package com.sharobi.webpos.roombooking.base.model;

import com.sharobi.webpos.roombooking.adm.model.Room;

public class RoomBookingDetails {
  private int id;
  private int hotelId;
  private Room roomId;
  private String fromDate;
  private String toDate;
  private String isCancelled;
  private String isCheckIn;
  private double advancePayment;
  private String reserveId;
  private int customerId;
  private String isCheckOut;
  private String bookingDate;
  private String checkInTime;
  private String checkOutTime;
  private double roomRate;
  private double roomTotal;
  private int taxId;
  private double taxRate;
  private double taxAmt;
  private double discPer;
  private double discAmt;
  private double netTotal;
  private RoomBooking bookingId;
  private String bookingNo;
  public int getId() {
    return id;
  }
  public void setId(int id) {
    this.id = id;
  }
  public int getHotelId() {
    return hotelId;
  }
  public void setHotelId(int hotelId) {
    this.hotelId = hotelId;
  }
  public Room getRoomId() {
    return roomId;
  }
  public void setRoomId(Room roomId) {
    this.roomId = roomId;
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
  public String getIsCancelled() {
    return isCancelled;
  }
  public void setIsCancelled(String isCancelled) {
    this.isCancelled = isCancelled;
  }
  public String getIsCheckIn() {
    return isCheckIn;
  }
  public void setIsCheckIn(String isCheckIn) {
    this.isCheckIn = isCheckIn;
  }
  public double getAdvancePayment() {
    return advancePayment;
  }
  public void setAdvancePayment(double advancePayment) {
    this.advancePayment = advancePayment;
  }
  public String getReserveId() {
    return reserveId;
  }
  public void setReserveId(String reserveId) {
    this.reserveId = reserveId;
  }
  public int getCustomerId() {
    return customerId;
  }
  public void setCustomerId(int customerId) {
    this.customerId = customerId;
  }
  public String getIsCheckOut() {
    return isCheckOut;
  }
  public void setIsCheckOut(String isCheckOut) {
    this.isCheckOut = isCheckOut;
  }
  public String getBookingDate() {
    return bookingDate;
  }
  public void setBookingDate(String bookingDate) {
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
  public double getRoomRate() {
    return roomRate;
  }
  public void setRoomRate(double roomRate) {
    this.roomRate = roomRate;
  }
  public double getRoomTotal() {
    return roomTotal;
  }
  public void setRoomTotal(double roomTotal) {
    this.roomTotal = roomTotal;
  }
  public int getTaxId() {
    return taxId;
  }
  public void setTaxId(int taxId) {
    this.taxId = taxId;
  }
  public double getTaxRate() {
    return taxRate;
  }
  public void setTaxRate(double taxRate) {
    this.taxRate = taxRate;
  }
  public double getTaxAmt() {
    return taxAmt;
  }
  public void setTaxAmt(double taxAmt) {
    this.taxAmt = taxAmt;
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
  public double getNetTotal() {
    return netTotal;
  }
  public void setNetTotal(double netTotal) {
    this.netTotal = netTotal;
  }
  public RoomBooking getBookingId() {
    return bookingId;
  }
  public void setBookingId(RoomBooking bookingId) {
    this.bookingId = bookingId;
  }
  public String getBookingNo() {
    return bookingNo;
  }
  public void setBookingNo(String bookingNo) {
    this.bookingNo = bookingNo;
  }
  @Override
  public String toString() {
    return "RoomBookingDetails [id=" + id + ", hotelId=" + hotelId + ", roomId=" + roomId + ", fromDate=" + fromDate
        + ", toDate=" + toDate + ", isCancelled=" + isCancelled + ", isCheckIn=" + isCheckIn + ", advancePayment="
        + advancePayment + ", reserveId=" + reserveId + ", customerId=" + customerId + ", isCheckOut=" + isCheckOut
        + ", bookingDate=" + bookingDate + ", checkInTime=" + checkInTime + ", checkOutTime=" + checkOutTime
        + ", roomRate=" + roomRate + ", roomTotal=" + roomTotal + ", taxId=" + taxId + ", taxRate=" + taxRate
        + ", taxAmt=" + taxAmt + ", discPer=" + discPer + ", discAmt=" + discAmt + ", netTotal=" + netTotal
        + ", bookingId=" + bookingId + ", bookingNo=" + bookingNo + "]";
  }
  
  
}
