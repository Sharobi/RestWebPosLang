package com.sharobi.webpos.inv.model;

import java.util.List;

public class InventoryStockIn {
	private int id;
	private String date;
	private String userId;
	private int storeId;
	private double totalQuantity;
	private double totalPrice;
	private double miscCharge;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String closed;
	private int vendorId;
	private String vendorName;
	private String billNo;
	private String billDate;
	private int edpId;
	private List<InventoryStockInItem> inventoryStockInItems;

	private double totGrossAmt;
	//newly added for accounting 26.04.2018

	private int poId;
	private double itemTotal;
	private double discPer;
	private double discAmt;
	private double taxAmt;
	private Double roundOffAmt;

	/*
	 * account
	 */
	private int duties_ledger_id;
	private int round_ledger_id;
	private int purchase_ledger_id;
	private int discount_ledger_id;
	private int credior_ledger_id;
	private int missllenous_ledger_id;
	private String qs;
    private String is_account;

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

	public double getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(double totalQuantity) {
		this.totalQuantity = totalQuantity;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public double getMiscCharge() {
		return miscCharge;
	}

	public void setMiscCharge(double miscCharge) {
		this.miscCharge = miscCharge;
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

	public String getClosed() {
		return closed;
	}

	public void setClosed(String closed) {
		this.closed = closed;
	}

	public int getVendorId() {
		return vendorId;
	}

	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public List<InventoryStockInItem> getInventoryStockInItems() {
		return inventoryStockInItems;
	}

	public void setInventoryStockInItems(List<InventoryStockInItem> inventoryStockInItems) {
		this.inventoryStockInItems = inventoryStockInItems;
	}



	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	public int getEdpId() {
		return edpId;
	}

	public void setEdpId(int edpId) {
		this.edpId = edpId;
	}

	public int getPoId() {
		return poId;
	}

	public void setPoId(int poId) {
		this.poId = poId;
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


	public int getDuties_ledger_id() {
		return duties_ledger_id;
	}

	public void setDuties_ledger_id(int duties_ledger_id) {
		this.duties_ledger_id = duties_ledger_id;
	}

	public int getRound_ledger_id() {
		return round_ledger_id;
	}

	public void setRound_ledger_id(int round_ledger_id) {
		this.round_ledger_id = round_ledger_id;
	}

	public int getPurchase_ledger_id() {
		return purchase_ledger_id;
	}

	public void setPurchase_ledger_id(int purchase_ledger_id) {
		this.purchase_ledger_id = purchase_ledger_id;
	}

	public int getDiscount_ledger_id() {
		return discount_ledger_id;
	}

	public void setDiscount_ledger_id(int discount_ledger_id) {
		this.discount_ledger_id = discount_ledger_id;
	}

	public int getCredior_ledger_id() {
		return credior_ledger_id;
	}

	public void setCredior_ledger_id(int credior_ledger_id) {
		this.credior_ledger_id = credior_ledger_id;
	}

	public int getMissllenous_ledger_id() {
		return missllenous_ledger_id;
	}

	public void setMissllenous_ledger_id(int missllenous_ledger_id) {
		this.missllenous_ledger_id = missllenous_ledger_id;
	}



	public String getQs() {
		return qs;
	}

	public void setQs(String qs) {
		this.qs = qs;
	}


	public String getIs_account() {
		return is_account;
	}

	public void setIs_account(String is_account) {
		this.is_account = is_account;
	}


	public double getTotGrossAmt() {
		return totGrossAmt;
	}

	public void setTotGrossAmt(double totGrossAmt) {
		this.totGrossAmt = totGrossAmt;
	}

	@Override
	public String toString() {
		return "InventoryStockIn [id=" + id + ", date=" + date + ", userId=" + userId + ", storeId=" + storeId
				+ ", totalQuantity=" + totalQuantity + ", totalPrice=" + totalPrice + ", miscCharge=" + miscCharge
				+ ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate
				+ ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", closed=" + closed + ", vendorId="
				+ vendorId + ", vendorName=" + vendorName + ", billNo=" + billNo + ", billDate=" + billDate + ", edpId="
				+ edpId + ", inventoryStockInItems=" + inventoryStockInItems + ", totGrossAmt=" + totGrossAmt
				+ ", poId=" + poId + ", itemTotal=" + itemTotal + ", discPer=" + discPer + ", discAmt=" + discAmt
				+ ", taxAmt=" + taxAmt + ", roundOffAmt=" + roundOffAmt + ", duties_ledger_id=" + duties_ledger_id
				+ ", round_ledger_id=" + round_ledger_id + ", purchase_ledger_id=" + purchase_ledger_id
				+ ", discount_ledger_id=" + discount_ledger_id + ", credior_ledger_id=" + credior_ledger_id
				+ ", missllenous_ledger_id=" + missllenous_ledger_id + ", qs=" + qs + ", is_account=" + is_account
				+ "]";
	}









}
