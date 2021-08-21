/**
 * 
 */

var emptypedetailsjson=getAllEmployeeTypeDetails();
var emptypelist=emptypedetailsjson.emptypelistjson;
var designationlist=emptypedetailsjson.designationlistjson;
console.log(designationlist);
var departmentlist=emptypedetailsjson.departmentlistjson;

$(document).ready(function(){
	var res=getAllEmployees();
	
	if(res!=null && res.length>0){
		var trow="";
		
		var input1="<input type='image' src='"+editimg+"'"+"></input>"
		var input2="<input type='image' src='"+deleteimg+"'"+"></input>"
		var input3="<input type='image' src='"+detmg+"'"+"></input>"
		for(var i=0;i<res.length;i++){
			var obj =res[i];
			var id=obj.id;
			$("#employeeeditid").val(id);
			var storeId=obj.storeId;
			//$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_empid>#td_empid>#emp_id").val(id);
			trow=trow+"<tr style='background:#404040; color:#FFF;'>";
			trow=trow+"<td class='hide' id='td_empid'>"+obj.id+"</td>"
			trow=trow+"<td>"+obj.name+"</td>"
			trow=trow+"<td>"+obj.presentAddress+"</td>"
			trow=trow+"<td>"+obj.mobileNo+"</td>"
			trow=trow+"<td>"+obj.emailId+"</td>"
			trow=trow+'<td align="center" id="buttons"'+i+'>'
			trow=trow+'<a  href=javascript:onClick=editEmployee('+storeId+','+id+')>'+input1+'</a>'
			//trow=trow+'<a href="javascript:createEmployeeViewDetailsModal(${employee.id},${employee.storeId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a> '
			trow=trow+'</td>'
			trow=trow+'<td align="center">'
			trow=trow+'<a  href=javascript:onClick=deleteEmployee('+storeId+','+id+')>'+input2+'</a>'
			//trow=trow+'<a href="#">'+input2+'</a>  '
			//trow=trow+'<a href="javascript:createEmployeeViewDetailsModal(${employee.id},${employee.storeId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a> '
			trow=trow+'</td>'
			trow=trow+'<td align="center">'
			trow=trow+'<a  href=javascript:onClick=viewEmployee('+storeId+','+id+')>'+input3+'</a>'
			//trow=trow+'<a href="#">'+input3+'</a>  '
			//trow=trow+'<a href="javascript:createEmployeeViewDetailsModal(${employee.id},${employee.storeId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a> '
			trow=trow+'</td>'
			trow=trow+"</tr>"
			
			  //<a href="javascript:showDetailEmployeetypeModal(${employee.id},${employee.storeId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a>  
  			//<a href="javascript:createEmployeeViewDetailsModal(${employee.id},${employee.storeId})"><input type="image" src="${pageContext.request.contextPath}/assets/images/admin/g/g_details.png"></a> 
  		
		}
		
		$("#allemployeestbody").append(trow);
		
	}
	
	
	console.log("GET ALL EMPLOYEES JSON IS:");
	console.log(res);
    $("#addModal").on("click",function(){
    	createEmployeeModal();	
	 });
});

$(document).on('change',"#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr3", function(){
	var tr=this;
	//alert("TRIGGERD MODAL CHANGE");
	var td=$(tr).find("td:nth-child(3)");
	
	var selecttag=$(td).find("select");
	
	var selecttag_id=$(selecttag).attr("id");
	
	var emptype_id=$("#"+selecttag_id).val();
	
	//if(emptype_id)
	
	var employeetyperes=getEmployeeTypesById(emptype_id);
	
	$('#casualLeave').val(employeetyperes.casualLeave);
	$('#sickLeave').val(employeetyperes.sickLeave);
	$('#miscLeave').val(employeetyperes.miscLeave); 
	
});
$(document).on('click',"#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_chk>#td_chk>#chk", function(){
	
	var present_add=$("#emppresentaddress").val();
	$("#emppermanentaddress").val(present_add);
	//alert("CLICKED CHKBOX");

});
//Code To switch between different tabs like details,photo and document//
$(document).on('click','#ultag>li', function(){
	var temp=this;
	console.log("ULTAG>LI ELEMENT IS:");
	console.log(temp);
	var empid=$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_empid>#td_empid>#emp_id").val();
	if(empid>0){
		var hreftemp=$(temp).find("a").attr("href");
		if(hreftemp=="#documenttab"){
			$("#uploaddocument").removeClass("hide");
			$("#registeremployee").addClass("hide");
			$("#updateemployee").addClass("hide");
			$("#uploadphoto").addClass("hide");
		}else if(hreftemp=="#phototab"){
			$("#uploadphoto").removeClass("hide");
			$("#registeremployee").addClass("hide");
			$("#updateemployee").addClass("hide");
			$("#uploaddocument").addClass("hide");
		}else if(hreftemp=="#detailstab"){
			$("#registeremployee").addClass("hide");
			$("#uploaddocument").addClass("hide");
			$("#uploadphoto").addClass("hide");
			$("#updateemployee").removeClass("hide");
			
		}
	}else{
		var hreftemp=$(temp).find("a").attr("href");
		if(hreftemp=="#documenttab"){
			$("#uploaddocument").removeClass("hide");
			$("#registeremployee").addClass("hide");
			$("#uploadphoto").addClass("hide");
		}else if(hreftemp=="#phototab"){
			$("#uploadphoto").removeClass("hide");
			$("#registeremployee").addClass("hide");
			$("#uploaddocument").addClass("hide");
		}else if(hreftemp=="#detailstab"){
			$("#registeremployee").removeClass("hide");
			$("#uploaddocument").addClass("hide");
			$("#uploadphoto").addClass("hide");
			
		}
		
	}
	
		
}) ;

$(document).on('click','#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#registeremployee', function(){
	var selectedbutton=this;
	console.log("SELECTED BUTTON IS");
	console.log($(selectedbutton).html());
	//alert("CLICKED REGISTER BUTTON ");
	var is_valid=validateEmployeeCreateModal();
	if(is_valid){
		
	 var obj=registerEmployee(false,0,0);
	 if(obj.empid>0){
		 jCustomConfirm('Employee Details Are Saved Succesfully', 'Employee Saved');
		/* $("#ultag>#phototab_li>a").prop('disabled', false);
		 $("#ultag>#documenttab_li>a").prop('disabled', false);*/
		  $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#documenttab_li").removeClass("hide");
		  $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#phototab_li").removeClass("hide");
		 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>li").removeClass("active");
		 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#phototab_li>a").trigger("click");
		 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_empid>#td_empid>#emp_id").val(obj.empid);
		 
		/*var test=$("#popup_title_blue").html();
		alert(test);*/
		 
	 }else{
		 jCustomConfirm('Failed To Save Employee', 'Failure!');
	 }
		
	}
//window.reload();	
}) ;


