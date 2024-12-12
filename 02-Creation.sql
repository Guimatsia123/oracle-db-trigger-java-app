/*
* TP3_INF3080_A24_UQAM
* Un fichier 02-Creation.sql qui comporte le script de modification
* et création des tables du schéma physique.
* @author MARIUS GUIMATSIA AKALONG(GUIM27309006)
* @author MARIUS GUIMATSIA AKALONG(GUIM27309006)
*
*/
-- Table Client
CREATE TABLE Client (
    id_client NUMBER(10) NOT NULL,
    nom_client VARCHAR2(50) NOT NULL,
    adresse_numero NUMBER(10) NOT NULL,
    adresse_rue VARCHAR2(50) NOT NULL,
    adresse_ville VARCHAR2(50) NOT NULL,
    adresse_codepostal VARCHAR2(7) NOT NULL,
    nom_contact VARCHAR2(50) NOT NULL,
    telephone VARCHAR2(15) NOT NULL,
    courriel VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_client PRIMARY KEY (id_client)
);

-- Table Projet
CREATE TABLE Projet (
    id_projet NUMBER(10) NOT NULL,
    nom_projet VARCHAR2(50) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    budget NUMBER(10, 2) NOT NULL,
    CONSTRAINT pk_projet PRIMARY KEY (id_projet)
);

-- Table Specialite
CREATE TABLE Specialite (
    id_specialite NUMBER(10) NOT NULL,
    description VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_specialite PRIMARY KEY (id_specialite)
);

-- Table Departement
CREATE TABLE Departement (
    id_departement NUMBER(10) NOT NULL,
    description VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_departement PRIMARY KEY (id_departement)
);

-- Table Type_emploie
CREATE TABLE Type_emploie (
    id_type_emploie NUMBER(10) NOT NULL,
    description VARCHAR2(25) NOT NULL,
    CONSTRAINT pk_type_emploie PRIMARY KEY (id_type_emploie)
);

-- Table Employe
CREATE TABLE Employe (
    id_employe NUMBER(10) NOT NULL,
    nom VARCHAR2(50) NOT NULL,
    prenom VARCHAR2(50) NOT NULL,
    id_specialite NUMBER(10) NOT NULL,
    id_departement NUMBER(10) NOT NULL,
    id_type_emploie NUMBER(10) NOT NULL,
    salaire NUMBER(8, 2) NOT NULL,
    CONSTRAINT pk_employe PRIMARY KEY (id_employe),
    CONSTRAINT fk_employe_specialite FOREIGN KEY (id_specialite) REFERENCES Specialite(id_specialite),
    CONSTRAINT fk_employe_departement FOREIGN KEY (id_departement) REFERENCES Departement(id_departement),
    CONSTRAINT fk_employe_type FOREIGN KEY (id_type_emploie) REFERENCES Type_emploie(id_type_emploie)
);

-- Table Projet_client
CREATE TABLE Projet_client (
    id_client NUMBER(10) NOT NULL,
    id_projet NUMBER(10) NOT NULL,
    CONSTRAINT pk_projet_client PRIMARY KEY (id_client, id_projet),
    CONSTRAINT fk_projet_client_client FOREIGN KEY (id_client) REFERENCES Client(id_client),
    CONSTRAINT fk_projet_client_projet FOREIGN KEY (id_projet) REFERENCES Projet(id_projet)
);

-- Table Projet_phase
CREATE TABLE Projet_phase (
    id_projet NUMBER(10) NOT NULL,
    id_phase NUMBER(10) NOT NULL,
    nom_phase VARCHAR2(50) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    budget NUMBER(10, 2) NOT NULL,
    CONSTRAINT pk_projet_phase PRIMARY KEY (id_projet, id_phase),
    CONSTRAINT fk_projet_phase_projet FOREIGN KEY (id_projet) REFERENCES Projet(id_projet)
);

-- Table Accident_travail
CREATE TABLE Accident_travail (
    id_projet NUMBER(10) NOT NULL,
    id_employe NUMBER(10) NOT NULL,
    date_accident TIMESTAMP NOT NULL,
    description VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_accident_travail PRIMARY KEY (id_projet, id_employe, date_accident),
    CONSTRAINT fk_accident_travail_projet FOREIGN KEY (id_projet) REFERENCES Projet(id_projet),
    CONSTRAINT fk_accident_travail_employe FOREIGN KEY (id_employe) REFERENCES Employe(id_employe)
);

-- Table Absence
CREATE TABLE Absence (
    id_absence NUMBER(10) NOT NULL,
    description VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_absence PRIMARY KEY (id_absence)
);

-- Table Absence_employe
CREATE TABLE Absence_employe (
    id_employe NUMBER(10) NOT NULL,
    date_debut_absence TIMESTAMP NOT NULL,
    id_absence NUMBER(10) NOT NULL,
    date_fin_absence TIMESTAMP NOT NULL,
    CONSTRAINT pk_absence_employe PRIMARY KEY (id_employe, date_debut_absence),
    CONSTRAINT fk_absence_employe_employe FOREIGN KEY (id_employe) REFERENCES Employe(id_employe),
    CONSTRAINT fk_absence_employe_absence FOREIGN KEY (id_absence) REFERENCES Absence(id_absence)
);

-- Table Employe_Tache
CREATE TABLE Employe_Tache (
    id_employe NUMBER(10) NOT NULL,
    id_projet NUMBER(10) NOT NULL,
    id_phase NUMBER(10) NOT NULL,
    date_heure_debut TIMESTAMP NOT NULL,
    date_heure_fin TIMESTAMP NOT NULL,
    description VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_employe_tache PRIMARY KEY (id_employe, id_projet, id_phase, date_heure_debut),
    CONSTRAINT fk_employe_tache_employe FOREIGN KEY (id_employe) REFERENCES Employe(id_employe),
    CONSTRAINT fk_employe_tache_projet_phase FOREIGN KEY (id_projet, id_phase) REFERENCES Projet_phase(id_projet, id_phase)
);
--*******************************************************************---
--Q3_a) Modifier la structure de la B.D pour ajouter le champ 
--« dépenses » dans la table « projet_phase »
--*******************************************************************---

ALTER TABLE Projet_phase ADD depenses NUMBER(10, 2) DEFAULT 0 NOT NULL;

--*******************************************************************---
-- Q5) Modifier la structure de la B.D pour refléter les règles d’affaires suivantes
--*******************************************************************---


-- Q5.1) Identifier le ou les directeurs d’un employé dans la compagnie.

ALTER TABLE Employe ADD id_directeur NUMBER(10);

ALTER TABLE Employe
ADD CONSTRAINT fk_employe_directeur FOREIGN KEY (id_directeur) REFERENCES Employe(id_employe);

-- Q5.2) Garder un historique des payements de employés
CREATE TABLE Historique_Paiement (
    id_paiement NUMBER(10) NOT NULL,
    id_employe NUMBER(10) NOT NULL,
    date_paiement DATE NOT NULL,
    montant NUMBER(10, 2) NOT NULL,
    mode_paiement VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_historique_paiement PRIMARY KEY (id_paiement),
    CONSTRAINT fk_historique_paiement_employe FOREIGN KEY (id_employe) REFERENCES Employe(id_employe)
);



COMMIT;

