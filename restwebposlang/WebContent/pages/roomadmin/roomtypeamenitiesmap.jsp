<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<title>:. POS :: Room Type - Amenities Mapping Setup :.</title>
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
<body>

	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>

				<div class="col-md-10 col-sm-10">
					<div class="col-md-10 col-sm-10">
						<div
							style="color: #FFF; font-size: 16px; font-weight: bold; text-align: center; margin-top: 15px;">
							<strong> <spring:message
									code="admin.menumgnt.jsp.roomtypeamenitieslinkup"
									text="ROOM-TYPE & AMENITIES LINKUP" /></strong> <select
								id="roomTypeLinkup" style="color: #000;"
								onchange="javascript:selectRoomType()">
								<c:if test="${! empty roomtypeList}">									
										<option value="0" selected="selected">Select
											Room-Type</option>
									<c:forEach items="${roomtypeList}" var="roomtypeList">									
											<option value="${roomtypeList.id}">${roomtypeList.roomType}</option>
									</c:forEach>
								</c:if>
								<c:if test="${empty roomtypeList}">
									<option value="0" selected="selected">No Room-Type
										Added</option>
									<script>   
                                        	$(function () {
                                        		
                                        		 document.getElementById('roomtypeadddataopmassagecont').innerHTML = "Add Room-Type First in RoomType-Master !!";
                                        		  $('#alertRoomTypeAddDataopModal').modal('show');
                                        	   });
									</script>
								</c:if>
							</select>
						</div>
					</div>

					<div class="col-md-12 col-sm-12">
						<div
							style="max-height: 400px; overflow-y: auto; margin-top: 30px;">
							<div class="panel panel-default">
								<div class="panel-body">
									<div class="table-responsive" style="background: #404040;">
										<table class="table table-striped table-bordered table-hover">
											<thead style="background: #404040; color: #FFF;">

												<th style="text-align: center;"><spring:message
														code="admin.menumgnt.jsp.id" text="ID" /></th>
												<th style="text-align: center;"><spring:message
														code="admin.menumgnt.jsp.amenities" text="AMENITIES" /></th>
												<th style="text-align: center;"><spring:message
														code="admin.menumgnt.jsp.enable" text="ENABLED" /></th>

											</thead>
											<tbody id="amenitiesMapTBody">
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-10 col-sm-10"
						style="font-size: 16px; font-weight: bold; text-align: center; display: none;"
						id="submitAmenitiesMapDiv">
						<a href="javascript:submitAmenitieslink()" class="btn btn-success"
							style="background: #41A1E3; margin-top: 5px; text-align: center;"><spring:message
								code="admin.taxmgnt.jsp.submit" text="SUBMIT" /></a>
					</div>
					<div class="col-md-10 col-sm-10"
						style="font-size: 16px; font-weight: bold; text-align: center; display: none;"
						id="updateAmenitiesMapDiv">
						<a href="javascript:updateAmenitieslink()" class="btn btn-success"
							style="background: #41A1E3; margin-top: 5px; text-align: center;"><spring:message
								code="admin.taxmgnt.jsp.update" text="UPDATE" /></a>
					</div>
				</div>
			</div>
			<!-- modal starts -->

			<div class="modal fade" data-backdrop="static"
				id="alertCountryDataopModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.menumgnt.jsp.alert" text="Alert!" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<div id="catdataopmassagecont"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								onclick="location.href='${pageContext.request.contextPath}/roomtypeamenitiesmgnt/viewroomtypeamenitiesmgnt.htm'"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" data-backdrop="static"
				id="alertRoomTypeAddDataopModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true"
				style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content"
						style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header"
							style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title"
								style="font-size: 18px; font-weight: bold;" id="myModalLabel">
								<spring:message code="admin.menumgnt.jsp.alert" text="Alert!" />
							</h4>
						</div>
						<div class="modal-body"
							style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<div id="roomtypeadddataopmassagecont"></div>
							</div>
						</div>
						<div class="modal-footer"
							style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button"
								style="background: #72BB4F; font-weight: bold; width: 25%"
								onclick="location.href='${pageContext.request.contextPath}/menumgnt/loadroomtype.htm'"
								data-dismiss="modal" class="btn btn-success">
								<spring:message code="admin.menumgnt.jsp.ok" text="OK" />
							</button>
						</div>
					</div>
				</div>
			</div>
			<!-- modal ends -->
		</div>
	</div>
	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/hotelAdminScript.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>

	<script type="text/javascript">
  
   var BASE_URL="${pageContext.request.contextPath}";
   var language = '<%= session.getAttribute("language") %>';
   var storeID="${sessionScope.loggedinStore.id}";

  function showalertcatdataopModal()
	{
		$('#alertCountryDataopModal').modal('show');
	}
  
   </script>

	<c:choose>
		<c:when test="${pageContext.response.locale == 'ar'}">
			<script
				src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script>
		</c:when>

		<c:otherwise>
			<script
				src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script>
		</c:otherwise>
	</c:choose>


</body>
</html>