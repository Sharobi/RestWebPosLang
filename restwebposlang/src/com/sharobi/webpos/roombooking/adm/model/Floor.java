package com.sharobi.webpos.roombooking.adm.model;

import java.util.List;

public class Floor {

	private List<Room> room;
	private String floor;

	public List<Room> getRoom() {
		return room;
	}

	public void setRoom(List<Room> room) {
		this.room = room;
	}

	
	public String getFloor() {
		return floor;
	}

	public void setFloor(String floor) {
		this.floor = floor;
	}

	@Override
	public String toString() {
		return "Floor [room=" + room + ", floor=" + floor + "]";
	}
 
	
}
