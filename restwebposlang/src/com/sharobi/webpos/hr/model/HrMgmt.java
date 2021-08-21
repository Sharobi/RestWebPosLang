/**
 * 
 */
package com.sharobi.webpos.hr.model;

/**
 * @author sumon
 *
 */
public class HrMgmt {

  private static final long serialVersionUID = 1L;
  
  private int id;
  
  private String name;
  
  private int storeId;

  public int getStoreId() {
    return storeId;
  }

  public void setStoreId(int storeId) {
    this.storeId = storeId;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  @Override
  public String toString() {
    return "Department [id=" + id + ", name=" + name + "]";
  }

}
