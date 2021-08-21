<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.sharobi.webpos.util.CommonResource"%>
<div class="col-md-2 col-sm-2">
                <div class="menu-category" style="height:100%;">
                	<div style="overflow-y:auto;height:500px;">
                	<div style="padding:5px;">
                		<div class="item item-sub-child" style="background:#72bb4f;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/recipe/loadrecipeingredient.htm'" ><strong><spring:message code="rmleftpanel.jsp.RecipeIngredients" text="Recipe Ingredients"/></strong></a>
                    	</div>
                    	<div class="item item-sub-child" style="background:#72bb4f;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/edp/loadedp.htm'"><strong><spring:message code="rmleftpanel.jsp.EstimateDailyProd" text="EstimateDailyProd"/>.</strong></a>
                    	</div>
                    	<div class="item item-sub-child" style="background:#72bb4f;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/requisition/loadrequisition.htm'"><strong><spring:message code="rmleftpanel.jsp.Requisition" text="Requisition"/></strong></a>
                    	</div>
                    	<div class="item item-sub-child" style="background:#72bb4f;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/rawstockin/loadrawstockin.htm'"><strong><spring:message code="rmleftpanel.jsp.RawStockIn" text="Raw Stock In"/></strong></a>
                    	</div>
                    	<div class="item item-sub-child" style="background:#72bb4f;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/rawstockout/loadrawstockout.htm'"><strong><spring:message code="rmleftpanel.jsp.RawStockOut" text="Raw Stock Out"/></strong></a>
                    	</div>
                    	
                    	<div class="item item-sub-child" style="background:#72bb4f;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/rawstockreturn/loadrawstockreturn.htm'"><strong><spring:message code="rmleftpanel.jsp.RawStockReturn" text="Raw Stock Return"/></strong></a>
                    	</div>
                    	
                    	<div class="item item-sub-child" style="background:#72bb4f;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/rawclose/loadrawclose.htm'"><strong><spring:message code="rmleftpanel.jsp.RawClose" text="Raw Close"/></strong></a>
                    	</div>
                    	<div class="item item-sub-child" style="background:#72bb4f;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/fgstockin/loadfgstockin.htm'"><strong><spring:message code="rmleftpanel.jsp.FGStockIn" text="FG Stock In"/></strong></a>
                    	</div>
                    	<div class="item item-sub-child" style="background:#72bb4f;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/fgstockout/loadfgstockout.htm'"><strong><spring:message code="rmleftpanel.jsp.FGSaleOut" text="FG Sale Out"/></strong></a>
                    	</div>
                    	<div class="item item-sub-child" style="background:#72bb4f;" >
                    		<a href="javascript:location.href='${pageContext.request.contextPath}/fgclose/loadfgclose.htm'"><strong><spring:message code="rmleftpanel.jsp.FGClose" text="FG Close"/></strong></a>
                    	</div>
                    </div>
                    </div>
                </div>
           </div>  