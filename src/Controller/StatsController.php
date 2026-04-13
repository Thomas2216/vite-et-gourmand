<?php

namespace App\Controller;

use App\Document\CommandeStat;
use Doctrine\ODM\MongoDB\DocumentManager;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/stats')]
#[IsGranted('ROLE_ADMIN')]
final class StatsController extends AbstractController
{
    #[Route('', name: 'app_stats', methods: ['GET'])]
    public function index(DocumentManager $dm): Response
    {
        $stats = $dm->getRepository(CommandeStat::class)->findAll();

        $statsByMenu = [];
        foreach ($stats as $stat) {
            $titre = $stat->getMenuTitre();
            if (!isset($statsByMenu[$titre])) {
                $statsByMenu[$titre] = [
                    'titre'            => $titre,
                    'total_commandes'  => 0,
                    'chiffre_affaires' => 0,
                ];
            }
            $statsByMenu[$titre]['total_commandes']++;
            $statsByMenu[$titre]['chiffre_affaires'] += $stat->getPrixTotal();
        }

        return $this->render('stats/index.html.twig', [
            'statsByMenu' => $statsByMenu,
        ]);
    }
}
