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
          <!-- <span class="btn btn-default input-group-addon" id="basic-addon2">Search!</span> -->
          <input id="SearchButton" class="btn btn-default" type="button" value="Search"  onclick="return SearchButton_onclick()">
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


          // approve auctions
          out.print("<br>");
          out.print("<label for=\"approved-auctions-label\">Approved Auctions</label>");
          out.print("<br>");
            if(rs.next()){
              java.util.Enumeration en = request.getParameterNames();
              //java.util.ArrayList<String> params = new java.util.ArrayList<String>();
                 while (en.hasMoreElements()) {

                  String auctID = (String)en.nextElement();
                  stmt1=conn.createStatement();
                  rs = stmt1.executeQuery("call approveAuction(" +auctID + ")");
                  out.println(auctID);
                  out.println("<br>");

                    // params.add(param);
                 }

               }

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
