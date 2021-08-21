<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>:. POS :: Amenities :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
    <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
   
     <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
		<div class="content-wrapper">
		<div class="container-fluid">
		<div class="row">
		 <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>

		
		<div class="col-md-10 col-sm-10">
                <div class="col-md-10 col-sm-10">
                    <div style="color:#FFF; font-size:16px; font-weight:bold;">
                   <strong> <spring:message code="admin.admleftpanel.jsp.roomservices" text="ROOM SERVICES" /></strong>
                    </div> 
                </div>
                <div class="col-md-2 col-sm-2">
                    <a href="javascript:showrmservicesaddModal()" class="btn btn-success" style="width:80px; background:#78B626;margin-bottom: 3px;"><spring:message code="admin.menumgnt.jsp.add" text="ADD" /></a>
                </div>
                <div class="col-md-12 col-sm-12">
                  <!--   Kitchen Sink -->
                  <div style="max-height: 400px;overflow-y:auto; ">
                    <div class="panel panel-default">
                        
                        <div class="panel-body">
                            <div class="table-responsive" style="background:#404040;">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead style="background:#404040; color:#FFF;">
                                        
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.id" text="ID" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.name" text="NAME" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.edit" text="EDIT" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.delete" text="DELETE" /></th>
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.details" text="DETAILS" /></th>
                                           <%--  <c:if test="${sessionScope.loggedinStore.kotPrintType=='category'}">
                                            <th style="text-align:center;"><spring:message code="admin.menumgnt.jsp.kotprinter" text="KOT PRINTER" /></th></th>
                                            </c:if> --%>
                                        
                                    </thead>
                          <%--           <tbody>
                                    	<c:if test="${! empty menucategorylist }">
                                    		<c:forEach items="${menucategorylist}" var="menucategoy">
                                    			<tr style="background:#404040; color:#FFF;">
                                    				<td align="center">${menucategoy.id}</td>
                                    				<td>${menucategoy.menuCategoryName}</td>
                                    				<td align="center"><a href="javascript:shownmenucateditModal(${menucategoy.id},&quot;${menucategoy.menuCategoryName}&quot;,&quot;${menucategoy.bgColor}&quot;)"> <input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png"></a></td>
                                           			<td align="center"><a href="javascript:showConfirmdeleteCatModal(${menucategoy.id},&quot;${menucategoy.menuCategoryName}&quot;,&quot;${menucategoy.bgColor}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png"></a></td>
                                            		<td align="center"><a href="javascript:showDetailCatModal(${menucategoy.id},&quot;${menucategoy.menuCategoryName}&quot;,&quot;${menucategoy.bgColor}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a></td>
                                            		<c:if test="${sessionScope.loggedinStore.kotPrintType=='category'}">
                                            		<td align="center"><a href="javascript:showCatKOTPrinterModal(${menucategoy.id},&quot;${menucategoy.menuCategoryName}&quot;)"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_tprinter.png"></a></td>
                                            		</c:if>
                                    			</tr>
                                    		</c:forEach>
                                    	</c:if>
                                        <c:if test="${empty menucategorylist}">
                                        	<tr style="background:#404040; color:#FFF;">
                                        		<td colspan="5"><spring:message code="admin.menumgnt.jsp.nodatafound" text="No Data found!" /></td>
                                        	</tr>
                                        </c:if>
                                    </tbody> --%>
                                </table>
                            </div>
                        </div>
                    </div>
                    </div>
                     <!-- End  Kitchen Sink -->
                </div>
           </div>
		
	
		
		</div>
</body>
