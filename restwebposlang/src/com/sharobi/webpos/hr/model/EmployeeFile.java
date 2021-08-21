package com.sharobi.webpos.hr.model;

import java.io.Serializable;

public class EmployeeFile implements Serializable {

  private Integer id;
  private String fileName;
  private String storeId;
  private String docName;
  
  public Integer getId() {
    return id;
  }
  public void setId(Integer id) {
    this.id = id;
  }
  public String getFileName() {
    return fileName;
  }
  public void setFileName(String fileName) {
    this.fileName = fileName;
  }
  public String getStoreId() {
    return storeId;
  }
  public void setStoreId(String storeId) {
    this.storeId = storeId;
  }
  public String getDocName() {
    return docName;
  }
  public void setDocName(String docName) {
    this.docName = docName;
  }
  
  
  
  
  
  
  
  
  
}
