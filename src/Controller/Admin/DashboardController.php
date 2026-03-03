<?php

namespace App\Controller\Admin;

use EasyCorp\Bundle\EasyAdminBundle\Attribute\AdminDashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;
use Symfony\Component\HttpFoundation\Response;
use EasyCorp\Bundle\EasyAdminBundle\Config\Assets;

use App\Entity\User;
use App\Entity\Menu;
use App\Entity\Commande;
use App\Entity\Plat;

#[AdminDashboard(routePath: '/admin', routeName: 'admin')]
class DashboardController extends AbstractDashboardController
{
    public function index(): Response
    {
        return $this->redirectToRoute('admin_user_index');
    }

    public function configureDashboard(): Dashboard
    {
        return Dashboard::new()
            ->setTitle('Vite Gourmand')

            ->setLocales(['fr']);
    }

    public function configureMenuItems(): iterable
    {
        yield MenuItem::linkToDashboard('Tableau de Bord', 'fa fa-table');
        yield MenuItem::linkToCrud('Utilisateurs', 'fas fa-user', User::class);
        yield MenuItem::linkToCrud('Menus', 'fas fa-list', Menu::class);
        yield MenuItem::linkToCrud('Commandes', 'fas fa-eur', Commande::class);
        yield MenuItem::linkToCrud('Plats', 'fas fa-cutlery', Plat::class);
        yield MenuItem::linkToRoute('Retour à Vite & Gourmand', 'fa fa-home', 'app_accueil');
        yield MenuItem::linkToLogout('Déconnexion', 'fas fa-sign-out-alt');
    }

    public function configureAssets(): Assets
    {
        return Assets::new()->addCssFile('assets/styles/admin.css');
    }
}
