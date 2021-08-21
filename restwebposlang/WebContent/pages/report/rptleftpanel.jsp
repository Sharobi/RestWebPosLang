<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="col-md-2 col-sm-2">
	<div class="menu-category">
		<div style="padding: 8px;">
			<c:if test="${! empty sessionScope.posModuleObj }">
				<c:choose>
					<c:when
						test="${sessionScope.loggedinStore.id==37 || sessionScope.loggedinStore.id==38}">
						<div style="overflow-y: auto; height: 430px;">
							<!----------------------- Start Sales Menu ------------------------->

							<div class="list-group panel"
								style="background: #404040; text-align: center; text-transform: uppercase;">
								<a href="#4" class="list-group-item"
									style="background: #1abb9c;" data-toggle="collapse"
									data-parent="#accord"><spring:message
										code="admin.rptleftpanel.jsp.sales" text="Sales" /></a>
								<div class="collapse" id="4">
									<div class="item item-sub-child" style="background: #FF8576;">
										<a href="javascript:viewDayWiseSales()"><spring:message
												code="admin.rptleftpanel.jsp.dayWiseSales"
												text="DAY WISE SALES" /> </a>
									</div>

									<div class="item item-sub-child" style="background: #073D91;">
										<a href="javascript:viewDayWiseHourlySales()"> <spring:message
												code="admin.rptleftpanel.jsp.hourlyWiseSales"
												text="HOURLY SALES" />
										</a>
									</div>
									<div class="item item-sub-child"
										style="background-color: #E0B12F;">
										<a href="javascript:viewPeriodWiseSales()"><spring:message
												code="admin.rptleftpanel.jsp.periodWiseSale"
												text="PERIOD WISE SALES" /></a>
									</div>

								</div>
							</div>

							<!----------------------- End Sales Menu ------------------------->


							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a href="javascript:viewDailySalesSummary()">Daily Sales
									Summary</a>
							</div>
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a href="javascript:viewMonthlySalesSummary()">Monthly Sales
									Summary</a>
							</div>
						</div>



					</c:when>
					<c:otherwise>
						<div style="overflow-y: auto; height: 430px;">
							<div class="list-group panel"
								style="background: #404040; text-align: center; text-transform: uppercase;">
								<a href="#4" class="list-group-item"
									style="background: #1abb9c;" data-toggle="collapse"
									data-parent="#accord"><spring:message
										code="admin.rptleftpanel.jsp.sales" text="Sales" /></a>
								<div class="collapse" id="4">
									<c:forEach items="${posModuleObj}" var="posModuleObjList">
										<c:if test="${posModuleObjList.moduleName=='DayWise_Sale'}">
											<div class="item item-sub-child" style="background: #FF8576;">
												<a href="javascript:viewDayWiseSales()"> <spring:message
														code="admin.rptleftpanel.jsp.dayWiseSales"
														text="DAY WISE SALES" />
												</a>
											</div>
										</c:if>


										<c:if
											test="${posModuleObjList.moduleName=='DayTimeWise_Sale'}">
											<div class="item item-sub-child" style="background: #FE2E64;">
												<a href="javascript:viewDayTimeWiseSales()"> <spring:message
														code="admin.rptleftpanel.jsp.dayTimeWiseSales"
														text="DAY TIME WISE SALES" />
												</a>
											</div>
										</c:if>

										<c:if test="${posModuleObjList.moduleName=='hourly_sales'}">
											<div class="item item-sub-child" style="background: #073D91;">
												<a href="javascript:viewDayWiseHourlySales()"> <spring:message
														code="admin.rptleftpanel.jsp.hourlyWiseSales"
														text="HOURLY SALES" />
												</a>
											</div>
										</c:if>




										<c:if
											test="${posModuleObjList.moduleName=='Period_Wise_Sale'}">
											<div class="item item-sub-child"
												style="background-color: #E0B12F;">
												<a href="javascript:viewPeriodWiseSales()"><spring:message
														code="admin.rptleftpanel.jsp.periodWiseSale"
														text="PERIOD WISE SALES" /></a>
											</div>
										</c:if>

										<c:if
											test="${posModuleObjList.moduleName=='Cancel_Order_Report'}">
											<div class="item item-sub-child"
												style="background-color: #E0B12F;">
												<a href="javascript:viewPeriodWiseCancelOrder()"> <spring:message
														code="admin.rptleftpanel.jsp.cancleWiseSales"
														text="PERIOD WISE CANCEL ORDER" />
												</a>
											</div>
										</c:if>


										<c:if
											test="${posModuleObjList.moduleName=='DayWiseUser_Sale'}">
											<div class="item item-sub-child"
												style="background-color: #073D91;">
												<a href="javascript:viewUserWiseDailySales()"> <spring:message
														code="admin.rptleftpanel.jsp.userWiseDailySales"
														text="USER WISE DAILY SALES" />
												</a>
											</div>
										</c:if>

										<c:if
											test="${posModuleObjList.moduleName=='item_wise_order_day'}">
											<div class="item item-sub-child"
												style="background-color: #41A1E3;">
												<a href="javascript:viewItemWiseDailyOrders()"><spring:message
														code="admin.rptleftpanel.jsp.itemWiseDailyOrder"
														text="ITEM WISE DAILY ORDER" /></a>
											</div>
										</c:if>

										<c:if
											test="${posModuleObjList.moduleName=='item_wise_order_period'}">
											<div class="item item-sub-child"
												style="background-color: #41A1E3;">
												<a href="javascript:viewItemWisePeriodicOrders()"><spring:message
														code="admin.rptleftpanel.jsp.itemWisePeriodicOrder"
														text="ITEM WISE PERIODIC ORDER" /></a>
											</div>
										</c:if>

										<c:if
											test="${posModuleObjList.moduleName=='day_wise_settlement'}">
											<div class="item item-sub-child" style="background: #FE2E64;">
												<a href="javascript:viewDayWiseSettlement()"><spring:message
														code="admin.rptleftpanel.jsp.dayWiseSetelment"
														text="DAY WISE SETTLEMENT" /></a>
											</div>
										</c:if>

										<c:if
											test="${posModuleObjList.moduleName=='category_wise_sales'}">
											<div class="item item-sub-child"
												style="background-color: #da84cb;">
												<a href="javascript:viewCategoryWiseSales()"><spring:message
														code="admin.rptleftpanel.jsp.catWiseSale"
														text="CATEGORY WISE SALES" /></a>
											</div>
										</c:if>

										<c:if
											test="${posModuleObjList.moduleName=='category_wise_periodic_sales'}">
											<div class="item item-sub-child"
												style="background-color: #da84cb;">
												<a href="javascript:viewCategoryWisePeriodicSales()"><spring:message
														code="admin.rptleftpanel.jsp.catWisePerodSales"
														text="CATEGORY WISE PERIODIC SALES" /></a>
											</div>
										</c:if>

										<c:if
											test="${posModuleObjList.moduleName=='nonchargeable_kot'}">
											<div class="item item-sub-child"
												style="background-color: #FE2E64;">
												<a href="javascript:viewNonChargableKot()"><spring:message
														code="admin.rptleftpanel.jsp.nonchargablekot"
														text="NON-CHARGABLE KOT" /></a>
											</div>
										</c:if>

									</c:forEach>
								</div>
							</div>

							<!----------------------- End Sales Menu ------------------------->
							<%--  <c:if test="${sessionScope.loggedinStore.creditSale=='Y'}">
                    			<div class="item item-sub-child" style="background-color:#7ca82f;">
                    				<a href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisecreditsales.htm'">CREDIT SALES</a>
                    			</div>
                    		</c:if> --%>

							<c:if
								test="${sessionScope.loggedinStore.simpleIm=='Y' || sessionScope.loggedinStore.smartIm=='Y'}">
								<c:forEach items="${posModuleObj}" var="posModuleObjList">
									<c:if test="${posModuleObjList.moduleName=='current_stock'}">
										<div class="item item-sub-child"
											style="background-color: #E0B12F; margin: 5px 0;">
											<a href="javascript:viewCurrentStock()"><spring:message
													code="admin.rptleftpanel.jsp.curStock" text="CURRENT STOCK" /></a>
										</div>
									</c:if>
								</c:forEach>
							</c:if>


							<div class="list-group panel"
								style="background: #404040; text-align: center; text-transform: uppercase;">


								<c:if
									test="${sessionScope.loggedinStore.simpleIm=='Y' || sessionScope.loggedinStore.smartIm=='Y'}">
									<c:set var="po" value="0"></c:set>
									<c:forEach items="${posModuleObj}" var="posModuleObjList"
										begin="0" end="40" step="1" varStatus="loop">
										<!-- begin="0" end="20" step="1" -->
										<c:if
											test="${posModuleObjList.moduleName=='DayWise_PO' || posModuleObjList.moduleName=='PeriodWise_PO'}">
											<c:if test="${po == 0}">

												<a href="#1" class="list-group-item"
													style="background: #0CF;" data-toggle="collapse"
													data-parent="#accord"> <spring:message
														code="admin.rptleftpanel.jsp.purchaseOrder"
														text="Purchase Order" />
												</a>

											</c:if>
											<c:set var="po" value="${loop.count}"></c:set>
										</c:if>
									</c:forEach>

									<div class="collapse" id="1">
										<c:forEach items="${posModuleObj}" var="posModuleObjList">
											<c:if test="${posModuleObjList.moduleName=='DayWise_PO'}">
												<a href="javascript:viewDayWisePO()" class="list-group-item"
													style="background: #999;"><spring:message
														code="admin.rptleftpanel.jsp.dayWise" text="Daywise" /></a>
											</c:if>
											<c:if test="${posModuleObjList.moduleName=='PeriodWise_PO'}">
												<a href="javascript:viewPeriodWisePO()"
													class="list-group-item" style="background: #999;"><spring:message
														code="admin.rptleftpanel.jsp.periodWise" text="Periodwise" /></a>

											</c:if>

										</c:forEach>
									</div>

								</c:if>

								<%--  <!--start accounts report -->

			    <c:set var="accounts" value="0"></c:set>
				<c:forEach items="${posModuleObj}" var="posModuleObjList" begin="0" end="40" step="1" varStatus="loop" >
				<c:if test="${posModuleObjList.moduleName=='pl_statement' || posModuleObjList.moduleName=='tax_inout'}">
				<c:if test="${accounts == 0}">
				<a href="#accrpt" class="list-group-item " style="background: #0C3;"
				data-toggle="collapse" data-parent="#accord"><spring:message
				code="admin.rptleftpanel.jsp.account" text="ACCOUNT" /></a>
				</c:if>
				<c:set var="accounts" value="${loop.count}"></c:set>
				</c:if>
				</c:forEach>
				<div class="collapse" id="accrpt">
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if test="${posModuleObjList.moduleName=='pl_statement'}">
									<a href="${pageContext.request.contextPath}/report/viewplstatement.htm"
										class="list-group-item" style="background: #999;"><spring:message
											code="admin.rptleftpanel.jsp.plstatement" text="P&L Statement" /></a>
								</c:if>
								<c:if
									test="${posModuleObjList.moduleName=='tax_inout'}">
									 <a href="${pageContext.request.contextPath}/report/viewtaxstatement.htm"
										class="list-group-item" style="background: #999;"><spring:message
											code="admin.rptleftpanel.jsp.taxstatement" text="Tax Statement" /></a>
								</c:if>
							</c:forEach>
						</div>

        <!-- end accounts report --> --%>
								<c:if
									test="${sessionScope.loggedinStore.simpleIm=='Y' || sessionScope.loggedinStore.smartIm=='Y'}">
									<c:set var="stIn" value="0"></c:set>
									<c:forEach items="${posModuleObj}" var="posModuleObjList"
										begin="0" end="40" step="1" varStatus="loop">
										<c:if
											test="${posModuleObjList.moduleName=='DayWise_StockIn' || posModuleObjList.moduleName=='PeriodWise_StockIn'}">
											<c:if test="${stIn == 0}">

												<a href="#2" class="list-group-item "
													style="background: #0C3;" data-toggle="collapse"
													data-parent="#accord"><spring:message
														code="admin.rptleftpanel.jsp.stockIn" text="Stock In" /></a>

											</c:if>
											<c:set var="stIn" value="${loop.count}"></c:set>
										</c:if>
									</c:forEach>


									<div class="collapse" id="2">

										<c:forEach items="${posModuleObj}" var="posModuleObjList">
											<c:if
												test="${posModuleObjList.moduleName=='DayWise_StockIn'}">
												<a href="javascript:viewDayWiseStockIn()"
													class="list-group-item" style="background: #999;"><spring:message
														code="admin.rptleftpanel.jsp.dayWise" text="Daywise" /></a>
											</c:if>
											<c:if
												test="${posModuleObjList.moduleName=='PeriodWise_StockIn'}">
												<a href="javascript:viewPeriodWiseStockIn()"
													class="list-group-item" style="background: #999;"><spring:message
														code="admin.rptleftpanel.jsp.periodWise" text="Periodwise" /></a>
											</c:if>
										</c:forEach>
									</div>
								</c:if>
								
								
								<!-- Raw Stock In --!>
								 <!-- ************** For RAW STOCK IN  *************** -->
								<c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
									<c:set var="rawStIn" value="0"></c:set>
									<c:forEach items="${posModuleObj}" var="posModuleObjList"
										begin="0" end="40" step="1" varStatus="loop">
										<c:if
											test="${posModuleObjList.moduleName=='raw_stockin_register' || posModuleObjList.moduleName=='raw_stockin_summary' ||  posModuleObjList.moduleName=='raw_stockin_itemwise'}">
											<c:if test="${rawStIn == 0}">
												<a href="#R2" class="list-group-item "
													style="background: #0C3;" data-toggle="collapse"
													data-parent="#accord"> <spring:message
														code="admin.rptleftpanel.jsp.rawstockIn"
														text="RAW STOCK IN" /></a>
											</c:if>
											<c:set var="rawStIn" value="${loop.count}"></c:set>
										</c:if>
									</c:forEach>
									<!--code to be checked-->
									<div class="collapse" id="R2">
										<c:forEach items="${posModuleObj}" var="posModuleObjList">
											<c:if
												test="${posModuleObjList.moduleName=='raw_stockin_summary'}">
												<a href="javascript:viewRawStockInSummary()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.summary" text="SUMMARY" /></a>
											</c:if>
											<c:if
												test="${posModuleObjList.moduleName=='raw_stockin_register'}">
												<a href="javascript:viewRawStockInRegister()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.register" text="REGISTER" /></a>
											</c:if>
											<c:if
												test="${posModuleObjList.moduleName=='raw_stockin_itemwise'}">
												<a href="javascript:viewRawStockInItemWise()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.itemwise" text="ITEM WISE" /></a>
											</c:if>
										</c:forEach>
									</div>
								</c:if>
								<!-- End of RawStock In report -->
								<!-- ************** For StockOut  *************** -->
								<%-- <c:if
									test="${sessionScope.loggedinStore.simpleIm=='Y' || sessionScope.loggedinStore.smartIm=='Y'}">
									<c:set var="so" value="0"></c:set>
									<c:forEach items="${posModuleObj}" var="posModuleObjList"
										begin="0" end="40" step="1" varStatus="loop">
										<c:if
											test="${posModuleObjList.moduleName=='StockOut_KitchenWise_DayWise' || posModuleObjList.moduleName=='StockOut_KitchenWise_PeriodWise' || posModuleObjList.moduleName=='StockOut_All_DayWise' || posModuleObjList.moduleName=='StockOut_All_PeriodWise'}">
											<c:if test="${so == 0}">

												<a href="#3" class="list-group-item "
													style="background: #C60;" data-toggle="collapse"
													data-parent="#accord"><spring:message
														code="admin.rptleftpanel.jsp.stockOut" text="Stock Out" /></a>
											</c:if>
											<c:set var="so" value="${loop.count}"></c:set>
										</c:if>
									</c:forEach>

									<div class="collapse" id="3">
										<!-- ************** For StockOut All  *************** -->
										<c:set var="kt" value="0"></c:set>
										<c:forEach items="${posModuleObj}" var="posModuleObjList"
											begin="0" end="40" step="1" varStatus="loop">
											<c:if
												test="${posModuleObjList.moduleName=='StockOut_KitchenWise_DayWise' || posModuleObjList.moduleName=='StockOut_KitchenWise_PeriodWise'}">
												<c:if test="${kt == 0}">

													<a href="#3_1" class="list-group-item"
														style="background: #0C9;" data-toggle="collapse"><spring:message
															code="admin.rptleftpanel.jsp.kitchenWise"
															text="Kitchenwise" /></a>

												</c:if>
												<c:set var="kt" value="${loop.count}"></c:set>
											</c:if>
										</c:forEach>

										<div class="collapse" id="3_1">
											<c:forEach items="${posModuleObj}" var="posModuleObjList">
												<c:if
													test="${posModuleObjList.moduleName=='StockOut_KitchenWise_DayWise'}">
													<a href="javascript:viewDayWiseStockOutKitchen()"
														class="list-group-item" style="background: #999;"><spring:message
															code="admin.rptleftpanel.jsp.dayWise" text="Daywise" /></a>
												</c:if>
												<c:if
													test="${posModuleObjList.moduleName=='StockOut_KitchenWise_PeriodWise'}">
													<a href="javascript:viewPeriodWiseStockOutKitchen()"
														class="list-group-item" style="background: #999;"><spring:message
															code="admin.rptleftpanel.jsp.periodWise"
															text="Periodwise" /></a>

												</c:if>
											</c:forEach>
										</div>

										<!--  ************** For StockOut All  *************** -->
										<c:set var="all" value="0"></c:set>
										<c:forEach items="${posModuleObj}" var="posModuleObjList"
											begin="0" end="40" step="1" varStatus="loop">
											<c:if
												test="${posModuleObjList.moduleName=='StockOut_All_DayWise' || posModuleObjList.moduleName=='StockOut_All_PeriodWise'}">
												<c:if test="${all == 0}">

													<a href="#3_2" class="list-group-item"
														style="background: #0C9;" data-toggle="collapse"><spring:message
															code="admin.rptleftpanel.jsp.all" text="All" /></a>

												</c:if>
												<c:set var="all" value="${loop.count}"></c:set>
											</c:if>
										</c:forEach>
										<div class="collapse" id="3_2">
											<c:forEach items="${posModuleObj}" var="posModuleObjList">
												<c:if
													test="${posModuleObjList.moduleName=='StockOut_All_DayWise'}">
													<a href="javascript:viewDayWiseStockOutAllCat()"
														class="list-group-item" style="background: #999;"><spring:message
															code="admin.rptleftpanel.jsp.dayWise" text="Daywise" /></a>
												</c:if>
												<c:if
													test="${posModuleObjList.moduleName=='StockOut_All_PeriodWise'}">
													<a href="javascript:viewPeriodWiseStockOutAllCat()"
														class="list-group-item" style="background: #999;"><spring:message
															code="admin.rptleftpanel.jsp.periodWise"
															text="Periodwise" /></a>
												</c:if>
											</c:forEach>

										</div>
									</div>
								</c:if> --%>
								
								<c:if test="${sessionScope.loggedinStore.simpleIm=='Y' || sessionScope.loggedinStore.smartIm=='Y'}">
									<c:set var="rawStOut" value="0"></c:set>
									<c:forEach items="${posModuleObj}" var="posModuleObjList"
											   begin="0" end="55" step="1" varStatus="loop">
										<c:if
											test="${posModuleObjList.moduleName=='raw_stockout_register' || posModuleObjList.moduleName=='raw_stockout_summary' ||  posModuleObjList.moduleName=='raw_stockout_itemwise'}">
											<c:if test="${rawStOut == 0}">
												<a href="#RAWOUT" class="list-group-item "
													style="background: #0C3;" data-toggle="collapse"
													data-parent="#accord"> RAW STOCK OUT</a>
											</c:if>
											<c:set var="rawStOut" value="${loop.count}"></c:set>
										</c:if>
									</c:forEach>
									<!--code to be checked-->
									<div class="collapse" id="RAWOUT">
										<c:forEach items="${posModuleObj}" var="posModuleObjList">
											<c:if
												test="${posModuleObjList.moduleName=='raw_stockout_summary'}">
												<a href="javascript:viewRawStockOutSummary()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.summary" text="SUMMARY" /></a>
											</c:if>
											<c:if
												test="${posModuleObjList.moduleName=='raw_stockout_register'}">
												<a href="javascript:viewRawStockOutRegister()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.register" text="REGISTER" /></a>
											</c:if>
											<c:if
												test="${posModuleObjList.moduleName=='raw_stockout_itemwise'}">
												<a href="javascript:viewRawStockOutItemWise()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.itemwise" text="ITEM WISE" /></a>
											</c:if>
										</c:forEach>
									</div>
								</c:if>
								
								
								<!-- ************** For FG STOCK IN  *************** -->
								<c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
									<c:set var="fgStIn" value="0"></c:set>
									<c:forEach items="${posModuleObj}" var="posModuleObjList"
										begin="0" end="49" step="1" varStatus="loop">
										<c:if
											test="${posModuleObjList.moduleName == 'fg_stockin_summary' || posModuleObjList.moduleName == 'fg_stockin_register' ||  posModuleObjList.moduleName == 'fg_stockin_itemwise'}">
											<c:if test="${fgStIn == 0}">
												<a href="#22" class="list-group-item "
													style="background: #0C3;" data-toggle="collapse"
													data-parent="#accord"> <spring:message
														code="base.rptleftpanel.jsp.fgstockIn" text="FG STOCK IN" /></a>
											</c:if>
											<c:set var="fgStIn" value="${loop.count}"></c:set>
										</c:if>
									</c:forEach>
									<div class="collapse" id="22">
										<c:forEach items="${posModuleObj}" var="posModuleObjList">
											<c:if
												test="${posModuleObjList.moduleName=='fg_stockin_summary'}">
												<a href="javascript:viewFGStockInSummary()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.summary" text="SUMMARY" /></a>
											</c:if>
											<c:if
												test="${posModuleObjList.moduleName=='fg_stockin_register'}">
												<a href="javascript:viewFGStockInRegister()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.register" text="REGISTER" /></a>
											</c:if>
											<c:if
												test="${posModuleObjList.moduleName=='fg_stockin_itemwise'}">
												<a href="javascript:viewFGStockInItemWise()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.itemwise" text="ITEM WISE" /></a>
											</c:if>
										</c:forEach>
									</div>
								</c:if>
								<!-- ************** END of FG STOCK IN  *************** -->
								<!-- ************** For RAW STOCK RETURN  *************** -->
								<c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
									<c:set var="stIn3" value="0"></c:set>
									<c:forEach items="${posModuleObj}" var="posModuleObjList"
										begin="0" end="49" step="1" varStatus="loop">
										<c:if
											test="${posModuleObjList.moduleName=='raw_stockin_return_register' || posModuleObjList.moduleName=='raw_stockin_return_summary' ||  posModuleObjList.moduleName=='raw_stockin_return_itemwise'}">
											<c:if test="${stIn3 == 0}">
												<a href="#21" class="list-group-item "
													style="background: #0C3;" data-toggle="collapse"
													data-parent="#accord"> <spring:message
														code="base.rptleftpanel.jsp.rawstockReturn"
														text="RAW STOCK RETURN" /></a>
											</c:if>
											<c:set var="stIn3" value="${loop.count}"></c:set>
										</c:if>
									</c:forEach>
									<div class="collapse" id="21">
										<c:forEach items="${posModuleObj}" var="posModuleObjList">
											<c:if
												test="${posModuleObjList.moduleName=='raw_stockin_return_summary'}">
												<a href="javascript:viewRawStockReturnSummary()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.summary" text="SUMMARY" /></a>
											</c:if>
											<c:if
												test="${posModuleObjList.moduleName=='raw_stockin_return_register'}">
												<a href="javascript:viewRawStockReturnRegister()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.register" text="REGISTER" /></a>
											</c:if>
											<c:if
												test="${posModuleObjList.moduleName=='raw_stockin_return_itemwise'}">
												<a href="javascript:viewRawStockReturnItemWise()"
													class="list-group-item" style="background: #999;"><spring:message
														code="base.rptleftpanel.jsp.rpt.itemwise" text="ITEM WISE" /></a>
											</c:if>
										</c:forEach>
									</div>
								</c:if>
								<!-- ************** End of RAW STOCK RETURN  *************** -->
								 <!-- ************** For FG STOCK RETURN  *************** -->          
           <c:if test="${sessionScope.loggedinStore.simpleIm=='Y'}">
                 <c:set var="stIn" value="0"></c:set>
						 <c:forEach items="${posModuleObj}" var="posModuleObjList"
							begin="0" end="49" step="1" varStatus="loop">
							<c:if test="${posModuleObjList.moduleName=='fg_stockin_return_register' || posModuleObjList.moduleName=='fg_stockin_return_summary' || posModuleObjList.moduleName=='fg_stockin_return_itemwise'}">
							 	<c:if test="${stIn == 0}">
									<a  href="#23" class="list-group-item " style="background: #0C3;"
									    data-toggle="collapse" data-parent="#accord">
										 <spring:message code="base.rptleftpanel.jsp.fgtockReturn" text="FG STOCK RETURN" /></a>
								</c:if>
								 <c:set var="stIn" value="${loop.count}"></c:set>
							</c:if>
						</c:forEach> 
						<div class="collapse" id="23">
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if test="${posModuleObjList.moduleName=='fg_stockin_return_summary'}">
									<a href="javascript:viewFGStockReturnSummary()"
										class="list-group-item" style="background: #999;"><spring:message
									    code="base.rptleftpanel.jsp.rpt.summary" text="SUMMARY" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='fg_stockin_return_register'}">
									<a href="javascript:viewFGStockReturnRegister()"
									   class="list-group-item" style="background: #999;"><spring:message
									   code="base.rptleftpanel.jsp.rpt.register" text="REGISTER" /></a>
								</c:if>
								<c:if test="${posModuleObjList.moduleName=='fg_stockin_return_itemwise'}">
									<a  href="javascript:viewFGStockReturnItemWise()"
										class="list-group-item" style="background: #999;"><spring:message
										code="base.rptleftpanel.jsp.rpt.itemwise" text="ITEM WISE" /></a>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
					<!-- End of FG Stock Return -->				
								<!-- Vendor payment report start -->
								<c:if
									test="${sessionScope.loggedinStore.simpleIm=='Y' || sessionScope.loggedinStore.smartIm=='Y'}">
									<c:forEach items="${posModuleObj}" var="posModuleObjList">
										<c:if
											test="${posModuleObjList.moduleName=='vendor_payment_report'}">
											<div class="item item-sub-child"
												style="background-color: #E0B12F; margin: 5px 0;">
												<a href="javascript:viewVendorPaymentReport()"><spring:message
														code="admin.admleftpanel.jsp.invItem.vendorpayment"
														text="VENDOR PAYMENT" /> </a>
											</div>
										</c:if>
									</c:forEach>
								</c:if>
								<!-- Vendor payment report end -->




								<a href="#5" class="list-group-item" style="background: #C60;"
									data-toggle="collapse" data-parent="#accord"><spring:message
										code="admin.rptleftpanel.jsp.customer" text="CUSTOMER" /></a>

								<div class="collapse" id="5">

									<a href="javascript:getCustomerList()" class="list-group-item"
										style="background: #999;">CUSTOMER DETAILS<%-- <spring:message
												code="admin.rptleftpanel.jsp.dayWise" text="CUSTOMER DETAILS" /> --%>
									</a> <a href="javascript:viewTop5Customer()"
										class="list-group-item" style="background: #999;">TOP 5
										CUSTOMERS<%-- <spring:message
												code="admin.rptleftpanel.jsp.topCust" text="TOP 5 CUSTOMERS" /> --%>
									</a> <a href="javascript:viewOutstandingCustomer()"
										class="list-group-item" style="background: #999;">OUTSTANDING
										CUSTOMERS<%-- <spring:message
												code="admin.rptleftpanel.jsp.outstandingCust" text="OUTSTANDING CUSTOMER" /> --%>
									</a> <a href="javascript:viewNewAndRepeatCustomer()"
										class="list-group-item" style="background: #999;">NEW V/S
										REPEAT CUSTOMERS (AMT. & COUNT)<%-- <spring:message
												code="admin.rptleftpanel.jsp.newvsrepeatCust" text="NEW V/S REPEAT CUSTOMER(AMT. & COUNT)" /> --%>
									</a>

								</div>

							</div>


							<%-- <c:forEach items="${posModuleObj}" var="posModuleObjList">
						<c:if test="${posModuleObjList.moduleName=='current_stock'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/getcustomerlist.htm'"><spring:message
										code="admin.rptleftpanel.jsp.custDetails" text="CUSTOMER DETAILS" /></a>
							</div>
						</c:if>
					</c:forEach> --%>




							<c:if test="${sessionScope.loggedinStore.deliveryBoyFlag=='Y'}">
								<div class="item item-sub-child"
									style="background-color: #E0B12F; margin: 5px 0;">
									<a href="javascript:viewOrderWiseDeliveryBoy()"> ORDERS &
										DELIVERY BOYS</a>
								</div>
							</c:if>

							<c:if test="${sessionScope.loggedinStore.waiterNameFlag=='Y'}">
								<div class="item item-sub-child"
									style="background-color: #E0B12F; margin: 5px 0;">
									<a href="javascript:viewTableWiseWaitors()">TABLE ORDERS &
										WAITERS</a>
								</div>
							</c:if>


							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<%-- <c:if test="${posModuleObjList.moduleName=='Cancel_Order_Report_Celavi'}">
							<div class="item item-sub-child"
								style="background-color: #E0B12F; margin: 5px 0;">
								<a
									href="javascript:location.href='${pageContext.request.contextPath}/report/viewcancelorderreasonrpt.htm'">Cancel Order 12</a>
							</div>
						</c:if> --%>
								<c:if
									test="${posModuleObjList.moduleName=='Expenditure_Details_Report'}">
									<div class="item item-sub-child"
										style="background-color: #E0B12F; margin: 5px 0;">
										<a href="javascript:viewExpenditureDetails()">Expenditure
											Details</a>
									</div>
								</c:if>

							</c:forEach>

							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if
									test="${posModuleObjList.moduleName=='daily_sales_report_celavi'}">
									<div class="item item-sub-child"
										style="background-color: #E0B12F; margin: 5px 0;">
										<a href="javascript:viewDailySalesReport()">Daily Sales</a>
									</div>
								</c:if>
							</c:forEach>
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if
									test="${posModuleObjList.moduleName=='discount_report_celavi'}">
									<div class="item item-sub-child"
										style="background-color: #E0B12F; margin: 5px 0;">
										<a href="javascript:viewDiscountedOrder()">Discounted
											Order</a>
									</div>
								</c:if>
							</c:forEach>
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if
									test="${posModuleObjList.moduleName=='nonchargeable_report_celavi'}">
									<div class="item item-sub-child"
										style="background-color: #E0B12F; margin: 5px 0;">
										<a href="javascript:viewNonChargableOrder()">Non-Chargeable</a>
									</div>
								</c:if>
							</c:forEach>
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if
									test="${posModuleObjList.moduleName=='payment_report_celavi'}">
									<div class="item item-sub-child"
										style="background-color: #E0B12F; margin: 5px 0;">
										<a href="javascript:viewPaymentWiseReport()">Payment Wise</a>
									</div>
								</c:if>
							</c:forEach>
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if
									test="${posModuleObjList.moduleName=='daily_sales_inclusive_taxes_report_celavi'}">
									<div class="item item-sub-child"
										style="background-color: #E0B12F; margin: 5px 0;">
										<a href="javascript:viewDailySalesInclusiveTax()">Sales
											Inclusive Tax</a>
									</div>
								</c:if>
							</c:forEach>
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if
									test="${posModuleObjList.moduleName=='monthly_summary_report_celavi'}">
									<div class="item item-sub-child"
										style="background-color: #E0B12F; margin: 5px 0;">
										<a href="javascript:viewDailySalesSummaryReport()">Sales
											Summary</a>
									</div>
								</c:if>
							</c:forEach>

							<!--start refund report -->
							<c:if test="${sessionScope.loggedinStore.isRefund=='Y'}">
								<c:set var="redunds" value="0"></c:set>
								<c:forEach items="${posModuleObj}" var="posModuleObjList"
									begin="0" end="40" step="1" varStatus="loop">
									<c:if
										test="${posModuleObjList.moduleName=='refund_summary' || posModuleObjList.moduleName=='refund_details'}">
										<c:if test="${redunds == 0}">
											<a href="#refundrpt" class="list-group-item "
												style="background: #0CF; text-align: center;"
												data-toggle="collapse" data-parent="#accord"><spring:message
													code="paidorder.jsp.REFUND" text="REFUND" /></a>
										</c:if>
										<c:set var="redunds" value="${loop.count}"></c:set>
									</c:if>
								</c:forEach>
								<div class="collapse" id="refundrpt">
									<c:forEach items="${posModuleObj}" var="posModuleObjList">
										<c:if test="${posModuleObjList.moduleName=='refund_summary'}">
											<a href="javascript:viewRefundSummary()"
												class="list-group-item"
												style="background: #999; text-align: center;"><spring:message
													code="admin.rptleftpanel.jsp.refundsummary"
													text="Refund Summary" /></a>
										</c:if>
										<c:if test="${posModuleObjList.moduleName=='refund_details'}">
											<a href="javascript:viewRefundDetails()"
												class="list-group-item"
												style="background: #999; text-align: center;"><spring:message
													code="admin.rptleftpanel.jsp.refunddetails"
													text="Refund Details" /></a>
										</c:if>
									</c:forEach>
								</div>
							</c:if>
							<!-- end refund report -->

							<!--start accounts report -->
							<c:if test="${sessionScope.loggedinStore.is_account=='Y'}">
								<c:set var="accounts" value="0"></c:set>
								<c:forEach items="${posModuleObj}" var="posModuleObjList"
									begin="0" end="40" step="1" varStatus="loop">
									<c:if
										test="${posModuleObjList.moduleName=='daily_collection' || posModuleObjList.moduleName=='daily_payment' || posModuleObjList.moduleName=='ledger' || posModuleObjList.moduleName=='trial_balance' || posModuleObjList.moduleName=='balance_sheet' || posModuleObjList.moduleName=='account_balance' || posModuleObjList.moduleName=='profit_and_loss'}">
										<c:if test="${accounts == 0}">
											<a href="#accrpt" class="list-group-item "
												style="background: #0C3; text-align: center;"
												data-toggle="collapse" data-parent="#accord"><spring:message
													code="admin.rptleftpanel.jsp.account" text="ACCOUNT" /></a>
										</c:if>
										<c:set var="accounts" value="${loop.count}"></c:set>
									</c:if>
								</c:forEach>
								<div class="collapse" id="accrpt">
									<c:forEach items="${posModuleObj}" var="posModuleObjList">
										<%-- <c:if test="${posModuleObjList.moduleName=='pl_statement'}">
									<a href="${pageContext.request.contextPath}/report/viewplstatement.htm"
										class="list-group-item" style="background: #999;text-align: center;"><spring:message
											code="admin.rptleftpanel.jsp.plstatement" text="P&L Statement" /></a>
								</c:if> --%>
										<%--  <c:if test="${posModuleObjList.moduleName=='tax_inout'}">
									 <a href="${pageContext.request.contextPath}/report/viewtaxstatement.htm"
										class="list-group-item" style="background: #999;text-align: center;">
										<spring:message
											code="admin.rptleftpanel.jsp.taxstatement" text="Tax Statement" /></a>
								</c:if> --%>
										<%-- ${posModuleObjList.moduleName} --%>

										<c:if
											test="${posModuleObjList.moduleName=='dlaily_collection'}">
											<a href="javascript:viewDailyCollection()"
												class="list-group-item"
												style="background: #E0B12F; text-align: center;"><spring:message
													code="accgroup.jsp.dailycollection" text="Daily Collection" /></a>
										</c:if>

										<c:if test="${posModuleObjList.moduleName=='daily_payment'}">
											<a href="javascript:viewDailyPayment()"
												class="list-group-item"
												style="background: #E0B12F; text-align: center;"><spring:message
													code="accgroup.jsp.dailypayment" text="Daily Payment" /></a>
										</c:if>

										<c:if test="${posModuleObjList.moduleName=='ledger'}">
											<a href="javascript:viewLedgerReport()"
												class="list-group-item"
												style="background: #E0B12F; text-align: center;"><spring:message
													code="accgroup.jsp.ledgerview" text="Ledger  Report" /></a>
										</c:if>
										<c:if test="${posModuleObjList.moduleName=='trial_balance'}">
											<a href="javascript:viewTrialBalance()"
												class="list-group-item"
												style="background: #E0B12F; text-align: center;"><spring:message
													code="accgroup.jsp.trialbalanceview" text="Trial Balance" /></a>
										</c:if>
										<c:if test="${posModuleObjList.moduleName=='balance_sheet'}">
											<a href="javascript:viewBalanceSheet()"
												class="list-group-item"
												style="background: #E0B12F; text-align: center;"><spring:message
													code="accgroup.jsp.balancesheetview" text="Balance Sheet" /></a>
										</c:if>
										<c:if test="${posModuleObjList.moduleName=='account_balance'}">
											<a href="javascript:viewAccountBalance()"
												class="list-group-item"
												style="background: #E0B12F; text-align: center;"><spring:message
													code="accgroup.jsp.accout_balance" text="Account Balance" /></a>
										</c:if>
										<c:if test="${posModuleObjList.moduleName=='profit_and_loss'}">
											<a href="javascript:viewProfitAndLoss()"
												class="list-group-item"
												style="background: #E0B12F; text-align: center;"><spring:message
													code="accgroup.jsp.profit_and_loss" text="Profit And Loss" /></a>
										</c:if>
									</c:forEach>
								</div>
							</c:if>
							<!-- end accounts report -->
							<!-- start room booking report  -->
							<c:if test="${sessionScope.loggedinStore.roomBooking=='Y'}">
								<c:set var="roombooking" value="0"></c:set>
								<c:forEach items="${posModuleObj}" var="posModuleObjList"
									begin="0" end="40" step="1" varStatus="loop">
									<c:if
										test="${posModuleObjList.moduleName=='roomreserve_details' || posModuleObjList.moduleName=='roombooking_details'}">
										<c:if test="${roombooking == 0}">
											<a href="#rmbookingrpt" class="list-group-item "
												style="background: #0CF; text-align: center;"
												data-toggle="collapse" data-parent="#accord"><spring:message
													code="rb.rpt.roombooking" text="ROOM BOOKING" /></a>
										</c:if>
										<c:set var="roombooking" value="${loop.count}"></c:set>
									</c:if>
								</c:forEach>
								<div class="collapse" id="rmbookingrpt">
									<c:forEach items="${posModuleObj}" var="posModuleObjList">
										<c:if
											test="${posModuleObjList.moduleName=='roombooking_details'}">
											<a href="javascript:viewRoomBookingDetails()"
												class="list-group-item"
												style="background: #999; text-align: center;"><spring:message
													code="rb.rpt.room.booking" text="Booking Details" /></a>
										</c:if>
										<c:if
											test="${posModuleObjList.moduleName=='roomreserve_details'}">
											<a href="javascript:viewRoomServiceReport()"
												class="list-group-item"
												style="background: #999; text-align: center;">
												<spring:message code="rb.rpt.room.booking.summary" text="Booking Summary" /></a>

										</c:if>
										<c:if
											test="${posModuleObjList.moduleName=='room_payment_wise_sales'}">
											<a href="javascript:viewRoomPaymentWiseSalesReport()"
												class="list-group-item"
												style="background: #999; text-align: center;"><spring:message
													code="rb.rpt.room.paymentwisesale" text="Payment Wise Sale" /></a>
										</c:if>
										<c:if
											test="${posModuleObjList.moduleName=='guest_list'}">
											<a href="javascript:viewRoomGuestListReport()"
												class="list-group-item"
												style="background: #999; text-align: center;"><spring:message
													code="rb.rpt.room.booking.guest_list" text="Guest List" /></a>
										</c:if>
										<c:if
											test="${posModuleObjList.moduleName=='flash_report'}">
											<a href="javascript:viewFlashReport()"
												class="list-group-item"
												style="background: #999; text-align: center;"><spring:message
													code="rb.rpt.room.booking.flashreport" text="Flash Report" /></a>
										</c:if>
									</c:forEach>
								</div>
							</c:if>
							<!-- end room booking report  -->
						</div>
					</c:otherwise>
				</c:choose>
			</c:if>
		</div>
	</div>
</div>
<script
	src="${pageContext.request.contextPath}/assets/js/reportleftpanel.js"></script>
<script type="text/javascript">
	var BASE_URL = "${pageContext.request.contextPath}";
</script>
