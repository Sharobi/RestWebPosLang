<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <title>:. POS :: Chart of Accounts :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
   <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
   <link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />

     <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style type="text/css">
    .ui-autocomplete {
    overflow-y: scroll; max-height: 250px; width: 300px; word-break: break-all; z-index: 2150000000 !important;
}
.modal:nth-of-type(even) {
    z-index: 1042 !important;
}
.modal-backdrop.in:nth-of-type(even) {
    z-index: 1041 !important;
}
</style>
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <c:set var="today" value="<%=new java.util.Date()%>" />
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
             <jsp:include page="/pages/accounts/accountleftpanel.jsp"></jsp:include>
	        <div class="col-md-10 col-sm-10">

			<%-- 	<div class="row" style="margin-left: 1%; margin-right: 1%;">
					<div class="panel panel-default">
					<div class="panel-body">

						<div class="col-lg-8 col-md-8 col-sm-12">


							<div class="row" style="margin-left: 1%; margin-right: 1%;">

							<div class="col-sm-6"><h3><spring:message code="accgroup.jsp.chartofaccount" text="Chart of Accounts" /></h3> </div>
							<div class="col-sm-3">
							<spring:message code="accgroup.jsp.asondate" text="As on Date" />
						 <form id="chart" action="chartofaccnt.htm" method="post">
								<input type="text" id="entrydate" name="asOnDate" class="form-control">
								</form>

								</div>
									<div class="col-sm-3"></div>


						</div>



							<form modelAttribute="commonResultSetMapper" class="form-inline" role="form" action="${pageContext.request.contextPath }/accntgrp/searchaccntgrp.htm" method="post">
								<div class="form-group">

									<input type="text" class="form-control" placeholder="Group Name" name="groupName" value="${commonResultSetMapper.groupName}">
								</div>
								<div class="form-group">
									<select class="form-control" name="qryCondition" >
										<option value="like">LIKE</option>
										<option value="equals">=</option>
									</select>
								</div>


								<button type="submit" class="btn btn-theme"><spring:message code="cmn.jsp.search" text="Search" /></button>
							</form>
						</div>




						<div class="pull-right">
							<c:if test="${menuByUserDTO.isAll==1}">
								<button class="btn btn-primary" type="button" onclick="javascript:openAddEditModal(0,'','','',0)"><i class="fa fa-plus"></i>&nbsp;<spring:message code="cmn.jsp.btn.add" text="Add" /></button>
							</c:if>
						</div>
					</div>
				</div>

				</div> --%>

				<div class="row" style="margin-left: 1%; margin-right: 1%;">
				<table id="example" class="table table-bordered  table-condensed  " cellspacing="0" width="100%" style="color:white;">
				<thead>


					<tr>
						<th><spring:message code="accgroup.jsp.type" text="Account Type" /></th>
				    	<th><spring:message code="accgroup.jsp.groupname" text="Group Name" /></th>
						<th><spring:message code="accsetup.jsp.partyaccountname" text="Account Name" /></th>

						<th><spring:message code="accgroup.jsp.Currentbalance" text="Current Balance" /></th>
					</tr>
				</thead>

				<tbody>




				<c:if test="${!empty chartofaccounts }">
					<c:forEach items="${chartofaccounts}" var="ca" varStatus="index">
					<tr>
						<td>${ca.type_name}</td>
						<td>${ca.group_name}</td>
						<td>${ca.account_name}</td>

						<td>

						<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${ca.current_balance}" />
						<c:if test="${ca.current_balance>0}">
						 &nbsp;&nbsp;${ca.balance_type}

						</c:if>


						</td>
					</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>

				</div>

	      </div>
      <!--./ end col -10  -->
  </div>
  <!--./ end row of first   -->
<!-- Confirm Message Modal Starts -->


<div class="modal fade" id="confirmMessageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false"  style="    margin-top: 3%;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"  style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
				<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
				<h4 class="modal-title" id="myModalLabel">
					<spring:message code="footer.jsp.alert" text="Alert!" />
				</h4>
			</div>
			<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;" >
				<div id="confirmmessagecont"></div>
				<input type="hidden" id="confirmval" value="">
				<input type="hidden" id="cnfrmCustName" />
			</div>
			<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; color: #fff;" >
				<button type="button" onclick="targetURL()" data-dismiss="modal" class="btn btn-theme">
					<spring:message code="footer.jsp.btn.ok" text="OK" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- Confirm Message Modal ends -->

<!-- Confirm Modal Start -->

<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="    margin-top: 3%;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
				<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
				<h4 class="modal-title" id="myModalLabel">
					<spring:message code="footer.jsp.confrmation" text="Confirmation!"></spring:message>
				</h4>
			</div>
			<div class="modal-body"  style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<spring:message code="footer.jsp.cnfrmquestion" text="Are you sure?" />
				<input type="hidden" id="confirmId" value="">
			</div>
			<div class="modal-footer"  style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<button type="button" class="btn btn-default" data-dismiss="modal" id="cnfrm_cancel_btn">
					<spring:message code="footer.jsp.btn.cancel" text="Cancel" />
				</button>
				<button type="button" onclick="DoConfirm()" data-dismiss="modal" class="btn btn-theme">
					<spring:message code="footer.jsp.btn.ok" text="OK" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- Confirm Modal end -->

  		</div>
  		<!-- ./ container-fluid -->
    </div>
    <!--./ content-wrapper -->
    <!-- CONTENT-WRAPPER SECTION END-->

    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <script src="${pageContext.request.contextPath}/assets/js/advancebookingScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>

 <script src="${pageContext.request.contextPath}/assets/common/common.js"></script>

  <script src="${pageContext.request.contextPath}/assets/common/moment-with-locales.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/accounts/journal/journal.js"></script>
   <script type="text/javascript">

   var BASE_URL="${pageContext.request.contextPath}";

   var currentDate = new Date();
   $('#entrydate').datepicker({
		format : 'yyyy-mm-dd',
		endDate : currentDate,
		autoclose : true,
	});

   var ason_Date="${ason_Date}";

	 if (ason_Date==0) {
		 $('#entrydate').val(moment(new Date()).format("YYYY-MM-DD"));
	}else
		{
		$('#entrydate').val(moment(ason_Date).format("YYYY-MM-DD"));
		}


	 $('#entrydate').on('changeDate', function(ev) {
        var date = $('#entrydate').val();

        $('#chart').submit();
    });

   </script>

   <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
    <%--    <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script> --%>
    </c:when>

    <c:otherwise>
    <%--  <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script> --%>
      <script src="${pageContext.request.contextPath}/assets/js/accounts/journal/journal_en.js"></script>
         <script src="${pageContext.request.contextPath}/assets/common/common_en.js"></script>


    </c:otherwise>
    </c:choose>

</body>
</html>
