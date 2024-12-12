/*
* TP3_INF3080_A24_UQAM
* Description: Insertion dans les tables en tenant compte des nouvelles modificatins 
* de la structure des tables 02-insert.sql
* @author MARIUS GUIMATSIA AKALONG(GUIM27309006)
* @author MARIUS GUIMATSIA AKALONG(GUIM27309006)
*
*/
-- Table Client
INSERT INTO Client VALUES (1, 'Entreprise ABC', 123, 'Rue Principale', 'Montreal', 'H3Z2Y7', 'Jean Dupuis', '514-123-4567', 'contact@entrepriseabc.com');
INSERT INTO Client VALUES (2, 'Construction XYZ', 456, 'Avenue Centrale', 'Quebec', 'G1R5H2', 'Marie Tremblay', '418-987-6543', 'info@constructionxyz.com');
INSERT INTO Client VALUES (3, 'Developpement DEF', 789, 'Boulevard Industriel', 'Laval', 'H7M3J8', 'Paul Lavoie', '450-321-9876', 'contact@developpementdef.com');
INSERT INTO Client VALUES (4, 'Infrastructures GHI', 101, 'Chemin du Parc', 'Sherbrooke', 'J1G2V5', 'Alice Moreau', '819-456-7890', 'contact@infrastructuresghi.com');
INSERT INTO Client VALUES (5, 'Batiments JKL', 234, 'Route des Laurentides', 'Trois-Rivières', 'G8Y4N3', 'Sophie Martin', '819-123-6543', 'info@batimentsjkl.com');
INSERT INTO Client VALUES (6, 'Ingenierie MNO', 567, 'Rue du Sud', 'Saguenay', 'G7H5P2', 'Lucas Bernard', '418-654-7890', 'contact@ingenieriemno.com');
INSERT INTO Client VALUES (7, 'Solutions PQR', 890, 'Avenue Verte', 'Gatineau', 'J8X4K7', 'Julie Lefevre', '819-789-6543', 'contact@solutionspqr.com');
INSERT INTO Client VALUES (8, 'Groupes STU', 112, 'Place du Commerce', 'Longueuil', 'J4K5B6', 'Thomas Petit', '450-789-1234', 'info@groupestu.com');
INSERT INTO Client VALUES (9, 'Terrains VWX', 334, 'Allée des Constructions', 'Drummondville', 'J2C3V8', 'Claire Gagnon', '819-321-4567', 'contact@terrainsvwx.com');
INSERT INTO Client VALUES (10, 'Innovations YZA', 556, 'Boulevard des Amériques', 'Montreal', 'H3K1T3', 'Pierre Simon', '514-789-6543', 'info@innovationsyza.com');

-- Table Projet
INSERT INTO Projet VALUES (1, 'Projet Nepturne', DATE '2024-01-15', DATE '2024-12-15', 5000000.00);
INSERT INTO Projet VALUES (2, 'Réhabilitation Route XYZ', DATE '2024-03-01', DATE '2024-10-01', 2000000.00);
INSERT INTO Projet VALUES (3, 'Aménagement Parc Urbain', DATE '2024-05-15', DATE '2025-03-15', 1500000.00);
INSERT INTO Projet VALUES (4, 'Construction Barrage DEF', DATE '2024-06-01', DATE '2025-06-01', 10000000.00);
INSERT INTO Projet VALUES (5, 'Tunnel de Montagne', DATE '2024-08-01', DATE '2025-12-31', 8000000.00);
INSERT INTO Projet VALUES (6, 'Amélioration Infrastructure Portuaire', DATE '2024-04-15', DATE '2025-01-15', 3000000.00);
INSERT INTO Projet VALUES (7, 'Extension de l’Aéroport GHI', DATE '2024-07-01', DATE '2026-07-01', 12000000.00);
INSERT INTO Projet VALUES (8, 'Construction de Résidences Étudiantes', DATE '2024-09-01', DATE '2025-05-01', 2500000.00);
INSERT INTO Projet VALUES (9, 'Renforcement des Digues', DATE '2024-10-01', DATE '2025-08-01', 5000000.00);
INSERT INTO Projet VALUES (10, 'Complexe Industriel JKL', DATE '2024-11-01', DATE '2026-01-01', 9500000.00);
INSERT INTO Projet VALUES (123, 'Travaux Publics - Route A20', DATE '2024-11-01', DATE '2025-03-31', 500000.00);


