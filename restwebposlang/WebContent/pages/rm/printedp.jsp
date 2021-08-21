<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="com.sharobi.webpos.util.CommonResource"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Print EDP</title>
</head>
<body onload="printEDP()">
<div id="edpreportContainerId">
</div>
</body>
<script type="text/javascript">
var pdf_url_of_edp='<%=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_RM_EDP_REPORT)%>';
function printEDP()
{
	var edpid=window.opener.document.getElementById('edpId').value;
	var storeid=window.opener.document.getElementById('hidstoreid').value;
	var url=pdf_url_of_edp+"?edpId="+edpid+"&storeId="+storeid;
	var pdfline="<iframe src='"+url+"' style='width:100%; height:650px;' frameborder='0'></iframe>";
	document.getElementById('edpreportContainerId').innerHTML=pdfline;
}
</script>
</html>