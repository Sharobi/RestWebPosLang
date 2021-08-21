/**
 *
 */
package com.sharobi.webpos.account.model;

/**
 * @author SK A SIDDIK
 *
 * Feb 23, 2018
 */
public class ParaJournalTypeMaster {

	private int id;

	private int journal_type_id;
	private String journal_type;
	private String journal_prefix;
	private String description ;
	private int company_id;
	private int store_id;

	/**
	 *
	 */
	public ParaJournalTypeMaster() {
		// TODO Auto-generated constructor stub
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
	 * @return the journal_type
	 */
	public String getJournal_type() {
		return journal_type;
	}

	/**
	 * @param journal_type the journal_type to set
	 */
	public void setJournal_type(String journal_type) {
		this.journal_type = journal_type;
	}

	/**
	 * @return the journal_prefix
	 */
	public String getJournal_prefix() {
		return journal_prefix;
	}

	/**
	 * @param journal_prefix the journal_prefix to set
	 */
	public void setJournal_prefix(String journal_prefix) {
		this.journal_prefix = journal_prefix;
	}

	/**
	 * @return the company_id
	 */
	public int getCompany_id() {
		return company_id;
	}

	/**
	 * @param company_id the company_id to set
	 */
	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}

	/**
	 * @return the store_id
	 */
	public int getStore_id() {
		return store_id;
	}

	/**
	 * @param store_id the store_id to set
	 */
	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}



	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ParaJournalTypeMaster [id=" + id + ", journal_type_id=" + journal_type_id + ", journal_type="
				+ journal_type + ", journal_prefix=" + journal_prefix + ", description=" + description + ", company_id="
				+ company_id + ", store_id=" + store_id + "]";
	}





}
