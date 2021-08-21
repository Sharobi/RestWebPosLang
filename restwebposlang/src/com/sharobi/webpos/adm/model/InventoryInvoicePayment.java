/**
 *
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class InventoryInvoicePayment implements Serializable{

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int poId;
	private int stockInId;
	private String stockInDate;
	private int vendorId;
    private int storeId;
    private double billAmount;
    private double paidAmount;
    private double amountToPay;
    private double creditLimit;
    private String deleteFlag;
    private String createdBy;
    private String createdDate;
    private String updatedBy;
    private String updatedDate;
    private double returnAmount;

    private int cr_legder_id;
    private int dr_legder_id;

    private String qs;
	private double cr_amount;
	private double dr_amount;
	 private String is_account;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPoId() {
		return poId;
	}
	public void setPoId(int poId) {
		this.poId = poId;
	}
	public int getStockInId() {
		return stockInId;
	}
	public void setStockInId(int stockInId) {
		this.stockInId = stockInId;
	}

	public String getStockInDate() {
		return stockInDate;
	}
	public void setStockInDate(String stockInDate) {
		this.stockInDate = stockInDate;
	}
	public int getVendorId() {
		return vendorId;
	}
	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public double getBillAmount() {
		return billAmount;
	}
	public void setBillAmount(double billAmount) {
		this.billAmount = billAmount;
	}
	public double getPaidAmount() {
		return paidAmount;
	}
	public void setPaidAmount(double paidAmount) {
		this.paidAmount = paidAmount;
	}
	public double getAmountToPay() {
		return amountToPay;
	}
	public void setAmountToPay(double amountToPay) {
		this.amountToPay = amountToPay;
	}
	public double getCreditLimit() {
		return creditLimit;
	}
	public void setCreditLimit(double creditLimit) {
		this.creditLimit = creditLimit;
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

	public double getReturnAmount() {
		return returnAmount;
	}
	public void setReturnAmount(double returnAmount) {
		this.returnAmount = returnAmount;
	}

	public int getCr_legder_id() {
		return cr_legder_id;
	}
	public void setCr_legder_id(int cr_legder_id) {
		this.cr_legder_id = cr_legder_id;
	}
	public int getDr_legder_id() {
		return dr_legder_id;
	}
	public void setDr_legder_id(int dr_legder_id) {
		this.dr_legder_id = dr_legder_id;
	}


	public String getQs() {
		return qs;
	}
	public void setQs(String qs) {
		this.qs = qs;
	}
	public double getCr_amount() {
		return cr_amount;
	}
	public void setCr_amount(double cr_amount) {
		this.cr_amount = cr_amount;
	}
	public double getDr_amount() {
		return dr_amount;
	}
	public void setDr_amount(double dr_amount) {
		this.dr_amount = dr_amount;
	}



	public String getIs_account() {
		return is_account;
	}
	public void setIs_account(String is_account) {
		this.is_account = is_account;
	}
	@Override
	public String toString() {
		return "InventoryInvoicePayment [id=" + id + ", poId=" + poId + ", stockInId=" + stockInId + ", stockInDate="
				+ stockInDate + ", vendorId=" + vendorId + ", storeId=" + storeId + ", billAmount=" + billAmount
				+ ", paidAmount=" + paidAmount + ", amountToPay=" + amountToPay + ", creditLimit=" + creditLimit
				+ ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate
				+ ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", returnAmount=" + returnAmount
				+ ", cr_legder_id=" + cr_legder_id + ", dr_legder_id=" + dr_legder_id + ", qs=" + qs + ", cr_amount="
				+ cr_amount + ", dr_amount=" + dr_amount + ", is_account=" + is_account + "]";
	}

}
