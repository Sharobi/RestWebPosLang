<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.sharobi.webpos.util.Constants"%>
<%@page import="com.sharobi.webpos.base.model.Store"%>
<%@page import="com.sharobi.webpos.vfd.Display"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>:. POS :: Table :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
<link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/0.2.0/Chart.min.js" type="text/javascript"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<style type="text/css">
#chart_div{
  margin-top: -450px;
  margin-left: 500px;
}

</style>
</head>

<body>
 <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
        
        
        <div class="col-md-2 col-sm-2">
	    <div class="menu-category">
		<div style="padding: 8px;">
		<div style="overflow-y: auto; height: 430px;">
		<div class="list-group panel" style="background: #404040; text-align: center; text-transform: uppercase;">
						
					<div class="item item-sub-child" style="background: #FF8576;">
							<a
								href="javascript:location.href='${pageContext.request.contextPath}/bi/getBidataPage.htm'">
								<spring:message code="bi.biview.jsp.salesBi"
								text="SALES BI" />
							</a>
					</div>
									
									
		</div>
		</div>
		</div>
		</div>
		</div>
           
           <div class="col-md-10 col-sm-10">
           
           <div class="col-md-12 col-sm-12">
				<div class="col-md-3 col-sm-3">
				<span style="color:#FFF; font-size:16px; font-weight:bold;">Business Intelligence</span>
				</div>
				<div class="col-md-9 col-sm-9">
                    
                     <span style="color:#FFF; font-size:16px; font-weight:bold;">Select Month:</span>
                    <select id="monthly">
                    	<option value="1">JAN</option>
                    	<option value="2">Feb</option>
                    	<option value="3">Mar</option>
                    	<option value="4">Apr</option>
                    	<option value="5">May</option>
                    	<option value="6">Jun</option>
                    	<option value="7">Jul</option>
                    	<option value="8">Aug</option>
                    	<option value="9">Sep</option>
                    	<option value="10">Oct</option>
                    	<option value="11">Nov</option>
                    	<option value="12">Dec</option>
                    	
                    </select>
                    
                    <span style="color:#FFF; font-size:16px; font-weight:bold;">Select Year:</span>
                    <select id="yearly">
                    	<option value="2017">2017</option>
                    </select>
                    
                    <span style="color:#FFF; font-size:16px; font-weight:bold;">Select Type:</span>
                    <select id="chart">
                    	<option value="pieChart">Pie Chart</option>
                    	<option value="3dChart">3D Pie Chart</option>
                    	<option value="dountChart">Donut Chart</option>
                    	
                    	
                    </select>
                    
                   <button id="showChart" onclick="drawChart(document.getElementById('monthly').value,document.getElementById('yearly').value,document.getElementById('chart').value)" class="btn btn-success" style="background:#E0B12F;margin-bottom: 3px;">SUBMIT</button> 
                   
                </div> 
                </div>
                
                
				
              
           </div>
          
          
           <div id="chart_div" style="display: none; padding-top: 500px;"></div> 
       </div>
     </div>
     </div>
     
</body>

<script type="text/javascript">
 
  function drawChart (month,year,type) {
	//  alert(month+" <><> "+year+" <><> "+type);
		  
	  google.charts.load('current', {'packages':['corechart']});
	  google.charts.setOnLoadCallback(drawChart);  
	
	 
	$.ajax({
	        url:  "${pageContext.request.contextPath}/bi/getBidata.htm",
	        dataType: "json",
	        success: function (jsonData) {
	        	
	        	var data =new google.visualization.DataTable();
	            data.addColumn('string', 'name');
	            data.addColumn('number', 'price');

	            for (var i = 0; i < jsonData.length; i++) {
	                data.addRow([jsonData[i].itemName, jsonData[i].itemPrice]);
	            }

	            var options =  {'title':'Item Details',
	                     'width':500,
	                     'height':400};
	            
	            var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	            chart.draw(data, options);
	        }
	    });
	 document.getElementById("chart_div").style.display = 'block';
	} 
 </script>

</html>