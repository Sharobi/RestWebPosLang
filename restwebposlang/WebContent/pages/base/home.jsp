<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.sharobi.webpos.util.Constants"%>
<%@page import="com.sharobi.webpos.base.model.Store"%>
<%@page import="com.sharobi.webpos.vfd.Display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>:. POS :: Home :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"
	rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link
	href="${pageContext.request.contextPath}/assets/css/font-awesome.css"
	rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet" />
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
     
</head>
<body onload="getSelectVal()">
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<input type="hidden" id="expdate" value='${expdate}' />
	<c:set var="homebgImg" value="yewpos-home.jpg"></c:set>
	<c:set var="storebgImg" value="blue-panel-store.png"></c:set>
	<c:if test="${store.id==37 ||store.id==38}">
		<c:set var="homebgImg" value="pos-saravanaa-home.jpg"></c:set>
		<c:set var="storebgImg" value="black-panel-store.png"></c:set>
	</c:if>
	<c:if test="${sessionScope.loggedinStore.dayBookReg=='Y'}">
	<c:if test="${restopendet.id==0}">
	<input type="hidden" id="daybookregid" value="${restopendet.id}">
	<div class="modal fade" data-backdrop="static" id="restOpenModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog" style="margin: 100px auto;">
		<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
			<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
				<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel">
					<spring:message code="inventorynew.jsp.Alert" text="Alert" />
				</h4>
			</div>
			<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<div style="text-align: center; font-size: 20px;">
					Please open the store.
				</div>
			</div>
			<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
				<button type="button" style="font-weight: bold; width: 25%;" class="btn btn-success" data-dismiss="modal" onclick="saveRestOpenTime()">
					<spring:message code="inventorynew.jsp.OK" text="OK" />
				</button>
			</div>
		</div>
	</div>
</div>
	</c:if>
</c:if>

<div class="modal fade" data-backdrop="static"
		id="licenseexpalertmodal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog" style="margin: 100px auto;">
			<div class="modal-content"
				style="border: 3px solid #ffffff; border-radius: 0px;">
				<div class="modal-header"
					style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
					<h4 class="modal-title" style="font-size: 18px; font-weight: bold;"
						id="myModalLabel">
						<spring:message code="header.jsp.LicenceInformation"
							text="Licence Information" />
						:
					</h4>
				</div>
				<div class="modal-body"
					style="background: #404040; border-top: 1px solid #404040; color: #fff;">
					<div align="center" style="font-size: 20px;">
						<table>
							<tr>
								<td>Expiry Date:</td>
								<td>&nbsp;&nbsp;</td>
								<td><span id="licenceexpdate" style="color:white"></span></td>
							</tr>
						</table><br>
						<span>Your license will expire soon.Please contact with
							provider.Thanks.</span>
						
					</div>
				</div>
				<div class="modal-footer"
					style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
					<button type="button" style="font-weight: bold; width: 25%;"
						data-dismiss="modal" class="btn btn-warning">Close</button>

				</div>
			</div>
		</div>
	</div>

	<div class="content-wrapper">
		<!-- <div class="container-fluid"> -->
		<div class="container-fluid" id="containerId"
			style="background-image:url('${pageContext.request.contextPath }/assets/images/base/home/${homebgImg}');margin-top:-12px;background-position:center;background-size:cover; ">
			
			
		<c:if test="${langlist.size() > 1}">
		   
		<div id="select_language" style="float: right;width: 15%;padding-left: 60px;margin-top: 10px;">
			
		        <select id="dropdown_value" style="background-color:#202020; color: #FFF ">
			        <%--  <option selected='selected'>${pageContext.response.locale}</option> --%>
			           <%--  <option value="0">Select Language</option>
			         <c:forEach items="${langlist}" var="langList">
			             <option value="${langList.codeWeb}">${langList.language}</option>
			         </c:forEach> --%>
			         
			         <c:choose>
					   <c:when test="${not empty sessionScope.selectedLang}">
					       <option id ="selct_VAL" disabled="disabled" selected='selected'>${sessionScope.selectedLang} </option>
					     
					       <c:forEach items="${langlist}" var="langList">
					             <option value="${langList.codeWeb}">${langList.language}</option>
					       </c:forEach>
					         
					  </c:when>
 
					</c:choose>


			    </select>
		
		</div> 
		
		</c:if>	
		
			
			
			
			<div class="col-md-4 col-sm-4"></div>
			<div class="col-md-4 col-sm-4">
				<!-- <div class="container-store-details"> -->
				<div class="container-store-details">
					<div class="header">${store.storeName}</div>
					<!-- div class="content"> -->
					<div class="content"
						style="background-image: url('${pageContext.request.contextPath }/assets/images/base/home/${storebgImg}');color:#fff;">
						<c:if test="${store.id==35 || store.id==80}">
							<span style="font-weight: bold;"><spring:message
									code="home.jsp.anUnitofShahTradingCorporation" text="LANGUAGE" /></span>
							<br>
						</c:if>
						${store.address}<br>
						<spring:message code="home.jsp.tel" text="TEL" />
						: ${store.phoneNo}<br>
						<%-- Home Phone: ${store.mobileNo} --%>
					</div>
				</div>
			</div>
			<div class="col-md-4 col-sm-4"></div>
		</div>
	</div>
	
		<!-- CURRENT USER'S LANGUAGE -->
	
	<%-- Current Locale : ${pageContext.response.locale} --%>
	<!-- CONTENT-WRAPPER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->

	<!-- CORE JQUERY SCRIPTS -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script type="text/javascript">
	var getSelectedLanguage;
	window.onload = function() {
			setScreenHeight();
		};
		
  var BASE_URL="${pageContext.request.contextPath}";
  var storeId='${sessionScope.loggedinStore.id}';	
  		  
		function setScreenHeight() {
			var screenHeight = window.innerHeight || document.body.clientHeight;
			// 		alert(screenHeight);
			var newheight = screenHeight - 133;
			// 		alert(newheight);
			document.getElementById('containerId').style.height = newheight
					+ 'px';
		}
	<%Store store = (Store) session
					.getAttribute(Constants.LOGGED_IN_STORE);
			if (store != null) {
				if (store.getCustomerDisplay().startsWith("COM")) {%>
		
	<%Display display = new Display(store.getCustomerDisplay());
					display.vfdWelcome(store.getCustomerDisplay());
				}
			}%>
			
			 var optionText;
			
			$('select').on('change', function() {
			
			 getSelectedLanguage = this.value;
			 
			// optionText = $("#dropdown_value option[value= '"+getSelectedLanguage+"']").text();
			 
			 
			 location.href = BASE_URL + "/home/welcome.htm?lang="+getSelectedLanguage; 
			
			 });
			
		
			$( document ).ready(function() {
			    var daybookregid=$("#daybookregid").val();
			    if(daybookregid==0){
			    	$("#restOpenModal").modal("show");
			    }
			});	
			
			
	</script>
	<script type="text/javascript">
     var count = "<%=session.getAttribute("count")%>" ;
     var expdate=$('#expdate').val();
       if(count == 0 && expdate != "null"){
    	   $('#licenceexpdate').html(expdate)
    	   $('#licenseexpalertmodal').modal('show');
       }
       <%session.setAttribute("count", 1);%>
     
     </script>
</body>
</html>