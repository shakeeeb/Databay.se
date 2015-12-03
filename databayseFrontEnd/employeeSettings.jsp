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
        <a class="navbar-brand" href="index.jsp">databayse logo</a>

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

    String empID = "" + session.getValue("login");
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
					java.sql.ResultSet rs = stmt1.executeQuery("Select * From Employee Where EmployeeID = '" + empID + "'");

          String ssn = new String();
          String firstName = new String();
          String lastName = new String();
          String address = new String();
          String city = new String();
          String state = new String();
          String zip = new String();
          String tel = new String();
          String hrwage = new String();
          String password = new String();

            if(rs.next()) {
              ssn = rs.getString("SSN");
              firstName = rs.getString("FirstName");
              lastName = rs.getString("LastName");
              address = rs.getString("Address");
              city = rs.getString("City");
              state = rs.getString("State");
              zip = rs.getString("Zipcode");
              tel = rs.getString("Telephone");
              hrwage = rs.getString("HourlyRate");
              password = rs.getString("Password");
            }
            %>

            <div class="row">
              <section class="col-sm-12">
                <h2> Account Info:  </h2>
              </section>
            </div>

          <form name="edit-account-form" id="edit-account-form" action="editEmployee.jsp" method="post" role="form">

             <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="ssn-label">SSN</label>
              <%
              out.println("<input name=\"ssn-input\" id=\"ssn-input\" type=\"text\" class=\"form-control col-lg-offset-1\" readonly value=\""+ ssn +"\">");
              %>
            </div>

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
              <label for="hrwage-label">Hourly Wage</label>
                <%
                out.println("<input name=\"hrwage-input\" id=\"hrwage-input\" type=\"text\" class=\"form-control col-lg-offset-1\" readonly value=\""+ hrwage +"\">");
                %>
            </div>

              <div class ="form-group col-lg-6 form-large col-lg-offset-2">
    <label for="state-label">State</label>
    
<input name="state-input" id="state-input" type="text" class="form-control col-lg-offset-1" placeholder="State">



  </div>

            <div class ="form-group col-lg-6 form-large col-lg-offset-2">
              <label for="zip-label">Zip Code</label>
              <%
              out.println("<input name=\"zip-input\" id=\"zip-input\" type=\"text\" class=\"form-control col-lg-offset-1\" value=\""+ zip +"\">");
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