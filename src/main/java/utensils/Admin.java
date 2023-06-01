package utensils;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Admin {
	
	@Id
	private int aid;
	private String aname;
	private String aemail;
	private String apassword;
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getAname() {
		return aname;
	}
	public void setAname(String aname) {
		this.aname = aname;
	}
	public String getAemail() {
		return aemail;
	}
	public void setAemail(String aemail) {
		this.aemail = aemail;
	}
	public String getApassword() {
		return apassword;
	}
	public void setApassword(String apassword) {
		this.apassword = apassword;
	}
	@Override
	public String toString() {
		return "Addmin [aid=" + aid + ", aname=" + aname + ", aemail=" + aemail + ", apassword=" + apassword + "]";
	}
	
	

}
