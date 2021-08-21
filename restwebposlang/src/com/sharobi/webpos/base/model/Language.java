package com.sharobi.webpos.base.model;

import java.io.Serializable;

public class Language implements Serializable {

	
    private static final long serialVersionUID = 1L;

    
    protected int id;
    protected String language;
    protected String codeAndroid;
    protected String codeWeb;
    protected String codeIOS;
    protected String status;
    protected String deleteFlag;
    protected Store store;
    
    public Language() {}
    
    public Language(Language language) {
    	this.id = language.getId();
    	this.store = language.getStore();
    	this.language = language.getLanguage();
    	this.codeAndroid = language.getCodeAndroid();
    	this.codeIOS = language.getCodeIOS();
    	this.status = language.getStatus();
    	this.deleteFlag = language.getDeleteFlag();
    }

    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getCodeAndroid() {
		return codeAndroid;
	}
	public void setCodeAndroid(String codeAndroid) {
		this.codeAndroid = codeAndroid;
	}
	
	public String getCodeWeb() {
		return codeWeb;
	}
	public void setCodeWeb(String codeWeb) {
		this.codeWeb = codeWeb;
	}
	public String getCodeIOS() {
		return codeIOS;
	}
	public void setCodeIOS(String codeIOS) {
		this.codeIOS = codeIOS;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	
	public Store getStore() {
		return store;
	}
	public void setStore(Store store) {
		this.store = store;
	}
	@Override
	public String toString() {
		return "Language [id=" + id + ", language=" + language
				+ ", codeAndroid=" + codeAndroid + ", codeWeb=" + codeWeb
				+ ", codeIOS=" + codeIOS + ", status=" + status
				+ ", deleteFlag=" + deleteFlag + ", store=" + store + "]";
	}


}
