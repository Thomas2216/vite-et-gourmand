<?php

namespace App\Controller;

use App\Entity\Commande;
use App\Entity\Menu;
use App\Form\CommandeType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request as HttpFoundationRequest;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

final class CommandeController extends AbstractController
{
    #[Route('/commande', name: 'app_commande', methods: ['GET', 'POST'])]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function commande(HttpFoundationRequest $request, EntityManagerInterface $em): Response
    {
        $commande = new Commande();
        $menus = $em->getRepository(Menu::class)->findAll();
        $form = $this->createForm(CommandeType::class, $commande);
        $form->handleRequest($request);

        $menuIdPreselect = $request->query->get('menuId');

        if ($form->isSubmitted() && $form->isValid()) {

            $nombrePersonnes = $commande->getNombrePersonnes();
            $fraisLivraison = $form->get('frais_livraison')->getData() ?? 0;

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
            $em->flush();

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
