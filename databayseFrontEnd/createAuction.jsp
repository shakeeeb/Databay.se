<%

// THESE COLLECT THE DATA FROM THE SIGNUP FORM
String itemName = request.getParameter("item-name-input");
String itemType = request.getParameter("item-type-input");
String itemYear = request.getParameter("year-input");
String inc = "1";
String reserve = request.getParameter("reserve-input");
String openingBid = "0";
String auctionLength = request.getParameter("auct-length-input");



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

          java.sql.Statement stmt1=conn.createStatement();
					java.sql.ResultSet rs = stmt1.executeQuery("Select * From Customer Where CustomerID = '" + custID + "'");

          if(rs.next()){
            java.util.Enumeration en = request.getParameterNames();
            //java.util.ArrayList<String> params = new java.util.ArrayList<String>();
               while (en.hasMoreElements()) {

                String param = (String)en.nextElement();
                out.println(param);
                out.println(request.getParameter(param));

                  // params.add(param);
                }

             }

          // customer info
            while(rs.next()){
              String fn = rs.getString("FirstName");
              String ln = rs.getString("LastName");
              out.print(" FirstName: " + fn);
              out.print(" LastName: " + ln);
              out.print("<br>");
            }


          // add item to database
          stmt1=conn.createStatement();
          rs = stmt1.executeQuery("call addItem('"+itemName+"','" + itemType+"'," + itemYear +"," + "1" + ")");


      stmt1=conn.createStatement();
      rs = stmt1.executeQuery("call getItem('"+itemName+"','" + itemType+"'," + itemYear + ")");
      String itemID = new String();
        while(rs.next()){
            itemID = rs.getString("ItemID");
          }

          // get lowest selling employee
          stmt1=conn.createStatement();
					rs = stmt1.executeQuery("call getLowestCustomerRep()");
          String employeeID = new String();
          while(rs.next()){
              employeeID = rs.getString("EmployeeID");
            }

          // add lowest employee to look over auction
          stmt1=conn.createStatement();
          rs = stmt1.executeQuery("call addAuction('"+custID +"'," + itemID + "," + employeeID + "," + openingBid
          + "," + reserve + "," + inc  +"," + auctionLength +")");

          // load page saying auction is being approved
          out.println("Auction submitted for approval.");
          response.sendRedirect("auctionSubmitted.html");



        } catch(Exception e) {
          out.println("Error: " + e);
        }
%>
