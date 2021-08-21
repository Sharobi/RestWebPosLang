/**
 *
 */
package com.sharobi.webpos.account.model;

import java.util.Date;

/**
 * @author SK A SIDDIK
 *
 *         Nov 14, 2017
 */
public class AccountDTO {
	private static final long serialVersionUID = 1L;

	private int id;

	private int groupId;

	private String name;

	private String code;

	private int cityId;

	private int zoneId;

	private int areaId;

	private String address;

	private String phone;

	private String pin;

	private String email;

	private String panNo;

	private String gstRegistrationNo;

	private String bcdaRegistrationNo;

	private String dlNo;

	private double cashDiscountPercentage;

	private double transLimit;

	private int isActive;

	private int companyId;

	private int storeId;

	private int isDeleted;

	private int createdBy;

	private Date createdDate;

	private int updatedBy;

	private Date updatedDate;

	private String lang;

	private double opBalance;

	private String asOnDate;

	private int finyrId;

	private int pst_type_id;

	private String group_name;
	private String pst_type_code;

	private String group_code;

	private double aboveScheme;
	private int state_id;
	private int country_id;
	private String state_name;

	private String country_name;

	private String type_name;

	 private int dueDays;
	 private double duePer;

	/**
	 * @return the type_name
	 */
	public String getType_name() {
		return type_name;
	}

