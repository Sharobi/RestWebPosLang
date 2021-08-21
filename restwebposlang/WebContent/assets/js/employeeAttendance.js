var isoff_checked=false;
var isleave_checked=false;
$(document).ready(function(){
	$("#forAdmin").hide();
	$("#forAdmin2").hide();
	$("#forAdmin3").hide();
	$("#i1").show();
	$("#i2").show();
	$("#i3").show();
	var obj=getAllLeaves();
	//var obj2=getAllEmployeeShiftSchedule();
	console.log("EMPLOYEE LEAVES OBEJCT RECEIVED IS:");
	console.log(obj);
	/*console.log("EMPLOYEE SHIFT SCHEDULE IN employeeattendance.js FILE RECEIVED IS:");
	console.log(obj2);*/
	if(obj!=null){
	createDropDownForEmployeeLeaves(obj);
	}
	
	//THIS IS FOR CLOSING MODAL//
	$("#closeemployeeattendance").click(function(){
		$("#employeeattendanceaddmodal").modal("hide");
		$("#off").prop("checked",false);
		$("#leave").prop("checked",false);
		$("#off").prop("disabled",false);
		$("#leave").prop("disabled",false);
		$("#selectemployeeleaves").addClass("hide");
	});
	
	$("#addemployeeattendance").click(function(){
		addEmployeeAttendance();
	});
	
	
	
	 $("#off").click(function(){
		 isoff_checked=$("#off").prop("checked")
		 if(isoff_checked){
			 $("#leave").prop("checked",false);
			 $("#selectemployeeleaves").addClass("hide");
			  $("#emptimein").val("00:00");
			  $("#emptimeout").val("00:00");
			  $("#emptimein").prop("disabled",true);
			  $("#emptimeout").prop("disabled",true);
			 
		 }else if(!isoff_checked){
			 
				 $("#emptimein").prop("disabled",false);
				 $("#emptimeout").prop("disabled",false);
			 
		 }
		
		  
	});
 
 $("#leave").click(function(){
	 
	 isleave_checked=$("#leave").prop("checked")
	 if(isleave_checked){
		 $("#off").prop("checked",false);
		 $("#selectemployeeleaves").removeClass("hide");
		 $("#emptimein").val("00:00");
		 $("#emptimeout").val("00:00");
		 $("#emptimein").prop("disabled",true);
		 $("#emptimeout").prop("disabled",true);
		 
	 }else if(!isleave_checked){
			 $("#emptimein").prop("disabled",false);
			 $("#emptimeout").prop("disabled",false);
		 $("#selectemployeeleaves").addClass("hide");
	 }
	 
	
	   
});
 
 
 $("#employeeattendanceexcelexport").click(function () {  
	 var datein=$("#datein").val();
	 var dateout=$("#dateout").val();
	 var fileName="EmployeeAttendance_"+datein+"_"+dateout+".xls";
	    $("#employeeattendancetable").table2excel({  
	        filename: fileName  
	    });  
	}); 
	
});


function createDropDownForEmployeeLeaves(obj){
	var myvar="<select id='selectemployeeleaves' class='customselect hide'>";
	myvar+="<option value='0'>"+"Select Leave"+"</option>"
	
	obj.filter(function(o){
		myvar+="<option value="+o.id+">"+o.leaveType+"</option>"
	});
	
	$("#employeeleavestd").append(myvar);
}

function getAllLeaves(){
	var  url=BASE_URL + "/hrmgnt/getEmployeeLeaves.htm";
	var obj=null;
	 $.ajax({
			url : url,
			type : 'GET',
			headers: {"storeId": storeID},
			async:false,
			contentType : 'application/json;charset=utf-8',
			success : function(response) {
				obj=JSON.parse(response);
				
			},
			error:function(error){
				console.log("ERROR IN employeeAttendance.js FILE FOR GETTING ALL LEAVES EMPLOYEE ATTENDANCE IS:");
				console.log(error);
			}
		});		 
	return obj;
}

