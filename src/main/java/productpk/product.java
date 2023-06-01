package productpk;

import javax.persistence.Entity;
import javax.persistence.Id;

import com.mysql.cj.jdbc.Blob;



@Entity
public class product {
	
	@Id
	private int pid;
	private String pname;
	private String pimage;
	private int price;
	private int quantity;
	private String category;   //Kitchen Or Office
	private String type;          // Steal,clay
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getPrice() {
		return price;
	}
	
	public String getPimage() {
		return pimage;
	}
	public void setPimage(String pimage) {
		this.pimage = pimage;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public String getCatagory() {
		return category;
	}
	public void setCatagory(String catagory) {
		this.category = catagory;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "product [pid=" + pid + ", pname=" + pname + ", price=" + price + ", quantity=" + quantity + "]";
	}
	
	

}
