import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class connecttest {

    public static void main(String[] args) {

        Connection conn = null;
        Statement stmt = null;
        try {
            // The newInstance() call is a work around for some
            // broken Java implementations
        Class.forName("com.mysql.jdbc.Driver");//.newInstance();
        conn = DriverManager.getConnection("jdbc:mysql://localhost/DATABAYSE","root","1");
        stmt = conn.createStatement();

        String query = "Select * from Employee";
        ResultSet res = stmt.executeQuery(query);

        while(res.next()){
         //Retrieve by column name
         int id  = res.getInt("EmployeeID");
         String firstName = res.getString("FirstName");
         String lastName = res.getString("LastName");

         //Display valuesa
         System.out.print("ID: " + id);
         System.out.print(" FirstName: " + firstName);
         System.out.print(" LastName: " + lastName);
         System.out.println();

      }

        } catch (Exception e) {

            System.out.println("It didn't work :D\n" + e);
        }
    }


    }