-- Table Projet_client
INSERT INTO Projet_client VALUES (1, 1);
INSERT INTO Projet_client VALUES (2, 2);
INSERT INTO Projet_client VALUES (3, 3);
INSERT INTO Projet_client VALUES (4, 4);
INSERT INTO Projet_client VALUES (5, 5);
INSERT INTO Projet_client VALUES (6, 6);
INSERT INTO Projet_client VALUES (7, 7);
INSERT INTO Projet_client VALUES (8, 8);
INSERT INTO Projet_client VALUES (9, 9);
INSERT INTO Projet_client VALUES (10, 10);
INSERT INTO Projet_client VALUES (10, 123);

-- Table Projet_phase
INSERT INTO Projet_phase VALUES (1, 1, 'Étude de faisabilité', DATE '2024-01-15', DATE '2024-02-15', 500000.00,0);
INSERT INTO Projet_phase VALUES (1, 2, 'Conception des structures', DATE '2024-02-16', DATE '2024-05-01', 1500000.00,0);
INSERT INTO Projet_phase VALUES (1, 3, 'Construction', DATE '2024-05-02', DATE '2024-12-15', 3000000.00,0);
INSERT INTO Projet_phase VALUES (2, 1, 'Étude préliminaire', DATE '2024-03-01', DATE '2024-03-31', 200000.00,0);
INSERT INTO Projet_phase VALUES (2, 2, 'Préparation du site', DATE '2024-04-01', DATE '2024-05-01', 400000.00,0);
INSERT INTO Projet_phase VALUES (2, 3, 'Travaux de réhabilitation', DATE '2024-05-02', DATE '2024-10-01', 1400000.00,0);
INSERT INTO Projet_phase VALUES (3, 1, 'Évaluation environnementale', DATE '2024-05-15', DATE '2024-06-15', 250000.00,0);
INSERT INTO Projet_phase VALUES (3, 2, 'Conception du plan d’aménagement', DATE '2024-06-16', DATE '2024-08-01', 500000.00,0);
INSERT INTO Projet_phase VALUES (3, 3, 'Construction des infrastructures', DATE '2024-08-02', DATE '2025-03-15', 750000.00,0);
INSERT INTO Projet_phase VALUES (4, 1, 'Étude géologique', DATE '2024-06-01', DATE '2024-07-15', 300000.00,0);
INSERT INTO Projet_phase VALUES (4, 2, 'Conception hydraulique', DATE '2024-07-16', DATE '2024-10-01', 1200000.00,0);
INSERT INTO Projet_phase VALUES (4, 3, 'Construction du barrage', DATE '2024-10-02', DATE '2025-06-01', 8500000.00,0);
INSERT INTO Projet_phase VALUES (5, 1, 'Étude de terrain', DATE '2024-08-01', DATE '2024-09-01', 600000.00,0);
INSERT INTO Projet_phase VALUES (5, 2, 'Excavation du tunnel', DATE '2024-09-02', DATE '2025-01-01', 2000000.00,0);
INSERT INTO Projet_phase VALUES (5, 3, 'Revêtement et sécurisation', DATE '2025-01-02', DATE '2025-12-31', 5400000.00,0);
INSERT INTO Projet_phase VALUES (6, 1, 'Étude de site portuaire', DATE '2024-04-15', DATE '2024-05-15', 300000.00,0);
INSERT INTO Projet_phase VALUES (6, 2, 'Renforcement des quais', DATE '2024-05-16', DATE '2024-08-01', 1200000.00,0);
INSERT INTO Projet_phase VALUES (6, 3, 'Amélioration des infrastructures', DATE '2024-08-02', DATE '2025-01-15', 1500000.00,0);
INSERT INTO Projet_phase VALUES (7, 1, 'Planification et design', DATE '2024-07-01', DATE '2024-09-01', 1500000.00,0);
INSERT INTO Projet_phase VALUES (7, 2, 'Extension des pistes', DATE '2024-09-02', DATE '2025-05-01', 3000000.00,0);
INSERT INTO Projet_phase VALUES (7, 3, 'Construction du terminal', DATE '2025-05-02', DATE '2026-07-01', 7500000.00,0);
INSERT INTO Projet_phase VALUES (8, 1, 'Planification des logements', DATE '2024-09-01', DATE '2024-10-01', 250000.00,0);
INSERT INTO Projet_phase VALUES (8, 2, 'Construction des fondations', DATE '2024-10-02', DATE '2025-01-01', 1000000.00,0);
INSERT INTO Projet_phase VALUES (8, 3, 'Équipements et finitions', DATE '2025-01-02', DATE '2025-05-01', 1250000.00,0);
INSERT INTO Projet_phase VALUES (9, 1, 'Étude d’impact hydrologique', DATE '2024-10-01', DATE '2024-11-01', 400000.00,0);
INSERT INTO Projet_phase VALUES (9, 2, 'Renforcement des digues', DATE '2024-11-02', DATE '2025-04-01', 2500000.00,0);
INSERT INTO Projet_phase VALUES (9, 3, 'Mise en place de systèmes de drainage', DATE '2025-04-02', DATE '2025-08-01', 2100000.00,0);
INSERT INTO Projet_phase VALUES (10, 1, 'Planification du complexe', DATE '2024-11-01', DATE '2025-01-01', 1500000.00,0);
INSERT INTO Projet_phase VALUES (10, 2, 'Construction des bâtiments industriels', DATE '2025-01-02', DATE '2025-09-01', 5000000.00,0);
INSERT INTO Projet_phase VALUES (10, 3, 'Mise en service et inspection', DATE '2025-09-02', DATE '2026-01-01', 3000000.00,0);
INSERT INTO Projet_phase VALUES (123, 1, 'Étude Préliminaire', DATE '2024-11-01', DATE '2024-11-30', 50000.00,0);
INSERT INTO Projet_phase VALUES (123, 2, 'Travaux de Construction', DATE '2024-12-01', DATE '2025-02-28', 400000.00,0);
INSERT INTO Projet_phase VALUES (123, 3, 'Inspection Finale',DATE '2025-03-01',DATE '2025-03-31',50000.00,0);


