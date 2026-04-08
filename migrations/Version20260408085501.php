<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260408085501 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('CREATE TABLE avis (id INT AUTO_INCREMENT NOT NULL, note INT NOT NULL, commentaire LONGTEXT CHARACTER SET utf8mb4 DEFAULT NULL COLLATE `utf8mb4_0900_ai_ci`, user_id INT DEFAULT NULL, statut VARCHAR(20) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, INDEX IDX_8F91ABF0A76ED395 (user_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_0900_ai_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('ALTER TABLE avis ADD CONSTRAINT `FK_8F91ABF0A76ED395` FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('CREATE TABLE commande (id INT AUTO_INCREMENT NOT NULL, numero_commande INT DEFAULT NULL, date_commande DATE NOT NULL, date_livraison DATE NOT NULL, heure_livraison TIME NOT NULL, adresse VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, prix_total DOUBLE PRECISION NOT NULL, statut VARCHAR(50) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, avis_id INT DEFAULT NULL, user_id INT DEFAULT NULL, nombre_personnes INT NOT NULL, UNIQUE INDEX UNIQ_6EEAA67D197E709F (avis_id), INDEX IDX_6EEAA67DA76ED395 (user_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_0900_ai_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('ALTER TABLE commande ADD CONSTRAINT `FK_6EEAA67D197E709F` FOREIGN KEY (avis_id) REFERENCES avis (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('ALTER TABLE commande ADD CONSTRAINT `FK_6EEAA67DA76ED395` FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('CREATE TABLE commande_menu (commande_id INT NOT NULL, menu_id INT NOT NULL, INDEX IDX_16693B7082EA2E54 (commande_id), INDEX IDX_16693B70CCD7E912 (menu_id), PRIMARY KEY (commande_id, menu_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_0900_ai_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('ALTER TABLE commande_menu ADD CONSTRAINT `FK_16693B7082EA2E54` FOREIGN KEY (commande_id) REFERENCES commande (id) ON UPDATE NO ACTION ON DELETE CASCADE');
        $this->addSql('ALTER TABLE commande_menu ADD CONSTRAINT `FK_16693B70CCD7E912` FOREIGN KEY (menu_id) REFERENCES menu (id) ON UPDATE NO ACTION ON DELETE CASCADE');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('CREATE TABLE menu (id INT AUTO_INCREMENT NOT NULL, titre VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, description LONGTEXT CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, prix DOUBLE PRECISION NOT NULL, min_personne INT NOT NULL, stock INT NOT NULL, theme VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, regime VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT NULL COLLATE `utf8mb4_0900_ai_ci`, PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_0900_ai_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('CREATE TABLE menu_plat (menu_id INT NOT NULL, plat_id INT NOT NULL, INDEX IDX_E8775249CCD7E912 (menu_id), INDEX IDX_E8775249D73DB560 (plat_id), PRIMARY KEY (menu_id, plat_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_0900_ai_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('ALTER TABLE menu_plat ADD CONSTRAINT `FK_E8775249CCD7E912` FOREIGN KEY (menu_id) REFERENCES menu (id) ON UPDATE NO ACTION ON DELETE CASCADE');
        $this->addSql('ALTER TABLE menu_plat ADD CONSTRAINT `FK_E8775249D73DB560` FOREIGN KEY (plat_id) REFERENCES plat (id) ON UPDATE NO ACTION ON DELETE CASCADE');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('CREATE TABLE messenger_messages (id BIGINT AUTO_INCREMENT NOT NULL, body LONGTEXT CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, headers LONGTEXT CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, queue_name VARCHAR(190) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, created_at DATETIME NOT NULL, available_at DATETIME NOT NULL, delivered_at DATETIME DEFAULT NULL, INDEX IDX_75EA56E0FB7336F0E3BD61CE16BA31DBBF396750 (queue_name, available_at, delivered_at, id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_0900_ai_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('CREATE TABLE plat (id INT AUTO_INCREMENT NOT NULL, nom VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, type VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, allergene VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT NULL COLLATE `utf8mb4_0900_ai_ci`, PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_0900_ai_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('CREATE TABLE user (id INT AUTO_INCREMENT NOT NULL, email VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, password VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, roles JSON NOT NULL, nom VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, prenom VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, adresse VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, ville VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, telephone VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_0900_ai_ci`, UNIQUE INDEX UNIQ_8D93D649E7927C74 (email), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_0900_ai_ci` ENGINE = InnoDB COMMENT = \'\' ');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('DROP TABLE `avis`');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('DROP TABLE `commande`');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('DROP TABLE `commande_menu`');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('DROP TABLE `menu`');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('DROP TABLE `menu_plat`');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('DROP TABLE `messenger_messages`');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('DROP TABLE `plat`');
        $this->abortIf(
            !$this->connection->getDatabasePlatform() instanceof \Doctrine\DBAL\Platforms\MySQL80Platform,
            "Migration can only be executed safely on '\Doctrine\DBAL\Platforms\MySQL80Platform'."
        );

        $this->addSql('DROP TABLE `user`');
    }
}