function addEmployeeAttendance(){
	var attendanceid=$("#attendanceidinmodal").val();
	 $("#employeeattendancemodalfooter").find("span").remove();
	   $("#emptimein").removeClass("customdanger");
		$("#emptimeout").removeClass("customdanger");
		 var leave_id=$("#selectemployeeleaves").val();
	 var emp_id=$("#empid").val();
	      var empattendanceobject=getEmployeeAttendanceJsonObjectForPosting();
			 url=BASE_URL + "/hrmgnt/addEmpAttendance.htm";
			 if(url!=null && url!=""&& Object.keys(empattendanceobject).length != 0){
				 $.ajax({
						url : url,
						type : 'POST',
						async:false,
						contentType : 'application/json;charset=utf-8',
						data : JSON.stringify(empattendanceobject),
						success : function(response) {
							obj=JSON.parse(response);
							if(obj.is_success){ 
							   var msg="Succesfully saved the record";
								$("#alertmodalbody").html(msg);
								$("#alertmessagemodal").modal("show");
							}
						},
						error:function(error){
							console.log("ERROR IN employeeAttendance.js FILE FOR ADDING OR UPDATING EMPLOYEE ATTENDANCE IS:");
							console.log(error);
						}
					});		 
			 
				 
			 }else{
				 if(attendanceid>0){
					alert("You cannot update any attendance record"); 
				 }else if(emp_id<=0){
					alert("There are no employess to add attendance.Please add your employees first.") 
				 }else if(Object.keys(empattendanceobject).length == 0){
					 var intime=$("#emptimein").val();
					 var outtime=$("#emptimeout").val();
					 
					 if(outtime==""|| outtime==null){
						 $("#emptimein").addClass("customdanger");
							$("#emptimeout").addClass("customdanger");
								
						 $("#employeeattendancemodalfooter").append("<span class='error'>Out time cannot be empty</span>");
					 }else if(intime==""|| intime==null){
						 $("#emptimein").addClass("customdanger");
							$("#emptimeout").addClass("customdanger");
								
						 $("#employeeattendancemodalfooter").append("<span class='error'>In time cannot be empty</span>");
					 }else if( (outtime=="00:00"&& intime=="00:00" && leave_id<=0 )|| (outtime=="00:00"&& intime=="00:00" && $("#off").prop("checked")==false) ){
						 $("#emptimein").addClass("customdanger");
						$("#emptimeout").addClass("customdanger");
						$("#employeeattendancemodalfooter").append("<span class='error'>Please select values of InTime and OutTime</span>");
						 
					 } else if(outtime<intime){
						 //alert("WORKING");
							$("#emptimein").addClass("customdanger");
							$("#emptimeout").addClass("customdanger");
								
						 $("#employeeattendancemodalfooter").append("<span class='error'>Out time should be greater than  In time</span>");
								
							 
						 }
					 
					 
					 
					
					 
					 
				 }
				 
			 }
			 
	
	 
	 
	
}

