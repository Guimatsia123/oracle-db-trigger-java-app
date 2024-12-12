import java.sql.*;
import java.sql.Date;
import java.util.*;
import java.lang.*;


public class AppJava {

    //Definition des constantes

    public static final String MENU = """
            \n\t\t ***MENU PRINCIPAL***
               1. Afficher les employés qui ont travaillé
                  entre deux dates sur un projet(Question #7)
               2. Ajouter un accident de travail d’un employé(Question #8)
               3. Obtenir la liste des conflits présence (Question #9)
               4. Quitter L'application\n\n 
            """;
    public static final String MSG_AJOUT_OK = "Accident de travail ajouté avec succes\n";
    public static final String MSG_AJOUT_FAIL = "Echec d'ajout de l'accident de travail\n";


    // Configuration de connexion à la base de données
    private static final String DB_URL = "jdbc:oracle:thin:@//localhost:1521/orcl";
    private static final String DB_USERNAME = "C##MARIUS";
    private static final String DB_PASSWORD = "LeLe@180518";

    public static void main(String[] args) {

        int choix ;
        do{
            choix = validerChoixMenu();
            if(choix == 1){
                rechercherEmployerParProjet();
            }
            if(choix == 2){
                insererAccidentTravail();
            }
            if(choix == 3){
                obtenirListeEmployerConflitPresence();
            }
            if(choix == 4){
                System.exit(0);
            }

        }while(true);



    }
    public static int validerChoixMenu(){
        int choix = 0;
        boolean estInvalide = true;
        do{
            System.out.println(MENU);
            Scanner scanner = new Scanner(System.in);

            try{

                System.out.print("Entrez votre choix :");
                choix = scanner.nextInt();
                if(choix < 1 || choix > 4)
                    System.out.println("Choix du menu doit etre entre 1 et 3");
                else estInvalide = false;
            }catch (Exception e ){
                System.out.println("Votre choix doit etre un entier positif entre 1 et 3");

            }


        }while(estInvalide);

        return choix;

    }

    public static void rechercherEmployerParProjet(){
        Scanner sc = new Scanner(System.in);
        try{
            // Entrée utilisateur
            System.out.print("Entrez le nom du projet : ");
            String projectName = sc.nextLine();

            System.out.print("Entrez la date de début (YYYY-MM-DD) : \t");
            String startDate = sc.nextLine();

            System.out.print("Entrez la date de fin (YYYY-MM-DD) : \t");
            String endDate = sc.nextLine();
            if(!validerData(projectName, startDate, endDate)){
                System.out.println("Erreur : Les données saisies sont invalides\n");

            }else {
                // Obtenir les employés et afficher les résultats
                List<Employee> employees = obternirEmployeParProjet(projectName, startDate, endDate);
                if (employees.isEmpty()) {
                    System.out.println("Aucun employé trouvé pour le projet spécifié dans l'intervalle de dates.");
                } else {
                    System.out.println("\nListe des employés ayant travaillé sur le projet : "+projectName
                    +"\n entre "+startDate+" et "+endDate);
                    employees.forEach(employee ->
                            System.out.println(employee.toString())
                    );
                }

            }
            //sc.close();

        } catch(Exception e ){
            System.err.println(e.getMessage());

        }



    }
    public static void obtenirListeEmployerConflitPresence(){

        List<Employee> employees = ObtenirListeConflit();
        if(!employees.isEmpty()){
            System.out.println("\nListe des employés ayant déclaré etre entrain de travailler alors qu'ils étaient absents ");
            employees.forEach(employee ->
                    System.out.println(employee.toString())
            );

        }else {
            System.out.println("Aucun employé trouvé !!!");
        }


    }
    public static void insererAccidentTravail(){
        Scanner sc = new Scanner(System.in);

        try{

            System.out.print("Saisir l'identifiant du projet(id_projet) : ");
            int idProjet = sc.nextInt();
            System.out.print("Saisir l'identifiant de l'employe(id_employe) : ");
            int idEmploye = sc.nextInt();
            sc.nextLine();
            System.out.print("Saisir la date de l'accident(YYYY-MM-DD) : ");
            String date = sc.nextLine();
            System.out.print("Saisir la description de l'accident : ");
            String description = sc.nextLine();
            boolean insertionComplete = insertAccidentTravail(idProjet, idEmploye, date, description);
            if(insertionComplete)
                System.out.println(MSG_AJOUT_OK);
            else
                System.err.println(MSG_AJOUT_FAIL);



        }catch (Exception e){
            System.out.println("Les valeurs saisie ne sont pas valides : "+e.getMessage());
        }


    }

