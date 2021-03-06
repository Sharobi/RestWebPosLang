package com.sharobi.webpos.roombooking.base.model;

public class RoomBookingPayment {

	private static final long serialVersionUID = 1L;

	private int id;
	private int booking_id;
	private String reserveId;
	private String hotelId;
	private double amount;
	private double paidamount;
	private double amt_to_pay;
	private String isCancelled;
	private double tenderamount;
	private String paymentMode;
	private String cardLastFourDigits;
	
	// For accounts 
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
   private double netTotal;
   private double grossAmt;
   private double discAmt;
   private double taxVatAmt;
   private double serviceChargeAmt;
   private String createdBy;
   
   
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBooking_id() {
		return booking_id;
	}
	public void setBooking_id(int booking_id) {
		this.booking_id = booking_id;
	}
	public String getReserveId() {
		return reserveId;
	}
	public void setReserveId(String reserveId) {
		this.reserveId = reserveId;
	}
	public String getHotelId() {
		return hotelId;
	}
	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public double getPaidamount() {
		return paidamount;
	}
	public void setPaidamount(double paidamount) {
		this.paidamount = paidamount;
	}
	public double getAmt_to_pay() {
		return amt_to_pay;
	}
	public void setAmt_to_pay(double amt_to_pay) {
		this.amt_to_pay = amt_to_pay;
	}
	
  public String getIsCancelled() {
    return isCancelled;
  }
  public void setIsCancelled(String isCancelled) {
    this.isCancelled = isCancelled;
  }
  
  public double getTenderamount() {
    return tenderamount;
  }
  public void setTenderamount(double tenderamount) {
    this.tenderamount = tenderamount;
  }
  public String getPaymentMode() {
    return paymentMode;
  }
  public void setPaymentMode(String paymentMode) {
    this.paymentMode = paymentMode;
  }
  public String getCardLastFourDigits() {
    return cardLastFourDigits;
  }
  public void setCardLastFourDigits(String cardLastFourDigits) {
    this.cardLastFourDigits = cardLastFourDigits;
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
  public String getQs() {
    return qs;
  }
  public void setQs(String qs) {
    this.qs = qs;
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
  public int getService_charge_ledger_id() {
    return service_charge_ledger_id;
  }
  public void setService_charge_ledger_id(int service_charge_ledger_id) {
    this.service_charge_ledger_id = service_charge_ledger_id;
  }
  
  public double getNetTotal() {
    return netTotal;
  }
  public void setNetTotal(double netTotal) {
    this.netTotal = netTotal;
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
  public String getCreatedBy() {
    return createdBy;
  }
  public void setCreatedBy(String createdBy) {
    this.createdBy = createdBy;
  }
  @Override
  public String toString() {
    return "RoomBookingPayment [id=" + id + ", booking_id=" + booking_id + ", reserveId=" + reserveId + ", hotelId="
        + hotelId + ", amount=" + amount + ", paidamount=" + paidamount + ", amt_to_pay=" + amt_to_pay
        + ", isCancelled=" + isCancelled + ", tenderamount=" + tenderamount + ", paymentMode=" + paymentMode
        + ", cardLastFourDigits=" + cardLastFourDigits + ", cr_amount=" + cr_amount + ", dr_amount=" + dr_amount
        + ", cr_legder_id=" + cr_legder_id + ", dr_legder_id=" + dr_legder_id + ", qs=" + qs + ", duties_ledger_id="
        + duties_ledger_id + ", round_ledger_id=" + round_ledger_id + ", sale_ledger_id=" + sale_ledger_id
        + ", discount_ledger_id=" + discount_ledger_id + ", debitor_ledger_id=" + debitor_ledger_id
        + ", debitor_cash_ledger_id=" + debitor_cash_ledger_id + ", card_ledger_id=" + card_ledger_id + ", is_account="
        + is_account + ", service_charge_ledger_id=" + service_charge_ledger_id + ", netTotal=" + netTotal
        + ", grossAmt=" + grossAmt + ", discAmt=" + discAmt + ", taxVatAmt=" + taxVatAmt + ", serviceChargeAmt="
        + serviceChargeAmt + ", createdBy=" + createdBy + "]";
  }
  
  
  
	
}
