package com.sharobi.webpos.roombooking.base.model;

//import com.mysql.jdbc.Blob;
//import com.sun.jersey.multipart.MultiPart;

public class RoomBookingCustomer {
	
	private int id;
	private String name;
	private String address;
	private String phone;
	private String email;
	private String gender;
	private String store_id;
	private String dob;
	private String deleteflag;
	private String location;
	private String houseno;
	private String street;
	private String state;
	
	//private IdentityFile identity;
	 private int uniqueidType;
     private String uniqueidNo;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getDeleteflag() {
		return deleteflag;
	}
	public void setDeleteflag(String deleteflag) {
		this.deleteflag = deleteflag;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getHouseno() {
		return houseno;
	}
	public void setHouseno(String houseno) {
		this.houseno = houseno;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}	
    
	public int getUniqueidType() {
		return uniqueidType;
	}
	public void setUniqueidType(int uniqueidType) {
		this.uniqueidType = uniqueidType;
	}
	public String getUniqueidNo() {
		return uniqueidNo;
	}
	public void setUniqueidNo(String uniqueidNo) {
		this.uniqueidNo = uniqueidNo;
	}
	//	public IdentityFile getIdentity() {
//		return identity;
//	}
//	public void setIdentity(IdentityFile identity) {
//		this.identity = identity;
//	}
	@Override
	public String toString() {
		return "RoomBookingCustomer [id=" + id + ", name=" + name + ", address=" + address + ", phone=" + phone
				+ ", email=" + email + ", gender=" + gender + ", store_id=" + store_id + ", dob=" + dob
				+ ", deleteflag=" + deleteflag + ", location=" + location + ", houseno=" + houseno + ", street="
				+ street + ", state=" + state + ", uniqueidType=" + uniqueidType + ", uniqueidNo=" + uniqueidNo + "]";
	}
	
	
	

}
