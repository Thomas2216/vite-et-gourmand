<?php

namespace App\Controller;

use App\Form\EditProfileType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

final class IndexController extends AbstractController
{
    #[Route('/', name: 'app_accueil')]
    public function index(): Response
    {
        return $this->render('index/index.html.twig');
    }

    /** #[Route('/login', name: 'app_login')]
    public function login(): Response
    {
        return $this->render('index/login.html.twig');
    }
     *
     **/

    /**  #[Route('/create', name: 'app_create')]
    public function create(): Response
    {
        return $this->render('index/create.html.twig');
    }

    **/

//    #[Route('/menus', name: 'app_menus')]
//    public function menus(): Response
//    {
//        return $this->render('index/menus.html.twig');
//    }
//
//    #[Route('/menu-detail', name: 'app_menu_detail')]
//    public function menuDetail(): Response
//    {
//        return $this->render('index/menu-detail.html.twig');
//    }

    #[Route('/user', name: 'app_user')]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function user(): Response
    {
        return $this->render('index/user.html.twig');
    }

    #[Route('/user/edit', name: 'app_user_edit', methods: ['GET', 'POST'])]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function editProfile(Request $request, EntityManagerInterface $em, UserPasswordHasherInterface $passwordHasher): Response {

        $user = $this->getUser();

        $form = $this->createForm(EditProfileType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $plainPassword = $form->get('plainPassword')->getData();
            if ($plainPassword) {
                $user->setPassword($passwordHasher->hashPassword($user, $plainPassword));
            }

            $em->flush();
            $this->addFlash('success', 'Votre profil a bien été mis à jour.');

            return $this->redirectToRoute('app_user');
        }

        return $this->render('index/edit-profile.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    /**
    #[Route('/admin', name: 'app_admin')]
    #[IsGranted('ROLE_ADMIN')]
    public function admin(): Response
    {
        return $this->render('index/admin.html.twig');
    }
     **/


//    #[Route('/commande', name: 'app_commande')]
//    public function commande(): Response
//    {
//        return $this->render('index/commande.html.twig');
//    }

    #[Route('/contact', name: 'app_contact')]
    public function contact(): Response
    {
        return $this->render('index/contact.html.twig');
    }

    #[Route('/mentions-legales', name: 'app_mentions')]
    public function mentions(): Response
    {
        return $this->render('index/mentions-legales.html.twig');
    }
}
