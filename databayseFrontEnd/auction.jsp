
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
    document.getElementById("placebid-form").submit();
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
      <li><a></a></li>

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
    try {
          Class.forName(mysJDBCDriver).newInstance();
          java.util.Properties sysprops=System.getProperties();
          sysprops.put("user",mysUserID);
          sysprops.put("password",mysPassword);

          //connect to the database
          conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
          System.out.println("Connected successfully to database using JConnect");

            java.util.Enumeration en = request.getParameterNames();
            String auctID = new String();

               while(en.hasMoreElements()) {
               auctID = (String)en.nextElement();
               }


              // get all the auction info
              java.sql.Statement stmt1=conn.createStatement();
              java.sql.ResultSet rs = stmt1.executeQuery("Select * From Auction Where AuctionID = " + auctID + "");


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


            if(rs.next()) {
               itemID = rs.getString("ItemID");
               sellerID = rs.getString("SellerID");
               buyerID = rs.getString("BuyerID");
               currentHighBid = rs.getString("CurrentHighBid");
               openingDate = rs.getString("OpeningDate");
               openingTime = rs.getString("OpeningTime");
               closingDate = rs.getString("ClosingDate");
               closingTime = rs.getString("ClosingTime");
               imagePath = rs.getString("ImagePath");

              rs = stmt1.executeQuery("Select * From Item where ItemID = " + itemID);
                if(rs.next()) {
                  itemName = rs.getString("Name");
                  itemType = rs.getString("Type");
                  itemYear = rs.getString("Year");

                  out.println("<h2>"+itemName+"</h2>");
                  out.println("<h5>"+itemType+ " Year: " + itemYear + "</h5>");
                  out.println("<br>");


                }

                    out.println("<form name=\"placebid-form\" id=\"placebid-form\" action=\"placeBid.jsp\" method=\"post\" role=\"form\">");

                    out.println("<img src=\"images/"+imagePath+"\" alt=\"default.jpg\" height=\"400\">");
                      out.println("<br>");
                        out.println("<br>");
                          out.println("<br>");

                    out.println("<label for=\"seller-id-label\">Seller: "+sellerID+"</label>");

                  rs = stmt1.executeQuery("Select * From Customer where CustomerID = '" + sellerID + "'");
                  if(rs.next()) {
                  String sellerRating = rs.getString("Rating");
                  out.println("rating: " + sellerRating + "\5");
                  out.println("<br>");
                  }


                    if(currentHighBid.contentEquals("-1.00")){
                    out.println("<label for=\"auction-bid-label\">No Bid Yet!</label>");
                    out.println("<br>");
                  }else {
                    if(custID != null &&  buyerID != null && custID.contentEquals(buyerID)){

                        out.println("<label for=\"auction-bid-label\">You are currently winning!</label>");
                              out.println("<br>");
                    }
                    out.println("<label for=\"auction-bid-label\">Winning Bid: "+currentHighBid+"</label>");
                    out.println("<br>");
                  }

                  rs = stmt1.executeQuery("Select * From Auction where AuctionID = " + auctID);
                  if(rs.next()) {
                    String isComplete = rs.getString("isComplete");


                  if(isComplete.contentEquals("0")){
                    out.println("<div class =\"form-group col-lg-2 form-large col-lg-offset-0\">");
                    out.println("<label for=\"bid-label\">Place Bid: </label>");
                    out.println("<input name=\"bid-input\" id=\"bid-input\" type=\"text\" class=\"form-control col-lg-offset-1\" placeholder=\"bid\">");
                    out.println("</div>");

                    out.println("<br>");
                        out.println("<br>");


                    out.println("<div class=\"form-group col-lg-0 form-large col-lg-offset-0\">");
                    out.println("<input id=\"PlaceBidButton\" type=\"submit\" class=\"btn btn-primary\" value=\"Place Bid\" onclick=\"return PlaceBidButton_onclick()\" >");

                    out.println("</div>");
                  }
                  else {
                    out.println("Auction Complete");
                    out.println("<br>");
                      out.println("<br>");
                        out.println("<br>");
                out.println("<label for=\"bid-history-label\">Bid History </label>");
                  rs = stmt1.executeQuery("call getBidHistory("+auctID+")");
                  out.println("<table class=\"table table-striped\"style=\"width:100%\">");
                  out.print("<tr>");
                  out.print("<th>Bid</th>");
                  out.print("<th>Bidder</th>");
                  out.print("<th>Bid Date</th>");
                  out.print("<th>Bid Time</th>");
                  out.print("</tr>");
                  while(rs.next()){
                    String bid = rs.getString("Bid");
                    String bidder = rs.getString("CustomerID");
                    String bidDate = rs.getString("BidDate");
                    String bidTime = rs.getString("BidTime");

                    out.print("</tr>");
                    out.print("<td>" + bid + "</td>");
                    out.print("<td>" +  bidder + "</td>");
                   out.print("<td>" + bidDate + "</td>");
                   out.print("<td>" + bidTime + "</td>");
                    out.print("</tr>");



                  }
                  out.print("</table>");

                  }
                }
                      out.println("<input hidden name=\""+auctID+"\">");

          out.println("</form>");


            }




    %>
<%
// do jsp stuff here...

} catch (Exception e){
  out.println("Error: " + e);
}
%>
</div>
<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/script.js"></script>
</body>
</html>