-- Table Specialite
INSERT INTO Specialite VALUES (1, 'Designers');
INSERT INTO Specialite VALUES (2, 'Technicien Architecte');
INSERT INTO Specialite VALUES (3, 'Gestion de Projets de Construction');
INSERT INTO Specialite VALUES (4, 'Génie Géotechnique');
INSERT INTO Specialite VALUES (5, 'Gestion de la Qualité');
INSERT INTO Specialite VALUES (6, 'Sécurité et Gestion des Risques');
INSERT INTO Specialite VALUES (7, 'Génie Hydraulique');
INSERT INTO Specialite VALUES (8, 'Planification Urbaine');
INSERT INTO Specialite VALUES (9, 'Ingénierie des Matériaux');
INSERT INTO Specialite VALUES (10, 'Conception de Routes et Autoroutes');

-- Table Departement
INSERT INTO Departement VALUES (1, 'Conception et Ingénierie');
INSERT INTO Departement VALUES (2, 'Géotechnique');
INSERT INTO Departement VALUES (3, 'Gestion de Construction');
INSERT INTO Departement VALUES (4, 'Gestion de la Qualité et de la Sécurité');
INSERT INTO Departement VALUES (5, 'Hydraulique et Environnement');
INSERT INTO Departement VALUES (6, 'Planification et Urbanisme');
INSERT INTO Departement VALUES (7, 'Infrastructure Routière et Ferroviaire');
INSERT INTO Departement VALUES (8, 'Infrastructure Portuaire et Maritime');
INSERT INTO Departement VALUES (9, 'Études et Matériaux');
INSERT INTO Departement VALUES (10, 'Gestion des Ressources et Logistique');

