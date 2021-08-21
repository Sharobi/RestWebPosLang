package com.sharobi.webpos.account.model;
import java.io.Serializable;
import java.util.Date;

public class CommonResultSetMapper implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int companyId;
	private int storeId;
	private String name;
	private String lang;
	private int itemId;
	private String itemName;
	private String brandName;
	private String contentName;
	private String manufacturerName;
	private String packUnitName;
	private String looseUnitName;
	private String rackName;
	private int conv;
	private String groupName;
	private String schdName;
	private double price;
	private String queryCondn;
	private int purInvId;
	private int finYrId;
	private String startDate;
	private String endDate;
	private String invoiceNo;
	private String purOrderNo;
	private String distributorName;
	private int distributorId;
	private String upToDate;
    private int noOfExpiryMonth;
    private int saleId;
    private int custId;
    private String custName;
    private String custPh;
    private int status;
    private String doctorName;
    private String doctorPh;
    private String asOnDate;
	private String searchCriteria; // use for web
	private int deletedBy;
    private int createdBy;
    private int manuId;
    private int contentId;
    private String batchNo;
    private String expiryDateFormat;
    private double mrp;
    private int saleReturnId;
    private int noOfMonthBefore;
    private String manufacturerCode;
    private int purchaseReturnId;
    private int paymentId;
    private String paymentDate;
    private String finyrCode; // new used for search in reprint cash memo
    private int expiryId;
    private int taxId;
    private int isGroup;
    private String taxName;
    private int purTaxId;
    private String purTaxName;
    private int salTaxId;
    private String salTaxName;
    private double taxPer;
    private int noOfRows;
    private String frmDate;
    private String toDate;
    private String sku;
    private String hsnCode;
    private String retType;
    private int purchaseOrderId;
    private String invDate;
    private String poGenType;
    private String noteLineOne;
    private String noteLineTwo;
    private int isRePrint;
    private int printCount;
    private String remarks;
    private String barCode;
    private int lastSaleDays;
    private int comingPurchaseDays;
    private int noOfDays;
    private String billNo;
    private String marketerCode;
    private String accntGrpName;
	private String marketerName;
	private double purchaseRate;
	private double saleRate;
	private Date launchDate;
	private Date discontinueDate;
    private int countryId;
    private int stateId;
    private int cityId;
    private int zoneId;
    private String districtName;
    private int variantTypeId;
    private String variantTypeName;
    private int menuID;
	private int retailTypeID;
	private double listedMrp;
    private int catId;
    private String expDate;
    private int saleDetailsId;
    private String qs;
	private String mulSeriesPrefix;

	/*
	 * add for account
	 */

    private String qryCondition;

    private String groupCode;
    private int accountID;
    private int referenceID;

    private String purchaseIds;

	/**
	 * @return the qryCondition
	 */
	public String getQryCondition() {
		return qryCondition;
	}
	/**
	 * @param qryCondition the qryCondition to set
	 */
	public void setQryCondition(String qryCondition) {
		this.qryCondition = qryCondition;
	}
	/**
	 * @return the groupCode
	 */
	public String getGroupCode() {
		return groupCode;
	}
	/**
	 * @param groupCode the groupCode to set
	 */
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	/**
	 * @return the accountID
	 */
	public int getAccountID() {
		return accountID;
	}
	/**
	 * @param accountID the accountID to set
	 */
	public void setAccountID(int accountID) {
		this.accountID = accountID;
	}
	/**
	 * @return the referenceID
	 */
	public int getReferenceID() {
		return referenceID;
	}
	/**
	 * @param referenceID the referenceID to set
	 */
	public void setReferenceID(int referenceID) {
		this.referenceID = referenceID;
	}
	public int getCityId() {
		return cityId;
	}
	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public int getZoneId() {
		return zoneId;
	}
	public void setZoneId(int zoneId) {
		this.zoneId = zoneId;
	}

	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getBillNo() {
		return billNo;
	}
	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public String getPoGenType() {
		return poGenType;
	}
	public void setPoGenType(String poGenType) {
		this.poGenType = poGenType;
	}

	public String getRetType() {
		return retType;
	}

	public void setRetType(String retType) {
		this.retType = retType;
	}

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public String getHsnCode() {
		return hsnCode;
	}

	public void setHsnCode(String hsnCode) {
		this.hsnCode = hsnCode;
	}

	public int getTaxId() {
		return taxId;
	}

	public void setTaxId(int taxId) {
		this.taxId = taxId;
	}

	public int getIsGroup() {
		return isGroup;
	}

	public void setIsGroup(int isGroup) {
		this.isGroup = isGroup;
	}

	public String getTaxName() {
		return taxName;
	}

	public void setTaxName(String taxName) {
		this.taxName = taxName;
	}

	public int getPurTaxId() {
		return purTaxId;
	}

	public void setPurTaxId(int purTaxId) {
		this.purTaxId = purTaxId;
	}

	public String getPurTaxName() {
		return purTaxName;
	}

	public void setPurTaxName(String purTaxName) {
		this.purTaxName = purTaxName;
	}

	public int getSalTaxId() {
		return salTaxId;
	}

	public void setSalTaxId(int salTaxId) {
		this.salTaxId = salTaxId;
	}

	public String getSalTaxName() {
		return salTaxName;
	}

	public void setSalTaxName(String salTaxName) {
		this.salTaxName = salTaxName;
	}

	public int getExpiryId() {
		return expiryId;
	}

	public void setExpiryId(int expiryId) {
		this.expiryId = expiryId;
	}

	public String getFinyrCode() {
		return finyrCode;
	}

	public void setFinyrCode(String finyrCode) {
		this.finyrCode = finyrCode;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCompanyId() {
		return companyId;
	}

	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}

	public int getStoreId() {
		return storeId;
	}

	public void setStoreId(int storeId) {
		this.storeId = storeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getContentName() {
		return contentName;
	}

	public void setContentName(String contentName) {
		this.contentName = contentName;
	}

	public String getManufacturerName() {
		return manufacturerName;
	}

	public void setManufacturerName(String manufacturerName) {
		this.manufacturerName = manufacturerName;
	}

	public String getPackUnitName() {
		return packUnitName;
	}

	public void setPackUnitName(String packUnitName) {
		this.packUnitName = packUnitName;
	}

	public String getLooseUnitName() {
		return looseUnitName;
	}

	public void setLooseUnitName(String looseUnitName) {
		this.looseUnitName = looseUnitName;
	}

	public String getRackName() {
		return rackName;
	}

	public void setRackName(String rackName) {
		this.rackName = rackName;
	}

	public int getConv() {
		return conv;
	}

	public void setConv(int conv) {
		this.conv = conv;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getSchdName() {
		return schdName;
	}

	public void setSchdName(String schdName) {
		this.schdName = schdName;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getQueryCondn() {
		return queryCondn;
	}

	public void setQueryCondn(String queryCondn) {
		this.queryCondn = queryCondn;
	}

	public int getPurInvId() {
		return purInvId;
	}

	public void setPurInvId(int purInvId) {
		this.purInvId = purInvId;
	}

	public int getFinYrId() {
		return finYrId;
	}

	public void setFinYrId(int finYrId) {
		this.finYrId = finYrId;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getInvoiceNo() {
		return invoiceNo;
	}

	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}

	public String getPurOrderNo() {
		return purOrderNo;
	}

	public void setPurOrderNo(String purOrderNo) {
		this.purOrderNo = purOrderNo;
	}

	public String getDistributorName() {
		return distributorName;
	}

	public void setDistributorName(String distributorName) {
		this.distributorName = distributorName;
	}

	public String getSearchCriteria() {
		return searchCriteria;
	}

	public void setSearchCriteria(String searchCriteria) {
		this.searchCriteria = searchCriteria;
	}

	public int getDistributorId() {
		return distributorId;
	}

	public void setDistributorId(int distributorId) {
		this.distributorId = distributorId;
	}

	public String getUpToDate() {
		return upToDate;
	}

	public void setUpToDate(String upToDate) {
		this.upToDate = upToDate;
	}

	public int getNoOfExpiryMonth() {
		return noOfExpiryMonth;
	}

	public void setNoOfExpiryMonth(int noOfExpiryMonth) {
		this.noOfExpiryMonth = noOfExpiryMonth;
	}

	public int getSaleId() {
		return saleId;
	}

	public void setSaleId(int saleId) {
		this.saleId = saleId;
	}

	public int getCustId() {
		return custId;
	}

	public void setCustId(int custId) {
		this.custId = custId;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getDoctorName() {
		return doctorName;
	}

	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}

	public String getDoctorPh() {
		return doctorPh;
	}

	public void setDoctorPh(String doctorPh) {
		this.doctorPh = doctorPh;
	}

	public String getAsOnDate() {
		return asOnDate;
	}

	public void setAsOnDate(String asOnDate) {
		this.asOnDate = asOnDate;
	}

	public int getDeletedBy() {
		return deletedBy;
	}

	public void setDeletedBy(int deletedBy) {
		this.deletedBy = deletedBy;
	}

	public int getManuId() {
		return manuId;
	}

	public void setManuId(int manuId) {
		this.manuId = manuId;
	}

	public int getContentId() {
		return contentId;
	}

	public void setContentId(int contentId) {
		this.contentId = contentId;
	}

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public String getExpiryDateFormat() {
		return expiryDateFormat;
	}

	public void setExpiryDateFormat(String expiryDateFormat) {
		this.expiryDateFormat = expiryDateFormat;
	}

	public double getMrp() {
		return mrp;
	}

	public void setMrp(double mrp) {
		this.mrp = mrp;
	}

	public int getSaleReturnId() {
		return saleReturnId;
	}

	public void setSaleReturnId(int saleReturnId) {
		this.saleReturnId = saleReturnId;
	}

	public int getNoOfMonthBefore() {
		return noOfMonthBefore;
	}

	public void setNoOfMonthBefore(int noOfMonthBefore) {
		this.noOfMonthBefore = noOfMonthBefore;
	}

	public String getManufacturerCode() {
		return manufacturerCode;
	}

	public void setManufacturerCode(String manufacturerCode) {
		this.manufacturerCode = manufacturerCode;
	}

	public int getPurchaseReturnId() {
		return purchaseReturnId;
	}

	public void setPurchaseReturnId(int purchaseReturnId) {
		this.purchaseReturnId = purchaseReturnId;
	}

	public int getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public double getTaxPer() {
		return taxPer;
	}

	public void setTaxPer(double taxPer) {
		this.taxPer = taxPer;
	}

	public int getNoOfRows() {
		return noOfRows;
	}

	public void setNoOfRows(int noOfRows) {
		this.noOfRows = noOfRows;
	}

	public String getFrmDate() {
		return frmDate;
	}

	public void setFrmDate(String frmDate) {
		this.frmDate = frmDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public int getPurchaseOrderId() {
		return purchaseOrderId;
	}

	public void setPurchaseOrderId(int purchaseOrderId) {
		this.purchaseOrderId = purchaseOrderId;
	}

	public String getInvDate() {
		return invDate;
	}

	public void setInvDate(String invDate) {
		this.invDate = invDate;
	}

	public String getNoteLineOne() {
		return noteLineOne;
	}
	public void setNoteLineOne(String noteLineOne) {
		this.noteLineOne = noteLineOne;
	}
	public String getNoteLineTwo() {
		return noteLineTwo;
	}
	public void setNoteLineTwo(String noteLineTwo) {
		this.noteLineTwo = noteLineTwo;
	}

	public int getIsRePrint() {
		return isRePrint;
	}
	public void setIsRePrint(int isRePrint) {
		this.isRePrint = isRePrint;
	}
	public int getPrintCount() {
		return printCount;
	}
	public void setPrintCount(int printCount) {
		this.printCount = printCount;
	}

	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getBarCode() {
		return barCode;
	}
	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}

	public int getLastSaleDays() {
		return lastSaleDays;
	}
	public void setLastSaleDays(int lastSaleDays) {
		this.lastSaleDays = lastSaleDays;
	}
	public int getComingPurchaseDays() {
		return comingPurchaseDays;
	}
	public void setComingPurchaseDays(int comingPurchaseDays) {
		this.comingPurchaseDays = comingPurchaseDays;
	}
	public int getNoOfDays() {
		return noOfDays;
	}
	public void setNoOfDays(int noOfDays) {
		this.noOfDays = noOfDays;
	}

	public String getMarketerCode() {
		return marketerCode;
	}
	public void setMarketerCode(String marketerCode) {
		this.marketerCode = marketerCode;
	}

	public int getCountryId() {
		return countryId;
	}
	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}
	public int getStateId() {
		return stateId;
	}
	public void setStateId(int stateId) {
		this.stateId = stateId;
	}

	/**
	 * @return the variantTypeId
	 */
	public int getVariantTypeId() {
		return variantTypeId;
	}
	/**
	 * @param variantTypeId the variantTypeId to set
	 */
	public void setVariantTypeId(int variantTypeId) {
		this.variantTypeId = variantTypeId;
	}
	/**
	 * @return the variantTypeName
	 */
	public String getVariantTypeName() {
		return variantTypeName;
	}
	/**
	 * @param variantTypeName the variantTypeName to set
	 */
	public void setVariantTypeName(String variantTypeName) {
		this.variantTypeName = variantTypeName;
	}

	/**
	 * @return the menuID
	 */
	public int getMenuID() {
		return menuID;
	}
	/**
	 * @param menuID the menuID to set
	 */
	public void setMenuID(int menuID) {
		this.menuID = menuID;
	}
	/**
	 * @return the retailTypeID
	 */
	public int getRetailTypeID() {
		return retailTypeID;
	}
	/**
	 * @param retailTypeID the retailTypeID to set
	 */
	public void setRetailTypeID(int retailTypeID) {
		this.retailTypeID = retailTypeID;
	}

	/**
	 * @return the accntGrpName
	 */
	public String getAccntGrpName() {
		return accntGrpName;
	}
	/**
	 * @param accntGrpName the accntGrpName to set
	 */
	public void setAccntGrpName(String accntGrpName) {
		this.accntGrpName = accntGrpName;
	}
	/**
	 * @return the marketerName
	 */
	public String getMarketerName() {
		return marketerName;
	}
	/**
	 * @param marketerName the marketerName to set
	 */
	public void setMarketerName(String marketerName) {
		this.marketerName = marketerName;
	}
	/**
	 * @return the purchaseRate
	 */
	public double getPurchaseRate() {
		return purchaseRate;
	}
	/**
	 * @param purchaseRate the purchaseRate to set
	 */
	public void setPurchaseRate(double purchaseRate) {
		this.purchaseRate = purchaseRate;
	}
	/**
	 * @return the saleRate
	 */
	public double getSaleRate() {
		return saleRate;
	}
	/**
	 * @param saleRate the saleRate to set
	 */
	public void setSaleRate(double saleRate) {
		this.saleRate = saleRate;
	}
	/**
	 * @return the launchDate
	 */
	public Date getLaunchDate() {
		return launchDate;
	}
	/**
	 * @param launchDate the launchDate to set
	 */
	public void setLaunchDate(Date launchDate) {
		this.launchDate = launchDate;
	}
	/**
	 * @return the discontinueDate
	 */
	public Date getDiscontinueDate() {
		return discontinueDate;
	}
	/**
	 * @param discontinueDate the discontinueDate to set
	 */
	public void setDiscontinueDate(Date discontinueDate) {
		this.discontinueDate = discontinueDate;
	}

	/**
	 * @return the listedMrp
	 */
	public double getListedMrp() {
		return listedMrp;
	}
	/**
	 * @param listedMrp the listedMrp to set
	 */
	public void setListedMrp(double listedMrp) {
		this.listedMrp = listedMrp;
	}
	/**
	 * @return the catId
	 */
	public int getCatId() {
		return catId;
	}
	/**
	 * @param catId the catId to set
	 */
	public void setCatId(int catId) {
		this.catId = catId;
	}
	/**
	 * @return the expDate
	 */
	public String getExpDate() {
		return expDate;
	}
	/**
	 * @param expDate the expDate to set
	 */
	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	/**
	 * @return the saleDetailsId
	 */
	public int getSaleDetailsId() {
		return saleDetailsId;
	}
	/**
	 * @param saleDetailsId the saleDetailsId to set
	 */
	public void setSaleDetailsId(int saleDetailsId) {
		this.saleDetailsId = saleDetailsId;
	}

	/**
	 * @return the qs
	 */
	public String getQs() {
		return qs;
	}
	/**
	 * @param qs the qs to set
	 */
	public void setQs(String qs) {
		this.qs = qs;
	}
	/**
	 * @return the mulSeriesPrefix
	 */
	public String getMulSeriesPrefix() {
		return mulSeriesPrefix;
	}
	/**
	 * @param mulSeriesPrefix the mulSeriesPrefix to set
	 */
	public void setMulSeriesPrefix(String mulSeriesPrefix) {
		this.mulSeriesPrefix = mulSeriesPrefix;
	}


	/**
	 * @return the purchaseIds
	 */
	public String getPurchaseIds() {
		return purchaseIds;
	}
	/**
	 * @param purchaseIds the purchaseIds to set
	 */
	public void setPurchaseIds(String purchaseIds) {
		this.purchaseIds = purchaseIds;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CommonResultSetMapper [id=" + id + ", companyId=" + companyId + ", storeId=" + storeId + ", name="
				+ name + ", lang=" + lang + ", itemId=" + itemId + ", itemName=" + itemName + ", brandName=" + brandName
				+ ", contentName=" + contentName + ", manufacturerName=" + manufacturerName + ", packUnitName="
				+ packUnitName + ", looseUnitName=" + looseUnitName + ", rackName=" + rackName + ", conv=" + conv
				+ ", groupName=" + groupName + ", schdName=" + schdName + ", price=" + price + ", queryCondn="
				+ queryCondn + ", purInvId=" + purInvId + ", finYrId=" + finYrId + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", invoiceNo=" + invoiceNo + ", purOrderNo=" + purOrderNo
				+ ", distributorName=" + distributorName + ", distributorId=" + distributorId + ", upToDate=" + upToDate
				+ ", noOfExpiryMonth=" + noOfExpiryMonth + ", saleId=" + saleId + ", custId=" + custId + ", custName="
				+ custName + ", custPh=" + custPh + ", status=" + status + ", doctorName=" + doctorName + ", doctorPh="
				+ doctorPh + ", asOnDate=" + asOnDate + ", searchCriteria=" + searchCriteria + ", deletedBy="
				+ deletedBy + ", createdBy=" + createdBy + ", manuId=" + manuId + ", contentId=" + contentId
				+ ", batchNo=" + batchNo + ", expiryDateFormat=" + expiryDateFormat + ", mrp=" + mrp + ", saleReturnId="
				+ saleReturnId + ", noOfMonthBefore=" + noOfMonthBefore + ", manufacturerCode=" + manufacturerCode
				+ ", purchaseReturnId=" + purchaseReturnId + ", paymentId=" + paymentId + ", paymentDate=" + paymentDate
				+ ", finyrCode=" + finyrCode + ", expiryId=" + expiryId + ", taxId=" + taxId + ", isGroup=" + isGroup
				+ ", taxName=" + taxName + ", purTaxId=" + purTaxId + ", purTaxName=" + purTaxName + ", salTaxId="
				+ salTaxId + ", salTaxName=" + salTaxName + ", taxPer=" + taxPer + ", noOfRows=" + noOfRows
				+ ", frmDate=" + frmDate + ", toDate=" + toDate + ", sku=" + sku + ", hsnCode=" + hsnCode + ", retType="
				+ retType + ", purchaseOrderId=" + purchaseOrderId + ", invDate=" + invDate + ", poGenType=" + poGenType
				+ ", noteLineOne=" + noteLineOne + ", noteLineTwo=" + noteLineTwo + ", isRePrint=" + isRePrint
				+ ", printCount=" + printCount + ", remarks=" + remarks + ", barCode=" + barCode + ", lastSaleDays="
				+ lastSaleDays + ", comingPurchaseDays=" + comingPurchaseDays + ", noOfDays=" + noOfDays + ", billNo="
				+ billNo + ", marketerCode=" + marketerCode + ", accntGrpName=" + accntGrpName + ", marketerName="
				+ marketerName + ", purchaseRate=" + purchaseRate + ", saleRate=" + saleRate + ", launchDate="
				+ launchDate + ", discontinueDate=" + discontinueDate + ", countryId=" + countryId + ", stateId="
				+ stateId + ", cityId=" + cityId + ", zoneId=" + zoneId + ", districtName=" + districtName
				+ ", variantTypeId=" + variantTypeId + ", variantTypeName=" + variantTypeName + ", menuID=" + menuID
				+ ", retailTypeID=" + retailTypeID + ", listedMrp=" + listedMrp + ", catId=" + catId + ", expDate="
				+ expDate + ", saleDetailsId=" + saleDetailsId + ", qs=" + qs + ", mulSeriesPrefix=" + mulSeriesPrefix
				+ ", qryCondition=" + qryCondition + ", groupCode=" + groupCode + ", accountID=" + accountID
				+ ", referenceID=" + referenceID + ", purchaseIds=" + purchaseIds + "]";
	}



}