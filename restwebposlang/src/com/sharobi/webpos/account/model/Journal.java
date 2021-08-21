/**
 *
 */
package com.sharobi.webpos.account.model;

/**
 * @author SK A SIDDIK
 *
 *         Feb 22, 2018
 */
public class Journal {

	private int account_id;
	private double dr_amount;
	private double cr_amount;

	private int id;
	private String inv_no;
	private String inv_date;
	private String narration;

	/**
	 * @return the account_name
	 */
	public String getAccount_name() {
		return account_name;
	}

	/**
	 * @param account_name
	 *            the account_name to set
	 */
	public void setAccount_name(String account_name) {
		this.account_name = account_name;
	}

	private String account_name;

	/**
	 *
	 */
	public Journal() {
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
	 * @return the inv_no
	 */
	public String getInv_no() {
		return inv_no;
	}

	/**
	 * @param inv_no
	 *            the inv_no to set
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
	 * @param inv_date
	 *            the inv_date to set
	 */
	public void setInv_date(String inv_date) {
		this.inv_date = inv_date;
	}

	/**
	 * @return the narration
	 */
	public String getNarration() {
		return narration;
	}

	/**
	 * @param narration
	 *            the narration to set
	 */
	public void setNarration(String narration) {
		this.narration = narration;
	}

	/**
	 * @return the account_id
	 */
	public int getAccount_id() {
		return account_id;
	}

	/**
	 * @param account_id
	 *            the account_id to set
	 */
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}

	/**
	 * @return the dr_amount
	 */
	public double getDr_amount() {
		return dr_amount;
	}

	/**
	 * @param dr_amount
	 *            the dr_amount to set
	 */
	public void setDr_amount(double dr_amount) {
		this.dr_amount = dr_amount;
	}

	/**
	 * @return the cr_amount
	 */
	public double getCr_amount() {
		return cr_amount;
	}

	/**
	 * @param cr_amount
	 *            the cr_amount to set
	 */
	public void setCr_amount(double cr_amount) {
		this.cr_amount = cr_amount;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Journal [account_id=" + account_id + ", dr_amount=" + dr_amount + ", cr_amount=" + cr_amount + ", id="
				+ id + ", inv_no=" + inv_no + ", inv_date=" + inv_date + ", narration=" + narration + ", account_name="
				+ account_name + "]";
	}

}