	/**
	 * @param type_name
	 *            the type_name to set
	 */
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}

	/**
	 * @return the state_name
	 */
	public String getState_name() {
		return state_name;
	}

	/**
	 * @param state_name
	 *            the state_name to set
	 */
	public void setState_name(String state_name) {
		this.state_name = state_name;
	}

	/**
	 * @return the country_name
	 */
	public String getCountry_name() {
		return country_name;
	}

	/**
	 * @param country_name
	 *            the country_name to set
	 */
	public void setCountry_name(String country_name) {
		this.country_name = country_name;
	}

	/**
	 * @return the state_id
	 */
	public int getState_id() {
		return state_id;
	}

	/**
	 * @param state_id
	 *            the state_id to set
	 */
	public void setState_id(int state_id) {
		this.state_id = state_id;
	}

	/**
	 * @return the country_id
	 */
	public int getCountry_id() {
		return country_id;
	}

	/**
	 * @param country_id
	 *            the country_id to set
	 */
	public void setCountry_id(int country_id) {
		this.country_id = country_id;
	}

	/**
	 * @return the aboveScheme
	 */
	public double getAboveScheme() {
		return aboveScheme;
	}

	/**
	 * @param aboveScheme
	 *            the aboveScheme to set
	 */
	public void setAboveScheme(double aboveScheme) {
		this.aboveScheme = aboveScheme;
	}

	/**
	 * @return the group_code
	 */
	public String getGroup_code() {
		return group_code;
	}

	/**
	 * @param group_code
	 *            the group_code to set
	 */
	public void setGroup_code(String group_code) {
		this.group_code = group_code;
	}

	/**
	 * @return the group_name
	 */
	public String getGroup_name() {
		return group_name;
	}

	/**
	 * @param group_name
	 *            the group_name to set
	 */
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}

	/**
	 * @return the pst_type_code
	 */
	public String getPst_type_code() {
		return pst_type_code;
	}

	/**
	 * @param pst_type_code
	 *            the pst_type_code to set
	 */
	public void setPst_type_code(String pst_type_code) {
		this.pst_type_code = pst_type_code;
	}

	/**
	 * @return the pst_type_id
	 */
	public int getPst_type_id() {
		return pst_type_id;
	}

	/**
	 * @param pst_type_id
	 *            the pst_type_id to set
	 */
	public void setPst_type_id(int pst_type_id) {
		this.pst_type_id = pst_type_id;
	}

	private double outstandingAmount;

	/**
	 * @return the outstandingAmount
	 */
	public double getOutstandingAmount() {
		return outstandingAmount;
	}

	/**
	 * @param outstandingAmount
	 *            the outstandingAmount to set
	 */
	public void setOutstandingAmount(double outstandingAmount) {
		this.outstandingAmount = outstandingAmount;
	}

	/**
	 *
	 */
	public AccountDTO() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id
	 *            the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the groupId
	 */
	public int getGroupId() {
		return groupId;
	}

	/**
	 * @param groupId
	 *            the groupId to set
	 */
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code
	 *            the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @return the cityId
	 */
	public int getCityId() {
		return cityId;
	}

	/**
	 * @param cityId
	 *            the cityId to set
	 */
	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	/**
	 * @return the zoneId
	 */
	public int getZoneId() {
		return zoneId;
	}

	/**
	 * @param zoneId
	 *            the zoneId to set
	 */
	public void setZoneId(int zoneId) {
		this.zoneId = zoneId;
	}

	/**
	 * @return the areaId
	 */
	public int getAreaId() {
		return areaId;
	}

	/**
	 * @param areaId
	 *            the areaId to set
	 */
	public void setAreaId(int areaId) {
		this.areaId = areaId;
	}

	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address
	 *            the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * @param phone
	 *            the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * @return the pin
	 */
	public String getPin() {
		return pin;
	}

	/**
	 * @param pin
	 *            the pin to set
	 */
	public void setPin(String pin) {
		this.pin = pin;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email
	 *            the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the panNo
	 */
	public String getPanNo() {
		return panNo;
	}

	/**
	 * @param panNo
	 *            the panNo to set
	 */
	public void setPanNo(String panNo) {
		this.panNo = panNo;
	}

	/**
	 * @return the gstRegistrationNo
	 */
	public String getGstRegistrationNo() {
		return gstRegistrationNo;
	}

	/**
	 * @param gstRegistrationNo
	 *            the gstRegistrationNo to set
	 */
	public void setGstRegistrationNo(String gstRegistrationNo) {
		this.gstRegistrationNo = gstRegistrationNo;
	}

	/**
	 * @return the bcdaRegistrationNo
	 */
	public String getBcdaRegistrationNo() {
		return bcdaRegistrationNo;
	}

	/**
	 * @param bcdaRegistrationNo
	 *            the bcdaRegistrationNo to set
	 */
	public void setBcdaRegistrationNo(String bcdaRegistrationNo) {
		this.bcdaRegistrationNo = bcdaRegistrationNo;
	}

	/**
	 * @return the dlNo
	 */
	public String getDlNo() {
		return dlNo;
	}

	/**
	 * @param dlNo
	 *            the dlNo to set
	 */
	public void setDlNo(String dlNo) {
		this.dlNo = dlNo;
	}

	/**
	 * @return the cashDiscountPercentage
	 */
	public double getCashDiscountPercentage() {
		return cashDiscountPercentage;
	}

	/**
	 * @param cashDiscountPercentage
	 *            the cashDiscountPercentage to set
	 */
	public void setCashDiscountPercentage(double cashDiscountPercentage) {
		this.cashDiscountPercentage = cashDiscountPercentage;
	}

	/**
	 * @return the transLimit
	 */
	public double getTransLimit() {
		return transLimit;
	}

	/**
	 * @param transLimit
	 *            the transLimit to set
	 */
	public void setTransLimit(double transLimit) {
		this.transLimit = transLimit;
	}

	/**
	 * @return the isActive
	 */
	public int getIsActive() {
		return isActive;
	}

	/**
	 * @param isActive
	 *            the isActive to set
	 */
	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	/**
	 * @return the companyId
	 */
	public int getCompanyId() {
		return companyId;
	}

	/**
	 * @param companyId
	 *            the companyId to set
	 */
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}

	/**
	 * @return the storeId
	 */
	public int getStoreId() {
		return storeId;
	}

	/**
	 * @param storeId
	 *            the storeId to set
	 */
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	/**
	 * @return the isDeleted
	 */
	public int getIsDeleted() {
		return isDeleted;
	}

	/**
	 * @param isDeleted
	 *            the isDeleted to set
	 */
	public void setIsDeleted(int isDeleted) {
		this.isDeleted = isDeleted;
	}

	/**
	 * @return the createdBy
	 */
	public int getCreatedBy() {
		return createdBy;
	}

	/**
	 * @param createdBy
	 *            the createdBy to set
	 */
	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	/**
	 * @return the createdDate
	 */
	public Date getCreatedDate() {
		return createdDate;
	}

	/**
	 * @param createdDate
	 *            the createdDate to set
	 */
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	/**
	 * @return the updatedBy
	 */
	public int getUpdatedBy() {
		return updatedBy;
	}

	/**
	 * @param updatedBy
	 *            the updatedBy to set
	 */
	public void setUpdatedBy(int updatedBy) {
		this.updatedBy = updatedBy;
	}

	/**
	 * @return the updatedDate
	 */
	public Date getUpdatedDate() {
		return updatedDate;
	}

	/**
	 * @param updatedDate
	 *            the updatedDate to set
	 */
	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	/**
	 * @return the lang
	 */
	public String getLang() {
		return lang;
	}

	/**
	 * @param lang
	 *            the lang to set
	 */
	public void setLang(String lang) {
		this.lang = lang;
	}

	/**
	 * @return the opBalance
	 */
	public double getOpBalance() {
		return opBalance;
	}

	/**
	 * @param opBalance
	 *            the opBalance to set
	 */
	public void setOpBalance(double opBalance) {
		this.opBalance = opBalance;
	}

	/**
	 * @return the asOnDate
	 */
	public String getAsOnDate() {
		return asOnDate;
	}

	/**
	 * @param asOnDate
	 *            the asOnDate to set
	 */
	public void setAsOnDate(String asOnDate) {
		this.asOnDate = asOnDate;
	}

	/**
	 * @return the finyrId
	 */
	public int getFinyrId() {
		return finyrId;
	}

	/**
	 * @param finyrId
	 *            the finyrId to set
	 */
	public void setFinyrId(int finyrId) {
		this.finyrId = finyrId;
	}

	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}



	/**
	 * @return the dueDays
	 */
	public int getDueDays() {
		return dueDays;
	}

	/**
	 * @param dueDays the dueDays to set
	 */
	public void setDueDays(int dueDays) {
		this.dueDays = dueDays;
	}

	/**
	 * @return the duePer
	 */
	public double getDuePer() {
		return duePer;
	}

	/**
	 * @param duePer the duePer to set
	 */
	public void setDuePer(double duePer) {
		this.duePer = duePer;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AccountDTO [id=" + id + ", groupId=" + groupId + ", name=" + name + ", code=" + code + ", cityId="
				+ cityId + ", zoneId=" + zoneId + ", areaId=" + areaId + ", address=" + address + ", phone=" + phone
				+ ", pin=" + pin + ", email=" + email + ", panNo=" + panNo + ", gstRegistrationNo=" + gstRegistrationNo
				+ ", bcdaRegistrationNo=" + bcdaRegistrationNo + ", dlNo=" + dlNo + ", cashDiscountPercentage="
				+ cashDiscountPercentage + ", transLimit=" + transLimit + ", isActive=" + isActive + ", companyId="
				+ companyId + ", storeId=" + storeId + ", isDeleted=" + isDeleted + ", createdBy=" + createdBy
				+ ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate
				+ ", lang=" + lang + ", opBalance=" + opBalance + ", asOnDate=" + asOnDate + ", finyrId=" + finyrId
				+ ", pst_type_id=" + pst_type_id + ", group_name=" + group_name + ", pst_type_code=" + pst_type_code
				+ ", group_code=" + group_code + ", aboveScheme=" + aboveScheme + ", state_id=" + state_id
				+ ", country_id=" + country_id + ", state_name=" + state_name + ", country_name=" + country_name
				+ ", type_name=" + type_name + ", dueDays=" + dueDays + ", duePer=" + duePer + ", outstandingAmount="
				+ outstandingAmount + "]";
	}


}
