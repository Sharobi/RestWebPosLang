package com.sharobi.webpos.adm.model;

public class OrderDeliveryBoy {

	private static final long serialVersionUID = 1L;
	private int id;
	private int orderId;
	private String deliveryPersonName;
	private String store_id;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getDeliveryPersonName() {
		return deliveryPersonName;
	}
	public void setDeliveryPersonName(String deliveryPersonName) {
		this.deliveryPersonName = deliveryPersonName;
	}
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	@Override
	public String toString() {
		return "OrderDeliveryBoy [id=" + id + ", orderId=" + orderId
				+ ", deliveryPersonName=" + deliveryPersonName + ", store_id="
				+ store_id + "]";
	}

	
}
