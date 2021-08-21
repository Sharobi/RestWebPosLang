package com.sharobi.webpos.roombooking.adm.model;

import java.io.Serializable;

public class Amenities implements Serializable{
	private static final long serialVersionUID = 1L;

	private int id;
	private String hotelId;
	private String amenities;
	private String flag;
	
	
	
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
	public String getAmenities() {
		return amenities;
	}
	public void setAmenities(String amenities) {
		this.amenities = amenities;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	@Override
	public String toString() {
		return "AmenitiesInfo [id=" + id + ", hotelId=" + hotelId
				+ ", amenities=" + amenities + ", flag=" + flag + "]";
	}
	
	
	
	
	
	
	

}
