/*
* TP3_INF3080_A24_UQAM
* Fichier 01-trigger.sql qui comporte le script des déclencheurs,
* procédures.
* @author MARIUS GUIMATSIA AKALONG(GUIM27309006)
* @author MARIUS GUIMATSIA AKALONG(GUIM27309006)
*
*/
--*******************************************************************---
--Q1_a) Création du trigger T_validerbudget_Insertion_projetphase
--*******************************************************************---
create or replace TRIGGER Q1_a
AFTER INSERT ON Projet_phase
DECLARE
    total_budget_phase NUMBER(10, 2);
    budget_projet NUMBER(10, 2);
BEGIN
    -- Récupérer le budget total des phases existantes pour le projet concerné
    SELECT NVL(SUM(budget), 0) INTO total_budget_phase
    FROM Projet_phase
    WHERE id_projet = (SELECT id_projet FROM Projet_phase WHERE ROWID =
     (SELECT MAX(ROWID) FROM Projet_phase));

    -- Récupérer le budget du projet
    SELECT budget INTO budget_projet
    FROM Projet
    WHERE id_projet = (SELECT id_projet FROM Projet_phase WHERE ROWID = 
    (SELECT MAX(ROWID) FROM Projet_phase));

    -- Vérifier que la somme des budgets ne dépasse pas le budget du projet
    IF (total_budget_phase > budget_projet) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Echec d''insertion : Le budget total des phases 
        (' || total_budget_phase || ') dépasse le budget du projet (' || budget_projet || ').');
    END IF;
END;



-- Test du trigger T_validerbudget_Insertion_projetphase 
-- On tente l'insertion d'une phase qui fera deborder le budget

INSERT INTO Projet_phase VALUES (1, 4, 'Finalisation du projet',  '2024-12-01',  '2024-12-15', 500000.00,0);


--*******************************************************************---
--Q1_b Création du trigger T_validerbudget_Modification_projetphase
--*******************************************************************---

CREATE OR REPLACE TRIGGER Q1_b
AFTER UPDATE OF budget ON Projet_phase
DECLARE
    total_budget_phase NUMBER(10, 2);
    budget_projet NUMBER(10, 2);
BEGIN
    -- Parcourir chauqe ligne de la table Projet_phase pour récupérer les projets

    FOR rec IN (SELECT id_projet
                FROM Projet_phase
                ) LOOP
        
        -- Pour chaque phase, récupérer le budget du projet  
        SELECT budget INTO budget_projet
        FROM Projet
        WHERE id_projet = rec.id_projet;

        -- Calculer le budget total des phases (y compris les phases mises à jour)
        SELECT NVL(SUM(budget), 0)
        INTO total_budget_phase
        FROM Projet_phase
        WHERE id_projet = rec.id_projet;

        -- Vérifier que la somme des budgets des phases ne dépasse pas le budget du projet
        -- Ainsi seule la ligne modifié sera rejetté
        IF total_budget_phase  > budget_projet THEN
            RAISE_APPLICATION_ERROR(-20001, 'Echec de mise à jour : 
            Le budget total des phases dépasse le budget du projet.');
        END IF;
    END LOOP;
END;


-- Test du déclencheur T_validerbudget_Modification_projetphase
UPDATE Projet_phase SET budget = 3500000 WHERE id_projet = 1 AND id_phase = 3;

--*******************************************************************---
-- Q2_a) Création du trigger T_validerbudget_Insertion_projetphase
--*******************************************************************---
CREATE OR REPLACE TRIGGER Q2_a
BEFORE INSERT ON Projet 
FOR EACH ROW
DECLARE   
    total_budget_phase Projet_phase.budget%TYPE;
BEGIN
    SELECT NVL(SUM(budget),0) INTO total_budget_phase FROM Projet_phase
    WHERE id_projet = :NEW.id_projet ;

    IF( total_budget_phase > :NEW.budget) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Le budget total des phases dépasse le budget du projet.');
    END IF;
END;

--*******************************************************************---
-- Q2_b) Création du trigger T_validerbudget_Modfication_projet
--*******************************************************************---
CREATE OR REPLACE TRIGGER Q2_b
BEFORE UPDATE OF budget ON Projet 
FOR EACH ROW 
DECLARE 
    total_budget_phase Projet.budget%TYPE;
BEGIN  
    SELECT NVL(SUM(budget),0) INTO total_budget_phase FROM Projet
    WHERE id_projet = :NEW.id_projet;

    IF(total_budget_phase > :NEW.budget) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Echec de mis a jour : Le budget total des phases dépasse le budget du projet.');
    END IF;
END;

--*******************************************************************---
-- Q3 :
/*--Créer un déclencheur T_calcul_depensephase
permettant de calculer les totaux des dépenses par
phase et de vérifier qu’il n’y aura pas de dépassement
des coûts */
--*******************************************************************---

