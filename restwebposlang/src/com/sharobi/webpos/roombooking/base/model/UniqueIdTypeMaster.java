package com.sharobi.webpos.roombooking.base.model;

import java.io.Serializable;

public class UniqueIdTypeMaster implements Serializable {
	 private static final long serialVersionUID = 1L;
	 
	 private int id;
     private String name;
     private String storeId;
     private String deleteFlag;
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
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	@Override
	public String toString() {
		return "UniqueIdTypeMaster [id=" + id + ", name=" + name + ", storeId=" + storeId + ", deleteFlag=" + deleteFlag
				+ "]";
	}
     
     
     
     
     

}
