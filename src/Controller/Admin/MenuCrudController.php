<?php

namespace App\Controller\Admin;

use App\Entity\Menu;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\MoneyField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;

class MenuCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Menu::class;
    }


    public function configureFields(string $pageName): iterable
    {
        return [
            TextField::new('titre', 'Titre du Menu'),
            TextEditorField::new('description'),
            MoneyField::new('prix', 'Prix')->setCurrency('EUR'),
            IntegerField::new('min_personne', 'Personnes minimum'),
            IntegerField::new('stock', 'Stock restant'),
            TextField::new('theme', 'Thème'),
            TextField::new('regime', 'Régime Alimentaire'),

        ];
    }

}
