/**
 *
 */
package com.sharobi.webpos.util;

import java.lang.reflect.Type;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

/**
 * @author habib
 *
 */
public class CommonResource {

	private final static Logger logger = LogManager.getLogger(CommonResource.class);
	private final static Properties resourceProperties = getProperties();

	public static final String DATE_FORMAT_GSON = "date.format.gson";
	public static final String DATE_FORMAT_GSON_TABLE = "date.format.gson.table";
	public static final String DATE_FORMAT_SHORT = "date.format.short";

	public static final String TARGET_WEBSERVICE_ENDPOINT = "target.webservice.endpoint";
	/* Start Login module */
	public final static String WEBSERVICE_LOGIN = "webservice.login";
	public final static String WEBSERVICE_LICENSE = "webservice.admin.module.license";
	public final static String WEBSERVICE_LOGIN_POSHEADER = "webservice.login.posheader";
	public final static String WEBSERVICE_LOGIN_GETALLWAITERS = "webservice.login.getallwaiters";
	/* End Login module */

	/* Start Base module */
	public final static String WEBSERVICE_ORDER_TYPE = "webservice.order.type";
	public final static String WEBSERVICE_STORE_BYID = "webservice.store.byid";
	public final static String WEBSERVICE_ORDER_GETCUSTOMER_BYID = "webservice.order.getcustomerdetails.byid";
	public final static String WEBSERVICE_ORDER_GETTOTALTRANSACTION_CUSTID = "webservice.order.gettotaltransactionpercustomer.bycustid";
	public final static String WEBSERVICE_ORDER_GETLASTVISITDATE_CUSTID = "webservice.order.getlastvisitdate.bycustid";
	public final static String WEBSERVICE_ORDER_GETTOTALPAIDAMOUNT_CUSTID = "webservice.order.gettotalpaidamount.bycustid";
	public final static String WEBSERVICE_ORDER_GETCUSTMOSTPURCHASEITEM_CUSTID = "webservice.order.getcustmostpurchaseitem.bycustid";
	public final static String WEBSERVICE_ORDER_GETCUSTTRANSACTIONSUMMARY_CUSTID = "webservice.order.getcusttransactionsummary.bycustid";
	public final static String WEBSERVICE_STORELOCATOR_INSERTOPENTIME = "webservice.storeLocator.insertopentime";
	public final static String WEBSERVICE_STORELOCATOR_INSERTCLOSETIME = "webservice.storeLocator.insertclosetime";
	public final static String WEBSERVICE_STORELOCATOR_CHECKOPENTIMESTATUS = "webservice.storeLocator.checkopentimestatus";
	public final static String WEBSERVICE_TABLE_GETLIST = "webservice.table.getlist";
	public final static String WEBSERVICE_UPDATE_TABLE_STATUS = "webservice.update.table.status";
	public final static String WEBSERVICE_MENU_GETLIST = "webservice.menu.getlist";
	public final static String WEBSERVICE_ORDER_GETUNPAIDORDERLIST = "webservice.order.getUnpaidOrderlist";
	public final static String WEBSERVICE_ORDER_GETALLUNPAIDORDERLISTBYDATE = "webservice.order.getAllUnpaidorderlistbyDate";
	public final static String WEBSERVICE_ORDER_GETALLUNPAIDORDERLISTBYPERIOD = "webservice.order.getAllUnpaidorderlistbyPeriod";
	public final static String WEBSERVICE_ORDER_SAVE = "webservice.order.save";
	public final static String WEBSERVICE_ORDER_BILL_PRINT = "werservice.order.bill.print";
	public final static String WEBSERVICE_ORDER_REFUND_BILL_PRINT = "werservice.order.refund.bill.print";
	public final static String WEBSERVICE_BILL_PAYMENTINFO = "webservice.bill.paymentinfo";
	public final static String WEBSERVICE_BILL_PAYMENT = "webservice.bill.payment";
	public final static String WEBSERVICE_BILL_GETBILLBYID = "webservice.bill.getbillbyid";
	public final static String WEBSERVICE_UNPAID_ORDER_GETORDERBYID = "webservice.unpaid.order.getorderbyid";
	public final static String WEBSERVICE_UNPAID_ORDER_GETUNPAIDORDERDETAILSBYID = "webservice.unpaid.order.getunpaidorderdetailsbyid";
	public final static String WEBSERVICE_UNPAID_ORDER_GETUNPAIDORDERDETAILSBYNUMBER = "webservice.unpaid.order.getunpaidorderdetailsbynumber";
	public final static String WEBSERVICE_UNPAID_ORDER_GETORDERBYIDWITHLANGUAGE = "webservice.unpaid.order.getorderbyidwithlanguage";
	public final static String WEBSERVICE_UNPAID_ORDER_GETORDERBYID_FOR_SPLITBILL = "webservice.unpaid.order.getorderbyid.for.splitbill";
	public final static String WEBSERVICE_UNPAID_ORDER_UPDATE_ORDERITEM = "webservice.unpaid.order.update.orderitem";
	public final static String WEBSERVICE_UNPAID_ORDER_UPDATE_ORDERITEM_POST = "webservice.unpaid.order.update.orderitem.post";
	public final static String WEBSERVICE_UNPAID_ORDER_CANCEL = "webservice.unpaid.order.cancel";
	public final static String WEBSERVICE_UNPAID_ORDER_CANCEL_POST = "webservice.unpaid.order.cancel.post";
	public final static String WEBSERVICE_BILL_ADDDISCOUNT = "webservice.bill.adddiscount";
	public final static String WEBSERVICE_ORDER_GETSPLNOTEBYITEMID = "webservice.order.getspecialnotebyitemid";
	public final static String WEBSERVICE_ORDER_GETSPLNOTEFORSTORE = "webservice.order.getspecialnotebyitemid";// check
	public final static String WEBSERVICE_ORDER_UPDATE_CREDITSALE = "webservice.order.update.creditsale";
	public final static String WEBSERVICE_ORDER_UPDATE_PAX = "webservice.order.update.pax";
	public final static String WEBSERVICE_ORDER_GETALLPAIDORDER = "webservice.order.getallpaidorder";
	public final static String WEBSERVICE_ORDER_UPDATE_TABLE = "webservice.order.update.table";
	public final static String WEBSERVICE_BILL_SPLIT_M = "webservice.order.split.bill.m";
	public final static String WEBSERVICE_BILL_SPLIT_PRINT = "webservice.order.split.bill.print";
	public final static String WEBSERVICE_ORDER_KOT_CHECKLIST_PRINT = "webservice.order.kot.checklist.print";
	public final static String WEBSERVICE_ORDER_GETCUSTOMER_BYCONTACT = "webservice.order.getcustomerdetails.bycontact";
	public final static String WEBSERVICE_ORDER_GETCUSTOMERCONTACT = "webservice.order.getcustomercontact";
	public final static String WEBSERVICE_ORDER_GETCUSTOMERDETAILS_BYNAME = "webservice.order.getcustomerdetails.byname";
	public final static String WEBSERVICE_ORDER_GETCUSTOMERDETAILS_BYPHNO = "webservice.order.getcustomerdetails.byphno";
	public final static String WEBSERVICE_ORDER_GETCUSTOMER_LOCATION = "webservice.order.getcustomer.location";
	public final static String WEBSERVICE_MENU_GETITEM_BYCODE = "webservice.menu.getitem.bycode";
	public final static String WEBSERVICE_TABLE_MENUCAT_DIRECTCAT = "webservice.table.category.getdirectcategory";
	public final static String WEBSERVICE_ORDER_UPDATE_BILLPRINT_COUNT = "webservice.order.update.billprint.count";
	public final static String WEBSERVICE_ORDER_GET_BILLPRINT_COUNT = "webservice.order.get.billprint.count";
	public final static String WEBSERVICE_ORDER_GETPAYMENTTYPEBYSTORE = "webservice.order.getPaymentTypeByStore";
	public final static String WEBSERVICE_ORDER_UPDATESCHARGERATE = "webservice.order.updateschargerate";

	/* End Base module */

	/* Start Billing module */
	public final static String WEBSERVICE_SPLIT_BILL_MANUAL_BYORDERID = "webservice.split.bill.manual.byorderid";
	public final static String WEBSERVICE_PRINT_BILL_CASH = "webservice.print.bill.cash";
	/* End Billing module */

