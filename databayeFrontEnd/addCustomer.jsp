<%
  // THESE COLLECT THE DATA FROM THE SIGNUP FORM
  String firstName = request.getParameter("first-name-input");
  String lastName = request.getParameter("last-name-input");
  String address = request.getParameter("address-input");
  String city = request.getParameter("city-input");
  String state = request.getParameter("state-input");
  String zip = request.getParameter("zip-input");
  String email = request.getParameter("email-input");
  String ccard = request.getParameter("ccard-input");

  // APPARENTLY THERES NO WAY AROUND PUTTING YOUR USERNAME AND PASSWORD IN THE CODE
  String mysqlPath = "jdbc:mysql://localhost/DATABAYSE";
  String mysqlUsername = "root";
  String mysqlPassword = "1";

  // THIS GETS READY TO CONNECT TO THE DATABASE
  java.sql.Connection conn = null;
  java.sql.Statement stmt = null;	
out.println("yo");	
			try	{
        // THIS CONNECTS TO THE DATABASE
        Class.forName("com.mysql.jdbc.Driver");
        conn = java.sql.DriverManager.getConnection(mysqlPath,mysqlUsername,mysqlPassword);
        stmt = conn.createStatement();

        // THIS IS THE PROCEDURE WE WILL CALL TO ADD A NEW CUSTOMER TO THE DATABASE
        String query = "call addCustomer('" + firstName + "','" + lastName + "','"
        + address + "','" + city + "','" + state + "','" + zip + "','" + "ADD PHONE"
        + "','" + email + "','" + ccard +"')";
        // HERE IS THE ACTUAL CALL TO THE DATABASE
        stmt.executeQuery(query);

        // THIS IS JUST TO CHECK IF THE NEW CUSTOMER WAS ADDED. (REMOVE LATER)
  			java.sql.ResultSet res = stmt.executeQuery("Select * from Customer");
          while(res.next()){
            String fn = res.getString("FirstName");
            String ln = res.getString("LastName");
            out.print(" FirstName: " + fn);
            out.print(" LastName: " + ln);
            out.print("<br>");
          }
        } catch (Exception e) { // IF SOMETHING GOES WRONG TOMCAT SHOULD GIVE YOU AN ERROR SCREEN
          System.out.println("Something went wrong: " + e);
        }

%>
