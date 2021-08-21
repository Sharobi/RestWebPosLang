package com.sharobi.webpos.roombooking.adm.model;

public class Country {
	private static final long serialVersionUID = 1L;

	private int id;
	private String countryname;
	private String courency;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCountryname() {
		return countryname;
	}
	public void setCountryname(String countryname) {
		this.countryname = countryname;
	}
	public String getCourency() {
		return courency;
	}
	public void setCourency(String courency) {
		this.courency = courency;
	}
	@Override
	public String toString() {
		return "Country [id=" + id + ", countryname=" + countryname
				+ ", courency=" + courency + "]";
	}
}