	/* Start Admin module */
	public final static String WEBSERVICE_MENUMGNT_LANGUAGE_GETLANGUAGE = "webservice.menumgnt.language.getlanguage";
	public final static String WEBSERVICE_ADMIN_MODULE_LOGIN = "webservice.admin.module.login";
	public final static String WEBSERVICE_ADMIN_MODULE_GETLICENSE_INFO = "webservice.admin.module.getlicenseinfo";
	public final static String WEBSERVICE_ADMIN_MODULE_PROFILE_CHANGEPASSWORD = "webservice.admin.module.profile.changepassword";
	public final static String WEBSERVICE_MENU_GETLISTALL = "webservice.menu.getlistall";
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY = "webservice.menumgnt.category.getcategory";
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORYEXCLUDESPCLNOTE = "webservice.menumgnt.category.getcategoryexcludespclnote";
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_ADDCATEGORY = "webservice.menumgnt.category.addcategory";
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_ADDCATEGORY_POST = "webservice.menumgnt.category.addcategorypost";
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_EDITCATEGORY = "webservice.menumgnt.category.editcategory";
	public final static String WEBSERVICE_MENUMGNT_CATEROGY_DELETECATEGORY = "webservice.menumgnt.category.deletecategory";
	public final static String WEBSERVICE_MENUMGNT_SUBCATEROGY_GETSUBCATEGORY = "webservice.menumgnt.subcategory.getsubcategory";
	public final static String WEBSERVICE_MENUMGNT_SUBCATEROGY_ADDSUBCATEGORY = "webservice.menumgnt.subcategory.addsubcategory";
	public final static String WEBSERVICE_MENUMGNT_SUBCATEROGY_ADDSUBCATEGORY_POST = "webservice.menumgnt.subcategory.addsubcategorypost";
	public final static String WEBSERVICE_MENUMGNT_SUBCATEROGY_EDITSUBCATEGORY = "webservice.menumgnt.subcategory.editsubcategory";
	public final static String WEBSERVICE_MENUMGNT_SUBCATEROGY_DELETESUBCATEGORY = "webservice.menumgnt.subcategory.deletesubcategory";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_ADDMENUITEM = "webservice.menumgnt.menuitem.addmenuitem";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_EDITMENUITEM = "webservice.menumgnt.menuitem.editmenuitem";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_TRANSLATEMENUITEM = "webservice.menumgnt.translatemenuitem";
	public final static String WEBSERVICE_MENUMGNT_CATNSUBCAT_TRANSLATEMENUCATNSUBCAT = "webservice.menumgnt.translatemenucatnsubcat";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_GETITEMBYID = "webservice.menumgnt.menuitem.getitembyid";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_DELETEMENUITEM = "webservice.menumgnt.menuitem.deletemenuitem";
	public final static String WEBSERVICE_MENUMGNT_SPECIALNOTE_GETSPECIALNOTE = "webservice.menumgnt.splecialnote.getspeciallnote";
	public final static String WEBSERVICE_MENUMGNT_SPECIALNOTE_ADDSPECIALNOTE = "webservice.menumgnt.splecialnote.addspecialnote";
	public final static String WEBSERVICE_MENUMGNT_SPECIALNOTE_GETALLSPECIALNOTE = "webservice.menumgnt.splecialnote.getallspeciallnote";
	public final static String WEBSERVICE_MENUMGNT_SPECIALNOTE_GETSPECIALNOTE_FORSTORE = "webservice.menumgnt.splecialnote.getspeciallnote.store";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_SPECIALNOTE_GETCOLOR = "webservice.menumgnt.splecialnote.getallcolors";

	public final static String WEBSERVICE_ADMIN_PREBOOKINGTABLE_ADDBOOKINGDETAILS = "webservice.admin.pretablebooking.addprebookingdetails";
	public final static String WEBSERVICE_ADMIN_TABLE_PREBOOKLIST = "webservice.admin.table.prebook.getlist";
	public final static String WEBSERVICE_ADMIN_PREBOOKINGTABLE_EDITBOOKINGDETAILS = "webservice.admin.pretablebooking.editprebookingdetails";
	public final static String WEBSERVICE_ADMIN_PREBOOKINGTABLE_DELETEBOOKINGDETAILS = "webservice.admin.pretablebooking.deleteprebookingdetails";
	public final static String WEBSERVICE_ADMIN_PREBOOKINGTABLE_ADVANCEPAY = "webservice.admin.pretablebooking.advancepay";

	/* Refund order in admin */
	public final static String WEBSERVICE_ORDER_PAIDORDERDETAILS_BYORDERID = "webservice.paidorder.details.byid";

	public final static String WEBSERVICE_ORDER_PAIDORDERDETAILS_BYORDERNUMBER = "webservice.paidorder.details.bynumber";

	public final static String WEBSERVICE_ORDER_REFUND_REASONS = "webservice.paidorder.refund.reasonlist";
	public final static String WEBSERVICE_ADMIN_ORDER_SAVEREFUND = "webservice.paidorder.refundorder";
	public final static String WEBSERVICE_ORDER_REFUNDORDERDETAILS_BYORDERID = "webservice.paidorder.refund.orderdetailsbyid";
	public final static String WEBSERVICE_ADMIN_ORDERREFUND_APPROVE = "webservice.paidorder.refund.approve";

	public final static String WEBSERVICE_ADMIN_ORDERREFUND_DELETE = "webservice.paidorder.refund.delete";
	public final static String WEBSERVICE_TABLEMGNT_TABLE_ADDTABLE = "webservice.tablemgnt.table.addtable";
	public final static String WEBSERVICE_TABLEMGNT_TABLE_EDITTABLE = "webservice.tablemgnt.table.edittable";
	public final static String WEBSERVICE_TABLEMGNT_TABLE_DELETETABLE = "webservice.tablemgnt.table.deletetable";
	public final static String WEBSERVICE_TABLEMGNT_TABLE_UPDATETABLEPOSITION = "webservice.tablemgnt.table.updatetableposition";
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_GETVENDOR = "webservice.vendormgnt.vendor.getvendor";
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_ADDVENDOR = "webservice.vendormgnt.vendor.addvendor";
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_EDITVENDOR = "webservice.vendormgnt.vendor.editvendor";
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_DELETEVENDOR = "webservice.vendormgnt.vendor.deletevendor";
	public final static String WEBSERVICE_INVMGNT_INVTYPE_GETINVTYPE = "webservice.invmgnt.invtype.getinvtype";
	public final static String WEBSERVICE_INVMGNT_INVTYPE_ADDINVTYPE = "webservice.invmgnt.invtype.addinvtype";
	public final static String WEBSERVICE_INVMGNT_INVTYPE_EDITINVTYPE = "webservice.invmgnt.invtype.editinvtype";
	public final static String WEBSERVICE_INVMGNT_INVTYPE_DELETEINVTYPE = "webservice.invmgnt.invtype.deleteinvtype";
	public final static String WEBSERVICE_INVMGNT_INVITEM_GETINVITEM = "webservice.invmgnt.invitem.getinvitem";
	public final static String WEBSERVICE_INVMGNT_INVITEM_ADDINVITEM = "webservice.invmgnt.invitem.addinvitem";
	public final static String WEBSERVICE_INVMGNT_INVITEM_EDITINVITEM = "webservice.invmgnt.invitem.editinvitem";
	public final static String WEBSERVICE_INVMGNT_INVITEM_GETFGSTOCKINITEMSBYITEMID = "webservice.invmgnt.invitem.getfgstockinitemsbyitemid";
	public final static String WEBSERVICE_INVMGNT_INVITEM_DELETEINVITEM = "webservice.invmgnt.invitem.deleteinvitem";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_GETFMCGUNIT = "webservice.menumgnt.menuitem.getfmcgunit";
	public final static String WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_GETSTORECUSTOMER = "webservice.storecustmgnt.storecustomer.getstorecustomer";
	public final static String WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_ADDSTORECUSTOMER = "webservice.storecustmgnt.storecustomer.addstorecustomer";
	public final static String WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_EDITSTORECUSTOMER = "webservice.storecustmgnt.storecustomer.editstorecustomer";
	public final static String WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_DELETESTORECUSTOMER = "webservice.storecustmgnt.storecustomer.deletestorecustomer";
	public final static String WEBSERVICE_TAXMGNT_MENUITEM_UPDATEALLITEM = "webservice.taxmgnt.menuitem.updateallitem";
	public final static String WEBSERVICE_SERVICECHARGE_ORDERTYPE_UPDATE = "webservice.servicecharge.ordertype.update";
	public final static String WEBSERVICE_INVMGNT_INVITEM_GETUNITLIST = "webservice.invmgnt.invitem.getunitlist";
	public final static String WEBSERVICE_INVMGNT_INVITEM_GETUNITDETAILS = "webservice.invmgnt.invitem.getunitdetails";
	public final static String WEBSERVICE_MENUMGNT_MENUITEM_UPLOADFILE = "webservice.menumgnt.menuitem.uploadfile";
	public final static String WEBSERVICE_ADMIN_MODULE_DATA_BACKUP = "webservice.admin.module.databackup";
	public final static String WEBSERVICE_ADMIN_LOGFILE_PATH = "webservice.admin.logfile.path";
	public final static String WEBSERVICE_ADMIN_CLEANLOGFILE_DAYSBEFORE = "webservice.admin.cleanlogfile.daysbefore";
	public final static String WEBSERVICE_ADMIN_LOGFILE_PATH_SERVER = "webservice.admin.logfile.path.server";
	public final static String WEBSERVICE_ADMIN_LOGFILE_CLEAN_SERVER = "webservice.admin.logfile.clean.server";
	public final static String WEBSERVICE_MENU_TRANSLATION_GETLIST = "webservice.menu.translation.getlist";
	public final static String WEBSERVICE_CATNSUBCAT_TRANSLATION_GETLIST = "webservice.catnsubcat.translation.getlist";

