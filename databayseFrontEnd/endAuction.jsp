<%
  // THESE COLLECT THE DATA FROM THE SIGNUP FORM
  String auctID = request.getParameter("endAuction-input");

  // APPARENTLY THERES NO WAY AROUND PUTTING YOUR USERNAME AND PASSWORD IN THE CODE
  String mysqlPath = "jdbc:mysql://localhost/DATABAYSE";
  String mysqlUsername = "root";
  String mysqlPassword = "1";

  // THIS GETS READY TO CONNECT TO THE DATABASE
  java.sql.Connection conn = null;
  java.sql.Statement stmt = null;

			try	{
        // THIS CONNECTS TO THE DATABASE
        Class.forName("com.mysql.jdbc.Driver");
        conn = java.sql.DriverManager.getConnection(mysqlPath,mysqlUsername,mysqlPassword);
        stmt = conn.createStatement();

        // THIS IS THE PROCEDURE WE WILL CALL TO ADD A NEW CUSTOMER TO THE DATABASE
        String query = "call endAuction("+auctID+")";

        // HERE IS THE ACTUAL CALL TO THE DATABASE
        stmt.executeQuery(query);
        //session.putValue("login",firstName);
        response.sendRedirect("auctionEnded.jsp");

        } catch (Exception e) { // IF SOMETHING GOES WRONG TOMCAT SHOULD GIVE YOU AN ERROR SCREEN
          out.println("Something went wrong: " + e);
        } finally {
    				try{conn.close();}catch(Exception ee){};
    			}

%>
