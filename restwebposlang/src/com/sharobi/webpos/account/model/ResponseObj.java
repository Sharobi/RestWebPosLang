/**
 *
 */
package com.sharobi.webpos.account.model;

import java.io.Serializable;



/**
 * @author habib
 *
 */
public class ResponseObj implements Serializable{

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String status;
	private String reason;

	private String code;

/*	private ItemMaster item;

	public ItemMaster getItem() {
		return item;
	}
	public void setItem(ItemMaster item) {
		this.item = item;
	}*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}


	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	@Override
	public String toString() {
		return "ResponseObj [id=" + id + ", status=" + status + ", reason=" + reason + ", code=" + code + "]";
	}



}
