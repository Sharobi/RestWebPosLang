/**
 *
 */
package com.sharobi.webpos.account.model;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Sk A siddik
 *
 *         Nov 3, 2017
 */
public class AccountGroupDTO implements Serializable {
	private int id;

	private String name;

	private String code;

	private String description;
	private String accountTypeName;
	private int accountTypeId;

	private int companyId;

	private int storeId;

	private int createdBy;

	private Date createdDate;

	private int updatedBy;

	private Date updatedDate;
	private int is_system;
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
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
	 * @param code the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return the accountTypeName
	 */
	public String getAccountTypeName() {
		return accountTypeName;
	}
	/**
	 * @param accountTypeName the accountTypeName to set
	 */
	public void setAccountTypeName(String accountTypeName) {
		this.accountTypeName = accountTypeName;
	}
	/**
	 * @return the accountTypeId
	 */
	public int getAccountTypeId() {
		return accountTypeId;
	}
	/**
	 * @param accountTypeId the accountTypeId to set
	 */
	public void setAccountTypeId(int accountTypeId) {
		this.accountTypeId = accountTypeId;
	}
	/**
	 * @return the companyId
	 */
	public int getCompanyId() {
		return companyId;
	}
	/**
	 * @param companyId the companyId to set
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
	 * @param storeId the storeId to set
	 */
	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}
	/**
	 * @return the createdBy
	 */
	public int getCreatedBy() {
		return createdBy;
	}
	/**
	 * @param createdBy the createdBy to set
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
	 * @param createdDate the createdDate to set
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
	 * @param updatedBy the updatedBy to set
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
	 * @param updatedDate the updatedDate to set
	 */
	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}
	/**
	 * @return the is_system
	 */
	public int getIs_system() {
		return is_system;
	}
	/**
	 * @param is_system the is_system to set
	 */
	public void setIs_system(int is_system) {
		this.is_system = is_system;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AccountGroupDTO [id=" + id + ", name=" + name + ", code=" + code + ", description=" + description
				+ ", accountTypeName=" + accountTypeName + ", accountTypeId=" + accountTypeId + ", companyId="
				+ companyId + ", storeId=" + storeId + ", createdBy=" + createdBy + ", createdDate=" + createdDate
				+ ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + ", is_system=" + is_system + "]";
	}






}
