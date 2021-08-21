package com.sharobi.webpos.roombooking.base.model;

import java.util.Date;
import java.util.List;

import com.sharobi.webpos.adm.model.StoreCustomer;
import com.sharobi.webpos.roombooking.adm.model.RoomBookingType;

public class RoomBooking {
	
private static final long serialVersionUID = 1L;

	
	private int id;
	private String frontDeskName;
	
	private String checkInDate;
	private String checkinTimeId; 	// One time entry for each hotel.
	private String actualCheckinTime;
	
	private String checkoutDate;
	private String checkoutTimeId;	// One time entry for each hotel.
	private String actualCheckoutTime;
	
	private String isCheckedOut;
	
	private String reserveId;
	private int hotelId;
	private StoreCustomer custId;
	private RoomBookingInfo roombookinginfo;

	private double grossAmt;
	private double discPer;
	private double discAmt;
	private double taxAmt;
	private double netAmt;
	private String isTaxable;
	private String bookingNo;
	
	// new added 17.7.2019
	private String isCheckedIn;
	private String isCancelled;
	private String bookingDate;
	private RoomBookingType bookingType;
	private double roundOff;
	private List<RoomBookingDetails> bookingDetail;
	private List<RoomBookingPayment> payment;
	private List<RoomBookingServices> bookingServices;
	private double roomServiceGross;
	private double roomServiceTax;
	private double roomServiceDiscount;
	private int noOfPersons;
	private String checkoutType;
	private String cancelBy;
	private Date cancelDate;
	private String cancelRemarks;
	private String takePType;
	private List<RoomBookingGuest> bookingGuest;
	private String creditFlag="N";
	private String refNo;
	private String remarks;
	//Added paidAmount And netAmountToPay On 5Th November 2019-Tuesday-By Prothit //
	private double paidAmount;
	private double netAmountToPay;
	
	
  public StoreCustomer getCustId() {
		return custId;
	}

	public void setCustId(StoreCustomer custId) {
		this.custId = custId;
	}

	public int getHotelId() {
		return hotelId;
	}

	public void setHotelId(int hotelId) {
		this.hotelId = hotelId;
	}

	public String getReserveId() {
		return reserveId;
	}