$(document).on('click','#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#uploaddocument', function(){
	
	//alert("CLICKED UPLOAD DOCUMENT BUTTON ");
	var documentfile=$("#documentfile")[0].files[0];
	var formData = new FormData();
	var docname=$("#uploaddoctype").find("option:selected").html();
	//alert("DOCTYPE IS:"+docname)
	formData.append('file', $("#documentfile")[0].files[0]);
	formData.append('id', $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_empid>#td_empid>#emp_id").val());
	formData.append('docname', docname); 
	var res=UploadEmpImageOrDocImage(false,true,formData);
	if(res.is_upload){
		jCustomConfirm('Employee Document Image Is Uploaded Succesfully', 'Upload Document Image!');
		$("#employeeAddModal").modal("hide");
		$("#popup_ok").click(function(){
			location.href=contextpath+'/hrmgmt/viewmemployeedetails.htm';
		});
		 
	 }else{
		 
		 var msg=res.errormsg;
		 jCustomConfirm(msg, 'Failure!');
	 }
	
	}) ;
$(document).on('click','#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#uploadphoto', function(){
	var photofile=$("#photofile")[0].files[0];
	var formData = new FormData();
	formData.append('file', $("#photofile")[0].files[0]); 
	formData.append('id', $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_empid>#td_empid>#emp_id").val()); 
	var res=UploadEmpImageOrDocImage(true,false,formData);
	if(res.is_upload){
		jCustomConfirm('Employee  Image Is Uploaded Succesfully', 'Upload Image!');
		 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>li").removeClass("active");
		 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#documenttab_li>a").trigger("click");
		 
	 }else{
		 
		 var msg=res.errormsg;
		 jCustomConfirm(msg, 'Failure!');
	 }			
	}) ;

$(document).on("click","#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#updateemployee",function(){
	
	var is_valid=validateEmployeeCreateModal();
	if(is_valid){
		//var html=$("#allemployeestbody>tr>td#td_empid").html();
		 //$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_empid>#td_empid>#emp_id").val();
		var empid=$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_empid>#td_empid>#emp_id").val();
		//alert("EMPID FOR UPDATE IS:"+empid);
		//alert("STOREID FOR UPDATE IS"+storeID);
		
		var obj=registerEmployee(true,storeID,empid);
		if(obj.empid>0){
			 jCustomConfirm('Employee Details Are Updated Succesfully', 'Employee Updated');
				/* $("#ultag>#phototab_li>a").prop('disabled', false);
				 $("#ultag>#documenttab_li>a").prop('disabled', false);*/
				  $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#documenttab_li").removeClass("hide");
				  $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#phototab_li").removeClass("hide");
				 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>li").removeClass("active");
				 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#phototab_li>a").trigger("click");
				 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_empid>#td_empid>#emp_id").val(obj.empid);
			
		}else{
			 jCustomConfirm('Failed To Update Employee.Please try later.', 'Failure!');
		}
		
		
		
	}
	
	
});

function viewEmployee(storeId,id){
	var res=getSingleEmployeeDetails(storeId,id);
	createEmployeeModal();
	/*uploadpara
	photofile
	docpara1
	docpara2
	uploaddoctype

	documentfile
*/	
	$("#modalheading").text("Employee Details");
	$("#department").prop("disabled",true);
	$("#designtion").prop("disabled",true);
	$("#emptype").prop("disabled",true);
	
	$("#code").prop("disabled",true);
	$("#name").prop("disabled",true);
	$("#empmobile").prop("disabled",true);
	
	$("#email").prop("disabled",true);
	
	$("#emppresentaddress").prop("disabled",true);
	$("#emppermanentaddress").prop("disabled",true);
	
	$("#casualLeave").prop("disabled",true);
	$("#sickLeave").prop("disabled",true);
	
	$("#earnedLeave").prop("disabled",true);
	$("#miscLeave").prop("disabled",true);
	$("#sickLeave").prop("disabled",true);
	$("#joiningdate").prop("disabled",true);
	 $("#uploaddoctype").prop("disabled",true);
	$("#registeremployee").attr("style","display:none;");
	$("#uploaddocument").attr("style","display:none;");
	$("#uploadphoto").attr("style","display:none;");
	
	
	$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#documenttab_li").removeClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#phototab_li").removeClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_chk").addClass("hide");
	
	$("#uploadpara").addClass("hide");
	$("#photofile").addClass("hide");
	$("#documentfile").addClass("hide");
	$("#docpara1").addClass("hide");
	$("#docpara2").addClass("hide");
	//$("#uploaddoctype").addClass("hide");

	
	/*$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter").addClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#registeremployee").addClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#updateemployee").addClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#uploadphoto").addClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#uploaddocument").addClass("hide");*/
	console.log("SINGLE EMPLOYEE DETAILS ARE:");
	console.log(res);
	if(res!=null){
		var tr=$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr");
		//alert("DESIG ID IS:"+res.designation.id);
		//alert("DESIG:"+res.designation.name);
		//alert("PRESENT ADDRESS:"+res.presentAddress);
		//alert("PERMANENT ADDRESS:"+res.permanentAddress);
		//alert("JOINING DATE:"+res.joiningDate);
		//var st = "yyyy-mm-dd";
		//var dt = new date();
		
		//alert("DATE IS:"+mydate.toDateString());
		//var dt_st= //st in date format same as dt
		var mydate = new Date(res.joiningDate);
		 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr14>td:nth-child(3)>input").val(moment(mydate).format("YYYY-MM-DD"));
		$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr1>td:nth-child(3)").find("select").val(res.dept.id);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr2>td:nth-child(3)").find("select").val(res.designation.id);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr3>td:nth-child(3)").find("select").val(res.employeeType.id);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr4>td:nth-child(3)>input").val(res.code);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr5>td:nth-child(3)>input").val(res.name);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr6>td:nth-child(3)>input").val(res.mobileNo);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr7>td:nth-child(3)>input").val(res.emailId);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr8>td:nth-child(3)>textarea").val(res.presentAddress);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr9>td:nth-child(3)>textarea").val(res.permanentAddress);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr10>td:nth-child(3)>input").val(res.casualLeave);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr11>td:nth-child(3)>input").val(res.sickLeave);
	    $("#photoimg").removeClass("hide");
	    $("#photoimg").attr("src",res.photo);
	    $("#photoimg").attr("style","height:100px;width:100px;");
	    
	    
	    $("#docimg").removeClass("hide");
	    $("#docimg").attr("src",res.idProofDocImage);
	    $("#docimg").attr("style","height:100px;width:100px;");
	    var options=$("#uploaddoctype").find("option");
	     var idproofname=res.idProofName;
	     //idproofname.splice(1,idproofname.length-1);
	     
	     for(var i=0;i<options.length;i++){
	    	 var option=options[i];
	    	 console.log("OPTION IS:");
	    	 console.log(option);
	    	 var st=$(option).html();
	    	 console.log("ST IS"+st);
             //st='"'+st+'"';
	    	 if(st==idproofname){
	    		 //alert("ENTERS");
	 	    	$(option).prop("selected",true);
	 	    }
	    	 
	     }
	    
	    //$("#uploaddoctype").val(res.idProofName);
	    
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr12>td:nth-child(3)>input").val(res.earnedLeave);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr13>td:nth-child(3)>input").val(res.miscLeave);
	    //$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr14>td:nth-child(3)>input").val(mydate.toDateString());
	    //$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr14>td:nth-child(3)>input").datepicker();
		
		
	}
	
}
/*$(document).on("click","#popup_ok",function(){
	alert("TRIGGERD")
	var ele=this;
	var empid=$(ele).attr("empid");
	var storeid=$(ele).attr("storeid");
	alert("EMPID IS:"+empid)
	deleteEmployee(storeid,empid);
	
});*/
function editEmployee(storeId,id){
	var res=getSingleEmployeeDetails(storeId,id);
	console.log("SINGLE EMPLOYEE DETAILS ARE:");
	console.log(res);
	//alert("EDIT IS CALLED");
	//alert("STOREID IS:"+storeId)
	//alert("ID IS:"+id)
	
	/*$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#updateemployee").removeClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#registeremployee").addClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#uploadphoto").addClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#uploaddocument").addClass("hide");*/
	
	
	createEmployeeModal();
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#updateemployee").removeClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#registeremployee").addClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#uploadphoto").addClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalfooter>#uploaddocument").addClass("hide");
	$("#employeeAddModal>#modaldialog>#modalcontent>#modalheader>#modalheading").text("Update Employee");
	$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr14>td:nth-child(3)>input").datepicker({"format":"yyyy-mm-dd","autoclose":true});
	$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_empid>#td_empid>#emp_id").val(id)
	
	$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_chk").addClass("hide");
	
	
	 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#documenttab_li").removeClass("hide");
	  $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#ultag>#phototab_li").removeClass("hide");
	
	if(res!=null){
		var tr=$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr");
		//alert("DESIG ID IS:"+res.designation.id);
		//alert("DESIG:"+res.designation.name);
		//alert("PRESENT ADDRESS:"+res.presentAddress);
		//alert("PERMANENT ADDRESS:"+res.permanentAddress);
		//alert("JOINING DATE:"+res.joiningDate);
		
		var mydate = new Date(res.joiningDate);
		 $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr14>td:nth-child(3)>input").val(moment(mydate).format("YYYY-MM-DD"));
		//alert("DATE IS:"+mydate.toDateString());
		//var dt_st= //st in date format same as dt
		$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_chk").addClass("hide");
		$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr1>td:nth-child(3)").find("select").val(res.dept.id);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr2>td:nth-child(3)").find("select").val(res.designation.id);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr3>td:nth-child(3)").find("select").val(res.employeeType.id);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr4>td:nth-child(3)>input").val(res.code);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr5>td:nth-child(3)>input").val(res.name);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr6>td:nth-child(3)>input").val(res.mobileNo);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr7>td:nth-child(3)>input").val(res.emailId);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr8>td:nth-child(3)>textarea").val(res.presentAddress);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr9>td:nth-child(3)>textarea").val(res.permanentAddress);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr10>td:nth-child(3)>input").val(res.casualLeave);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr11>td:nth-child(3)>input").val(res.sickLeave);
	    
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr12>td:nth-child(3)>input").val(res.earnedLeave);
	    $("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr13>td:nth-child(3)>input").val(res.miscLeave);
	    //$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr14>td:nth-child(3)>input").val(mydate.toDateString());
	    //$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr14>td:nth-child(3)>input").datepicker();
		
		
	}
	
	

	
}

