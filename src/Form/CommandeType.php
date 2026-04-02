<?php

namespace App\Form;

use App\Entity\Commande;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class CommandeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('date_livraison')
            ->add('heure_livraison')
            ->add('adresse')
            ->add('nombre_personnes', IntegerType::class, [
                'label' => 'Nombre de personnes',
                'attr'  => [
                    'min' => 1,
                    'id'  => 'nombre-personnes'
                ]
            ])
            ->add('frais_livraison', HiddenType::class, [
                'mapped' => false,
                'attr'   => ['id' => 'frais-livraison-input']
            ])
            ->add('submit', SubmitType::class, [
                'label' => 'Valider la commande'
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Commande::class,
        ]);
    }
}
