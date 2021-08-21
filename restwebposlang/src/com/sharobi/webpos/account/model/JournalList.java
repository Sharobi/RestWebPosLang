/**
 *
 */
package com.sharobi.webpos.account.model;

import java.util.List;

/**
 * @author SK A SIDDIK
 *
 * Feb 22, 2018
 */
public class JournalList {

private String entrydate;

private String naration;
private List<Journal> journallist;

private double drtotal;
private double crtotal;


private int id;



private String inv_no;
private String inv_date;


private int companyId;

private int storeId;

private int createdBy;
private String lang;
private int finyrId;

private String qs;

private int journal_type_id;
private String finyrCode;

private String entry_type;

/**
 *
 */
public JournalList() {
	// TODO Auto-generated constructor stub
}



/**
 * @return the entry_type
 */
public String getEntry_type() {
	return entry_type;
}



/**
 * @param entry_type the entry_type to set
 */
public void setEntry_type(String entry_type) {
	this.entry_type = entry_type;
}




/**
 * @return the entrydate
 */
public String getEntrydate() {
	return entrydate;
}

/**
 * @param entrydate the entrydate to set
 */
public void setEntrydate(String entrydate) {
	this.entrydate = entrydate;
}

/**
 * @return the naration
 */
public String getNaration() {
	return naration;
}

/**
 * @param naration the naration to set
 */
public void setNaration(String naration) {
	this.naration = naration;
}

/**
 * @return the journallist
 */
public List<Journal> getJournallist() {
	return journallist;
}

/**
 * @param journallist the journallist to set
 */
public void setJournallist(List<Journal> journallist) {
	this.journallist = journallist;
}

/**
 * @return the drtotal
 */
public double getDrtotal() {
	return drtotal;
}

/**
 * @param drtotal the drtotal to set
 */
public void setDrtotal(double drtotal) {
	this.drtotal = drtotal;
}

/**
 * @return the crtotal
 */
public double getCrtotal() {
	return crtotal;
}

/**
 * @param crtotal the crtotal to set
 */
public void setCrtotal(double crtotal) {
	this.crtotal = crtotal;
}

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
 * @return the inv_no
 */
public String getInv_no() {
	return inv_no;
}

/**
 * @param inv_no the inv_no to set
 */
public void setInv_no(String inv_no) {
	this.inv_no = inv_no;
}

/**
 * @return the inv_date
 */
public String getInv_date() {
	return inv_date;
}

/**
 * @param inv_date the inv_date to set
 */
public void setInv_date(String inv_date) {
	this.inv_date = inv_date;
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
 * @return the lang
 */
public String getLang() {
	return lang;
}

/**
 * @param lang the lang to set
 */
public void setLang(String lang) {
	this.lang = lang;
}

/**
 * @return the finyrId
 */
public int getFinyrId() {
	return finyrId;
}

/**
 * @param finyrId the finyrId to set
 */
public void setFinyrId(int finyrId) {
	this.finyrId = finyrId;
}

/**
 * @return the qs
 */
public String getQs() {
	return qs;
}

/**
 * @param qs the qs to set
 */
public void setQs(String qs) {
	this.qs = qs;
}

/**
 * @return the journal_type_id
 */
public int getJournal_type_id() {
	return journal_type_id;
}

/**
 * @param journal_type_id the journal_type_id to set
 */
public void setJournal_type_id(int journal_type_id) {
	this.journal_type_id = journal_type_id;
}

/**
 * @return the finyrCode
 */
public String getFinyrCode() {
	return finyrCode;
}

/**
 * @param finyrCode the finyrCode to set
 */
public void setFinyrCode(String finyrCode) {
	this.finyrCode = finyrCode;
}



/* (non-Javadoc)
 * @see java.lang.Object#toString()
 */
@Override
public String toString() {
	return "JournalList [entrydate=" + entrydate + ", naration=" + naration + ", journallist=" + journallist
			+ ", drtotal=" + drtotal + ", crtotal=" + crtotal + ", id=" + id + ", inv_no=" + inv_no + ", inv_date="
			+ inv_date + ", companyId=" + companyId + ", storeId=" + storeId + ", createdBy=" + createdBy + ", lang="
			+ lang + ", finyrId=" + finyrId + ", qs=" + qs + ", journal_type_id=" + journal_type_id + ", finyrCode="
			+ finyrCode + ", entry_type=" + entry_type + "]";
}
















}