function getEmployeeAttendanceJsonObjectForPosting(){
	 var intime= $("#emptimein").val();
	   var outtime=$("#emptimeout").val();
	   var attendanceid=$("#attendanceidinmodal").val();
	   var leave_id=$("#selectemployeeleaves").val();
		var workinghours=0;
		var emp_id=$("#empid").val();
		var shiftScheduleId=$("#shiftscheduleid").val();
		var empattendanceobject={};
		var indatestring=$("#dateinmodal").val();
		 var indate= new Date(indatestring);
		indate=moment(indate,"YYYY-MM-DD").format("YYYY-MM-DD");
		 var outdate=indate;
		//debugger
		if(attendanceid==0 && emp_id>0){
			if((outtime!=null && intime!=null && outtime>intime)||(outtime<intime && outtime.startsWith("0") && !intime.startsWith("0"))){
				   if(outtime<intime && outtime.startsWith("0") && !intime.startsWith("0")){
					     var outtimehour=parseInt(outtime.split(":")[0]);
						 var intimehour=parseInt(intime.split(":")[0]);
						 var outtimeminutes=parseInt(outtime.split(":")[1]);
						 var intimeminutes=parseInt(intime.split(":")[1]);
						 var totalintime=0;
						 var totalouttime=0;
						 totalouttime=((outtimehour+24)*60)+(outtimeminutes);
						 totalintime=(intimehour*60)+(intimeminutes);
						 workinghours=totalouttime-totalintime;
						 /*var indatestring=$("#dateinmodal").val();
						 var indate= new Date(indatestring);
						 indate=moment(indate,"YYYY-MM-DD").format("YYYY-MM-DD");
						 var outdate=moment(indate, "YYYY-MM-DD").add('days',1).format("YYYY-MM-DD");*/
						 
						// $("#dateinmodal").val(indate);
						 //$("#dateoutmodal").val(indate);
						 
						// $("#dateoutmodal").val(outdate);
						
						
						 
					 }else{
						 var outtimehour=+(outtime.split(":")[0]);
						 var intimehour=+(intime.split(":")[0]);
						 var outtimeminutes=+(outtime.split(":")[1]);
						 var intimeminutes=+(intime.split(":")[1]);
						 var totalintime=0;
						 var totalouttime=0;
						 totalouttime=((outtimehour)*60)+(outtimeminutes);
						 totalintime=(intimehour*60)+(intimeminutes);
						 workinghours=totalouttime-totalintime;
						 console.log("workinghours IS:"+workinghours);
						 /* var indatestring=$("#dateinmodal").val();
						  var indate= new Date(indatestring);
						  var outdate=new Date(indatestring);
						  indate=moment(indate,"YYYY-MM-DD").format("YYYY-MM-DD");*/
						 
						  /*outdate=moment(outdate,"YYYY-MM-DD").format("YYYY-MM-DD");*/
						  
						  if(intime.startsWith("00")){
							indate=moment(indate, "YYYY-MM-DD").add('days',1).format("YYYY-MM-DD"); 
						  }
						  /*outdate=indate;
						  $("#dateinmodal").val(indate);
						  $("#dateoutmodal").val(outdate);	*/  
					 } 
				   
				  
		     }/*else{//if intime and outtime are equal or both are 00:00//
		    	 var indatestring=$("#dateinmodal").val();
		    	 var indate= new Date(indatestring);
				 var outdate=new Date(indatestring);
				 if(intime.startsWith("00")){
						indate=moment(indate, "YYYY-MM-DD").add('days',1).format("YYYY-MM-DD"); 
					  }
				 indate=moment(indate,"YYYY-MM-DD").format("YYYY-MM-DD");
				 //outdate=moment(outdate,"YYYY-MM-DD").format("YYYY-MM-DD");
				 outdate=indate;
				 $("#dateinmodal").val(indate);
				 $("#dateoutmodal").val(outdate);
		    	 
		     } */
			     
			    /* if(workinghours>0){*/
			
			    	 //var indate= $("#dateinmodal").val();
					 //var outdate=$("#dateoutmodal").val();
					 
					 outdate=indate;
					/* if(("#off").prop("checked")==true){
						 empattendanceobject.isOffDay=1;
						
						 
					 }else{
						 empattendanceobject.isOffDay=0;
					 }*/
					 
					 /*if(leave_id>0){
						 outdate=indate;
					 }*/
					 if((workinghours>0)||(outtime=="00:00"&& intime=="00:00" && leave_id>0 )|| (outtime=="00:00"&& intime=="00:00" && $("#off").prop("checked")==true)){
						 if($("#off").prop("checked")==true){
							 empattendanceobject.isOffDay=1;
							 //outdate=indate;
							 
						 }else{
							 empattendanceobject.isOffDay=0;
						 }
						 empattendanceobject.id=0;
						 empattendanceobject.workedHour=workinghours;
						 empattendanceobject.employee={"id":emp_id};
						 empattendanceobject.storeId=storeID;
						 empattendanceobject.dateIn=indate;
						 empattendanceobject.dateOut=outdate;
						 empattendanceobject.timeIn=intime;
						 empattendanceobject.timeOut=outtime;
						 empattendanceobject.leaveId=leave_id;
						 empattendanceobject.shiftScheduleId=shiftScheduleId;
						 
					 }
							 
					 /*empattendanceobject.id=0;
					 empattendanceobject.workedHour=workinghours;
					 empattendanceobject.employee={"id":emp_id};
					 empattendanceobject.storeId=storeID;
					 empattendanceobject.dateIn=indate;
					 empattendanceobject.dateOut=outdate;
					 empattendanceobject.timeIn=intime;
					 empattendanceobject.timeOut=outtime;
					 empattendanceobject.leaveId=leave_id;
					 empattendanceobject.shiftScheduleId=shiftScheduleId;*/
					 
			    	 
			    /* }*/
			
		}
	     
	     return empattendanceobject;
	
}

