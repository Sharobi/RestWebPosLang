<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page import="com.sharobi.webpos.util.CommonResource"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Print Stock-in Data</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"	rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"	rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css"	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/datepicker.css"	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/languagebody.css" rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">


 <style>
	    .menu-category {
	    height: 100%;
	    overflow: auto;
	    /*background: #fff;*/
	    font-size: 16px;
	    color: #fff;
	}
    </style>
</head>
<body onload="stockInPrintData()">
<div id="stockineportContainerId">
</div>
</body>
<script type="text/javascript">
var pdf_url_of_stockin='<%=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_STOCKIN_REPORT)%>';
function stockInPrintData()
{
	var stockinid=window.opener.document.getElementById('createdstockinid').value;
	var storeid=window.opener.document.getElementById('hidstoreid').value;
	var url=pdf_url_of_stockin+"?stkId="+stockinid+"&storeId="+storeid;
	var pdfline="<iframe src='"+url+"' style='width:100%; height:650px;' frameborder='0'></iframe>";
	document.getElementById('stockineportContainerId').innerHTML=pdfline;
}
</script>
</html>