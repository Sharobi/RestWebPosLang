$(document).ready(function(){
	$("#forAdmin").hide();
	$("#forAdmin2").hide();
	$("#forAdmin3").hide();
	$("#i1").show();
	$("#i2").show();
	$("#i3").show();
	 gettablebodydesign();
	 $("#employeeleavedetailsexport").click(function () {  
		 var date = new Date();
		 var currentyear = date.getFullYear();
		 var fileName="EmployeeLeaveDetails_"+currentyear+".xls";
	        $("#employeeleavedetailstable").table2excel({  
	            filename: fileName  
	        });  
	    }); 
	
});
function gettablebodydesign(){
	
	var res=getAllEmployeeLeaveDetails();
	var tr="";
	console.log("ALL EMPLOYEE LEAVE DETAILS ARE:");
	console.log(res);
	
	if(res!=null && res!="" && res.length>0){
		$("#employeeleavedetailstable").removeClass("hide");
		res.filter(function(ob){
			tr=tr+'<tr class="customtablerow"  id=" '+ob.empId+'">'
			tr=tr+'<td>'+ob.empName+'</td>'
			tr=tr+'<td>'+ob.janLeave+'</td>'
			tr=tr+'<td>'+ob.febLeave+'</td>'
			tr=tr+'<td>'+ob.marLeave+'</td>'
			tr=tr+'<td>'+ob.aprLeave+'</td>'
			tr=tr+'<td>'+ob.mayLeave+'</td>'
			tr=tr+'<td>'+ob.junLeave+'</td>'
			tr=tr+'<td>'+ob.julLeave+'</td>'
			tr=tr+'<td>'+ob.augLeave+'</td>'
			tr=tr+'<td>'+ob.sepLeave+'</td>'
			tr=tr+'<td>'+ob.octLeave+'</td>'
			tr=tr+'<td>'+ob.novLeave+'</td>'
			tr=tr+'<td>'+ob.decLeave+'</td>'
			tr=tr+'<td>'+ob.totalLeave+'</td>'
			tr=tr+'<td>'+ob.allotedLeave+'</td>'
			tr=tr+'<td>'+ob.leaveBalance+'</td>'
			tr=tr+'</tr>'
		});
		
		$("#employeeleavedetailstabletbody").append(tr);
		$("#exportbuttondiv").removeClass("hide");
	}
	   
	   
 }
function getAllEmployeeLeaveDetails(){
	//fromdate=moment(date).format('YYYY-MM-DD');
	// todate=moment(date).format('YYYY-MM-DD');
	 var url=BASE_URL + "/hrmgnt/getEmpCalculationByYear.htm";
	   var res=null;
	   $.ajax({
			url :url,
			type : 'GET',
			headers: {"storeId": storeID,"empId":0,"fromDate":null,"toDate":null},
			contentType : 'application/json;charset=utf-8',
			async:false,
			success : function(response) {
				if(response!=null && response!=""){
					res=JSON.parse(response);
					console.log("RES  IN employeeleavedetails.jsp FILE GET ALL EMPLOYEE LEAVE DETAILS RESPONSE IS:");
					console.log(res);
				}
				
			},
			error:function(error){
				console.log("ERROR IN employeeleavedetails.jsp FILE IN getAllEmployeeDetails function AJAX CALL IS:");
				console.log(error);
			}
		});
	   return res;
	
}
