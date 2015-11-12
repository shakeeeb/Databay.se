// To save as "<TOMCAT_HOME>\webapps\hello\WEB-INF\classes\QueryServlet.java".
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class QueryServlet extends HttpServlet {  // JDK 6 and above only

   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      // Get a output writer to write the response message into the network socket
      PrintWriter out = response.getWriter();

      Connection conn = null;
      Statement stmt = null;
      try {

         // Step 1: Allocate a database Connection object
          conn = DriverManager.getConnection("jdbc:mysql://localhost/DATABAYSE","root","1");

            // database-URL(hostname, port, default database), username, password

         // Step 2: Allocate a Statement object within the Connection
         stmt = conn.createStatement();

         String query = "Select * from Item where Name ="
            + "'" + request.getParameter("item-name") + "'";

            out.println("<html><head><title>Query Response</title></head><body>");
            out.println("<h3>Thank you for your query.</h3>");
            out.println("<p>You query is: " + query + "</p>"); // Echo for debugging

                ResultSet res = stmt.executeQuery(query);
                int count = 0;

                while(res.next()){
                 //Retrieve by column name
                 int id  = res.getInt("ItemID");
                 String name = res.getString("Name");
                 String type = res.getString("Type");


                 //Display valuesa
                 out.println("<p>" + id
                      + ", " +  name
                      + ", $" + type + "</p>");
                      count++;
                 }
              out.println("<p> " + count + " items found </p>");
              out.println("</body></html>");


     } catch (SQLException ex) {
        ex.printStackTrace();
     } finally {
        out.close();  // Close the output writer
        try {
           // Step 5: Close the resources
           if (stmt != null) stmt.close();
           if (conn != null) conn.close();
        } catch (SQLException ex) {
           ex.printStackTrace();
        }
     }
   }

}
