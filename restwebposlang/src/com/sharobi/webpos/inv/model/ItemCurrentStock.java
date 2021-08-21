package com.sharobi.webpos.inv.model;

public class ItemCurrentStock {
  private Integer itemId;
  private String name;
  private Double rate;
  private String unit;
  private String metricUnitId;
  private Double curStock;
  public Integer getItemId() {
    return itemId;
  }
  public void setItemId(Integer itemId) {
    this.itemId = itemId;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public Double getRate() {
    return rate;
  }
  public void setRate(Double rate) {
    this.rate = rate;
  }
  public String getUnit() {
    return unit;
  }
  public void setUnit(String unit) {
    this.unit = unit;
  }
  public String getMetricUnitId() {
    return metricUnitId;
  }
  public void setMetricUnitId(String metricUnitId) {
    this.metricUnitId = metricUnitId;
  }
  public Double getCurStock() {
    return curStock;
  }
  public void setCurStock(Double curStock) {
    this.curStock = curStock;
  }
  @Override
  public String toString() {
    return "ItemCurrentStock [itemId=" + itemId + ", name=" + name + ", rate=" + rate + ", unit=" + unit
        + ", metricUnitId=" + metricUnitId + ", curStock=" + curStock + "]";
  }
  
  
}
