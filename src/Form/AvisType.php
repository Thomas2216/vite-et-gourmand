<?php

namespace App\Form;

use App\Entity\Avis;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Validator\Constraints\Range;

class AvisType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('note', ChoiceType::class, [
                'label'   => 'Votre note',
                'choices' => [
                    '★★★★★  —  Excellent (5)' => 5,
                    '★★★★☆  —  Très bien (4)' => 4,
                    '★★★☆☆  —  Bien (3)'      => 3,
                    '★★☆☆☆  —  Passable (2)'  => 2,
                    '★☆☆☆☆  —  Décevant (1)'  => 1,
                ],
                'constraints' => [
                    new NotBlank(['message' => 'Veuillez sélectionner une note.']),
                    new Range(['min' => 1, 'max' => 5]),
                ],
            ])
            ->add('commentaire', TextareaType::class, [
                'label'    => 'Votre commentaire',
                'required' => false,
                'attr'     => ['rows' => 5, 'placeholder' => 'Partagez votre expérience...'],
            ])
            ->add('submit', SubmitType::class, [
                'label' => 'Envoyer mon avis',
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Avis::class,
        ]);
    }
}
