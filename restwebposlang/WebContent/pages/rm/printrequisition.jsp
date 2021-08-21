<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="com.sharobi.webpos.util.CommonResource"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Print Requisition</title>
</head>
<body onload="printRequisition()">
<div id="requisitionreportContainerId">
</div>
</body>
<script type ="text/javascript">
var pdf_url_of_requisition='<%=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_REPORT_REQUISITION_GETREQUISITIONREPORTBYIDS)%>';
function printRequisition()
{
	var poid=window.opener.document.getElementById('selectedpoid').value;
	var storeid=window.opener.document.getElementById('hidstoreid').value;
	var url=pdf_url_of_requisition+"?poId="+poid+"&storeId="+storeid;
	var pdfline="<iframe src='"+url+"' style='width:100%; height:650px;' frameborder='0'></iframe>";
	document.getElementById('requisitionreportContainerId').innerHTML=pdfline;
}
</script>
</html>