INSERT INTO user (id, email, password, roles, nom, prenom, adresse, ville, telephone) VALUES
-- ADMIN
(1, 'admin@demo.fr', '$2y$13$abcdefghijklmnopqrstuv', '["ROLE_ADMIN"]', 'Admin', 'Super', '1 rue Admin', 'Paris', '0600000001'),

-- EMPLOYES
(2, 'employe1@demo.fr', '$2y$13$abcdefghijklmnopqrstuv', '["ROLE_EMPLOYE"]', 'Martin', 'Julie', '2 rue Travail', 'Lyon', '0600000002'),
(3, 'employe2@demo.fr', '$2y$13$abcdefghijklmnopqrstuv', '["ROLE_EMPLOYE"]', 'Bernard', 'Lucas', '3 rue Travail', 'Marseille', '0600000003'),

-- USERS
(4, 'user1@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Durand', 'Emma', '4 rue A', 'Paris', '0600000004'),
(5, 'user2@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Petit', 'Louis', '5 rue B', 'Lyon', '0600000005'),
(6, 'user3@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Robert', 'Chloe', '6 rue C', 'Nice', '0600000006'),
(7, 'user4@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Richard', 'Hugo', '7 rue D', 'Bordeaux', '0600000007'),
(8, 'user5@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Moreau', 'Lea', '8 rue E', 'Lille', '0600000008'),
(9, 'user6@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Simon', 'Nathan', '9 rue F', 'Toulouse', '0600000009'),
(10, 'user7@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Laurent', 'Manon', '10 rue G', 'Nantes', '0600000010'),
(11, 'user8@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Michel', 'Enzo', '11 rue H', 'Strasbourg', '0600000011'),
(12, 'user9@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Garcia', 'Camille', '12 rue I', 'Rennes', '0600000012'),
(13, 'user10@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'David', 'Theo', '13 rue J', 'Reims', '0600000013'),
(14, 'user11@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Bertrand', 'Sarah', '14 rue K', 'Dijon', '0600000014'),
(15, 'user12@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Roux', 'Tom', '15 rue L', 'Angers', '0600000015'),
(16, 'user13@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Vincent', 'Eva', '16 rue M', 'Grenoble', '0600000016'),
(17, 'user14@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Fournier', 'Noah', '17 rue N', 'Limoges', '0600000017'),
(18, 'user15@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Morel', 'Jade', '18 rue O', 'Metz', '0600000018'),
(19, 'user16@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Girard', 'Lina', '19 rue P', 'Amiens', '0600000019'),
(20, 'user17@demo.fr', 'Demo1234!', '["ROLE_USER"]', 'Andre', 'Milo', '20 rue Q', 'Caen', '0600000020');



INSERT INTO plat (id, nom, type, allergene) VALUES
(1, 'Salade César', 'Entrée', 'Oeufs'),
(2, 'Soupe de légumes', 'Entrée', NULL),
(3, 'Bruschetta', 'Entrée', 'Gluten'),
(4, 'Poulet rôti', 'Plat principal', NULL),
(5, 'Saumon grillé', 'Plat principal', 'Poisson'),
(6, 'Steak frites', 'Plat principal', NULL),
(7, 'Lasagnes', 'Plat principal', 'Gluten'),
(8, 'Risotto champignons', 'Plat principal', NULL),
(9, 'Tiramisu', 'Dessert', 'Oeufs'),
(10, 'Mousse au chocolat', 'Dessert', NULL),
(11, 'Tarte aux pommes', 'Dessert', 'Gluten'),
(12, 'Salade de fruits', 'Dessert', NULL);



INSERT INTO menu (id, titre, description, prix, min_personne, stock, theme, regime) VALUES
(1, 'Menu Italien', 'Spécialités italiennes', 25.90, 2, 50, 'Italien', NULL),
(2, 'Menu Healthy', 'Repas équilibré et léger', 22.50, 1, 40, 'Healthy', 'Végétarien'),
(3, 'Menu Gourmet', 'Cuisine raffinée', 35.00, 2, 30, 'Gastronomique', NULL),
(4, 'Menu Famille', 'Idéal pour toute la famille', 19.90, 4, 60, 'Familial', NULL),
(5, 'Menu Express', 'Rapide et efficace', 15.00, 1, 100, 'Rapide', NULL);



INSERT INTO menu_plat (menu_id, plat_id) VALUES
-- Menu Italien
(1, 3), (1, 7), (1, 9),

-- Menu Healthy
(2, 2), (2, 8), (2, 12),

-- Menu Gourmet
(3, 1), (3, 5), (3, 10),

-- Menu Famille
(4, 4), (4, 6), (4, 11),

-- Menu Express
(5, 2), (5, 4), (5, 10);
