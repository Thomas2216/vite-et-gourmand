<?php

namespace App\Controller;

use App\Entity\Avis;
use App\Form\AvisType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

final class AvisController extends AbstractController
{
    #[Route('/avis/nouveau', name: 'app_avis_nouveau', methods: ['GET', 'POST'])]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function nouveau(Request $request, EntityManagerInterface $em): Response
    {
        $avis = new Avis();

        $form = $this->createForm(AvisType::class, $avis);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $user = $this->getUser();
            $avis->setUser($user);
            $avis->setStatut(Avis::STATUT_EN_ATTENTE);

            $em->persist($avis);
            $em->flush();

            $this->addFlash('success', 'Votre avis a bien été envoyé. Il sera publié après validation par notre équipe.');

            return $this->redirectToRoute('app_user');
        }

        return $this->render('index/avis-nouveau.html.twig', [
            'form' => $form->createView(),
        ]);
    }
}