function deleteEmployee(storeId, id) {

	jConfirm(
			'Are you Sure?',
			'Confirmation Dialog',
			function(r) {
				if (r == true) {
					// //$("#popup_cancel").trigger("click");
					var empobj = {};
					empobj.id = id;
					empobj.storeId = storeId;
					$.ajax({
								url : BASE_URL + "/hrmgnt/deleteEmployee.htm",
								type : 'POST',
								async : false,
								contentType : 'application/json;charset=utf-8',
								data : JSON.stringify(empobj),
								success : function(response) {
									obj = JSON.parse(response);
									if (obj.is_delete == true) {
										// location.href=contextpath+'/hrmgmt/viewmemployeedetails.htm';
										jAlert('Deleted Employee Succesfully.',
												'Deleted!');
										$("#popup_ok")
												.click(
														function() {
															location.href = contextpath
																	+ '/hrmgmt/viewmemployeedetails.htm';
														});

										// $("#popup_ok").attr("id","closepopup");
										// window.reload();
									} else {
										jAlert(
												'Failed to delete Employee Record.Please try later.',
												'Failure!');
									}
								},
								error : function(error) {
									console
											.log("ERROR IN hrAdminScript.js FILE FOR DELETING EMPLOYEE IS:");
									console.log(error);
								}
							});

				}

				else {
					location.href = contextpath
							+ '/hrmgmt/viewmemployeedetails.htm';
				}
			});

}
/*function sureToDelete(storeId,id){
	
	jCustomConfirm('Are You Sure To Delete?', 'Delete!');
	$("#popup_ok").attr("empid",id);
	$("#popup_ok").attr("storeId",storeId);
	
}*/

function getSingleEmployeeDetails(storeId,id){
	var res=null;
	url=BASE_URL + "/hrmgnt/getEmployeeByStoreIdAndId.htm";
	$.ajax({
		url :url,
		type : 'GET',
		headers: {"storeId": storeID,"id":id},
		contentType : 'application/json;charset=utf-8',
		async:false,
		success : function(response) {
			res=JSON.parse(response);
			console.log("RES getSingleEmployeeDetails() FUNCTION  IS:");
			console.log(res);
		},
		error:function(error){
			console.log("ERROR IN hrAdminScript.js FILE FOR UPLOADING  EMPLOYEE IMAGE OR DOCUMENT IS:");
			console.log(error);
		}
	});
	return res;
	
}


function UploadEmpImageOrDocImage(is_photofile,is_documentfile,formData){
	var res='';
	var url='';
	if(is_photofile){
       url=BASE_URL + "/hrmgnt/uploadEmpImage.htm";
	}else if(is_documentfile){
		url=BASE_URL + "/hrmgnt/uploadEmpDocImage.htm"
	}
	$.ajax({
		url :url,
		type : 'POST',
		data : formData,
		processData: false,
		contentType: false, 
		async:false,
		success : function(response) {
			res=JSON.parse(response);
		},
		error:function(error){
			console.log("ERROR IN hrAdminScript.js FILE FOR UPLOADING  EMPLOYEE IMAGE OR DOCUMENT IS:");
			console.log(error);
		}
	});
	
	
	return res;
	
	
}


