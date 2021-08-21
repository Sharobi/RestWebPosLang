/**
 *
 */
package com.sharobi.webpos.account.model;

import java.io.Serializable;

/**
 * @author habib
 *
 */
public class QSMaster implements Serializable{

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private int id;
    private String qs;


    /**
	 *
	 */
	public QSMaster() {
		// TODO Auto-generated constructor stub
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
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "QSMaster [id=" + id + ", qs=" + qs + "]";
	}



}
