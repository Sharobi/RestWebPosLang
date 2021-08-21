package com.sharobi.webpos.inv.model;

public class InvItem {
	private int id;
	private String code;
	private String name;
	private int metricUnitId;
	private double rate;
	public InvItem(	int id,
					String code,
					String name,
					int metricUnitId) {
		this.id = id;
		this.code = code;
		this.name = name;
		this.metricUnitId = metricUnitId;
	}

	public InvItem(  int id,
      String code,
      String name,
      int metricUnitId,
      double rate) {
      this.id = id;
      this.code = code;
      this.name = name;
      this.metricUnitId = metricUnitId;
      this.setRate(rate);
	}

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public int getMetricUnitId() {
		return metricUnitId;
	}

	public void setMetricUnitId(int metricUnitId) {
		this.metricUnitId = metricUnitId;
	}


  public double getRate() {
    return rate;
  }

  public void setRate(double rate) {
    this.rate = rate;
  }

  @Override
  public String toString() {
    return "InvItem [id=" + id + ", code=" + code + ", name=" + name + ", metricUnitId=" + metricUnitId + ", rate="
        + rate + "]";
  }
  
  
}