function registerEmployee(is_update,storeId,empid){
	var obj;
	var empcode=$("#code").val();
	var empname=$("#name").val();
	var permanentaddress=$("#emppermanentaddress").val();
	var presentaddress=$("#emppresentaddress").val();
	var empmobile=$("#empmobile").val();
	var email=$("#email").val();
	var department=$("#department").val();
	var designation=$("#designtion").val();
	var emptype=$("#emptype").val();
	var casualLeave=$("#casualLeave").val();
	var sickLeave=$("#sickLeave").val();
	var miscLeave=$("#miscLeave").val();
	var earnedLeave=$("#earnedLeave").val();
	var joiningdate=$("#joiningdate").val();
	var leavingdate=$("#leavingdate").val();
	if(is_update==false && storeId==0 && empid==0){
		var empobj= {};
		empobj.dept=department;
		empobj.designation=designation;
		empobj.employeeType=emptype;
		empobj.emailId=email;
		empobj.permanentAddress=permanentaddress;
		empobj.presentAddress=presentaddress;
		empobj.mobileNo=empmobile;
		empobj.code=empcode;
		empobj.name=empname;
		empobj.casualLeave=casualLeave;
		empobj.sickLeave=sickLeave;
		empobj.miscLeave=miscLeave;
		empobj.earnedLeave=earnedLeave;
		empobj.joiningDate=joiningdate;
		empobj.leavingDate=leavingdate;
		console.log("EMPLOYEE OBJECT BEFORE SENDING IS:");
		console.log(empobj);
		$.ajax({
			url : BASE_URL + "/hrmgnt/addEmployee.htm",
			type : 'POST',
			async:false,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(empobj),
			success : function(response) {
				obj=JSON.parse(response);
			},
			error:function(error){
				console.log("ERROR IN hrAdminScript.js FILE FOR ADDING EMPLOYEE IS:");
				console.log(error);
			}
		});
		
		
		
	}else{
		var empobj= {};
		
		
		empobj.storeId=storeId;
		empobj.id=empid;
		empobj.dept={"id":department};
		empobj.designation={"id":designation};
		empobj.employeeType={"id":emptype};
		empobj.emailId=email;
		empobj.permanentAddress=permanentaddress;
		empobj.presentAddress=presentaddress;
		empobj.mobileNo=empmobile;
		empobj.code=empcode;
		empobj.name=empname;
		empobj.casualLeave=casualLeave;
		empobj.sickLeave=sickLeave;
		empobj.miscLeave=miscLeave;
		empobj.earnedLeave=earnedLeave;
		empobj.joiningDate=joiningdate;
		empobj.leavingDate=leavingdate;
		console.log("EMPLOYEE OBJECT BEFORE SENDING FOR UPDATE IS:");
		console.log(empobj);
		$.ajax({
			url : BASE_URL + "/hrmgnt/updateEmployee.htm",
			type : 'POST',
			async:false,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(empobj),
			success : function(response) {
				obj=JSON.parse(response);
				window.reload();
			},
			error:function(error){
				console.log("ERROR IN hrAdminScript.js FILE FOR ADDING EMPLOYEE IS:");
				console.log(error);
			}
		});
		
		
	}
	return obj;
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
		error:function(){
			alert("ERROR IN GETTING ALL EMPLOYEES");
		}
	});
	return res;
}