    public static List<Employee> obternirEmployeParProjet(String projectName, String startDate, String endDate) {
        List<Employee> employees = new ArrayList<>();
        String query = """
                SELECT DISTINCT e.nom, e.prenom
                FROM Employe e
                INNER JOIN Employe_Tache et ON e.id_employe = et.id_employe
                INNER JOIN Projet p ON et.id_projet = p.id_projet
                WHERE p.nom_projet = ?
                  AND et.date_heure_debut >= TO_DATE(?, 'YYYY-MM-DD')
                  AND et.date_heure_fin <= TO_DATE(?, 'YYYY-MM-DD')
                """;

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            // Préparation de la requête
            preparedStatement.setString(1, projectName);
            preparedStatement.setString(2, startDate);
            preparedStatement.setString(3, endDate);

            // Exécution de la requête
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    String lastName = resultSet.getString("nom");
                    String firstName = resultSet.getString("prenom");
                    employees.add(new Employee(lastName, firstName));
                }
            }
            preparedStatement.close();
            connection.close();

        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
        }

        return employees;
    }
    public static List<Employee> ObtenirListeConflit() {
        List<Employee> employees = new ArrayList<>();
        String query = """

                SELECT Employe.nom, Employe.prenom
        FROM Employe
        INNER JOIN Absence_employe ON Employe.id_employe = Absence_employe.id_employe
        INNER JOIN Employe_tache ON Employe.id_employe = Employe_tache.id_employe

        WHERE (Absence_employe.date_debut_absence BETWEEN employe_tache.date_heure_debut AND employe_tache.date_heure_fin)
        OR (Absence_employe.date_fin_absence BETWEEN employe_tache.date_heure_debut  AND employe_tache.date_heure_fin)
        OR (Absence_employe.date_debut_absence  <= employe_tache.date_heure_debut \s
                AND Absence_employe.date_debut_absence >= employe_tache.date_heure_fin)
               \s
               \s""";
        try{
            Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            PreparedStatement preparedStatement = connection.prepareStatement(query);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    String lastName = resultSet.getString("nom");
                    String firstName = resultSet.getString("prenom");
                    employees.add(new Employee(lastName, firstName));

                }
            }
            preparedStatement.close();

        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête :" + e.getMessage());

        }
        return employees;
    }
    public static boolean insertAccidentTravail(int idProjet, int idEmploye, String dateAccident, String description) {
        boolean isInserted = false;
        try {
            // Parse and validate date
            Timestamp date = Timestamp.valueOf(dateAccident + " 00:00:00");

            // Insert into database
            Connection cnx = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            String sql = "INSERT INTO Accident_travail (id_projet, id_employe, date_accident, description) " +
                    "VALUES (?, ?, ?, ?)";
            PreparedStatement ps = cnx.prepareStatement(sql);
            ps.setInt(1, idProjet);
            ps.setInt(2, idEmploye);
            ps.setTimestamp(3, date);
            ps.setString(4, description);

            isInserted = ps.executeUpdate() > 0 ? true : false;


            ps.close();
            cnx.close();
        } catch (Exception ex) {
            System.err.println("Erreur: Echec d'insertion dans la table Accident_travail "+ex.getMessage());

        }



    return isInserted;
    }

    public static boolean validerData(String projectName, String startDate, String endDate) {
        if(projectName.isEmpty()) return false;
        try {
            Date d1 = Date.valueOf(startDate);
            Date d2 = Date.valueOf(endDate);
            if(!d1.before(d2)) return false;

        } catch (Exception e) {
            System.err.println("Erreur: La date doit etre au format YYYY-MM-DD " +
                    "et la date début doit etre inferieur a date fin");
            return false;
        }
        return true;

    }

    // Classe Employee pour stocker les résultats
    static class Employee {
        private final String lastName;
        private final String firstName;

        public Employee(String lastName, String firstName) {
            this.lastName = lastName;
            this.firstName = firstName;
        }

        public String getLastName() {
            return lastName;
        }

        public String getFirstName() {
            return firstName;
        }

        @Override
        public String toString() {
            return "- Nom : " + lastName + ", Prénom : " + firstName + "\n";


        }

    }

}

