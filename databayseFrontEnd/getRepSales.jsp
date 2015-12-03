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

  function GetRepSalesButton_onclick() {
    if(document.getElementById("repId-input").value != "") {
        document.getElementById("get_rep-form").submit();
    }
  }

  function PromoteButton_onclick()
  {
    if(document.getElementById("promoteToManager-input").value != "") {
        document.getElementById("promoteToManager-form").submit();
    }
  }
  </script>
</head>


<body>

  <nav class="navbar navbar1 navbar" role="navigation">

    <div class="container">
      <div class="navbar-header">
        <a class="navbar-brand" href="index.html">databayse logo</a>
      </div><!-- navbar-header -->
    </div><!-- container -->
  </nav>

  <nav class="navbar navbar-default navbar-fixed-top" role="navigation">

    <div class="container">
      <div class="navbar-header">
        <a class="pull-left" href="index.jsp"><img src="images/logo.png" height="50px" width="50px"></a>

      <ul class="nav navbar-nav">
      <li><a></a></li>
        <li><a href="signup.html">sign up</a></li>
        <li><a href="/logout.jsp">log out</a></li>
      </ul>

      </div><!-- navbar-header -->

      <form name="search-form" id="search-form" action="itemsearch.jsp" method="post" role="form">
        <div class="container navtop-margin">

        <div class="col-lg-offset-6 input-group col-lg-6">
          <input name="search-input" id="search-input" type="text" class="form-control col-lg-10" placeholder="I want to bid on...">
          <!-- <span class="btn btn-default input-group-addon" id="basic-addon2">Search!</span> -->
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
    String get_rep_id = request.getParameter("repId-input");

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
          java.sql.ResultSet rs = stmt1.executeQuery("Select * From Employee Where EmployeeID = " + emplID);;

            if(rs.next()){
              String fn = rs.getString("FirstName");
              String ln = rs.getString("LastName");
              out.print("<br>");
              out.print("<label for=\"unnaproved-auctions-label\">Employee: " + fn + " " + ln + "</label>");
              out.print("<br>");
            }

            // unapproved auctions
            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("call getUnnapprovedAuctions(" + emplID + ")");

            out.print("<br>");
            out.print("<label for=\"unnaproved-auctions-label\">Unnaproved Auctions</label>");
            out.print("<br>");

            out.print("<form name=\"approve-auction-form\" id=\"signup-form\" action=\"approveAuction.jsp\" method=\"post\" role=\"form\">");
            out.println("<table border=\"1\" style=\"width:100%\">");
            out.print("<tr>");
            out.print("<th>Approve</th>");
            out.print("<th>ItemID</th>");
            out.print("<th>SellerID</th>");
            out.print("</tr>");
              while(rs.next()) {
                out.print("<tr>");
                String auctionID = rs.getString("AuctionID");
                String itemName = rs.getString("ItemID");
                String sellerID = rs.getString("SellerID");
                out.print("<td><input type=\"checkbox\" name=\""+auctionID+"\"></td>");
                out.print("<td>" + itemName + "</td>");
                out.print("<td>" + sellerID + "</td>");
                out.print("</tr>");
              }
              out.println("</table>");
              out.println("<input type=\"submit\" value=\"Approve\">");
              out.print("</form>");



          // getMonthlySalesReport
          out.print("<br>");
          out.print("<br>");
          out.print("<label for=\"monthly-sales-report-label\">The Monthly Sales Report</label>");
          out.print("<br>");

          rs = stmt1.executeQuery("call getMonthlySalesReport('" + 12 + "')");
          out.println("<table border=\"1\" style=\"width:100%\">");
          out.print("<tr>");
          out.print("<th>Name</th>");
          out.print("<th>Type</th>");
          out.print("</tr>");
            boolean hasSalesReport = false;
              while(rs.next()) {
                String itemName = rs.getString("Name");
                String type = rs.getString("SUM(A.ClosingBid)");
                out.print("<tr>");
                out.print("<td>" + itemName + "</td>");
                out.print("<td>" + type + "</td>");
                out.print("</tr>");
                hasSalesReport = true;
            }

            out.println("</table>");



          // getBestCustomerRep
          out.print("<br>");
          out.print("<br>");
          out.print("<label for=\"best-customer-rep-label\">The Best Customer Rep</label>");
          out.print("<br>");

          rs = stmt1.executeQuery("call getBestCustomerRep(" + ")");
          out.println("<table border=\"1\" style=\"width:100%\">");
          out.print("<tr>");
          out.print("<th>Employee ID</th>");
          out.print("<th>SSN</th>");
          out.print("<th>First Name</th>");
          out.print("<th>Last Name</th>");
          out.print("</tr>");
            boolean hasBestCustomerRep = false;
              while(rs.next()) {
                String employeeID = rs.getString("EmployeeID");
                String ssn = rs.getString("SSN");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");

                out.print("<tr>");
                out.print("<td>" + employeeID + "</td>");
                out.print("<td>" + ssn + "</td>");
                out.print("<td>" + firstName + "</td>");
                out.print("<td>" + lastName + "</td>");
                out.print("</tr>");
                hasBestCustomerRep = true;
            }

            out.println("</table>");




          // getRepSales(IN empl_id INTEGER)
          out.print("<br>");
          out.print("<br>");
          out.print("<label for=\"get-customer-rep-label\">Get Rep Sales </label>");
          out.print("<br>");

          rs = stmt1.executeQuery("call getRepSales(" + get_rep_id + ")");
          out.println("<table border=\"1\" style=\"width:100%\">");
          out.print("<tr>");
          out.print("<th>First Name</th>");
          out.print("<th>Last Name</th>");
          out.print("<th>Item Name</th>");
          out.print("<th>Auction ID</th>");
          out.print("<th>Closing Bid</th>");

          out.print("</tr>");
            boolean hasRepSales = false;
              while(rs.next()) {
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                String name = rs.getString("Name");
                String auction_id = rs.getString("AuctionID");
                String closing_bid = rs.getString("ClosingBid");

                out.print("<tr>");

                out.print("<td>" + firstName + "</td>");
                out.print("<td>" + lastName + "</td>");
                out.print("<td>" + name + "</td>");
                out.print("<td>" + auction_id + "</td>");
                out.print("<td>" + closing_bid + "</td>");

                out.print("</tr>");
                hasRepSales = true;
            }

            out.println("</table>");





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

        <form name="promoteToManager-form" method="post" action="promoteToManager.jsp">
        <div class ="form-group col-lg-6 form-large col-lg-offset-2">
          <label for="promoteToManager-label">Promote to Manager</label>
          <input name="promoteToManager-input" id="repId-input" type="text" class="form-control col-lg-offset-1" placeholder="ID of Person to Promote">
        </div>

        <div class="form-group col-lg-1 form-large col-lg-offset-7">
            <input id="PromoteButton" type="button" class="btn btn-primary" value="Promote" onclick="return PromoteButton_onclick()" >
        </div>
        </form>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>

        <form name="demoteToEmployee-form" method="post" action="demoteToEmployee.jsp">
        <div class ="form-group col-lg-6 form-large col-lg-offset-2">
          <label for="demoteToEmployee-label">Demote to Employee</label>
          <input name="demoteToEmployee-input" id="repId-input" type="text" class="form-control col-lg-offset-1" placeholder="ID of Person to Demote">
        </div>

        <div class="form-group col-lg-1 form-large col-lg-offset-7">
            <input id="DemoteButton" type="button" class="btn btn-primary" value="Demote" onclick="return DemoteButton_onclick()" >
        </div>
        </form>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>

        <form name="get_rep-form" method="post" action="getRepSales.jsp">
        <div class ="form-group col-lg-6 form-large col-lg-offset-2">
          <label for="repId-label">Get Sales Rep ID</label>
          <input name="repId-input" id="repId-input" type="text" class="form-control col-lg-offset-1" placeholder="Rep Id">
        </div>

        <div class="form-group col-lg-1 form-large col-lg-offset-7">
            <input id="GetRepSalesButton" type="button" class="btn btn-primary" value="Get Rep Sales" onclick="return GetRepSalesButton_onclick()" >
        </div>
        </form>
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
