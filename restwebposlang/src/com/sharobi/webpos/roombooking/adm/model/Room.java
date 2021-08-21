package com.sharobi.webpos.roombooking.adm.model;

import java.io.Serializable;
import java.util.Date;


	
	public class Room implements Serializable {

	     private static final long serialVersionUID = 1L;

	     private int id;
	     private String hotelId;
	     private int floor;
	     private String roomNo;
	     private RoomType roomTypeId;

         private String roomCategory;
         private String roomCapacity;
         private double roomPrice;       
         private String roomName;
         private String roomDesc;
         private TaxForRoomBook taxId;
         private String roomSize;
         private String roomSizeUnit;
         private int status;
         
         private String isBooked;
         private String isStatus;
         private String isCheckIn;
         
         
         
         private String custName;
         private String custPh;
         private double advPayment;
         private String fromDate;
         private String toDate;
         private String reserveId;
         private String bookingDate;
         private String bookingNo;
        
           
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

		public RoomType getRoomTypeId() {
			return roomTypeId;
		}

		public void setRoomTypeId(RoomType roomTypeId) {
			this.roomTypeId = roomTypeId;
		}

		

		public String getRoomCategory() {
			return roomCategory;
		}

		public void setRoomCategory(String roomCategory) {
			this.roomCategory = roomCategory;
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

		public TaxForRoomBook getTaxId() {
			return taxId;
		}

		public void setTaxId(TaxForRoomBook taxId) {
			this.taxId = taxId;
		}

	

		public String getIsBooked() {
			return isBooked;
		}

		public void setIsBooked(String isBooked) {
			this.isBooked = isBooked;
		}

		public String getIsStatus() {
			return isStatus;
		}

		public void setIsStatus(String isStatus) {
			this.isStatus = isStatus;
		}

		public String getIsCheckIn() {
			return isCheckIn;
		}

		public void setIsCheckIn(String isCheckIn) {
			this.isCheckIn = isCheckIn;
		}
        public String getCustName() {
			return custName;
		}

		public void setCustName(String custName) {
			this.custName = custName;
		}

		public String getCustPh() {
			return custPh;
		}

		public void setCustPh(String custPh) {
			this.custPh = custPh;
		}

		public double getAdvPayment() {
			return advPayment;
		}

		public void setAdvPayment(double advPayment) {
			this.advPayment = advPayment;
		}

		public String getFromDate() {
			return fromDate;
		}

		public void setFromDate(String fromDate) {
			this.fromDate = fromDate;
		}

		public String getToDate() {
			return toDate;
		}

		public void setToDate(String toDate) {
			this.toDate = toDate;
		}

		public String getReserveId() {
			return reserveId;
		}

		public void setReserveId(String reserveId) {
			this.reserveId = reserveId;
		}

		public String getBookingDate() {
			return bookingDate;
		}

		public void setBookingDate(String bookingDate) {
			this.bookingDate = bookingDate;
		}

    public String getBookingNo() {
      return bookingNo;
    }

    public void setBookingNo(String bookingNo) {
      this.bookingNo = bookingNo;
    }

    @Override
    public String toString() {
      return "Room [id=" + id + ", hotelId=" + hotelId + ", floor=" + floor + ", roomNo=" + roomNo + ", roomTypeId="
          + roomTypeId + ", roomCategory=" + roomCategory + ", roomCapacity=" + roomCapacity + ", roomPrice="
          + roomPrice + ", roomName=" + roomName + ", roomDesc=" + roomDesc + ", taxId=" + taxId + ", roomSize="
          + roomSize + ", roomSizeUnit=" + roomSizeUnit + ", status=" + status + ", isBooked=" + isBooked
          + ", isStatus=" + isStatus + ", isCheckIn=" + isCheckIn + ", custName=" + custName + ", custPh=" + custPh
          + ", advPayment=" + advPayment + ", fromDate=" + fromDate + ", toDate=" + toDate + ", reserveId=" + reserveId
          + ", bookingDate=" + bookingDate + ", bookingNo=" + bookingNo + "]";
    }

		
	

	}




