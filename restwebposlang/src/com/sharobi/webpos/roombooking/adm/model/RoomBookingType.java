package com.sharobi.webpos.roombooking.adm.model;

public class RoomBookingType {
  private int id;
  private String name;
  private int storeId;
  private int isDeleted;
  public int getId() {
    return id;
  }
  public void setId(int id) {
    this.id = id;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public int getStoreId() {
    return storeId;
  }
  public void setStoreId(int storeId) {
    this.storeId = storeId;
  }
  public int getIsDeleted() {
    return isDeleted;
  }
  public void setIsDeleted(int isDeleted) {
    this.isDeleted = isDeleted;
  }
  @Override
  public String toString() {
    return "RoomBookingType [id=" + id + ", name=" + name + ", storeId=" + storeId + ", isDeleted=" + isDeleted + "]";
  }
  
}