	public final static String WEBSERVICE_DELVRYBOYMGNT_ASSIGNDELIVERYBOY = "webservice.delvryboymgnt.assigndeliveryboy";
	public final static String WEBSERVICE_DELVRYBOYMGNT_ADDDELIVERYBOY = "webservice.delvryboymgnt.adddeliveryboy";
	public final static String WEBSERVICE_DELVRYBOYMGNT_EDITDELIVERYBOY = "webservice.delvryboymgnt.editdeliveryboy";
	public final static String WEBSERVICE_DELVRYBOYMGNT_DELETEDELIVERYBOY = "webservice.delvryboymgnt.deletedeliveryboy";
	public final static String WEBSERVICE_DELVRYBOYMGNT_GETALLDELIVERYBOY = "webservice.delvryboymgnt.getalldeliveryboy";
	// for vendor payment management
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_GETPAYMENTINFOBYID = "webservice.vendormgnt.vendor.getpaymentinfobyid";
	public final static String WEBSERVICE_VENDORMGNT_VENDOR_VENDOPAYMENT = "webservice.vendormgnt.vendor.vendorpayment";

	// for credit sales
	public final static String WEBSERVICE_CREDITSALE_GETCREDITCUSTTOMERLIST = "webservice.creditsale.getcreditcustomerlist";
	public final static String WEBSERVICE_CREDITSALE_ORDER_GETCREDITORDERBYCUSTOMERID = "webservice.creditsale.order.getcreditorderbycustotmerid";
	public final static String WEBSERVICE_CREDITSALE_ORDER_GETCREDITCUSTOMERBYCONTACTNO = "webservice.creditsale.order.getcreditcustomerbycontact";
	// for kot printer setup
	public final static String WEBSERVICE_PRINT_GETALLINSTALLEDPRINTERS = "webservice.print.getallinstalledprinters";
	public final static String WEBSERVICE_PRINT_ASSIGNPRINTER = "webservice.print.assignprinter";
	public final static String WEBSERVICE_PRINT_GETALLSERVERPRINTERS = "webservice.print.getallserverprinters";
	public final static String WEBSERVICE_PRINT_ASSIGNPRINTERTOITEM = "webservice.print.assignprintertoitem";
	// for daily expenditure
	public final static String WEBSERVICE_ACCOUNT_ADD_DAILYEXPENDITURE = "webservice.expenditure.add.dailyexpenditure";
	public final static String WEBSERVICE_ACCOUNT_VIEW_DAILYEXPENDITURE = "webservice.expenditure.view.dailyexpenditure";
	public final static String WEBSERVICE_ACCOUNT_VIEW_PERIODEXPENDITURE = "webservice.expenditure.view.periodexpenditure";
	public final static String WEBSERVICE_ACCOUNT_VIEW_DELETEEXPENDITURE = "webservice.expenditure.delete.periodexpenditure";
	public final static String WEBSERVICE_ACCOUNT_VIEW_EDITXPENDITURE = "webservice.expenditure.edit.periodexpenditure";
	public final static String WEBSERVICE_ACCOUNT_VIEW_XPENDITURETYPE = "webservice.expenditure.periodexpenditure.expendituretype";

	/* End Admin module */

	/* Inventory Module */
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKIN_SUMMARY = "webservice.report.inventory.raw.stockin.summary";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKIN_REGISTER = "webservice.report.inventory.raw.stockin.register";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKIN_ITEMWISE = "webservice.report.inventory.raw.stockin.itemwise";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKIN_SUMMARY = "webservice.report.inventory.fg.stockin.summary";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKIN_REGISTER = "webservice.report.inventory.fg.stockin.register";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKIN_ITEMWISE = "webservice.report.inventory.fg.stockin.itemwise";

	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKRETURN_SUMMARY = "webservice.report.inventory.raw.stockreturn.summary";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKRETURN_REGISTER = "webservice.report.inventory.raw.stockreturn.register";
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKRETURN_ITEMWISE = "webservice.report.inventory.raw.stockreturn.itemwise";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKRETURN_SUMMARY = "webservice.report.inventory.fg.stockreturn.summary";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKRETURN_REGISTER = "webservice.report.inventory.fg.stockreturn.register";
	public final static String WEBSERVICE_REPORT_INVENTORY_FG_STOCKRETURN_ITEMWISE = "webservice.report.inventory.fg.stockreturn.itemwise";
	