-- Table Type_emploie
INSERT INTO Type_emploie VALUES (1, 'Permanent');
INSERT INTO Type_emploie VALUES (2, 'Temporaire');
INSERT INTO Type_emploie VALUES (3, 'Contrat');
INSERT INTO Type_emploie VALUES (4, 'Consultant');
INSERT INTO Type_emploie VALUES (5, 'Stagiaire');
INSERT INTO Type_emploie VALUES (6, 'Temps Partiel');
INSERT INTO Type_emploie VALUES (7, 'Freelance');
INSERT INTO Type_emploie VALUES (8, 'CDD');
INSERT INTO Type_emploie VALUES (9, 'Indépendant');
INSERT INTO Type_emploie VALUES (10, 'CDD Longue Durée');

-- Table Employe
INSERT INTO Employe VALUES (1, 'Martin', 'Jean',1, 1, 1,9.99,NULL);
INSERT INTO Employe VALUES (2, 'Debay', 'Georges', 2, 2, 1,5.62,NULL);
INSERT INTO Employe VALUES (3, 'Durand', 'Paul', 3, 3, 4,8.20,NULL);
INSERT INTO Employe VALUES (4, 'Bernard', 'Alice', 4, 4, 1,9.81,NULL);
INSERT INTO Employe VALUES (5, 'Petit', 'Sophie', 5, 5, 2,3.20,NULL);
INSERT INTO Employe VALUES (6, 'Robert', 'Lucas', 6, 6, 3,7.32,NULL);
INSERT INTO Employe VALUES (7, 'Tremblay', 'Natasha', 1, 1, 1,8.80,NULL);
INSERT INTO Employe VALUES (8, 'Moreau', 'Thomas', 8, 8, 1,5.20,NULL);
INSERT INTO Employe VALUES (9, 'Simon', 'Claire', 9, 9, 2,6.30,NULL);
INSERT INTO Employe VALUES (10, 'Gagnon', 'Pierre', 10, 10, 1,9.50,NULL);

