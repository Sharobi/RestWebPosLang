package com.sharobi.webpos.hr.model;

import java.io.Serializable;
import java.util.List;

public class EmpShiftScheduleList implements Serializable {

  private static final long serialVersionUID = 1L;

  private List<EmpShiftSchedule> empshiftscheduleList;

  public List<EmpShiftSchedule> getEmpshiftscheduleList() {
    return empshiftscheduleList;
  }

  public void setEmpshiftscheduleList(List<EmpShiftSchedule> empshiftscheduleList) {
    this.empshiftscheduleList = empshiftscheduleList;
  }

  public static long getSerialversionuid() {
    return serialVersionUID;
  }

  @Override
  public String toString() {
    return "EmpShiftScheduleList [empshiftscheduleList=" + empshiftscheduleList + "]";
  }
  
  
  
  
}
