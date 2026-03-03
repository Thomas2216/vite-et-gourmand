<?php

namespace App\Controller;

use App\Entity\Menu;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class MenuController extends AbstractController
{
    #[Route('/menus', name: 'app_menus', methods: ['GET'])]
    public function index(EntityManagerInterface $em): Response
    {
        $menus = $em->getRepository(Menu::class)->findAll();
        return $this->render('index/menus.html.twig', [
            'menus' => $menus,
        ]);
    }
}