-- Table Accident_travail
INSERT INTO Accident_travail VALUES (1, 1, TIMESTAMP '2024-04-01 09:30:00', 'Entorse à la cheville lors de la préparation du site');
INSERT INTO Accident_travail VALUES (1, 2, TIMESTAMP '2024-06-15 14:00:00', 'Coupure mineure lors de la manipulation d’outils');
INSERT INTO Accident_travail VALUES (2, 3, TIMESTAMP '2024-05-10 08:45:00', 'Chute de hauteur lors de la réhabilitation');
INSERT INTO Accident_travail VALUES (2, 4, TIMESTAMP '2024-07-20 13:30:00', 'Brûlure due à une machine de découpe');
INSERT INTO Accident_travail VALUES (3, 5, TIMESTAMP '2024-06-20 10:00:00', 'Inhalation de poussière sur le chantier');
INSERT INTO Accident_travail VALUES (3, 6, TIMESTAMP '2024-09-01 15:30:00', 'Égratignure causée par un outil de construction');
INSERT INTO Accident_travail VALUES (4, 7, TIMESTAMP '2024-07-10 11:00:00', 'Blessure au poignet lors de la manipulation d’équipement lourd');
INSERT INTO Accident_travail VALUES (4, 8, TIMESTAMP '2024-12-15 09:30:00', 'Choc électrique mineur pendant les travaux');
INSERT INTO Accident_travail VALUES (5, 9, TIMESTAMP '2024-08-10 08:00:00', 'Contusion due à une chute de matériaux');
INSERT INTO Accident_travail VALUES (5, 10, TIMESTAMP '2025-02-20 16:30:00', 'Torsion du genou en sortant d’un tunnel');
INSERT INTO Accident_travail VALUES (6, 1, TIMESTAMP '2024-05-15 12:00:00', 'Coupure avec un morceau de métal rouillé');
INSERT INTO Accident_travail VALUES (6, 2, TIMESTAMP '2024-09-05 10:45:00', 'Choc contre un conteneur');
INSERT INTO Accident_travail VALUES (7, 3, TIMESTAMP '2024-10-02 14:00:00', 'Inhalation de fumées d’échappement');
INSERT INTO Accident_travail VALUES (7, 4, TIMESTAMP '2025-04-15 11:30:00', 'Écrasement de doigt lors de la pose de panneaux');
INSERT INTO Accident_travail VALUES (8, 5, TIMESTAMP '2024-11-15 15:15:00', 'Chute en transportant des matériaux lourds');
INSERT INTO Accident_travail VALUES (8, 6, TIMESTAMP '2025-03-05 09:00:00', 'Glissade sur le chantier');
INSERT INTO Accident_travail VALUES (9, 7, TIMESTAMP '2024-11-20 07:30:00', 'Brûlure due à un tuyau chaud');
INSERT INTO Accident_travail VALUES (9, 8, TIMESTAMP '2025-06-10 10:15:00', 'Chute sur terrain accidenté');
INSERT INTO Accident_travail VALUES (10, 9, TIMESTAMP '2024-12-01 13:45:00', 'Écrasement de pied par un chariot élévateur');
INSERT INTO Accident_travail VALUES (10, 10, TIMESTAMP '2025-10-05 08:30:00', 'Blessure à l’épaule due à une surcharge');


-- Table Absence
INSERT INTO Absence VALUES (1, 'Maladie');
INSERT INTO Absence VALUES (2, 'Vacances');
INSERT INTO Absence VALUES (3, 'Journée personnel');
INSERT INTO Absence VALUES (4, 'Congé de parternité');
INSERT INTO Absence VALUES (5, 'Raison familiale');
INSERT INTO Absence VALUES (6, 'Déces d’un proche');
INSERT INTO Absence VALUES (7, 'Absence non justifiée');
INSERT INTO Absence VALUES (8, 'En mission de travail');
INSERT INTO Absence VALUES (9, 'Démission');
INSERT INTO Absence VALUES (10, 'Empechement de derniere minute');


-- Table Absence_employe
INSERT INTO Absence_employe VALUES (1, TIMESTAMP '2024-05-20 08:00:00', 1, TIMESTAMP '2024-05-25 17:00:00'); 
INSERT INTO Absence_employe VALUES (2, TIMESTAMP '2024-06-01 08:00:00', 2, TIMESTAMP '2024-06-05 17:00:00'); 
INSERT INTO Absence_employe VALUES (3, TIMESTAMP '2024-07-10 08:00:00', 3, TIMESTAMP '2024-07-15 17:00:00'); 
INSERT INTO Absence_employe VALUES (4, TIMESTAMP '2024-08-05 08:00:00', 4, TIMESTAMP '2024-08-10 17:00:00'); 
INSERT INTO Absence_employe VALUES (5, TIMESTAMP '2024-09-15 08:00:00', 5, TIMESTAMP '2024-09-20 17:00:00'); 
INSERT INTO Absence_employe VALUES (6, TIMESTAMP '2024-10-01 08:00:00', 6, TIMESTAMP '2024-10-10 17:00:00'); 
INSERT INTO Absence_employe VALUES (7, TIMESTAMP '2024-11-05 08:00:00', 7, TIMESTAMP '2024-11-15 17:00:00'); 
INSERT INTO Absence_employe VALUES (8, TIMESTAMP '2024-12-01 08:00:00', 7, TIMESTAMP '2024-12-05 17:00:00'); 
INSERT INTO Absence_employe VALUES (9, TIMESTAMP '2025-01-15 08:00:00', 8, TIMESTAMP '2025-01-20 17:00:00'); 
INSERT INTO Absence_employe VALUES (10, TIMESTAMP '2025-02-05 08:00:00', 9, TIMESTAMP '2025-02-10 17:00:00'); 

