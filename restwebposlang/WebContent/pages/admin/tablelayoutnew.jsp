<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<title>:. POS :: Table Management :.</title>
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
    <style type="text/css">
    div.postable .table-image{
 	background:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/table_empty.png') no-repeat center; 
	height:65px;
	width:65px;
}
div.postable div.table-index{
	text-align:center;
	color:#242b31;
	margin:20px auto 0;
}
    </style>
</head>
<body>
	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>
				<div class="col-md-10 col-sm-10" style="background-image:url('${pageContext.request.contextPath }/assets/images/admin/tablelayout/wooden_bg.jpg');">
					<div class="col-md-10 col-sm-10">
						<div style="color: #FFF; font-size: 16px; font-weight: bold;"><spring:message code="admin.tablelayoutnew.jsp.tableLayout" text="TABLE LAYOUT" /></div>
						<input type="hidden" id="hidstoreid" value="${sessionScope.loggedinStore.id}">
					</div>
					<div class="col-md-2 col-sm-2" id="layoutsavebutdiv">
						<a href="javascript:savetableposition()" class="btn btn-success" style="width: 80px; background: #41A1E3; margin-bottom: 3px;"><spring:message code="admin.tablelayoutnew.jsp.save" text="Save" /></a>
					</div>
					<div class="col-md-12 col-sm-12" >
						<!--   Kitchen Sink -->
						<div style="height: 100%; width: 100%;" class="drop">
							<div style="height: 463px; overflow-y: auto;" id="draggablearea">
								<c:if test="${empty tableList }">
            			<spring:message code="admin.tablelayout.jsp.noTableFound" text="No Table found!" />
            			</c:if>
								<c:if test="${!empty tableList }">
									<c:set var="tableposx" value="${tableList[0].xPos}"></c:set>
									<c:set var="tableposy" value="${tableList[0].yPos}"></c:set>
									<c:forEach items="${tableList}" var="tables">
										<c:choose>
											<c:when test="${tableposx==0 &&  tableposy==0}">
												<div class="table-holder1">
													<div class="postable enabled">
														<div class="postable table-image">
															<div class="table-id hide">${tables.tableId}</div>
															<div class="table-index"><a href="#" style="color:black;" title="${tables.tableNo}" data-toggle="popover" data-trigger="hover" data-content="${tables.seatingCapacity}-Seats">${tables.tableNo}</a></div>
														</div>
														<div class="table-info">

															<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>
<%-- 															<div class="table-subinfo">${tables.seatingCapacity}SEATERS</div> --%>
															<div class="table-subinfo"></div>
															<div class="table-subinfo"></div>
														</div>
														<br style="clear: both;">
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="table-holder1" style="position: absolute; top:${tables.yPos}px; left:${tables.xPos}px;">
													<div class="postable enabled">
														<div class="postable table-image">
															<div class="table-id hide">${tables.tableId}</div>
															<div class="table-index"><a href="#" style="color:black;" title="${tables.tableNo}" data-toggle="popover" data-trigger="hover" data-content="${tables.seatingCapacity}-<spring:message code="admin.tablelayoutnew.jsp.seats" text="Seats" />">${tables.tableNo}</a></div>
														</div>
														<div class="table-info">
															<%-- <div class="table-descinfo">${tables.tableDescription}</div> --%>
<%-- 															<div class="table-subinfo">${tables.seatingCapacity}SEATERS</div> --%>
															<div class="table-subinfo"></div>
															<div class="table-subinfo"></div>
														</div>
														<br style="clear: both;">
													</div>
												</div>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:if>
							</div>
						</div>
						<!-- End  Kitchen Sink -->
					</div>
				</div>
			</div>
			<!-- modal starts -->

			<div class="modal fade" data-backdrop="static" id="tablePositionUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				<div class="modal-dialog" style="margin: 100px auto;">
					<div class="modal-content" style="border: 3px solid #ffffff; border-radius: 0px;">
						<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">

							<h4 class="modal-title" style="font-size: 18px; font-weight: bold;" id="myModalLabel"><spring:message code="admin.tablelayout.jsp.confirmation" text="Confirmation!" /></h4>
						</div>
						<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
							<div style="text-align: center; font-size: 20px;">
								<div id="positionupdate"></div>

							</div>
						</div>
						<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; padding: 10px;">
							<button type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/tablemgnt/loadtablelayout.htm'" style="background: #72BB4F; font-weight: bold; width: 25%;" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.tablelayoutnew.jsp.ok" text="OK" /></button>
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
	<script src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.min.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>

	<script type="text/javascript">
		var BASE_URL = "${pageContext.request.contextPath}";
		var ismultiOrder = "${sessionScope.loggedinStore.multiOrderTable}";
		/*start table management*/
		var widthleftpanel = parseInt($("#admleftpanid").css('width'));
		var heightsavebut = parseInt($("#layoutsavebutdiv").css('height'));
		// 		alert(heightsavebut);
		/*end table management*/
		$(document).ready(function(){
	    $('[data-toggle="popover"]').popover();
	});
		$('.drop').droppable({
			tolerance : 'fit'
		});

		$('.table-image').draggable({
			containment : '#draggablearea',
			stop : function() {
				$(this).draggable('option', 'revert', 'invalid');
				var that = $(this);
				var offset = $(this).offset();
				var xPos = offset.left;
				var yPos = offset.top;
				// 				console.log('table-id: ' + $(that).find(".table-id").html());
				// 				console.log('x: ' + xPos);
				// 				console.log('y: ' + yPos);
			}
		});
		$('.table-image').droppable({
			greedy : true,
			tolerance : 'touch',
			drop : function(event,
							ui) {
				ui.draggable.draggable('option', 'revert', true);
			}
		});
		function savetableposition() {
			var tablemaster = {};
			var tablelist = [];
			$('.table-image').each(function() {
				var that = $(this);
				var offset = $(this).offset();
				var xpos = offset.left;
				var ypos = offset.top;
				/* console.log('table-index: ' + $(that).find(".table-index").html());
				 console.log('x: ' + xPos);
				 console.log('y: ' + yPos);
				 console.log('y11: ' + yPos-133);*/
				var tabledetails = {};
				tabledetails.id = $(that).find(".table-id").html();
				tabledetails.storeId = $("#hidstoreid").val();
				tabledetails.xPos = parseInt(xpos - (widthleftpanel + 2+6));
				tabledetails.yPos = parseInt(ypos - (133 + heightsavebut + 12+6));
				tablelist.push(tabledetails);
			});
			tablemaster.tableList = tablelist;
			// 		 console.log("table="+JSON.stringify(table));
			$.ajax({
				url : BASE_URL + "/tablemgnt/updatetableposition.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(tablemaster),
				success : function(response) {
					$("#positionupdate").text(response);
					$("#tablePositionUpdateModal").modal("show");
				},
				error : function(e) {
					// console.log(e.message);
				}
			});
		}
	</script>