<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "jakarta.servlet.http.*,jakarta.servlet.*" %>
<%@ page import=" org.hibernate.cfg.Configuration" %>
<%@ page import=" org.hibernate.SessionFactory" %>
<%@ page import="org.springframework.web.servlet.ModelAndView " %>
<%@ page import="org.springframework.stereotype.Controller " %>
<%@ page import="productpk.product" %>
<%@ page import="productpk.OrderItem" %>
<%@ page import="utensils.Register" %>
<%@ page import="org.hibernate.Session " %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer</title>

   <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Utensils</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-light bg-light" style="background: linear-gradient(-135deg, #c850c0, #4158d0)">
        <a class="navbar-brand" href="#">Utensils</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav" >
          <ul class="navbar-nav">
            <li class="nav-item active">
              <a class="nav-link" href="Admin?aid=${aid}">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="AdminAddProduct?aid=${aid}">Add Product</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="AdminInventory?aid=${aid}">Inventory</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="AdminVeiwCustomer?aid=${aid}">Customers</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="Logout">Logout</a>
            </li>
          </ul>
        </div>
      </nav>
      <br>
    
     




<%
try {
	
	Configuration cfg = new Configuration().configure().addAnnotatedClass(Register.class);
	cfg.configure("hibernate.cfg.xml");
	SessionFactory factory = cfg.buildSessionFactory();
	Session Session = factory.openSession();

	
	java.util.List li = Session.createQuery("from Register").list();
	java.util.Iterator it = li.iterator();
	
	
	
	while (it.hasNext()) {
		Object o = (Object) it.next();
		Register rs = (Register) o;
		
	
		
		%>
		
		<br><br>
     <div class="container">
    <table class="table table-striped">
    <thead>
      <tr>
        <th class = "text-center">Customer ID</th>
        <th class = "text-center">Name</th>
      </tr>
    </thead>
    <tbody>
    
    
		
			<tr>
				<td class = "text-center"><% out.print(rs.getID()); %></td>
			    <td class = "text-center"><% out.print(rs.getUsername()); %></td>
			</tr>
			
			
			    <%
					Configuration cfg1 = new Configuration().configure().addAnnotatedClass(OrderItem.class);
					cfg.configure("hibernate.cfg.xml");
					SessionFactory factory1 = cfg1.buildSessionFactory();
					Session Session1 = factory1.openSession();
				
					
					java.util.List li1 = Session1.createQuery("from OrderItem where ID = '" + rs.getID() + "'" ).list();
					java.util.Iterator it1 = li1.iterator();
					
					if(it1.hasNext()){
	
				%>
			
	
			<tr>
				<th class = "text-center">Product ID</th>
		        <th class = "text-center">Product Name</th>
		        <th class = "text-center">Price</th>
		        <th class = "text-center">Quantity</th>
		        <th class = "text-center">Date</th>
			</tr>
			
		
		<%
		
		
	}
		
		while (it1.hasNext()) {
			Object o1 = (Object) it1.next();
			OrderItem rs1 = (OrderItem) o1;
			%>
			   <tr>
			        <td class = "text-center"><% out.print(rs1.getPid()); %></td>
			        <td class = "text-center"><% out.print(rs1.getPname()); %></td>
			        <td class = "text-center"><% out.print(rs1.getPrice()); %></td>
			        <td class = "text-center"><% out.print(rs1.getQuantity()); %></td>
			        <td class = "text-center"><% out.print(rs1.getDate()); %></td>
      		    </tr> 
			
			
			<%
		}
		
		
		
	}
}
	catch (Exception ex) {
		System.out.println(ex);
	}

%>
 	   </tbody>
    </table>
  </div>



</body>
</html>