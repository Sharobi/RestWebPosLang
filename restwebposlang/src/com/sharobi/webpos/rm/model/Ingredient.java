package com.sharobi.webpos.rm.model;

import java.io.Serializable;

import com.sharobi.webpos.base.model.MenuItem;
import com.sharobi.webpos.inv.model.InventoryItems;



public class Ingredient implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int storeId;
	private MenuItem item;
	private InventoryItems inventoryItem;
	private Double cookingAmount;
	private MetricUnit cookingUnit;
	private Double metricAmount;
	private MetricUnit metricUnit;
	private Double costAmount;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private double totalQuantity;
	private double currentQuantity;// stock in quantity
	private double currentQuantityEdpWise;
	private double edpQuantity; // name changed
    private double currentStockInQuantityEdpWise; // stock in quantity edp wise //name changed
    private double currentStockOutQuantityEdpWise;
    private int poId;          //newly added        - before saving Raw stock In items.
	private int vendorId;      //newly added        - before saving Raw stock In items.

	public double getEdpQuantity() {
		return edpQuantity;
	}

	public void setEdpQuantity(double edpQuantity) {
		this.edpQuantity = edpQuantity;
	}

	public double getCurrentStockInQuantityEdpWise() {
		return currentStockInQuantityEdpWise;
	}

	public void setCurrentStockInQuantityEdpWise(double currentStockInQuantityEdpWise) {
		this.currentStockInQuantityEdpWise = currentStockInQuantityEdpWise;
	}

	public double getCurrentStockOutQuantityEdpWise() {
		return currentStockOutQuantityEdpWise;
	}

	public void setCurrentStockOutQuantityEdpWise(double currentStockOutQuantityEdpWise) {
		this.currentStockOutQuantityEdpWise = currentStockOutQuantityEdpWise;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public MenuItem getItem() {
		return item;
	}

	public void setItem(MenuItem item) {
		this.item = item;
	}

	public InventoryItems getInventoryItem() {
		return inventoryItem;
	}

	public void setInventoryItem(InventoryItems inventoryItem) {
		this.inventoryItem = inventoryItem;
	}

	public Double getCookingAmount() {
		return cookingAmount;
	}

	public void setCookingAmount(Double cookingAmount) {
		this.cookingAmount = cookingAmount;
	}

	
	public MetricUnit getCookingUnit() {
		return cookingUnit;
	}

	public void setCookingUnit(MetricUnit cookingUnit) {
		this.cookingUnit = cookingUnit;
	}

	public Double getMetricAmount() {
		return metricAmount;
	}

	public void setMetricAmount(Double metricAmount) {
		this.metricAmount = metricAmount;
	}

	public MetricUnit getMetricUnit() {
		return metricUnit;
	}

	public void setMetricUnit(MetricUnit metricUnit) {
		this.metricUnit = metricUnit;
	}

	public Double getCostAmount() {
		return costAmount;
	}

	public void setCostAmount(Double costAmount) {
		this.costAmount = costAmount;
	}

	public double getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(double totalQuantity) {
		this.totalQuantity = totalQuantity;
	}

	public double getCurrentQuantity() {
		return currentQuantity;
	}

	public void setCurrentQuantity(double currentQuantity) {
		this.currentQuantity = currentQuantity;
	}

	public double getCurrentQuantityEdpWise() {
		return currentQuantityEdpWise;
	}

	public void setCurrentQuantityEdpWise(double currentQuantityEdpWise) {
		this.currentQuantityEdpWise = currentQuantityEdpWise;
	}
	
	public int getPoId() {
		return poId;
	}

	public void setPoId(int poId) {
		this.poId = poId;
	}

	public int getVendorId() {
		return vendorId;
	}

	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}

	@Override
	public String toString() {
		return "Ingredient [id=" + id + ", storeId=" + storeId + ", item=" + item + ", inventoryItem=" + inventoryItem + ", cookingAmount=" + cookingAmount + ", cookingUnit=" + cookingUnit + ", metricAmount=" + metricAmount + ", metricUnit=" + metricUnit + ", costAmount=" + costAmount + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", totalQuantity=" + totalQuantity + ", currentQuantity=" + currentQuantity + ", currentQuantityEdpWise=" + currentQuantityEdpWise + ", edpQuantity=" + edpQuantity + ", currentStockInQuantityEdpWise=" + currentStockInQuantityEdpWise + ", currentStockOutQuantityEdpWise=" + currentStockOutQuantityEdpWise + ", poId=" + poId + ", vendorId=" + vendorId + "]";
	}
	
}