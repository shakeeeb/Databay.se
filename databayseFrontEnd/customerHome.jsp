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
          }

          // customer suggestions
          out.print("<br>");
          out.print("<label for=\"customer-suggestions-label\">Check out these Auctions</label>");
          out.print("<br>");

          rs = stmt1.executeQuery("call getSuggestionsByType('" + custID + "')");
          out.print("<table class=\"table table-striped\" >");
          out.print("<tr>");
          out.print("<th>Name</th>");
          out.print("<th>Type</th>");
          out.print("</tr>");
            boolean hasSuggestions = false;
              while(rs.next()) {
                String itemName = rs.getString("Name");
                String type = rs.getString("Type");
                out.print("<tr>");
                out.print("<td>" + itemName + "</td>");
                out.print("<td>" + type + "</td>");
                out.print("</tr>");
                hasSuggestions = true;
            }

            // if the customer doesn't have suggestions show the best sellers list
            if(hasSuggestions == false) {
              rs = stmt1.executeQuery("Select * from bestSellersList");
              while(rs.next()) {
                String itemName = rs.getString("Name");
                String type = rs.getString("Type");
                out.print("<tr>");
                out.print("<td>" + itemName + "</td>");
                out.print("<td>" + type + "</td>");
                out.print("</tr>");
              }
            }
            out.println("</table>");

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
                out.print("<label for=\"unnaproved-auctions-label\">No Upcoming Auctions!</label>");
                out.print("<br>");
              }

            // get past auction
            out.print("<br>");
            out.print("<br>");
            out.print("Past Auctions");
            out.print("<br>");

             stmt1=conn.createStatement();
             rs = stmt1.executeQuery("call getCompleteAuctions('" + custID + "')");

              while(rs.next()){
                String itemName = rs.getString("Name");
                String isComplete = rs.getString("isComplete");
                out.print("Item: " + itemName);
                out.print("Active: " + isComplete);
                out.print("<br>");
              }




// EDIT CUSTOMER

        } catch(Exception e) {
          out.println("Error: " + e);
        }
%>
  <a href="createAuction.html" class="btn btn-default">Create Auction</a>
  <a href="customerSettings.jsp" class="btn btn-default">Edit Account Info: </a>


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
