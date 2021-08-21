package com.sharobi.webpos.bi.model;

public class BiModel {

	private String itemName;
	private double itemPrice;
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public double getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(double itemPrice) {
		this.itemPrice = itemPrice;
	}
	@Override
	public String toString() {
		return "BiModel [itemName=" + itemName + ", itemPrice=" + itemPrice
				+ "]";
	}
	
	
	
}
