<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/styles.css">
  <title>databayse</title>

  <script language="javascript" type="text/javascript">

  function SearchButton_onclick() {

    if(document.getElementById("search-input").value != "") {
        document.getElementById("search-form").submit();
    }
  }

  function CreateAccountButton_onclick() {

  }
  </script>
</head>

<body>

  <nav class="navbar navbar1 navbar" role="navigation">

    <div class="container">
      <div class="navbar-header">
        <a class="navbar-brand" href="index.jsp">databayse logo</a>
      </div><!-- navbar-header -->
    </div><!-- container -->
  </nav>

  <nav class="navbar navbar-default navbar-fixed-top" role="navigation">

    <div class="container">
      <div class="navbar-header">
        <a class="navbar-brand" href="index.jsp">databayse logo</a>

      <ul class="nav navbar-nav">
      <li><a></a></li>
        <li><a href="logout.jsp">log out</a></li>
      </ul>

      </div><!-- navbar-header -->

      <form name="search-form" id="search-form" action="itemsearch.jsp" method="post" role="form">
        <div class="container navtop-margin">

          <div class="col-lg-offset-6 input-group col-lg-6">
            <input name="search-input" id="search-input" type="text" class="form-control col-lg-10" placeholder="I want to bid on...">
            <span id="SearchButton" class="input-group-addon" type="button" value="Search"  onclick="return SearchButton_onclick()">Search!</span>
          </div>

        </div>
      </form>

    </div> <!-- container -->

  </nav>

  <div class="content container"><!-- content container -->

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
            String fn = rs.getString("FirstName");
            String ln = rs.getString("LastName");
            out.print("<br>");
            out.print("<h2>" + fn + " " + ln + "'s Homepage</h2>");
            out.print("<br>");
            out.print("<a href=\"createAuction.html\" class=\"btn btn-default\">Create Auction</a>");
            out.print(" <a href=\"customerSettings.jsp\" class=\"btn btn-default\">Edit Account Info </a>");
          }

          // customer suggestions
          out.print("<br>");
          out.print("<h4>Check out these Auctions</h4>");

          rs = stmt1.executeQuery("call getSuggestionsByType('" + custID + "')");
            boolean hasSuggestions = false;
          //  <---
            out.print("<form name=\"search-results-form\" id=\"search-results-form\" action=\"auction.jsp\" method=\"get\" role=\"form\">");
            out.println("<table class=\"table table-striped\"style=\"width:100%\">");
            out.print("<tr>");
            out.print("<th>Item</th>");
            out.print("<th>Seller ID</th>");
            out.print("<th>Name</th>");
            out.print("<th>Closing Date</th>");
            out.print("<th>Closing Time</th>");
            out.print("<th>Buy It Now!</th>");
            out.print("</tr>");


          out.println("</br>");
        //    --)
        while(rs.next()) { // go through the result set,
         //Retrieve by column name
         int id  = rs.getInt("AuctionID");
         String name = rs.getString("Name");
         String imagePath = rs.getString("ImagePath");
         String sellerID = rs.getString("SellerID");
         String auctionID = rs.getString("AuctionID");
         String closingDate = rs.getString("ClosingDate");
         String closingTime = rs.getString("ClosingTime");

         out.print("</tr>");
         out.print("<td><img src=images\\"+imagePath+" alt=\":D\" style=\"width:128px;height:128px;\"></td>");
         out.print("<td>" + sellerID + "</td>");
         out.print("<td>" + name + "</td>");
        out.print("<td>" + closingDate + "</td>");
        out.print("<td>" + closingTime + "</td>");
        out.print("<td><input type=\"submit\" name=\""+auctionID+"\" value =\"Buy Now\"></td>");
         out.print("</tr>");

         hasSuggestions = true;
         }

            // if the customer doesn't have suggestions show the best sellers list
            if(hasSuggestions == false) {


                 out.print("<h5>You don't have any suggestions, search for what you like to get started!</h5>");
              /*
              rs = stmt1.executeQuery("Select * from bestSellersList");
              while(rs.next()){ // go through the result set,
               //Retrieve by column name
               int id  = rs.getInt("AuctionID");
               String name = rs.getString("Name");
               String imagePath = rs.getString("ImagePath");
               String sellerID = rs.getString("SellerID");
               String auctionID = rs.getString("AuctionID");
               String closingDate = rs.getString("ClosingDate");
               String closingTime = rs.getString("ClosingTime");


               out.print("</tr>");
               out.print("<td><img src=images\\"+imagePath+" alt=\":D\" style=\"width:128px;height:128px;\"></td>");
               out.print("<td>" + sellerID + "</td>");
               out.print("<td>" + name + "</td>");
              out.print("<td>" + closingDate + "</td>");
              out.print("<td>" + closingTime + "</td>");
              out.print("<td><input type=\"submit\" name=\""+auctionID+"\" value =\"Buy Now\"></td>");
               out.print("</tr>");

             }*/
            }
            out.println("</table>");
                  out.println("</form>");

            // Unnaproved Auctions
            out.print("<br>");
            out.print("<label for=\"unnaproved-auctions-label\">Upcoming Auctions</label>");
            out.print("<br>");

            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("call getUpcomingAuctions('" + custID + "')");

            boolean hasUnnapprovedAuctions = false;
            while(rs.next()){
                String itemID = rs.getString("ItemID");
                String isComplete = rs.getString("isComplete");
                out.print("Item: " + itemID);
                out.print("Active: " + isComplete);
                out.print("<br>");
                hasUnnapprovedAuctions = true;
              }

              if(hasUnnapprovedAuctions == false) {
                // Unnaproved Auctions
                out.print("<label for=\"approved-auctions-label\">No Auctions!</label>");
                out.print("<br>");
              }

            // get open Auctions
            out.print("<br>");
            out.print("<br>");
            out.print("Items You're Selling!");
            out.print("<br>");

             stmt1=conn.createStatement();
             rs = stmt1.executeQuery("call getOpenAuctions('" + custID + "')");


                             out.print("<form name=\"search-results-form\" id=\"search-results-form\" action=\"auction.jsp\" method=\"get\" role=\"form\">");
                             out.println("<table class=\"table table-striped\"style=\"width:100%\">");
                             out.print("<tr>");
                             out.print("<th>Item</th>");
                             out.print("<th>Seller ID</th>");
                             out.print("<th>Name</th>");
                             out.print("<th>Closing Date</th>");
                             out.print("<th>Closing Time</th>");
                             out.print("<th>Status</th>");
                             out.print("</tr>");


              while(rs.next()){
                String auctID = rs.getString("AuctionID");

              java.sql.Statement stmt2=conn.createStatement();
              java.sql.ResultSet rs2 = stmt2.executeQuery("Select * From Auction Where AuctionID = " + auctID + "");



                while(rs2.next()) { // go through the result set,
                 //Retrieve by column name
                 int itemID = rs2.getInt("ItemID");
                 //String imagePath = rs2.getString("ItemID");
                 String imagePath = rs2.getString("ImagePath");
                 String sellerID = rs2.getString("SellerID");
                 String auctionID = rs2.getString("AuctionID");
                 String closingDate = rs2.getString("ClosingDate");
                 String closingTime = rs2.getString("ClosingTime");
                 String name = new String();
                 java.sql.Statement stmt3=conn.createStatement();
                 java.sql.ResultSet rs3 = stmt3.executeQuery("Select * From Item Where ItemID = " + itemID + "");
                 if(rs3.next()) {
                 name = rs3.getString("Name");
              }
                 out.print("</tr>");
                 out.print("<td><img src=images\\"+imagePath+" alt=\":D\" style=\"width:128px;height:128px;\"></td>");
                 out.print("<td>" + sellerID + "</td>");
                 out.print("<td>" +  name + "</td>");
                out.print("<td>" + closingDate + "</td>");
                out.print("<td>" + closingTime + "</td>");
                out.print("<td><input type=\"submit\" name=\""+auctionID+"\" value =\"OPEN\"></td>");
                 out.print("</tr>");
               }

              }
              out.print("</table>");
              out.print("<form>");

            // get past auction
            out.print("<br>");
            out.print("<br>");
            out.print("Past Auctions");
            out.print("<br>");

             stmt1=conn.createStatement();
             rs = stmt1.executeQuery("call getCompleteAuctions('" + custID + "')");

              while(rs.next()){
                String auctID = rs.getString("AuctionID");

              java.sql.Statement stmt2=conn.createStatement();
              java.sql.ResultSet rs2 = stmt2.executeQuery("Select * From Auction Where AuctionID = " + auctID + "");



                out.print("<form name=\"search-results-form\" id=\"search-results-form\" action=\"auction.jsp\" method=\"get\" role=\"form\">");
                out.println("<table class=\"table table-striped\"style=\"width:100%\">");
                out.print("<tr>");
                out.print("<th>Item</th>");
                out.print("<th>Seller ID</th>");
                out.print("<th>Name</th>");
                out.print("<th>Closing Date</th>");
                out.print("<th>Closing Time</th>");
                out.print("<th>Status</th>");
                out.print("</tr>");

                while(rs2.next()) { // go through the result set,
                 //Retrieve by column name
                 int itemID = rs2.getInt("ItemID");
                 //String imagePath = rs2.getString("ItemID");
                 String imagePath = rs2.getString("ImagePath");
                 String sellerID = rs2.getString("SellerID");
                 String auctionID = rs2.getString("AuctionID");
                 String closingDate = rs2.getString("ClosingDate");
                 String closingTime = rs2.getString("ClosingTime");
                 String name = new String();
                 java.sql.Statement stmt3=conn.createStatement();
                 java.sql.ResultSet rs3 = stmt3.executeQuery("Select * From Item Where ItemID = " + itemID + "");
                 if(rs3.next()) {
                 name = rs3.getString("Name");
              }
                 out.print("</tr>");
                 out.print("<td><img src=images\\"+imagePath+" alt=\":D\" style=\"width:128px;height:128px;\"></td>");
                 out.print("<td>" + sellerID + "</td>");
                 out.print("<td>" +  name + "</td>");
                out.print("<td>" + closingDate + "</td>");
                out.print("<td>" + closingTime + "</td>");
                out.print("<td><input type=\"submit\" name=\""+auctionID+"\" value =\"DONE\"></td>");
                 out.print("</tr>");
               }

              }
              out.print("</table>");
              out.print("<form>");




// EDIT CUSTOMER

        } catch(Exception e) {
          out.println("Error: " + e);
        }
%>



  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>



</div><!-- content container -->


<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/script.js"></script>
</body>
</html>
