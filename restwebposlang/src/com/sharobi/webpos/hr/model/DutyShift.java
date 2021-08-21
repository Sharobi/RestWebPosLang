package com.sharobi.webpos.hr.model;

import java.io.Serializable;

public class DutyShift implements Serializable{
    private static final long serialVersionUID = 1L;
    private int id;
    private String fromTime;
    private String toTime;
    private int storeId;
    private int shiftingNo;
    private String shiftName;
    private String deleteFlag;
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
    public String getFromTime() {
      return fromTime;
    }
    public void setFromTime(String fromTime) {
      this.fromTime = fromTime;
    }
    public String getToTime() {
      return toTime;
    }
    public void setToTime(String toTime) {
      this.toTime = toTime;
    }
    public int getStoreId() {
      return storeId;
    }
    public void setStoreId(int storeId) {
      this.storeId = storeId;
    }
    public int getShiftingNo() {
      return shiftingNo;
    }
    public void setShiftingNo(int shiftingNo) {
      this.shiftingNo = shiftingNo;
    }
    public String getShiftName() {
      return shiftName;
    }
    public void setShiftName(String shiftName) {
      this.shiftName = shiftName;
    }
    public String getDeleteFlag() {
      return deleteFlag;
    }
    public void setDeleteFlag(String deleteFlag) {
      this.deleteFlag = deleteFlag;
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
      return "DutyShift [id=" + id + ", fromTime=" + fromTime + ", toTime=" + toTime + ", storeId=" + storeId
          + ", shiftingNo=" + shiftingNo + ", shiftName=" + shiftName + ", deleteFlag=" + deleteFlag + ", createdBy="
          + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate
          + "]";
    }
    
    
}
