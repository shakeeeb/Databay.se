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
          if(rs.next()){
            String auctID = new String();
            java.util.Enumeration en = request.getParameterNames();
            //java.util.ArrayList<String> params = new java.util.ArrayList<String>();
               while (en.hasMoreElements()) {

                auctID = (String)en.nextElement();
                stmt1=conn.createStatement();
                out.println(auctID);
                out.println("<br>");

                  // params.add(param);
               }

          String bid = request.getParameter("bid-input");

            String fn = rs.getString("FirstName");
            String ln = rs.getString("LastName");
            out.print("<br>");
            out.print("<h2>" + fn + " " + ln + "'s Homepage</h2>");
            out.print(bid);
            out.print("<br>");

String currentHighBid = new String();
          // check if bid is valid
          rs = stmt1.executeQuery("Select * from Auction where AuctionID = " + auctID);
            if(rs.next()){
             currentHighBid = rs.getString("CurrentHighBid");
            }

            out.println(Double.parseDouble(bid));

            if(Double.parseDouble(bid) > Double.parseDouble(currentHighBid)){
            rs = stmt1.executeQuery("call addBid("+auctID+",'"+custID+"',"+Double.parseDouble(bid)+",100000)");
            response.sendRedirect("auction.jsp?"+auctID+"=submit");

          } else {
              response.sendRedirect("unsucessfulbid.html");


          }





        }



        } catch(Exception e) {
          out.println("Error: " + e);
        }
%>
