package com.sharobi.webpos.hr.model;

import java.io.Serializable;
import java.util.Date;

import com.google.gson.annotations.Expose;

public class EmpShiftSchedule implements Serializable {

  private int id;

  private int storeId;

  private Employee employee;

  private int dutyShiftId;

  private String fromDate;

  private String fromTime;

  private String toDate;

  private String toTime;

  private int shiftingNo;

  private int isCanceled;

  private int isAmmend;

  private int refShiftId;

  private String createdBy;

  private String createdDate;

  private String updatedBy;

  private String updatedDate;
  
  private double workingHour;

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

  public Employee getEmployee() {
    return employee;
  }

  public void setEmployee(Employee employee) {
    this.employee = employee;
  }

  public int getDutyShiftId() {
    return dutyShiftId;
  }

  public void setDutyShiftId(int dutyShiftId) {
    this.dutyShiftId = dutyShiftId;
  }

  public String getFromDate() {
    return fromDate;
  }

  public void setFromDate(String fromDate) {
    this.fromDate = fromDate;
  }

  public String getFromTime() {
    return fromTime;
  }

  public void setFromTime(String fromTime) {
    this.fromTime = fromTime;
  }

  public String getToDate() {
    return toDate;
  }

  public void setToDate(String toDate) {
    this.toDate = toDate;
  }

  public String getToTime() {
    return toTime;
  }

  public void setToTime(String toTime) {
    this.toTime = toTime;
  }

  public int getShiftingNo() {
    return shiftingNo;
  }

  public void setShiftingNo(int shiftingNo) {
    this.shiftingNo = shiftingNo;
  }

  public int getIsCanceled() {
    return isCanceled;
  }

  public void setIsCanceled(int isCanceled) {
    this.isCanceled = isCanceled;
  }

  public int getIsAmmend() {
    return isAmmend;
  }

  public void setIsAmmend(int isAmmend) {
    this.isAmmend = isAmmend;
  }

  public int getRefShiftId() {
    return refShiftId;
  }

  public void setRefShiftId(int refShiftId) {
    this.refShiftId = refShiftId;
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

  public double getWorkingHour() {
    return workingHour;
  }

  public void setWorkingHour(double workingHour) {
    this.workingHour = workingHour;
  }

  @Override
  public String toString() {
    return "EmpShiftSchedule [id=" + id + ", storeId=" + storeId + ", employee=" + employee + ", dutyShiftId="
        + dutyShiftId + ", fromDate=" + fromDate + ", fromTime=" + fromTime + ", toDate=" + toDate + ", toTime="
        + toTime + ", shiftingNo=" + shiftingNo + ", isCanceled=" + isCanceled + ", isAmmend=" + isAmmend
        + ", refShiftId=" + refShiftId + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy="
        + updatedBy + ", updatedDate=" + updatedDate + ", workingHour=" + workingHour + ", getId()=" + getId()
        + ", getStoreId()=" + getStoreId() + ", getEmployee()=" + getEmployee() + ", getDutyShiftId()="
        + getDutyShiftId() + ", getFromDate()=" + getFromDate() + ", getFromTime()=" + getFromTime() + ", getToDate()="
        + getToDate() + ", getToTime()=" + getToTime() + ", getShiftingNo()=" + getShiftingNo() + ", getIsCanceled()="
        + getIsCanceled() + ", getIsAmmend()=" + getIsAmmend() + ", getRefShiftId()=" + getRefShiftId()
        + ", getCreatedBy()=" + getCreatedBy() + ", getCreatedDate()=" + getCreatedDate() + ", getUpdatedBy()="
        + getUpdatedBy() + ", getUpdatedDate()=" + getUpdatedDate() + ", getWorkingHour()=" + getWorkingHour()
        + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
  }

 
  

  
  

 
 

}
