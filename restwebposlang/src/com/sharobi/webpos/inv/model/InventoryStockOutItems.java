package com.sharobi.webpos.inv.model;

public class InventoryStockOutItems {
	private int id;
	private double itemQuantity;
	private int storeId;
	private double totalPrice;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String time;
	private String toWhom;
	private String approveFlag = "N";
	private InventoryStockOut inventoryStockOut;
	private InventoryItems inventoryItems;
	private int unitId;
	private String unitName;
	private MetricUnit unit;
	private int itemQty;
	private double currentStockOutQuantityEdpWise;
	private double edpQuantity;
	private double currentStock;
	
	private Double itemRate;
	private Double itemTotalPrice;
	private double discPer;
	private double discAmt;
	private String isTaxExclusive="Y";
	private Double taxRate;
	private Double taxAmount;
	private Double itemNetAmount;


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(double itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public double getTotalPrice() {
		double itemRate = getInventoryItems().getRate();
		double qty = getItemQuantity();
		totalPrice = itemRate * qty;
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
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

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getApproveFlag() {
		return approveFlag;
	}

	public void setApproveFlag(String approveFlag) {
		this.approveFlag = approveFlag;
	}

	public String getToWhom() {
		return toWhom;
	}

	public void setToWhom(String toWhom) {
		this.toWhom = toWhom;
	}

	public InventoryStockOut getInventoryStockOut() {
		return inventoryStockOut;
	}

	public void setInventoryStockOut(InventoryStockOut inventoryStockOut) {
		this.inventoryStockOut = inventoryStockOut;
	}

	public InventoryItems getInventoryItems() {
		return inventoryItems;
	}

	public void setInventoryItems(InventoryItems inventoryItems) {
		this.inventoryItems = inventoryItems;
	}
	
	public MetricUnit getUnit() {
		return unit;
	}

	public void setUnit(MetricUnit unit) {
		this.unit = unit;
	}
	
	public int getUnitId() {
		return unitId;
	}

	public void setUnitId(int unitId) {
		this.unitId = unitId;
	}

	
	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	

	public int getItemQty() {
		return itemQty;
	}

	public void setItemQty(int itemQty) {
		this.itemQty = itemQty;
	}

	public double getCurrentStockOutQuantityEdpWise() {
		return currentStockOutQuantityEdpWise;
	}

	public void setCurrentStockOutQuantityEdpWise(double currentStockOutQuantityEdpWise) {
		this.currentStockOutQuantityEdpWise = currentStockOutQuantityEdpWise;
	}

	public double getEdpQuantity() {
		return edpQuantity;
	}

	public void setEdpQuantity(double edpQuantity) {
		this.edpQuantity = edpQuantity;
	}
	
	public double getCurrentStock() {
		return currentStock;
	}

	public void setCurrentStock(double currentStock) {
		this.currentStock = currentStock;
	}

	public Double getItemRate() {
    return itemRate;
  }

  public void setItemRate(Double itemRate) {
    this.itemRate = itemRate;
  }

  public Double getItemTotalPrice() {
    return itemTotalPrice;
  }

  public void setItemTotalPrice(Double itemTotalPrice) {
    this.itemTotalPrice = itemTotalPrice;
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

  public String getIsTaxExclusive() {
    return isTaxExclusive;
  }

  public void setIsTaxExclusive(String isTaxExclusive) {
    this.isTaxExclusive = isTaxExclusive;
  }

  public Double getTaxRate() {
    return taxRate;
  }

  public void setTaxRate(Double taxRate) {
    this.taxRate = taxRate;
  }

  public Double getTaxAmount() {
    return taxAmount;
  }

  public void setTaxAmount(Double taxAmount) {
    this.taxAmount = taxAmount;
  }

  public Double getItemNetAmount() {
    return itemNetAmount;
  }

  public void setItemNetAmount(Double itemNetAmount) {
    this.itemNetAmount = itemNetAmount;
  }

  @Override
  public String toString() {
    return "InventoryStockOutItems [id=" + id + ", itemQuantity=" + itemQuantity + ", storeId=" + storeId
        + ", totalPrice=" + totalPrice + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate="
        + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", time=" + time + ", toWhom="
        + toWhom + ", approveFlag=" + approveFlag + ", inventoryStockOut=" + inventoryStockOut + ", inventoryItems="
        + inventoryItems + ", unitId=" + unitId + ", unitName=" + unitName + ", unit=" + unit + ", itemQty=" + itemQty
        + ", currentStockOutQuantityEdpWise=" + currentStockOutQuantityEdpWise + ", edpQuantity=" + edpQuantity
        + ", currentStock=" + currentStock + ", itemRate=" + itemRate + ", itemTotalPrice=" + itemTotalPrice
        + ", discPer=" + discPer + ", discAmt=" + discAmt + ", isTaxExclusive=" + isTaxExclusive + ", taxRate="
        + taxRate + ", taxAmount=" + taxAmount + ", itemNetAmount=" + itemNetAmount + "]";
  }

  
}
