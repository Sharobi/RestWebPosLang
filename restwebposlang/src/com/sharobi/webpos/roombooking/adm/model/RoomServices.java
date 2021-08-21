package com.sharobi.webpos.roombooking.adm.model;

import java.io.Serializable;

public class RoomServices implements Serializable {
	
  private int id;
	private int hotelId;
	private String name;
	private String description;
	private double rate;
	private int isTaxable;
	private double taxRate;
	private int isServiceChargable;
	private double serviceChargeRate=0.0;
	private double discRate;
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
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getDescription() {
    return description;
  }
  public void setDescription(String description) {
    this.description = description;
  }
  public double getRate() {
    return rate;
  }
  public void setRate(double rate) {
    this.rate = rate;
  }
  public int getIsTaxable() {
    return isTaxable;
  }
  public void setIsTaxable(int isTaxable) {
    this.isTaxable = isTaxable;
  }
  public double getTaxRate() {
    return taxRate;
  }
  public void setTaxRate(double taxRate) {
    this.taxRate = taxRate;
  }
  public int getIsServiceChargable() {
    return isServiceChargable;
  }
  public void setIsServiceChargable(int isServiceChargable) {
    this.isServiceChargable = isServiceChargable;
  }
  public double getServiceChargeRate() {
    return serviceChargeRate;
  }
  public void setServiceChargeRate(double serviceChargeRate) {
    this.serviceChargeRate = serviceChargeRate;
  }
  public double getDiscRate() {
    return discRate;
  }
  public void setDiscRate(double discRate) {
    this.discRate = discRate;
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
    return "RoomServices [id=" + id + ", hotelId=" + hotelId + ", name=" + name + ", description=" + description
        + ", rate=" + rate + ", isTaxable=" + isTaxable + ", taxRate=" + taxRate + ", isServiceChargable="
        + isServiceChargable + ", serviceChargeRate=" + serviceChargeRate + ", discRate=" + discRate + ", isDeleted="
        + isDeleted + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy
        + ", updatedDate=" + updatedDate + "]";
  }
 
	 
 
}
