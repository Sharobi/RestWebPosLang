package com.sharobi.webpos.roombooking.adm.model;

public class TaxForRoomBookInfo {
	private static final long serialVersionUID = 1L;
	
	private int country;	
	private int id;
	private String name;
	private String hotelId;
	private float percentage;
	private String effective_Date;
	private String isActive;
	public int getCountry() {
		return country;
	}
	public void setCountry(int country) {
		this.country = country;
	}
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
	public String getHotelId() {
		return hotelId;
	}
	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}
	public float getPercentage() {
		return percentage;
	}
	public void setPercentage(float percentage) {
		this.percentage = percentage;
	}
	public String getEffective_Date() {
		return effective_Date;
	}
	public void setEffective_Date(String effective_Date) {
		this.effective_Date = effective_Date;
	}
	public String getIsActive() {
		return isActive;
	}
	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}
	@Override
	public String toString() {
		return "TaxForRoomBookInfo [country=" + country + ", id=" + id
				+ ", name=" + name + ", hotelId=" + hotelId + ", percentage="
				+ percentage + ", effective_Date=" + effective_Date
				+ ", isActive=" + isActive + "]";
	}
	
	
}