	public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKOUT_SUMMARY = "webservice.report.inventory.raw.stockout.summary";
  public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKOUT_REGISTER = "webservice.report.inventory.raw.stockout.register";
  public final static String WEBSERVICE_REPORT_INVENTORY_RAW_STOCKOUT_ITEMWISE = "webservice.report.inventory.raw.stockout.itemwise";
	
	
	/* Start Report module */
	public final static String WEBSERVICE_REPORT_SALES_DAILY_REPORT = "webservice.report.sales.daily.report";
	public final static String WEBSERVICE_REPORT_SALES_DAILY_TIMEWISE_REPORT = "webservice.report.sales.datetime.report";
	public final static String WEBSERVICE_REPORT_ORDERS_DAILY_REPORT = "webservice.report.orders.daily.report";
	public final static String WEBSERVICE_REPORT_SALES_PERIOD_REPORT = "webservice.report.sales.period.report";
	public final static String WEBSERVICE_REPORT_SALES_CATWISE_DAILY_REPORT = "webservice.report.sales.catwise.daily.report";
	public final static String WEBSERVICE_REPORT_SALES_CREDIT_PERIOD_REPORT = "webservice.report.sales.credit.period.report";
	public final static String WEBSERVICE_REPORT_SALES_USER_WISE_DAILY_REPORT = "webservice.report.sales.user.wise.daily.report";
	public final static String WEBSERVICE_REPORT_SALES_PAYMENTMODE_WISE_REPORT = "webservice.report.sales.paymentmodewise.report";
	public final static String WEBSERVICE_REPORT_ORDERS_ITEM_WISE_DAILY_REPORT = "webservice.report.orders.item.wise.daily.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_PO_DAILY_REPORT = "webservice.report.inventory.po.daily.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_PO_PERIOD_REPORT = "webservice.report.inventory.po.period.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKIN_DAILY_REPORT = "webservice.report.inventory.stockin.daily.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKIN_PERIOD_REPORT = "webservice.report.inventory.stockin.period.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKOUT_DAILY_KITCHENWISE_REPORT = "webservice.report.inventory.stockout.daily.kitchenwise.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKOUT_DAILY_ALLCATWISE_REPORT = "webservice.report.inventory.stockout.daily.allcatwise.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKOUT_PERIOD_KITCHENWISE_REPORT = "webservice.report.inventory.stockout.period.kitchenwise.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_STOCKOUT_PERIOD_ALLCATWISE_REPORT = "webservice.report.inventory.stockout.period.allcatwise.report";
	public final static String WEBSERVICE_REPORT_INVENTORY_CURRENT_STOCK_REPORT = "webservice.report.inventory.current.stock.report";
	public final static String WEBSERVICE_REPORT_SALES_DAILY_REPORT_WITHTAX = "webservice.report.sales.daily.report.withtax";
	public final static String WEBSERVICE_REPORT_ORDERS_ITEM_WISE_PERIOD_REPORT = "webservice.report.orders.item.wise.period.report";
	public final static String WEBSERVICE_REPORT_ORDERS_NOCKOT_PERIOD_REPORT = "webservice.report.orders.nockot.period.report";
	public final static String WEBSERVICE_REPORT_ORDERS_CANCEL_PERIOD_REPORT = "webservice.report.orders.cancel.period.report";
	public final static String WEBSERVICE_REPORT_SALES_CATWISE_PERIOD_REPORT = "webservice.report.sales.categorywise.period.report";
	public final static String WEBSERVICE_REPORT_BY_STORE = "webservice.report.getReportByStore";
	public final static String WEBSERVICE_REPORT_CUSTOMER = "webservice.report.getCustomerReport";
	public final static String WEBSERVICE_REPORT_TOP_CUSTOMER = "webservice.report.getTopCustomerReport";
	public final static String WEBSERVICE_REPORT_OUTSTANDING_CUSTOMER = "webservice.report.getOutstandingCustomerReport";
	public final static String WEBSERVICE_REPORT_NEW_REPEAT_CUSTOMER = "webservice.report.getNewAndRepeatCustomerReport";
	public final static String WEBSERVICE_REPORT_TABLEORDERS_WITH_WAITER = "webservice.report.getTableOrdersWithWaiterReport";
	public final static String WEBSERVICE_REPORT_ORDERS_WITH_DELIVERYBOY = "webservice.report.getOrdersWithDeliveryBoyReport";
	// celavi report
	public final static String WEBSERVICE_REPORT_PAYMENTWISE = "webservice.report.paymentwise";
	public final static String WEBSERVICE_REPORT_NONCHARGEABLE = "webservice.report.nonchargeable";
	public final static String WEBSERVICE_REPORT_DISCOUNTREASON = "webservice.report.discountreason";
	public final static String WEBSERVICE_REPORT_DAILYSALES = "webservice.report.dailysales";
	public final static String WEBSERVICE_REPORT_CANCELORDERREASON = "webservice.report.cancelorderreason";
	public final static String WEBSERVICE_REPORT_DAILYMANAGERWITHTAX = "webservice.report.dailymanagerwithtax";
	public final static String WEBSERVICE_REPORT_DAILYSALESINCLUSIVE = "webservice.report.dailysalesinclusive";
	public final static String WEBSERVICE_REPORT_DAILYSALESSUMMARY = "webservice.report.dailysalessummary";
	// for thermal printer
	public final static String WEBSERVICE_REPORT_SALES_DAILY_REPORT_TP = "webservice.report.sales.daily.report.tp";
	public final static String WEBSERVICE_REPORT_SALES_PERIOD_REPORT_TP = "webservice.report.sales.period.report.tp";
	public final static String WEBSERVICE_REPORT_SALES_DAY_WISE_HOURLY_REPORT_TP = "webservice.report.sales.day.wise.hourly.report.tp";
	public final static String WEBSERVICE_REPORT_SALES_DAY_WISE_SUMMARY_REPORT_TP = "webservice.report.sales.day.wise.summary.report.tp";
	public final static String WEBSERVICE_REPORT_SALES_PERIOD_WISE_SUMMARY_REPORT_TP = "webservice.report.sales.period.wise.summary.report.tp";

	// accounts report 23.05.2018

	public final static String WEBSERVICE_REPORT_ACCOUNTS_PERIODWISE_PL_STATEMENT = "webservice.report.accounts.periodwise.pl.statement";
	public final static String WEBSERVICE_REPORT_ACCOUNTS_PERIODWISE_TAX_STATEMENT = "webservice.report.accounts.periodwise.tax.statement";

	// refund report 21.6.2018
	public final static String WEBSERVICE_REPORT_REFUNDS_PERIODWISE_REFUND_SUMMARY = "webservice.report.accounts.periodwise.refund.summary";
	public final static String WEBSERVICE_REPORT_REFUNDS_PERIODWISE_REFUND_DETAILS = "webservice.report.accounts.periodwise.refund.details";

	public final static String WEBSERVICE_REPORT_PERIODIC_VENDOR_PAYMENT_REPORT = "webservice.report.periodwise.vendor.payment";


	// roombooking reports
	 public final static String WEBSERVICE_REPORT_ROOMBOOKING_BOOKING_SUMMARY_REPORT = "webservice.report.roombooking.bookingsummary";
	 public final static String WEBSERVICE_REPORT_ROOMBOOKING_BOOKING_DETAILS_REPORT = "webservice.report.roombooking.bookingdetails";
	 public final static String WEBSERVICE_REPORT_ROOMBOOKING_PAYMENTWISESALE_REPORT = "webservice.report.roombooking.paymentwisesale";

	 //GuestList Report
	 public final static String WEBSERVICE_REPORT_GUEST_LIST = "webservice.report.guestlist";
	 
	//FlashReportForRoomSearch
   public final static String WEBSERVICE_FLASH_REPORT="webservice.report.roomsearchflashreport";
	 
	 //GetCreditBookingForAdminLeftPanel
	 public final static String WEBSERVICE_REPORT_CREDIT_BOOKING_CUSTOMER_BY_ID = "webservice.report.creditbookingbycustomerid";
	 
	 
	 
	/* End Report module */
	 
	 //RoomBooking Customer Autocomplete Search Api On 31 October 2019 By Prothit
	 public final static String WEBSERVICE_ROOMBOOKING_GETCUSTOMERDETAILS_BYNAME = "webservice.base.room.getcustomerdetailsbyname";
	 public final static String WEBSERVICE_ROOMBOOKING_GETCUSTOMERDETAILS_BYPHNO = "webservice.base.room.getcustomerdetailsbyphno";

	 
	 //Convert To Credit Customer And Convert to Credit Room Booking Api
	 public final static String WEBSERVICE_CUSTOMER_CONVERT_TO_CREDIT_CUSTOMER = "webservice.base.room.convertToCreditCustomer";
   public final static String WEBSERVICE_CUSTOMER_CONVERT_TO_CREDIT_BOOKING = "webservice.base.room.convertToCreditBooking";
   
   //Add More Room Api
   public final static String WEBSERVICE_ROOMBOOKING_ADD_MORE_ROOM= "webservice.base.room.addMoreRoom";
	 
	 
	/* Start Inventory module */
	public final static String WEBSERVICE_INVENTORY_PURCHASEORDER_BYDATE = "webservice.inventory.purchaseorder.bydate";
	public final static String WEBSERVICE_INVENTORY_PURCHASEORDER_BYPOID = "webservice.inventory.purchaseorder.bypoid";
	public final static String WEBSERVICE_INVENTORY_INVENTORYITEMS = "webservice.inventory.inventoryitems";
	public final static String WEBSERVICE_INVENTORY_GETINVENTORYITEMS_BYCODE = "webservice.inventory.getinventoryitems.bycode";
	public final static String WEBSERVICE_INVENTORY_APPROVEDPO = "webservice.inventory.approvedpo";
	public final static String WEBSERVICE_INVENTORY_UPDATEDPO = "webservice.inventory.updatepo";
	public final static String WEBSERVICE_INVENTORY_UPDATE_EACHPOITEM = "webservice.inventory.updateEachpoitem";
	public final static String WEBSERVICE_INVENTORY_DELETE_POITEM = "webservice.inventory.deletepoitem";
	public final static String WEBSERVICE_INVENTORY_CURRENTSTOCK_ITEM = "webservice.inventory.currentstock.item";
	public final static String WEBSERVICE_INVENTORY_VENDORS = "webservice.inventory.vendors";
	public final static String WEBSERVICE_INVENTORY_PURCHASEORDER_CREATE = "webservice.inventory.purchaseOrder.create";
	public final static String WEBSERVICE_INVENTORY_PURCHASEORDER_UPDATE = "webservice.inventory.purchaseOrder.update";
	public final static String WEBSERVICE_INVENTORY_STOCKOUT_BYDATE = "webservice.inventory.stockout.bydate";
	public final static String WEBSERVICE_INVENTORY_STOCKOUT_BYID = "webservice.inventory.stockout.byid";
	public final static String WEBSERVICE_INVENTORY_STOCKOUT_CREATE_NEW = "webservice.inventory.stockout.create.newstockout";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_BYDATE = "webservice.inventory.stockin.bydate";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_BYID = "webservice.inventory.stockin.byid";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_CLOSED = "webservice.inventory.stockin.close";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_UPDATE_EACHSTOCKINITEM = "webservice.inventory.stockin.update.eachstockinitem";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_DELETE_EACHSTOCKINITEM = "webservice.inventory.stockin.delete.eachstockinitem";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_SAVE_NEW = "webservice.inventory.stockin.save.newstockin";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_UPDATE_EXISTING = "webservice.inventory.stockin.update.existing";
	public final static String WEBSERVICE_INVENTORY_PURCHASEORDER_PRINT = "webservice.inventory.purchaseorder.print";
	public final static String WEBSERVICE_INVENTORY_REQUISITION_DELETE = "webservice.inventory.requisition.delete";
	public final static String WEBSERVICE_INVENTORY_STOCKIN_DELETEBYID = "webservice.inventory.stockin.deletebyid";
	public final static String WEBSERVICE_INVENTORY_STOCKOUT_DELETEBYID = "webservice.inventory.stockout.deletebyid";
	public final static String WEBSERVICE_INVENTORY_STOCKOUT_RAWITEMLIST_CURRENTDATE = "webservice.inventory.stockout.rawitemlist.currentdate";

