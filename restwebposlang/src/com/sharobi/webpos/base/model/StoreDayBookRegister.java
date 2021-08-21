package com.sharobi.webpos.base.model;

import java.io.Serializable;
/**
 * @author Manodip
 */

public class StoreDayBookRegister implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private int id;
	private String orderDate;
	private String openTime;
	private int openBy;
	private String closeTime;
	private int closeBy;
	private int storeId;
	private String userText;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getOpenTime() {
		return openTime;
	}

	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	public int getOpenBy() {
		return openBy;
	}

	public void setOpenBy(int openBy) {
		this.openBy = openBy;
	}

	public String getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}

	public int getCloseBy() {
		return closeBy;
	}

	public void setCloseBy(int closeBy) {
		this.closeBy = closeBy;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	
	public String getUserText() {
		return userText;
	}

	public void setUserText(String userText) {
		this.userText = userText;
	}

	@Override
	public String toString() {
		return "StoreDayBookRegister [id=" + id + ", orderDate=" + orderDate + ", openTime=" + openTime + ", openBy=" + openBy + ", closeTime=" + closeTime + ", closeBy=" + closeBy + ", storeId=" + storeId + ", userText=" + userText + "]";
	}

}
