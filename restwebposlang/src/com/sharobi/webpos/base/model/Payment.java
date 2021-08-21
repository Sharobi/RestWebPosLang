/**
 *
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class Payment implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private double amount;
	private double paidAmount;
	private double amountToPay;
	private double tenderAmount;
	private double changeAmt;
	private String cardLastFourDigits;
	private String remarks;
	private String paymentMode;
	private int storeId;
	private String source;
	private String createdBy;
	private String creationDate;
	private Order orderPayment;
	private Double customerDiscount;
	private Double discountPercentage;
	private Double tipsAmount; // new added 27th June 2018

	// for accounts

	private double cr_amount;
	private double dr_amount;
	private int cr_legder_id;
	private int dr_legder_id;

	private String qs;
	private int duties_ledger_id;
	private int round_ledger_id;
	private int sale_ledger_id;
	private int discount_ledger_id;
	private int debitor_ledger_id;
	private int debitor_cash_ledger_id;
	private int card_ledger_id;
	private String is_account;
	private int service_charge_ledger_id;
	private double grossAmt;
	private double discAmt;
	private double taxVatAmt;
	private double serviceChargeAmt;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
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

	public double getTenderAmount() {
		return tenderAmount;
	}

	public void setTenderAmount(double tenderAmount) {
		this.tenderAmount = tenderAmount;
	}

	public double getChangeAmt() {
		return changeAmt;
	}

	public void setChangeAmt(double changeAmt) {
		this.changeAmt = changeAmt;
	}

	public String getCardLastFourDigits() {
		return cardLastFourDigits;
	}

	public void setCardLastFourDigits(String cardLastFourDigits) {
		this.cardLastFourDigits = cardLastFourDigits;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}

	public Order getOrderPayment() {
		return orderPayment;
	}

	public void setOrderPayment(Order orderPayment) {
		this.orderPayment = orderPayment;
	}

	public Double getCustomerDiscount() {
		return customerDiscount;
	}

	public void setCustomerDiscount(Double customerDiscount) {
		this.customerDiscount = customerDiscount;
	}

	public Double getDiscountPercentage() {
		return discountPercentage;
	}

	public void setDiscountPercentage(Double discountPercentage) {
		this.discountPercentage = discountPercentage;
	}

	public Double getTipsAmount() {
		return tipsAmount;
	}

	public void setTipsAmount(Double tipsAmount) {
		this.tipsAmount = tipsAmount;
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

	public int getSale_ledger_id() {
		return sale_ledger_id;
	}

	public void setSale_ledger_id(int sale_ledger_id) {
		this.sale_ledger_id = sale_ledger_id;
	}

	public int getDiscount_ledger_id() {
		return discount_ledger_id;
	}

	public void setDiscount_ledger_id(int discount_ledger_id) {
		this.discount_ledger_id = discount_ledger_id;
	}

	public int getDebitor_ledger_id() {
		return debitor_ledger_id;
	}

	public void setDebitor_ledger_id(int debitor_ledger_id) {
		this.debitor_ledger_id = debitor_ledger_id;
	}

	public int getDebitor_cash_ledger_id() {
		return debitor_cash_ledger_id;
	}

	public void setDebitor_cash_ledger_id(int debitor_cash_ledger_id) {
		this.debitor_cash_ledger_id = debitor_cash_ledger_id;
	}

	public int getCard_ledger_id() {
		return card_ledger_id;
	}

	public void setCard_ledger_id(int card_ledger_id) {
		this.card_ledger_id = card_ledger_id;
	}

	public String getIs_account() {
		return is_account;
	}

	public void setIs_account(String is_account) {
		this.is_account = is_account;
	}

	public String getQs() {
		return qs;
	}

	public void setQs(String qs) {
		this.qs = qs;
	}

	public double getGrossAmt() {
		return grossAmt;
	}

	public void setGrossAmt(double grossAmt) {
		this.grossAmt = grossAmt;
	}

	public double getDiscAmt() {
		return discAmt;
	}

	public void setDiscAmt(double discAmt) {
		this.discAmt = discAmt;
	}

	public double getTaxVatAmt() {
		return taxVatAmt;
	}

	public void setTaxVatAmt(double taxVatAmt) {
		this.taxVatAmt = taxVatAmt;
	}

	public double getServiceChargeAmt() {
		return serviceChargeAmt;
	}

	public void setServiceChargeAmt(double serviceChargeAmt) {
		this.serviceChargeAmt = serviceChargeAmt;
	}

	public int getService_charge_ledger_id() {
		return service_charge_ledger_id;
	}

	public void setService_charge_ledger_id(int service_charge_ledger_id) {
		this.service_charge_ledger_id = service_charge_ledger_id;
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

	@Override
	public String toString() {
		return "Payment [id=" + id + ", amount=" + amount + ", paidAmount=" + paidAmount + ", amountToPay="
				+ amountToPay + ", tenderAmount=" + tenderAmount + ", changeAmt=" + changeAmt + ", cardLastFourDigits="
				+ cardLastFourDigits + ", remarks=" + remarks + ", paymentMode=" + paymentMode + ", storeId=" + storeId
				+ ", source=" + source + ", createdBy=" + createdBy + ", creationDate=" + creationDate
				+ ", orderPayment=" + orderPayment + ", customerDiscount=" + customerDiscount + ", discountPercentage="
				+ discountPercentage + ", tipsAmount=" + tipsAmount + ", cr_amount=" + cr_amount + ", dr_amount="
				+ dr_amount + ", cr_legder_id=" + cr_legder_id + ", dr_legder_id=" + dr_legder_id + ", qs=" + qs
				+ ", duties_ledger_id=" + duties_ledger_id + ", round_ledger_id=" + round_ledger_id
				+ ", sale_ledger_id=" + sale_ledger_id + ", discount_ledger_id=" + discount_ledger_id
				+ ", debitor_ledger_id=" + debitor_ledger_id + ", debitor_cash_ledger_id=" + debitor_cash_ledger_id
				+ ", card_ledger_id=" + card_ledger_id + ", is_account=" + is_account + ", service_charge_ledger_id="
				+ service_charge_ledger_id + ", grossAmt=" + grossAmt + ", discAmt=" + discAmt + ", taxVatAmt="
				+ taxVatAmt + ", serviceChargeAmt=" + serviceChargeAmt + "]";
	}

}
