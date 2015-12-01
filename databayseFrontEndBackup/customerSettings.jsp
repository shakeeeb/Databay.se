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

            while(rs.next()){
              String fn = rs.getString("FirstName");
              String ln = rs.getString("LastName");
              out.print(" FirstName: " + fn);
              out.print(" LastName: " + ln);
              out.print("<br>");
            }

            // customer suggestions
            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("call getSuggestionsByType('" + custID + "')");

            out.print("<br>");
                  out.print("<br>");
            out.print("Sugestions");
            out.print("<br>");

              while(rs.next()) {
                String itemName = rs.getString("Name");
                String type = rs.getString("Type");
                out.print("Item: " + itemName);
                out.print("Type: " + type);
                out.print("<br>");
              }

            // items sold by customer
            out.print("<br>");
            out.print("<br>");
            out.print("Items Sold");
            out.print("<br>");



            stmt1=conn.createStatement();
            rs = stmt1.executeQuery("call itemsSoldBy('" + custID + "')");

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
             rs = stmt1.executeQuery("call getPastAuctions('" + custID + "')");

              while(rs.next()){
                String itemName = rs.getString("Name");
                String isComplete = rs.getString("isComplete");
                out.print("Item: " + itemName);
                out.print("Active: " + isComplete);
                out.print("<br>");
              }





        } catch(Exception e) {
          out.println("Error: " + e);
        }
%>
