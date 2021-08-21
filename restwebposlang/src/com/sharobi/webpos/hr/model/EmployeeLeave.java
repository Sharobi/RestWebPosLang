package com.sharobi.webpos.hr.model;

import java.io.Serializable;

public class EmployeeLeave implements Serializable {
  
      private int id;

      private String leaveType;

      private int storeId;

      private int days;

      private int empTypeId;

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

      public String getLeaveType() {
        return leaveType;
      }

      public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
      }

      public int getStoreId() {
        return storeId;
      }

      public void setStoreId(int storeId) {
        this.storeId = storeId;
      }

      public int getDays() {
        return days;
      }

      public void setDays(int days) {
        this.days = days;
      }

      public int getEmpTypeId() {
        return empTypeId;
      }

      public void setEmpTypeId(int empTypeId) {
        this.empTypeId = empTypeId;
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
      
      
}