	public void setReserveId(String reserveId) {
		this.reserveId = reserveId;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFrontDeskName() {
		return frontDeskName;
	}

	public void setFrontDeskName(String frontDeskName) {
		this.frontDeskName = frontDeskName;
	}

	public String getCheckInDate() {
		return checkInDate;
	}

	public void setCheckInDate(String checkInDate) {
		this.checkInDate = checkInDate;
	}

	public String getCheckinTimeId() {
		return checkinTimeId;
	}

	public void setCheckinTimeId(String checkinTimeId) {
		this.checkinTimeId = checkinTimeId;
	}

	public String getActualCheckinTime() {
		return actualCheckinTime;
	}

	public void setActualCheckinTime(String actualCheckinTime) {
		this.actualCheckinTime = actualCheckinTime;
	}

	public String getCheckoutDate() {
		return checkoutDate;
	}

	public void setCheckoutDate(String checkoutDate) {
		this.checkoutDate = checkoutDate;
	}

	public String getCheckoutTimeId() {
		return checkoutTimeId;
	}

	public void setCheckoutTimeId(String checkoutTimeId) {
		this.checkoutTimeId = checkoutTimeId;
	}

	public String getActualCheckoutTime() {
		return actualCheckoutTime;
	}

	public void setActualCheckoutTime(String actualCheckoutTime) {
		this.actualCheckoutTime = actualCheckoutTime;
	}

	public String getIsCheckedOut() {
		return isCheckedOut;
	}

	public void setIsCheckedOut(String isCheckedOut) {
		this.isCheckedOut = isCheckedOut;
	}

	public RoomBookingInfo getRoombookinginfo() {
		return roombookinginfo;
	}

	public void setRoombookinginfo(RoomBookingInfo roombookinginfo) {
		this.roombookinginfo = roombookinginfo;
	}

	public double getGrossAmt() {
		return grossAmt;
	}

	public void setGrossAmt(double grossAmt) {
		this.grossAmt = grossAmt;
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

	public double getNetAmt() {
		return netAmt;
	}

	public void setNetAmt(double netAmt) {
		this.netAmt = netAmt;
	}

  public String getIsTaxable() {
    return isTaxable;
  }

  public void setIsTaxable(String isTaxable) {
    this.isTaxable = isTaxable;
  }

  public String getBookingNo() {
    return bookingNo;
  }

  public void setBookingNo(String bookingNo) {
    this.bookingNo = bookingNo;
  }

  public String getIsCheckedIn() {
    return isCheckedIn;
  }

  public void setIsCheckedIn(String isCheckedIn) {
    this.isCheckedIn = isCheckedIn;
  }

  public String getIsCancelled() {
    return isCancelled;
  }

  public void setIsCancelled(String isCancelled) {
    this.isCancelled = isCancelled;
  }

  public String getBookingDate() {
    return bookingDate;
  }

  public void setBookingDate(String bookingDate) {
    this.bookingDate = bookingDate;
  }

  public RoomBookingType getBookingType() {
    return bookingType;
  }

  public void setBookingType(RoomBookingType bookingType) {
    this.bookingType = bookingType;
  }

  public double getRoundOff() {
    return roundOff;
  }

  public void setRoundOff(double roundOff) {
    this.roundOff = roundOff;
  }

  public List<RoomBookingDetails> getBookingDetail() {
    return bookingDetail;
  }

  public void setBookingDetail(List<RoomBookingDetails> bookingDetail) {
    this.bookingDetail = bookingDetail;
  }

  public List<RoomBookingPayment> getPayment() {
    return payment;
  }

  public void setPayment(List<RoomBookingPayment> payment) {
    this.payment = payment;
  }

 

  public List<RoomBookingServices> getBookingServices() {
    return bookingServices;
  }

  public void setBookingServices(List<RoomBookingServices> bookingServices) {
    this.bookingServices = bookingServices;
  }

  public double getRoomServiceGross() {
    return roomServiceGross;
  }

  public void setRoomServiceGross(double roomServiceGross) {
    this.roomServiceGross = roomServiceGross;
  }

  public double getRoomServiceTax() {
    return roomServiceTax;
  }

  public void setRoomServiceTax(double roomServiceTax) {
    this.roomServiceTax = roomServiceTax;
  }

  public double getRoomServiceDiscount() {
    return roomServiceDiscount;
  }

  public void setRoomServiceDiscount(double roomServiceDiscount) {
    this.roomServiceDiscount = roomServiceDiscount;
  }

  public int getNoOfPersons() {
    return noOfPersons;
  }

  public void setNoOfPersons(int noOfPersons) {
    this.noOfPersons = noOfPersons;
  }

  public String getCheckoutType() {
    return checkoutType;
  }

  public void setCheckoutType(String checkoutType) {
    this.checkoutType = checkoutType;
  }

  public String getCancelBy() {
    return cancelBy;
  }

  public void setCancelBy(String cancelBy) {
    this.cancelBy = cancelBy;
  }

  public Date getCancelDate() {
    return cancelDate;
  }

  public void setCancelDate(Date cancelDate) {
    this.cancelDate = cancelDate;
  }

  public String getCancelRemarks() {
    return cancelRemarks;
  }

  public void setCancelRemarks(String cancelRemarks) {
    this.cancelRemarks = cancelRemarks;
  }

  public String getTakePType() {
    return takePType;
  }

  public void setTakePType(String takePType) {
    this.takePType = takePType;
  }

  public List<RoomBookingGuest> getBookingGuest() {
    return bookingGuest;
  }

  public void setBookingGuest(List<RoomBookingGuest> bookingGuest) {
    this.bookingGuest = bookingGuest;
  }
  

  public String getCreditFlag() {
    return creditFlag;
  }

  public void setCreditFlag(String creditFlag) {
    this.creditFlag = creditFlag;
  }

  
  
  public String getRefNo() {
    return refNo;
  }

  public void setRefNo(String refNo) {
    this.refNo = refNo;
  }

  public double getPaidAmount() {
    return paidAmount;
  }

  public void setPaidAmount(double paidAmount) {
    this.paidAmount = paidAmount;
  }
  
  

  public double getNetAmountToPay() {
    return netAmountToPay;
  }

  public void setNetAmountToPay(double netAmountToPay) {
    this.netAmountToPay = netAmountToPay;
  }
  
  public String getRemarks() {
    return remarks;
  }

  public void setRemarks(String remarks) {
    this.remarks = remarks;
  }

  @Override
  public String toString() {
    return "RoomBooking [id=" + id + ", frontDeskName=" + frontDeskName + ", checkInDate=" + checkInDate
        + ", checkinTimeId=" + checkinTimeId + ", actualCheckinTime=" + actualCheckinTime + ", checkoutDate="
        + checkoutDate + ", checkoutTimeId=" + checkoutTimeId + ", actualCheckoutTime=" + actualCheckoutTime
        + ", isCheckedOut=" + isCheckedOut + ", reserveId=" + reserveId + ", hotelId=" + hotelId + ", custId=" + custId
        + ", roombookinginfo=" + roombookinginfo + ", grossAmt=" + grossAmt + ", discPer=" + discPer + ", discAmt="
        + discAmt + ", taxAmt=" + taxAmt + ", netAmt=" + netAmt + ", isTaxable=" + isTaxable + ", bookingNo="
        + bookingNo + ", isCheckedIn=" + isCheckedIn + ", isCancelled=" + isCancelled + ", bookingDate=" + bookingDate
        + ", bookingType=" + bookingType + ", roundOff=" + roundOff + ", bookingDetail=" + bookingDetail + ", payment="
        + payment + ", bookingServices=" + bookingServices + ", roomServiceGross=" + roomServiceGross
        + ", roomServiceTax=" + roomServiceTax + ", roomServiceDiscount=" + roomServiceDiscount + ", noOfPersons="
        + noOfPersons + ", checkoutType=" + checkoutType + ", cancelBy=" + cancelBy + ", cancelDate=" + cancelDate
        + ", cancelRemarks=" + cancelRemarks + ", takePType=" + takePType + ", bookingGuest=" + bookingGuest
        + ", creditFlag=" + creditFlag + ", refNo=" + refNo + ", remarks=" + remarks + ", paidAmount=" + paidAmount
        + ", netAmountToPay=" + netAmountToPay + "]";
  }



 


 
 

  
 

}
