package com.sharobi.webpos.inv.model;

import java.util.List;

public class InventoryStockOut {
	private int id;
	private String date;
	private String time;
	private String userId;
	private int storeId;
	private int edpId;
	private Double totalQuantity;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String approved;
	private String approvedBy;
	private List<InventoryStockOutItems> inventoryStockOutItems;
	private double itemTotal;
	private double discPer;
	private double discAmt;
	private double taxAmt;
	private Double roundOffAmt;
	private double totalPrice;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public String getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}

	public List<InventoryStockOutItems> getInventoryStockOutItemList() {
		return inventoryStockOutItems;
	}

	public void setInventoryStockOutItemList(List<InventoryStockOutItems> inventoryStockOutItems) {
		this.inventoryStockOutItems = inventoryStockOutItems;
	}
	
	public int getEdpId() {
		return edpId;
	}

	public void setEdpId(int edpId) {
		this.edpId = edpId;
	}

	public Double getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(Double totalQuantity) {
		this.totalQuantity = totalQuantity;
	}

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
	}

	public String getApprovedBy() {
		return approvedBy;
	}

	public void setApprovedBy(String approvedBy) {
		this.approvedBy = approvedBy;
	}

	public List<InventoryStockOutItems> getInventoryStockOutItems() {
		return inventoryStockOutItems;
	}

	public void setInventoryStockOutItems(List<InventoryStockOutItems> inventoryStockOutItems) {
		this.inventoryStockOutItems = inventoryStockOutItems;
	}

	public double getItemTotal() {
    return itemTotal;
  }

  public void setItemTotal(double itemTotal) {
    this.itemTotal = itemTotal;
  }

  public double getDiscPer() {
    return discPer;
  }

  public void setDiscPer(double discPer) {
    this.discPer = discPer;
  }

  public double getDiscAmt() {
    return discAmt;
  }

  public void setDiscAmt(double discAmt) {
    this.discAmt = discAmt;
  }

  public double getTaxAmt() {
    return taxAmt;
  }

  public void setTaxAmt(double taxAmt) {
    this.taxAmt = taxAmt;
  }

  public Double getRoundOffAmt() {
    return roundOffAmt;
  }

  public void setRoundOffAmt(Double roundOffAmt) {
    this.roundOffAmt = roundOffAmt;
  }

  public double getTotalPrice() {
    return totalPrice;
  }

  public void setTotalPrice(double totalPrice) {
    this.totalPrice = totalPrice;
  }

  @Override
  public String toString() {
    return "InventoryStockOut [id=" + id + ", date=" + date + ", time=" + time + ", userId=" + userId + ", storeId="
        + storeId + ", edpId=" + edpId + ", totalQuantity=" + totalQuantity + ", deleteFlag=" + deleteFlag
        + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate="
        + updatedDate + ", approved=" + approved + ", approvedBy=" + approvedBy + ", inventoryStockOutItems="
        + inventoryStockOutItems + ", itemTotal=" + itemTotal + ", discPer=" + discPer + ", discAmt=" + discAmt
        + ", taxAmt=" + taxAmt + ", roundOffAmt=" + roundOffAmt + ", totalPrice=" + totalPrice + "]";
  }

  
}
