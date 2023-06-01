package utensils;


import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import productpk.Cart;
import productpk.OrderItem;
import productpk.product;




@Controller
public class adduserController {
	
		@RequestMapping("/adduser")
		public ModelAndView adduser(@RequestParam("username") String username,@RequestParam("email") String email,@RequestParam("phone") int phone,@RequestParam("address") String address,@RequestParam("gender") String gender,@RequestParam("password") String password,@RequestParam("cpassword") String cpassword) 
		{
		
			ModelAndView mv = new ModelAndView();
			if(password.equals(cpassword))                               
			{
				Register c = new Register();
				c.setUsername(username);
				c.setEmail(email);
				c.setPhone(phone);
				c.setAddress(address);
				c.setGender(gender);
				c.setPassword(password);
				
				Configuration con = new Configuration().configure().addAnnotatedClass(Register.class);
				SessionFactory sf = con.buildSessionFactory();
				Session session = sf.openSession();
				Transaction tx = (Transaction) session.beginTransaction();
				session.save(c);
				tx.commit();
								
				String msg = "You Registered Successfully!";
				mv.setViewName("index.jsp");
				mv.addObject("msg",msg);
				
			}
			else {
				String msg = "Confirm Password And Password Are Not Same !";
				mv.setViewName("Register.jsp");
				mv.addObject("msg",msg);
			}
			
			return mv;
		}
		
		
		
		
		@RequestMapping("/verifyUser")
		public ModelAndView verifyUser(@RequestParam("email") String email,@RequestParam("password") String password) 
		{
			ModelAndView mv = new ModelAndView();
			
			int flag=0;
			try {
				
				Configuration cfg1 = new Configuration().configure().addAnnotatedClass(Admin.class);			
				cfg1.configure("hibernate.cfg.xml");
				SessionFactory factory1 = cfg1.buildSessionFactory();
				Session session1=factory1.openSession();
				
				java.util.List li1 = session1.createQuery("from Admin where aemail='" + email + "' and apassword='" + password + "'" ).list();
				java.util.Iterator it1 = li1.iterator();
				Admin r1 = null;
				while(it1.hasNext()) {
					Object o1 = (Object)it1.next();
					r1 = (Admin)o1;
					flag++;
				}
				session1.close();
				factory1.close();
				
				if(flag==1)
				{
					mv.setViewName("Admin.jsp");
					mv.addObject("aname",r1.getAname());
					mv.addObject("aid",r1.getAid());
				}
				else 
				{
					Configuration cfg = new Configuration().configure().addAnnotatedClass(Register.class);			
					cfg.configure("hibernate.cfg.xml");
					SessionFactory factory = cfg.buildSessionFactory();
					Session session=factory.openSession();
					
					java.util.List li = session.createQuery("from Register where email='" + email + "' and password='" + password + "'" ).list();
					java.util.Iterator it=li.iterator();
					Register r = null;
					while(it.hasNext()) {
						Object o = (Object)it.next();
						r = (Register)o;
						flag++;
					}
					session.close();
					factory.close();
					
					
					if(flag==1)
					{
						mv.setViewName("Home.jsp");
						mv.addObject("uname",r.getUsername());
						mv.addObject("ID",r.getID());
						
					}
					else {
						String msg = "Email Or Password Incorrect!";
						mv.setViewName("index.jsp");
						mv.addObject("msg",msg);
						
					}
				}
								
			}
			catch(Exception ex) {
				System.out.println(ex);	
			}
			return mv;
			
		}
		
		
		@RequestMapping("/addProduct")
		public ModelAndView addProduct(@RequestParam("pname") String pname,@RequestParam("price") int price,@RequestParam("quantity") int quantity,@RequestParam("category") String category,@RequestParam("type") String type,@RequestParam("pimage") String pimage) 
		{
		
			ModelAndView mv = new ModelAndView();
			try {
				product p = new product();			
					
					p.setPname(pname);
					p.setPimage(pimage);
					p.setPrice(price);
					p.setQuantity(quantity);
					p.setCategory(category);
					p.setType(type);
					
					
					Configuration con = new Configuration().configure().addAnnotatedClass(product.class);
					SessionFactory sf = con.buildSessionFactory();
					Session session = sf.openSession();
					Transaction tx = (Transaction) session.beginTransaction();
					session.save(p);
					tx.commit();
									
					String msg = "Product Added Successfully!";
					mv.setViewName("AddProduct.jsp");
					mv.addObject("msg",msg);
					
			}
			catch(Exception ex) {
				System.out.println(ex);	
			}
				
				return mv;
		}
		
		
		@RequestMapping(value = "/MyProfile", method = RequestMethod.GET)
		public ModelAndView idFormyProfile(HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			int ID = Integer.parseInt(request.getParameter("ID"));
			mv.addObject("ID", ID);
			mv.setViewName("MyProfile.jsp");
			return mv ;
		}
		
		@RequestMapping(value = "/EditProfile", method = RequestMethod.GET)
		public ModelAndView idForeditProfile(HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			int ID = Integer.parseInt(request.getParameter("ID"));
			mv.addObject("ID", ID);
			mv.setViewName("EditProfile.jsp");
			return mv ;
		}
		
