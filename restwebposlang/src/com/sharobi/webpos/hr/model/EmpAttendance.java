package com.sharobi.webpos.hr.model;

import java.io.Serializable;
import java.util.Date;

public class EmpAttendance implements Serializable {

  private int id;

  private int storeId;

  private Employee employee;

  private String dateIn;

  private String timeIn;

  private String dateOut;

  private String timeOut;

  private double workedHour;

  private String inOffice = "Y";

  private int leaveId;

  private String remarks;

  private int shiftScheduleId;

  private int overTime;

  private String grantOverTime = "N";

  private int isOffDay;

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

  public Employee getEmployee() {
    return employee;
  }

  public void setEmployee(Employee employee) {
    this.employee = employee;
  }

  public String getDateIn() {
    return dateIn;
  }

  public void setDateIn(String dateIn) {
    this.dateIn = dateIn;
  }

  public String getTimeIn() {
    return timeIn;
  }

  public void setTimeIn(String timeIn) {
    this.timeIn = timeIn;
  }

  public String getDateOut() {
    return dateOut;
  }

  public void setDateOut(String dateOut) {
    this.dateOut = dateOut;
  }

  public String getTimeOut() {
    return timeOut;
  }

  public void setTimeOut(String timeOut) {
    this.timeOut = timeOut;
  }

  public double getWorkedHour() {
    return workedHour;
  }

  public void setWorkedHour(double workedHour) {
    this.workedHour = workedHour;
  }

  public String getInOffice() {
    return inOffice;
  }

  public void setInOffice(String inOffice) {
    this.inOffice = inOffice;
  }

  public int getLeaveId() {
    return leaveId;
  }

  public void setLeaveId(int leaveId) {
    this.leaveId = leaveId;
  }

  public String getRemarks() {
    return remarks;
  }

  public void setRemarks(String remarks) {
    this.remarks = remarks;
  }

  public int getShiftScheduleId() {
    return shiftScheduleId;
  }

  public void setShiftScheduleId(int shiftScheduleId) {
    this.shiftScheduleId = shiftScheduleId;
  }

  public int getOverTime() {
    return overTime;
  }

  public void setOverTime(int overTime) {
    this.overTime = overTime;
  }

  public String getGrantOverTime() {
    return grantOverTime;
  }

  public void setGrantOverTime(String grantOverTime) {
    this.grantOverTime = grantOverTime;
  }

  public String getCreatedBy() {
    return createdBy;
  }

  public void setCreatedBy(String createdBy) {
    this.createdBy = createdBy;
  }

  public int getIsOffDay() {
    return isOffDay;
  }

  public void setIsOffDay(int isOffDay) {
    this.isOffDay = isOffDay;
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

 
}
