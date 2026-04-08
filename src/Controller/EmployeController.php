<?php

namespace App\Controller;

use App\Entity\Commande;
use App\Repository\CommandeRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/employe')]
#[IsGranted('ROLE_EMPLOYE')]
final class EmployeController extends AbstractController
{
    #[Route('', name: 'app_employe', methods: ['GET'])]
    public function index(CommandeRepository $commandeRepository): Response
    {
        $commandes = $commandeRepository->findAllOrderedByDate();

        return $this->render('employe/index.html.twig', [
            'commandes' => $commandes,
            'statuts'   => Commande::getStatuts(),
        ]);
    }

    #[Route('/commande/{id}/statut', name: 'app_employe_statut', methods: ['POST'])]
    public function updateStatut(
        Commande $commande,
        Request $request,
        EntityManagerInterface $em
    ): Response {
        $nouveauStatut = $request->request->get('statut');

        if (!in_array($nouveauStatut, Commande::getStatuts(), true)) {
            $this->addFlash('error', 'Statut invalide.');
            return $this->redirectToRoute('app_employe');
        }

        $commande->setStatut($nouveauStatut);
        $em->flush();

        $this->addFlash('success', sprintf(
            'Commande n°%s mise à jour : %s.',
            $commande->getNumeroCommande() ?? $commande->getId(),
            array_search($nouveauStatut, Commande::getStatuts())
        ));

        return $this->redirectToRoute('app_employe');
    }
}
