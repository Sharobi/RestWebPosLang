/**
 * 
 */
package com.sharobi.webpos.adm.model;

import java.io.Serializable;

/**
 * @author srabasti
 *
 */
public class ColorMaster implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String code;
	private int name;
	private String deleteFlag;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getName() {
		return name;
	}
	public void setName(int name) {
		this.name = name;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	@Override
	public String toString() {
		return "ColorMaster [id=" + id + ", code=" + code + ", name=" + name + ", deleteFlag=" + deleteFlag + "]";
	}

	
}