	// new added 7.3.2018
	public final static String WEBSERVICE_INVENTORY_STOCKIN_REPORT = "webservice.report.inventory.stockin.report";

	// new added 10.7.2018 for purchase return
	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_SAVE = "webservice.inventory.purchase.return.save";
	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_UPDATE = "webservice.inventory.purchase.return.update";

	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_BYDATE = "webservice.inventory.purchase.return.getreturnlistbydate";
	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_BYID = "webservice.inventory.purchase.return.getreturnlistbyid";
	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_CLOSED = "webservice.inventory.purchase.return.closed";
	public final static String WEBSERVICE_INVENTORY_PURCHASE_RETURN_DELETEBYID = "webservice.inventory.purchase.return.deletebyid";

	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_GETFGSTOCKINBYDATE = "webservice.inventory.simplefgstockin.getfgstockinbydate";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_CREATEFGSTOCKIN = "webservice.inventory.simplefgstockin.createfgstockin";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_GETSIMPLESTOCKINLISTBYID = "webservice.inventory.simplefgstockin.getsimplefgstckindatabystockinid";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_GETFGITEMCURRENTSTOCK = "webservice.inventory.simplefgstockin.getfgitemcurrentstock";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_UPDATEFGSTOCKIN = "webservice.inventory.simplefgstockin.updatefgstockin";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKIN_DELETEFGSTOCKIN = "webservice.inventory.simplefgstockin.deletefgstockin";

	/* End Inventory module */
	
	// Simple Fg Item Return
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_CREATEFGSTOCKRETURN = "webservice.inventory.simplefgstockreturn.createfgstockreturn";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_UPDATEFGSTOCKRETURN = "webservice.inventory.simplefgstockreturn.updatefgstockreturn";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_DELETEFGSTOCKRETURN = "webservice.inventory.simplefgstockreturn.deletefgstockreturn";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_APPROVEFGSTOCKRETURN = "webservice.inventory.simplefgstockreturn.approvefgstockreturn";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_GETFGSTOCKRETURNBYID = "webservice.inventory.simplefgstockreturn.getfgstockreturnbyid";
	public final static String WEBSERVICE_INVENTORY_SIMPLEFGSTOCKRETURN_GETFGSTOCKRETURNBYDATE = "webservice.inventory.simplefgstockreturn.getfgstockreturnbydate";
	/* End of Simple FG Item Return */

	/* Start Kitchen module */
	public final static String WEBSERVICE_KITCHEN_GETKITCHENITEM = "webservice.kitchen.getkitchenitem";
	public final static String WEBSERVICE_KITCHEN_GETKITCHENITEM_WITH_LANG = "webservice.kitchen.getkitchenitemwithlang";
	public final static String WEBSERVICE_KITCHEN_COOKING_START = "webservice.kitchen.cooking.start";
	public final static String WEBSERVICE_KITCHEN_COOKING_END = "webservice.kitchen.cooking.end";
	public final static String WEBSERVICE_KITCHEN_OUT = "webservice.kitchen.out";
	/* End Kitchen module */

	/* Start RM module */
	public final static String WEBSERVICE_RM_RECIPE_MENU_GETLIST = "webservice.rm.recipe.menu.getlist";
	public final static String WEBSERVICE_RM_RECIPE_MENU_GETINGREDIENTLIST = "webservice.rm.recipe.menu.getingredients";
	public final static String WEBSERVICE_RM_RECIPE_MENU_ADDINGREDIENT = "webservice.rm.recipe.menu.addingredient";
	public final static String WEBSERVICE_RM_RECIPE_MENU_UPDATEINGREDIENT = "webservice.rm.recipe.menu.updateingredient";
	public final static String WEBSERVICE_RM_RECIPE_MENU_DELETEINGREDIENT = "webservice.rm.recipe.menu.deleteingredient";
	public final static String WEBSERVICE_RM_RECIPE_MENU_GETALLCOOKINGUNITS = "webservice.rm.recipe.menu.getallcookingunits";
	public final static String WEBSERVICE_RM_RECIPE_MENU_GETALLMETRICUNITS = "webservice.rm.recipe.menu.getallmetricunits";
	public final static String WEBSERVICE_RM_RECIPE_MENU_GETALLMETRICUNITS_BYTYPE = "webservice.rm.recipe.menu.getallmetricunitsbytype";
	public final static String WEBSERVICE_RM_RECIPE_MENU_GETMETRICUNITCONVERSIONFACTOR = "webservice.rm.recipe.menu.getmetricunitconversionfactor";
	public final static String WEBSERVICE_RM_EDP_GETALLEDPBYDATE = "webservice.rm.edp.getalledpbydate";
	public final static String WEBSERVICE_RM_EDP_GETEDPBYSTOREIDANDID = "webservice.rm.edp.getedpbystoreidandid";
	public final static String WEBSERVICE_RM_EDP_GETINGREDIENTFOREDP = "webservice.rm.edp.getingredientsforedp";
	public final static String WEBSERVICE_RM_EDP_DELETEEDPITEM = "webservice.rm.edp.deleteedpitem";
	public final static String WEBSERVICE_RM_EDP_CREATEEDP = "webservice.rm.edp.createedp";
	public final static String WEBSERVICE_RM_EDP_APPROVEEDP = "webservice.rm.edp.approveedp";
	public final static String WEBSERVICE_RM_EDP_ADDEDPITEM = "webservice.rm.edp.addedpitem";
	public final static String WEBSERVICE_RM_EDP_UPDATEEDPITEM = "webservice.rm.edp.updateedpitem";
	public final static String WEBSERVICE_RM_EDP_DELETEEDP = "webservice.rm.edp.deleteedp";
	public final static String WEBSERVICE_RM_EDP_REPORT = "webservice.report.automatedinventory.edp.report";
	public final static String WEBSERVICE_RM_EDP_MENU_GETLAYOFFLIST = "webservice.rm.edp.menu.getMenuLayofflist";
	public final static String WEBSERVICE_RM_REQUISITION_GETREQUISITIONBYSTOREIDANDDATE = "webservice.rm.requisition.getrequisitionbydate";
	public final static String WEBSERVICE_RM_REQUISITION_GETREQUISITIONBYIDS = "webservice.rm.requisition.getrequisitionbyids";
	// new added 8.5.2018
	public final static String WEBSERVICE_RM_REQUISITION_GETREQUISITIONBYIDS_NEW = "webservice.rm.requisition.getrequisitionbyids.new";

