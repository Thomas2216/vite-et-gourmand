<?php

namespace App\Controller;

use App\Entity\Commande;
use App\Entity\Menu;
use App\Form\CommandeType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request as HttpFoundationRequest;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Address;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

final class CommandeController extends AbstractController
{
    #[Route('/commande', name: 'app_commande', methods: ['GET', 'POST'])]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function commande(HttpFoundationRequest $request, EntityManagerInterface $em, MailerInterface $mailer): Response
    {
        $commande = new Commande();
        $menus = $em->getRepository(Menu::class)->findAll();
        $form = $this->createForm(CommandeType::class, $commande);
        $form->handleRequest($request);

        $menuIdPreselect = $request->query->get('menuId');

        if ($form->isSubmitted() && $form->isValid()) {

            if ($commande->getDateLivraison() < new \DateTime('today')) {
                $this->addFlash('error', 'La date de livraison doit être au moins aujourd\'hui.');
                return $this->render('index/commande.html.twig', [
                    'controller_name' => 'CommandeController',
                    'form'            => $form->createView(),
                    'menus'           => $menus,
                    'menuIdPreselect' => $menuIdPreselect,
                    'ors_key'         => $_ENV['ORS_API_KEY'],
                ]);
            }

            $nombrePersonnes = $commande->getNombrePersonnes();

            foreach ($commande->getMenu() as $menuItem) {
                if ($nombrePersonnes < $menuItem->getMinPersonne()) {
                    $this->addFlash('error', sprintf(
                        'Le nombre de personnes est insuffisant pour le menu %s (minimum %d personnes).',
                        $menuItem->getTitre(),
                        $menuItem->getMinPersonne()
                    ));
                    return $this->render('index/commande.html.twig', [
                        'controller_name' => 'CommandeController',
                        'form'            => $form->createView(),
                        'menus'           => $menus,
                        'menuIdPreselect' => $menuIdPreselect,
                        'ors_key'         => $_ENV['ORS_API_KEY'],
                    ]);
                }
            }

            foreach ($commande->getMenu() as $menuItem) {
                if ($menuItem->getStock() < $nombrePersonnes) {
                    $this->addFlash('error', sprintf(
                        'Le menu %s n\'a plus assez de stock disponible.',
                        $menuItem->getTitre()
                    ));
                    return $this->render('index/commande.html.twig', [
                        'controller_name' => 'CommandeController',
                        'form'            => $form->createView(),
                        'menus'           => $menus,
                        'menuIdPreselect' => $menuIdPreselect,
                        'ors_key'         => $_ENV['ORS_API_KEY'],
                    ]);
                }
            }

            $fraisLivraison = (float) ($form->get('frais_livraison')->getData() ?? 0);

            $total = 0;
            foreach ($commande->getMenu() as $menu) {
                $total += $menu->getPrix() * $nombrePersonnes;

                // Réduction 10%
                if ($nombrePersonnes >= $menu->getMinPersonne() + 5) {
                    $total = $total * 0.90;
                }
            }

            $total += $fraisLivraison;

            $commande->setPrixTotal($total);
            $commande->setUser($this->getUser());
            $commande->setDateCommande(new \DateTime());
            $commande->setStatut(Commande::STATUT_EN_ATTENTE);

            $em->persist($commande);
            $em->flush();

            $commande->setNumeroCommande($commande->getId());

            foreach ($commande->getMenu() as $menuItem) {
                $menuItem->setStock($menuItem->getStock() - $nombrePersonnes);
            }

            $em->flush();

            $user = $this->getUser();
            $mailer->send(
                (new TemplatedEmail())
                    ->from(new Address('no-reply@viteetgourmand.fr', 'Vite & Gourmand'))
                    ->to($user->getEmail())
                    ->subject('Confirmation de votre commande n°' . $commande->getNumeroCommande())
                    ->htmlTemplate('emails/commande.html.twig')
                    ->context([
                        'commande' => $commande,
                        'user'     => $user,
                    ])
            );

            $this->addFlash('success', 'Votre commande n°' . $commande->getNumeroCommande() . ' a bien été enregistrée !');

            return $this->redirectToRoute('app_user');
        }

        return $this->render('index/commande.html.twig', [
            'controller_name' => 'CommandeController',
            'form'            => $form->createView(),
            'menus'           => $menus,
            'menuIdPreselect' => $menuIdPreselect,
            'ors_key'         => $_ENV['ORS_API_KEY'],
        ]);
    }

    #[Route('/add_menu', name: 'add_menu', methods: ['GET', 'POST'])]
    public function addItem(HttpFoundationRequest $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $menuId = $data['menuId'] ?? null;

        $session = $request->getSession();
        $panier = $session->get('panier', []);

        $action = $data['action'] ?? 'add';
        $nombrePersonnes = $data['nombrePersonnes'] ?? 1;

        if ($action == 'add') {
            if (isset($panier[$menuId])) {
                $panier[$menuId] = $nombrePersonnes;
            } else {
                $panier[$menuId] = $nombrePersonnes;
            }
        } elseif ($action == 'remove') {
            if (isset($panier[$menuId])) {
                $panier[$menuId]--;
                if ($panier[$menuId] <= 0) {
                    unset($panier[$menuId]);
                }
            }
        }

        $session->set('panier', $panier);

        $totalItems = 0;
        $totalPrix = 0;
        $detailPanier = [];

        foreach ($panier as $menuId => $quantite) {
            $menu = $em->getRepository(Menu::class)->find($menuId);
            if ($menu) {
                $sousTotalMenu = $menu->getPrix() * $quantite;

                $totalItems += $quantite;
                $totalPrix  += $sousTotalMenu;

                $detailPanier[] = [
                    'menuId'    => $menuId,
                    'quantite'  => $quantite,
                    'titre'     => $menu->getTitre(),
                    'prix'      => $menu->getPrixFormate(),
                    'sousTotal' => $sousTotalMenu / 100,
                    'minPersonne' => $menu->getMinPersonne(),
                ];
            }
        }

        $totalPrix = $totalPrix / 100;

        return $this->json([
            'totalItems'   => $totalItems,
            'totalPrix'    => $totalPrix,
            'detailPanier' => $detailPanier,
            'action'       => $action,
        ]);
    }
}
