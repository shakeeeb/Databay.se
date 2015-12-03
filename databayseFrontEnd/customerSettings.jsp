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

]
  }

  function UpdateAccountButton_onclick() {

    if(document.getElementById("first-name-input").value != "") {
        document.getElementById("edit-account-form").submit();
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
        <a class="pull-left" href="index.jsp"><img src="images/logo.png" height="50px" width="50px"></a>

      <ul class="nav navbar-nav">
      <li><a></a></li>
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

          String firstName = new String();
          String lastName = new String();
          String address = new String();
          String city = new String();
          String state = new String();
          String zip = new String();
          String tel = new String();
          String email = new String();
          String password = new String();
          String ccard = new String();

            if(rs.next()) {
              firstName = rs.getString("FirstName");
              lastName = rs.getString("LastName");
              address = rs.getString("Address");
              city = rs.getString("City");
              state = rs.getString("State");
              zip = rs.getString("Zipcode");
              tel = rs.getString("Telephone");
              email = rs.getString("Email");
              password = rs.getString("Password");
              ccard = rs.getString("CreditCard");
            }
            %>

            <div class="row">
              <section class="col-sm-12">
                <h2> Account Info:  </h2>
              </section>
            </div>

          <form name="edit-account-form" id="edit-account-form" action="editCustomer.jsp" method="post" role="form">

            <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="first-name-label">First Name</label>
              <%
              out.println("<input name=\"first-name-input\" id=\"first-name-input\" type=\"text\" class=\"form-control col-lg-offset-1\" readonly value=\""+ firstName +"\">");
              %>
            </div>

            <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="last-name-label">Last Name</label>
              <%
              out.println("<input name=\"last-name-input\" id=\"last-name-input\" type=\"text\" class=\"form-control col-lg-offset-1\" value=\""+ lastName +"\">");
              %>

            </div>

            <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="email-label">Email</label>
              <%
              out.println("<input name=\"email-input\" id=\"email-input\" type=\"email\" class=\"form-control col-lg-offset-1\" value=\""+ email +"\">");
              %>
            </div>

            <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="password-label">Password</label>
              <%
              out.println("<input name=\"password-input\" id=\"password-input\" type=\"password\" class=\"form-control col-lg-offset-1\" value=\""+ password +"\">");
              %>
            </div>

            <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="phone-label">Phone</label>
              <%
              out.println("<input name=\"phone-input\" id=\"phone-input\" type=\"text\" class=\"form-control col-lg-offset-1\" value=\""+ tel +"\">");
              %>
            </div>

            <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="address-label">Street Address</label>
              <%
              out.println("<input name=\"address-input\" id=\"address-input\" type=\"text\" class=\"form-control col-lg-offset-1\" value=\""+ address +"\">");
              %>

            </div>

            <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="city-label">City</label>
                <%
                out.println("<input name=\"city-input\" id=\"city-input\" type=\"text\" class=\"form-control col-lg-offset-1\" value=\""+ city +"\">");
                %>
            </div>

  <div class ="form-group col-lg-6 form-large col-lg-offset-2">
    <label for="state-label">State</label>

 <div class="dropdown">
  <button class="btn btn-default btn-dropdown dropdown-toggle col-lg-6" type="button" id="dropdownMenu1" data-toggle="dropdown">
    State
    <span class="caret"></span>
  </button>
  <ul class="dropdown-menu col-lg-6">
    <li><a href="#">AL</a></li>
    <li><a href="#">AK</a></li>
    <li><a href="#">AR</a></li>
    <li><a href="#">AZ</a></li>
    <li><a href="#">CA</a></li>
    <li><a href="#">CO</a></li>
    <li><a href="#">CT</a></li>
    <li><a href="#">DC</a></li>
    <li><a href="#">DE</a></li>
    <li><a href="#">FL</a></li>
    <li><a href="#">HI</a></li>
    <li><a href="#">ID</a></li>
    <li><a href="#">IL</a></li>
    <li><a href="#">IN</a></li>
    <li><a href="#">IA</a></li>
    <li><a href="#">KS</a></li>
    <li><a href="#">KY</a></li>
    <li><a href="#">LA</a></li>
    <li><a href="#">ME</a></li>
    <li><a href="#">MA</a></li>
    <li><a href="#">MD</a></li>
    <li><a href="#">MI</a></li>
    <li><a href="#">MN</a></li>
    <li><a href="#">MS</a></li>
    <li><a href="#">MO</a></li>
    <li><a href="#">MT</a></li>
    <li><a href="#">NE</a></li>
    <li><a href="#">NV</a></li>
    <li><a href="#">NH</a></li>
    <li><a href="#">NJ</a></li>
    <li><a href="#">NM</a></li>
    <li><a href="#">NY</a></li>
    <li><a href="#">NC</a></li>
    <li><a href="#">ND</a></li>
    <li><a href="#">OH</a></li>
    <li><a href="#">OK</a></li>
    <li><a href="#">OR</a></li>
    <li><a href="#">PA</a></li>
    <li><a href="#">RI</a></li>
    <li><a href="#">SC</a></li>
    <li><a href="#">SD</a></li>
    <li><a href="#">TN</a></li>
    <li><a href="#">TX</a></li>
    <li><a href="#">UT</a></li>
    <li><a href="#">VT</a></li>
    <li><a href="#">VA</a></li>
    <li><a href="#">WA</a></li>
    <li><a href="#">WV</a></li>
    <li><a href="#">WI</a></li>
    <li><a href="#">WY</a></li>

  </ul>
</div>



  </div>

            <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="zip-label">Zip Code</label>
              <%
              out.println("<input name=\"zip-input\" id=\"zip-input\" type=\"text\" class=\"form-control col-lg-offset-1\" value=\""+ zip +"\">");
              %>
            </div>

            <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="ccard-label">Credit Card</label>
              <%
              out.println("<input name=\"ccard-input\" id=\"ccard-input\" type=\"text\" class=\"form-control col-lg-offset-1\" value=\""+ ccard +"\">");
              %>
            </div>

            <div class="form-group col-lg-1 form-large col-lg-offset-7">
                <input id="UpdateAccountButton" type="submit" class="btn btn-primary" value="Update Account" onclick="return UpdateAccountButton_onclick()" >
            </div>

          </form> <!--form-->




<%
        } catch(Exception e) {
          out.println("Error: " + e);
        }
%>
