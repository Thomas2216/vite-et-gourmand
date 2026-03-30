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

        if ($form->isSubmitted() && $form->isValid()) {

            $total = 0;
            foreach ($commande->getMenu() as $menu) {
                $total += $menu->getPrix();
            }

            $commande->setPrixTotal($total);
            $commande->setUser($this->getUser());
            $commande->setDateCommande(new \DateTime());
            $commande->setStatut('en attente');

            $em->persist($commande);
            $em->flush();

            $commande->setNumeroCommande($commande->getId());
            $em->flush();

            return $this->redirectToRoute('app_commande');
        }
        return $this->render('index/commande.html.twig', [
            'controller_name' => 'CommandeController',
            'form' => $form->createView(),
            'menus' => $menus,
        ]);
    }

    #[Route('/add_menu', name: 'add_menu', methods: ['GET', 'POST'])]
    public function addItem(HttpFoundationRequest $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $itemId = $data['itemId'] ?? null;

        $session = $request->getSession();
        $panier = $session->get('panier', []);

        $action = $data['action'] ?? 'add';

        if ($action == 'add') {
            if (isset($panier[$itemId])) {
                $panier[$itemId]++;
            }
            else {
                $panier[$itemId] = 1;
            }
        }
        elseif ($action == 'remove') {
            if (isset($panier[$itemId])) {
                $panier[$itemId]--;
                if ($panier[$itemId] <= 0) {
                    unset($panier[$itemId]);
                }
            }
        }

        $session->set('panier', $panier);

        $totalItems =0;
        $totalPrix = 0;

        foreach ($panier as $menuId => $quantite) {
            $menu = $em->getRepository(Menu::class)->find($menuId);

            $totalItems += $quantite;
            $totalPrix += $menu->getPrix() * $quantite;

        }

        return $this->json([
            'totalItems' => $totalItems,
            'totalPrix' => $totalPrix,
            'action' => $action,
        ]);
    }

}
