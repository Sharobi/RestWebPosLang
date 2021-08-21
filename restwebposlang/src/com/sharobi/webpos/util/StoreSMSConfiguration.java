package com.sharobi.webpos.util;

public class StoreSMSConfiguration {
	private int id;
	private int storeId;
	private String merchantId;
	private String email;
	private String type;
	private String subId;
	private String requestUrl;
	private String requestMethod;
	private String contentType;
	private String merchantIdHeader;
	private String deleteFlag;
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
	public String getMerchantId() {
		return merchantId;
	}
	public void setMerchantId(String merchantId) {
		this.merchantId = merchantId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSubId() {
		return subId;
	}
	public void setSubId(String subId) {
		this.subId = subId;
	}
	public String getRequestUrl() {
		return requestUrl;
	}
	public void setRequestUrl(String requestUrl) {
		this.requestUrl = requestUrl;
	}
	public String getRequestMethod() {
		return requestMethod;
	}
	public void setRequestMethod(String requestMethod) {
		this.requestMethod = requestMethod;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	public String getMerchantIdHeader() {
		return merchantIdHeader;
	}
	public void setMerchantIdHeader(String merchantIdHeader) {
		this.merchantIdHeader = merchantIdHeader;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	@Override
	public String toString() {
		return "StoreSMSConfiguration [id=" + id + ", storeId=" + storeId + ", merchantId=" + merchantId + ", email="
				+ email + ", type=" + type + ", subId=" + subId + ", requestUrl=" + requestUrl + ", requestMethod="
				+ requestMethod + ", contentType=" + contentType + ", merchantIdHeader=" + merchantIdHeader
				+ ", deleteFlag=" + deleteFlag + "]";
	}
	
	
}