function getAllEmployeeTypeDetails(){
	var res=''
	$
	.ajax({
		url : BASE_URL + "/hrmgnt/employeetypedetails.htm",
		type : 'GET',
		async:false,
		contentType : 'application/json;charset=utf-8',
		success : function(response) {
			   res=JSON.parse(response);
			
		}
	});
	return res;
}
function createEmployeeModal(){
	console.log("EMPTYPE JSON RESPONSE IS:");
	console.log(emptypedetailsjson);
    //alert("MODAL FROM JQUERY");
	var myvar = '<div id="modaldialog" class="modal-dialog">'+
	''+
	'    <!-- Modal content-->'+
	'    <div id="modalcontent" class="modal-content">'+
	'      <div id="modalheader" class="modal-header custommodalheaderforemployeemodal">'+
	'        <button type="button" class="close" data-dismiss="modal">×</button>'+
	'        <h4 id="modalheading" class="modal-title">Add Employee</h4>'+
	'      </div>'+
	'      <div id="empmodalbody" class="modal-body custommodalbodyforemployeemodal">'+
	'        <p>Some text in the modal.</p>'+
	'      </div>'+
	'      <div id="modalfooter" class="modal-footer custommodalfooterforemployeemodal">'+
    '<button type="button" class="btn btn-primary" id="registeremployee" >Register Employee</button>'+
    '<button type="button" class="btn btn-primary hide" id="uploadphoto" >Upload Photo</button>'+
    '<button type="button" class="btn btn-primary hide" id="uploaddocument" >Upload Document</button>'+
    '<button type="button" class="btn btn-primary hide" id="updateemployee" >Update Employee</button>'+
	'        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>'+
   
	'      </div>'+
	'    </div>'+
	''+
	'  </div>';
	
	var myvar2 = '<ul class="nav nav-tabs" id="ultag">'+
	'    <li id="detailstab_li" class="active"><a class="customanchor" data-toggle="tab" href="#detailstab">Details</a></li>'+
	'    <li id="phototab_li" class="hide"><a class="customanchor" data-toggle="tab" href="#phototab">Photo</a></li>'+
	'    <li id="documenttab_li" class="hide"><a class="customanchor" data-toggle="tab" href="#documenttab">Document</a></li>'+
	' '+
	'  </ul>'+
	''+
	'  <div id="tabcontent" class="tab-content">'+
	'    <div id="detailstab" class="tab-pane fade in active">'+
	'      <h3>Details Tab </h3>'+
	'      <p>Details Tab Paragraph</p>'+
	'    </div>'+
	'    <div id="phototab" class="tab-pane fade">'+
	'<div class="col-md-12">'+
	'<label class="col-md-6">'+
	'<p id="uploadpara" class="lead">Upload Photo</p>'+
	'</label>'+
	'      <input class="customborder" type="file" id="photofile"></input>'+
	'      <img class="hide"  id="photoimg"></input>'+
	'</div>'+
	'    </div>'+
	'    <div id="documenttab" class="tab-pane fade">'+
	'<div class="col-md-12">'+
	'<label class="col-md-4">'+
	'<p id="docpara1" class="lead text-nowrap">Select Document Type</p>'+
	
	'</label>'+
	/*'<select id="uploaddoctype" style="margin-bottom: 2px; color: #222222; width: 95%;">'+*/
	'<select id="uploaddoctype" class="form-control">'+
	'   <option value="0">Select</option>'+
	'   <option value="1">Aadhar Card</option>'+
	'   <option value="2">Voter Card</option>'+
	'   <option value="3">Passport</option>'+
	'   <option value="4">Pan Card</option>'+
	'</select>'+
	'    </div>'+
	'<div class="col-md-12 margintop">'+
	/*'<div class="col-md-6">'+*/
	'<label class="col-md-6">'+
	'<p id="docpara2" class="lead text-nowrap">Upload Document</p>'+
	'</label>'+
	/*'<div class="col-md-3">'+*/
	'      <input class="customborder" type="file" id="documentfile"></input>'+
	'      <img class="hide"  id="docimg"></input>'+
	/*'</div>'+*/
	/*'    </div>'+*/
	
	'    </div>'+
	'   '+
	'  </div>';

	var myvar3 ='<table id="emptable">'+
	'<tbody id="tbody">'+
	'                                            		<tr id="tr1">'+
	'                                            			<td>DEPARTMENT</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;">'+
	getDropDownForEmployeeModal(false,false,true)+
	'</td>'+
	'                                            		</tr>'+
	'                                            		<tr id="tr2">'+
	'                                            			<td>DESIGNATION </td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;">'+
	getDropDownForEmployeeModal(false,true,false)+
	'														   </td>'+
	'                                            		</tr>'+
	'                                            		<tr id="tr3">'+
	'                                            			<td>TYPE</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td id="td8" style="margin-bottom: 3px;">'+
	getDropDownForEmployeeModal(true,false,false)+
	
	 '</td>'+
	'                                            		</tr>'+
	'                                                    <tr id="tr4">'+
	'                                            			<td>CODE</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><input type="text" id="code" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" />'+
	'                                            			     </td>'+
	
	'                                            		</tr>'+
	'                                            		<tr id="tr5">'+
	'                                            			<td>NAME</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><input type="text" id="name" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;"/>'+
	'                                            			     </td>'+
	
	'                                            		</tr>'+
	'                                            		<tr id="tr6">'+
	'                                            			<td>MOBILE NO</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><input type="number"  id="empmobile" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>'+
	
	'                                            		</tr>'+
	'                                            		<tr id="tr7">'+
	'                                            			<td>EMAIL ID</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><input type="text"  id="email" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>'+
	
	'                                            		</tr>'+
	'                                            		<tr id="tr8">'+
	'                                            			<td>PRESENT ADDRESS</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><textarea rows="3"  id="emppresentaddress" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" ></textarea></td>'+

	'                                            		</tr>'+
	'                                            		<tr id="tr_chk">'+
	'                                            			<td></td>'+
	'                                            			<td></td>'+
	'                                            			<td id="td_chk" style="margin-bottom: 3px;"><input type="checkbox" id="chk" />Same As Present Address</td>'+

	'                                            		</tr>'+
	'                                            		<tr id="tr_empid" class="hide">'+
	'                                            			<td></td>'+
	'                                            			<td></td>'+
	'                                            			<td id="td_empid" style="margin-bottom: 3px;"><input type="text" id="emp_id" />0</td>'+

	'                                            		</tr>'+
	
	
	'                                            		<tr id="tr9">'+
	'                                            			<td>PERMANENT ADDRESS</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><textarea rows="3"   id="emppermanentaddress" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" ></textarea></td>'+
	

	'                                            		</tr>'+
	'                                            		<tr id="tr10">'+
	'                                            			<td>CASUAL LEAVE</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="casualLeave" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>'+
	
	'                                            		</tr>'+
	'                                            		'+
	'                                            		'+
	'                                            		<tr id="tr11">'+
	'                                            			<td>SICK LEAVE</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="sickLeave" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>'+
	
	'                                            		</tr>'+
	'                                            		'+
	'                                            		<tr id="tr12">'+
	'                                            			<td>EARNED LEAVE</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="earnedLeave" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>'+
	
	'                                            		</tr>'+
	'                                            		'+
	'                                            		<tr id="tr13">'+
	'                                            			<td>MISC LEAVE</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><input type="number" step="0.5" id="miscLeave" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>'+

	'                                            		</tr>'+
	'                                            		'+
	'                                            		<tr id="tr14">'+
	'                                            			<td>JOINING DATE</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><input type="text" placeholder="yyyy-mm-dd"  id="joiningdate" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>'+
	
	'                                            		</tr>'+
	'                                            		'+
	'                                            		<tr id="tr15" class="hide">'+
	'                                            			<td>LEAVING DATE</td>'+
	'                                            			<td>:</td>'+
	'                                            			<td style="margin-bottom: 3px;"><input type="date" placeholder="yyyy-mm-dd"  id="leavingdate" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;" /></td>'+
	
	'                                            		</tr>'+
	'</tbody>'+
	'                                            	</table>';
		
	
	
		
$("#employeeAddModal").html(myvar);
$("#empmodalbody").html(myvar2);
$("#detailstab").html(myvar3);
//$("#ultag>#phototab_li>a").prop('disabled', true);
//$("#ultag>#documenttab_li>a").prop('disabled', true);
$("#employeeAddModal").modal("show");
$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr14>td:nth-child(3)>input").datepicker({"format":"yyyy-mm-dd","autoclose":true});
var empidafterregister=$("#employeeAddModal>#modaldialog>#modalcontent>#empmodalbody>#tabcontent>#detailstab>#emptable>#tbody>tr#tr_empid>#td_empid>#emp_id").val();

var li=$("#ultag>li.active>a");
console.log("LI IS:")
console.log($(li).html());




}

function getDropDownForEmployeeModal(is_emptypelist,is_designationlist,is_departmentlist){
	var myvar='';
	if(is_emptypelist){
		myvar='<select id="emptype" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;">'
			myvar+='<option value="0">'+"Select A Value"+'</option>'
			for(var i=0;i<emptypelist.length;i++){
				var obj=emptypelist[i];
				myvar+='<option value='+obj.emptypelistid+'>'+obj.emptype+'</option>'
				
			}
		myvar+='</select>'	
		
		
	}else if(is_designationlist){
		myvar='<select id="designtion" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;">'
			myvar+='<option value="0">'+"Select A Value"+'</option>'
			for(var i=0;i<designationlist.length;i++){
				var obj=designationlist[i];
				myvar+='<option value='+obj.desgId+'>'+obj.desgname+'</option>'
				
			}
		myvar+='</select>'	
	}else if(is_departmentlist){
		myvar='<select id="department" style="text-align:center; width:95%; color: #222222;margin-bottom: 5px;">'
			myvar+='<option value="0">'+"Select A Value"+'</option>'
			for(var i=0;i<departmentlist.length;i++){
				var obj=departmentlist[i];
				myvar+='<option value='+obj.deptId+'>'+obj.deptName+'</option>'
				
			}
		myvar+='</select>'	
	}
	
	return myvar;
}

