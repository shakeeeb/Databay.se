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

  function look_at_item(var ID){
    if()
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
        <li><a href="signup.html">sign up</a></li>
        <li><a href="login.html">log in</a></li>
        <li><a href="/logout.jsp">log out</a></li>
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

  <div class="content container">
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

                  out.println("Item: ");

                  out.println(request.getParameter("search-input") + "\n"); // this is what was queried

                  String query = "call itemsAvailableByKeyword('"+request.getParameter("search-input")+"')";
                  // call the query using the thing we just got from the user that was stored in the request object


					java.sql.ResultSet res = stmt1.executeQuery(query);
          //HttpSession session = request.getSession();

          int count = 0;
          // before this, wrap things in a form tag
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
          while(res.next()){ // go through the result set,
           //Retrieve by column name
           int id  = res.getInt("AuctionID");
           String name = res.getString("Name");
           String imagePath = res.getString("ImagePath");
           String sellerID = res.getString("SellerID");
           String auctionID = res.getString("AuctionID");
           String closingDate = res.getString("ClosingDate");
           String closingTime = res.getString("ClosingTime");


           out.print("</tr>");
           out.print("<td><img src=images\\"+imagePath+" alt=\":D\" style=\"width:128px;height:128px;\"></td>");
           out.print("<td>" + sellerID + "</td>");
           out.print("<td>" + name + "</td>");
          out.print("<td>" + closingDate + "</td>");
          out.print("<td>" + closingTime + "</td>");
          out.print("<td><input type=\"submit\" name=\""+auctionID+"\" value =\"Buy Now\"></td>");
           out.print("</tr>");
           count++;
           }
        out.println("</form>");
        out.println("</br>");
        out.println("<p> " + count + " items found </p>");
//>>>>>>> f1ad0cfb294de4d10adc73e005ff366b033157cb

        } catch(Exception e) {
          out.println("Error: " + e);
        }
%>
</div>
</body>
</html>