--Phase 1: Création d'une procedure pour mettre a jour la colonne dépenses de chaque phase

CREATE OR REPLACE PROCEDURE mettre_a_jour_depenses AS
BEGIN
    -- Parcourir chaque phase
    FOR phase_rec IN (
        SELECT id_phase,id_projet, budget
        FROM Projet_phase
    ) LOOP
        -- Calculer les dépenses pour la phase en cours
        DECLARE
            total_depenses NUMBER(10, 2);
        BEGIN
            SELECT NVL(SUM(e.salaire * (EXTRACT(HOUR FROM (et.date_heure_fin - et.date_heure_debut)))), 0)
            INTO total_depenses
            FROM Employe_tache et
            INNER JOIN Employe e ON et.id_employe = e.id_employe
            WHERE et.id_phase = phase_rec.id_phase AND et.id_projet = phase_rec.id_projet;

            -- Mettre à jour la colonne depenses pour cette phase
            UPDATE Projet_phase
            SET depenses = total_depenses
            WHERE id_phase = phase_rec.id_phase AND id_projet = phase_rec.id_projet;
        END;
    END LOOP;

    -- Confirmer la mise à jour
    DBMS_OUTPUT.PUT_LINE('Mise à jour des dépenses terminée.');
    COMMIT;
END;

-- Excecution de la procedure 
BEGIN
    mettre_a_jour_depenses;
END;

-- Voir le résultat
SELECT * FROM Projet_phase;



--Phase 2: Création d'une déclencheur T_calcul_depensephase
/*
Pour résoudre le problème des tables mutantes , 
nous allons utiliser un déclencheur au niveau de la déclaration (statement-level trigger) 
plutôt qu'un déclencheur au niveau de la ligne (row-level trigger).
*/
CREATE OR REPLACE TRIGGER T_calcul_depensephase
AFTER INSERT OR UPDATE OR DELETE ON Employe_tache
DECLARE
    total_depense_phase NUMBER(10, 2);
    CURSOR c_depenses IS
        SELECT et.id_phase, et.id_projet, 
               NVL(SUM(e.salaire * (EXTRACT(HOUR FROM (et.date_heure_fin - et.date_heure_debut)))), 0) AS total_depense
        FROM Employe_tache et
        INNER JOIN Employe e ON et.id_employe = e.id_employe
        GROUP BY et.id_phase, et.id_projet;
BEGIN
    -- Parcours du curseur pour calculer les dépenses totales par phase et projet
    FOR rec IN c_depenses LOOP
        -- Vérification du budget de la phase et du projet
        DECLARE
            budget_phase NUMBER(10, 2);
        BEGIN
            -- Récupérer le budget de la phase
            SELECT budget
            INTO budget_phase
            FROM Projet_phase
            WHERE id_phase = rec.id_phase AND id_projet = rec.id_projet;

            -- Si les dépenses dépassent le budget alors on lève une exception
            IF rec.total_depense > budget_phase THEN
                RAISE_APPLICATION_ERROR(
                    -20003,
                    'Erreur : Les dépenses totales pour la phase ' || rec.id_phase || ' et le projet ' || rec.id_projet || 
                    ' dépassent le budget alloué.'
                );
            END IF;
        END;

        -- Sinon on procede a la  mise à jour des dépenses dans la table Projet_phase
        UPDATE Projet_phase
        SET depenses = rec.total_depense
        WHERE id_phase = rec.id_phase AND id_projet = rec.id_projet;

    END LOOP;
END;



-- Phase 4: Test du déclencheur T_calcul_depensephase


INSERT INTO Projet VALUES (13, 'Construction du complexe UQAM', DATE '2024-11-01', DATE '2026-01-01', 150.00);

INSERT INTO Projet_phase VALUES (13, 1, 'Étude de faisabilité', DATE '2024-11-01', DATE '2024-02-15', 50.00,0);
INSERT INTO Projet_phase VALUES (13, 2, 'Réalisation du projet', DATE '2024-02-17', DATE '2026-01-01', 100.00,0);

INSERT INTO Employe_Tache VALUES (2, 13, 1, TIMESTAMP '2024-01-01 08:00:00', TIMESTAMP '2024-02-15 17:00:00', 'Inspection du site de construction');

--*******************************************************************---
-- Q4 Créer un déclencheur T_valider_tache
--*******************************************************************---
CREATE OR REPLACE TRIGGER T_valider_tache
BEFORE INSERT OR UPDATE ON Employe_Tache
FOR EACH ROW
DECLARE
    nb_absences NUMBER;
