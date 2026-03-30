<?php

namespace App\Form;

use App\Entity\Avis;
use App\Entity\Commande;
use App\Entity\Menu;
use App\Entity\User;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\MoneyType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class CommandeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('menu', EntityType::class, [
                'class' => Menu::class,
                'choice_label' => 'titre',
                'multiple' => true,
            ])
            ->add('date_livraison')
            ->add('heure_livraison')
            ->add('adresse');
//            ->add('prix_total', MoneyType::class, ['disabled' => true]);
//            ->add('submit', SubmitType::class, [
//                'attr' => ['id' => 'btn-add'],
//                'label' => 'Ajouter à la commande']);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Commande::class,
        ]);
    }
}
