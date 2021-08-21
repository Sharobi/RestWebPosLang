package com.sharobi.webpos.roombooking.adm.model;

public class TaxForRoomBook {
	private static final long serialVersionUID = 1L;

	private int id;
	private String name;
	private String hotelId;
	private double percentage;
	private String effective_Date;
	private Country country;
	private String isActive;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getHotelId() {
		return hotelId;
	}
	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}
	public double getPercentage() {
		return percentage;
	}
	public void setPercentage(double percentage) {
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
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
	@Override
	public String toString() {
		return "TaxForRoomBook [id=" + id + ", name=" + name + ", hotelId="
				+ hotelId + ", percentage=" + percentage + ", effective_Date="
				+ effective_Date + ", country=" + country + ", isActive="
				+ isActive + "]";
	}
		
}
