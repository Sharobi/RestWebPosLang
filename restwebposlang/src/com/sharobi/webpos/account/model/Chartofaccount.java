/**
 *
 */
package com.sharobi.webpos.account.model;
/**
 * @author Sk A siddik
 *
 * Mar 14, 2018
 */
public class Chartofaccount {
	private static final long serialVersionUID = 1L;
    private int type_id;

	private String type_name;

	private String group_name;
	private int group_id;
	private String account_name;
	private int account_id;


	 private String asOnDate;
	private String balance_type;
	private double current_balance;

	/**
	 *
	 */
	public Chartofaccount() {
		// TODO Auto-generated constructor stub
	}


	/**
	 * @return the balance_type
	 */
	public String getBalance_type() {
		return balance_type;
	}


	/**
	 * @param balance_type the balance_type to set
	 */
	public void setBalance_type(String balance_type) {
		this.balance_type = balance_type;
	}


	/**
	 * @return the current_balance
	 */
	public double getCurrent_balance() {
		return current_balance;
	}


	/**
	 * @param current_balance the current_balance to set
	 */
	public void setCurrent_balance(double current_balance) {
		this.current_balance = current_balance;
	}


	/**
	 * @return the asOnDate
	 */
	public String getAsOnDate() {
		return asOnDate;
	}

	/**
	 * @param asOnDate the asOnDate to set
	 */
	public void setAsOnDate(String asOnDate) {
		this.asOnDate = asOnDate;
	}

	/**
	 * @return the type_id
	 */
	public int getType_id() {
		return type_id;
	}

	/**
	 * @param type_id the type_id to set
	 */
	public void setType_id(int type_id) {
		this.type_id = type_id;
	}

	/**
	 * @return the type_name
	 */
	public String getType_name() {
		return type_name;
	}

	/**
	 * @param type_name the type_name to set
	 */
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}

	/**
	 * @return the group_name
	 */
	public String getGroup_name() {
		return group_name;
	}

	/**
	 * @param group_name the group_name to set
	 */
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}

	/**
	 * @return the group_id
	 */
	public int getGroup_id() {
		return group_id;
	}

	/**
	 * @param group_id the group_id to set
	 */
	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}

	/**
	 * @return the account_name
	 */
	public String getAccount_name() {
		return account_name;
	}

	/**
	 * @param account_name the account_name to set
	 */
	public void setAccount_name(String account_name) {
		this.account_name = account_name;
	}

	/**
	 * @return the account_id
	 */
	public int getAccount_id() {
		return account_id;
	}

	/**
	 * @param account_id the account_id to set
	 */
	public void setAccount_id(int account_id) {
		this.account_id = account_id;
	}


	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Chartofaccount [type_id=" + type_id + ", type_name=" + type_name + ", group_name=" + group_name
				+ ", group_id=" + group_id + ", account_name=" + account_name + ", account_id=" + account_id
				+ ", asOnDate=" + asOnDate + ", balance_type=" + balance_type + ", current_balance=" + current_balance
				+ "]";
	}











}
