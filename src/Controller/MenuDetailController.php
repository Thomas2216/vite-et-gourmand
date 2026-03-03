<?php

namespace App\Controller;

use App\Entity\Menu;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class MenuDetailController extends AbstractController
{
    #[Route('/menu/{id}', name: 'app_menu_detail')]
    public function show(Menu $menu): Response
    {
        return $this->render('index/menu-detail.html.twig', [
            'menu' => $menu,
        ]);
    }
}
