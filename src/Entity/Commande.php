<?php

namespace App\Entity;

use App\Repository\CommandeRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CommandeRepository::class)]
class Commande
{
    const STATUT_EN_ATTENTE                  = 'en_attente';
    const STATUT_ACCEPTEE                    = 'acceptee';
    const STATUT_EN_PREPARATION              = 'en_preparation';
    const STATUT_EN_COURS_DE_LIVRAISON       = 'en_cours_de_livraison';
    const STATUT_LIVREE                      = 'livree';
    const STATUT_EN_ATTENTE_RETOUR_MATERIEL  = 'en_attente_retour_materiel';
    const STATUT_TERMINEE                    = 'terminee';

    public static function getStatuts(): array
    {
        return [
            'En attente'                  => self::STATUT_EN_ATTENTE,
            'Acceptée'                    => self::STATUT_ACCEPTEE,
            'En préparation'              => self::STATUT_EN_PREPARATION,
            'En cours de livraison'       => self::STATUT_EN_COURS_DE_LIVRAISON,
            'Livrée'                      => self::STATUT_LIVREE,
            'En attente retour matériel'  => self::STATUT_EN_ATTENTE_RETOUR_MATERIEL,
            'Terminée'                    => self::STATUT_TERMINEE,
        ];
    }

    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;


    #[ORM\Column (nullable: true)]
    private ?int $numero_commande = null;

    #[ORM\Column(type: Types::DATE_MUTABLE)]
    private ?\DateTime $date_commande = null;

    #[ORM\Column(type: Types::DATE_MUTABLE)]
    private ?\DateTime $date_livraison = null;

    #[ORM\Column(type: Types::TIME_MUTABLE, nullable: true)]
    private ?\DateTime $heure_livraison = null;

    #[ORM\Column(length: 255)]
    private ?string $adresse = null;

    #[ORM\Column]
    private ?float $prix_total = null;

    #[ORM\Column(length: 50)]
    private ?string $statut = null;

    #[ORM\Column]
    private ?int $nombre_personnes = null;

    /**
     * @var Collection<int, User>
     */
    #[ORM\ManyToOne(targetEntity: User::class, inversedBy: 'commandes')]
    private ?User $user = null;

    /**
     * @var Collection<int, Menu>
     */
    #[ORM\ManyToMany(targetEntity: Menu::class, inversedBy: 'commandes')]
    private Collection $menu;

    #[ORM\OneToOne(cascade: ['persist', 'remove'])]
    private ?Avis $avis = null;

    public function __construct()
    {
        $this->menu = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNumeroCommande(): ?int
    {
        return $this->numero_commande;
    }

    public function setNumeroCommande(int $numero_commande): static
    {
        $this->numero_commande = $numero_commande;

        return $this;
    }

    public function getDateCommande(): ?\DateTime
    {
        return $this->date_commande;
    }

    public function setDateCommande(\DateTime $date_commande): static
    {
        $this->date_commande = $date_commande;

        return $this;
    }

    public function getDateLivraison(): ?\DateTime
    {
        return $this->date_livraison;
    }

    public function setDateLivraison(\DateTime $date_livraison): static
    {
        $this->date_livraison = $date_livraison;

        return $this;
    }

    public function getHeureLivraison(): ?\DateTime
    {
        return $this->heure_livraison;
    }

    public function setHeureLivraison(?\DateTime $heure_livraison): static
    {
        $this->heure_livraison = $heure_livraison;

        return $this;
    }

    public function getAdresse(): ?string
    {
        return $this->adresse;
    }

    public function setAdresse(string $adresse): static
    {
        $this->adresse = $adresse;

        return $this;
    }

    public function getPrixTotal(): ?float
    {
        return $this->prix_total;
    }

    public function setPrixTotal(float $prix_total): static
    {
        $this->prix_total = $prix_total;

        return $this;
    }

    public function getStatut(): ?string
    {
        return $this->statut;
    }

    public function setStatut(string $statut): static
    {
        $this->statut = $statut;

        return $this;
    }

    public function getNombrePersonnes(): ?int
    {
        return $this->nombre_personnes;
    }

    public function setNombrePersonnes(int $nombre_personnes): static
    {
        $this->nombre_personnes = $nombre_personnes;
        return $this;
    }

    /**
     * @return Collection<int, User>
     */
    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): static
    {
        $this->user = $user;
        return $this;
    }

    /**
     * @return Collection<int, Menu>
     */
    public function getMenu(): Collection
    {
        return $this->menu;
    }

    public function addMenu(Menu $menu): static
    {
        if (!$this->menu->contains($menu)) {
            $this->menu->add($menu);
        }

        return $this;
    }

    public function removeMenu(Menu $menu): static
    {
        $this->menu->removeElement($menu);

        return $this;
    }

    public function getAvis(): ?Avis
    {
        return $this->avis;
    }

    public function setAvis(?Avis $avis): static
    {
        $this->avis = $avis;

        return $this;
    }
}
