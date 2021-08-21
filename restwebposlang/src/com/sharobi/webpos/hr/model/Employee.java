package com.sharobi.webpos.hr.model;

import java.io.Serializable;
import java.util.Date;

public class Employee implements Serializable {
  private int id;
  private int storeId;
  private String code;
  private String name;
  private String permanentAddress;
  private String presentAddress;
  private String mobileNo;
  private String phoneNo;
  private String emailId;
  private EmployeeType employeeType;
  private Department dept;
  private Designation designation;
  private String joiningDate;
  private String leavingDate;
  private String isResigned = "N";
  private String overTimeEnable = "N";
  private String photo;
  private String idProofName;
  private String idProofDocImage;
  private String deleteFlag = "N";
  private double casualLeave;
  private double sickLeave;
  private double earnedLeave;
  private double miscLeave;
  private double grossMonthlySal;
  private double netMonthlySal;
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

  public String getCode() {
    return code;
  }

  public void setCode(String code) {
    this.code = code;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getPermanentAddress() {
    return permanentAddress;
  }

  public void setPermanentAddress(String permanentAddress) {
    this.permanentAddress = permanentAddress;
  }

  public String getPresentAddress() {
    return presentAddress;
  }

  public void setPresentAddress(String presentAddress) {
    this.presentAddress = presentAddress;
  }

  public String getMobileNo() {
    return mobileNo;
  }

  public void setMobileNo(String mobileNo) {
    this.mobileNo = mobileNo;
  }

  public String getPhoneNo() {
    return phoneNo;
  }

  public void setPhoneNo(String phoneNo) {
    this.phoneNo = phoneNo;
  }

  public String getEmailId() {
    return emailId;
  }

  public void setEmailId(String emailId) {
    this.emailId = emailId;
  }

  public EmployeeType getEmployeeType() {
    return employeeType;
  }

  public void setEmployeeType(EmployeeType employeeType) {
    this.employeeType = employeeType;
  }

  public Department getDept() {
    return dept;
  }

  public void setDept(Department dept) {
    this.dept = dept;
  }

  public Designation getDesignation() {
    return designation;
  }

  public void setDesignation(Designation designation) {
    this.designation = designation;
  }

  public String getJoiningDate() {
    return joiningDate;
  }

  public void setJoiningDate(String joiningDate) {
    this.joiningDate = joiningDate;
  }

  public String getLeavingDate() {
    return leavingDate;
  }

  public void setLeavingDate(String leavingDate) {
    this.leavingDate = leavingDate;
  }

  public String getIsResigned() {
    return isResigned;
  }

  public void setIsResigned(String isResigned) {
    this.isResigned = isResigned;
  }

  public String getOverTimeEnable() {
    return overTimeEnable;
  }

  public void setOverTimeEnable(String overTimeEnable) {
    this.overTimeEnable = overTimeEnable;
  }

  public String getPhoto() {
    return photo;
  }

  public void setPhoto(String photo) {
    this.photo = photo;
  }

  public String getIdProofName() {
    return idProofName;
  }

  public void setIdProofName(String idProofName) {
    this.idProofName = idProofName;
  }

  public String getIdProofDocImage() {
    return idProofDocImage;
  }

  public void setIdProofDocImage(String idProofDocImage) {
    this.idProofDocImage = idProofDocImage;
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

  public double getEarnedLeave() {
    return earnedLeave;
  }

  public void setEarnedLeave(double earnedLeave) {
    this.earnedLeave = earnedLeave;
  }

  public double getMiscLeave() {
    return miscLeave;
  }

  public void setMiscLeave(double miscLeave) {
    this.miscLeave = miscLeave;
  }

  public double getGrossMonthlySal() {
    return grossMonthlySal;
  }

  public void setGrossMonthlySal(double grossMonthlySal) {
    this.grossMonthlySal = grossMonthlySal;
  }

  public double getNetMonthlySal() {
    return netMonthlySal;
  }

  public void setNetMonthlySal(double netMonthlySal) {
    this.netMonthlySal = netMonthlySal;
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
    return "Employee [id=" + id + ", storeId=" + storeId + ", code=" + code + ", name=" + name + ", permanentAddress="
        + permanentAddress + ", presentAddress=" + presentAddress + ", mobileNo=" + mobileNo + ", phoneNo=" + phoneNo
        + ", emailId=" + emailId + ", employeeType=" + employeeType + ", dept=" + dept + ", designation=" + designation
        + ", joiningDate=" + joiningDate + ", leavingDate=" + leavingDate + ", isResigned=" + isResigned
        + ", overTimeEnable=" + overTimeEnable + ", photo=" + photo + ", idProofName=" + idProofName
        + ", idProofDocImage=" + idProofDocImage + ", deleteFlag=" + deleteFlag + ", casualLeave=" + casualLeave
        + ", sickLeave=" + sickLeave + ", earnedLeave=" + earnedLeave + ", miscLeave=" + miscLeave
        + ", grossMonthlySal=" + grossMonthlySal + ", netMonthlySal=" + netMonthlySal + ", createdBy=" + createdBy
        + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + "]";
  }

}
