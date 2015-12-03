
<%
          String username = request.getParameter("username-input");
          String userpasswd = request.getParameter("password-input");

     // APPARENTLY THERES NO WAY AROUND PUTTING YOUR USERNAME AND PASSWORD IN THE CODE
     String mysqlPath = "jdbc:mysql://localhost/DATABAYSE";
     String mysqlUsername = "root";
     String mysqlPassword = "1";
     String mysJDBCDriver = "com.mysql.jdbc.Driver";

     // THIS GETS READY TO CONNECT TO THE DATABASE
   //     java.sql.Connection conn = null;
     java.sql.Statement stmt = null;

//<<<<<<< HEAD
    //session.putValue("login","");
    if ((username!=null) &&(userpasswd!=null))
    {

        if (username.trim().equals("") || userpasswd.trim().equals(""))
        {

            response.sendRedirect("index.htm");
        }
        else
        {

            // code start here

            java.sql.Connection conn=null;
            try {
                        Class.forName(mysJDBCDriver).newInstance();
                        java.util.Properties sysprops=System.getProperties();
                        sysprops.put("user",mysqlUsername);
                        sysprops.put("password",mysqlPassword);

                          //connect to the database
                        conn=java.sql.DriverManager.getConnection(mysqlPath,sysprops);
                        //System.out.println("Connected successfully to database using JConnect");

                        conn.setAutoCommit(false);
                        java.sql.Statement stmt1=conn.createStatement();

                java.sql.ResultSet rs = stmt1.executeQuery("Select * from Customer where CustomerID ='"+username+"' and Password ='"+userpasswd+"'");
                if (rs.next())
                {
                    // login success
                    session.putValue("login",username);
                    //response.sendRedirect("StudentInformation.jsp");
          response.sendRedirect("customerHome.jsp");
          //out.println("We made it");
                }
                else
                {
                    rs = stmt1.executeQuery(" select * from Employee where EmployeeID='"+username+"' and Password='"+userpasswd+"'");
                    if(rs.next())
                    {

                       if(rs.getString("isManager").contentEquals("1")) {
                            session.putValue("login", username);
                            response.sendRedirect("managerHome.jsp");
                        }
                        else {
                        session.putValue("login", username);
                        response.sendRedirect("employeeHome.jsp");
                        }
                    }

                    else
                    {
                         //username or password mistake
                        response.sendRedirect("passMistake.html");
            out.println("Password Mistake");
                    }
                }
            } catch(Exception e) {
                out.println("Error: " + e);
            } finally{
        try{conn.close();}catch(Exception ee){ out.println("Error: " + ee);}
      }
    }}

%>
<!--=======-->
/*
   //session.putValue("login","");
   if ((username!=null) &&(userpasswd!=null))
   {

       if (username.trim().equals("") || userpasswd.trim().equals(""))
       {

           response.sendRedirect("index.htm");
       }
       else
       {

           // code start here

           java.sql.Connection conn=null;
           try {
                       Class.forName(mysJDBCDriver).newInstance();
                       java.util.Properties sysprops=System.getProperties();
                       sysprops.put("user",mysqlUsername);
                       sysprops.put("password",mysqlPassword);

                         //connect to the database
                       conn=java.sql.DriverManager.getConnection(mysqlPath,sysprops);
                       //System.out.println("Connected successfully to database using JConnect");

                       conn.setAutoCommit(false);
                       java.sql.Statement stmt1=conn.createStatement();

               java.sql.ResultSet rs = stmt1.executeQuery("Select * from Customer where CustomerID ='"+username+"' and Password ='"+userpasswd+"'");
               if (rs.next())
               {
                   // login success
                   session.putValue("login",username);
                   //response.sendRedirect("StudentInformation.jsp");
         response.sendRedirect("customerHome.jsp");
         //out.println("We made it");
               }
               else
               {
                   rs = stmt1.executeQuery(" select * from Employee where EmployeeID='"+username+"' and Password='"+userpasswd+"'");
                   if(rs.next())
                   {

                      if(rs.getString("isManager").contentEquals("1")) {
                           session.putValue("login", username);
                           response.sendRedirect("managerHome.jsp");
                       }
                       else {
                       session.putValue("login", username);
                       response.sendRedirect("employeeHome.jsp");
                       }
                   }

                   else
                   {
                        //username or password mistake
                       response.sendRedirect("passMistake.html");
           out.println("Password Mistake");
                   }
               }
           } catch(Exception e) {
               out.println("Error: " + e);
           } finally{
						 try{conn.close();}catch(Exception ee){ out.println("Error: " + ee);}
		      }
		    }}

		 */%>
<!-->>>>>>> 3f3bdef50a75ed7f4795fbba57a826175668e8ea-->