function validateEmployeeCreateModal(){
	var is_valid=true;
	//alert("validateEmployeeCreateModal() IS CALLED INSIDE hradminScript.js FILE");
	var empcode=$("#code").val();
	var empname=$("#name").val();
	var permanentaddress=$("#emppermanentaddress").val();
	var presentaddress=$("#emppresentaddress").val();
	var empmobile=$("#empmobile").val();
	var email=$("#email").val();
	var department=$("#department").val();
	var designation=$("#designtion").val();
	var emptype=$("#emptype").val();
	
	var casualLeave=$("#casualLeave").val();
	var sickLeave=$("#sickLeave").val();
	var miscLeave=$("#miscLeave").val();
	var earnedLeave=$("#earnedLeave").val();
	var joiningdate=$("#joiningdate").val();
	var leavingdate=$("#leavingdate").val();
	
	//alert("EMP CODE IS:"+empcode);
	//alert("EMP NAME IS:"+empname);
	$("#department").parent().parent().find("span").remove();
	$("#designtion").parent().parent().find("span").remove();
	$("#emptype").parent().parent().find("span").remove();
	$("#code").parent().parent().find("span").remove();
	$("#name").parent().parent().find("span").remove();
	$("#empmobile").parent().parent().find("span").remove();
	$("#email").parent().parent().find("span").remove();
	$("#emppresentaddress").parent().parent().find("span").remove();
	$("#emppermanentaddress").parent().parent().find("span").remove();
	$("#joiningdate").parent().parent().find("span").remove();
	if(department==0){
		$("#department").parent().parent().append("<span class='error'>This field is required</span>");
		is_valid=false;
	}else if(designation==0){
		$("#designtion").parent().parent().append("<span class='error'>This field is required</span>");
		is_valid=false;
	}else if(emptype==0){
		$("#emptype").parent().parent().append("<span class='error'>This field is required</span>");
		is_valid=false;
	}else if(empcode=='' || empcode==null){
		$("#code").parent().parent().append("<span class='error'>This field is required</span>");
		is_valid=false;
	}else if(empname=='' || empname==null){
		$("#name").parent().parent().append("<span class='error'>This field is required</span>");
		is_valid=false;
	}else if(empmobile=='' || empmobile==null){
		$("#empmobile").parent().parent().append("<span class='error'>This field is required</span>");
		is_valid=false;
	}else if(email=='' || email==null){
		$("#email").parent().parent().append("<span class='error'>This field is required</span>");
		is_valid=false;
	}else if(presentaddress=='' || presentaddress==null){
		$("#emppresentaddress").parent().parent().append("<span class='error'>This field is required</span>");
		is_valid=false;
	}else if(permanentaddress=='' || permanentaddress==null){
		$("#emppermanentaddress").parent().parent().append("<span class='error'>This field is required</span>");
		is_valid=false;
	}else if(joiningdate=='' || joiningdate==null){
		$("#joiningdate").parent().parent().append("<span class='error'>This field is required</span>");
		is_valid=false;
	}
	
	
	
	
	return is_valid;
	
	
}