	public final static String WEBSERVICE_RM_REPORT_REQUISITION_GETREQUISITIONREPORTBYIDS = "webservice.report.automatedinventory.requisition.report";
	public final static String WEBSERVICE_RM_FGSTOCKIN_GETFGSTOCKINBYDATE = "webservice.rm.fgstockin.getfgstockinbydate";
	public final static String WEBSERVICE_RM_FGSTOCKIN_CREATEFGSTOCKIN = "webservice.rm.fgstockin.createfgstockin";
	public final static String WEBSERVICE_RM_FGSTOCKIN_APPROVEFGSTOCKIN = "webservice.rm.fgstockin.approvefgstockin";
	public final static String WEBSERVICE_RM_FGSTOCKOUT_GETFGSTOCKOUTBYDATE = "webservice.rm.fgstockout.getfgstockoutbydate";
	public final static String WEBSERVICE_RM_FGSTOCKOUT_CREATEFGSTOCKOUT = "webservice.rm.fgstockout.createfgstockout";
	public final static String WEBSERVICE_RM_FGCLOSE_GETFGCLOSEBYDATE = "webservice.rm.fgclose.getfgclosebydate";
	public final static String WEBSERVICE_RM_FGCLOSE_CREATEFGCLOSE = "webservice.rm.fgclose.createfgclose";
	public final static String WEBSERVICE_RM_FGCLOSE_APPROVEFGCLOSE = "webservice.rm.fgclose.approvefgclose";
	public final static String WEBSERVICE_RM_RAWSTOCKOUT_GETRAWSTOCKOUTBYDATE = "webservice.rm.rawstockout.getrawstockoutbydate";
	public final static String WEBSERVICE_RM_RAWSTOCKOUT_GETRAWSTOCKOUTBYID = "webservice.rm.rawstockout.getrawstockoutbyid";
	public final static String WEBSERVICE_RM_RAWSTOCKOUT_UPDATERAWSTOCKOUTITEM = "webservice.rm.rawstockout.updaterawstockoutitem";
	public final static String WEBSERVICE_RM_RAWSTOCKOUT_APPROVERAWSTOCKOUT = "webservice.rm.rawstockout.approverawstockout";
	public final static String WEBSERVICE_RM_RAWSTOCKOUT_DELETERAWSTOCKOUT = "webservice.rm.rawstockout.deleterawstockoutitem";
	public final static String WEBSERVICE_RM_RAWCLOSE_GETRAWCLOSEBYDATE = "webservice.rm.rawclose.getrawclosebydate";
	public final static String WEBSERVICE_RM_RAWCLOSE_CREATERAWCLOSE = "webservice.rm.rawclose.createrawclose";
	public final static String WEBSERVICE_RM_RAWCLOSE_APPROVERAWCLOSE = "webservice.rm.rawclose.approverawclose";
	/* End RM module */

	/* Start Room Admin Module */

	public final static String WEBSERVICE_HOTEL_TAX_GETALLTAXES = "webservice.hotel.tax.getalltaxes";
	public final static String WEBSERVICE_HOTEL_TAX_GETALLTAXESBYHOTELID = "webservice.hotel.tax.getalltaxesbyhotelid";
	public final static String WEBSERVICE_HOTEL_TAX_ADDTAX_POST = "webservice.hotel.tax.addtaxpost";
	public final static String WEBSERVICE_HOTEL_TAX_EDITTAX_POST = "webservice.hotel.tax.edittaxpost";
	public final static String WEBSERVICE_HOTEL_TAX_DELETETAX_POST = "webservice.hotel.tax.deletetaxpost";

	public final static String WEBSERVICE_COUNTRY_GETALLCOUNTRIES = "webservice.country.getallcountries";
	public final static String WEBSERVICE_COUNTRY_ADDCOUNTRY_POST = "webservice.country.addcountrypost";
	public final static String WEBSERVICE_COUNTRY_EDITCOUNTRY_POST = "webservice.country.editcountrypost";
	public final static String WEBSERVICE_COUNTRY_DELETECOUNTRY_POST = "webservice.country.deletecountrypost";

	public final static String WEBSERVICE_COUNTRY_HOTELCOUNTRYLINKUP = "webservice.country.hotelcountrylinkup";
	public final static String WEBSERVICE_ROOMTYPE_AMENITIES_GETAMENITIESMAPINFO = "webservice.roomtype.amenities.getamenitiesmapinfo";
	public final static String WEBSERVICE_ROOMTYPE_AMENITIES_ASSIGNAMENITIESMAPINFO = "webservice.roomtype.amenities.assignamenitiesmapinfo";
	public final static String WEBSERVICE_ROOMTYPE_AMENITIES_UPDATEAMENITIESMAPINFO = "webservice.roomtype.amenities.updateamenitiesmapinfo";

	public final static String WEBSERVICE_ROOMMGNT_AMENITIES_GETAMENITIES = "webservice.roommgnt.amenities.getamenities";
	public final static String WEBSERVICE_ROOMMGNT_AMENITIES_ADDAMENITIES = "webservice.roommgnt.amenities.addamenities";
	public final static String WEBSERVICE_ROOMMGNT_AMENITIES_UPDATEAMENITIES = "webservice.roommgnt.amenities.updateamenities";
	public final static String WEBSERVICE_ROOMMGNT_AMENITIES_DELETEAMENITIES = "webservice.roommgnt.amenities.deleteamenities";
	public final static String WEBSERVICE_ROOMMGNT_ROOMTYPE_GETROOMTYPES = "webservice.roommgnt.roomtype.getroomtypes";
	public final static String WEBSERVICE_ROOMMGNT_ROOMTYPE_ADDROOMTYPES = "webservice.roommgnt.roomtype.addroomtypes";
	public final static String WEBSERVICE_ROOMMGNT_ROOMTYPE_EDITROOMTYPES = "webservice.roommgnt.roomtype.editroomtypes";
	public final static String WEBSERVICE_ROOMMGNT_ROOMTYPE_DELETEROOMTYPES = "webservice.roommgnt.roomtype.deleteroomtypes";
	public final static String WEBSERVICE_ROOMMGNT_ROOM_ADDROOM = "webservice.roommgnt.room.addroom";
	public final static String WEBSERVICE_ROOMMGNT_ROOM_DELETEROOM = "webservice.roommgnt.room.deleteroom";
	public final static String WEBSERVICE_ROOMMGNT_ROOM_EDITROOM = "webservice.roommgnt.room.editroom";
	public final static String WEBSERVICE_ROOMMGNT_ROOM_GETROOM = "webservice.roommgnt.room.getroom";
	public final static String WEBSERVICE_ROOMMGNT_ROOMSERVICES_GETROOMSERVICES = "webservice.roommgnt.roomservices.getroomservices";
	public final static String WEBSERVICE_ROOMMGNT_ROOMSERVICES_ADDROOMSERVICES = "webservice.roommgnt.roomservices.addroomservices";
	public final static String WEBSERVICE_ROOMMGNT_ROOMSERVICES_EDITROOMSERVICES = "webservice.roommgnt.roomservices.editroomservices";
	public final static String WEBSERVICE_ROOMMGNT_ROOMSERVICES_DELETEROOMSERVICES = "webservice.roommgnt.roomservices.deleteroomservices";
	public final static String WEBSERVICE_ROOMMGNT_ROOMSERVICES_BOOKROOM = "webservice.roommgnt.roomservices.bookroom";
	public final static String WEBSERVICE_BASE_ROOM_GETROOMBYSEARCHCRITERIA = "webservice.base.room.getroombysearchcriteria";
	public final static String WEBSERVICE_BASE_ROOM_GETALLRESERVEIDBYHOTELID = "webservice.base.room.getallreserveidbyhotelid";
	public final static String WEBSERVICE_BASE_ROOM_GETALLRESERVEIDBYDATEPERIOD = "webservice.base.room.getallreserveidbydateperiod";
	public final static String WEBSERVICE_BASE_ROOM_CANCELBOOKINGBYRESERVEID = "webservice.base.room.cancelbookingbyreserveid";
	public final static String WEBSERVICE_BASE_ROOM_ADVANCEMENTBYRESERVEID = "webservice.base.room.advancepaymentbyreserveid";
	public final static String WEBSERVICE_BASE_ROOM_GETCUSTOMERDETAILSBYRESERVEID = "webservice.base.room.getcustomerdetailsbyreserveid";
	public final static String WEBSERVICE_BASE_ROOM_GETRROMDETAILSBYID = "webservice.base.room.getroomdetailsbyid";
	public final static String WEBSERVICE_ROOM_RESERVEROOM_POST = "webservice.room.reserveroompost";
	public final static String WEBSERVICE_ROOM_BOOKROOM_POST = "webservice.room.bookroompost";
	public final static String WEBSERVICE_BASE_ROOM_CHANGEROOM = "webservice.base.room.changeroom";
	public final static String WEBSERVICE_ADMIN_ROOM_BILLREGISTER = "webservice.admin.roommgnt.getallbillsperiodwise";

