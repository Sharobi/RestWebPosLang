<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.sharobi.webpos.util.CommonResource"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <title>:. POS :: Balance Sheet</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
    <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
    <link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css" rel="stylesheet" />

     <!-- HTML5 shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
     <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<c:set var="today" value="<%=new java.util.Date()%>" />
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
           <jsp:include page="../rptleftpanel.jsp"></jsp:include>

           <div class="col-md-10 col-sm-10">

					<div class="col-sm-12 col-sm-12">
					<input type="hidden" id="compid" value="0">
					<input type="hidden" id="storeid" value="${store.id}">
					<input type="hidden" id="finyrid" value="0">
					<!-- <input type="hidden" id="manufid" value="0">
					<input type="hidden" id="contentid" value="0"> -->
					<center>
						<span id="error_rpt" style="color:red;"></span>
					</center>
					<center>
					<table >
						<tr align="center" style="font-weight: bold;">
					<%-- 	  <td width="10%" ><spring:message code="accgroup.jsp.report_type" text="Report Type" /></td> --%>

								<td align="center" style="color:#FFF; font-size:16px; font-weight:bold;">

								 <spring:message code="accgroup.jsp.asondate" text="As on Date" />

								</td>

							<%-- 	<td width="25%" id="ledger_group"><spring:message code="accsetup.jsp.accountgroupname" text="Account Group Name" /></td>
								<td width="23%"><spring:message code="accsetup.jsp.partyaccountname" text="Account Name " /></td> --%>
								<td style="color:#FFF; font-size:16px; font-weight:bold;"><spring:message code="accgroup.jsp.reportformat" text="Format" /> </td>
							</tr>
						<tr>
						<fmt:parseDate value="${sessionScope.sesloggedinUser.startDate}" var="parsedStrtDate" pattern="yyyy-MM-dd" />
						<fmt:parseDate value="${sessionScope.sesloggedinUser.endDate}" var="parsedEndDate" pattern="yyyy-MM-dd" />

						 	<!-- report  type -->
							<!-- 	<td style="padding: 0 1px;">
									<select class="form-control-trx" name="reprot_type" id="report_type"  onchange="arrange_menu();">

										<option value="0">Select</option>
										<option value="1">Ledger</option>
										<option value="2">Trial Balance</option>
										<option value="3">Balance Sheet</option>
									</select>
								</td>  -->



								<td align="center" style="padding: 0 1px;">
									<!-- <div class="input-group date" data-provide="datepicker"> -->
									<div class="input-group">
										<input type="hidden" id="sessionenddate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${parsedEndDate}" />">
										<input type="text" readonly="readonly" class="form-control-trx" id="enddate" name="endDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${today}" />">

									</div>
								</td>


					<%--
								<td style="padding: 0 1px;">
									<select class="form-control-trx" name="accountgroup_id" id="accountgroup_id">
										<option value="0">All</option>
										<c:if test="${!empty accountgrouplist}">
											<c:forEach items="${accountgrouplist}" var="ag">
												<option value="${ag.id}">${ag.name}</option>
											</c:forEach>
										</c:if>
									</select>
								</td>
								<td>
									<input type="hidden" id="accountid" value="0" />
									<input class="form-control-trx" type="text" id="account_name"  onkeyup="auto_com();" placeholder="Account Name(Please type atleast 2 characters)">

								</td> --%>

								<td>
									<select class="form-control-trx" name="report_format" id="report_format" style="height:26px;">
										<option value="1">Pdf</option>
									 	<option value="2">XLSX</option>
									</select>

								</td>

								<td>
									<div class="col-lg-4 col-md-4 col-sm-12">
										<button style="background: #41A1E3;margin-bottom: 3px;" type="button" class="btn btn-theme" onclick="getCurrPurchaseItems()"><spring:message code="cmn.jsp.btn.submit" text="Submit" /></button>
									</div>
								</td>
								<td><div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="alertMsg"></div></td>
					</table>
					</center>
					</div>


				<div id="rptpossaleregdiv" style="height: 450px;width: 100%;"></div>

           </div>
       </div>


           <!-- modal ends -->
     </div>
     </div>
    <!-- CONTENT-WRAPPER SECTION END-->

    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <script src="${pageContext.request.contextPath}/assets/js/reportScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
   <script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";
   $(document).ready(function() {
		$("#ason_heading").addClass('hide');


	});


// $(document).ready(function() {
var compid=0;//$("#compid").val();
var storeid=$("#storeid").val();
var finyrid=0;//$("#finyrid").val();
var pdf_url_purchase_itemwise='<%=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ACCOUNT_BALANCE_SHEET)%>';



	var currentDate = new Date();
	var sessionstrtdate = $("#sessionstrtdate").val();
	var sessionenddate = $("#sessionenddate").val();
	var endDt = new Date();
	if( (currentDate.getTime() > new Date(sessionenddate).getTime()))
	{
		endDt = sessionenddate;
		$('#enddate').val(sessionenddate);
	}
	else
	{
		endDt = currentDate;
	}

	var startDateFrom = new Date((currentDate.getFullYear() - 1), 3, 1);
	$('#strtdate').datepicker({
		format : 'yyyy-mm-dd',
		startDate : sessionstrtdate,
		autoclose: true,
	});
	$('#enddate').datepicker({
		format : 'yyyy-mm-dd',
		endDate : endDt,
		autoclose: true,
	});
	function getCurrPurchaseItems(){

		var enddate=$("#enddate").val();
		var group_id=$("#accountgroup_id").val();
		var account_id=$("#accountid").val();
		var report_format= $('#report_format').val();



			var  final_url=pdf_url_purchase_itemwise+"?cmpnyId="+compid+"&storeId="+storeid+"&finYrId="+finyrid+"&asOnDate="+enddate+"&report_format="+report_format+"";


			var pdfline="<iframe src='"+final_url+"' style='width:100%; height:450px;' frameborder='0'></iframe>";

			document.getElementById('rptpossaleregdiv').innerHTML=pdfline;



}

   </script>
   </body>
</html>