BEGIN
    -- Vérifier si l'employé est absent pendant la période de la tâche
    SELECT COUNT(*) INTO nb_absences
    FROM Absence_employe ae
    WHERE ae.id_employe = :NEW.id_employe
    -- Un conflit se produit lorsque les intervalles d'absence 
    -- et de presence au travail se chevauchent ou coincident.
    AND (
          -- Vérifier si la tâche est comprise dans une période d'absence
          (:NEW.date_heure_debut BETWEEN ae.date_debut_absence AND ae.date_fin_absence)
          OR 
          (:NEW.date_heure_fin BETWEEN ae.date_debut_absence AND ae.date_fin_absence)
          OR
          -- Vérifier si la période d'absence englobe complètement la tâche
          (ae.date_debut_absence <= :NEW.date_heure_debut 
           AND ae.date_fin_absence >= :NEW.date_heure_fin)
      );

    -- Si nb_absences > 0, lever une exception
    IF nb_absences > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Echec : Cet employé est déclaré absent pendant cette période et ne peut pas travailler.'
        );
    END IF;
END;

-- Test du déclencheur T_valider_tache
INSERT INTO Employe_Tache VALUES (1, 1, 3, TIMESTAMP '2024-05-20 08:00:00', TIMESTAMP '2024-05-23 17:00:00', 'Inspection du site');



--*******************************************************************---
-- Question 5_b) Garder un historique des payements des employés
--*******************************************************************---
-- Création d'un itérateur 
CREATE SEQUENCE HISTORIQUE_PAIEMENT_SEQ START WITH 1 INCREMENT BY 1;

-- Procédure permettant de remplir la table historique de paiement generer_historique_paiement
CREATE OR REPLACE PROCEDURE generer_historique_paiement
IS 
    CURSOR taches_employes IS
        SELECT DISTINCT et.id_employe,  e.salaire, et.date_heure_fin,
        (EXTRACT(HOUR FROM (et.date_heure_fin - et.date_heure_debut)) * e.salaire) AS montant
        FROM Employe_tache et
        INNER JOIN Employe e ON et.id_employe = e.id_employe
        ;

    -- Variables pour stocker les données du curseur
    v_id_employe Employe_Tache.id_employe%TYPE;
    v_date_paiement Employe_Tache.date_heure_fin%TYPE;
    v_salaire Employe.salaire%TYPE;
    v_montant NUMBER(10, 2);
BEGIN 

    FOR rec IN taches_employes LOOP
     -- Assigner les valeurs récupérées
        v_id_employe := rec.id_employe;
        v_date_paiement := rec.date_heure_fin;
        v_montant := rec.montant;
        
        INSERT INTO Historique_Paiement 
        (id_paiement, id_employe, date_paiement, montant, mode_paiement)
        
        VALUES (
            HISTORIQUE_PAIEMENT_SEQ.NEXTVAL, -- Utilisation d'une séquence pour générer l'ID
            v_id_employe,
            TRUNC(v_date_paiement), -- Date du paiement basée sur la fin de la tâche
            v_montant,
            'Virement Bancaire' -- Mode de paiement par défaut
        );
    END LOOP;

    COMMIT;
END;
-- Excecution de la procédure generer_historique_paiement
BEGIN
    generer_historique_paiement;
END;
-- Voir le résultat
SELECT * FROM Historique_paiement

--*******************************************************************---
/*
Q6)  Créer une procédure (P-afficher-vip) permettant
d’afficher le nom et prénom des employés qui ont
encaissé plus que 30000$ entre le 1er et le 30 novembre
2024

*/
--*******************************************************************---
CREATE OR REPLACE PROCEDURE P_afficher_vip
IS
    -- Déclare un curseur pour récupérer les employés VIP
    CURSOR liste_employes_vip IS
        SELECT e.nom, e.prenom, SUM(hp.montant) AS total_encaisse
        FROM Employe e
        INNER JOIN Historique_Paiement hp ON e.id_employe = hp.id_employe
        WHERE hp.date_paiement BETWEEN TO_DATE('2024-11-01', 'YYYY-MM-DD') 
                                      AND TO_DATE('2024-11-30', 'YYYY-MM-DD')
        GROUP BY e.nom, e.prenom
        HAVING SUM(hp.montant) > 30000;

    -- Déclare une variable pour compter le nombre d'enregistrements retournés
    nb_employes NUMBER := 0;

BEGIN
    -- Boucle pour parcourir les enregistrements du curseur
    DBMS_OUTPUT.PUT_LINE('--------------Liste des employés VIP------------ ');
    FOR rec IN liste_employes_vip LOOP
        DBMS_OUTPUT.PUT_LINE('Nom : ' || rec.nom || ', Prénom : ' || rec.prenom || ', Total encaissé : ' || rec.total_encaisse || '$');
        nb_employes := nb_employes + 1;
    END LOOP;

    -- Vérifie si aucun employé VIP n'a été trouvé
    IF nb_employes = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Aucun client VIP trouvé.');
    END IF;
END;

-- Exécution de la procédure

BEGIN
    P_afficher_vip;
END;


