/**
 * 
 */
function viewDashboard(){
	location.href = BASE_URL + '/dash/viewmdashboard.htm';
}

function viewRoomBookingDashboard(){
	location.href = BASE_URL + '/dash/viewroombookingdashboard.htm';		
}

function viewCategories(){
	location.href = BASE_URL + '/menumgnt/viewmenumgnt.htm';
}

function loadSubCategory(){
	location.href = BASE_URL + '/menumgnt/loadsubcategory.htm';
}

function loadMenuItems(){
	location.href = BASE_URL + '/menumgnt/loadmenuitems.htm';
}

function loadDepartment(){
	location.href = BASE_URL + '/hrmgmt/viewmdepartment.htm';
}

function loadDesignation(){
	location.href = BASE_URL + '/hrmgmt/viewmdesignation.htm';
}

function loadEmployeeType(){
	location.href = BASE_URL + '/hrmgmt/viewemployeetype.htm';
}

function loadEmployeeDetails(){
	location.href = BASE_URL + '/hrmgmt/viewmemployeedetails.htm';
}

function loadDutyShift(){
	location.href = BASE_URL + '/hrmgmt/viewmdutyshift.htm';
}

function loadShiftSchedule(){
	////alert("CALLS loadShiftSchedule() FUNCTION");
	location.href = BASE_URL + '/hrmgmt/loadshiftschedule.htm';
	
}

function loadEmployeeAttendance(){
	location.href = BASE_URL + '/hrmgmt/loademployeeattendance.htm';
}

function loadEmployeeLeaveDetails(){
	location.href = BASE_URL + '/hrmgmt/loademployeeleavedetails.htm';
}

function loadAllSpecialNote(){
	location.href = BASE_URL + '/menumgnt/loadallspecialnotes.htm';
}

function menuItemsTranslation(){
	//alert(BASE_URL);
	location.href = BASE_URL + '/menutranslation/loadmenuitemtotranslate.htm?lang=' + PAGE_CONTEXT_LOCAL ;
}

function categoryAndSubcategoryTranslation(){
	location.href = BASE_URL + '/catNSubcattranslation/loadmenucatnsubcattotranslatewithlang.htm?lang=' + PAGE_CONTEXT_LOCAL;
}

function loadTableManagement(){
	location.href = BASE_URL + '/tablemgnt/loadtablemgnt.htm';
}

function loadAdvanceBooking(){
	location.href = BASE_URL + '/advancebooking/loadadvancebooking.htm';
}

function loadTableLayout(){
	location.href = BASE_URL + '/tablemgnt/loadtablelayout.htm';
}

function serviceChargeSetup(){
	location.href = BASE_URL + '/servicecharge/viewservicecharge.htm';
}

function setUpDeliveryBoy(){
	location.href = BASE_URL + '/deliveryboy/viewdeliveryboy.htm';
}

function loadDaywiseUnpaidOrder(){
	location.href = BASE_URL + '/unpaidorderlist/loadunpaidorder.htm';
}

function loadPeriodWiseUnpaidOrder(){
	location.href = BASE_URL + '/unpaidorderlist/loadunpaidorderperiodwise.htm';
}

function loadTaxSetup(){
	location.href = BASE_URL + '/taxmgnt/viewtaxmgnt.htm';
}

function loadVendors(){
	location.href = BASE_URL + '/vendormgnt/loadvendormgnt.htm';
}

function loadInventoryType(){
	location.href = BASE_URL + '/inventorymgnt/loadinvtypemgnt.htm';
}

function loadInventoryItem(){
	location.href = BASE_URL + '/inventorymgnt/loadsimpleinvitemmgnt.htm';
}

function loadVendorPayment(){
	location.href = BASE_URL + '/vendormgnt/loadvendorpayment.htm';
}

function viewUploadMenu(){
	location.href = BASE_URL + '/menumgnt/viewmenuitemupload.htm';
}

function addExpenditure(){
	location.href = BASE_URL + '/expendituremgmt/loadexpendituremgmt.htm';
}

function viewPeriodWiseExpenditure(){
	location.href = BASE_URL + '/expendituremgmt/viewdailyexpenditure.htm';
}

function loadStaff(){
	location.href = BASE_URL + '/storecustomermgnt/loadstorecustomermgnt.htm';
}

function loadStaffExpenditure(){
	location.href = BASE_URL + '/creditsale/loadcreditcustomer.htm';
}

function loadCustomer(){
	location.href = BASE_URL + '/storecustomermgnt/loadstorecustomermgnt.htm';
}

function loadCreditSales(){
	location.href = BASE_URL + '/creditsale/loadcreditcustomer.htm';
}

function loadCreditBooking(){
	location.href = BASE_URL + '/creditsale/loadcreditbooking.htm';
}

function openOrderRefund(){
	location.href = BASE_URL + '/order/openorderrefund.htm';
}

function openChangePassword(){
	location.href = BASE_URL + '/admin/openchangepassword.htm';
}

function openDatabaseBackup(){
	location.href = BASE_URL + '/admin/databasebackup.htm';
}

function loadCleanLog(){
	location.href = BASE_URL + '/admin/loadcleanlogfile.htm';
}

function viewHotelTaxSetup(){
	location.href = BASE_URL + '/hoteltaxmgnt/viewhoteltaxmgnt.htm';
}

function viewCountrySetUp(){
	location.href = BASE_URL + '/countrymgnt/viewcountrymgnt.htm';
}

function viewHotelandCountryLinkUp(){
	location.href = BASE_URL + '/countrymgnt/viewcountryhotelmgnt.htm';
}

function viewRoomsAndAmenitiesSetup(){
	location.href = BASE_URL + '/roomtypeamenitiesmgnt/viewroomtypeamenitiesmgnt.htm';
}

function loadAmenities(){
	location.href = BASE_URL + '/rmmgnt/loadamenities.htm';
}

function loadRoomType(){
	location.href = BASE_URL + '/rmtypemgnt/loadroomtype.htm';
}

function loadRoom(){
	location.href = BASE_URL + '/roommgnt/loadroom.htm';
}

function loadRoomServices(){
	location.href = BASE_URL + '/rmservicemgnt/loadroomservices.htm';
}

function loadBillRegister(){
	location.href = BASE_URL + '/rmservicemgnt/loadbillregister.htm';
}
function loadAssetMaster()
{
location.href= BASE_URL +'/asset/loadassetMaster.htm';	
}