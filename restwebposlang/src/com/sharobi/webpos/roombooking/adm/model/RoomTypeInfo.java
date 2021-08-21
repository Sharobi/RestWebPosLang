package com.sharobi.webpos.roombooking.adm.model;

import java.io.Serializable;

public class RoomTypeInfo implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
    private String hotelId;
    private String roomType;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getHotelId() {
		return hotelId;
	}

	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}

	public String getRoomType() {
		return roomType;
	}

	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}

	@Override
	public String toString() {
		return "RoomTypeInfo [id=" + id + ", hotelId=" + hotelId
				+ ", roomType=" + roomType + "]";
	}

	
}
