<%
    String mysURL = "jdbc:mysql://localhost/DATABAYSE";
    String mysUserID = "root";
    String mysPassword = "1";
    String mysJDBCDriver = "com.mysql.jdbc.Driver";

    String custID = "" + session.getValue("login");
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

          // customer info
          java.sql.Statement stmt1=conn.createStatement();
					java.sql.ResultSet rs = stmt1.executeQuery("Select * From Customer Where CustomerID = '" + custID + "'");

            while(rs.next()){
              String fn = rs.getString("FirstName");
              String ln = rs.getString("LastName");
              out.print(" FirstName: " + fn);
              out.print(" LastName: " + ln);
              out.print("<br>");
            }

            // customer suggestions
            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("call getSuggestionsByType('" + custID + "')");

            out.print("<br>");
                  out.print("<br>");
            out.print("Sugestions");
            out.print("<br>");

              while(rs.next()) {
                String itemName = rs.getString("Name");
                String type = rs.getString("Type");
                out.print("Item: " + itemName);
                out.print("Type: " + type);
                out.print("<br>");
              }

            // items sold by customer
            out.print("<br>");
            out.print("<br>");
            out.print("Items Sold");
            out.print("<br>");



            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("call itemsSoldBy('" + custID + "')");

              while(rs.next()){
                String itemName = rs.getString("Name");
                String isComplete = rs.getString("isComplete");
                out.print("Item: " + itemName);
                out.print("Active: " + isComplete);
                out.print("<br>");
              }


            // get past auction
            out.print("<br>");
                  out.print("<br>");
                out.print("Past Auctions");
                        out.print("<br>");

             stmt1=conn.createStatement();
             rs = stmt1.executeQuery("call getPastAuctions('" + custID + "')");

              while(rs.next()){
                String itemName = rs.getString("Name");
                String isComplete = rs.getString("isComplete");
                out.print("Item: " + itemName);
                out.print("Active: " + isComplete);
                out.print("<br>");
              }





        } catch(Exception e) {
          out.println("Error: " + e);
        }
%>
