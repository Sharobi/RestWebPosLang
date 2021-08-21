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
    <title>:. POS :: Employee Attendance :.</title>
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
  
   <%--  <jsp:include page="/pages/common/header.jsp"></jsp:include> --%>
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
          <%--  <jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>  --%> 
           <jsp:include page="/pages/hr/hrmodules.jsp"></jsp:include>  
         <div class="col-md-10 col-sm-10">
					<div class="col-md-12 col-sm-12" align="center">
						<span class="spanclass">Select Date For Employee Attendance</span>&nbsp;&nbsp;

						
						       
							    
								<span class="spanclass">Date In:</span>
								<input type="text" id="datein" size="7" value="">
								<span class="spanclass">Date Out:</span>
								<input type="text" id="dateout" size="7" value="">
								 <%-- <c:if test="${! empty dutyShiftList }">
								     
						             <select id="selectdutyshiftlist" style="text-align:center; width:10%; color: #222222;margin-bottom: 5px;" class="hide">
                                 	 <option value=0> Please Select Shift</option>
                                 	<c:forEach items="${dutyShiftList}" var="dutyshift">
                                 	 <option value=${dutyshift.shiftingNo}> ${dutyshift.shiftName}</option>
                                 	</c:forEach>
                                    </select>   
                                    	
                                </c:if> --%>
							    
                                 <span class="spanclass">Select Slot Interval:</span>
                                <select id="slotinputselect" class=" customslotinputselect" >
                                <option selected="selected" >7</option>
                                <option>14</option>
                               <!--  <option>21</option>
                                <option>28</option> -->
                                </select>
								
							
							<button id="getallemployeeattendanceinfo" class="btn btn-success"
							style="background: #FF8576; margin-bottom: 3px;"><spring:message
								code="admin.rpt_sales_day.jsp.submit" text="SUBMIT" /></button>

							<div id="content" align="center" style="margin-top:20px;">
							
							 <table class="table table-striped table-bordered table-hover hide" id="employeeattendancetable">
                                    <thead style="background:#404040; color:#FFF;" id="employeeattendancetablethead">
                                            <tr id="theadrow" class="text-nowrap">
                                            
                                           </tr>
                                                                                  
                                   
                                    </thead>
                                    <tbody id="employeeattendancetabletbody">
                                    	
                                    </tbody>
                                </table>
							 <div id="exportbuttondiv" class="hide">
                                <a  id="employeeattendanceexcelexport" class="btn btn-success customexportbutton"><spring:message code="invitemstock.jsp.export" text="EXPORT" /></a>
                                </div>
							</div>
							<!-- EMPLOYEE ATTENDANCE ADD MODAL STARTS FROM LINE NUMBER 117 AND ENDS AT 178 -->
						   <div class="modal fade" data-backdrop="static" id="employeeattendanceaddmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                                <div class="modal-dialog" style="margin: 100px auto;width:60%;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                            <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel2">Add Employee Attendance</h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: left;font-size: 20px;">
                                            	<table id="employeeattendancemodaltable">
                                                   <tr>
                                                   <td class="text-nowrap col-span-4 hide"><spring:message text="DATE IN" /></td>
                                            		
                                            		 <td id="dateintdtag" class="hide"  ><input type="text" placeholder="Date In" id="dateinmodal" style="text-align:center; width:90%; color: #222222;margin-bottom: 5px; font-size: 15px;" /></td> 
                                            		
                                                   </tr>
                                            		<tr id="employeeattendancemodaltablerow">
                                            		
                                            		<%-- <td class="text-nowrap col-span-4"><spring:message text="DATE IN" /></td>
                                            		<td id="dateintdtag"   ><input type="text" placeholder="Date In" id="dateinmodal" style="text-align:center; width:90%; color: #222222;margin-bottom: 5px; font-size: 15px;" /></td> --%>
                                            		
                                            		<td id="dateouttdtag" class="hide"  ><input type="text" placeholder="Date Out" id="dateoutmodal" style="text-align:center; width:60%; color: #222222;margin-bottom: 5px;" /></td>
                                            		<td id="attendancetdtag" class="hide"  ><input type="text" placeholder="AttendanceId" id="attendanceidinmodal" style="text-align:center; width:20%; color: #222222;margin-bottom: 5px;" /></td>
                                            		
                                            		<td id="empidtdtag" class="hide" ><input type="text" placeholder="EmployeeId" id="empid" style="text-align:center; width:20%; color: #222222;margin-bottom: 5px;" /></td>
                                            		<td id="shiftscheduleidtdtag" class="hide"  ><input type="text" placeholder="ShiftScheduleId" id="shiftscheduleid" style="text-align:center; width:20%; color: #222222;margin-bottom: 5px;" /></td>
                                             
                                            	
                                            			<!-- <td id="errorshiftno" style="color:red;font-size:14px">  </td> -->
                                            			
                                            			
                                            			
                                            			
                                            			<td class="text-nowrap"><spring:message text="TIME IN" /></td>
                                            			
                                            			 <td style="margin-bottom: 3px;"><input type="text" placeholder="HH:MM" id="emptimein" style="text-align:center; width:70%; color: #222222;margin-bottom: 5px;" /></td>
                                            			   
                                            			<!-- <td id="errorstarttime" style="color:red;font-size:14px">  </td>    -->
                                            			<td class="text-nowrap"><spring:message  text="TIME OUT" /></td>
                                            			
                                            			<td style="margin-bottom: 3px;"><input type="text" placeholder="HH:MM" id="emptimeout" style="text-align:center; width:80%; color: #222222;margin-bottom: 5px;" /></td>
                                            			<td id="labeloff" class="text-nowrap"><spring:message text="OFF" /></td>
                                            			<td id="checkboxofftd"><input type="checkbox" id="off" name="off" value="off"></td><br/>
                                            			<td id="labelleave" class="text-nowrap"><spring:message text="LEAVE" /></td>
                                            			<td id="checkboxleavetd"><input type="checkbox" id="leave" name="leave" value="leave"></input></td>
                                            			<td id="employeeleavestd"></td>
                                            			<tr>
                                            			<%-- <td id="labeloff" class="text-nowrap"><spring:message text="OFF" /></td>
                                            			<td id="checkboxofftd"><input type="checkbox" id="off" name="off" value="off"></td><br/>
                                            			<td id="labelleave" class="text-nowrap"><spring:message text="LEAVE" /></td>
                                            			<td id="checkboxleavetd"><input type="checkbox" id="leave" name="leave" value="leave"></input></td> --%>
                                            			</tr>
                                            			 <%-- <tr> 
                                            			<td colspan="4" style="height:10px;">
                                            			</td>
                                            			 </tr> 
                                            			 <tr style="margin-bottom: 3px;" > 
                                            			 <td id="labeloff" class="text-nowrap"><spring:message text="OFF" /></td>
                                            			<td id="checkboxofftd"><input type="checkbox" id="off" name="off" value="off"></td><br/>
                                            			<td id="labelleave" class="text-nowrap"><spring:message text="LEAVE" /></td>
                                            			<td id="checkboxleavetd"><input type="checkbox" id="leave" name="leave" value="leave"></input></td>
                                            			<td id="employeeleavestd"></td>
                                            			
                                            			 </tr>  --%>
                                            			
                                            			</br>
                                            			<!-- <td><input type="radio" id="leave" name="leave" value="leave">Leave</td> -->
                                            			
                                            			
                                            			
                                            			<!-- <td id="errorendtime" style="color:red;font-size:14px">  </td>  --> 
                                            		</tr>
                                            	</table>
                                           		<div style="text-align: center;color: #F60;font-size: 12px;font-weight: bold;" id="addalertMsg"></div>
                                            </div>
                                        </div>
                                        <div id="employeeattendancemodalfooter" class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <%-- <button type="button" id="cancelshiftshedule"  class="btn btn-warning"><spring:message code="admin.menumgnt.jsp.cancel" text="CANCEL" /></button> --%>
                                            <button type="button"  id="addemployeeattendance"  class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="SAVE" /></button>
                                            <button type="button"  id="closeemployeeattendance"   class="btn btn-primary"><spring:message code="admin.menumgnt.jsp.close" text="CLOSE" /></button>
                                            
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>

						  <div class="modal fade" data-backdrop="static" id="alertmessagemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog" style="margin: 100px auto;">
                                    <div class="modal-content" style="border: 3px solid #ffffff;border-radius: 0px;">
                                        <div class="modal-header" style="background: #939393;color: #fff;border-bottom: 1px solid #939393;">
                                           
                                            <h4 class="modal-title" style="font-size: 18px;font-weight: bold;" id="myModalLabel"><spring:message code="admin.menumgnt.jsp.alert" text="Alert!" /></h4>
                                        </div>
                                        <div class="modal-body" style="background: #404040;border-top: 1px solid #404040;color: #fff;">
                                        	<div style="text-align: center;font-size: 20px;">
                                            <div id="alertmodalbody"></div>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="background: #404040;border-top: 1px solid #404040;padding: 10px;">
                                            <button type="button" style="background: #72BB4F;font-weight: bold;width: 25%" onclick="location.href='${pageContext.request.contextPath}/hrmgmt/loademployeeattendance.htm'" data-dismiss="modal" class="btn btn-success"><spring:message code="admin.menumgnt.jsp.ok" text="OK" /></button>
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
   
  
   <script>
   
   
   <%-- var dutyShiftList='<%=session.getAttribute("dutyShiftList")%>' --%>
	   $("#employeeattendancetabletbody").find("td:eq(1)").prop("disabled",true);
      
   //var dutyShiftList2='${sessionScope.dutyShiftList}';
   $("#getallemployeeattendanceinfo").click(function(){
	   gettablebodyandheaddesign();
	   //var res=getAllEmployeeAttendance();
	   //console.log("ATTENDAVCE RECEIVED IS:");
	   //console.log(res);
	   
	   showallemployeesattendanceintable();
   });
 
	   
   $(document).on("click","#employeeattendancetabletbody>tr>td.cursorpointer",function(){
	   var elem=this;
	   var ths=$("#theadrow").find("th");
	   var anchortagid=$(this).find("a").attr("id");
	   var emp_id=$(this).parent().attr("id");
	   var empname=$(this).parent().find("td:eq(0)").html();
	   var headertextforaddemployeeattendance="Add "+empname+"'s"+" attendance";
	   var headertextforviewemployeeattendance="View "+empname+"'s"+" attendance";
	   var empshiftobj=null;
	   //console.log("SELECTED EMPLOYEE NAME IS:"+empname);
	   var tdindex=$(this).index();
	   $("#empid").val(emp_id);
	   $("#employeeattendancemodalfooter").find("span").remove();
	   $("#emptimein").removeClass("customdanger");
		$("#emptimeout").removeClass("customdanger");
		
		$("#labelleave").removeClass("hide");
		$("#checkboxleavetd").removeClass("hide");
		$("#labeloff").removeClass("hide");
		$("#checkboxofftd").removeClass("hide");
		$("#selectemployeeleaves").addClass("hide");
		$(ths).filter(function(o){
			console.log("ENTERS $(ths).filter() IN LINE 281 OF employeeattendance.jsp PAGE function");
			
			if(o==tdindex){
				console.log("ENTERS $(ths).filter() if(o==tdindex) BLOCK IN LINE 284 OF employeeattendance.jsp PAGE function");
				 $("#dateinmodal").val($(this).text().split(" ")[0]);
			}  
			  
		  }); 
	   if(anchortagid==0){
		   $("#myModalLabel2").html(headertextforaddemployeeattendance+" On "+$("#dateinmodal").val());
		   $("#empid").prop("disabled",false);
		   $("#leave").prop("disabled",false);
		   $("#emptimein").prop("disabled",false);
		   $("#emptimeout").prop("disabled",false);
		   $("#dateinmodal").prop("disabled",true);
		   $("#dateoutmodal").prop("disabled",true);
		   $("#empid").prop("disabled",true);
		   $("#shiftscheduleid").prop("disabled",true);
		   $("#attendanceidinmodal").prop("disabled",true);
		   $("#selectemployeeleaves").prop("disabled",false);
		   $("#selectemployeeleaves").val(0);
		   $("#shiftscheduleid").val(0);
		   $("#addemployeeattendance").removeClass("hide");
		   $("#dateinmodal").val("");
		   $("#dateoutmodal").val("");
		   $("#emptimein").val("");
		   $("#emptimeout").val("");
		   $("#emptimein").prop("disabled",false);
		   $("#emptimeout").prop("disabled",false); 
		   $(ths).filter(function(o){
			   console.log("ENTERS $(ths).filter() IN LINE 311 OF employeeattendance.jsp PAGE function");
				if(o==tdindex){
					console.log("ENTERS $(ths).filter() if(o==tdindex) BLOCK IN LINE 313 OF employeeattendance.jsp PAGE function");
					 $("#dateinmodal").val($(this).text().split(" ")[0]);
				}  
				  
			  }); 
		   //alert("DATE IN MODAL VALUE BEFORE SETTING EMPLOYEE SHIFT ID IS:"+$("#dateinmodal").val());
		   empshiftobj=getSingleEmployeeShiftSchedule(emp_id,$("#dateinmodal").val());
		   if(empshiftobj!=null && empshiftobj!=""){
			   var shiftid=empshiftobj[0].dutyShiftId;
			   var intime=empshiftobj[0].fromTime;
			   var outtime=empshiftobj[0].toTime;
			   $("#shiftscheduleid").val(shiftid);
			    $("#emptimein").val(intime); 
			  $("#emptimeout").val(outtime);
		   }
		   
		   $("#attendanceidinmodal").val(0); 
	   }else{
		    $(ths).filter(function(o){
		    	 console.log("ENTERS $(ths).filter() IN LINE 334 OF employeeattendance.jsp PAGE function");
				if(o==tdindex){
					console.log("ENTERS $(ths).filter() if(o==tdindex) BLOCK IN LINE 336 OF employeeattendance.jsp PAGE function");
					 $("#dateinmodal").val($(this).text().split(" ")[0]);
				}  
				  
			  });  
		    empshiftobj=getSingleEmployeeShiftSchedule(emp_id,$("#dateinmodal").val());
			   if(empshiftobj!=null && empshiftobj!=""){
				   var shiftid=empshiftobj[0].dutyShiftId;
				   var intime=empshiftobj[0].fromTime;
				   var outtime=empshiftobj[0].toTime;
				   $("#shiftscheduleid").val(shiftid);
			   }else{
				  // alert("NO SHIFT ALERT");
				   $("#shiftscheduleid").val(0);
			   }
		   $("#emptimein").prop("disabled",true);
		   $("#emptimeout").prop("disabled",true);
		   $("#dateinmodal").prop("disabled",true);
		   $("#dateoutmodal").prop("disabled",true);
		   $("#shiftscheduleid").prop("disabled",true);
		   $("#attendanceidinmodal").prop("disabled",true);
		   $("#empid").prop("disabled",true);
		   $("#leave").prop("disabled",true);
		   $("#off").prop("disabled",true);
		   $("#selectemployeeleaves").prop("disabled",true);
		   var timeslot=$(this).find("a").html();
		   var timearray=timeslot.split("-");
		   var intime=timearray[0];
		   var outtime=timearray[1];
		   var dateinmodal=$("#dateinmodal").val();
		   var dateoutmodal=$("#dateoutmodal").val();
		   $("#emptimein").val(intime);
		  $("#emptimeout").val(outtime);
		  $("#myModalLabel2").html(headertextforviewemployeeattendance+" On "+$("#dateinmodal").val());
		  $("#addemployeeattendance").addClass("hide");
		  $("#attendanceidinmodal").val(anchortagid);
		  var res=getAllEmployeeAttendanceByEmployeeIdAndDate(emp_id, moment($("#dateinmodal").val()).format('YYYY-MM-DD'));
			if(res.shiftScheduleId>0){
				$("#shiftscheduleid").val(res.shiftScheduleId);
			}
		   if(res.isOffDay==1){
			   $("#labelleave").addClass("hide");
			   $("#checkboxleavetd").addClass("hide");
			   $("#labeloff").removeClass("hide");
				$("#checkboxofftd").removeClass("hide");
				 $("#off").prop("checked",true);
				 $("#off").prop("disabled",true);
				 $("#emptimein").val("00:00");
				 $("#emptimeout").val("00:00");
			   $("#selectemployeeleaves").addClass("hide");
		   }
			if(res.leaveId>0){
				$("#leave").prop("checked",true);
				$("#leave").prop("disabled",true);
				$("#labelleave").removeClass("hide");
				$("#checkboxleavetd").removeClass("hide");
				$("#labeloff").addClass("hide");
				$("#checkboxofftd").addClass("hide");
				$("#emptimein").val("00:00");
				$("#emptimeout").val("00:00");
				$("#selectemployeeleaves").val(res.leaveId);
				$("#selectemployeeleaves").removeClass("hide");
			}
		  
		   }
	   
	  
	   
	   
	   $("#employeeattendanceaddmodal").modal("show");  
	   
	   
   });
 
   
   function showallemployeesattendanceintable(){
	   
	   var allempattendancelist=getAllEmployeeAttendance();
	   var ths=$("#theadrow").find("th");
	 
	  if(allempattendancelist!=null && allempattendancelist!="" ){
		  for(var i=0;i<allempattendancelist.length;i++){
			  var empattendanceobj=allempattendancelist[i];
			  //var empshiftname=null;
			  var isoffday=empattendanceobj.isOffDay;
			  var anchor="";
			  var leaveId=empattendanceobj.leaveId;
			  var empid=empattendanceobj.employee.id;
			  var start= empattendanceobj.dateIn;
			  var end= empattendanceobj.dateOut;
			  start = new Date(start);
			  end = new Date(end);
			  start = moment(start,"YYYY-MM-DD").format("YYYY-MM-DD");
			  end = moment(end,"YYYY-MM-DD").format("YYYY-MM-DD");
			  $("#dateinmodal").val(start);
			  $("#dateoutmodal").val(end);
			  var daysarr=generatedaterange(start,end);
			  var sel="#employeeattendancetabletbody>tr#"+empid;
			  var selectedemp=$(sel).html(); 
			  var startdate=$("#datein").val();
			  var todate=$("#dateout").val();
			  var timein=empattendanceobj.timeIn;
			  var timeout=empattendanceobj.timeOut;
			   
			   for(var j=0;j<ths.length;j++){
				   var o=$(ths[j]).html().split(" ")[0];
				   for(var k=0;k<daysarr.length;k++){
					   var day=daysarr[k];
					   if(o==day){
						   var td=$(sel).find("td:eq("+j+")");
						   $(td).find("a").remove();
						   if(isoffday==1){
								  anchor="<a class='text-nowrap customanchor' id='"+empattendanceobj.id+"'"+">"+"Off Day"+"</a>";
							  }else if(leaveId>0){
								  anchor="<a class='text-nowrap customanchor' id='"+empattendanceobj.id+"'"+">"+"Leave"+"</a>";
							  }else{
								  anchor="<a class='text-nowrap customanchor' id='"+empattendanceobj.id+"'"+">"+timein+"-"+timeout+"</a>";
							  }
						   
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
	  $("#employeeattendancetabletbody").empty();
	   $("#theadrow").empty();
	    var start=$("#datein").val();
		var end=$("#dateout").val();
	   var daysarr=generatedaterange(start,end);
	   var emplistresponse=getAllEmployees();
	   var head="";
	   console.log("DAYS ARRAY IS:");
	   console.log(daysarr); 
	    head=head+'<th>NAME</th>';
	   
	    
	   var body='';
	   for(var i=0;i<daysarr.length;i++){
		   var obj=daysarr[i];
		   var t= new Date(obj);
		   var x=moment(t).format("YYYY-MM-DD");
		   var weekday=moment(x).weekday();
		   
		   console.log("WEEKDAY=="+weekday);
		   
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
		   $("#employeeattendancetable").removeClass("hide");
		  
		
		   for(var i=0;i<emplistresponse.length;i++){
			  
			   var empobj=emplistresponse[i];
			   
			   var empid=empobj.id;
			   var empname=empobj.name;
			   var st_id=empobj.storeId;
			   
			  
			  /*  body=body+"<tr style='background:#404040; color:#FFF;' id="+empid+">" */
			   body=body+"<tr class='customtablerow' id="+empid+">"
			   body=body+"<td class='default'>"
			   body=body+empname
			   body=body+"</td>"
			   
			   
				   for(var k=0;k<daysarr.length;k++){
					   body=body+"<td class='cursorpointer'><a class='text-nowrap customanchor' id='0'>-</a></td>"
				   }
			   
			 
			   
			   body=body+"</tr>" 
			   
			   
		   }
		
		    
		   $("#employeeattendancetabletbody").append(body);
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
	   var start=$("#datein").val();
	   var end=$("#dateout").val();
	   
	   if(start==null || start==""){
		   $("#datein").attr("style","font-color:red");
		   //$("#datein").append("<span class='error'>Start Date is Required</span>");
		   is_valid=false;
	   }else if(end==null || end==""){
		   $("#dateout").append("<span class='error'>To Date is Required</span>");
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
   
   function getAllEmployeeAttendance(){
	   var url=BASE_URL + "/hrmgnt/getAllEmpAttendance.htm";
	   var res=null;
	   var startdate=$("#datein").val();
	   var todate=$("#dateout").val();
	   console.log("STARTDATE IS:"+startdate);
	   console.log("TODATE IS:"+todate);
	   startdate=moment(startdate).format('YYYY-MM-DD');
	   todate=moment(todate).format('YYYY-MM-DD');
	   $.ajax({
			url :url,
			type : 'GET',
			headers: {"storeId": storeID,"fromDate":startdate,"toDate":todate},
			contentType : 'application/json;charset=utf-8',
			async:false,
			success : function(response) {
				if(response!=null && response!=""){
					//console.log("RESPONSE IS:"+response)
					res=JSON.parse(response);
					console.log("RES  IN employeeattendance.jsp FILE AFTER CLICKING  getAllEmployeeAttendance BUTTON  IS:");
					console.log(res);
				}
				
			},
			error:function(error){
				console.log("ERROR IN employeeattendance.jsp FILE AFTER CLICKING  getAllEmployeeAttendance BUTTON  IS:");
				console.log(error);
			}
		});
	   return res;
	   
   }
   </script>
  <script src="${pageContext.request.contextPath}/assets/js/table2excel.js"></script>
   
   

   <script type="text/javascript">
   
   	
   
   var BASE_URL="${pageContext.request.contextPath}";

   var language = '<%= session.getAttribute("language") %>';

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
   console.log("WEEKSTART ARRAY IN EMPLOYEE ATTENDANCE JSP IS:");
   console.log(weekStart);
   console.log("CURRENT WEEK MONDAY IN EMPLOYEE ATTENDANCE JSP PAGE IS:");
   console.log(currentmonday);
   
  
  
   
 
 $(document).ready(function(){
 
 $('#emptimein').timepicker({
 	timeFormat:"HH:mm"
 });
 $("#emptimeout").timepicker({
 	timeFormat:"HH:mm"
 });
 
 
 $("#datein").datepicker( {
 	
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
 


 $("#datein").val(currentmonday);
 var slot=$("#slotinputselect").val();
 var new_date = moment(currentmonday, "YYYY-MM-DD").add('days', slot-1).format("YYYY-MM-DD");
 $("#dateout").val(new_date);
 
 
 $("#getallemployeeattendanceinfo").trigger("click");
$("#dateout").prop("disabled",true);


$("#datein").on("change",function(){
	 var slot=$("#slotinputselect").val();
	 var startdate=$("#datein").val();
	 var new_date = moment(startdate, "yyyy-mm-dd").add('days', 6).format("yyyy-mm-dd");
	 var new_date = moment(startdate, "YYYY-MM-DD").add('days', slot-1).format("YYYY-MM-DD");
	
	 $("#dateout").val(new_date);
	 $("#getallemployeeattendanceinfo").trigger("click");
});

$("#slotinputselect").on("change",function(){
	 var datein=$("#datein").val();
	 var slot=$("#slotinputselect").val();
	 var new_date = moment(datein, "YYYY-MM-DD").add('days', slot-1).format("YYYY-MM-DD");
	 $("#dateout").val(new_date);
	 $("#getallemployeeattendanceinfo").trigger("click");
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
    <%--  <script src="${pageContext.request.contextPath}/assets/js/shiftSchedule.js"></script> --%>
      <script src="${pageContext.request.contextPath}/assets/js/employeeAttendance.js"></script>
    </c:otherwise>
    </c:choose>

  
</body>
