package com.sharobi.webpos.roombooking.adm.model;

import java.io.Serializable;

public class RoomInfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private int id;
    private String hotelId;
    private int floor;
    private String roomNo;       
    private int roomTypeId;     // PREMIUM DELUX
    
    private String roomCategory;   // AC - NON AC
    private String roomCapacity;
    private double roomPrice;       
    private String roomName;
    private String roomDesc;
    private int roomTax;
    private String roomSize;
    private String roomSizeUnit;
    private int status;
    
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
	public int getFloor() {
		return floor;
	}
	public void setFloor(int floor) {
		this.floor = floor;
	}
	public String getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}
	public int getRoomTypeId() {
		return roomTypeId;
	}
	public void setRoomTypeId(int roomTypeId) {
		this.roomTypeId = roomTypeId;
	}
	
	public String getRoomCapacity() {
		return roomCapacity;
	}
	public void setRoomCapacity(String roomCapacity) {
		this.roomCapacity = roomCapacity;
	}
	public double getRoomPrice() {
		return roomPrice;
	}
	public void setRoomPrice(double roomPrice) {
		this.roomPrice = roomPrice;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getRoomDesc() {
		return roomDesc;
	}
	public void setRoomDesc(String roomDesc) {
		this.roomDesc = roomDesc;
	}
	public int getRoomTax() {
		return roomTax;
	}
	public void setRoomTax(int roomTax) {
		this.roomTax = roomTax;
	}
	public String getRoomSize() {
		return roomSize;
	}
	public void setRoomSize(String roomSize) {
		this.roomSize = roomSize;
	}
	public String getRoomSizeUnit() {
		return roomSizeUnit;
	}
	public void setRoomSizeUnit(String roomSizeUnit) {
		this.roomSizeUnit = roomSizeUnit;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getRoomCategory() {
		return roomCategory;
	}
	public void setRoomCategory(String roomCategory) {
		this.roomCategory = roomCategory;
	}
	@Override
	public String toString() {
		return "RoomInfo [id=" + id + ", hotelId=" + hotelId + ", floor="
				+ floor + ", roomNo=" + roomNo + ", roomTypeId=" + roomTypeId
				+ ", roomCategory=" + roomCategory + ", roomCapacity="
				+ roomCapacity + ", roomPrice=" + roomPrice + ", roomName="
				+ roomName + ", roomDesc=" + roomDesc + ", roomTax=" + roomTax
				+ ", roomSize=" + roomSize + ", roomSizeUnit=" + roomSizeUnit
				+ ", status=" + status + "]";
	}
	

}
