<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "jakarta.servlet.http.*,jakarta.servlet.*" %>
<%@ page import=" org.hibernate.cfg.Configuration" %>
<%@ page import=" org.hibernate.SessionFactory" %>
<%@ page import="org.springframework.web.servlet.ModelAndView " %>
<%@ page import="org.springframework.stereotype.Controller " %>
<%@ page import="productpk.product" %>
<%@ page import="productpk.Cart" %>
<%@ page import="org.hibernate.Session " %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Utensils</title>
<link rel="stylesheet"href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"crossorigin="anonymous"></script>
<meta name="viewport"content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
${Msg}

<% int ID = (Integer) request.getAttribute("ID");
   
   int pid = (Integer) request.getAttribute("pid");
%>
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
				<li class="nav-item"><a class="nav-link" href="Logout">Logout</a>
				</li>
			</ul>
		</div>
	</nav>
	<br><br>
     <div class="container">
    <table class="table table-striped">
    <thead>
      <tr>
        
        <th class = "text-center">Product Name</th>
        <th class = "text-center">Category</th>
        <th class = "text-center">Type</th>
        <th class = "text-center">Quantity</th>
        <th class = "text-center">Price</th>
      </tr>
    </thead>
    <tbody>
	
	
	<%
	try {
		Configuration cfg = new Configuration().configure().addAnnotatedClass(Cart.class);
		cfg.configure("hibernate.cfg.xml");
		SessionFactory factory = cfg.buildSessionFactory();
		Session Session = factory.openSession();

		
		java.util.List li = Session.createQuery("from Cart where ID ='" + ID + "'" ).list();
		java.util.Iterator it = li.iterator();
		
		
		int total = 0,flag=0;
		
		
		while (it.hasNext()) {
			Object o = (Object) it.next();
			Cart rs = (Cart) o;
			
			total += (rs.getPrice()*rs.getQuantity());
			
			if(rs.getFlag()==0)
			{
			flag=1;
			
	    	
			
	%>
		<tr>
        <td class = "text-center"><% out.print(rs.getPname()); %></td>
        <td class = "text-center"><% out.print(rs.getCategory()); %></td>
        <td class = "text-center"><% out.print(rs.getType()); %></td>
        <td class = "text-center"><% out.print(rs.getQuantity()); %></td>
        <td class = "text-center"><% out.print(rs.getPrice()); %></td>
        </tr>
	
	<%
			}
		}
		if(flag==1)
		{
	%>
		<tr>
			<td class = "text-right" colspan="5"><b><%out.print("Totle Amount : " + total);%></b></td>
		</tr>
	<%
	
		}
		else
		{
	
	%>
		<tr>
			<td class = "text-right" colspan="5"><b><%out.print("Totle Amount : 0");%></b></td>
		</tr>
	<%
		}
	
	%>
		<tr>
			<td class = "text-left " colspan="5"><a class="btn btn-block btn-primary" href="PlaceOrder?ID=${ID}" role="button">Place Order</a></td>
		</tr>
		</tbody>
		</table>
		</div>
		
		
		
		<%
		
		Session.close();
		factory.close();
	} 
	catch (Exception ex) {
		System.out.println(ex);
	}
	%>



</body>
</html>