function getEmployeeTypesById(id) { 
	   var url=BASE_URL + "/hrmgnt/getEmployeeTypesById.htm?storeId="+storeID+"&id="+id;
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



function cancelDesignation() {
	document.getElementById('editalertMsg').innerHTML = '';
}
function editDesignation() {
	/*alert("Hi edit");*/
	document.getElementById('editalertMsg').innerHTML = '';
	var id = document.getElementById('modeditdesignationid').value;
	var name = decodeURIComponent(document.getElementById('editdesignationname').value);
	//var color = decodeURIComponent(document.getElementById('editbgcolorContId').value);
	if (name == '') {
		document.getElementById('editalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(name) /*|| (/[#%?\/\\]/gi).test(color)*/) {
		/*alert("Hello");*/
		document.getElementById('editalertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		/*alert("Hello");*/
		var designationEditPost = {};
		designationEditPost.id = id;
		designationEditPost.name = name;
		/*maneCategoryEditPost.bgColor = color;*/
		designationEditPost.storeId = storeID;
		/*console.log(designationEditPost);*/
		$.ajax({
					url : BASE_URL + "/hrmgnt/editdesignation.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(designationEditPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						/*console.log(response);*/
						closenmenucateditModal();
						if (response == 'Success') {
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertcatdataopModal();
						}
					}
				});

		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/menumgnt/editmenucategory/" + id +
		 * "/" + name + "/" + color + ".htm", function(response) {
		 * closenmenucateditModal(); if(response==success) {
		 * document.getElementById('catdataopmassagecont').innerHTML='Data is
		 * sucessfully edited!'; showalertcatdataopModal(); } else{
		 * document.getElementById('catdataopmassagecont').innerHTML=getLang.datasucNotUpdate;
		 * showalertcatdataopModal(); }
		 * //location.href=BASE_URL+'/menumgnt/viewmenumgnt.htm'; }, null);
		 */
	}
}

function deleteDesignation() {
	/*alert("delete hi");*/
	var id = document.getElementById('moddeleteconfirmdesignationid').value;
	var name = decodeURIComponent(document.getElementById('moddeleteconfirmdesignationname').value);
	//var color = decodeURIComponent(document.getElementById('moddeleteconfirmcatbgcolorContId').value);

	var maneDesignationDeletePost = {};
	maneDesignationDeletePost.id = id;
	maneDesignationDeletePost.name = name;
/*	maneCategoryDeletePost.bgColor = color;*/
	maneDesignationDeletePost.storeId = storeID;
	/*console.log(maneDesignationDeletePost);*/
	$
			.ajax({
				url : BASE_URL + "/hrmgnt/deletedesignation.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(maneDesignationDeletePost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					/*console.log(response);*/
					closenmenucateditModal();
					if (response == 'success') {
						document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucDelete;
						showalertcatdataopModal();
					} else {
						document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotDelete;
						showalertcatdataopModal();
					}
				}
			});
}

function addDesignation() {
	/*alert("add designation function");*/
	document.getElementById('addalertMsg').innerHTML = '';
	var desgName = decodeURIComponent(document.getElementById('adddesignationname').value);
	//var bgColor = decodeURIComponent(document.getElementById('addbgcolorContId').value);
	// var storeID=storeId;
	if (desgName == '' /*|| bgColor == ''*/) {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(desgName)) {
		document.getElementById('addalertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		/*alert("added su");*/
		var DesignationPost = {};
		DesignationPost.name = desgName;
		/*maneCategoryPost.bgColor = bgColor;*/
		DesignationPost.storeId = storeID;
		$.ajax({
					url : BASE_URL + "/hrmgnt/adddesignation.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(DesignationPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						/*console.log(response);*/
						// closenmenucataddModal();
						if (response == 'Success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertcatdataopModal();
						}
					}
				});
	}
}


function cancelDesignation1(){
	$("#adddesignationname").val("");
}

function adddepartment() {
	/*alert("Hi");
	alert("add department function");*/
	document.getElementById('addalertMsg').innerHTML = '';
	var desgName = decodeURIComponent(document.getElementById('adddepartmentname').value);
	//var bgColor = decodeURIComponent(document.getElementById('addbgcolorContId').value);
	// var storeID=storeId;
	if (desgName == '' /*|| bgColor == ''*/) {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(desgName)) {
		document.getElementById('addalertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		/*alert("added su");*/
		var DesignationPost = {};
		DesignationPost.name = desgName;
		/*maneCategoryPost.bgColor = bgColor;*/
		DesignationPost.storeId = storeID;
		
		$.ajax({
					url : BASE_URL + "/hrmgnt/adddepartment.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(DesignationPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'Success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertcatdataopModal();
						}
					}
				});
	}
}


function canceldepartment1(){
	$("#adddepartmentname").val("");
}


function cancelDepartment() {
	document.getElementById('editalertMsg').innerHTML = '';
}
function editDepartment() {
	/*alert("Hi");*/
	document.getElementById('editalertMsg').innerHTML = '';
	var id = document.getElementById('departmenteditid').value;
	var name = decodeURIComponent(document.getElementById('editdepartmentname').value);
	//var color = decodeURIComponent(document.getElementById('editbgcolorContId').value);
	if (name == '') {
		document.getElementById('editalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(name) /*|| (/[#%?\/\\]/gi).test(color)*/) {
		/*alert("Hello");*/
		document.getElementById('editalertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		/*alert("Hello");*/
		var departmentEditPost = {};
		departmentEditPost.id = id;
		departmentEditPost.name = name;
		/*maneCategoryEditPost.bgColor = color;*/
		departmentEditPost.storeId = storeID;
		/*console.log(departmentEditPost);*/
		$.ajax({
					url : BASE_URL + "/hrmgnt/editdepartment.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(departmentEditPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						closenmenucateditModal();
						if (response == 'Success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertcatdataopModal();
						}
					}
				});

		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/menumgnt/editmenucategory/" + id +
		 * "/" + name + "/" + color + ".htm", function(response) {
		 * closenmenucateditModal(); if(response==success) {
		 * document.getElementById('catdataopmassagecont').innerHTML='Data is
		 * sucessfully edited!'; showalertcatdataopModal(); } else{
		 * document.getElementById('catdataopmassagecont').innerHTML=getLang.datasucNotUpdate;
		 * showalertcatdataopModal(); }
		 * //location.href=BASE_URL+'/menumgnt/viewmenumgnt.htm'; }, null);
		 */
	}
}


function deleteDepartment() {
	/*alert("delete hi");*/
	var id = document.getElementById('moddeleteconfirmcatidDeptId').value;
	var name = decodeURIComponent(document.getElementById('moddeleteconfirmcatnameDeptId').value);
	//var color = decodeURIComponent(document.getElementById('moddeleteconfirmcatbgcolorContId').value);

	var maneDepartmentDeletePost = {};
	maneDepartmentDeletePost.id = id;
	maneDepartmentDeletePost.name = name;
/*	maneCategoryDeletePost.bgColor = color;*/
	maneDepartmentDeletePost.storeId = storeID;
	/*console.log(maneDepartmentDeletePost);*/
	$
			.ajax({
				url : BASE_URL + "/hrmgnt/deletedepartment.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(maneDepartmentDeletePost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					closenmenucateditModal();
					if (response == 'success') {
						document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucDelete;
						showalertcatdataopModal();
					} else {
						document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotDelete;
						showalertcatdataopModal();
					}
				}
			});
}


function cancelDutyshift() {
	document.getElementById('editalertMsg').innerHTML = '';
}



function addDutyshift() {
	/*alert("add dutyshift function");*/
	document.getElementById('addalertMsg').innerHTML = '';
	$("#errorstarttime").html("");
	$("#errorendtime").html("");
	$("#errorshiftno").html("");
	$("#errorshiftname").html("");
	var dutyStarttime = decodeURIComponent(document.getElementById('adddutyshiftStarttime').value);
	/*var dutyStarttime1 = dutyStarttime+":00";*/
	/*alert(dutyStarttime);*/
	var dutyEndtime = decodeURIComponent(document.getElementById('adddutyshiftEndtime').value);
	/*var dutyEndtime1 = dutyEndtime+":00";*/
	var dutyShiftno = decodeURIComponent(document.getElementById('adddutyshiftNo').value);
	var dutyShiftname = decodeURIComponent(document.getElementById('adddutyshiftName').value);
	//var bgColor = decodeURIComponent(document.getElementById('addbgcolorContId').value);
	// var storeID=storeId;
	if (dutyStarttime == '' /*|| bgColor == ''*/) {
		/*document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;*/
		$("#errorstarttime").html("This field is required");
	} else if (dutyEndtime=='') {
		$("#errorendtime").html("This field is required");
	} else if (dutyShiftno=='') {
		$("#errorshiftno").html("This field is required");
	} else if (dutyShiftname=='') {
		$("#errorshiftname").html("This field is required");
	} else {
		/*alert("added su");*/
		var DutyshiftPost = {};
		DutyshiftPost.fromTime = dutyStarttime;
		DutyshiftPost.toTime = dutyEndtime;
		DutyshiftPost.shiftingNo = dutyShiftno;
		DutyshiftPost.shiftName = dutyShiftname;
		/*maneCategoryPost.bgColor = bgColor;*/
		DutyshiftPost.storeId = storeID;
		/*console.log(DutyshiftPost);*/
		
		$.ajax({
					url : BASE_URL + "/hrmgnt/adddutyshift.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(DutyshiftPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'Success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertcatdataopModal();
						}
					}
				});
	}
}

function cancelDutyshift1(){
	$("#adddutyshiftStarttime").val("");
	$("#adddutyshiftEndtime").val("");
	$("#adddutyshiftNo").val("");
	$("#adddutyshiftName").val("");
}

function editDutyshift() {
	/*alert("Hi Edit");*/
	/*document.getElementById('editalertMsg').innerHTML = '';*/
	$("#editerrorstarttime").html("");
	$("#editerrorendtime").html("");
	$("#editerrorshiftno").html("");
	$("#editerrorshiftname").html("");
	var editdutyId = document.getElementById('editdutyshiftId').value;
	var editdutyStarttime = document.getElementById('editdutyshiftStarttime').value;
	var editdutyEndtime = document.getElementById('editdutyshiftEndtime').value;
	var editdutyShiftno = document.getElementById('editdutyshiftShiftno').value;
	var editdutyShiftname = document.getElementById('editdutyshiftShiftname').value;
	//var color = decodeURIComponent(document.getElementById('editbgcolorContId').value);
	if (editdutyStarttime == '' /*|| bgColor == ''*/) {
		/*document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;*/
		$("#editerrorstarttime").html("This field is required");
	} else if (editdutyEndtime=='') {
		$("#editerrorendtime").html("This field is required");
	} else if (editdutyShiftno=='') {
		$("#editerrorshiftno").html("This field is required");
	} else if (editdutyShiftname=='') {
		$("#editerrorshiftname").html("This field is required");
	} else {
		/*alert("Hello");*/
		var dutyshiftEditPost = {};
		dutyshiftEditPost.id = editdutyId;
		dutyshiftEditPost.fromTime = editdutyStarttime;
		dutyshiftEditPost.toTime = editdutyEndtime;
		dutyshiftEditPost.shiftingNo = editdutyShiftno;
		dutyshiftEditPost.shiftName = editdutyShiftname;
		
		/*maneCategoryEditPost.bgColor = color;*/
		dutyshiftEditPost.storeId = storeID;
		/*console.log(dutyshiftEditPost);*/
		$.ajax({
					url : BASE_URL + "/hrmgnt/editdutyshift.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(dutyshiftEditPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						closenmenucateditModal();
						if (response == 'Success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertcatdataopModal();
						}
					}
				});

		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/menumgnt/editmenucategory/" + id +
		 * "/" + name + "/" + color + ".htm", function(response) {
		 * closenmenucateditModal(); if(response==success) {
		 * document.getElementById('catdataopmassagecont').innerHTML='Data is
		 * sucessfully edited!'; showalertcatdataopModal(); } else{
		 * document.getElementById('catdataopmassagecont').innerHTML=getLang.datasucNotUpdate;
		 * showalertcatdataopModal(); }
		 * //location.href=BASE_URL+'/menumgnt/viewmenumgnt.htm'; }, null);
		 */
	}
}



