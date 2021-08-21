/**
 *
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class StoreCustomer  implements Serializable{

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String name;
	private String address;
	private String contactNo;
	private String emailId;
	private int storeId;
	private String creditCustomer;
	private int creditLimit;
	private String deleteFlag;
	private String createdBy;
	private String createdDate;
	private String updatedBy;
	private String updatedDate;
	private String location;
    private String house_no;
    private String street;
    private String dob;
    private String anniversary;
    private int createdByid;
    
    
    private String userName;
    private String password;
    private String type;
    private String cust_vat_reg_no;
    private String car_no;
    private String state;
    private String waiterName;
    private int uniqueidType=0;
    private String uniqueidNo;
    private String gender;
    
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getContactNo() {
		return contactNo;
	}
	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public int getStoreId() {
		return storeId;
	}
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	public String getCreditCustomer() {
		return creditCustomer;
	}
	public void setCreditCustomer(String creditCustomer) {
		this.creditCustomer = creditCustomer;
	}
	public int getCreditLimit() {
		return creditLimit;
	}
	public void setCreditLimit(int creditLimit) {
		this.creditLimit = creditLimit;
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



	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}

	public String getHouse_no() {
		return house_no;
	}
	public void setHouse_no(String house_no) {
		this.house_no = house_no;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getAnniversary() {
		return anniversary;
	}
	public void setAnniversary(String anniversary) {
		this.anniversary = anniversary;
	}


public int getCreatedByid() {
		return createdByid;
	}
	public void setCreatedByid(int createdByid) {
		this.createdByid = createdByid;
	}
	
	public String getUserName() {
    return userName;
  }
  public void setUserName(String userName) {
    this.userName = userName;
  }
  public String getPassword() {
    return password;
  }
  public void setPassword(String password) {
    this.password = password;
  }
  public String getType() {
    return type;
  }
  public void setType(String type) {
    this.type = type;
  }
  public String getCust_vat_reg_no() {
    return cust_vat_reg_no;
  }
  public void setCust_vat_reg_no(String cust_vat_reg_no) {
    this.cust_vat_reg_no = cust_vat_reg_no;
  }
  public String getCar_no() {
    return car_no;
  }
  public void setCar_no(String car_no) {
    this.car_no = car_no;
  }
  public String getState() {
    return state;
  }
  public void setState(String state) {
    this.state = state;
  }
  public String getWaiterName() {
    return waiterName;
  }
  public void setWaiterName(String waiterName) {
    this.waiterName = waiterName;
  }
  public int getUniqueidType() {
    return uniqueidType;
  }
  public void setUniqueidType(int uniqueidType) {
    this.uniqueidType = uniqueidType;
  }
  public String getUniqueidNo() {
    return uniqueidNo;
  }
  public void setUniqueidNo(String uniqueidNo) {
    this.uniqueidNo = uniqueidNo;
  }
  public String getGender() {
    return gender;
  }
  public void setGender(String gender) {
    this.gender = gender;
  }
  @Override
  public String toString() {
    return "StoreCustomer [id=" + id + ", name=" + name + ", address=" + address + ", contactNo=" + contactNo
        + ", emailId=" + emailId + ", storeId=" + storeId + ", creditCustomer=" + creditCustomer + ", creditLimit="
        + creditLimit + ", deleteFlag=" + deleteFlag + ", createdBy=" + createdBy + ", createdDate=" + createdDate
        + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", location=" + location + ", house_no="
        + house_no + ", street=" + street + ", dob=" + dob + ", anniversary=" + anniversary + ", createdByid="
        + createdByid + ", userName=" + userName + ", password=" + password + ", type=" + type + ", cust_vat_reg_no="
        + cust_vat_reg_no + ", car_no=" + car_no + ", state=" + state + ", waiterName=" + waiterName + ", uniqueidType="
        + uniqueidType + ", uniqueidNo=" + uniqueidNo + ", gender=" + gender + "]";
  }
  


}
