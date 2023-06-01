package utensils;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Register {
	@Id
	private int ID;
	private int phone;
	private String username , email , password , address , gender;
	
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public int getPhone() {
		return phone;
	}
	public void setPhone(int phone) {
		this.phone = phone;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	@Override
	public String toString() {
		return "Register [ID=" + ID + ", phone=" + phone + ", username=" + username + ", email=" + email + ", password="
				+ password + ", address=" + address + ", gender=" + gender + "]";
	}
	
}