		@RequestMapping("EditData")
		public ModelAndView EditData(@RequestParam("ID") int ID,@RequestParam("username") String username, @RequestParam("email") String email,
				@RequestParam("phone") int phone , @RequestParam("address") String address, @RequestParam("gender") String gender ) {
			
			
			ModelAndView mv = new ModelAndView();
			
			Configuration cfg = new Configuration().configure().addAnnotatedClass(Register.class);			
			cfg.configure("hibernate.cfg.xml");
			SessionFactory factory = cfg.buildSessionFactory();
			Session Session = factory.openSession();
			Transaction t = Session.beginTransaction();
			
			Register temp = (Register) Session.get(Register.class, ID);
		
				temp.setUsername(username);
				temp.setEmail(email);
				temp.setPhone(phone);
				temp.setAddress(address);
				temp.setGender(gender);
				Session.update(temp);
				
				String Msg=  "Record Updated Successfully.";
				mv.setViewName("MyProfile.jsp");
				mv.addObject("ID",ID);
				mv.addObject("Msg", Msg);
				
					
			t.commit();
			Session.close();
			factory.close();
			
			
			return mv ;
		}
		
		@RequestMapping(value = "/AddToCart", method = RequestMethod.GET)
		public ModelAndView AddToCart(@RequestParam("ID") int ID,@RequestParam("pid") int pid,@RequestParam("pname") String pname,@RequestParam("category") String category,@RequestParam("type") String type,@RequestParam("price") int price,@RequestParam("quantity") int quantity) {
			
			ModelAndView mv = new ModelAndView();
			
			try {
				Cart c = new Cart();			
					
					c.setID(ID);
					c.setPid(pid);
					c.setPname(pname);
					c.setCategory(category);
					c.setType(type);
					c.setPrice(price);
					c.setQuantity(quantity);
					
					
					
					Configuration con = new Configuration().configure().addAnnotatedClass(Cart.class);
					SessionFactory sf = con.buildSessionFactory();
					Session session = sf.openSession();
					Transaction tx = (Transaction) session.beginTransaction();
					session.save(c);
					tx.commit();
									
					String msg = "Product Added Into Cart Successfully!";
					mv.addObject("msg",msg);
					
			}
			catch(Exception ex) {
				System.out.println(ex);	
			}
			
			Configuration cfg = new Configuration().configure().addAnnotatedClass(product.class);			
			cfg.configure("hibernate.cfg.xml");
			SessionFactory factory = cfg.buildSessionFactory();
			Session Session = factory.openSession();
			Transaction t = Session.beginTransaction();
			
			product temp = (product) Session.get(product.class, pid);
				if(temp.getQuantity()<quantity)
				{
					String Msg="Product Is Out Of Stock.";
					mv.addObject("Msg",Msg);
				}
				else
				{
					temp.setQuantity((temp.getQuantity()-quantity));
					Session.update(temp);
				}
							
					
			t.commit();
			Session.close();
			factory.close();
			
			
			System.out.println("hii");
			System.out.println(ID);
			System.out.println(pid);
			mv.addObject("ID", ID);
			mv.addObject("pid", pid);
			mv.setViewName("Cart.jsp");
			return mv ;
		}
			
