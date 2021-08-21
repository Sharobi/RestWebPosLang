<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.sharobi.webpos.base.model.Customer"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>:. POS :: Shift Schedule :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/assets/css/customstyle.css" rel="stylesheet" />
    <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
    
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"	rel="stylesheet" />
    
  
    

    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    
    
    <!-- Core files For Using Jalert -->
	<script src="${pageContext.request.contextPath}/assets/js/jquery.alerts.js"></script>
	<link href="${pageContext.request.contextPath}/assets/css/jquery.alerts.css"	rel="stylesheet" />
    
    
    
   <%--  <script src="${pageContext.request.contextPath}/assets/js/jAlert-functions.js"></script> --%>
    <script src="${pageContext.request.contextPath}/assets/js/moment.js"></script>
    <%-- <script src="${pageContext.request.contextPath}/assets/js/bootstrap-datepicker.min.js"></script> --%>
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap-datetimepicker.min.js"></script>
    
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
    
    
    
   
<!-- <style>
.ui-timepicker-standard{
z-index:9999!important
}
</style> -->
 
        
</head>
<body>
  
    <%-- <jsp:include page="/pages/common/header.jsp"></jsp:include> --%>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
           <%-- <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>   --%>
           <jsp:include page="/pages/hr/hrmodules.jsp"></jsp:include>  
           <%-- <input type="text" value="${loggedinUser.id}"/> --%>
         <div class="col-md-10 col-sm-10">
					<div class="col-md-12 col-sm-12" align="center">
						<span class="spanclass">Select Date For Employee Shift</span>&nbsp;&nbsp;

						
								
								<span class="spanclass">From Date:</span>
								<input type="text" id="fromdate" size="7" value="">
								
								<span class="spanclass">To Date:</span>
								<input type="text" id="todate" size="7" value="">
								 <c:if test="${! empty dutyShiftList }">
								     
						             <select id="selectdutyshiftlist" style="text-align:center; width:10%; color: #222222;margin-bottom: 5px;" class="hide">
                                 	 <option value=0> Please Select Shift</option>
                                 	<c:forEach items="${dutyShiftList}" var="dutyshift">
                                 	 <option value=${dutyshift.shiftingNo}> ${dutyshift.shiftName}</option>
                                 	</c:forEach>
                                    </select>   
                                    	
                                </c:if>
                                
							    
                               <span class="spanclass">Select Slot Interval:</span>
                                <select id="slotinputselect" class=" customslotinputselect" >
                                <option selected="selected" >7</option>
                                <option>14</option>
                               <!--  <option>21</option>
                                <option>28</option> -->
                                </select>
								
							
							<button id="getallemployeeshiftinfo" class="btn btn-success"
							style="background: #FF8576; margin-bottom: 3px;"><spring:message
								code="admin.rpt_sales_day.jsp.submit" text="SUBMIT" /></button>

							<div id="content" align="center" style="margin-top:20px;">
							
							 <table class="table table-striped table-bordered table-hover hide" id="employeeshifttable">
                                    <thead style="background:#404040; color:#FFF;" id="employeeshifttablethead">
                                            <tr id="theadrow" class="text-nowrap">
                                            <!-- <th id="theadname"> 
                                               NAME
                                            </th> -->
                                           </tr>
                                                                                  
                                   
                                    </thead>
                                    <tbody id="employeeshifttabletbody">
                                    	
                                    </tbody>
                                </table>
                                <div id="exportbuttondiv" class="hide">
                                <a  id="shiftscheduleexcelexport" class="btn btn-success customexportbutton"><spring:message code="invitemstock.jsp.export" text="EXPORT" /></a>
                                </div>
							
							</div>
							<!-- EMPLOYEE SHIFT MODAL STARTS FROM LINE NUMBER 117 AND ENDS AT 178 -->
						   <div class="modal fade" data-backdrop="static" id="employeeshiftmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog" style="margin: 100px auto;width:95%;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <%-- <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.addDutyshift" text="Add Employee Shift Schedule" /></h4> --%>
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;"  id="myModalHeading"> Add  Attendance </h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table>
                                            
                                            		<tr>
                                            		<td><span class="text-nowrap"><spring:message  text="FROM DATE" /></span></td>
                                            		<td id="fromdatetdtag"><input type="text" placeholder="FromDate" id="fromdateinmodal" style="text-align:center; width:70%; color: #222222;margin-bottom: 5px;" /></td>
                                            		<td><span class="text-nowrap"><spring:message  text="TO DATE" /></span></td>
                                            		<td id="todatetdtag"><input type="text" placeholder="ToDate" id="todateinmodal" style="text-align:center; width:70%; color: #222222;margin-bottom: 5px;" /></td>
                                            		<td id="shiftscheduletdtag" class="hide" ><input type="text" placeholder="ShiftScheduleId" id="shiftscheduleidinmodal" style="text-align:center; width:20%; color: #222222;margin-bottom: 5px;" /></td>
                                            		
                                            		<td id="empidtdtag"  class="hide"><input type="text" placeholder="EmployeeId" id="empid" style="text-align:center; width:20%; color: #222222;margin-bottom: 5px;" /></td>
                                             
                                            		<td class="text-nowrap"><spring:message  text="SHIFT NAME" /></td>
                                            		
                                            			
                                            			<td style="margin-bottom: 3px;">
                                            			<c:if test="${! empty dutyShiftList }">
								     
						             <select id="selectdutyshiftlistinmodal" style="text-align:center; color: #222222;margin-right: 10px;">
                                 	 <option value=0>Select Shift</option>
                                 	<c:forEach items="${dutyShiftList}" var="dutyshift">
                                 	 <option value=${dutyshift.shiftingNo}> ${dutyshift.shiftName}</option>
                                 	</c:forEach>
                                    </select>   
                                    	
                                </c:if>
                                            			
                                            			</td>
                                            			<td id="errorshiftno" style="color:red;font-size:14px">  </td>
                                            			
                                            			
                                            			
                                            			
                                            			<td class="text-nowrap"><spring:message text="FROM TIME" /></td>
                                            			
                                            			<td style="margin-bottom: 3px;"><input type="text" placeholder="HH:MM" id="empshiftfromtime" style="text-align:center; width:70%; color: #222222;margin-bottom: 5px;" />
                                            			     </td>
                                            			<!-- <td id="errorstarttime" style="color:red;font-size:14px">  </td>    -->
                                            			<td class="text-nowrap"><spring:message  text="TO TIME" /></td>
                                            			
                                            			<td style="margin-bottom: 3px;"><input type="text" placeholder="HH:MM" id="empshifttotime" style="text-align:center; width:80%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<!-- <td id="errorendtime" style="color:red;font-size:14px">  </td>  --> 
                                            		</tr>
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div id="employeeshiftmodalfooter" class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" id="cancelshiftshedule"  class="btn btn-warning"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button>
                                            <button type="button"  id="addshiftshedule"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="SAVE" /></button>
                                            <button type="button"  id="closeshiftshedule"   class="btn btn-primary"><spring:message code="admin.menumgnt.jsp.close" text="CLOSE" /></button>
                                            
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>

						  <div class="modal fade" data-backdrop="static" id="alertmessagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel2"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="alertmodalbody"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/hrmgmt/loadshiftschedule.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
				</div>
                	
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
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/table2excel.js"></script>
  
  
  
    
   <script>
   
   
   var dutyShiftList='<%=session.getAttribute("dutyShiftList")%>'
	   $("#employeeshifttabletbody").find("td:eq(1)").prop("disabled",true);
      
   //var dutyShiftList2='${sessionScope.dutyShiftList}';
   $("#getallemployeeshiftinfo").click(function(){
	   gettablebodyandheaddesign();
	   showallemployeesshiftschedulesintable();
   });
   $(document).on("click","#employeeshifttabletbody>tr>td.cursorpointer",function(){
	   var elem=this;
	   var empname=$(this).parent().find("td:eq(0)").html();
	   var index=$(this).index();
	   var chosenfromdate=$("#theadrow").find("th:eq("+index+")").html().split(" ")[0];
	   var headertextforaddempshiftschedule="Add "+empname+"'s"+" Shift Schedule On "+chosenfromdate;
	   var headertextforupdateempshiftschedule="Update "+empname+"'s"+" Shift Schedule On "+chosenfromdate;
	   $("#employeeshiftmodalfooter").find("span").remove();
	   $("#empshiftfromtime").removeClass("customdanger");
	   $("#empshifttotime").removeClass("customdanger");
	   $("#fromdateinmodal").removeClass("customdanger");
	   $("#todateinmodal").removeClass("customdanger");
	   $("#selectdutyshiftlistinmodal").removeClass("customdanger");
	   $("#fromdateinmodal").val(chosenfromdate);
	   $("#todateinmodal").val(chosenfromdate);
	   
	   var dutyshift_id=$(this).attr("id");
	   var shiftscheduleid=$(elem).find("a").attr("id");
	    console.log("SHIFT SCHEDULE ID FROM DATABASE IS:"+shiftscheduleid);
	    $("#shiftscheduleidinmodal").val(shiftscheduleid);
	   $("#empshiftfromtime").val("");
	   $("#empshifttotime").val("");
	   var emp_id=$(this).parent().attr("id");
	   $("#empid").val(emp_id);
	  
	   if(shiftscheduleid>0){
		   $("#addshiftshedule").html("UPDATE");
		   $("#cancelshiftshedule").removeClass("hide");
		   $("#myModalHeading").html(headertextforupdateempshiftschedule);
		   $("#fromdateinmodal").prop("disabled",true);
		   $("#todateinmodal").prop("disabled",true);
	   }else{
		   $("#addshiftshedule").html("SAVE");
		   $("#cancelshiftshedule").addClass("hide");
		   $("#myModalHeading").html(headertextforaddempshiftschedule);
		   $("#fromdateinmodal").prop("disabled",true);
		   $("#todateinmodal").prop("disabled",false);
	   }
	  
	   var timerange=$(elem).find("a").html();
	   if(timerange!="" && timerange!=null && timerange!="-"){
		   var fromtime=timerange.split("-")[0];
		   var totime=timerange.split("-")[1];
		   
		   $("#empshiftfromtime").val(fromtime);
		   $("#empshifttotime").val(totime);
		   $("#selectdutyshiftlistinmodal").val(dutyshift_id);
		   
	   }else{
		   $("#selectdutyshiftlistinmodal").val(0);
	   }
	   $("#employeeshiftmodal").modal("show");
	  
	   
   });
	   
	   
  
 
   
   function showallemployeesshiftschedulesintable(){
	   var tdindexes=[];
	   var tdindex=0;
	   var allempshiftslist=getAllEmployeeShiftSchedule();
	   var ths=$("#theadrow").find("th");
	  // console.log("ALL EMPLOYEE SHIFT SCHEDULE IS:");
	  //console.log(allempshiftslist);
	  
	  if(allempshiftslist!=null && allempshiftslist!="" && allempshiftslist.length>0){
		  for(var i=0;i<allempshiftslist.length;i++){
			  var empshiftobj=allempshiftslist[i];
			  var empshiftname=null;
			  var empid=empshiftobj.employee.id;
			  var empshiftscheduleid=empshiftobj.id;
			  var start= empshiftobj.fromDate;
			  var end= empshiftobj.toDate;
			  start = new Date(start);
			  end = new Date(end);
			  var daysarr=generatedaterange(start,end);
			
			  var empshiftnumber=empshiftobj.shiftingNo;
			  var dutyshiftoptions=$("#selectdutyshiftlist>option");
			
			  var row="tr#"+empid;
			  var sel="#employeeshifttabletbody>tr#"+empid;
			  var selectedemp=$(sel).html();
			 
			  
			  var startdate=$("#fromdate").val();
			  var todate=$("#todate").val();
			   console.log("DAYS ARRAY2 FOR GETTING ASSIGNED SHIFT VALUES OF EMPLOYEE IS:");
			   console.log(daysarr);
			   
			   var fromtime=empshiftobj.fromTime;
			   var totime=empshiftobj.toTime;
			 
			   for(var j=0;j<ths.length;j++){
				   
				   var o=$(ths[j]).html().split(" ")[0];
				   for(var k=0;k<daysarr.length;k++){
					   var day=daysarr[k];
					   if(o==day){
						   var td=$(sel).find("td:eq("+j+")");
				    		$(td).find("a").remove();
				    		$(td).attr("id",empshiftnumber);
				    		var anchor="<a class='text-nowrap customanchor' id='"+empshiftscheduleid+"'"+">"+fromtime+"-"+totime+"</a>";
							td.append(anchor);
					   }
					   
					   
				   }
				   
				   
			   }  
			 
		  }
		 
		  $("#exportbuttondiv").removeClass("hide");
	  }
	 
	 
	   
   }
   
   function getCalendarDays(weekday){
	   var day=null;
	    if(weekday==0){
		   day="Sunday"
	   }else if(weekday==1){
		   day="Monday"
	   }else if(weekday==2){
		   day="Tuesday"
	   }else if(weekday==3){
		   day="Wednesday"
	   }else if(weekday==4){
		   day="Thursday"
	   }else if(weekday==5){
		   day="Friday"
	   }else if(weekday==6){
		   day="Saturday"
	   } 
	   return day;
   }
   
   function gettablebodyandheaddesign(){
	   $("#employeeshifttabletbody").empty();
	   $("#theadrow").empty();
	  var start=$("#fromdate").val();
	  var end=$("#todate").val();
	   
	   var daysarr=generatedaterange(start,end);
	   var emplistresponse=getAllEmployees();
	   var head="";
	   head=head+'<th>NAME</th>'; 
	   var body='';
	   for(var i=0;i<daysarr.length;i++){
		   var obj=daysarr[i];
		   var t= new Date(obj);
		   var x=moment(t).format("YYYY-MM-DD");
		   var weekday=moment(x).weekday();
		   
		   //console.log("WEEKDAY=="+weekday);
		   
		   var day=getCalendarDays(weekday);
		   
		   if(day!=null){
			   head=head+'<th>'
			   head=head+obj+" "+"<br>"+day+'</th>'
		   }else{
			   head=head+'<th>'
			   head=head+obj+'</th>'
		   } 
	   }
	   $("#theadrow").append(head);
	   if(emplistresponse!=null && emplistresponse!=""){
		   $("#employeeshifttable").removeClass("hide");
		  
		
		   for(var i=0;i<emplistresponse.length;i++){
			  
			   var empobj=emplistresponse[i];
			   
			   var empid=empobj.id;
			   var empname=empobj.name;
			   var st_id=empobj.storeId;
			   body=body+"<tr class='customtablerow' id="+empid+">"
			   body=body+"<td class='default'>"
			   body=body+empname
			   body=body+"</td>"
			   
			   
			   for(var k=0;k<daysarr.length;k++){
					  body=body+"<td class='cursorpointer'><a class='text-nowrap customanchor'>-</a></td>"
				}
			   
			 
			   
			   body=body+"</tr>" 
			   
			   
		   }
		
		    
		   $("#employeeshifttabletbody").append(body);
		   
	   }
   }
   
   
  
  function generatedaterange(start,end){
	  var arr=[];
	  var start =  moment(start,"YYYY-MM-DD").format("YYYY-MM-DD");
	  var end =  moment(end,"YYYY-MM-DD").format("YYYY-MM-DD");
	  for(var i=start;i<=end;){
		  var t=i;
		  arr.push(i);
		  i=moment(t, "YYYY-MM-DD").add('days',1).format("YYYY-MM-DD");
	  }
	  return arr;
	  
  } 
   
   
   function validate(){
	   var is_valid=true;
	   var start=$("#fromdate").val();
	   var end=$("#todate").val();
	   
	   if(start==null || start==""){
		   $("#fromdate").attr("style","font-color:red");
		   //$("#fromdate").append("<span class='error'>Start Date is Required</span>");
		   is_valid=false;
	   }else if(end==null || end==""){
		   $("#todate").append("<span class='error'>To Date is Required</span>");
		   is_valid=false;
	   }
	   
	   return is_valid;
   }
   
   
   function getAllEmployees(){
		var res=''
		$
		.ajax({
			url : BASE_URL + "/hrmgnt/getAllEmployees.htm",
			type : 'GET',
			headers: {"storeId": storeID},
			async:false,
			contentType : 'application/json;charset=utf-8',
			success : function(response) {
				   res=JSON.parse(response);
				
			},
			error:function(error){
				console.log("ERROR IN GETTING ALL EMPLOYEES:");
				console.log(error);
				//alert("ERROR IN GETTING ALL EMPLOYEES");
			}
		});
		return res;
	}
 
   
   </script>
   
   
   

   <script type="text/javascript">
   
   	
   
   var BASE_URL="${pageContext.request.contextPath}";

   var language = '<%=session.getAttribute("language") %>';
   
     
	  <%  
	  String responseString ="";
      Gson gson =new Gson();
     Customer obj=(Customer)session.getAttribute("loggedinUser"); 
    responseString =gson.toJson(obj);
	  String today ="";
	  DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
      today = formatter.format(new Date());
    %>
	   
	   var customerstring ='<%=responseString%>'
	   var customer=JSON.parse(customerstring);
	   var todaydate='<%=today%>'
	   console.log("TODAY DATE IN BODY SCRIPT TAG IS:");
	   console.log(todaydate);
	   console.log("CUSTOMER IN BODY SCRIPT TAG IS:");
	   console.log(customerstring);
	   console.log("ID IS:"+customer.id); 
  
        

   var storeID="${sessionScope.loggedinStore.id}";

   var detmg="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png";
   var deleteimg="${pageContext.request.contextPath}/assets/images/admin/g/g_delete.png";
   var editimg="${pageContext.request.contextPath}/assets/images/admin/g/g_edit.png";
   var contextpath="${pageContext.request.contextPath}";
  var dutyShiftList='<%=session.getAttribute("dutyShiftList")%>'
  var dutyShiftList2="${sessionScope.dutyShiftList}";
  var now = new Date();
  
  var weekStart = moment().clone().startOf('week');
  var currentmonday=moment(weekStart, "YYYY-MM-DD").add('days',1).format("YYYY-MM-DD");
  console.log("WEEKSTART ARRAY IN SHIFT SCHEDULE JSP IS:");
  console.log(weekStart);
  console.log("CURRENT WEEK MONDAY IN SHIFT SCHEDULE JSP IS:");
  console.log(currentmonday);
    
 $(document).ready(function(){
 $('#empshiftfromtime').timepicker({
 	timeFormat:"HH:mm"
 });
 $("#empshifttotime").timepicker({
 	timeFormat:"HH:mm"
 });
 
 $("#fromdate").datepicker( {
 	format : "yyyy-mm-dd",
 	autoclose:true,
 	beforeShowDay: function(date){ 
 		  var day = date.getDay(); 
 		 if(day==1){
 			 return true;
 		 }else{
 			 return false;
 		 }
 		 
 		}
	   }); 
 
 $("#fromdateinmodal").datepicker( {
	 	format : "yyyy-mm-dd",
	 	autoclose:true,
    }); 
 $("#todateinmodal").datepicker( {
	 	format : "yyyy-mm-dd",
	 	autoclose:true,
 }); 
 $("#fromdate").val(currentmonday);
 var slot=$("#slotinputselect").val();
 var new_date = moment(currentmonday, "YYYY-MM-DD").add('days', slot-1).format("YYYY-MM-DD");
 $("#todate").val(new_date);
 $("#todate").prop("disabled",true);
 
 $("#getallemployeeshiftinfo").trigger("click");
 
 $("#fromdate").on("change",function(){
	 var slot=$("#slotinputselect").val();
	 var startdate=$("#fromdate").val();
	 var new_date = moment(startdate, "YYYY-MM-DD").add('days', slot-1).format("YYYY-MM-DD");
	 $("#todate").val(new_date);
	 $("#getallemployeeshiftinfo").trigger("click");
 });
 
 
 $("#slotinputselect").on("change",function(){
	 var startdate=$("#fromdate").val();
	 var slot=$("#slotinputselect").val();
	 var new_date = moment(startdate, "YYYY-MM-DD").add('days', slot-1).format("YYYY-MM-DD");
	 $("#todate").val(new_date);
	 $("#getallemployeeshiftinfo").trigger("click");
 });
 
 });


	   
	
 
 
   </script>	
   
   
      
  <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
       <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script>
    </c:when>    
    
    <c:otherwise>
     <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script> 
     <%-- <script src="${pageContext.request.contextPath}/assets/js/hradminScript.js"></script> --%>
     <script src="${pageContext.request.contextPath}/assets/js/shiftSchedule.js"></script>
    </c:otherwise>
    </c:choose>
                            
  
</body>
