/**
 * 
 */
package com.sharobi.webpos.base.model;

import java.io.Serializable;
import java.util.List;

/**
 * @author habib
 * 
 */
public class Table implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int tableId;
	private String tableNo;
	private String tableDescription;
	private int seatingCapacity;
	private String status;
	private String isBooked = "N";
	private Order order;
	private int noofItem;
	private double orderAmt;
	private String ischildTable = "N";
	private String parentTable;
	private String multiOrder;
	private int noofOrder;
	private int xPos;
	private int yPos;
	private int section;
	private List<Order> multiOrders;
	private String isBilled = "N";

	public int getTableId() {
		return tableId;
	}

	public void setTableId(int tableId) {
		this.tableId = tableId;
	}

	public String getTableNo() {
		return tableNo;
	}

	public void setTableNo(String tableNo) {
		this.tableNo = tableNo;
	}

	public String getTableDescription() {
		return tableDescription;
	}

	public void setTableDescription(String tableDescription) {
		this.tableDescription = tableDescription;
	}

	public int getSeatingCapacity() {
		return seatingCapacity;
	}

	public void setSeatingCapacity(int seatingCapacity) {
		this.seatingCapacity = seatingCapacity;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getIsBooked() {
		return isBooked;
	}

	public void setIsBooked(String isBooked) {
		this.isBooked = isBooked;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public int getNoofItem() {
		return noofItem;
	}

	public void setNoofItem(int noofItem) {
		this.noofItem = noofItem;
	}

	public double getOrderAmt() {
		return orderAmt;
	}

	public void setOrderAmt(double orderAmt) {
		this.orderAmt = orderAmt;
	}

	public String getIschildTable() {
		return ischildTable;
	}

	public void setIschildTable(String ischildTable) {
		this.ischildTable = ischildTable;
	}

	public String getParentTable() {
		return parentTable;
	}

	public void setParentTable(String parentTable) {
		this.parentTable = parentTable;
	}

	public String getMultiOrder() {
		return multiOrder;
	}

	public void setMultiOrder(String multiOrder) {
		this.multiOrder = multiOrder;
	}

	public int getNoofOrder() {
		return noofOrder;
	}

	public void setNoofOrder(int noofOrder) {
		this.noofOrder = noofOrder;
	}

	public List<Order> getMultiOrders() {
		return multiOrders;
	}

	public void setMultiOrders(List<Order> multiOrders) {
		this.multiOrders = multiOrders;
	}

	public int getxPos() {
		return xPos;
	}

	public void setxPos(int xPos) {
		this.xPos = xPos;
	}

	public int getyPos() {
		return yPos;
	}

	public void setyPos(int yPos) {
		this.yPos = yPos;
	}

	public int getSection() {
		return section;
	}

	public void setSection(int section) {
		this.section = section;
	}


	/*@Override
	public String toString() {
		return "Table [tableId=" + tableId + ", tableNo=" + tableNo + ", tableDescription=" + tableDescription + ", seatingCapacity=" + seatingCapacity + ", status=" + status + ", isBooked=" + isBooked + ", order=" + order + ", noofItem=" + noofItem + ", orderAmt=" + orderAmt + ", ischildTable=" + ischildTable + ", parentTable=" + parentTable + ", multiOrder=" + multiOrder + ", noofOrder=" + noofOrder + ", xPos=" + xPos + ", yPos=" + yPos + ", section=" + section + ", multiOrders=" + multiOrders + "]";
	}*/

	public String getIsBilled() {
		return isBilled;
	}

	public void setIsBilled(String isBilled) {
		this.isBilled = isBilled;
	}

	@Override
	public String toString() {
		return "Table [tableId=" + tableId + ", tableNo=" + tableNo + ", tableDescription=" + tableDescription
				+ ", seatingCapacity=" + seatingCapacity + ", status=" + status + ", isBooked=" + isBooked + ", order="
				+ order + ", noofItem=" + noofItem + ", orderAmt=" + orderAmt + ", ischildTable=" + ischildTable
				+ ", parentTable=" + parentTable + ", multiOrder=" + multiOrder + ", noofOrder=" + noofOrder + ", xPos="
				+ xPos + ", yPos=" + yPos + ", section=" + section + ", multiOrders=" + multiOrders + ", isBilled="
				+ isBilled + "]";
	}
	
	

}
