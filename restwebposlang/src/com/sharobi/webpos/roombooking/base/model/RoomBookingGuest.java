package com.sharobi.webpos.roombooking.base.model;

import java.io.Serializable;

public class RoomBookingGuest implements Serializable {

  private static final long serialVersionUID = 1L;


  private int id;


  private int hotelId;


  private RoomBooking roomBooking;


  private String bookingNo;


  private String name;

 
  private String contactNo;


  private String emailId;

 
  private String address;

 
  private String gender;

 
  private String dob;

 
  private int uniqueidType=0;
   
 
  private String uniqueidNo;

  
  private String type;

  
  private String deleteFlag="N";


  private int createdBy;

  
  private String createdDate;


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


  public String getName() {
    return name;
  }


  public void setName(String name) {
    this.name = name;
  }


  public String getContactNo() {
    return contactNo;
  }


  public void setContactNo(String contactNo) {
    this.contactNo = contactNo;
  }


  public String getEmailId() {
    return emailId;
  }


  public void setEmailId(String emailId) {
    this.emailId = emailId;
  }


  public String getAddress() {
    return address;
  }


  public void setAddress(String address) {
    this.address = address;
  }


  public String getGender() {
    return gender;
  }


  public void setGender(String gender) {
    this.gender = gender;
  }


  public String getDob() {
    return dob;
  }


  public void setDob(String dob) {
    this.dob = dob;
  }


  public int getUniqueidType() {
    return uniqueidType;
  }


  public void setUniqueidType(int uniqueidType) {
    this.uniqueidType = uniqueidType;
  }


  public String getUniqueidNo() {
    return uniqueidNo;
  }


  public void setUniqueidNo(String uniqueidNo) {
    this.uniqueidNo = uniqueidNo;
  }


  public String getType() {
    return type;
  }


  public void setType(String type) {
    this.type = type;
  }


  public String getDeleteFlag() {
    return deleteFlag;
  }


  public void setDeleteFlag(String deleteFlag) {
    this.deleteFlag = deleteFlag;
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


  @Override
  public String toString() {
    return "RoomBookingGuest [id=" + id + ", hotelId=" + hotelId + ", roomBooking=" + roomBooking + ", bookingNo="
        + bookingNo + ", name=" + name + ", contactNo=" + contactNo + ", emailId=" + emailId + ", address=" + address
        + ", gender=" + gender + ", dob=" + dob + ", uniqueidType=" + uniqueidType + ", uniqueidNo=" + uniqueidNo
        + ", type=" + type + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate
        + "]";
  }
  
  
  
  
}
