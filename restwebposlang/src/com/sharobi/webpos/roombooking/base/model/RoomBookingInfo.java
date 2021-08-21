package com.sharobi.webpos.roombooking.base.model;

import java.util.Date;
import java.util.List;

import com.sharobi.webpos.roombooking.adm.model.Room;

public class RoomBookingInfo {

	private static final long serialVersionUID = 1L;
	
	private String reserveId;
	
	private RoomBookingCustomer customer;
	private List<Room> roomid;
	private String fromDate;
	private String toDate;
	private int hotelId;
	private String isCheckIn;
	private String isCheckOut;
	private RoomBookingPayment payment;
	
	//private int roomId;
	private double advancePayment;
	private String customerId;
	private String isCancelled;
	private Date bookingDate;
	private String checkInTime;
	private String checkOutTime;

	
	public double getAdvancePayment() {
		return advancePayment;
	}
	public void setAdvancePayment(double advancePayment) {
		this.advancePayment = advancePayment;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getIsCancelled() {
		return isCancelled;
	}
	public void setIsCancelled(String isCancelled) {
		this.isCancelled = isCancelled;
	}
	public Date getBookingDate() {
		return bookingDate;
	}
	public void setBookingDate(Date bookingDate) {
		this.bookingDate = bookingDate;
	}
	public String getCheckInTime() {
		return checkInTime;
	}
	public void setCheckInTime(String checkInTime) {
		this.checkInTime = checkInTime;
	}
	public String getCheckOutTime() {
		return checkOutTime;
	}
	public void setCheckOutTime(String checkOutTime) {
		this.checkOutTime = checkOutTime;
	}
	
   public String getReserveId() {
		return reserveId;
	}
	public void setReserveId(String reserveId) {
		this.reserveId = reserveId;
	}	
	public RoomBookingCustomer getCustomer() {
		return customer;
	}
	public void setCustomer(RoomBookingCustomer customer) {
		this.customer = customer;
	}

	public List<Room> getRoomid() {
		return roomid;
	}
	public void setRoomid(List<Room> roomid) {
		this.roomid = roomid;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	public int getHotelId() {
		return hotelId;
	}
	public void setHotelId(int hotelId) {
		this.hotelId = hotelId;
	}
	
	
	public String getIsCheckIn() {
		return isCheckIn;
	}
	public void setIsCheckIn(String isCheckIn) {
		this.isCheckIn = isCheckIn;
	}
	public String getIsCheckOut() {
		return isCheckOut;
	}
	public void setIsCheckOut(String isCheckOut) {
		this.isCheckOut = isCheckOut;
	}
	
	
	public RoomBookingPayment getPayment() {
		return payment;
	}
	public void setPayment(RoomBookingPayment payment) {
		this.payment = payment;
	}
	@Override
	public String toString() {
		return "RoomBookingInfo [reserveId=" + reserveId + ", customer=" + customer + ", roomid=" + roomid
				+ ", fromDate=" + fromDate + ", toDate=" + toDate + ", hotelId=" + hotelId + ", isCheckIn=" + isCheckIn
				+ ", isCheckOut=" + isCheckOut + ", payment=" + payment + ", advancePayment=" + advancePayment
				+ ", customerId=" + customerId + ", isCancelled=" + isCancelled + ", bookingDate=" + bookingDate
				+ ", checkInTime=" + checkInTime + ", checkOutTime=" + checkOutTime + "]";
	}
	
	
}
