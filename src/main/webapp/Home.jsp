<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
	
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "jakarta.servlet.http.*,jakarta.servlet.*" %>
<%@ page import=" org.hibernate.cfg.Configuration" %>
<%@ page import=" org.hibernate.SessionFactory" %>
<%@ page import="org.springframework.web.servlet.ModelAndView " %>
<%@ page import="org.springframework.stereotype.Controller " %>
<%@ page import="productpk.product" %>
<%@ page import="org.hibernate.Session " %>
	
	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
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
	
	<style>
    .card-img-top{
    	width: 100%;
   		height: 15vw;
   		object-fit: cover;
    }
    </style>
</head>
<body>

	<% String name = null;
		int ID = (Integer) request.getAttribute("ID");
		name = (String) request.getAttribute("username");
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
	<b><center>Welcome ${uname} </center></b>

	<%
	if (name != null) {
	%>
	<div class="text-center fs-4"
		style="font-size: 18px; margin-top: 20px;">Welcome ${uname} In Utensils Shop</div>
	<%
	}
	%>

	<%
	try {
		Configuration cfg = new Configuration().configure().addAnnotatedClass(product.class);
		cfg.configure("hibernate.cfg.xml");
		SessionFactory factory = cfg.buildSessionFactory();
		Session Session = factory.openSession();

		java.util.List li = Session.createQuery("from product").list();
		java.util.Iterator it = li.iterator();
		int col = 0;
		while (it.hasNext()) {
			Object o = (Object) it.next();
			product rs = (product) o;
			col++;
			if (col % 3 == 1) {
	%>
	<div class="container" style="margin-top: 25px;">
		<div class="row">

			<%
			}
			%>


			<div class="col-sm-4 col-lg-4 col-md-4 card-group ">
				<div class="card" style="width: 18rem;">
					<img src="<%out.print(rs.getPimage());%>" class="card-img-top" style="">
					<div class="card-body">
						<h5 class="card-title"><%out.print(rs.getPname());%></h5>
						<p class="card-text">Price :<%out.print(rs.getPrice());%></p>
					</div>
					<ul class="list-group list-group-flush">
						<li class="list-group-item">Available Quantity : <%out.print(rs.getQuantity());%></li>
						<li class="list-group-item">Category : <%out.print(rs.getCategory());%></li>
						<li class="list-group-item">Type : <%out.print(rs.getType());%></li>
					</ul>
					<form action="AddToCart" method="get">
					<input type="hidden" name='pid' value="<% out.print(rs.getPid()); %> "  >
					<input type="hidden" name='ID' value="${ID}">
					<input type="hidden" name='pname' value="<%out.print(rs.getPname());%>">
					<input type="hidden" name='price' value="<%out.print(rs.getPrice());%>">
					<input type="hidden" name='category' value="<%out.print(rs.getCategory());%>">
					<input type="hidden" name='type' value="<%out.print(rs.getType());%>">
					<div class="card-body">
					    <input type="text" name="quantity" placeholder="Quantity">
					    <input type="submit" class="btn btn-xs btn-primary" name="submit" value="Add To Cart" >
					</div>
					</form>

				</div>
			</div>



			<%
			if (col % 3 == 0) {
			%>
		</div>
	</div>
	<%
	}
	}
	Session.close();
	factory.close();
	} catch (Exception ex) {
	System.out.println(ex);
	}
	%>


	<br>
	<br>
	<br>

</body>
</html>