	// public final static String WEBSERVICE_ROOM_BOOKROOM_POST_STORE =
	// "webservice.room.bookroompost.store";
	public final static String WEBSERVICE_BASE_ROOM_GETALLRESERVEID_BYCUSTID_BYDATEPERIOD = "webservice.base.room.getallreserveid.bycustid.bydateperiod";
	public final static String WEBSERVICE_HOTEL_GETCUSTOMERDETAILS_BYNAME = "webservice.hotel.getcustomerdetails.byname";
	public final static String WEBSERVICE_HOTEL_GETCUSTOMERDETAILS_BYPHNO = "webservice.hotel.getcustomerdetails.byphno";
	public final static String WEBSERVICE_HOTEL_GETRESERVEDETAILSLIST_BYRESID = "webservice.hotel.getreservedetailslist.byresid";
	public final static String WEBSERVICE_BASE_ROOM_GETALLRESERVEID_BYRESID = "webservice.base.room.getallreserveid.byresid";
	public final static String WEBSERVICE_BASE_ROOM_TAXCHANGE = "webservice.base.room.taxchange";

	public final static String WEBSERVICE_BASE_ROOM_GETALLCHECKIN_BYDATEPERIOD = "webservice.base.room.getallcheckin.bydateperiod";
	public final static String WEBSERVICE_BASE_ROOM_GETALLBOOKINGID_BYCUSTID = "webservice.base.room.getallbookingid.bycustid";
	public final static String WEBSERVICE_BASE_ROOM_GETBOOKINGIDLIST_BYBOOKINGID = "webservice.base.room.getbookingidlist.bybookingid";
	public final static String WEBSERVICE_BASE_ROOM_GETALLBOOKINGDETAILS_BYBOOKINGID = "webservice.base.room.getallbookingdetails.bybookingid";
	public final static String WEBSERVICE_BASE_ROOM_CHECKOUT = "webservice.base.room.checkout";
	public final static String WEBSERVICE_BASE_ROOM_CHECKIN = "webservice.base.room.checkin";
	public final static String WEBSERVICE_HOTEL_GETROOMCUSTOMERDETAILS_BYPHNO = "webservice.hotel.getroomcustomerdetails.byphno";
	public static final String WEBSERVICE_HOTEL_ROOMMGNT_CUSTOMER_GETCUSTOMERIDTYPES = "webservice.hotel.getroomcustomeridtypedetails";
	public static final String WEBSERVICE_BASE_ROOM_CHECKOUT_UPDATE = "webservice.hotel.updatecheckoutdetails";
	public static final String WEBSERVICE_BASE_ROOM_ADD_DISCOUNT = "webservice.hotel.room.adddiscount";

	public final static String WEBSERVICE_BASE_ROOM_GETALLBOOKINGDETAILS_BYBOOKINGID_FORFINALBILL = "webservice.base.room.getallbookingdetails.bybookingid.forfinalbill";

	public final static String WEBSERVICE_BASE_ROOM_GETROOMBOOKINGTYPE = "webservice.base.room.getroombookingtypes";
	public final static String WEBSERVICE_HOTEL_BASE_ROOM_CUSTOMER_ADDSTORECUSTOMER = "webservice.hotel.base.room.customer.addstorecustomer";
	public final static String WEBSERVICE_HOTEL_BASE_ROOM_GETCUSTOMER_BYID="webservice.hotel.getcustomer.byid";
	public final static String WEBSERVICE_HOTEL_BASE_ROOM_GETPAYMENTINFO_BYBOOKINGID="webservice.hotel.getpaymentinfo.bybookingid";
	public final static String WEBSERVICE_BASE_ROOM_ADDSERVICES = "webservice.base.room.addservices";
  public final static String WEBSERVICE_BASE_ROOM_GETSERVICES_BYBOOKINGID = "webservice.base.room.getservices.bybookingid";
  public final static String WEBSERVICE_BASE_ADD_ROOM_BOOKING_GUEST = "webservice.base.room.addRoomBookingGuest";
  public final static String WEBSERVICE_BASE_GET_ROOM_BOOKING_GUEST= "webservice.base.room.getRoomBookingGuest";
  public final static String WEBSERVICE_BASE_ROOM_UPLOAD_CUST_IMAGE = "webservice.base.room.uploadcustimage";
  public final static String WEBSERVICE_BASE_ROOM_GET_CUST_IMAGE_BY_ID ="webservice.base.room.getcustimage";
	/* End Room Admin module */

	/* Start Language module */
	public final static String WEBSERVICE_LANGUAGE = "webservice.language.getlang.languagelist";
	/* End Language module */

	/* Accounts Module */

	public final static String WEBSERVICE_INV_GET_ALL_ACCGROUP = "webservice.acc.getall.accgroup";
	public final static String WEBSERVICE_INV_GET_ALL_ACCTYPE = "webservice.acc.getall.acctype";
	public final static String WEBSERVICE_ACC_ADD_GROUP = "webservice.acc.add.group";
	public final static String WEBSERVICE_ACC_UPDATE_GROUP = "webservice.acc.update.group";
	public final static String WEBSERVICE_ACC_DELETE_ACCGROUP = "webservice.acc.delete.accgroup";
	public final static String WEBSERVICE_ACC_SETUP_NEWACCOUNT = "webservice.acc.setup.addaccount";
	public final static String WEBSERVICE_ACC_SETUP_UPDATEACCOUNT = "webservice.acc.setup.updateaccount";
	public final static String WEBSERVICE_ACC_SETUP_GETALLACCOUNTSETUP = "webservice.acc.setup.getallaccount";
	public final static String WEBSERVICE_ACC_SETUP_DELETE = "webservice.acc.setup.deleteaccount";
	public final static String WEBSERVICE_ACC_SETUP_ALREAD_EXIST = "webservice.acc.setup.check_acc_already_exist";
	public final static String WEBSERVICE_ACC_SEARCH_LEDGER = "webservice.acc.setup.searchledger";
	public final static String WEBSERVICE_ACC_SEARCH_LEDGER_BANK = "webservice.acc.setup.searchledger_cash_bank";
	public final static String WEBSERVICE_CHART_OF_ACCOUNT = "webservice.acc.setup.chartofaccount";
	// Accounts.search
	public final static String WEBSERVICE_INV_GET_ALLVENDOR_LEGER = "webservice.inv.get.allvendor.ledgersearch";
	public final static String WEBSERVICE_INV_GET_ALL_LEGER_BY_GROUP_CODE = "webservice.inv.get.allvendor.ledgersearch";

	/*
	 * FOR JOURNAL
	 */
	public final static String WEBSERVICE_ACC_ENTRY_TYPE = "webservice.acc.setup.entrytypes";
	public final static String WEBSERVICE_ACC_ADD_JOURNAL = "webservice.acc.setup.addjournal";
	public final static String WEBSERVICE_ACC_DEL_JOURNAL = "webservice.acc.setup.deljournal";
	public final static String WEBSERVICE_ACC_GET_JOURNAL_LIST = "webservice.acc.setup.getjournallist";
	public final static String WEBSERVICE_ACC_GET_JOURNAL_BY_ID = "webservice.acc.setup.editjournallist";
	public final static String WEBSERVICE_ACC_UPDATE_JOURNAL = "webservice.acc.setup.updatejournal";

	/*
	 * for account report
	 */

	public final static String WEBSERVICE_ACCOUNT_REPORT_SEARCH_BY_GROUP = "webservice.acc.setup.account_report_leger_search_by_group";
	public final static String WEBSERVICE_ACCOUNT_REPORT = "webservice.acc.setup.account_report";
	public final static String WEBSERVICE_ACCOUNT_TRIAL_BALANCE = "webservice.acc.setup.trialbalance";
	public final static String WEBSERVICE_ACCOUNT_BALANCE_SHEET = "webservice.acc.setup.balance_sheet";
	public final static String WEBSERVICE_ACCOUNT_BALANCE = "webservice.acc.setup.account_balance_report";
	public final static String WEBSERVICE_ACCOUNT_PROFIT_AND_LOSS = "webservice.acc.setup.profitandloss";
	public final static String WEBSERVICE_ACCOUNT_DAILY_COLLETION = "webservice.acc.setup.dailycollection_acc";
	public final static String WEBSERVICE_ACCOUNT_DAILY_PAYMENT = "webservice.acc.setup.dailypayment_acc";
	public final static String WEBSERVICE_ADVANCE_ORDER_COUNT = "webservice.aqadvanc.order.count";

