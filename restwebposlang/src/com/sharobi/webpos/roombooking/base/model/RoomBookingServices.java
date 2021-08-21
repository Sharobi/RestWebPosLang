package com.sharobi.webpos.roombooking.base.model;

import com.sharobi.webpos.roombooking.adm.model.Room;
import com.sharobi.webpos.roombooking.adm.model.RoomServices;

public class RoomBookingServices {
  private int id;
  private int hotelId;
  private RoomBooking roomBooking;
  private String bookingNo;
  private Room room;
  private RoomServices roomServices;
  private String serviceNote;
  private double serviceRate;
  private double serviceQty;
  private double grossAmount;
  private double discPer;
  private double discAmount;
  private double taxRate;
  private double taxAmount;
  private double serviceChargeRate;
  private double serviceChargeAmount;
  private double netAmount;
  private int isDeleted;
  private int createdBy;
  private String createdDate;
  private int updatedBy;
  private String updatedDate;
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
  public RoomBooking getRoomBooking() {
    return roomBooking;
  }
  public void setRoomBooking(RoomBooking roomBooking) {
    this.roomBooking = roomBooking;
  }
  public String getBookingNo() {
    return bookingNo;
  }
  public void setBookingNo(String bookingNo) {
    this.bookingNo = bookingNo;
  }
  public Room getRoom() {
    return room;
  }
  public void setRoom(Room room) {
    this.room = room;
  }
  public RoomServices getRoomServices() {
    return roomServices;
  }
  public void setRoomServices(RoomServices roomServices) {
    this.roomServices = roomServices;
  }
  public String getServiceNote() {
    return serviceNote;
  }
  public void setServiceNote(String serviceNote) {
    this.serviceNote = serviceNote;
  }
  public double getServiceRate() {
    return serviceRate;
  }
  public void setServiceRate(double serviceRate) {
    this.serviceRate = serviceRate;
  }
  public double getServiceQty() {
    return serviceQty;
  }
  public void setServiceQty(double serviceQty) {
    this.serviceQty = serviceQty;
  }
  public double getGrossAmount() {
    return grossAmount;
  }
  public void setGrossAmount(double grossAmount) {
    this.grossAmount = grossAmount;
  }
  public double getDiscPer() {
    return discPer;
  }
  public void setDiscPer(double discPer) {
    this.discPer = discPer;
  }
  public double getDiscAmount() {
    return discAmount;
  }
  public void setDiscAmount(double discAmount) {
    this.discAmount = discAmount;
  }
  public double getTaxRate() {
    return taxRate;
  }
  public void setTaxRate(double taxRate) {
    this.taxRate = taxRate;
  }
  public double getTaxAmount() {
    return taxAmount;
  }
  public void setTaxAmount(double taxAmount) {
    this.taxAmount = taxAmount;
  }
  public double getServiceChargeRate() {
    return serviceChargeRate;
  }
  public void setServiceChargeRate(double serviceChargeRate) {
    this.serviceChargeRate = serviceChargeRate;
  }
  public double getServiceChargeAmount() {
    return serviceChargeAmount;
  }
  public void setServiceChargeAmount(double serviceChargeAmount) {
    this.serviceChargeAmount = serviceChargeAmount;
  }
  public double getNetAmount() {
    return netAmount;
  }
  public void setNetAmount(double netAmount) {
    this.netAmount = netAmount;
  }
  public int getIsDeleted() {
    return isDeleted;
  }
  public void setIsDeleted(int isDeleted) {
    this.isDeleted = isDeleted;
  }
  public int getCreatedBy() {
    return createdBy;
  }
  public void setCreatedBy(int createdBy) {
    this.createdBy = createdBy;
  }
  public String getCreatedDate() {
    return createdDate;
  }
  public void setCreatedDate(String createdDate) {
    this.createdDate = createdDate;
  }
  public int getUpdatedBy() {
    return updatedBy;
  }
  public void setUpdatedBy(int updatedBy) {
    this.updatedBy = updatedBy;
  }
  public String getUpdatedDate() {
    return updatedDate;
  }
  public void setUpdatedDate(String updatedDate) {
    this.updatedDate = updatedDate;
  }
  @Override
  public String toString() {
    return "RoomBookingServices [id=" + id + ", hotelId=" + hotelId + ", roomBooking=" + roomBooking + ", bookingNo="
        + bookingNo + ", room=" + room + ", roomServices=" + roomServices + ", serviceNote=" + serviceNote
        + ", serviceRate=" + serviceRate + ", serviceQty=" + serviceQty + ", grossAmount=" + grossAmount + ", discPer="
        + discPer + ", discAmount=" + discAmount + ", taxRate=" + taxRate + ", taxAmount=" + taxAmount
        + ", serviceChargeRate=" + serviceChargeRate + ", serviceChargeAmount=" + serviceChargeAmount + ", netAmount="
        + netAmount + ", isDeleted=" + isDeleted + ", createdBy=" + createdBy + ", createdDate=" + createdDate
        + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + "]";
  }
   
  
}