function getAllEmployeeShiftSchedule(){
	   var url=BASE_URL + "/hrmgnt/getAllEmpShiftSchedule.htm";
	   var res=null;
	   var startdate=$("#datein").val();
	   var todate=$("#dateout").val();
	   
	   startdate=moment(startdate).format('YYYY-MM-DD');
	   todate=moment(todate).format('YYYY-MM-DD');
	   $.ajax({
			url :url,
			type : 'GET',
			headers: {"storeId": storeID,"fromDate":startdate,"toDate":todate},
			contentType : 'application/json',
			async:false,
			success : function(response) {
				if(response!=null && response!=""){
					//console.log("RESPONSE IS:"+response)
					res=JSON.parse(response);
					console.log("RES  IN shiftschedule.jsp FILE AFTER CLICKING  getallemployeeshiftinfo BUTTON  IS:");
					console.log(res);
				}
				
			},
			error:function(error){
				console.log("ERROR IN shiftschedule.jsp FILE AFTER CLICKING  getallemployeeshiftinfo BUTTON  IS:");
				console.log(error);
			}
		});
	   return res;
	   
}

function getAllEmployeeAttendanceByEmployeeIdAndDate(empid,date){
	date=moment(date).format("YYYY-MM-DD");
	console.log("TYPE OF DATE VARIABLE IS:"+typeof(date));
	//alert("CALLED getAllEmployeeAttendanceByEmployeeIdAndDate");
	//alert(date);
	//alert(empid);
	var storeid=+storeID;
	 var url=BASE_URL + "/hrmgnt/getEmpAttendanceByEmpIdandDate.htm?date="+date;
	 var headers={"storeId": storeid,"empId":empid};
	 console.log("HEADERS IS:");
	 console.log(headers);
	 var res=null;
	$.ajax({
		url :url,
		type : 'GET',
		headers: {"storeId": storeID,"empId":empid},
		contentType : 'application/json;charset=utf-8',
		async:false,
		success : function(response) {
			if(response!=null && response!=""){
				console.log("RESPONSE IS:");
				console.log(response);
				res=JSON.parse(response);
				console.log("RES  IN shiftschedule.jsp FILE AFTER CLICKING  getallemployeeshiftinfo BUTTON  IS:");
				console.log(res);
			}
			
		},
		error:function(error){
			console.log("ERROR IN shiftschedule.jsp FILE AFTER CLICKING  getallemployeeshiftinfo BUTTON  IS:");
			console.log(error);
		}
	});
	return res;
}

function getDutyShiftById(){
	var dutyshiftid=$("#selectdutyshiftlistinmodal").val();
	
	var url=BASE_URL + "/hrmgnt/getDutyShiftsById.htm?storeId="+storeID+"&id="+dutyshiftid;
	   var employeetyperes='';
	   	$.ajax({
				url :url,
				type : 'GET',
				async:false,
				contentType : 'application/json;charset=utf-8',
				success : function(obj) {
				 employeetyperes=JSON.parse(obj);
				},
				error:function(error){ 
					console.log("ERROR INSIDE getEmployeeTypesById FUNCTION IN hrAdminScript.js FILE IS");
					console.log(error);
				}
	   	    });
	   
	   return employeetyperes;
	
}



function getSingleEmployeeShiftSchedule(empid,date){
	   var url=BASE_URL + "/hrmgnt/getEmpShiftScheduleByEmpIdandDate.htm?date="+date;
	   var res=null;
	   date=moment(date).format('YYYY-MM-DD');
	   var headerobj= new Object();
	   headerobj.storeId=storeID;
	   headerobj.empId=empid;
	   //headerobj.date=date;
	   //headers: {"storeId": storeID,"empId":empid,"date":date},
	   $.ajax({
			url :url,
			type : 'GET',
			headers: headerobj,
			contentType : 'application/json',
			async:false,
			success : function(response) {
				if(response!=null && response!=""){
					//console.log("RESPONSE IS:"+response)
					res=JSON.parse(response);
					console.log("RES  IN employeeateendance.js FILE IN getSingleEmployeeShiftSchedule() FUNCTION  IS:");
					console.log(res);
				}
				
			},
			error:function(error){
				console.log("ERRORIN employeeateendance.js FILE IN getSingleEmployeeShiftSchedule() FUNCTION  IS:");
				console.log(error);
			}
		});
	   return res;
	   
}