	/* End Accounts Module */
	
	/* HR Module */
	public final static String WEBSERVICE_HR_GET_ALL_DEPARTMENT = "webservice.admin.hr.getalldepartment";
	public final static String WEBSERVICE_HR_GET_ALL_DESIGNATION = "webservice.admin.hr.getalldesignation";
	public final static String WEBSERVICE_INVENTORY_UPDATE_DESIGNATION = "webservice.admin.hr.editdesignation";
	public final static String WEBSERVICE_INVENTORY_DELETE_DESIGNATION = "webservice.admin.hr.deletedesignation";
	public final static String WEBSERVICE_HRMGNT_DESIGNATION_ADD_POST = "webservice.admin.hr.adddesignation";
	public final static String WEBSERVICE_HRMGNT_DEPARTMENT_ADD_POST = "webservice.admin.hr.adddepartment";
	public final static String WEBSERVICE_HR_UPDATE_DEPARTMENT = "webservice.admin.hr.editdepartment";
	public final static String WEBSERVICE_HR_DELETE_DEPARTMENT = "webservice.admin.hr.deletedepartment";
	public final static String WEBSERVICE_HR_GET_ALL_DUTY_SHIFT = "webservice.admin.hr.getalldutyshift";
	public final static String WEBSERVICE_HR_GET_DUTY_SHIFT = "webservice.admin.hr.getdutyshift";
	public final static String WEBSERVICE_HRMGNT_ADD_DUTY_SHIFT = "webservice.admin.hr.adddutyshift";
	public final static String WEBSERVICE_HR_UPDATE_DUTY_SHIFT = "webservice.admin.hr.updatedutyshift";
	public final static String WEBSERVICE_HR_DELETE_DUTY_SHIFT = "webservice.admin.hr.deletedutyshift";
	public final static String WEBSERVICE_HR_GET_ALL_EMPLOYEE_TYPES = "webservice.admin.hr.getallemployeetypes";
	public final static String WEBSERVICE_HRMGNT_ADD_EMPLOYEE_TYPE = "webservice.admin.hr.addemployeetype";
	public final static String WEBSERVICE_HR_GET_EMPLOYEE_TYPE = "webservice.admin.hr.getemployeetypebyid";
	public final static String WEBSERVICE_HR_UPDATE_EMPLOYEE_TYPE = "webservice.admin.hr.updateemployeetype";
	public final static String WEBSERVICE_HR_DELETE_EMPLOYEE_TYPE = "webservice.admin.hr.deleteemployeetype";
	public final static String WEBSERVICE_HR_ADD_EMPLOYEE = "webservice.admin.hr.addemployee";
	public final static String WEBSERVICE_HR_EMPLOYEE_IMAGE_UPLOAD = "webservice.admin.hr.uploadimage";
	public final static String WEBSERVICE_HR_EMPLOYEE_DOCUMENT_UPLOAD = "webservice.admin.hr.uploaddocument";
	public final static String WEBSERVICE_HR_GET_ALL_EMPLOYEES ="webservice.admin.hr.getallemployees";
	public final static String WEBSERVICE_HR_GET_EMPLOYEE_BY_ID ="webservice.admin.hr.getemployeebyid";
	public final static String WEBSERVICE_HR_UPDATE_EMPLOYEE ="webservice.admin.hr.updateemployee";
	public final static String WEBSERVICE_HR_DELETE_EMPLOYEE ="webservice.admin.hr.deleteemployee";
	public final static String WEBSERVICE_HR_GET_EMPLOYEEIMAGE_BY_ID ="webservice.admin.hr.getemployeeimage";
	public final static String WEBSERVICE_HR_GET_EMPLOYEEDOCIMAGE_BY_ID ="webservice.admin.hr.getemployeedocimage";
	public final static String WEBSERVICE_HR_LOAD_SHIFT_SCHEDULE ="webservice.admin.hr.loadshiftschedule";
	public final static String WEBSERVICE_HR_GET_ALL_EMPLOYEE_SHIFT_SCHEDULE ="webservice.admin.hr.getallemployeeshiftschedule";
	public final static String WEBSERVICE_HR_GET_EMPLOYEE_SHIFT_SCHEDULE_BY_ID_AND_DATE ="webservice.admin.hr.getemployeeshiftschedulebyidanddate";
	public final static String WEBSERVICE_HR_ADD_EMPLOYEE_SHIFT_SCHEDULE ="webservice.admin.hr.addemployeeshiftschedule";
	public final static String WEBSERVICE_HR_UPDATE_EMPLOYEE_SHIFT_SCHEDULE = "webservice.admin.hr.updateemployeeshiftschedule";
	public final static String WEBSERVICE_HR_CANCEL_EMPLOYEE_SHIFT_SCHEDULE = "webservice.admin.hr.cancelemployeeshiftschedule";
	public final static String WEBSERVICE_HR_ADD_EMPLOYEE_ATTENDANCE ="webservice.admin.hr.addemployeeattendance";
	public final static String WEBSERVICE_HR_GET_EMPLOYEE_ATTENDANCE_BY_ID_AND_DATE ="webservice.admin.hr.getemployeeattendancebyidanddate";
	public final static String WEBSERVICE_HR_GET_ALL_EMPLOYEE_ATTENDANCE="webservice.admin.hr.getallemployeeattendance";
	public final static String WEBSERVICE_HR_GET_ALL_EMPLOYEE_LEAVES="webservice.admin.hr.getemployeeleaves";
	public final static String WEBSERVICE_HR_GET_ALL_EMPLOYEE_LEAVES_CALCULATION_BY_YEAR="webservice.admin.hr.getemployeeleavescalculationbyyear";
	//public final static String WEBSERVICE_HR_ADD_DUTY_SHIFT="webservice.admin.hr.adddutyshift";
	/* END OF HR Module*/
	
	/* SMS data fetch */
	public final static String WEBSERVICE_STORE_SMS_DATA = "webservice.store.sms.smsdata";

	/* Dash board data fetch */
	public final static String WEBSERVICE_STORE_DASHBOARD_SALESSUMMARY = "webservice.store.dash.salessummary";
	public final static String WEBSERVICE_STORE_DASHBOARD_PAYMENTSUMMARY = "webservice.store.dash.paymentsummary";
	public final static String WEBSERVICE_STORE_DASHBOARD_SALESSUMMARYORDERTYPE = "webservice.store.dash.salesummaryordertype";
	public final static String WEBSERVICE_STORE_DASHBOARD_SALESSUMMARYPAYMENTTYPE = "webservice.store.dash.salesummarypaymenttype";
	public final static String WEBSERVICE_STORE_DASHBOARD_TOPCUSTOMERS = "webservice.store.dash.topcustomer";
	public final static String WEBSERVICE_STORE_DASHBOARD_TOPITEMS = "webservice.store.dash.topitem";

	private static DateFormat dateFormatser = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
	private static DateFormat dateFormatdeser = new SimpleDateFormat("MMM dd, yyyy hh:mm:ss a", Locale.US);
	static JsonSerializer<Date> serializer = new JsonSerializer<Date>() {
		@Override
		public JsonElement serialize(Date date, Type type, JsonSerializationContext jsonSerializationContext) {
			return new JsonPrimitive(dateFormatser.format(date));
		}
	};

	static JsonDeserializer<Date> deserializer = new JsonDeserializer<Date>() {
		@Override
		public Date deserialize(JsonElement jsonElement, Type type,
				JsonDeserializationContext jsonDeserializationContext) {
			try {
				return dateFormatdeser.parse(jsonElement.getAsString());
			} catch (Exception e) {
				throw new JsonParseException(e);
			}
		}
	};

	public final static Gson GSON = new GsonBuilder().registerTypeAdapter(Date.class, serializer)
			.registerTypeAdapter(Date.class, deserializer).create();

	private static Properties getProperties() {
		logger.info("CommonResource initialized [+] ...");
		try {
			Properties properties = new Properties();
			properties.load(CommonResource.class.getClassLoader()
					.getResourceAsStream("com/sharobi/webpos/resources/commonResource.properties"));
			logger.debug("CommonResource properties loaded");
			return properties;
		} catch (Exception ex) {
			logger.error("Failed to initialize CommonResource [-] ", ex);
			return null;
		}
	}

	public static String getProperty(String key) {
		return resourceProperties.getProperty(key);
	}
}