function deleteDutyshift() {
	/*alert("delete hi");*/
	var id = document.getElementById('moddeleteconfirmdutyshiftid').value;
	var storeid = decodeURIComponent(document.getElementById('moddeleteconfirmdutyshiftstoreid').value);
	//var color = decodeURIComponent(document.getElementById('moddeleteconfirmcatbgcolorContId').value);

	var maneDutyshifttDeletePost = {};
	maneDutyshifttDeletePost.id = id;
	/*maneDutyshifttDeletePost.name = name;*/
/*	maneCategoryDeletePost.bgColor = color;*/
	maneDutyshifttDeletePost.storeId = storeID;
	/*console.log(maneDutyshifttDeletePost);*/
	$
			.ajax({
				url : BASE_URL + "/hrmgnt/deletedutyshift.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(maneDutyshifttDeletePost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					closenmenucateditModal();
					if (response == 'success') {
						document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucDelete;
						showalertcatdataopModal();
					} else {
						document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotDelete;
						showalertcatdataopModal();
					}
				}
			});
}


   /*Employee Type Function start*/

function addEmployeetype() {
	/*alert("add dutyshift function");*/
	document.getElementById('addalertMsg').innerHTML = '';
	$("#empaddErrortype").html("");
	$("#empaddErrorcasual").html("");
	$("#empaddErrorsick").html("");
	$("#empaddErrormisc").html("");

	var employeetypeType = decodeURIComponent(document.getElementById('addemployeetypeType').value);
	/*alert(employeetypeType);*/
	var employeetypeCasual = decodeURIComponent(document.getElementById('addemployeetypeCasual').value);
	var employeetypeSick = decodeURIComponent(document.getElementById('addemployeetypeSick').value);
	var employeetypeMisc = decodeURIComponent(document.getElementById('addemployeetypeMisc').value);
	
	if (employeetypeType == '' ) {
		$("#empaddErrortype").html("This field is required");
	} else if (employeetypeCasual=='') {
		$("#empaddErrorcasual").html("This field is required");
	} else if (employeetypeSick=='') {
		$("#empaddErrorsick").html("This field is required");
	} else if (employeetypeMisc=='') {
		$("#empaddErrormisc").html("This field is required");
	} else {
		/*alert("added employee type");*/
		var EmployeeTypePost = {};
		EmployeeTypePost.type = employeetypeType;
		EmployeeTypePost.casualLeave = employeetypeCasual;
		EmployeeTypePost.sickLeave = employeetypeSick;
		EmployeeTypePost.miscLeave = employeetypeMisc;
		EmployeeTypePost.storeId = storeID;
		/*console.log(EmployeeTypePost);*/
		
		$.ajax({
					url : BASE_URL + "/hrmgnt/addemployeetype.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(EmployeeTypePost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'Success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertcatdataopModal();
						}
					}
				});
	}
}

function cancelEmployeetype1()
{

	$("#addemployeetypeType").val("");
	$("#addemployeetypeCasual").val("");
	$("#addemployeetypeSick").val("");
	$("#addemployeetypeMisc").val("");
}


function cancelEmployeetype() {
	document.getElementById('editalertMsg').innerHTML = '';
}



function editEmployeetype() {
	/*alert("Edit Employee Type");*/
	/*document.getElementById('editalertMsg').innerHTML = '';*/
	$("#editerrorType").html("");
	$("#editerrorCasual").html("");
	$("#editerrorSick").html("");
	$("#editerrorMisc").html("");
	var editemployeetypeId = document.getElementById('editemployeetypeId').value;
	var editemployeetypeType = document.getElementById('editemployeetypeType').value;
	var editemployeetypeCasual = document.getElementById('editemployeetypeCasual').value;
	var editemployeetypeSick = document.getElementById('editemployeetypeSick').value;
	var editemployeetypeMisc = document.getElementById('editemployeetypeMisc').value;
	//var color = decodeURIComponent(document.getElementById('editbgcolorContId').value);
	if (editemployeetypeType == '' /*|| bgColor == ''*/) {
		/*document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;*/
		$("#editerrorType").html("This field is required");
	} else if (editemployeetypeCasual=='') {
		$("#editerrorCasual").html("This field is required");
	} else if (editemployeetypeSick=='') {
		$("#editerrorSick").html("This field is required");
	} else if (editemployeetypeMisc=='') {
		$("#editerrorMisc").html("This field is required");
	} else {
		/*alert("Hello");*/
		var employeetypeEditPost = {};
		employeetypeEditPost.id = editemployeetypeId;
		employeetypeEditPost.type = editemployeetypeType;
		employeetypeEditPost.casualLeave = editemployeetypeCasual;
		employeetypeEditPost.sickLeave = editemployeetypeSick;
		employeetypeEditPost.miscLeave = editemployeetypeMisc;	
		employeetypeEditPost.storeId = storeID;
		/*console.log(employeetypeEditPost);*/
		$.ajax({
					url : BASE_URL + "/hrmgnt/editemployeetype.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(employeetypeEditPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						closenmenucateditModal();
						if (response == 'Success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertcatdataopModal();
						}
					}
				});

	}
}



function deleteEmployeetype() {
	/*alert("delete hi");*/
	var id = document.getElementById('moddeleteconfirmemployeetypeid').value;
	var storeid = decodeURIComponent(document.getElementById('moddeleteconfirmemployeetypstoreid').value);
	//var color = decodeURIComponent(document.getElementById('moddeleteconfirmcatbgcolorContId').value);

	var maneEmployeetypeDeletePost = {};
	maneEmployeetypeDeletePost.id = id;
	/*maneDutyshifttDeletePost.name = name;*/
/*	maneCategoryDeletePost.bgColor = color;*/
	maneEmployeetypeDeletePost.storeId = storeID;
	/*console.log(maneEmployeetypeDeletePost);*/
	$
			.ajax({
				url : BASE_URL + "/hrmgnt/deleteemployeetype.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(maneEmployeetypeDeletePost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					closenmenucateditModal();
					if (response == 'success') {
						document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucDelete;
						showalertcatdataopModal();
					} else {
						document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotDelete;
						showalertcatdataopModal();
					}
				}
			});
}



