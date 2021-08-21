<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:if test="${empty menuItems}">
	<spring:message code="menuitem.jsp.noitems" text="no items" />
</c:if>
<c:if test="${!empty menuItems}">
	<c:forEach items="${menuItems}" var="item" varStatus="status">
		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
			<c:set var="discount" scope="page" value="${item.promotionValue}" />
		</c:if>
		<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'N') }">
			<c:set var="discount" scope="page" value="0.0" />
		</c:if>
		<c:if test="${fn:containsIgnoreCase(item.production, 'Y') }">
			<div class="table-holder">
				<div class="postable menucathead${css}" style="height: 84px;"
					onclick="javascript:additemtoOrder(${item.id }, &quot;${item.name }&quot;,${item.price }, ${discount },${item.vat },${item.serviceTax },'${item.promotionFlag}',${item.promotionValue },'${item.isKotPrint}')">
					<div style="height: 70px; padding: 1px;">
						<c:if
							test="${sessionScope.loggedinStore.displayCurrentStockMenu =='N'}">
							<div style="font-size: 13px; font-weight: bold;">${item.name}</div>
						</c:if>
						<c:if
							test="${sessionScope.loggedinStore.displayCurrentStockMenu =='Y'}">
							<div style="font-size: 13px; font-weight: bold;">
								<span style="color: #fff; font-size: 13px;"><%-- (<fmt:formatNumber
										type="number" minFractionDigits="0" maxFractionDigits="0"
										value="${item.currentStock}" />) --%>
								</span>${item.name}</div>
						</c:if>
						<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
							<div style="color: #fff; font-size: 0.5em">${item.promotionValue }%&nbsp;<spring:message
									code="menuitem.jsp.off" text="off" />
							</div>
						</c:if>
					</div>
					<div
						style="color: #fff; float: right; font-size: .6em; margin-right: 5px; margin-top: -5px; position: relative;">
						<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
							<span
								style="font-size: 0.6em; text-decoration: line-through; color: #fff">${item.price }</span>${item.price-(item.price*item.promotionValue)/100 }
                            		</c:if>
						<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'N') }">
							<fmt:formatNumber type="number" minFractionDigits="2"
								maxFractionDigits="2" value="${item.price }" />
						</c:if>

					</div>
					<br style="clear: both;">
				</div>
			</div>
		</c:if>
		<c:if test="${fn:containsIgnoreCase(item.production, 'N') }">
			<div class="table-holder">
				<div class="postable menucathead${css}"
					style="height: 84px; opacity: 0.6; cursor: auto;">
					<div style="height: 70px; padding: 1px;">
						<c:if
							test="${sessionScope.loggedinStore.displayCurrentStockMenu =='N'}">
							<div style="font-size: 13px; font-weight: bold;">${item.name}</div>
						</c:if>
						<c:if
							test="${sessionScope.loggedinStore.displayCurrentStockMenu =='Y'}">
							<div style="font-size: 13px; font-weight: bold;">
								<span style="color: #fff; font-size: 13px;"><%-- (<fmt:formatNumber
										type="number" minFractionDigits="0" maxFractionDigits="0"
										value="${item.currentStock}" />) --%>
								</span>${item.name}</div>
						</c:if>
						<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
							<div style="color: #fff; font-size: 0.5em">${item.promotionValue }%&nbsp;<spring:message
									code="menuitem.jsp.off" text="off" />
							</div>
						</c:if>
					</div>
					<div
						style="color: #fff; float: right; font-size: 1em; margin-right: 5px; margin-top: -5px; position: relative;">
						<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'Y') }">
							<span
								style="font-size: 0.6em; text-decoration: line-through; color: #fff">${item.price }</span>${item.price-(item.price*item.promotionValue)/100 }
                            		</c:if>
						<c:if test="${fn:containsIgnoreCase(item.promotionFlag, 'N') }">
							<fmt:formatNumber type="number" minFractionDigits="2"
								maxFractionDigits="2" value="${item.price }" />
						</c:if>

					</div>
					<br style="clear: both;">
				</div>
			</div>
		</c:if>

	</c:forEach>
</c:if>
