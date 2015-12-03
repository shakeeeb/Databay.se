
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

  function PlaceBidButton_onclick() {
    document.getElementById("bid-form").submit();
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
        <a class="navbar-brand" href="index.html">databayse logo</a>
      <ul class="nav navbar-nav">
      <li><a></a></li><!--HERE -->
      <%
      String mysURL = "jdbc:mysql://localhost/DATABAYSE";
      String mysUserID = "root";
      String mysPassword = "1";
      String mysJDBCDriver = "com.mysql.jdbc.Driver";
      String wierdmessage = "this is a wierdmessage";

      String custID = "" + session.getValue("login");

      java.sql.Connection conn=null;
      try {
            Class.forName(mysJDBCDriver).newInstance();
            java.util.Properties sysprops=System.getProperties();
            sysprops.put("user",mysUserID);
            sysprops.put("password",mysPassword);

            //connect to the database
            conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            System.out.println("Connected successfully to database using JConnect");
            java.sql.Statement stmt=conn.createStatement();
            java.sql.ResultSet rs = stmt.executeQuery("Select * from Customer where CustomerID ='"+ custID + "'");
            if(rs.next()){ // in this case teh user is a logged in customer
              out.print("<li><a href=\"customerHome.jsp\">My Account</a></li>");
              out.print("<li><a href=\"logout.jsp\">log out</a></li>");
            } else{
              rs = stmt.executeQuery("Select * from Employee Where EmployeeID = '" + custID + "'");
              if(rs.next()) {
                if(rs.getString("isManager").contentEquals("1")) {
                  out.print("<li><a href=\"managerHome.jsp\">Dashboard</a></li>");
                }

                else { // in this case the user is a logged in employee
                  out.print("<li><a href=\"employeeHome.jsp\">Dashboard</a></li>");
              }

                out.print("<li><a href=\"logout.jsp\">log out</a></li>");
              }
              else { // and they havent logged in yet
                out.print("<li><a href=\"signup.html\">sign up</a></li>");
                out.print("<li><a href=\"login.html\">log in</a></li>");
}
}


        //<li><a href="signup.html">sign up</a></li>
        //<li><a href="login.html">log in</a></li>
        //<li><a href="logout.jsp">log out</a></li>
        %>
      </ul><!--END HERE -->

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


            java.util.Enumeration en = request.getParameterNames();
            String auctID = new String();

               while(en.hasMoreElements()) {
               auctID = (String)en.nextElement();
               }


              // get all the auction info
              java.sql.Statement stmt1=conn.createStatement();
              java.sql.ResultSet res = stmt1.executeQuery("Select * From Auction Where AuctionID = " + auctID + "");


              String itemID = new String();
              String itemName = new String();
              String itemType = new String();
              String itemYear = new String();
              String sellerID = new String();
              String buyerID = new String();
              String currentHighBid = new String();
              String openingDate = new String();
              String openingTime = new String();
              String closingDate = new String();
              String closingTime = new String();
              String imagePath = new String();


            if(res.next()) {
               itemID = res.getString("ItemID");
               sellerID = res.getString("SellerID");
               buyerID = res.getString("BuyerID");
               currentHighBid = res.getString("CurrentHighBid");
               openingDate = res.getString("OpeningDate");
               openingTime = res.getString("OpeningTime");
               closingDate = res.getString("ClosingDate");
               closingTime = res.getString("ClosingTime");
               imagePath = res.getString("ImagePath");

              res = stmt1.executeQuery("Select * From Item where ItemID = " + itemID);
                if(res.next()) {


                  itemName = res.getString("Name");
                  itemType = res.getString("Type");
                  itemYear = res.getString("Year");

                  out.println("<h2>"+itemName+"</h2>");
                  out.println("<h5>"+itemType+ " Year: " + itemYear + "</h5>");
                  out.println("<br>");


                }

                    out.println("<img src=\"images/"+imagePath+"\" alt=\"default.jpg\" height=\"400\">");
                      out.println("<br>");
                        out.println("<br>");
                          out.println("<br>");

                    out.println("<label for=\"seller-id-label\">Seller: "+sellerID+"</label>");
                    out.println("<br>");
                    out.println("<div class =\"form-group col-lg-2 form-large col-lg-offset-0\">");
                    out.println("<label for=\"bid-label\">Place Bid: </label>");
                    out.println("<input name=\"bid-input\" id=\"bid-input\" type=\"number\" class=\"form-control col-lg-offset-1\" placeholder=\"bid\">");
                    out.println("</div>");

                    out.println("<br>");
                        out.println("<br>");
                    out.println("<div class=\"form-group col-lg-0 form-large col-lg-offset-0\">");
                    out.println("<input id=\"PlaceBidButton\" type=\"submit\" class=\"btn btn-primary\" value=\"Place Bid\" onclick=\"return PlaceBidButton_onclick()\" >");
                    out.println("</div>");




            }




    %>
<%
// do jsp stuff here...

} catch (Exception e){
  out.println("Error: " + e);
}
%>
</div>
</div>


  <br>
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