		@RequestMapping(value = "/VeiwCart", method = RequestMethod.GET)
		public ModelAndView VeiwCart(HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			int ID = Integer.parseInt(request.getParameter("ID"));
			mv.addObject("ID", ID);
			System.out.println("In Veiw Cart.....");
			mv.setViewName("Cart.jsp");
			return mv ;
		}
		
		
		@RequestMapping(value = "/PlaceOrder", method = RequestMethod.GET)
		public ModelAndView PlaceOrder(HttpServletRequest request) {
			System.out.println("hiii...");
			
			int ID = Integer.parseInt(request.getParameter("ID"));
			
			System.out.println("Id is : " + ID);
			
			ModelAndView mv = new ModelAndView();
			
			try {
				Configuration cfg = new Configuration().configure().addAnnotatedClass(Cart.class);
				cfg.configure("hibernate.cfg.xml");
				SessionFactory factory = cfg.buildSessionFactory();
				Session Session = factory.openSession();

				
				java.util.List li = Session.createQuery("from Cart where ID ='" + ID + "'" ).list();
				java.util.Iterator it = li.iterator();
				
				
				int total = 0;
				
				
				while (it.hasNext()) {
					Object o = (Object) it.next();
					Cart rs = (Cart) o;
					
					OrderItem oi = new OrderItem();
					
					
					System.out.println("hiii...");
					
					java.util.Date date=new java.util.Date();
					java.sql.Date sqlDate=new java.sql.Date(date.getTime());
					java.sql.Timestamp sqlTime=new java.sql.Timestamp(date.getTime());
					
					oi.setID(ID);
					oi.setPid(rs.getPid());
					oi.setPname(rs.getPname());
					oi.setPrice(rs.getPrice());
					oi.setQuantity(rs.getQuantity());
					oi.setDate(sqlDate);
					oi.setTime(sqlTime);
					
					Configuration con = new Configuration().configure().addAnnotatedClass(OrderItem.class);
					SessionFactory sf = con.buildSessionFactory();
					Session session = sf.openSession();
					Transaction tx = (Transaction) session.beginTransaction();
					
					session.save(oi);
					
					tx.commit();
										
				}
				
			}
			catch(Exception ex) {
				System.out.println(ex);	
			}
			
			Configuration cfg2 = new Configuration().configure().addAnnotatedClass(Register.class);
			cfg2.configure("hibernate.cfg.xml");
			SessionFactory factory2 = cfg2.buildSessionFactory();
			Session Session2 = factory2.openSession();

			
			java.util.List li2 = Session2.createQuery("from Register where ID ='" + ID + "'" ).list();
			java.util.Iterator it2 = li2.iterator();
			
			while (it2.hasNext()) {
				
				
				Object o2 = (Object) it2.next();
				Register rs2 = (Register) o2;
				
				mv.addObject("email",rs2.getEmail());
				mv.addObject("uname",rs2.getUsername());
				mv.addObject("address",rs2.getAddress());
				mv.addObject("phone",rs2.getPhone());
				
//			
			}
				
			mv.addObject("ID", ID);
			mv.setViewName("Bill.jsp");
			return mv ;
		}

		
		@RequestMapping("UpdateCart")
		public ModelAndView UpdateCart(HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			
			int ID = Integer.parseInt(request.getParameter("ID"));
			
			Configuration cfg = new Configuration().configure().addAnnotatedClass(Cart.class);
			cfg.configure("hibernate.cfg.xml");
			SessionFactory factory = cfg.buildSessionFactory();
			Session Session = factory.openSession();

			
			java.util.List li = Session.createQuery("from Cart where ID ='" + ID + "'" ).list();
			java.util.Iterator it = li.iterator();
			
			while (it.hasNext()) {
				
				Object o = (Object) it.next();
				Cart rs = (Cart) o;
				
				Transaction t = Session.beginTransaction();
				
				rs.setFlag(1);
				
				Session.update(rs);
				
				t.commit();
			}
			
			
			
			Configuration cfg1 = new Configuration().configure().addAnnotatedClass(OrderItem.class);
			cfg1.configure("hibernate.cfg.xml");
			SessionFactory factory1 = cfg1.buildSessionFactory();
			Session Session1 = factory1.openSession();

			
			java.util.List li1 = Session1.createQuery("from OrderItem where ID ='" + ID + "'" ).list();
			java.util.Iterator it1 = li1.iterator();
			
			while (it1.hasNext()) {
				
				System.out.println("OrderItem.....");
				
				Object o1 = (Object) it1.next();
				OrderItem rs1 = (OrderItem) o1;
				
				System.out.println("OrderItem After Create Object.....");
				
				Transaction t1 = Session1.beginTransaction();
				
				System.out.println("OrderItem Transaction start.....");
				
				rs1.setFlag(1);
				
				System.out.println(rs1);
				
				Session1.update(rs1);
				
				t1.commit();
			}
	
			
			mv.addObject("ID", ID);
			mv.setViewName("Home.jsp");
			
			return mv ;
		}
		
		@RequestMapping(value = "/Home", method = RequestMethod.GET)
		public ModelAndView Home(HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			int ID = Integer.parseInt(request.getParameter("ID"));
			mv.addObject("ID", ID);
			mv.setViewName("Home.jsp");
			return mv ;
		}
		
		
		@RequestMapping(value = "/Admin", method = RequestMethod.GET)
		public ModelAndView Admin(HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			int aid = Integer.parseInt(request.getParameter("aid"));
			mv.addObject("aid", aid);
			mv.setViewName("Admin.jsp");
			return mv ;
		}
		
		@RequestMapping(value = "/AdminAddProduct", method = RequestMethod.GET)
		public ModelAndView AdminAddProduct(HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			int aid = Integer.parseInt(request.getParameter("aid"));
			mv.addObject("aid", aid);
			mv.setViewName("AddProduct.jsp");
			return mv ;
		}
		
		@RequestMapping(value = "/AdminVeiwCustomer", method = RequestMethod.GET)
		public ModelAndView AdminVeiwCustome(HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			int aid = Integer.parseInt(request.getParameter("aid"));
			mv.addObject("aid", aid);
			mv.setViewName("VeiwCustomer.jsp");
			return mv ;
		}
		
		@RequestMapping(value = "/AdminInventory", method = RequestMethod.GET)
		public ModelAndView AdminInventory(HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			int aid = Integer.parseInt(request.getParameter("aid"));
			mv.addObject("aid", aid);
			mv.setViewName("Inventory.jsp");
			return mv;
		}
		
		
		
		
		
		
		
		
		
		
		@RequestMapping("/Logout")
		public ModelAndView Logout(HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			mv.setViewName("index.jsp");
			return mv ;
		}



			
}
