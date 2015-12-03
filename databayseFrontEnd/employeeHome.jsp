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

    String emplID = "" + session.getValue("login");
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

          // employee info
          java.sql.Statement stmt1=conn.createStatement();
					java.sql.ResultSet rs = stmt1.executeQuery("Select * From Employee Where EmployeeID = '" + emplID + "'");

            if(rs.next()){
              String fn = rs.getString("FirstName");
              String ln = rs.getString("LastName");
              out.print("<br>");
              out.print("<label for=\"unnaproved-auctions-label\">Employee: " + fn + " " + ln + "</label>");
              out.print("<br>");
            }

            // unnapproved auctions
            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("call getUnnapprovedAuctions(" + emplID + ")");

            out.print("<br>");
            out.print("<label for=\"unnaproved-auctions-label\">Unnaproved Auctions</label>");
            out.print("<br>");

            out.print("<form name=\"approve-auction-form\" id=\"signup-form\" action=\"approveAuction.jsp\" method=\"post\" role=\"form\">");
            out.println("<table class=\"table table-striped\" style=\"width:100%\">");
            out.print("<tr>");
            out.print("<th>Approve</th>");
            out.print("<th>ItemID</th>");
            out.print("<th>ItemName</th>");
            out.print("<th>ItemType</th>");
            out.print("<th>ItemYear</th>");
            out.print("<th>SellerID</th>");
            out.print("</tr>");
              while(rs.next()) {
                out.print("<tr>");
                String auctionID = rs.getString("AuctionID");
                String itemID = rs.getString("ItemID");
                String sellerID = rs.getString("SellerID");
                String itemName = "";
                String itemType = "";
                String itemYear = "";

              rs = stmt1.executeQuery("Select * From Item where ItemID = " + itemID);
               if(rs.next()) {
                 itemName = rs.getString("Name");
                 itemType = rs.getString("Type");
                 itemYear = rs.getString("Year");
  

               }

              

                out.print("<td><input type=\"checkbox\" name=\""+auctionID+"\"></td>");
                out.print("<td>" + itemID + "</td>");
                out.print("<td>" + itemName + "</td>");
                out.print("<td>" + itemType + "</td>");
                out.print("<td>" + itemYear + "</td>");
                out.print("<td>" + sellerID + "</td>");
                out.print("</tr>");
              }
              out.println("</table>");
              out.print("<br>");
              

              out.println("<input type=\"submit\" value=\"Approve\">");
              out.print("</form>");

              out.print("<br>");
              out.print("<br>");
            
            // unnapproved auctions
            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("select * from viewAllItems");

            out.print("<br>");
            out.print("<label for=\"viewAllItems-label\"> View All Items</label>");
            out.print("<br>");

            out.print("<form name=\"approve-auction-form\" id=\"signup-form\" action=\"approveAuction.jsp\" method=\"post\" role=\"form\">");
            out.println("<table class=\"table table-striped\" style=\"width:100%\">");
            out.print("<tr>");
            out.print("<th>ItemName</th>");
            out.print("<th>ItemType</th>");
            out.print("<th>ItemYear</th>");
            out.print("<th>CopiesSold</th>");
            out.print("<th>AmountInStock</th>");
            out.print("</tr>");
              while(rs.next()) {
                out.print("<tr>");
                String itemName = rs.getString("Name");
                String itemType = rs.getString("Type");
                String itemYear = rs.getString("Year");
                String copiesSold = rs.getString("CopiesSold");
                String amountInStock = rs.getString("AmountInStock");


                
                out.print("<td>" + itemName + "</td>");
                out.print("<td>" + itemType + "</td>");
                out.print("<td>" + itemYear + "</td>");
                out.print("<td>" + copiesSold + "</td>");
                out.print("<td>" + amountInStock + "</td>");
                out.print("</tr>");
              }
              out.println("</table>");
              out.print("<br>");
              


              //customer mailing list
            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("select * from customerMailingList");

            out.print("<br>");
            out.print("<label for=\"customerMailingList-label\"> Customer Mailing List</label>");
            out.print("<br>");

            out.print("<form name=\"customer-mailing-line-form\" id=\"signup-form\" action=\"approveAuction.jsp\" method=\"post\" role=\"form\">");
            out.println("<table class=\"table table-striped\" style=\"width:100%\">");
            out.print("<tr>");
            out.print("<th>LastName</th>");
            out.print("<th>FirstName</th>");
            out.print("<th>Address</th>");
            out.print("<th>City</th>");
            out.print("<th>State</th>");
            out.print("<th>ZipCode</th>");
            out.print("</tr>");
              while(rs.next()) {
                out.print("<tr>");
                String lastName = rs.getString("LastName");
                String firstName = rs.getString("FirstName");
                String address = rs.getString("Address");
                String city = rs.getString("City");
                String state = rs.getString("State");
                String zipCode = rs.getString("ZipCode");
                
                out.print("<td>" + lastName + "</td>");
                out.print("<td>" + firstName + "</td>");
                out.print("<td>" + address + "</td>");
                out.print("<td>" + city + "</td>");
                out.print("<td>" + state + "</td>");
                out.print("<td>" + zipCode + "</td>");
                out.print("</tr>");
              }
              out.println("</table>");
              out.print("<br>");
              out.print("<br>");              



            //sales by item name
            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("select * from salesByItemName");

            out.print("<br>");
            out.print("<label for=\"salesByItemName-label\"> Sales by Item Name </label>");
            out.print("<br>");

            out.print("<form name=\"salesByItemName-form\" id=\"signup-form\" action=\"approveAuction.jsp\" method=\"post\" role=\"form\">");
            out.println("<table class=\"table table-striped\" style=\"width:100%\">");
            out.print("<tr>");
            out.print("<th>Name</th>");
            out.print("<th>TotalCopiesSold</th>");
            out.print("<th>TotalCLosingBids</th>");
            out.print("</tr>");
              while(rs.next()) {
                out.print("<tr>");
                String name = rs.getString("Name");
                String totalCopiesSold = rs.getString("TotalCopiesSold");
                String totalClosingBids = rs.getString("TotalClosingBids");
                
                out.print("<td>" + name + "</td>");
                out.print("<td>" + totalCopiesSold + "</td>");
                out.print("<td>" + totalClosingBids + "</td>");
                out.print("</tr>");
              }
              out.println("</table>");
              out.print("<br>");
              out.print("<br>");              



            //itemsSold
            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("select * from itemsSold");

            out.print("<br>");
            out.print("<label for=\"itemsSold-label\"> Items Sold </label>");
            out.print("<br>");

            out.print("<form name=\"itemsSold-form\" id=\"signup-form\" action=\"approveAuction.jsp\" method=\"post\" role=\"form\">");
            out.println("<table class=\"table table-striped\" style=\"width:100%\">");
            out.print("<tr>");

            out.print("<th>ItemID</th>");
            out.print("<th>Name</th>");
            out.print("<th>Type</th>");
            out.print("<th>Year</th>");
            out.print("<th>CopiesSold</th>");
            
            out.print("</tr>");
              while(rs.next()) {
                out.print("<tr>");

                String itemID = rs.getString("ItemID");
                String name = rs.getString("Name");
                String type = rs.getString("Type");
                String year = rs.getString("Year");
                String copiesSold = rs.getString("CopiesSold");
                

                out.print("<td>" + itemID + "</td>");
                out.print("<td>" + name + "</td>");
                out.print("<td>" + type + "</td>");
                out.print("<td>" + year + "</td>");
                out.print("<td>" + copiesSold + "</td>");

                out.print("</tr>");
              }
              out.println("</table>");
              out.print("<br>");
              out.print("<br>");              




















              /*

            // items sold by customer
            out.print("<br>");
            out.print("<br>");
            out.print("Items Sold");
            out.print("<br>");



            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("call itemsSoldBy('" + emplID + "')");

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
             rs = stmt1.executeQuery("call getPastAuctions('" + emplID + "')");

              while(rs.next()){
                String itemName = rs.getString("Name");
                String isComplete = rs.getString("isComplete");
                out.print("Item: " + itemName);
                out.print("Active: " + isComplete);
                out.print("<br>");
              }


*/


        } catch(Exception e) {
          out.println("Error: " + e);
        }
%>

  <br>
  <br>
  <br>

</div><!-- content container -->
    <footer class="footer">
      <div class="container">
        <center><span class="text-muted"><br>FOOTER HERE.<br><br><br></span></center>
      </div>
    </footer>

<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/script.js"></script>
</body>
</html>
