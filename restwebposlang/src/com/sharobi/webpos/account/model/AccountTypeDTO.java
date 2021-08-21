/**
 *
 */
package com.sharobi.webpos.account.model;

import java.io.Serializable;

/**
 * @author Sk A siddik
 *
 * Nov 3, 2017
 */
public class AccountTypeDTO implements Serializable{

	private int id;

	private String typeName;

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
	 * @return the typeName
	 */
	public String getTypeName() {
		return typeName;
	}

	/**
	 * @param typeName the typeName to set
	 */
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AccountTypeDTO [id=" + id + ", typeName=" + typeName + "]";
	}


}
