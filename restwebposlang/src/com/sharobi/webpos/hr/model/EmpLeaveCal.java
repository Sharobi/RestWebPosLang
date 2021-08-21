package com.sharobi.webpos.hr.model;

import java.io.Serializable;

public class EmpLeaveCal implements Serializable {
  private static final long serialVersionUID = 1L;

  private int empId;

  private String empName;

  private double janLeave;

  private double febLeave;

  private double marLeave;

  private double aprLeave;

  private double mayLeave;

  private double junLeave;

  private double julLeave;

  private double augLeave;

  private double sepLeave;

  private double octLeave;

  private double novLeave;

  private double decLeave;

  private double totalLeave;

  private double allotedLeave;

  private double leaveBalance;

  public int getEmpId() {
    return empId;
  }

  public void setEmpId(int empId) {
    this.empId = empId;
  }

  public String getEmpName() {
    return empName;
  }

  public void setEmpName(String empName) {
    this.empName = empName;
  }

  public double getJanLeave() {
    return janLeave;
  }

  public void setJanLeave(double janLeave) {
    this.janLeave = janLeave;
  }

  public double getFebLeave() {
    return febLeave;
  }

  public void setFebLeave(double febLeave) {
    this.febLeave = febLeave;
  }

  public double getMarLeave() {
    return marLeave;
  }

  public void setMarLeave(double marLeave) {
    this.marLeave = marLeave;
  }

  public double getAprLeave() {
    return aprLeave;
  }

  public void setAprLeave(double aprLeave) {
    this.aprLeave = aprLeave;
  }

  public double getMayLeave() {
    return mayLeave;
  }

  public void setMayLeave(double mayLeave) {
    this.mayLeave = mayLeave;
  }

  public double getJunLeave() {
    return junLeave;
  }

  public void setJunLeave(double junLeave) {
    this.junLeave = junLeave;
  }

  public double getJulLeave() {
    return julLeave;
  }

  public void setJulLeave(double julLeave) {
    this.julLeave = julLeave;
  }

  public double getAugLeave() {
    return augLeave;
  }

  public void setAugLeave(double augLeave) {
    this.augLeave = augLeave;
  }

  public double getSepLeave() {
    return sepLeave;
  }

  public void setSepLeave(double sepLeave) {
    this.sepLeave = sepLeave;
  }

  public double getOctLeave() {
    return octLeave;
  }

  public void setOctLeave(double octLeave) {
    this.octLeave = octLeave;
  }

  public double getNovLeave() {
    return novLeave;
  }

  public void setNovLeave(double novLeave) {
    this.novLeave = novLeave;
  }

  public double getDecLeave() {
    return decLeave;
  }

  public void setDecLeave(double decLeave) {
    this.decLeave = decLeave;
  }

  public double getTotalLeave() {
    return totalLeave;
  }

  public void setTotalLeave(double totalLeave) {
    this.totalLeave = totalLeave;
  }

  public double getAllotedLeave() {
    return allotedLeave;
  }

  public void setAllotedLeave(double allotedLeave) {
    this.allotedLeave = allotedLeave;
  }

  public double getLeaveBalance() {
    return leaveBalance;
  }

  public void setLeaveBalance(double leaveBalance) {
    this.leaveBalance = leaveBalance;
  }

  @Override
  public String toString() {
    return "EmpLeaveCal [empId=" + empId + ", empName=" + empName + ", janLeave=" + janLeave + ", febLeave=" + febLeave
        + ", marLeave=" + marLeave + ", aprLeave=" + aprLeave + ", mayLeave=" + mayLeave + ", junLeave=" + junLeave
        + ", julLeave=" + julLeave + ", augLeave=" + augLeave + ", sepLeave=" + sepLeave + ", octLeave=" + octLeave
        + ", novLeave=" + novLeave + ", decLeave=" + decLeave + ", totalLeave=" + totalLeave + ", allotedLeave="
        + allotedLeave + ", leaveBalance=" + leaveBalance + "]";
  }
  
  
}
