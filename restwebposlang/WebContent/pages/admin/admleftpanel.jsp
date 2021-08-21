<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <c:if test="${sessionScope.loggedinStore.isHr=='N'}">  --%>
<div class="col-md-2 col-sm-2" id="admleftpanid">
<%-- <c:if test="${sessionScope.loggedinStore.isHr=='Y'}"> --%>
	<div class="menu-category" style="height: 100%;">
		<div style="overflow-y: auto; height: 500px;">
		
			<div style="padding: 5px;">
				<!-- <div class="item" style="margin-bottom:10px;">
                        </div> -->
                        <div id="forAdmin">
				<div  class="item item-sub-child" style="background: #FF8576;">
					<a href="javascript:viewDashboard()">DASHBOARD</a>
				</div>
				<c:if test="${sessionScope.loggedinStore.roomBooking=='Y'}">
				<div  class="item item-sub-child" style="background: #FF8576;">
					<a href="javascript:viewRoomBookingDashboard()">RB DASHBOARD</a>
				</div>
				
				</c:if>
				
				<div class="item item-sub-child" style="background: #FF8576;">
					<a href="javascript:viewCategories()"><spring:message code="admin.admleftpanel.jsp.category" text="CATEGORIES" /></a>
				</div>
				<div class="item item-sub-child" style="background-color: #41A1E3;">
					<a href="javascript:loadSubCategory()"><spring:message code="admin.admleftpanel.jsp.subCategory" text="SUB CATEGORIES" /></a>
				</div>
				<div class="item item-sub-child" style="background-color: #41A1E3;">
					<a href="javascript:loadMenuItems()"><spring:message code="admin.admleftpanel.jsp.menuItems" text="MENU ITEMS" /></a>
				</div>
				
				<div class="item item-sub-child" style="background-color: #41A1E3;">
					<a href="javascript:loadAllSpecialNote()"><spring:message code="admin.admleftpanel.jsp.specialNote" text="SPECIAL NOTE" /></a>
				</div>
				
				<%-- <div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadDepartment()"><spring:message code="admin.admleftpanel.jsp.department" text="DEPARTMENT" /></a>
				</div>
				
				
				<div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadDesignation()"><spring:message code="admin.admleftpanel.jsp.designation" text="DESIGNATION" /></a>
				</div>
				
				<div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadEmployeeType()"><spring:message code="admin.admleftpanel.jsp.employee" text="EMPLOYEE TYPE" /></a>
				</div>
				
				<div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadEmployeeDetails()"><spring:message code="admin.admleftpanel.jsp.employeedetail" text="EMPLOYEE" /></a>
				</div>
				
				<div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadDutyShift()"><spring:message code="admin.admleftpanel.jsp.dutyshift" text="DUTY SHIFT" /></a>
				</div> --%>
				</div>
			
				<%--  <c:if test="${sessionScope.loggedinStore.isHr=='Y'}"> 
				<div id="i1" class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadShiftSchedule()"><spring:message code="admin.admleftpanel.jsp.shiftschedule" text="SHIFT SCHEDULE" /></a>
				</div>
				
				<div id="i2" class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadEmployeeAttendance()"><spring:message code="admin.admleftpanel.jsp.shiftschedule" text="EMPLOYEE ATTENDANCE" /></a>
				</div>
				
				<div id="i3" class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadEmployeeLeaveDetails()"><spring:message code="admin.admleftpanel.jsp.shiftschedule" text="EMPLOYEE LEAVE DETAILS" /></a>
				</div>
				</c:if>  --%>
				
				<div  id="forAdmin2" class="item item-sub-child" style="background-color: #8080090;">
					<a href="javascript:loadAssetMaster()"><spring:message code="admin.admleftpanel.jsp.assetmaster" text="ASSET MASTER" /></a>
				</div>
              <div id="forAdmin3">
				<div  class="item item-sub-child" style="background-color: #25968D;">
					<a href="javascript:menuItemsTranslation()"> <spring:message code="admin.admleftpanel.jsp.menuItems.translation"
							text="MENU ITEMS TRANSLATION " /></a>
				</div>
				<div class="item item-sub-child" style="background-color: #25968D;">
					<a href="javascript:categoryAndSubcategoryTranslation()"><spring:message
							code="admin.admleftpanel.jsp.catnsubcat.translation"
							text="CAT N SUBCAT TRANSLATION" /></a>
				</div>
				<div class="item item-sub-child"
					style="background-color: #FF8576; margin-top: 20px;">
					<a href="javascript:loadTableManagement()"><spring:message
							code="admin.admleftpanel.jsp.tables" text="TABLES" /></a>
				</div>
				
				<c:if test="${sessionScope.loggedinStore.advOrder=='Y'}">
					<div class="item item-sub-child" style="background-color: #FF8576;">
						<a href="javascript:loadAdvanceBooking()"><spring:message
								code="admin.admleftpanel.jsp.prebooking" text="ADV BOOKING" /></a>
					</div>
				</c:if>
				<c:if test="${sessionScope.loggedinStore.tableLayout=='Y'}">
					<div class="item item-sub-child" style="background-color: #FF8576;">
						<a href="javascript:loadTableLayout()"><spring:message
								code="admin.admleftpanel.jsp.tableLayout" text="TABLE LAYOUT" /></a>
					</div>
				</c:if>

				<c:if test="${sessionScope.loggedinStore.serviceChargeFlag=='Y'}">
					<div class="item item-sub-child" style="background-color: #FF8576;">
						<a href="javascript:serviceChargeSetup()"><spring:message
								code="admin.admleftpanel.jsp.serviceChargeSetup"
								text="SERVICE CHARGE SETUP" /></a>
					</div>
				</c:if>

				<c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y'}">
					<div class="item item-sub-child" style="background-color: #FF8576;">
						<a href="javascript:setUpDeliveryBoy()"><spring:message
								code="admin.admleftpanel.jsp.deliveryBoySetup"
								text="DELIVERY BOY SETUP" /></a>
					</div>
				</c:if>


				<%--   <c:if test="${sessionScope.loggedinStore.tableLayout=='Y'}">
                   			
                   	     <c:choose>
                   	     	<c:when test="${sessionScope.storedetails.enterpriseTblLayout=='Y'}">
					      <div class="item item-sub-child" style="background-color:#FF8576;">
                   		   <a href="javascript:location.href='${pageContext.request.contextPath}/tablemgnt/loadtablelayoutenterprice.htm'"><spring:message code="admin.admleftpanel.jsp.tableLayout" text="TABLE LAYOUT" /></a>
                   	     </div>
					      </c:when>
					   	<c:otherwise>				      
					      <div class="item item-sub-child" style="background-color:#FF8576;">
                   		    <a href="javascript:location.href='${pageContext.request.contextPath}/tablemgnt/loadtablelayout.htm'"><spring:message code="admin.admleftpanel.jsp.tableLayout" text="TABLE LAYOUT" /></a>
                   	      </div>
					    </c:otherwise>
					    </c:choose>
                   	</c:if>   --%>



				<div class="item item-sub-child"
					style="background-color: #000; margin-top: 20px;">

					<a href="#5" class="list-group-item" style="background: #C60;"
						data-toggle="collapse" data-parent="#accord"><spring:message
							code="admin.admleftpanel.jsp.UnpaidOrders" text="UNPAID ORDERS" /></a>

					<div class="collapse" id="5">

						<a href="javascript:loadDaywiseUnpaidOrder()"
							class="list-group-item" style="background: #999;">DAY WISE<%-- <spring:message
												code="admin.rptleftpanel.jsp.dayWise" text="CUSTOMER DETAILS" /> --%></a>

						<a href="javascript:loadPeriodWiseUnpaidOrder()"
							class="list-group-item" style="background: #999;">PERIOD WISE<%-- <spring:message
												code="admin.rptleftpanel.jsp.topCust" text="TOP 5 CUSTOMERS" /> --%></a>
					</div>
				</div>


				<div class="item item-sub-child"
					style="background-color: #41A1E3; margin-top: 10px;">
					<a href="javascript:loadTaxSetup()"><spring:message
							code="admin.admleftpanel.jsp.taxSetup" text="TAX SETUP" /></a>
				</div>

				<c:if
					test="${sessionScope.loggedinStore.simpleIm=='Y' || sessionScope.loggedinStore.smartIm=='Y'}">

					<div class="item item-sub-child"
						style="background-color: #FF8576; margin-top: 20px;">
						<a href="javascript:loadVendors()"><spring:message
								code="admin.admleftpanel.jsp.vendor" text="VENDOR" /></a>
					</div>
					<div class="item item-sub-child" style="background-color: #41A1E3;">
						<a href="javascript:loadInventoryType()"><spring:message
								code="admin.admleftpanel.jsp.invType" text="INVENTORY TYPE" /></a>
					</div>
					<%-- <div class="item item-sub-child" style="background-color:#E0B12F;">
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/inventorymgnt/loadinvitemmgnt.htm'">INVENTORY ITEM</a>
                    	</div> --%>
					<div class="item item-sub-child" style="background-color: #6327F7;">
						<a href="javascript:loadInventoryItem()"><spring:message
								code="admin.admleftpanel.jsp.invItem" text="INVENTORY ITEM" /></a>
					</div>
					<div class="item item-sub-child" style="background-color: #41A1E3;">
						<a href="javascript:loadVendorPayment()"><spring:message
								code="admin.admleftpanel.jsp.invItem.vendorpayment"
								text="VENDOR PAYMENT" /></a>
					</div>
				</c:if>




				<div class="item item-sub-child" style="background-color: #FF8576;">
					<a href="javascript:viewUploadMenu()">UPLOAD MENU</a>
				</div>
				<div class="item item-sub-child" style="background-color: #FF8576;">
					<a href="javascript:addExpenditure()">ADD EXPENDITURE</a>
				</div>
				<div class="item item-sub-child" style="background-color: #FF8576;">
					<a href="javascript:viewPeriodWiseExpenditure()">VIEW PERIOD
						WISE EXPENDITURE</a>
				</div>
				
				<c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
					<c:choose>
						<c:when test="${sessionScope.loggedinStore.id==87}">
							<div class="item item-sub-child"
								style="background-color: #FF8576; margin-top: 20px;">
								<a href="javascript:loadStaff()"><spring:message
										code="admin.admleftpanel.jsp.staff" text="STAFF" /></a>
							</div>
							<div class="item item-sub-child"
								style="background-color: #41A1E3;">
								<a href="javascript:loadStaffExpenditure()"><spring:message
										code="admin.admleftpanel.jsp.staffExpenditure"
										text="STAFF EXPENDITURE" /></a>
							</div>
						</c:when>
						<c:otherwise>
							<div class="item item-sub-child"
								style="background-color: #FF8576; margin-top: 20px;">
								<a href="javascript:loadCustomer()"><spring:message
										code="admin.admleftpanel.jsp.customer" text="CUSTOMER" /></a>
							</div>
							<div class="item item-sub-child"
								style="background-color: #41A1E3;">
								<a href="javascript:loadCreditSales()"><spring:message
										code="admin.admleftpanel.jsp.creditSale" text="CREDIT SALE" /></a>
							</div>
							<div class="item item-sub-child"
								style="background-color: #41A1E3;">
								<a href="javascript:loadCreditBooking()"><spring:message
										code="admin.admleftpanel.jsp.creditBooking" text="CREDIT BOOKING" /></a>
							</div>
						</c:otherwise>
					</c:choose>

				</c:if>
				<c:if test="${sessionScope.loggedinStore.isRefund=='Y'}">
					<div class="item item-sub-child" style="background: purple;">
						<a href="javascript:openOrderRefund()"><spring:message
								code="admin.admleftpanel.jsp.refundorder" text="ORDER REFUND" /></a>
					</div>
				</c:if>



				<div class="item item-sub-child hide" style="background: purple;">
					<a href="javascript:openChangePassword()"><spring:message
							code="admin.admleftpanel.jsp.changePW" text="CHANGE PASSWORD" /></a>
				</div>
				<div class="item item-sub-child "
					style="background-color: #FF8576; margin-top: 20px; margin-bottom: 10px;">
					<a href="javascript:openDatabaseBackup()"><spring:message
							code="admin.admleftpanel.jsp.dataBackUp" text="DATA BACK UP" /></a>
				</div>
				<div class="item item-sub-child " style="background-color: #FF8576;">
					<a href="javascript:loadCleanLog()"><spring:message
							code="admin.admleftpanel.jsp.cleanLog" text="CLEAN LOG" /></a>
				</div>
                <div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadDepartment()"><spring:message code="admin.admleftpanel.jsp.department" text="DEPARTMENT" /></a>
				</div>
				
				
				<div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadDesignation()"><spring:message code="admin.admleftpanel.jsp.designation" text="DESIGNATION" /></a>
				</div>
				
				<div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadEmployeeType()"><spring:message code="admin.admleftpanel.jsp.employee" text="EMPLOYEE TYPE" /></a>
				</div>
				
				<div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadEmployeeDetails()"><spring:message code="admin.admleftpanel.jsp.employeedetail" text="EMPLOYEE" /></a>
				</div>
				
				<div class="item item-sub-child" style="background-color: #5E7E1D;">
					<a href="javascript:loadDutyShift()"><spring:message code="admin.admleftpanel.jsp.dutyshift" text="DUTY SHIFT" /></a>
				</div>

				<c:if test="${sessionScope.loggedinStore.roomBooking=='Y'}">
					<!-- Room-booking admin menu start -->
					<div class="item item-sub-child" style="background: purple;">
						<a href="javascript:viewHotelTaxSetup()"><spring:message
								code="admin.admleftpanel.jsp.hoteltaxsetup"
								text="HOTEL TAX SETUP" /></a>
					</div>
					<div class="item item-sub-child" style="background: purple;">
						<a href="javascript:viewCountrySetUp()"><spring:message
								code="admin.admleftpanel.jsp.countrysetup" text="COUNTRY SETUP" /></a>
					</div>
					<div class="item item-sub-child" style="background: purple;">
						<a href="javascript:viewHotelandCountryLinkUp()"><spring:message
								code="admin.admleftpanel.jsp.countryhotellinkup"
								text="HOTEL & COUNTRY LINKUP" /></a>
					</div>
					<div class="item item-sub-child" style="background: purple;">
						<a href="javascript:viewRoomsAndAmenitiesSetup()"><spring:message
								code="admin.admleftpanel.jsp.roomtypeamenitieslinkup"
								text="ROOM-TYPE & AMENITIES LINKUP" /></a>
					</div>
					<div class="item item-sub-child "
						style="background-color: #907F09;">
						<a href="javascript:loadAmenities()"><spring:message
								code="admin.admleftpanel.jsp.amenities" text="AMENITIES" /></a>
					</div>
					<div class="item item-sub-child "
						style="background-color: #907F09;">
						<a href="javascript:loadRoomType()"><spring:message
								code="admin.admleftpanel.jsp.roomtype" text="ROOM TYPE" /></a>
					</div>
					<div class="item item-sub-child "
						style="background-color: #907F09;">
						<a href="javascript:loadRoom()"><spring:message
								code="admin.admleftpanel.jsp.room" text="ROOM" /></a>
					</div>
					<div class="item item-sub-child "
						style="background-color: #907F09;">
						<a href="javascript:loadRoomServices()"><spring:message
								code="admin.admleftpanel.jsp.roomservices" text="ROOM SERVICES" /></a>
					</div>
					<div class="item item-sub-child "
						style="background-color: #907F09;">
						<a href="javascript:loadBillRegister()"><spring:message
								code="rb.admin.roombooking.billregister" text="BILL REGISTER" /></a>
					</div>
					<!-- Room-booking admin menu end -->
				</c:if>

					</div>
			</div>
		
		</div>
		
	</div>
	<%-- </c:if> --%>
</div>

<%-- </c:if> --%>
<script
	src="${pageContext.request.contextPath}/assets/js/adminleftpanel.js"></script>
<script type="text/javascript">
	var BASE_URL = "${pageContext.request.contextPath}";
	var PAGE_CONTEXT_LOCAL = "${pageContext.response.locale}";
	var hr="${sessionScope.loggedinStore.isHr}";
	var id="${sessionScope.loggedinStore.id}";
	
	//alert(hr);
	//alert(id);
	$(document).ready(function(){
	/*  $("#i1").hide();
	 $("#i2").hide();
	 $("#i3").hide();  */
	});
</script>
