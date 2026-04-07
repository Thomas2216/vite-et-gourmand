<?php

namespace App\Repository;

use App\Entity\Avis;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Avis>
 */
class AvisRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Avis::class);
    }


    public function findValides(): array
    {
        return $this->createQueryBuilder('a')
            ->where('a.statut = :statut')
            ->setParameter('statut', Avis::STATUT_VALIDE)
            ->orderBy('a.id', 'DESC')
            ->getQuery()
            ->getResult();
    }
}
