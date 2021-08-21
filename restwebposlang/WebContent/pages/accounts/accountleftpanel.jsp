<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

		<div class="col-md-2 col-sm-2" id="admleftpanid">
                <div class="menu-category" style="height:100%;">
                	<div style="overflow-y:auto;height:500px;">

			<!--./ end of admin menu -->
				<!--  START ACCOUNTS -->
				<!--  for group -->
	<div class="list-group panel"style="background: #404040; text-align: center; text-transform: uppercase;">
		<a href="javascript:location.href='${pageContext.request.contextPath}/accntgrp/loadaccntgrp.htm'"

		 class="list-group-item" style="background: #1abb9c;"   >
							<spring:message code="acc.memu.group" text="Account Group" />

							</a>
<%-- <a href="javascript:location.href='${pageContext.request.contextPath}/edp/loadedp.htm'"><strong><spring:message code="rmleftpanel.jsp.EstimateDailyProd" text="EstimateDailyProd"/>.</strong></a> --%>
			<!-- for account creation  -->

		<a href="${pageContext.request.contextPath}/accntsetup/loadaccntsetup.htm" class="list-group-item" style="background: #E0B12F;" >
							<spring:message code="acc.memu.accoutsetup" text="Account(Ledger)" />
							</a>
			<!-- voucher entry  -->



		<a href="${pageContext.request.contextPath}/accntenty/loadaccntjrl.htm" class="list-group-item" style="background: #0CF;" >
							<spring:message code="acc.memu.voucherentry" text="Voucher Entry" />
							</a>

					<!--  href="${pageContext.request.contextPath}/chatacc/chartofaccnt.htm -->
		<a   href="${pageContext.request.contextPath}/chatacc/chartofaccnt.htm" class="list-group-item" style="background: #C60;" >
							<spring:message code="acc.memu.chartofaccount" text="Chart of Account" />
							 </a>

					<%-- 	<div class="collapse" id="4">
						<div class="item item-sub-child"
										style="background-color: #FE2E64;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisecancelorder.htm'"><spring:message
												code="admin.rptleftpanel.jsp.cencelOrder"
												text="CANCEL ORDER" /></a>
									</div>
							<c:forEach items="${posModuleObj}" var="posModuleObjList">
								<c:if test="${posModuleObjList.moduleName=='DayWise_Sale'}">
									<div class="item item-sub-child" style="background: #FF8576;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewdaywisesales.htm'">
											<spring:message code="admin.rptleftpanel.jsp.dayWiseSales"
												text="DAY WISE SALES" />
										</a>
									</div>
								</c:if>



								<c:if test="${posModuleObjList.moduleName=='Cancel_Order_Report'}">
									<div class="item item-sub-child"
										style="background-color: #FE2E64;">
										<a
											href="javascript:location.href='${pageContext.request.contextPath}/report/viewperiodwisecancelorder.htm'"><spring:message
												code="admin.rptleftpanel.jsp.cencelOrder"
												text="CANCEL ORDER" /></a>
									</div>
								</c:if>

							</c:forEach>
						</div> --%>
					</div>
				<!--./  END ACCOUNTS -->

		</div>
	</div>
</div>
