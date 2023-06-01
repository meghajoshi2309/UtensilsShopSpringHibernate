<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "jakarta.servlet.http.*,jakarta.servlet.*" %>
<%@ page import=" org.hibernate.cfg.Configuration" %>
<%@ page import=" org.hibernate.SessionFactory" %>
<%@ page import="org.springframework.web.servlet.ModelAndView " %>
<%@ page import="org.springframework.stereotype.Controller " %>
<%@ page import="productpk.product" %>
<%@ page import="utensils.Register" %>
<%@ page import="org.hibernate.Session " %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Profile</title>
<link rel="stylesheet"href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"crossorigin="anonymous"></script>
<meta name="viewport"content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light"
		style="background: linear-gradient(-135deg, #c850c0, #4158d0)">
		<a class="navbar-brand" href="#">Utensils</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item active"><a class="nav-link" href="Home?ID=${ID}">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="VeiwCart?ID=${ID}">Cart</a></li>
				<li class="nav-item"><a class="nav-link" href="MyProfile?ID=${ID}">My Profile</a></li>
				<li class="nav-item"><a class="nav-link" href="Logout}">Logout</a>
				</li>
			</ul>
		</div>
	</nav>
      <br>
      <center>${msg}</center>
     <div class="container">
    <table class="table table-striped">
    <thead>
      <tr>
        <th class = "text-center" colspan="2">My Profile</th>
      </tr>
    </thead>
    <tbody>
      
      
      <% 
      int ID = (Integer) request.getAttribute("ID");
     
      try {
    		Configuration cfg = new Configuration().configure().addAnnotatedClass(Register.class);			
    		cfg.configure("hibernate.cfg.xml");
    		SessionFactory factory = cfg.buildSessionFactory();
    		Session Session = factory.openSession();
    		
    		
    		
    		java.util.List li = Session.createQuery("from Register where ID = " + ID).list();
    		System.out.println("ID");
    		java.util.Iterator it=li.iterator();
    		while(it.hasNext()) {
    			Object o = (Object)it.next();
    			Register rs = (Register)o;
    		    String name = rs.getUsername();

      %>
      
     
      <tr>
      	<td class = "text-center">Username : </td>
        <td class = "text-center"><% out.print(rs.getUsername()); %></td>
      </tr>
      <tr>
        <td class = "text-center">Email : </td>
        <td class = "text-center"><% out.print(rs.getEmail()); %></td>
      </tr>
       <tr>
      	<td class = "text-center">Phone No : </td>
        <td class = "text-center"><% out.print(rs.getPhone()); %></td>
      </tr>
      <tr>
        <td class = "text-center">Address : </td>
        <td class = "text-center"><% out.print(rs.getAddress()); %></td>
      </tr>
      <tr>
      	<td class = "text-center">Gender : </td>
        <td class = "text-center"><% out.print(rs.getGender()); %></td>
      </tr> 
      <tr>
      	<td class = "text-center " colspan="2"><a class="btn btn-primary" href="EditProfile?ID=${ID}" role="button">Edit Profile</a></td>
      
      
      
      <%  
	     
		 System.out.println(rs.getID());
		//flag++;
	}
	Session.close();
	factory.close();
}
catch(Exception ex) {
	System.out.println(ex);	
}
              
          %>
          
          </tbody>
    </table>
  </div>
          
          
          
          
	
	
	
	
</body>
</html>