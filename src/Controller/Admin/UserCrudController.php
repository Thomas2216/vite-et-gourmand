<?php

namespace App\Controller\Admin;

use App\Entity\User;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\ArrayField;
use EasyCorp\Bundle\EasyAdminBundle\Field\EmailField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TelephoneField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;

class UserCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return User::class;
    }


    public function configureFields(string $pageName): iterable
    {
        return [
            Emailfield::new('email'),
            TextField::new('password', 'Mot de passe'),
            TextField::new('nom'),
            TextField::new('prenom', 'Prénom'),
            TextField::new('adresse', 'Adresse postale'),
            TextField::new('ville'),
            TelephoneField::new('telephone', 'Téléphone'),
            ArrayField::new('roles', 'Role')->setPermission('ROLE_ADMIN'),

        ];
    }

}
