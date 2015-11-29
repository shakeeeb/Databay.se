<%
    String mysURL = "jdbc:mysql://localhost/DATABAYSE";
    String mysUserID = "root";
    String mysPassword = "1";
    String mysJDBCDriver = "com.mysql.jdbc.Driver";

        String custID = ""+session.getValue("login");
  			java.sql.Connection conn=null;
			try
			{
            	Class.forName(mysJDBCDriver).newInstance();
    			java.util.Properties sysprops=System.getProperties();
    			sysprops.put("user",mysUserID);
    			sysprops.put("password",mysPassword);

				//connect to the database
            			conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            			System.out.println("Connected successfully to database using JConnect");

            			java.sql.Statement stmt1=conn.createStatement();

                  out.println(request.getParameter("search-input"));

                  String query = "call itemsAvailableByKeyword('"+request.getParameter("search-input")+"')";



					java.sql.ResultSet res = stmt1.executeQuery(query);

          int count = 0;
          while(res.next()){
           //Retrieve by column name
           //int id  = res.getInt("ItemID");
           String name = res.getString("Name");
           String sellerID = res.getString("SellerID");


           //Display valuesa
           out.println("<p>" +  name
                + "," + sellerID + "</p>");
                count++;
           }
        out.println("<p> " + count + " items found </p>");
        out.println("</body></html>");

        } catch(Exception e) {
          out.println("Error: " + e);
        }
%>
