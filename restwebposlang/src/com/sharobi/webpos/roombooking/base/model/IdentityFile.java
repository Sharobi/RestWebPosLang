package com.sharobi.webpos.roombooking.base.model;

import java.util.Arrays;

public class IdentityFile {


	private static final long serialVersionUID = 1L;
	
	private String fileName;

	private byte[] data;

	private int storeId;

	private String bytes;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public byte[] getData() {
		return data;
	}

	public void setData(byte[] data) {
		this.data = data;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public String getBytes() {
		return bytes;
	}

	public void setBytes(String bytes) {
		this.bytes = bytes;
	}

	@Override
	public String toString() {
		return "IdentityFile [fileName=" + fileName + ", data="
				+ Arrays.toString(data) + ", storeId=" + storeId + ", bytes="
				+ bytes + "]";
	}

}
