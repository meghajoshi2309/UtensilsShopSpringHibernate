package productpk;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;




@Table(name="orderitem")
@Entity (name="OrderItem")
public class OrderItem {
	
	@Id
	private int o_no;
	private int ID,pid,price,quantity,flag;
	private String pname;
	private Date date;
	private java.sql.Timestamp time;
	public java.sql.Timestamp getTime() {
		return time;
	}
	public void setTime(java.sql.Timestamp sqlTime) {
		this.time = sqlTime;
	}
	public int getO_no() {
		return o_no;
	}
	public void setO_no(int o_no) {
		this.o_no = o_no;
	}
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getPrice() {
		return price;
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
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	@Override
	public String toString() {
		return "OrderItem [o_no=" + o_no + ", ID=" + ID + ", pid=" + pid + ", price=" + price + ", quantity=" + quantity
				+ ", flag=" + flag + ", pname=" + pname + ", date=" + date + ", time=" + time + "]";
	}
	
	
	

}
