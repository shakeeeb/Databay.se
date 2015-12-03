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

  function submitAuction(){
    console.log("im trying to submit!");
    document.getElementById("random-auctions-form").submit();
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


                java.sql.Statement stmt1=conn.createStatement();
                // query the database for a customer, i guess for a personalized list of suggestions
      					java.sql.ResultSet rs = stmt1.executeQuery("Select * From Customer Where CustomerID = '" + custID + "'");
                if(rs.next()){ // in this case teh user is a logged in customer
                  out.print("<li><a href=\"customerHome.jsp\">My Account</a></li>");
                  out.print("<li><a href=\"logout.jsp\">log out</a></li>");
                }
                else { // in this case a user is a logged in manager
                  rs = stmt1.executeQuery("Select * from Employee Where EmployeeID = '" + custID + "'");
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

          %>

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

<div class="row">
<div class="container">
  <div class="btn-group btn-group-justified" role="group" aria-label="...">
  <a href="itemTypeSearch.jsp?search-input=car" class="btn btn-default">Car</a>
  <a href="itemTypeSearch.jsp?search-input=clothes" class="btn btn-default">Clothing</a>
  <a href="itemTypeSearch.jsp?search-input=toy" class="btn btn-default">Toys</a>
  <a href="itemTypeSearch.jsp?search-input=electronics" class="btn btn-default">Electronics</a>
  <a href="itemTypeSearch.jsp?search-input=grocery" class="btn btn-default">Grocery</a>
  <a href="itemTypeSearch.jsp?search-input=other" class="btn btn-default">Other</a>
</div> <!-- button div -->
</div> <!-- container div -->
</div> <!-- row div -->

  <div class="row">
    <section class="col-sm-12">
  <h2> <h2>
    </section>
  </div>

<div class="row">

<div class="carousel slide" id="featured">

<ol class="carousel-indicators">
<li data-target="#featured" data-slide-to="0"></li>
<li data-target="#featured" data-slide-to="1"></li>
<li data-target="#featured" data-slide-to="2"></li>
<li data-target="#featured" data-slide-to="3"></li>
</ol>

  <div class="carousel-inner">
  <div class = "item active">
  <img src="images/holidaybanner.jpg" alt="Exotic Pets Photo" height="250" width="1200">
  </div><!-- div for item 1 -->

  <div class = "item">
  <img src="images/grocerybanner.jpg" alt="Exotic Pets Photo" height="250" width="1200">
  </div><!-- div for item 2 -->

  <div class = "item">
  <img src="images/charmander.png" alt="Exotic Pets Photo" height="400" width="500">
  </div><!-- div for item 3 -->

  <div class = "item">
  <img src="images/bulbasaur.png" alt="Exotic Pets Photo" height="400" width="500">
</div><!-- div for item 4 -->

  <div class = "item">
  <img src="images/pikachu.png" alt="Exotic Pets Photo" height="400" width="500">
</div><!-- div for item 5 -->


  </div> <!-- carousel inner -->

  <a class ="left carousel-control" href="#featured" role="button" data-slide="prev">
  <span class="glyphicon glyphicon-chevron-left"> </span>
  </a>

    <a class ="right carousel-control" href="#featured" role="button" data-slide="next">
  <span class="glyphicon glyphicon-chevron-right"> </span>
  </a>

</div> <!-- carousel slide -->


</div><!-- row -->

  <div class="row">
    <section class="col-sm-12">
      <h2>Best Selling Items</h2>
    </section>
  </div>

  </div>


<center>

  <div class = "item col-lg-offset-0">


  <%
   stmt1=conn.createStatement();
   // this is what i need to apy attention to-- selecting all from the bestesellers list
   rs = stmt1.executeQuery("Select * From bestSellersList");
   String aID = new String();

   int count = 0;
   String imagePath = new String();
   while(rs.next()) {
     count++;
   }

    stmt1=conn.createStatement();
    rs = stmt1.executeQuery("Select * From bestSellersList");
    int i = 0;
    while(i < 4) {
      if(rs.next()) {
           imagePath =  rs.getString("ImagePath");
           aID = rs.getString("AuctionID"); // okay change bestsellerslist to return the auctionID as well
           out.print("<a href=\"auction.jsp?" + aID +"=submit\">");
           //out.println("<h1>"+aID +"<h2>");
           out.println("<img src=\"images/"+imagePath+"\" alt=\"images/default.jpg class=\"img-responsive\" height=\"250\" >");
           out.print("</a>");
      }
      i++;
    }


  %></div><!-- end of the images for best sellers-->
  <div class = "row">
</center>
<div class ="container">
  <div class="row"><!--i dont know how to left justify this with a proper offset-->
    <section class="col-lg-12">
      <h2>Current Open Auctions</h2>
    </section>
  </div>
</div>
  <center>
  <div class = "item col-lg-offset-0"> <!--add in images for current open auctions -->
  <%
  // grab a bunch of things from open auctions
  stmt1 = conn.createStatement();
  rs = stmt1.executeQuery("select * from Auction order by Rand()");
  i = 0; // let there be a max of four images from open auctions
  aID = new String();
  imagePath = new String();
  //out.print("<form name=\"random-auctions-form\" id=\"random-auctions-form\" action=\"auction.jsp\" method=\"get\" role=\"form\">");
  while(i < 3){
    // print out the images
    if(rs.next()){
      aID = rs.getString("AuctionID");
      imagePath = rs.getString("ImagePath");
      out.print("<a href=\"auction.jsp?" + aID +"=submit\">");
      out.print("<img src=\"images/"+imagePath+"\" alt=\""+imagePath+" class=\"img-responsive\" height=\"250\" >");
      out.print("</a>");
    }
  i++;
}
  i=0;

%></div><!-- images -->
</center>
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
<script src="js/jquery.jcarousel.min.js"></script>
</body>
</html>

<%
}
catch(Exception e) {
    out.print("Error: " + e);
  } finally {
      try{conn.close();}catch(Exception ee){};
  }%>
