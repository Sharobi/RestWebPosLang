package com.sharobi.webpos.hr.model;

import java.io.Serializable;

public class EmployeeType implements Serializable{
  private int id;
  private int storeId;
  private String type;
  private String deleteFlag;
  private double casualLeave;
  private double sickLeave;
  private double miscLeave;
  private String createdBy;
  private String createdDate;
  private String updatedBy;
  private String updatedDate;
  public int getId() {
    return id;
  }
  public void setId(int id) {
    this.id = id;
  }
  public int getStoreId() {
    return storeId;
  }
  public void setStoreId(int storeId) {
    this.storeId = storeId;
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
  public double getCasualLeave() {
    return casualLeave;
  }
  public void setCasualLeave(double casualLeave) {
    this.casualLeave = casualLeave;
  }
  public double getSickLeave() {
    return sickLeave;
  }
  public void setSickLeave(double sickLeave) {
    this.sickLeave = sickLeave;
  }
  public double getMiscLeave() {
    return miscLeave;
  }
  public void setMiscLeave(double miscLeave) {
    this.miscLeave = miscLeave;
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
  @Override
  public String toString() {
    return "EmployeeType [id=" + id + ", storeId=" + storeId + ", type=" + type + ", deleteFlag=" + deleteFlag
        + ", casualLeave=" + casualLeave + ", sickLeave=" + sickLeave + ", miscLeave=" + miscLeave + ", createdBy="
        + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate
        + "]";
  }
}