-- Table Employe_Tache
INSERT INTO Employe_Tache VALUES (1, 1, 1, TIMESTAMP '2024-01-15 08:00:00', TIMESTAMP '2024-01-15 12:00:00', 'Préparation des plans initiaux');
INSERT INTO Employe_Tache VALUES (1, 1, 2, TIMESTAMP '2024-01-16 08:00:00', TIMESTAMP '2024-01-16 17:00:00', 'Analyse de site');
INSERT INTO Employe_Tache VALUES (7, 1, 3, TIMESTAMP '2024-10-01 08:00:00', TIMESTAMP '2024-12-15 12:00:00', 'Création de modèles 3D');
INSERT INTO Employe_Tache VALUES (3, 2, 1, TIMESTAMP '2024-04-01 08:00:00', TIMESTAMP '2024-04-01 10:00:00', 'Évaluation des risques');
INSERT INTO Employe_Tache VALUES (3, 2, 2, TIMESTAMP '2024-04-02 09:00:00', TIMESTAMP '2024-04-02 17:00:00', 'Préparation de la documentation technique');
INSERT INTO Employe_Tache VALUES (4, 2, 3, TIMESTAMP '2024-05-15 08:00:00', TIMESTAMP '2024-05-15 17:00:00', 'Supervision des travaux');
INSERT INTO Employe_Tache VALUES (5, 3, 1, TIMESTAMP '2024-06-01 08:00:00', TIMESTAMP '2024-06-01 12:00:00', 'Évaluation de l’impact environnemental');
INSERT INTO Employe_Tache VALUES (5, 3, 2, TIMESTAMP '2024-06-02 08:00:00', TIMESTAMP '2024-06-02 15:00:00', 'Réalisation des études de sol');
INSERT INTO Employe_Tache VALUES (6, 3, 3, TIMESTAMP '2024-07-01 08:00:00', TIMESTAMP '2024-07-01 17:00:00', 'Planification des ressources');
INSERT INTO Employe_Tache VALUES (7, 4, 1, TIMESTAMP '2024-07-15 08:00:00', TIMESTAMP '2024-07-15 10:00:00', 'Réalisation des études géologiques');
INSERT INTO Employe_Tache VALUES (7, 4, 2, TIMESTAMP '2024-08-01 09:00:00', TIMESTAMP '2024-08-01 17:00:00', 'Conception du plan de drainage');
INSERT INTO Employe_Tache VALUES (8, 4, 3, TIMESTAMP '2024-09-01 08:00:00', TIMESTAMP '2024-09-01 15:00:00', 'Inspection des matériaux');
INSERT INTO Employe_Tache VALUES (9, 5, 1, TIMESTAMP '2024-08-10 08:00:00', TIMESTAMP '2024-08-10 12:00:00', 'Analyse des données');
INSERT INTO Employe_Tache VALUES (9, 5, 2, TIMESTAMP '2024-09-05 09:00:00', TIMESTAMP '2024-09-05 17:00:00', 'Surveillance de la sécurité sur site');
INSERT INTO Employe_Tache VALUES (10, 5, 3, TIMESTAMP '2025-01-10 08:00:00', TIMESTAMP '2025-01-10 17:00:00', 'Rédaction des rapports d’avancement');
INSERT INTO Employe_Tache VALUES (1, 6, 1, TIMESTAMP '2024-06-01 08:00:00', TIMESTAMP '2024-06-01 10:00:00', 'Évaluation des besoins en équipement');
INSERT INTO Employe_Tache VALUES (1, 6, 2, TIMESTAMP '2024-06-15 09:00:00', TIMESTAMP '2024-06-15 15:00:00', 'Préparation des budgets');
INSERT INTO Employe_Tache VALUES (2, 6, 3, TIMESTAMP '2024-07-20 08:00:00', TIMESTAMP '2024-07-20 17:00:00', 'Élaboration des contrats de sous-traitance');
INSERT INTO Employe_Tache VALUES (2, 7, 1, TIMESTAMP '2024-10-01 08:00:00', TIMESTAMP '2024-10-01 12:00:00', 'Coordination des travaux de construction');
INSERT INTO Employe_Tache VALUES (3, 7, 2, TIMESTAMP '2024-10-15 09:00:00', TIMESTAMP '2024-10-15 17:00:00', 'Gestion des relations avec les clients');
INSERT INTO Employe_Tache VALUES (4, 7, 3, TIMESTAMP '2024-11-10 08:00:00', TIMESTAMP '2024-11-10 17:00:00', 'Évaluation de la performance des employés');
INSERT INTO Employe_Tache VALUES (5, 8, 1, TIMESTAMP '2024-11-15 08:00:00', TIMESTAMP '2024-11-15 12:00:00', 'Développement des plans de construction');
INSERT INTO Employe_Tache VALUES (5, 8, 2, TIMESTAMP '2024-12-01 09:00:00', TIMESTAMP '2024-12-01 17:00:00', 'Gestion des fournisseurs');
INSERT INTO Employe_Tache VALUES (6, 8, 3, TIMESTAMP '2025-01-15 08:00:00', TIMESTAMP '2025-01-15 17:00:00', 'Suivi des progrès de la construction');
INSERT INTO Employe_Tache VALUES (7, 9, 1, TIMESTAMP '2024-10-01 08:00:00', TIMESTAMP '2024-10-01 10:00:00', 'Gestion des documents de chantier');
INSERT INTO Employe_Tache VALUES (7, 9, 2, TIMESTAMP '2024-10-20 09:00:00', TIMESTAMP '2024-10-20 17:00:00', 'Assistance lors des inspections');
INSERT INTO Employe_Tache VALUES (8, 9, 3, TIMESTAMP '2024-11-15 08:00:00', TIMESTAMP '2024-11-15 12:00:00', 'Réalisation des audits de sécurité');
INSERT INTO Employe_Tache VALUES (9, 10, 1, TIMESTAMP '2025-01-10 08:00:00', TIMESTAMP '2025-01-10 10:00:00', 'Création des budgets prévisionnels');
INSERT INTO Employe_Tache VALUES (9, 10, 2, TIMESTAMP '2025-02-05 09:00:00', TIMESTAMP '2025-02-05 17:00:00', 'Suivi des coûts de construction');
INSERT INTO Employe_Tache VALUES (10, 10, 3, TIMESTAMP '2025-03-10 08:00:00', TIMESTAMP '2025-03-10 17:00:00', 'Rapport final sur l’avancement du projet');
INSERT INTO Employe_Tache VALUES (2, 123, 1, TIMESTAMP '2024-11-01 08:00:00', TIMESTAMP '2024-11-30 17:00:00', 'Inspection du site de construction');
INSERT INTO Employe_Tache VALUES (3, 123, 2, TIMESTAMP '2024-12-01 08:00:00', TIMESTAMP '2024-12-03 17:00:00', 'Conception du plan de drainage');
INSERT INTO Employe_Tache VALUES (7, 123, 3, TIMESTAMP '2025-03-01 08:00:00', TIMESTAMP '2025-03-31 17:00:00', 'Rapport final sur l’avancement du projet');
INSERT INTO Employe_Tache VALUES (2, 123, 2, TIMESTAMP '2024-12-20 08:00:00', TIMESTAMP '2024-12-20 17:00:00', 'Inspection du site de construction');
INSERT INTO Employe_Tache VALUES (2, 123, 3, TIMESTAMP '2025-03-07 08:00:00', TIMESTAMP '2025-03-21 17:00:00', 'Inspection du site de construction');

-- Mis a jour des salaires des employés pour test 
UPDATE Employe SET salaire = salaire * 5;

COMMIT;