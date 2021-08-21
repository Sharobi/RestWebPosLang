/**
 * 
 */




$(document).on('click',"#checkoutmodalbody>#checkoutmodaltable>#checkoutmodaltablebody>tr>td.input>input", function(){
	
	// var paymentType = $("input[name='payment']:checked").val();
	
	// alert("TRIGGERED");
	var chklength=$("#detailssize").val(); 
	var count=0;
	var modaltablerows=$("#checkoutmodaltablebody").find("tr");
		// alert("MODAL TABLE ROWS LENGTH IS:"+modaltablerows.length);
		for(var i=0;i<modaltablerows.length;i++){
			var tds=$(modaltablerows[i]).find("td");
			for(var j=0;j<tds.length;j++){
				if($(tds[j]).attr("class")=="input"){
					if($(tds[j]).find("input").prop("disabled")==false && $(tds[j]).find("input").prop("checked")==true){
						count++;
					}else if($(tds[j]).find("input").prop("disabled")==true && $(tds[j]).find("input").prop("checked")==true){
						chklength=chklength-1;
					}
					
					
				}
			}
			
		}
		
		if(chklength==count){
		$("#paymentdiv").addClass("hide");
			$("#fullIdDiv>input").prop("checked",true);
			$("#partialIdDiv>input").prop("checked",false);
			$("#partialIdDiv").hide();
			$("#fullIdDiv").show();
		}else if(count>0){
			$("#paymentdiv").removeClass("hide");
			$("#partialIdDiv>input").prop("checked",true);
			$("#fullIdDiv").show();
			$("#partialIdDiv").show();
		}
	
	
	
		

});

$(document).on('click',"#cancelguesttablerow>input",function(){
	$(this).parent().parent().remove();
});

	
function dateformat(str) {
	var dt = parseInt(str.substring(8, 10), 10);
	var mon = parseInt(str.substring(5, 7), 10);
	var yr = parseInt(str.substring(0, 4), 10);
	str = new Date(yr, mon - 1, dt);
	return str;
}


function searchRoomAvailability(fromdate,todate,storeId)
{
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertsearchRoomGreaterModal();
		
		}
	else{
				
		location.href = BASE_URL + "/room/searchroom.htm?fromDate=" +fromdate+"&toDate="+todate;
	}
}

function searchReservedCustAvailability(fromdate,todate,storeId,bookingNo)
{	
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertsearchRoomGreaterModal();
		
		}
	else{
		if(bookingNo == ""){bookingNo = 0;}		
		location.href = BASE_URL + "/customer/reservedcustomerbyperiod.htm?fromDate=" +fromdate+"&toDate="+todate+"&bookingNo="+bookingNo;	
	}
}
function searchCheckedInCust(fromdate,todate,storeId,bookingNo)
{	
	if(dateformat(fromdate)>dateformat(todate))
		{
		showalertsearchRoomGreaterModal();
		location.href = BASE_URL + "/checkout/welcome.htm";
		
		}
	else{
		if(bookingNo == "")	{bookingNo = 0;}
		location.href = BASE_URL + "/checkout/checkedincustomerbyperiod.htm?fromDate=" +fromdate+"&toDate="+todate+"&bookingNo="+bookingNo;	
	}
}

var roomDetails = [];
var totalCapacityCompleted = 0;

function selectPAX()
{
	var inputs = document.getElementsByClassName("room");
	for (var j = 0; j < inputs.length; j++) 
	{
		var roomId=0;
		roomId = inputs[j].id;
		document.getElementById(roomId).style.backgroundColor = '#000';
	}
	roomDetails = [];
	totalCapacityCompleted = 0;
}

function resetSearch()
{

	var fromdate = document.getElementById('fromdateroomsearch').value;
	var todate=fromdate;
	location.href = BASE_URL + "/room/searchroom.htm?fromDate=" +fromdate+"&toDate="+todate;
}

var floorListObj = null;
function selectRoomCategory()
{
	var todayhiddendate=$("#todayhiddendate").val();
	//alert("todayhiddendate DATE IS:"+todayhiddendate);
	var selectedRoomCat = $("#roomtypesearch").val();
	
	
	if(selectedRoomCat != 0)
	{
	
		var inputs = document.getElementsByClassName("room");
		for (var j = 0; j < inputs.length; j++) 
		{
			var roomId=0;
			roomId = inputs[j].id;
			document.getElementById(roomId).style.backgroundColor = '#000';
		}
	roomDetails = [];
	totalCapacityCompleted = 0;
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/room/getrooms.htm", function(response) {	

		document.getElementById('roomlayoutid').innerHTML = "";
var createdrowline = "";

var div1LineStart= "";
var div2LineStart="";

var div3LineStart = "";

var div4aLineStart = "";
var div5aLineStart = "";	

var aLine = "";	

var div5aLineEnd = "";	
var div4aLineEnd = "";

var div4bLineStart = "";

var div5bLine ="";
var div5cLine ="";	
var div5dLine =	"";	

var div4bLineEnd = "";

var brLine = "";
var div3LineEnd = "";

var div2LineEnd = "";
var div1LineEnd= "";
var msg1=document.getElementById('msgAc').value;
var msg2=document.getElementById('msgCap').value;
var msg3=document.getElementById('msgGuest').value;
var msg4=document.getElementById('msgForm').value;
var msg5=document.getElementById('msgTo').value;
var msg6=document.getElementById('msgAdvPay').value;
var msg7=document.getElementById('msgBookDate').value;


var floorList = JSON.parse(response);
var floorRoomExist = 'N';

floorListObj = floorList;

	for(var i=0;i<floorList.length;i++) 
	{
		var mainDivStart = "";
		var h4LineStart = "";
		var aFloorLine = "";
		var h4LineEnd = "";
		var mainDivEnd = "";
		
		if(floorRoomExist=='N')
		{
			for(var j=0;j<floorList[i].room.length;j++) 
			{
				if(floorList[i].room[j].roomTypeId.id == selectedRoomCat)
				{
					mainDivStart = "<div class='col-md-10 col-sm-10' style='margin-top: 15px;margin-bottom: 8px;color:#FFF;height:100px;'>";
					h4LineStart ="<h4 class='panel-title' style='width: inherit;'>";
					if(floorList[i].floor == 0)
					{
						aFloorLine = "<a style='display: block; width: inherit; font:14px; color:black;'> Ground Floor </a>"; 
					}
					else 
					{
						aFloorLine = "<a style='display: block; width: inherit; font:14px; color:black;'>Floor No.-  <b>" + floorList[i].floor + "</b></a>"; 	
					}
					
					h4LineEnd = "</h4>";	
					
					floorRoomExist='Y';
					j=floorList[i].room.length;
				}
			}
		}	
		
		if(floorRoomExist=='Y')
		{
			div1LineStart = "<div class='panel-body' style='overflow-y: auto;'>";	
		}	
		var roomDiv = "";
		
		var countPos = 0;
		for(var l=0;l<floorList[i].room.length;l++) 
		{
			if(floorList[i].room[l].roomTypeId.id == selectedRoomCat)   
			{
				div2LineStart = "<div class='table-holder1' style='position: absolute; left:"+(countPos*150+1)+"px;'>";
		
				countPos++;
				
				if(floorList[i].room[l].isStatus == 'Y' && floorList[i].room[l].isBooked == 'Y' && floorList[i].room[l].isCheckIn == 'N')
				{			
					// div3LineStart = "<div class='postable booked'
					// onclick='javascript:clickOnRoom('"+floorList[i].room[l].id+"','"+floorList[i].room[l].roomNo+"','"+floorList[i].room[l].roomtype.id+"')'>";
					div3LineStart = "<div class='postable booked' onclick='javascript:clickOnBookedRoom("
						+floorList[i].room[l].id
						+","
						+floorList[i].room[l].roomNo
						+",0)'>";	
						div4aLineStart = "<div class='postable room-image-booked'>";
							div5aLineStart = "<div class='table-index' style='text-align:left;margin:0;'>";	
							   var dbDate = floorList[i].room[l].bookingDate;
	                           var rmbookdate = new Date(dbDate).getFullYear()+"-"+(new Date(dbDate).getMonth()+1)+"-"+new Date(dbDate).getDate();
							   
								// aLine = "<a href='#' style='color:
								// black;font-size: 15px;' data-toggle='popover'
								// data-trigger='hover'
								// data-content='"+floorList[i].room[l].roomCapacity
								// +" Persons!'
								// title=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"</a>";
								// aLine = "<a href='#' style='color: black;'
								// title="+floorList[i].room[l].roomCapacity
								// +"<spring:message
								// code='admin.tablenew.jsp.person'
								// text='Persons!' /> data-toggle='popover'
								// data-trigger='hover' data-content=''></a>";
	                           aLine="<a href='#' style='color: black;font-size:15px;' title='"+floorList[i].room[l].roomTypeId.roomType+","+msg1+":"+floorList[i].room[l].roomCategory+","+msg2+":"+floorList[i].room[l].roomCapacity+"\n"+msg3+":"+floorList[i].room[l].custName+"\n"+msg4+":"+floorList[i].room[l].fromDate+"-"+msg5+":"+floorList[i].room[l].toDate+"\n"+msg6+":"+floorList[i].room[l].advPayment+"\n"+msg7+":"+rmbookdate+"'data-toggle='popover' data-trigger='hover' data-content=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"<br>&nbsp;&nbsp;&nbsp;&nbsp;C:&nbsp;"+floorList[i].room[l].roomCapacity+"</a>";
							
							div5aLineEnd = "</div>";	
						div4aLineEnd = "</div>";
						div4bLineStart = "<div class='table-info hide'>";
					
							div5bLine ="<div class='table-subinfo'>'"+floorList[i].room[l].roomCapacity+"'PERSONS/></div>";
							div5cLine ="<div class='table-subinfo'></div>";	
							div5dLine =	"<div class='table-subinfo'></div>";		
							
						div4bLineEnd = "</div>";
						brLine = "<br style='clear: both;'>";
					div3LineEnd = "</div>";
					divCapacity = "";
				}
				else if(floorList[i].room[l].isStatus == 'Y' && floorList[i].room[l].isBooked == 'Y' && floorList[i].room[l].isCheckIn == 'Y')
				{			
					// div3LineStart = "<div class='postable booked'
					// onclick='javascript:clickOnRoom('"+floorList[i].room[l].id+"','"+floorList[i].room[l].roomNo+"','"+floorList[i].room[l].roomtype.id+"')'>";
					
					var todate=floorList[i].room[l].toDate;
					if(todate==todayhiddendate){
						div3LineStart = "<div class='postable booked' onclick='javascript:clickOnBookedRoom("
							+floorList[i].room[l].id
							+","
							+floorList[i].room[l].roomNo
							+",0)'>";	
							div4aLineStart = "<div class='upcomingroomcheckout'>";
								div5aLineStart = "<div class='table-index' style='text-align: left;margin:0;'>";	
							
								   var dbDate = floorList[i].room[l].bookingDate;
		                           var rmbookdate = new Date(dbDate).getFullYear()+"-"+(new Date(dbDate).getMonth()+1)+"-"+new Date(dbDate).getDate();
								    // aLine = "<a href='#' style='color:
									// black;font-size: 15px;' data-toggle='popover'
									// data-trigger='hover'
									// data-content='"+floorList[i].room[l].roomCapacity
									// +" Persons!'
									// title=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"</a>";
									// aLine = "<a href='#' style='color: black;'
									// title="+floorList[i].room[l].roomCapacity
									// +"<spring:message
									// code='admin.tablenew.jsp.person'
									// text='Persons!' /> data-toggle='popover'
									// data-trigger='hover' data-content=''></a>";
		                           
		                           
								     // aLine="<a href='#' style='color: black;font-size:15px;' title='"+floorList[i].room[l].roomTypeId.roomType+","+msg1+":"+floorList[i].room[l].roomCategory+","+msg2+":"+floorList[i].room[l].roomCapacity+"\n"+msg3+":"+floorList[i].room[l].custName+"\n"+msg4+":"+floorList[i].room[l].fromDate+"-"+msg5+":"+floorList[i].room[l].toDate+"\n"+msg6+":"+floorList[i].room[l].advPayment+"\n"+msg7+":"+rmbookdate+"'data-toggle='popover' data-trigger='hover' data-content=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"</a>";
		                           aLine="<a href='#' style='color: black;font-size:15px;' title='"+floorList[i].room[l].roomTypeId.roomType+","+msg1+":"+floorList[i].room[l].roomCategory+","+msg2+":"+floorList[i].room[l].roomCapacity+"\n"+msg3+":"+floorList[i].room[l].custName+"\n"+msg4+":"+floorList[i].room[l].fromDate+"-"+msg5+":"+floorList[i].room[l].toDate+"\n"+msg6+":"+floorList[i].room[l].advPayment+"\n"+msg7+":"+rmbookdate+"'data-toggle='popover' data-trigger='hover' data-content=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"<br>&nbsp;&nbsp;&nbsp;&nbsp;C:&nbsp;"+floorList[i].room[l].roomCapacity+"</a>";
								div5aLineEnd = "</div>";	
							div4aLineEnd = "</div>";
							div4bLineStart = "<div class='table-info hide'>";
						
								div5bLine ="<div class='table-subinfo'>'"+floorList[i].room[l].roomCapacity+"'PERSONS/></div>";
								div5cLine ="<div class='table-subinfo'></div>";	
								div5dLine =	"<div class='table-subinfo'></div>";		
								
							div4bLineEnd = "</div>";					
							brLine = "<br style='clear: both;'>";
						div3LineEnd = "</div>";
						divCapacity = "";
						
						
					}else{
						div3LineStart = "<div class='postable booked' onclick='javascript:clickOnBookedRoom("
							+floorList[i].room[l].id
							+","
							+floorList[i].room[l].roomNo
							+",0)'>";	
							div4aLineStart = "<div class='postable room-image-booked-checked'>";
								div5aLineStart = "<div class='table-index' style='text-align: left;margin:0;'>";	
							
								   var dbDate = floorList[i].room[l].bookingDate;
		                           var rmbookdate = new Date(dbDate).getFullYear()+"-"+(new Date(dbDate).getMonth()+1)+"-"+new Date(dbDate).getDate();
								    // aLine = "<a href='#' style='color:
									// black;font-size: 15px;' data-toggle='popover'
									// data-trigger='hover'
									// data-content='"+floorList[i].room[l].roomCapacity
									// +" Persons!'
									// title=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"</a>";
									// aLine = "<a href='#' style='color: black;'
									// title="+floorList[i].room[l].roomCapacity
									// +"<spring:message
									// code='admin.tablenew.jsp.person'
									// text='Persons!' /> data-toggle='popover'
									// data-trigger='hover' data-content=''></a>";
		                           
		                           
								     // aLine="<a href='#' style='color: black;font-size:15px;' title='"+floorList[i].room[l].roomTypeId.roomType+","+msg1+":"+floorList[i].room[l].roomCategory+","+msg2+":"+floorList[i].room[l].roomCapacity+"\n"+msg3+":"+floorList[i].room[l].custName+"\n"+msg4+":"+floorList[i].room[l].fromDate+"-"+msg5+":"+floorList[i].room[l].toDate+"\n"+msg6+":"+floorList[i].room[l].advPayment+"\n"+msg7+":"+rmbookdate+"'data-toggle='popover' data-trigger='hover' data-content=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"</a>";
		                           aLine="<a href='#' style='color: black;font-size:15px;' title='"+floorList[i].room[l].roomTypeId.roomType+","+msg1+":"+floorList[i].room[l].roomCategory+","+msg2+":"+floorList[i].room[l].roomCapacity+"\n"+msg3+":"+floorList[i].room[l].custName+"\n"+msg4+":"+floorList[i].room[l].fromDate+"-"+msg5+":"+floorList[i].room[l].toDate+"\n"+msg6+":"+floorList[i].room[l].advPayment+"\n"+msg7+":"+rmbookdate+"'data-toggle='popover' data-trigger='hover' data-content=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"<br>&nbsp;&nbsp;&nbsp;&nbsp;C:&nbsp;"+floorList[i].room[l].roomCapacity+"</a>";
								div5aLineEnd = "</div>";	
							div4aLineEnd = "</div>";
							div4bLineStart = "<div class='table-info hide'>";
						
								div5bLine ="<div class='table-subinfo'>'"+floorList[i].room[l].roomCapacity+"'PERSONS/></div>";
								div5cLine ="<div class='table-subinfo'></div>";	
								div5dLine =	"<div class='table-subinfo'></div>";		
								
							div4bLineEnd = "</div>";					
							brLine = "<br style='clear: both;'>";
						div3LineEnd = "</div>";
						divCapacity = "";
						
						
						
					}
					
					
					
				}
				else if(floorList[i].room[l].isStatus == 'Y' && floorList[i].room[l].isBooked == 'N' && floorList[i].room[l].isCheckIn == 'N')
				{

					div3LineStart = "<div class='postable enabled' onclick='javascript:clickOnRoom("
						+floorList[i].room[l].id
						+",&quot;"
						+floorList[i].room[l].roomNo
						+"&quot;,"
						+floorList[i].room[l].roomTypeId.id+")'>";
					
						div4aLineStart = "<div class='postable table-image room' id ='"+floorList[i].room[l].id +"'>";
							div5aLineStart = "<div class='table-index' style='text-align: left;margin:0;'>";	

							
							// aLine = "<a href='#' style='color:
							// black;font-size: 15px;' data-toggle='popover'
							// data-trigger='hover' title='Room Category-
							// "+floorList[i].room[l].roomTypeId.roomType+"'
							// data-content='"+floorList[i].room[l].roomCapacity
							// + "
							// Persons!'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"</a>";
							// aLine = "<a href='#' style='color: black;'
							// title="+floorList[i].room[l].roomCapacity
							// +"<spring:message
							// code='admin.tablenew.jsp.person' text='Persons!'
							// /> data-toggle='popover' data-trigger='hover'
							// data-content=''></a>'";
							
							//aLine="<a href='#' style='color: black;font-size:15px;' title='"+floorList[i].room[l].roomTypeId.roomType+","+msg1+":"+floorList[i].room[l].roomCategory+","+msg2+":"+floorList[i].room[l].roomCapacity+"'data-toggle='popover' data-trigger='hover' data-content=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"</a>";
							aLine="<a href='#' style='color: black;font-size:15px;' title='"+floorList[i].room[l].roomTypeId.roomType+","+msg1+":"+floorList[i].room[l].roomCategory+","+msg2+":"+floorList[i].room[l].roomCapacity+"\n"+msg3+":"+floorList[i].room[l].custName+"\n"+msg4+":"+floorList[i].room[l].fromDate+"-"+msg5+":"+floorList[i].room[l].toDate+"\n"+msg6+":"+floorList[i].room[l].advPayment+"\n"+msg7+":"+rmbookdate+"'data-toggle='popover' data-trigger='hover' data-content=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"<br>&nbsp;&nbsp;&nbsp;&nbsp;C:&nbsp;"+floorList[i].room[l].roomCapacity+"</a>";
							div5aLineEnd = "</div>";	
						div4aLineEnd = "</div>";
						div4bLineStart = "<div class='table-info hide'>";
																																			
							div5bLine =	"<div class='table-subinfo'>'"+floorList[i].room[l].roomCapacity+"'PERSONS/></div>";
							div5cLine =	"<div class='table-subinfo'></div>";	
							div5dLine =	"<div class='table-subinfo'></div>";		
							
						div4bLineEnd = "</div>";	
						brLine = "<br style='clear: both;'>";
					   div3LineEnd = "</div>";
					   // divCapacity = "<div style='color:
						// white;font-size:12px;width:70px;'> Capacity :
						// "+floorList[i].room[l].roomCapacity+"</div>";
					   divCapacity="";
				}				
				else if(floorList[i].room[l].isStatus == 'N' && floorList[i].room[l].isBooked == 'N' && floorList[i].room[l].isCheckIn == 'N')
				{
					    div3LineStart = "<div class='postable disabled'>";
						div4aLineStart = "<div class='postable room-image-disabled'>";
						div5aLineStart = "<div class='table-index' style='text-align: left;margin:0;'>";	
					
								// aLine = "<a href='#' style='color:
								// black;font-size: 15px;' data-toggle='popover'
								// data-trigger='hover'
								// data-content='"+floorList[i].room[l].roomCapacity
								// +" Persons!' title='Disabled Or
								// Booked'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"</a>";
								// aLine = "<a href='#' style='color: black;'
								// title="+floorList[i].room[l].roomCapacity
								// +"<spring:message
								// code='admin.tablenew.jsp.person'
								// text='Persons!' /> data-toggle='popover'
								// data-trigger='hover'
								// data-content='<spring:message
								// code='admin.tablenew.jsp.disableORbooked'
								// text='Disabled Or Booked' />'></a>";
						
							     // aLine="<a href='#' style='color: black;font-size:15px;' title='"+floorList[i].room[l].roomTypeId.roomType+","+msg1+":"+floorList[i].room[l].roomCategory+","+msg2+":"+floorList[i].room[l].roomCapacity+"'data-toggle='popover' data-trigger='hover' data-content=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"</a>";
							
						aLine="<a href='#' style='color: black;font-size:15px;' title='"+floorList[i].room[l].roomTypeId.roomType+","+msg1+":"+floorList[i].room[l].roomCategory+","+msg2+":"+floorList[i].room[l].roomCapacity+"\n"+msg3+":"+floorList[i].room[l].custName+"\n"+msg4+":"+floorList[i].room[l].fromDate+"-"+msg5+":"+floorList[i].room[l].toDate+"\n"+msg6+":"+floorList[i].room[l].advPayment+"\n"+msg7+":"+rmbookdate+"'data-toggle='popover' data-trigger='hover' data-content=''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Room <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+floorList[i].room[l].roomNo+"<br>&nbsp;&nbsp;&nbsp;&nbsp;C:&nbsp;"+floorList[i].room[l].roomCapacity+"</a>";
						div5aLineEnd = "</div>";	
						div4aLineEnd = "</div>";
						div4bLineStart = "<div class='table-info hide'>";
						div5bLine =	"<div class='table-subinfo'>'"+floorList[i].room[l].roomCapacity+"'PERSONS/></div>";
						div5cLine ="<div class='table-subinfo'></div>";	
						div5dLine =	"<div class='table-subinfo'></div>";																			
					
						div4bLineEnd = "</div>";							
						brLine = "<br style='clear: both;'>";
					   div3LineEnd = "</div>";
					   divCapacity = "";
				}
			
			div2LineEnd = "</div>";
			roomDiv += div2LineStart + div3LineStart + 
						div4aLineStart + div5aLineStart +
						aLine + 
						div5aLineEnd + div4aLineEnd + 
						div4bLineStart + 
						div5bLine + div5cLine + div5dLine + 
						div4bLineEnd + brLine +
						div3LineEnd +divCapacity+  div2LineEnd;	
			}
			
		}	
		if(floorRoomExist=='Y')
		{
		div1LineEnd = "</div>";
		mainDivEnd = "</div>";
		}
		createdrowline += mainDivStart + h4LineStart + aFloorLine + h4LineEnd + 
							div1LineStart + roomDiv + div1LineEnd + mainDivEnd;
	
		floorRoomExist='N';
	}
	console.log(createdrowline);
	 $('[data-toggle="popover"]').popover(); 
	document.getElementById('roomlayoutid').innerHTML = createdrowline;
	
	}, null);
	}
	else {
		
		var fromdate = document.getElementById('fromdateroomsearch').value;
		var todate = document.getElementById('todateroomsearch').value;
		location.href = BASE_URL + "/room/getallrooms.htm?fromDate=" +fromdate+"&toDate="+todate;	
	}
}

function successReserve()
{

	var fromdate = document.getElementById('fromdateroomsearch').value;
	var todate = document.getElementById('todateroomsearch').value;
	location.href = BASE_URL + "/room/searchroom.htm?fromDate=" +fromdate+"&toDate="+todate;	
}


function clickOnRoom(roomId, roomNo, roomTypeId)
{ 
	// alert("TRIGGERED CLICK ON ROOM");
	// /alert("ROOM ID IS"+roomId);
	var id="#"+roomId;
	$(id).removeClass("postable table-image room");
	$(id+">div.table-index").addClass("transbox");
	// /alert($(id).html());
	
	var isMatched = 'N';
	$('#newcustomerbtn').css("display", "none");
	if(roomDetails.length>0)
	{
		for(var i=0;i<roomDetails.length;i++)
		{
			// alert('checking '+roomDetails[i].id + " " + roomId);
			if(roomDetails[i].id == roomId)
			{
				totalCapacityCompleted = totalCapacityCompleted - parseInt(roomDetails[i].roomCapacity);
				
				isMatched = 'Y';
			// alert(isMatched);
				var inputs = document.getElementsByClassName("room");
				for (var j = 0; j < inputs.length; j++) {
				  if(inputs[j].id == roomId)
				  {
					  document.getElementById(roomId).style.backgroundColor = '#000';
				  }
				  
				}
				roomDetails.splice(i, 1);
				i=roomDetails.length;
				break;
			}
		}	
	}	
	if(isMatched == 'N')
	{	
	// alert(isMatched);
		var selectedPAX = $("#paxroomsearch").val();
		var selectedRoomCat = $("#roomtypesearch").val();
	
		if(selectedRoomCat == 0)
		{
			var isObjNull ='N';
			if(floorListObj== null )
			{
				isObjNull ='Y';
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/room/getrooms.htm", function(response) {	
				
				var floorList = JSON.parse(response);
				if(floorListObj== null ) 
				{
					floorListObj = [];
					floorListObj = floorList;
				}	
				// console.log(response);
				if(totalCapacityCompleted<=selectedPAX && roomId!=0)
				{				
					for(var i=0;i<floorList.length;i++) 
					{
						for(var j=0;j<floorList[i].room.length;j++) 
						{
							if(floorList[i].room[j].id == roomId)
							{
								if(totalCapacityCompleted < selectedPAX)
								{
									totalCapacityCompleted += parseInt(floorList[i].room[j].roomCapacity);
									roomDetails.push(floorList[i].room[j]);
									
									var inputs = document.getElementsByClassName("room");
									for (var k = 0; k < inputs.length; k++) {
									  if(inputs[k].id == roomId)
									  {
										  document.getElementById(roomId).style.backgroundColor = '#5F9EA0';
									  }
									  
									}
									// alert(selectedRoomCat + " & floorlist
									// null " + roomDetails + "selectedPAX " +
									// selectedPAX + "totalCapacityCompleted " +
									// totalCapacityCompleted);
									// console.log('isMatched N &_& isObjNull Y
									// && selectedRoomCat 0
									// '+totalCapacityCompleted + ' ' +
									// selectedPAX);
								}	
								
								if(totalCapacityCompleted>=selectedPAX)
								{
									// alert('if'+totalCapacityCompleted);
									var fromdate = document.getElementById('fromdateroomsearch').value;
									var today=document.getElementById('hiddateroomsearch').value;
									// alert('if'+fromdate + " " + today);
									
										if(dateformat(fromdate)>dateformat(today))
										{
											// showRoomReserveModal();
											 $("input.onoffswitch-checkbox").attr("disabled", true);
											 openRoomBookingModal();
										}
										else if(dateformat(fromdate)<=dateformat(today))
										{
											// showRoomBookingAlertModal();
											 $("input.onoffswitch-checkbox").removeAttr("disabled");
											 openRoomBookingModal();
										}
									}
								}
						}
					}
				}
				
			}, null);
		}
		if(isObjNull == 'N') {
			
			if(totalCapacityCompleted<=selectedPAX && roomId!=0)
			{
				for(var i=0;i<floorListObj.length;i++) 
				{
					for(var j=0;j<floorListObj[i].room.length;j++) 
					{
						if(floorListObj[i].room[j].id == roomId)
						{
							
							if(totalCapacityCompleted < selectedPAX)
							{
								totalCapacityCompleted += parseInt(floorListObj[i].room[j].roomCapacity);	
								roomDetails.push(floorListObj[i].room[j]);
								
								var inputs = document.getElementsByClassName("room");
								for (var k = 0; k < inputs.length; k++) {
								  if(inputs[k].id == roomId)
								  {
									  document.getElementById(roomId).style.backgroundColor = '#5F9EA0';
								  }
								  
								}
								// alert(selectedRoomCat + " & floorlist not
								// null " + roomDetails + "selectedPAX " +
								// selectedPAX + "totalCapacityCompleted " +
								// totalCapacityCompleted);
								// alert('isMatched N &&&& isObjNull N &&
								// selectedRoomCat 0 '+totalCapacityCompleted +
								// ' ' + selectedPAX);
							}	
							if(totalCapacityCompleted>=selectedPAX)
							{
								var fromdate = document.getElementById('fromdateroomsearch').value;
								var today=document.getElementById('hiddateroomsearch').value;
									
									if(dateformat(fromdate)>dateformat(today))
									{
										// showRoomReserveModal();
										 $("input.onoffswitch-checkbox").attr("disabled", true);
										openRoomBookingModal();
									}
									else if(dateformat(fromdate)<=dateformat(today))
									{
										// showRoomBookingAlertModal();
										 $("input.onoffswitch-checkbox").removeAttr("disabled");
										openRoomBookingModal();
									}
								}
							}
						}
					}
				}			
		}
	}
	else {
		// alert('isMatched N && selectedRoomCat Not 0 '+totalCapacityCompleted
		// + ' ' + selectedPAX);
		if(totalCapacityCompleted<=selectedPAX && roomId!=0)
		{
			for(var i=0;i<floorListObj.length;i++) 
			{
				for(var j=0;j<floorListObj[i].room.length;j++) 
				{
					if(floorListObj[i].room[j].id == roomId)
					{
						if(totalCapacityCompleted < selectedPAX)
						{
							totalCapacityCompleted += parseInt(floorListObj[i].room[j].roomCapacity);	
							roomDetails.push(floorListObj[i].room[j]);
							
							var inputs = document.getElementsByClassName("room");
							for (var k = 0; k < inputs.length; k++) {
							  if(inputs[k].id == roomId)
							  {
								  document.getElementById(roomId).style.backgroundColor = '#5F9EA0';
							  }
							  
							}
							// alert(selectedRoomCat + " & floorlist not null "
							// + roomDetails + "selectedPAX " + selectedPAX +
							// "totalCapacityCompleted " +
							// totalCapacityCompleted);
						}	
						if(totalCapacityCompleted>=selectedPAX)
						{
							var fromdate = document.getElementById('fromdateroomsearch').value;
							var today=document.getElementById('hiddateroomsearch').value;
								
								if(dateformat(fromdate)>dateformat(today))
								{
									// showRoomReserveModal();
									$("input.onoffswitch-checkbox").attr("disabled", true);
									openRoomBookingModal();
								}
								else if(dateformat(fromdate)<=dateformat(today))
								{
								
									// showRoomBookingAlertModal();
									$("input.onoffswitch-checkbox").removeAttr("disabled");
									openRoomBookingModal();
									// /
								}
							}
						}
					}
				}
			}
		}
	}
	
	console.log(JSON.stringify(roomDetails));
}

function reserveRoom()
{
  // alert("Reserve Room");
	
	var id=decodeURIComponent(document
			.getElementById('modroomreservecustIdhidden').value);
	// alert("id:"+id);
	var customername = decodeURIComponent(document
			.getElementById('modroomreservecustName').value);
	var customerPhone = decodeURIComponent(document
			.getElementById('modroomreservecustPhone').value);
	var customerEmail = decodeURIComponent(document
			.getElementById('modroomreservecustEmail').value);
	
	var fromReserveDate = document.getElementById('fromdateroomsearch').value;
	var toReserveDate = document.getElementById('todateroomsearch').value;
	
	if(customername == '' || customerPhone == '')
	{
		document.getElementById('modroomreserveCustalertMsg').innerHTML = 'Name & Phone Number Mandatory!';
		
	} else {
		$("#reserveBtn").addClass('disabled');
		var roomBookingInfo = {};
		var customer = {};
		
		if(id ==''){
			// alert("null:");
			customer.id=0;
			}
		
		 if(id !='') {
			 // alert("not null:"+id);
			 customer.id=id;
		 }
		
		 
		customer.name=customername;
		customer.phone=customerPhone;
		customer.email=customerEmail;
		customer.store_id=storeID;
		customer.deleteflag='N';
		
		roomBookingInfo.reserveId = 0;
		roomBookingInfo.customer = customer;
		roomBookingInfo.roomid=roomDetails;
		roomBookingInfo.fromDate=fromReserveDate;
		roomBookingInfo.toDate=toReserveDate;
		roomBookingInfo.hotelId=storeID;
		
		// alert(roomBookingInfo);
		$
				.ajax({
					url : BASE_URL + "/room/reserveroom.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(roomBookingInfo),
					success : function(response) {
						console.log(response);
						$("#reserveBtn").removeClass('disabled');
						if (response === '0') {
							// alert("success");
							document.getElementById('roomreservealertopmassagecont').innerHTML = 'Reservation Not Successful !';
							$('#modRoomReserveCustDetailsModal').modal('hide');
							alertRoomReserveDataopModal();
						} else {							
							document.getElementById('roomreservedataopmassagecont').innerHTML = 'Reservation Successful. Generated ReserveId: '+ response;
							$('#modRoomReserveCustDetailsModal').modal('hide');
							showsuccessreserveopModal();
						}
					}
				});
	}
}

function cancelReserve() {
  // debugger
	// var inputs = document.getElementsByClassName("room");
  var inputs = document.getElementsByName("rooms");
	console.log("INPUTS IS",inputs);
	for (var j = 0; j < inputs.length; j++) 
	{
		var roomId=0;
		roomId = inputs[j].id;
		// alert("ROOM ID IS:"+roomId);
		var id="#"+roomId;
		$(id+">div.table-index").removeClass("transbox");
		$(id).addClass("postable table-image room");
	// alert(roomId + " " + inputs[j].id);
		document.getElementById(roomId).style.backgroundColor = '#000';
		
	}
	roomDetails = [];
	totalCapacityCompleted = 0;
	
	document.getElementById('modroomreserveCustalertMsg').innerHTML ="";
	document.getElementById("modroomreservecustName").value = "";
	document.getElementById("modroomreservecustPhone").value = "";
	document.getElementById("modroomreservecustEmail").value = "";

}

function cancelPayment()
{
	isCheckOut= "NO";
	document.getElementById("cashtenderAmt").value=" ";
	
}



function openReservation()
{
	$('#processSelectionModal').modal('hide');
	showRoomReserveModal(); 
}

function openDirectBooking()
{
 var directBooking='Y';
 
 var fromReserveDate = document.getElementById('fromdateroomsearch').value;
 var toReserveDate = document.getElementById('todateroomsearch').value;
 
 var roombooking = {};
 var roomBookingInfo = {};
 var customer = {};
 
 
 roomBookingInfo.reserveId = 0;
 roomBookingInfo.customer = customer;
 roomBookingInfo.roomid=roomDetails;
 roomBookingInfo.fromDate=fromReserveDate;
 roomBookingInfo.toDate=toReserveDate;
 roomBookingInfo.hotelId=storeID;
 
 roombooking.roombookinginfo = roomBookingInfo;
 
 $.ajax({
  url : BASE_URL + '/customer/directbooking.htm',
  type : 'POST',
  contentType : 'application/json;charset=utf-8',
  data : JSON.stringify(roombooking),
  success : function(response, JSON_UNESCAPED_UNICODE) {
   if (response == 'success' || response == 'SUCCESS') {
    location.href = BASE_URL + "/customer/welcomedirectbooking.htm";
   } 
  }

 });
}

function CancelReserveId()
{
	var roombookingobj={};
	var reserveId = document
	   .getElementById('hiddencustdataopmassagecont').value;
	
	var cancelRemarks="";
	if(printReason=='Y'){
		cancelRemarks=$("#cancelremarks").val();
	}
	
	
	
	// alert("scghsdgs" + reserveId);
	roombookingobj.id=reserveId;
	// roombookingobj.hotelId=storeID;
	roombookingobj.cancelRemarks=cancelRemarks;
	 $.ajax({
			url : BASE_URL + "/customer/cancelreseveCustomer.htm",
			type : 'POST',
			async:false,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(roombookingobj),
			success : function(response) {
				showalertcatdataopModal();
				if (response == 'success') {
					
					document.getElementById('catdataopmassagecont').innerHTML = "Room Booking Is Cancelled Successfully.";
					
				}
				else{
					document.getElementById('catdataopmassagecont').innerHTML =  "Error!! Room Booking Is Not Cancelled Successfully";
				}
				// obj=JSON.parse(response);
				/*
				 * if(obj.is_success){ var msg="Succesfully saved the record";
				 * $("#alertmodalbody").html(msg);
				 * $("#alertmessagemodal").modal("show"); }
				 */
			},
			error:function(error){
				console.log("ERROR IN hotelBaseScript.js FILE TO CANCEL ROOM BOOKING IS:");
				console.log(error);
			}
		});		 
	
	
	/*
	 * var ajaxCallObject = new CustomBrowserXMLObject();
	 * ajaxCallObject.callAjax(BASE_URL + "/customer/cancelreseveCustomer/" +
	 * reserveId + ".htm", function(response){ showalertcatdataopModal(); if
	 * (response == 'success') {
	 * 
	 * document.getElementById('catdataopmassagecont').innerHTML = "Room Booking
	 * Is Cancelled Successfully."; } else{
	 * document.getElementById('catdataopmassagecont').innerHTML = "Error!! Room
	 * Booking Is Not Cancelled Successfully"; }
	 * 
	 * });
	 */
}

function showCustomerBookingForm(directBooking)
{
	
	if(directBooking!='N')
	{
		showCheckInRoomModal(0);
	}
}

function showBookingSuccess(bookingId)
{
	
	if(bookingId!='N')
	{
		 if (bookingId === '0') {
// //alert("success");
				document.getElementById('roombookalertopmassagecont').innerHTML = 'Check-In Not Successful !';
				$('#modRoomCheckInCustDetailsModal').modal('hide');
				alertRoomBookDataopModal();
			} else {							
				document.getElementById('roomBookdataopmassagecont').innerHTML = 'Check-In Successful. Generated BookingId: '+ bookingId;
				$('#modRoomCheckInCustDetailsModal').modal('hide');
				showsuccessbookopModal();
			}
	}
}

function advancePayment(amount)
{
	var bookingId = 0;
	var customerId = document.getElementById('customerid').value; 
	var reserveId = document.getElementById('hiddenadvpaycustdataopmassagecont').value;// cashtenderAmt...cashamttopaycontId
	var totalAmt = document.getElementById('cashtotamtcontId').innerHTML;
	var amttopay=document.getElementById('cashamttopaycontId').innerHTML;
	var tenderamt=document.getElementById('cashtenderAmt').value;
	var paymentMode = document.getElementById('onlineselpaymenttype').innerHTML;
	var paymentTypeId = document.getElementById('paytypeid').value;
	var cardLastDigits = document.getElementById('cardlastfourDigit').value;
	var discamt = document.getElementById('discamt').value;
	var taxamt = document.getElementById('taxamount').value;
	var grossAmt = document.getElementById('grossamount').value;
	var bookingNo = document.getElementById('cashmodBookingNoCont').innerHTML;
	var greaterValue=0;
	var is_receipt_print=$("#advancepaymentreceiptcheckbox").prop("checked");
	//alert("is_receipt_print:"+is_receipt_print);
	if(amttopay== totalAmt){
		greaterValue=totalAmt;
	}
	else if(amttopay== 0.0){
		greaterValue=amttopay;
	}
	else{
		greaterValue = amttopay;       // totalAmt >= amttopay ? totalAmt :
										// amttopay;
	}
	
	var roomBookingPayment = {};
	/* roomBookingPayment.reserveId =reserveId; */
	roomBookingPayment.booking_id = reserveId;
	roomBookingPayment.tenderamount = amount;
	roomBookingPayment.paymentMode = paymentMode;
	roomBookingPayment.discAmt=discamt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
	roomBookingPayment.taxVatAmt=taxamt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
	roomBookingPayment.grossAmt=grossAmt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
	if(paymentTypeId == 2)
	  roomBookingPayment.cardLastFourDigits = cardLastDigits;
	else 
      roomBookingPayment.cardLastFourDigits = "xxxx";
	
	if(Number(tenderamt)<= Number(greaterValue))
		{
		
		if(is_Acc=="Y")
		{
		// getvendorledger_sale($('#debitor_group_codef').val(),0,customerId,3);//
		// for sunndry debitor
		var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
		var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
		var round_ledger_id = parseInt($('#round_ledger_idf').val());
		var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
		var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
	    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
	    var card_ledger_id=parseInt($('#card_ledger_idf').val());
	     
	     if(sale_ledger_id<=0 || duties_ledger_id<= 0 || round_ledger_id<=0 || discount_ledger_id<=0 || debitor_cash_ledger_id<=0 || card_ledger_id<=0) {
			   document.getElementById('paycashalertMsg').innerHTML = "ledger missing";
				return;
			 }else{
			document.getElementById('paycashalertMsg').innerHTML = "";	 
			roomBookingPayment.duties_ledger_id=duties_ledger_id;
			/* roomBookingPayment.round_ledger_id=round_ledger_id; */
			roomBookingPayment.sale_ledger_id=sale_ledger_id;
			
			roomBookingPayment.discount_ledger_id=discount_ledger_id;
			if(paymentTypeId == 1){
			roomBookingPayment.debitor_cash_ledger_id=debitor_cash_ledger_id;
			}else{
				roomBookingPayment.card_ledger_id=card_ledger_id;
			}
			/* roomBookingPayment.service_charge_ledger_id=service_charge_ledger_id; */
			
				
			 }
		}
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjaxPost(BASE_URL + "/customer/advancePayment.htm", roomBookingPayment, function(response) {
		   try {
					if (response == 'success') {
						document.getElementById('catdataopmassagecont').innerHTML = 'Advance Payment Successfully done. Added to Booking Number ' + bookingNo;
						$('#cashModal').modal('hide');
						//showalertcatdataopModal();
						if(is_receipt_print==true){
							print80mmbillreceipt();
							
						}
						
				}
				else
				{
					document.getElementById('catdataopmassagecont').innerHTML =  "Advance Payment Unsuccessful. Please try again!";
					$('#cashModal').modal('hide');
					showalertcatdataopModal();
				}
				
			} catch (e) {
				alert(e);
			}
		
           }, null);
		
		
	}else if(tenderamt == 0)
		{
		document.getElementById('paycashalertMsg').innerHTML='Tender Amount should not be empty';
		}
	else
		{
		document.getElementById('paycashalertMsg').innerHTML='Tender Amount should be less than or equal to Amount to pay';

		}
	
}

function print80mmbillreceipt(){
	//alert("print80mmbillreceipt() FUNCTION IS CALLED");
	$("#custom80mmtablebodyprint").find("tr").remove();
	var bookingId=$("#cashmodReserveCont").html();
	//alert("BOOKING ID FOR PRINTING RECEIPT IN print80mmbillreceipt() FUNCTION  IS:"+bookingId);
	 var jsonArr=getBillDetailsByBookingNumber(bookingId);
	 var bookedRooms="";
	 var bookedRoomsArray=[];
	 var bold="<b id='boldbookingnumber'>"+jsonArr[0].bookingNo+"</b>";
	 $("#bookingNumberSpan").html(bold);
	 for(var i=0;i<jsonArr.length;i++){
		 var obj=jsonArr[i];
		 var roombookingdetails=obj.bookingDetail;
		 var paymentdetails=obj.payment;
		 var lastpaymentobj=paymentdetails[paymentdetails.length-1];
		 var netamount=lastpaymentobj.amount;
		 var dueamount=lastpaymentobj.amt_to_pay;
		 //var netpaidamount=[lastpaymentobj.amount]-[lastpaymentobj.amt_to_pay];
		 var netpaidamount=$("#cashtenderAmt").val();
		 if(Number.isInteger(netamount)==true){
			 netamount=netamount+".00";
		 }
		 if(Number.isInteger(dueamount)==true){
			 dueamount=dueamount+".00";
		 }
		 if(Number.isInteger(netpaidamount)==true){
			 netpaidamount=netpaidamount+".00";
		 }
		 
		 $("#netamountspan").html("<b>"+netamount+"</b>");
		 $("#dueamountspan").html("<b>"+dueamount+"</b>");
		 $("#netpaidamountspan").html("<b>"+netpaidamount+"</b>");
		 
		 var bookingId = obj.id;
		    var bookingDate=obj.bookingDate;
		    bookingDate=moment(bookingDate).format("YYYY-MM-DD");
			var bookingINumber = obj.bookingNo;
			var customerName = obj.custId.name;
			var customerAddr = obj.custId.address;
			var customerPhNo = obj.custId.contactNo;
			var customerEmail = obj.custId.emailId;
			var custgstNo=obj.custId.cust_vat_reg_no;
			var state=obj.custId.state;
			var checkInDate = obj.checkInDate;
			checkInDate=moment(checkInDate).format("YYYY-MM-DD");
			var checkOutDate = obj.checkoutDate;
			checkOutDate=moment(checkOutDate).format("YYYY-MM-DD");
			var pax = obj.noOfPersons;
			var checkinTimeId=obj.checkinTimeId;
			var services = obj.bookingServices;
			var mydate = new Date(obj.bookingDate);
			
			$("#custnamespan").html("<b>"+customerName+"</b>");
			$("#custphonespan").html("<b>"+customerPhNo+"</b>");
			var tr="";
			tr=tr+"<tr>"
			tr=tr+"<td>"+customerName+"</td>"
			tr=tr+"<td>"+customerPhNo+"</td>"
			/*tr=tr+"<td>"+customerAddr+"</td>"
			tr=tr+"<td>"+bookingINumber+"</td>"
			tr=tr+"<td>"+bookingDate+"</td>"
			tr=tr+"<td>"+pax+"</td>"
			tr=tr+"<td>"+checkInDate+"</td>"
			tr=tr+"<td>"+checkinTimeId+"</td>"*/
			tr=tr+"</tr>"
			//$("#custom80mmtablebodyprint").append(tr);
			$("#custom80mmtablebodyprint").removeClass("hide"); 
		    for(var j=0;j<roombookingdetails.length;j++){
		    	var obj1=roombookingdetails[j];
		    	var roomNumber=obj1.roomId.roomNo;
		    	bookedRoomsArray.push(roomNumber)
		    }
		 
		    bookedRoomsArray.filter(function(o){
		    	if(bookedRooms==""){
		    		bookedRooms=o;
		    	}else{
		    		bookedRooms=bookedRooms+","+o
		    	}
		    	
		    	
		    });
		    var boldnos="<b id='boldbookedroomsarray'>"+bookedRooms+"</b>";
		    $("#roomsbookedspan").append(boldnos);
			
		 
	 }
	 //$("#roomsbookedParagraph").append(bookedRooms);
		var divToPrint = document.getElementById('printreceipt80mm');
		 var newWin = window.open("");
		 newWin.document.write(divToPrint.outerHTML);
		 newWin.focus();
		 newWin.print();
		 newWin.close();
	
	
}


function setCustomerDetails(id,customerId)
{
	 var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/customer/getCustomerDetailsById/" + customerId
				+ ".htm", function(response){
			
			 var customerDetails = JSON.parse(response);
			 var dob;
			 
			 if(customerDetails.dob != undefined){
				 var mydate = new Date(customerDetails.dob);
				 var date = mydate.getDate();
				 var month = mydate.getMonth();
				 var year = mydate.getFullYear();
				 
				 if(month < 10){month = "0"+month;}
				 if(date < 10){date = "0"+date;}
				 dob = year + "-" + month + "-" + date;
			 }else{
				 dob = "";
			 }
			$("#modroombookreserveIdhidden").val(id);
			$("#modroombookcustIdhidden").val(customerDetails.id);
			$("#modroombookcustName").val(customerDetails.name);
		    $("#modroombookcustAddress").val(customerDetails.address);
			$("#modroombookcustPhone").val(customerDetails.contactNo);
		    $("#modroombookcustEmail").val(customerDetails.emailId); 
			$("#modroombookuniqueIdType").val(customerDetails.uniqueidType);
			$("#modroombookuniqueId").val(customerDetails.uniqueidNo);
			$("#modroombookcustGender").val(customerDetails.gender);
			$("#modroombookcustdob").val(dob);
			$("#modroombookcuststate").val(customerDetails.state);
			$("#modroombookcusthouseno").val(customerDetails.house_no);
		    $("#modroombookcuststreet").val(customerDetails.street);
			$("#modroombookcustLocation").val(customerDetails.location);
			$("#gstno").val(customerDetails.cust_vat_reg_no);
			
			
				});
}

function openCreditCustomerModal(bookingId,bookingNo,custIdObject){
	//alert("BOOKING NUMBER IS:"+bookingNo);
	//alert("BOOKING ID IS:"+bookingId);
	//alert(custIdObject);
	$("#converttocreditcustomerbutton").parent().find("span").remove();
	var dueamount="";
	var netamount="";
	var custobjstring=JSON.stringify(custIdObject);
	var custobj=JSON.parse(custobjstring);
	var jsonArr=getBillDetailsByBookingNumber(bookingId);
	 for(var i=0;i<jsonArr.length;i++){
		 var obj=jsonArr[i];
		 var roombookingdetails=obj.bookingDetail;
		 var paymentdetails=obj.payment;
		 var lastpaymentobj=paymentdetails[paymentdetails.length-1];
		  netamount=lastpaymentobj.amount;
		  dueamount=lastpaymentobj.amt_to_pay;
		 
		 if(Number.isInteger(netamount)==true){
			 netamount=netamount+".00";
		 }
		 if(Number.isInteger(dueamount)==true){
			 dueamount=dueamount+".00";
		 }
		
		 
		 
	 }
	//console.log("CUSTOMER OBJ IS:")
	//console.log(custobj);
	//alert(custobj.name);
	 $("#netamountForCreditCustomerModal").val(netamount);
	 $("#dueamountForCreditCustomerModal").val(dueamount);
	$("#bookingnumberspan").text(bookingNo);
	$("#bookingIdForCreditCustomerModal").val(bookingId);
	$("#bookingNumberForCreditCustomerModal").val(bookingNo);
	$("#customerIdForCreditCustomerModal").val(custobj.id);
	if(custobj.creditCustomer=='Y'){
		//alert("HIT ");
		$("#converttocreditbookingbutton").removeClass("hide");
		$("#converttocreditcustomerbutton").addClass("hide");
		
	}else{
		//alert("ELSE IF creditCustomer==N");
		$("#converttocreditbookingbutton").addClass("hide");
		$("#converttocreditcustomerbutton").removeClass("hide");
	}
	$("#customerIdJsonObjectForCreditCustomerModal").val(custobjstring);
	$("#addcreditcustomermodal").modal("show");
	
	
}
function convertToCreditCustomer(){
	var custobjstring=$("#customerIdJsonObjectForCreditCustomerModal").val();
	var custobj=JSON.parse(custobjstring);
	var bookingId=$("#bookingIdForCreditCustomerModal").val();
	var bookingNo=$("#bookingNumberForCreditCustomerModal").val();
	
	var res=convertToCreditCustomerAjax(custobj);
	 
	if(res.is_success){
		var msg="Succesufully converted to Credit Customer"
		//$("#alertmodalbody").html(msg);
        //$("#alertmessagemodal").modal("show");
			
			//creditBookingPayment(custobj);
			$("#converttocreditbookingbutton").removeClass("hide");
		   $("#converttocreditcustomerbutton").addClass("hide");
		   var design="<span class='error'>"+msg+"</span>";
		   $("#converttocreditcustomerbutton").parent().append(design);
        
	}else{
		var msg="Failed To convert to Credit Customer"
		 var design="<span class='error'>"+msg+"</span>";
		   $("#converttocreditcustomerbutton").parent().append(design);
	}
	
	
}

function convertToCreditBooking(){
	var custobjstring=$("#customerIdJsonObjectForCreditCustomerModal").val();
	var custobj=JSON.parse(custobjstring);
	var bookingId=$("#bookingIdForCreditCustomerModal").val();
	var bookingNo=$("#bookingNumberForCreditCustomerModal").val();
	var response=creditBookingPayment(custobj);
	if (response == 'success') {
		convertToCreditBookingAjax(bookingId,bookingNo,custobj);
	}
	//convertToCreditBookingAjax(bookingId,bookingNo,custobj);
}
function convertToCreditBookingAjax(bookingId,bookingNo,custobj){
	var url=BASE_URL + "/storecustomermgnt/convertToCreditBooking.htm";
	var RoomBooking={};
	RoomBooking.id=bookingId;
	RoomBooking.hotelId=storeID;
	var msg="";
	
	$.ajax({
		url :url,
		type : 'POST',
		async:false,
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(RoomBooking),
		success : function(response) {
			obj=JSON.parse(response);
			if(obj.is_success){
				msg="Succesfully Converted to Credit Booking"
			}else{
				msg="Failed To Convert to Credit Booking"
			}
			$("#alertmodalbody").html(msg);
	        $("#alertmessagemodal").modal("show");
		},
		error:function(error){
			console.log("ERROR IN hotelBaseScript.js FILE FOR CONVERTING TO CREDIT BOOKING IS:");
			console.log(error);
		}
	});
	
}
function creditBookingPayment(custobj){
	
	/*var reserveId = document.getElementById('hiddenadvpaycustdataopmassagecont').value;*/
	var res="";
	var url=BASE_URL + "/customer/advancePayment.htm";
	var netAmt = $("#netamountForCreditCustomerModal").val();
	var amttopay=$("#dueamountForCreditCustomerModal").val();
	var tenderamt="00.00";
	var paymentMode = "nopay";
	var paymentTypeId=1;
	var bookingId=$("#bookingIdForCreditCustomerModal").val();
	var bookingNo=$("#bookingNumberForCreditCustomerModal").val();
	
	var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
	var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
	var round_ledger_id = parseInt($('#round_ledger_idf').val());
	var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
	var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
    var card_ledger_id=parseInt($('#card_ledger_idf').val());
    
	var roomBookingPayment = {};
	roomBookingPayment.booking_id = bookingId;
	roomBookingPayment.tenderamount =tenderamt;
	roomBookingPayment.paymentMode =paymentMode;
	/*if(sale_ledger_id<=0 || duties_ledger_id<= 0 || round_ledger_id<=0 || discount_ledger_id<=0 || debitor_cash_ledger_id<=0 || card_ledger_id<=0) {*/
	if(is_Acc=="Y")
	{
		if(sale_ledger_id<=0 || duties_ledger_id<= 0 || round_ledger_id<=0 || discount_ledger_id<=0 || debitor_cash_ledger_id<=0 || card_ledger_id<=0) {
			
			$("#errormessageforcreditcustomermodal").html("ledger missing");
			return;
		 }else{
			 $("#errormessageforcreditcustomermodal").html("");	 
		roomBookingPayment.duties_ledger_id=duties_ledger_id;
		 roomBookingPayment.round_ledger_id=round_ledger_id; 
		roomBookingPayment.sale_ledger_id=sale_ledger_id;
		
		roomBookingPayment.discount_ledger_id=discount_ledger_id;
		if(paymentTypeId == 1){
		roomBookingPayment.debitor_cash_ledger_id=debitor_cash_ledger_id;
		}else{
			roomBookingPayment.card_ledger_id=card_ledger_id;
		}
		roomBookingPayment.service_charge_ledger_id=service_charge_ledger_id; 
		
			
		 }
			
			
		}
		
	

	
	
	$.ajax({
		url :url,
		type : 'POST',
		async:false,
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(roomBookingPayment),
		success : function(response) {
			
			if (response == 'success') {
				
				res=response;
				
			}else{
				
				console.log("Error In creditBookingPayment(custobj) Function .creditBookingPayement is failed in hotelBaseScript.js File")
				$("#errormessageforcreditcustomermodal").html("Failed to convert to Credit Booking Customer");
			}
			
			
		},
		error:function(error){
			console.log("ERROR IN hotelBaseScript.js FILE FOR creditBookingPayment(custobj) Function IS:");
			console.log(error);
		}
	});
	
	
	
	
	
	return res;
	
	
	
	}
	
	
	
	
	
	
	
	
	






function convertToCreditCustomerAjax(custobj){
	var res=null;
	var url=BASE_URL + "/storecustomermgnt/convertToCreditCustomer.htm";
	$.ajax({
		url :url,
		type : 'GET',
		headers: {"storecustomer":JSON.stringify(custobj),"storeId": storeID},
		contentType : 'application/json;charset=utf-8',
		async:false,
		success : function(response) {
			res=JSON.parse(response);
			console.log("RES convertToCreditCustomerAjax() FUNCTION  IS:");
			console.log(res);
		},
		error:function(error){
			console.log("ERROR IN hotelBaseScript.js FILE FOR convertToCreditCustomerAjax() FUNCTION IS:");
			console.log(error);
		}
	});
	return res;
	
}
function createCheckIn() {
	var bookingid = document.getElementById('modroombookreserveIdhidden').value;
	var gstNo=$("#gstno").val();
	var custId = 0;
	var customerName = null;
	var customerPhone = null;
	var customerEmail = null;
	var customerGender = null;
	var dob = null;
	var custAddress = null;
	var houseno = null;
	var streetno = null;
	var location = null;
	var state = null;
	var idtype = 0;
	var idno = null;
	var id=document.getElementById("modroombookcustIdhidden").value;
	if(id != '') {
		 custId=id;
		 
	 }
	customerPhone = document.getElementById("modroombookcustPhone").value;
	customerName = document.getElementById("modroombookcustName").value;	
	customerEmail = document.getElementById("modroombookcustEmail").value;
	customerGender = document.getElementById("modroombookcustGender").value
	dob = decodeURIComponent(document.getElementById('modroombookcustdob').value);
	custAddress = decodeURIComponent(document.getElementById('modroombookcustAddress').value);
	houseno = decodeURIComponent(document.getElementById('modroombookcusthouseno').value);
	streetno = decodeURIComponent(document.getElementById('modroombookcuststreet').value);
	location = decodeURIComponent(document.getElementById('modroombookcustLocation').value);
	state=decodeURIComponent(document.getElementById('modroombookcuststate').value);
    idtype=decodeURIComponent(document.getElementById('modroombookuniqueIdType').value);
    idno=decodeURIComponent(document.getElementById('modroombookuniqueId').value);
    	
	if(customerPhone==null)
	{
		customerPhone='';
	}
	if(customerName==null)
	{
		customerName='';
	}
	if(idtype==0)
	{
		idtype='';
	}
	if(idno==null)
	{
		idno='';
	}
	
	if(bookingid!=0)
		{
		if(customerName == '' || customerPhone == '' || idtype == '' || idno == '')
		{
			document.getElementById('modroombookCustalertMsg').innerHTML = 'Name ,Phone Number ,Id Type & Id No. Mandatory!';
			
		}else {
			document.getElementById('modroombookCustalertMsg').innerHTML = "";
			$("#checkIn").addClass('disabled'); 
			 var storeCustomer = {};
			 storeCustomer.id=$("#modroombookcustIdhidden").val();;
			 storeCustomer.name = $("#modroombookcustName").val();
			 storeCustomer.address =$("#modroombookcustAddress").val();
			 storeCustomer.contactNo = $("#modroombookcustPhone").val();
			 storeCustomer.emailId = $("#modroombookcustEmail").val(); 
			 storeCustomer.creditCustomer = "N";
			 storeCustomer.creditLimit = 0;
			 storeCustomer.cust_vat_reg_no=gstNo;
			 var idtype = $("#modroombookuniqueIdType").val();
			 if(idtype == ""){idtype = 0;}
			 storeCustomer.uniqueidType = idtype;
			 storeCustomer.uniqueidNo = $("#modroombookuniqueId").val();
			 storeCustomer.gender=$("#modroombookcustGender").val();
			 storeCustomer.dob=$("#modroombookcustdob").val();
			 storeCustomer.state=$("#modroombookcuststate").val();
			 storeCustomer.house_no=$("#modroombookcusthouseno").val();
			 storeCustomer.street=$("#modroombookcuststreet").val();
			 storeCustomer.location=$("#modroombookcustLocation").val();
			 console.log(JSON.stringify(storeCustomer));
			 $.ajax({
					url : BASE_URL + "/customer/addroomcustomer.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(storeCustomer),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						var resp = JSON.parse(response);
						// alert(resp.id);
						if(resp.id==0){
							document.getElementById('modroombookCustalertMsg').innerHTML = "Error!!"+ resp.type;
						}else{
								 $("#modroombookcustId").val(resp.id);
								 checkIn(bookingid);						
						}
					   
					    
					 }
				  });
			}
		}
	else
		{
		if(customerName == '' || customerPhone == '')
		{
			document.getElementById('modroombookCustalertMsg').innerHTML = 'Name ,Phone Number Mandatory!';
			
		}else {
			document.getElementById('modroombookCustalertMsg').innerHTML = "";
			$("#checkIn").addClass('disabled'); 
			 var storeCustomer = {};
			 storeCustomer.id=$("#modroombookcustIdhidden").val();;
			 storeCustomer.name = $("#modroombookcustName").val();
			 storeCustomer.address =$("#modroombookcustAddress").val();
			 storeCustomer.contactNo = $("#modroombookcustPhone").val();
			 storeCustomer.emailId = $("#modroombookcustEmail").val(); 
			 storeCustomer.creditCustomer = "N";
			 storeCustomer.creditLimit = 0;
			 storeCustomer.cust_vat_reg_no=gstNo;
			 var idtype = $("#modroombookuniqueIdType").val();
			 if(idtype == ""){idtype = 0;}
			 storeCustomer.uniqueidType = idtype;
			 storeCustomer.uniqueidNo = $("#modroombookuniqueId").val();
			 storeCustomer.gender=$("#modroombookcustGender").val();
			 storeCustomer.dob=$("#modroombookcustdob").val();
			 storeCustomer.state=$("#modroombookcuststate").val();
			 storeCustomer.house_no=$("#modroombookcusthouseno").val();
			 storeCustomer.street=$("#modroombookcuststreet").val();
			 storeCustomer.location=$("#modroombookcustLocation").val();
			 console.log(JSON.stringify(storeCustomer));
			 $.ajax({
					url : BASE_URL + "/customer/addroomcustomer.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(storeCustomer),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						var resp = JSON.parse(response);
						// alert(resp.id);
						if(resp.id==0){
							document.getElementById('modroombookCustalertMsg').innerHTML = "Error!!"+ resp.type;
						}else{
							document.getElementById('modroombookCustalertMsg').innerHTML = "Customer updated successfully";
							 $("#checkIn").removeClass('disabled');
						}
					   
					    
					 }
				  });
			}
		}
	
	
	}


function checkIn(bookingid){
	 var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/customer/checkin/" + bookingid 
				+ ".htm", function(response){
			 $("#checkIn").removeClass('disabled'); 
			  if (response == 'Success' || response == 'SUCCESS' || response == 'success') {
				    document.getElementById('roomBookdataopmassagecont').innerHTML = 'Check-In Successful.';
					$('#modRoomCheckInCustDetailsModal').modal('hide');
					showsuccessbookopModal();
				 } else {							
					document.getElementById('roombookalertopmassagecont').innerHTML = 'Check-In Not Successful !';
					$('#modRoomCheckInCustDetailsModal').modal('hide');
					alertRoomBookDataopModal();
				}
			
			
				});
}
















function successRoomBook()
{
	var fromdate = document.getElementById('fromdateroomsearch').value;
	var todate = document.getElementById('todateroomsearch').value;
	var bookingNo = 0;
		location.href = BASE_URL + "/customer/reservedcustomerbyperiod.htm?fromDate=" +fromdate+"&toDate="+todate+"&bookingNo="+bookingNo;
}

function successCheckOut()
{
	
	var fromdate = document.getElementById('fromdateroomsearch').value;
	var todate = document.getElementById('todateroomsearch').value;
	var bookingNo = 0;
	location.href = BASE_URL + "/checkout/checkedincustomerbyperiod.htm?fromDate=" +fromdate+"&toDate="+todate+"&bookingNo="+bookingNo;;	

}

function getReserveDetailsOfselectedCustomer(custId)
{
	

	if(custId!=0)
	{
		var fromdate = document.getElementById('fromdateroomsearch').value;
		var todate = document.getElementById('todateroomsearch').value;
		location.href = BASE_URL + "/customer/reservedidbycustomeridbyperiod.htm?fromDate=" +fromdate+"&toDate="+todate+"&custId="+custId;
	}
}

function getReserveDetailsOfReserveId(resId)
{
	
	if(resId!=0)
	{
		location.href = BASE_URL + "/customer/reservedidbyreserveid.htm?resId="+resId;
	}
}

function resetReserveSearch()
{
	var fromdate = document.getElementById('fromdateroomsearch').value;
	var bookingNo = document.getElementById('reserveIdSearch').value;
	if(bookingNo==""){bookingNo=0;}
	var todate=fromdate;
	location.href = BASE_URL + "/customer/reservedcustomerbyperiod.htm?fromDate=" +fromdate+"&toDate="+todate+"&bookingNo="+bookingNo;
}

function amountCalculationAdvPayRoom(reserveId)
{
	if(reserveId!=0)
	{
		 var ajaxCallObject = new CustomBrowserXMLObject();
		/*
		 * ajaxCallObject.callAjax(BASE_URL +
		 * "/customer/reservedetailsbyreserveid/" + reserveId
		 */
		 ajaxCallObject.callAjax(BASE_URL + "/customer/getpaymentinfo/" + reserveId
						+ ".htm", function(response){
			    console.log(response);
				var responseObj = JSON.parse(response);
				var taxAmt = 0.0;
				var subtotal = 0.0;
				var days = 0;
				/*
				 * if(responseObj!=null) { var one_day=1000*60*60*24; var
				 * startDate = Date.parse(responseObj[0].fromDate); var endDate =
				 * Date.parse(responseObj[0].toDate); var timeDiff = endDate -
				 * startDate; var daysDiff = Math.floor(timeDiff / (1000 * 60 *
				 * 60 * 24)); days=daysDiff; if(days==0) { days = 1; } for(var i
				 * =0;i<responseObj[0].roomid.length; i++) {
				 * //alert('Calculation - '+ parseInt(days) + ' ' +
				 * parseFloat(responseObj[0].roomid[i].roomPrice) + ' ' +
				 * parseFloat(responseObj[0].roomid[i].taxId.percentage));
				 * taxAmt += ((parseFloat(responseObj[0].roomid[i].roomPrice) *
				 * parseInt(days)) *
				 * parseFloat(responseObj[0].roomid[i].taxId.percentage)) / 100;
				 * subtotal += (parseFloat(responseObj[0].roomid[i].roomPrice) *
				 * parseInt(days)); //alert('Inner Calculation - '+taxAmt+ ' ' +
				 * subtotal); } }
				 */
                var totalAmount = responseObj[0].amount;
                var paidAmount = 0.0;
                var amtToPay = 0.0;
                for(var i = 0 ;i< responseObj.length ; i++){
					paidAmount= Number(paidAmount) + Number(responseObj[i].paidamount); 
				}
				amtToPay = Number(totalAmount) - Number(paidAmount);
				/*
				 * var grandTotal = parseFloat(responseObj.) +
				 * parseFloat(taxAmt); var paidAmt =
				 * parseFloat(responseObj[0].payment.paidamount); var amtToPay =
				 * parseFloat(grandTotal) -
				 * parseFloat(responseObj[0].payment.paidamount);
				 */
								
				document.getElementById('cashtotamtcontId').innerHTML = parseFloat(totalAmount).toFixed(2);
				document.getElementById('cashpaidamtcontId').innerHTML = parseFloat(paidAmount).toFixed(2);
				document.getElementById('cashamttopaycontId').innerHTML = parseFloat(amtToPay).toFixed(2);
				
				
			});
	}
}

function getCheckInDetailsOfselectedCustomer(custId)
{
	
	if(custId!=0)
	{
		var fromdate = document.getElementById('fromdateroomsearch').value;
		var todate = document.getElementById('todateroomsearch').value;
		location.href = BASE_URL + "/checkout/bookingidbycustomeridbyperiod.htm?fromDate=" +fromdate+"&toDate="+todate+"&custId="+custId;
	}
}

function getBookingDetailsofBookinId(bookId)
{
	
	if(bookId!=0)
	{
		location.href = BASE_URL + "/checkout/bookingidetailsbybookingid.htm?bookId="+bookId;
	}
	
}

function amountCalculationToPayRoom(bookingId)
{
	var ajaxCallObject = new CustomBrowserXMLObject();
	/*
	 * ajaxCallObject.callAjax(BASE_URL + "/checkout/bookingidetbybookingid/" +
	 * bookingId+ ".htm", function(response){
	 */
	 ajaxCallObject.callAjax(BASE_URL + "/customer/getpaymentinfo/" + bookingId+ ".htm", function(response){
	var responseObj = JSON.parse(response);
	console.log('-resdetails--'+response);
	
	document.getElementById('cashtotamtcontId').innerHTML = responseObj[0].amount;
	 var paidAmount = 0.0;
     var amtToPay = 0.0;
     var totalAmount = responseObj[0].amount;
     for(var i = 0 ;i< responseObj.length ; i++){
			paidAmount= Number(paidAmount) + Number(responseObj[i].paidamount); 
		}
		amtToPay = Number(totalAmount) - Number(paidAmount);
	
	
	
	
	
	/*
	 * var netammt = responseObj[0].roombookinginfo.payment.amount var paidammt =
	 * responseObj[0].roombookinginfo.payment.paidamount; var payableammt =
	 * parseFloat(netammt) - parseFloat(paidammt);
	 */
	document.getElementById('cashtotamtcontId').innerHTML = responseObj[0].amount;
	document.getElementById('cashpaidamtcontId').innerHTML =  parseFloat(paidAmount).toFixed(2);
	document.getElementById('cashamttopaycontId').innerHTML = parseFloat(amtToPay).toFixed(2);

	
	});
	
}

function finalBillPayment(amount)
{  //alert("CALLED");
	// var bookingId=document.getElementById('hiddenbookingid').value;
	var bookingId=document.getElementById('cashmodReserveCont').innerHTML;
	// alert("bookingId:"+bookingId);
	var amttopay=document.getElementById('cashamttopaycontId').innerHTML;
	var totalAmt = document.getElementById('cashtotamtcontId').innerHTML;
	var tenderamt=document.getElementById('cashtenderAmt').value;
	var reserveId = document.getElementById('hiddenadvpaycustdataopmassagecont1').value;
	var paymentMode = document.getElementById('onlineselpaymenttype').innerHTML;
	var paymentTypeId = document.getElementById('paytypeid').value;
	var cardLastDigits = document.getElementById('cardlastfourDigit').value;
	var discamt = document.getElementById('discamt').value;
	var taxamt = document.getElementById('taxamount').value;
	var grossAmt = document.getElementById('grossamount').value;
	
	var roomServiceGross = document.getElementById('roomServiceGross').value;
	var roomServiceTax = document.getElementById('roomServiceTax').value;
	var roomServiceDiscount = document.getElementById('roomServiceDiscount').value;
	var is_receipt_print=$("#advancepaymentreceiptcheckbox").prop("checked");
	
	var greaterValue=0;
	if(amttopay== totalAmt){
		greaterValue=totalAmt;
	}
	else if(amttopay== 0.0){
		greaterValue=amttopay;
	}
	else{
		greaterValue = amttopay;       // totalAmt >= amttopay ? totalAmt :
										// amttopay;
	}
	
	var roomBookingPayment = {};
	roomBookingPayment.reserveId =reserveId;
	roomBookingPayment.booking_id = bookingId;
	roomBookingPayment.tenderamount = amount;
	roomBookingPayment.paymentMode = paymentMode;
	if(paymentTypeId == 2)
	  roomBookingPayment.cardLastFourDigits = cardLastDigits;
	else 
      roomBookingPayment.cardLastFourDigits = "xxxx";
	roomBookingPayment.discAmt=(Number(discamt) + Number(roomServiceDiscount)).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
	roomBookingPayment.taxVatAmt=(Number(taxamt)+Number(roomServiceTax)).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
	roomBookingPayment.grossAmt=(Number(grossAmt)+Number(roomServiceGross)).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
	
	
	if(Number(tenderamt)<=Number(greaterValue)){
		if(is_Acc=="Y")
		{
		// getvendorledger_sale($('#debitor_group_codef').val(),0,customerId,3);//
		// for sunndry debitor
		var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
		var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
		var round_ledger_id = parseInt($('#round_ledger_idf').val());
		var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
		var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
	    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
	    var card_ledger_id=parseInt($('#card_ledger_idf').val());
	     
	     if(sale_ledger_id<=0 || duties_ledger_id<= 0 || round_ledger_id<=0 || discount_ledger_id<=0 || debitor_cash_ledger_id<=0 || card_ledger_id<=0) {
			   document.getElementById('paycashalertMsg').innerHTML = "ledger missing";
				return;
			 }else{
				document.getElementById('paycashalertMsg').innerHTML = "";	 
				roomBookingPayment.duties_ledger_id=duties_ledger_id;
				/* roomBookingPayment.round_ledger_id=round_ledger_id; */
				roomBookingPayment.sale_ledger_id=sale_ledger_id;
				roomBookingPayment.discount_ledger_id=discount_ledger_id;
				/* roomBookingPayment.service_charge_ledger_id=service_charge_ledger_id; */
				/* if(paymentTypeId == 1){ */
				roomBookingPayment.debitor_cash_ledger_id=debitor_cash_ledger_id;
					/* }else{ */
				roomBookingPayment.card_ledger_id=card_ledger_id;
					/* } */
			 }
		}
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjaxPost(BASE_URL + "/customer/advancePayment.htm", roomBookingPayment, function(response) {
		   try {
					if (response == 'success') {
						document.getElementById('catdataopmassagecont').innerHTML = 'Advance Payment Successfully done.' ;
						$('#cashModal').modal('hide');
						if(is_receipt_print==true){
							print80mmbillreceipt();
							
						}else{
							showalertcatdataopModal();
						}
						//showalertcatdataopModal();
				}
				else
				{
					document.getElementById('catdataopmassagecont').innerHTML =  "Advance Payment Unsuccessful. Please try again!";
					$('#cashModal').modal('hide');
					showalertcatdataopModal();
				}
				
			} catch (e) {
				alert(e);
			}
		
           }, null);
		
		
		
	}
	else if(tenderamt == 0)
	{
		document.getElementById('paycashalertMsg').innerHTML='Tender Amount should not be empty';

	}
	else
		{
		document.getElementById('paycashalertMsg').innerHTML='Tender Amount should be less than or equal to Amount to pay';

		}
	
	
}
var isCheckOut="NO";
function checkOut(bookingId,creditFlag)
{
	var chklength=$("#detailssize").val(); 
	// /var paymentType=$("#payTypeId").val();
	var paymentType = $("input[name='payment']:checked").val();
	 // alert(paymentType);
	var count=0;
	
	//console.log("creditFlag IS INSIDE checkOut() FUNCTION IS:");
	//console.log(creditFlag);
	//alert(custIdObject)
	
	//alert("Z IS:"+z);
	/* alert(bookingId); */
	// alert("checkout"+bookingId);
	/*
	 * var currentday = new Date(); var dd = currentday.getDate(); var mm =
	 * currentday.getMonth()+1; //January is 0!
	 * 
	 * var yyyy = currentday.getFullYear(); if(dd<10){ dd='0'+dd; } if(mm<10){
	 * mm='0'+mm; } currentday = yyyy+'-'+mm+'-'+dd;
	 * 
	 */
	
	var checkoutType="";
	var bookingDetailsIds=[];
	var RoomBookingDetails={};
	var RoomBookingDetailsArray=[];
	var modaltablerows=$("#checkoutmodaltablebody").find("tr");
	// RoomBookingDetails
	
	for(var i=0;i<modaltablerows.length;i++){
		var tds=$(modaltablerows[i]).find("td");
		for(var j=0;j<tds.length;j++){
			if($(tds[j]).attr("class")=="input"){
				if($(tds[j]).find("input").prop("disabled")==false && $(tds[j]).find("input").prop("checked")==true){
					bookingDetailsIds.push($(tds[j]).parent().attr("id"));
					count++;
				}else if($(tds[j]).find("input").prop("disabled")==true && $(tds[j]).find("input").prop("checked")==true){
					chklength=chklength-1;
				}
				
				
			}
		}
		
	}

	console.log("BOOKING DETAILS ID ARRAY IS:");
	console.log(bookingDetailsIds);
	
	if(bookingDetailsIds!=""&& bookingDetailsIds.length>0){
		for(var r=0;r<bookingDetailsIds.length;r++){
			var obj=bookingDetailsIds[r];
			console.log("OBJ IS:"+obj);
			RoomBookingDetails={};
			RoomBookingDetails.id=obj;
			RoomBookingDetailsArray.push(RoomBookingDetails);
			
		}
		
		
	}
	console.log("ROOM BOOKING DETAILS  ARRAY IS:");
	console.log(RoomBookingDetailsArray);
	
	console.log("LENGTH OF ALL CHECKBOXES ARE:"+chklength);
	console.log("LENGTH OF ALL COUNT ARE:"+count);
	
	if(chklength==count){
		console.log("ENTERS if(chklength==count) BLOCK ");
		checkoutType="F";
	}else if(count>0){
		console.log("ENTERS ELSE PART OF  if(chklength==count) BLOCK ");
		checkoutType="P";
		$("#partialcheckoutdiv").removeClass("hide");
	}
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	/*
	 * ajaxCallObject.callAjax(BASE_URL + "/checkout/bookingidetbybookingid/" +
	 * bookingId + ".htm", function(response){
	 */
	 ajaxCallObject.callAjax(BASE_URL + "/customer/getpaymentinfo/" + bookingId
				+ ".htm", function(response){
	var responseObj = JSON.parse(response);
	
	console.log("RESPONSE OBJECT FOR CHECKOUT IS:");
	console.log(responseObj);
	/*
	 * var fromdate = responseObj[0].checkInDate; var diff = Math.floor((
	 * Date.parse(today) - Date.parse(fromdate) ) / 86400000);
	 * alert("diff:"+diff);
	 */
      console.log(responseObj);
      console.log("CHEKOUTTYTPE IS:" +checkoutType);
      console.log("AMOUNT TO PAY IS",responseObj[responseObj.length - 1].amt_to_pay);
      
     
      // alert("CHEKOUTTYTPE IS:" +checkoutType);
	if(parseFloat(responseObj[responseObj.length - 1].amt_to_pay)<= 0 || checkoutType=="P" || creditFlag=="Y" )
		{
		// alert("final checkout");
		
		var roombooking = {};
		/* var roombookinginfo={}; */
		roombooking.id=bookingId;
		roombooking.reserveId=bookingId;
		roombooking.isCheckedOut='Y';
		roombooking.hotelId=storeID;
		roombooking.checkoutType=checkoutType;
		roombooking.bookingDetail=RoomBookingDetailsArray;
		
		roombooking.takePType=paymentType;
		
		/* roombooking.roombookinginfo=roombookinginfo; */
		$.ajax({
			  url : BASE_URL + '/checkout/checkoutfromhotel.htm',
			  type : 'POST',
			  contentType : 'application/json;charset=utf-8',
			  data : JSON.stringify(roombooking),
			  success : function(response, JSON_UNESCAPED_UNICODE) {
			   
				  // alert(response);
				  if (response == '0') {					  
						document.getElementById('roombookalertopmassagecont').innerHTML = 'Check-Out Not Successful !';
						$('#modRoomCheckInCustDetailsModal').modal('hide');
						alertRoomBookDataopModal();
					} else {							
						document.getElementById('roomBookdataopmassagecont').innerHTML = 'Check-Out Successful.';
						$('#modRoomCheckInCustDetailsModal').modal('hide');
						$('#alertcatdataopModal').modal('hide');
						printPaidBill(bookingId,2);
						showsuccessbookopModal();
					}
			  }

			 });
		
		
		}
	else
		{
		// alert("ELSE PAYMENT MODAL SHOW");
		// debugger
		$('#paymentalert').modal('show');
		
		
		}

	
	});
	
}


function getBillDetailsByBookingNumber(bookingId){
	var res=null;
	$
	.ajax({
		url :BASE_URL + "/checkout/bookingidetbybookingidforfinalbill/" + bookingId + ".htm", 
		type : 'GET',
		async:false,
		contentType : 'application/json;charset=utf-8',
		success : function(response) {
			   res=JSON.parse(response);
			
		},
		error:function(error){
			console.log("ERROR IN hotelBaseScript.js FILE IN getBillDetailsByBookingNumber(bookingId) FUNCTION IS:");
			console.log(error);
			//alert("ERROR IN GETTING ALL EMPLOYEES");
		}
	});
	return res;
}


function getAvailableRoomDetailsForBooking(fromDate,toDate){
	var res=null;
	var url=BASE_URL + "/room/getavailablerooms.htm?fromDate=" +fromDate+"&toDate="+toDate
	$
	.ajax({
		url :url, 
		type : 'GET',
		async:false,
		contentType : 'application/json;charset=utf-8',
		success : function(response) {
			   res=JSON.parse(response);
			
		},
		error:function(error){
			console.log("ERROR IN hotelBaseScript.js FILE IN getAvailableRoomDetailsForBooking(fromDate,toDate) FUNCTION IS:");
			console.log(error);
		}
	});
	return res;
}


function printPaidBill(bookingId,mode)
{
	// alert(bookingId);
	// alert("printPaidBill() IS CALLED IN hotelBaseScript.js FILE");
	var caseValue =  'Y';
	var printbillpapersize = '2100.00';
	if (caseValue == "Y") {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/checkout/bookingidetbybookingidforfinalbill/" + bookingId + ".htm", function(response){	
				console.log(response);
				var jsonObj = JSON.parse(response);
				var bookingId = jsonObj[0].id;
				var bookingINumber = jsonObj[0].bookingNo;
				var customerName = jsonObj[0].custId.name;
				var customerAddr = jsonObj[0].custId.address;
				var customerPhNo = jsonObj[0].custId.contactNo;
				var customerEmail = jsonObj[0].custId.emailId;
				var custgstNo=jsonObj[0].custId.cust_vat_reg_no;
				var state=jsonObj[0].custId.state;
				var checkInDate = jsonObj[0].checkInDate;
				var checkOutDate = jsonObj[0].checkoutDate;
				var pax = jsonObj[0].noOfPersons;
				var services = jsonObj[0].bookingServices;
				var mydate = new Date(jsonObj[0].bookingDate);
				var date = mydate.getDate();
				var month = mydate.getMonth()+1;
				var year = mydate.getFullYear();
				if(month < 10){month = "0"+month;}
				if(date < 10){date = "0"+date;}
				var bookingDate = year + "-" + month + "-" + date;
				var hotelcountry = "";
				var hoteltaxname = jsonObj[0].bookingDetail[0].roomId.taxId.name;
                var paidAmountt = 0.0;
                for(var i=0; i<jsonObj[0].payment.length;i++){
                	paidAmountt = Number(paidAmountt) + Number(jsonObj[0].payment[i].paidamount);
                }
                var advancepaidAmount = paidAmountt;
                var hotelId = jsonObj[0].hotelId;
				var billAmt = jsonObj[0].netAmt;
				var totsubtotal = 0;
				var totdiscount = 0;			
				
				 /* if(printbillpapersize == '2100.00'){ */
					    
					  	 var startDate = Date.parse(checkInDate);
				         var endDate = Date.parse(checkOutDate);
				         var timeDiff = endDate - startDate;
				         var daysDiff = Math.floor(timeDiff / (1000 * 60 * 60 * 24));					   
						 var days=daysDiff;
						 if(days==0)
						 	{
							 days = 1;
						 	}
						 $('#customerName').text(customerName);
						 $('#customerAddress').text(customerAddr+" "+state); 
						 $('#custgstNo').text(custgstNo);
						 $('#pax').text(pax); 
						 $('#bookingDate').text(checkInDate); 
						 $('#checkInDate').text(checkInDate);
						 $('#checkInTime').text(jsonObj[0].actualCheckinTime); 
						 $('#checkOutDate').text(checkOutDate); 
						 if(mode == 1){
							 $('#checkOutTime').text('00.00'); 
						 }else{
							 $('#checkOutTime').text(jsonObj[0].actualCheckoutTime);  
						 }
						 $('#invoiceNo').text(jsonObj[0].bookingNo); 
						 $('#customerPhone').text(customerPhNo); 
						 $('#bookingDate').text(bookingDate); 
						 
						 
						 var totTaxable = 0.0;
						 var totCTaxAmt = 0.0;
						 var totSTaxAmt = 0.0;
						 var totAmount = 0.0;
						 var totPaise = 0;
						$("#bill_perticulars").html('');
						$("#biil_footers").html('');
						for ( var k = 0; k < jsonObj[0].bookingDetail.length; k++) {
							var room = jsonObj[0].bookingDetail[k];
							// alert("FROM DATE FOR ROOM NUMER
							// "+room.roomId.roomNo+" IS :"+room.fromDate);
							// alert("TO DATE FOR ROOM NUMER
							// "+room.roomId.roomNo+" IS :"+room.toDate);
							
							 var indivroomfromdate1 = Date.parse(room.fromDate);
					         var indivroomtodate1 = Date.parse(room.toDate);
					         var indivroomfromdate =moment(room.fromDate).format("YYYY-MM-DD");
					         var indivroomtodate =moment(room.toDate).format("YYYY-MM-DD");
					         
					         var differ=moment(indivroomtodate).diff(moment(indivroomfromdate),'days');
					         if(differ==0){
					        	 differ=1;
					         }
					         
					       /*
							 * days=moment(indivroomtodate).diff(moment(indivroomfromdate),'days');
							 * if(days==0){ days=1; }
							 */
					        
	                        var roomNo = room.roomId.roomNo;
							var roomCat = room.roomId.roomTypeId.roomType;
							var roomRate = room.roomRate;
							var discammt = 0;
							var taxableammt = 0;
							var discountpercentage = jsonObj[0].discPer;
							var itemTaxableAmt = 0.0;
							var cgstPrcnt = parseFloat(room.roomId.taxId.percentage)/2;
							var cgstPrcnt = parseFloat(room.taxId.percentage);
							var cgstAmt = 0.0;
							var sgstPrcnt = parseFloat(room.roomId.taxId.percentage)/2;
							var sgstAmt = 0.0;
							var createdrowline = "";
							var startTrline = "<tr style='height:25px'>";
							var sl_no = "<td>"+(k+1)+"</td>";
							var roomnotd = "<td>" + roomNo + "</td>";
							// var daystd = "<td>" + days + "</td>";
							var daystd = "<td>" +  differ + "</td>";
							// var roomWtotal=parseFloat(roomRate).toFixed(2) *
							// differ;
							// /alert(roomWtotal);
							var ratetd = "<td 'style='text-align:right;'>" + parseFloat(roomRate).toFixed(2) + "</td>";
							var subtotaltd = "<td width='10%;'style='text-align:right;'>" + parseFloat(room.roomTotal).toFixed(2) + "</td>";
						    var cgstPrcnt_clm = "<td style='text-align:right;'>" + parseFloat(room.taxRate/2).toFixed(2)  + "</td>";
							var cgstAmt_clm = "<td style='text-align:right;'>" + parseFloat(room.taxAmt / 2).toFixed(2)  + "</td>";
							var sgstPrcnt_clm = "<td style='text-align:right;'>" + parseFloat(room.taxRate/2).toFixed(2) + "</td>";
							var sgstAmt_clm = "<td style='text-align:right;'>" + parseFloat(room.taxAmt / 2).toFixed(2)  + "</td>";
							var roomTotal = parseFloat(Number(room.netTotal) + Number(room.discAmt)).toFixed(2);
							// /roomTotal ="0.0";
							// alert("ROOMTOTAL IS:"+roomTotal);
							// roomTotal=roomTotal*parseFloat(Number(differ))+".0";
							var roomTotalDetails = roomTotal.split('.');
							var totalAmt_clm = "<td style='text-align:right;'>" + roomTotalDetails[0]  + "</td>";
							var tdpices_clm = "<td style='text-align:right;'>"+roomTotalDetails[1]+"</td>";
							var endTrline = "</tr>";
							var createdrowline = startTrline+roomnotd+daystd+ratetd+subtotaltd+cgstPrcnt_clm+cgstAmt_clm+sgstPrcnt_clm+sgstAmt_clm+totalAmt_clm+tdpices_clm+endTrline;
							$("#bill_perticulars").append(createdrowline);
							totAmount = Number(totAmount) + Number(roomTotalDetails[0]);
							totPaise = Number(totPaise) + Number(roomTotalDetails[1]);
						}
						 
						
						var serviceData = [];
						for(var z=0;z<services.length;z++){ 
							if(serviceData.length == 0){ // first time
								var service = {};
								service.id = services[z].roomServices.id;
								service.name = services[z].roomServices.name;
								service.note = services[z].serviceNote;
								service.ammt = services[z].netAmount;
								serviceData.push(service);
							}else{ // from second time
								var staus = -1;
								for(var k = 0; k<serviceData.length;k++){
									 if(serviceData[k].id == services[z].roomServices.id){
										 staus = k;
										}
								}
								if(staus != -1){ // if exist
									serviceData[staus].ammt = Number(serviceData[staus].ammt + Number(services[z].netAmount));
									serviceData[staus].note = serviceData[staus].note + " , " + services[z].serviceNote;
								}else{ // if not exist
									var service = {};
									service.id = services[z].roomServices.id;
									service.name = services[z].roomServices.name;
									service.note = services[z].serviceNote;
									service.ammt = services[z].netAmount;
									serviceData.push(service);
								}
								
								
							}
						}
						/* console.log(JSON.stringify(serviceData)); */
						
						var createdline = "";
						for(var a=0;a<serviceData.length;a++){
							var netammt = parseFloat(serviceData[a].ammt).toFixed(2);
							var data = netammt.split('.');
							if(data[1] == ""){data[1] = "0.00";}
							var servicenote = "";
							if(serviceData[a].note != ""){
								servicenote = "(#"+serviceData[a].note+")";
							}
							var servicetr = "<tr>" + 
						                   "<td colspan='8' style='text-align:left'> <b>"+serviceData[a].name + servicenote + "</b></td>"+
						                   "<td style='text-align:right'> <p>"+data[0]+"</p> </td>"+
						                   "<td> <p>"+data[1]+" </p> </td>"+
						                   "</tr>";
						
							createdline +=servicetr;
						}
						
						var subTotalAmttr = "";/*
												 * "<tr>" + "<td colspan='8' style='text-align:left'>
												 * <b> Sub Total </b> </td>" + "<td style='text-align:right'>
												 * <p id='subTotalAmt'>" +
												 * totAmount+" </td>" + "<td>
												 * <p id='subTotalP'> "+
												 * totPaise +"</p> </td>" + "</tr>";
												 */
						var discount = parseFloat(jsonObj[0].discAmt).toFixed(2);
						var discountDetails = discount.split('.');
						if(discountDetails[0] == '0'){discountDetails[0] = '00';}
						var totalDiscAmttr = "<tr>" + 
					                      "<td colspan='8' style='text-align:left'> <b> Discount  </b> </td>" + 
					                      "<td style='text-align:right'> <p id='totalDiscAmt'>" + discountDetails[0]+" </td>" +
					                      "<td> <p id='totalDiscPaise'> "+  discountDetails[1] +"</p> </td>" +  
					                      "</tr>";
						
						var totAmmt = parseFloat(jsonObj[0].payment[0].amount).toFixed(2);
						var totAmmtDetails = totAmmt.split('.');
						var totAmmtDetailstr = "<tr>" + 
						                      "<td colspan='8' style='text-align:left'> <b> Total  </b> </td>" + 
						                      "<td style='text-align:right'> <p id='totalAmt'>" + totAmmtDetails[0]+" </td>" +
						                      "<td> <p id='totalAmtPaise'> "+  totAmmtDetails[1] +"</p> </td>" +  
						                      "</tr>";
						
						
						var advammt = parseFloat(advancepaidAmount).toFixed(2);
						var advammtDetails = advammt.split('.');
						var advAmttr ="";
						if(mode == 1){
							if(advammtDetails[0] == '0'){advammtDetails[0] = '00';}
								advAmttr="<tr>" + 
					                      "<td colspan='8' style='text-align:left'> <b> Advance  </b> </td>" + 
					                      "<td style='text-align:right'> <p id='advAmt'>"+advammtDetails[0] +" </td>" +
					                      "<td> <p id='advAmtPaise'>"+ advammtDetails[1]+"</p></td>" +  
					                      "</tr>";
						}else{
							advAmttr="";
						}
						
						if(mode == 1){
							var netAmmt = parseFloat(Number(jsonObj[0].payment[0].amount) - Number(advancepaidAmount)).toFixed(2);
						}else{
							var netAmmt = parseFloat(jsonObj[0].payment[0].amount).toFixed(2);
						}
						var netAmmtDetails =  netAmmt.split('.');
						var netAmttr = "<tr>" + 
				                      "<td colspan='8' style='text-align:left'> <b> Net Amount  </b> </td>" + 
				                      "<td style='text-align:right'> <p id='netAmt'>" + netAmmtDetails[0] +" </td>" +
				                      "<td> <p id='netAmtPaise'> "+ netAmmtDetails[1]  +"</p> </td>" +  
				                      "</tr>";
						
						if(mode == 1){
							var paidAmttr = "";
						}else{
							var paidAmttr = "<tr>" + 
		                      "<td colspan='8' style='text-align:left'> <b> PaidAmount  </b> </td>" + 
		                      "<td style='text-align:right'> <p id='paidAmt'>" + netAmmtDetails[0] +" </td>" +
		                      "<td> <p id='paidAmtPaise'> "+ netAmmtDetails[1]  +"</p> </td>" +  
		                      "</tr>";
						}
						
						var cash_gross_word = number2text(totAmmt);
						var ammtinwordtr = "<tr>"+
					      					"<td colspan='10' style='padding:15px 0px'>" +  
					      					"<div style='text-align:left;display:flex;width:100%'>"+
					      					"<div style='width:17%'>"+
				          	                "<b> Rupees in word </b>"+  
				          	                "</div>"+
				          	                "<div style='border-bottom: 1px dotted #000;width:83%' id='billAmtInWords'>"+ 
				          	                cash_gross_word  +
				          	                "</div>"+
				          	                "</td>" +
				          	                "</tr>";
					
						createdline = createdline + subTotalAmttr + totalDiscAmttr + totAmmtDetailstr + advAmttr + netAmttr + paidAmttr+ ammtinwordtr;
						// $("#biil_footers").append(createdline);
						$("#bill_perticulars").append(createdline);
						
						
						var bankdetails =  todesc.split('~');
						
						$('#pancode').text(bankdetails[0]);
						$('#bankname').text(bankdetails[1]);
						$('#bankaccno').text(bankdetails[2]);
						$('#bankbarach').text(bankdetails[3]);
						
						printCashOrCardLocal2100New();
						 
				  /*
					 * //OLD BILL FROMAT
					 * 
					 * $('#storeName2100_GST').text(storeName);
					 * $('#storeAddr2100_GST').text(storeAddr);
					 * $('#storeEmail2100_GST').text(storeEmail);
					 * $('#storePhNo2100_GST').text(storePhNo);
					 * $('#cashReservation2100_GST').text(bookingDate);
					 * $('#cashInvoice2100_GST').text(bookingINumber);
					 * $('#cashCheckInDate_GST').text(checkInDate);
					 * $('#cashCheckOutDate_GST').text(checkOutDate);
					 * $('#cashCustName_GST').text(customerName);
					 * $('#cashCustAddr_GST').text(customerAddr);
					 * $('#cashCustContact_GST').text(customerPhNo);
					 * $('#cashCustState_GST').text(state);
					 * $("#itemDetailsPrint2100_GST").html('');
					 * $("#roomDetailsPrint2100_GST").html('');
					 * 
					 * var totTaxable = 0.0; var totCTaxAmt = 0.0; var
					 * totSTaxAmt = 0.0; for ( var k = 0; k <
					 * jsonObj[0].bookingDetail.length; k++) { var room =
					 * jsonObj[0].bookingDetail[k];
					 * 
					 * var roomNo = room.roomId.roomNo; var roomCat =
					 * room.roomId.roomTypeId.roomType; var roomRate =
					 * room.roomId.roomPrice; var discammt = 0; var taxableammt =
					 * 0; var discountpercentage = jsonObj[0].discPer; var
					 * itemTaxableAmt = 0.0; var cgstPrcnt =
					 * parseFloat(room.roomId.taxId.percentage)/2; var cgstPrcnt =
					 * parseFloat(room.taxId.percentage); var cgstAmt = 0.0; var
					 * sgstPrcnt = parseFloat(room.roomId.taxId.percentage)/2;
					 * var sgstAmt = 0.0; var startDate =
					 * Date.parse(checkInDate); var endDate =
					 * Date.parse(checkOutDate); var timeDiff = endDate -
					 * startDate; var daysDiff = Math.floor(timeDiff / (1000 *
					 * 60 * 60 * 24)); var days=daysDiff;
					 * 
					 * if(days==0) { days = 1; }
					 * 
					 * subtotal = (parseFloat(roomRate) * parseInt(days)); var
					 * createdrowline = ""; var startTrline1 = "<tr>"; var
					 * firstTdline = "<td width='15%;'>" + roomNo + "</td>";
					 * var secondTdline = "<td width='15%;'>" + roomCat + "</td>";
					 * var thirdTdline = "<td width='5%;'style='text-align:right;'>" +
					 * parseFloat(roomRate).toFixed(2) + "</td>"; var
					 * subtot_clm = "<td width='10%;'style='text-align:right;'>" +
					 * parseFloat(room.roomTotal).toFixed(2) + "</td>"; var
					 * disc_amt = "<td width='5%;'style='text-align:right;'>"+
					 * parseFloat(room.discAmt).toFixed(2)
					 * +"("+parseFloat(room.discPer).toFixed(2)+")"+ "</td>";
					 * taxableammt = parseFloat(room.roomTotal).toFixed(2) -
					 * parseFloat(room.discAmt).toFixed(2); totsubtotal =
					 * totsubtotal + taxableammt; var gross_amt = "<td width='5%;'style='text-align:right;'>"+
					 * parseFloat(taxableammt).toFixed(2) + "</td>"; var
					 * cgstPrcnt_clm = "<td style='text-align:right;'>" +
					 * parseFloat(room.taxRate/2).toFixed(2) + "</td>"; var
					 * cgstAmt_clm = "<td style='text-align:right;'>" +
					 * parseFloat(room.taxAmt / 2).toFixed(2) + "</td>"; var
					 * sgstPrcnt_clm = "<td style='text-align:right;'>" +
					 * parseFloat(room.taxRate/2).toFixed(2) + "</td>"; var
					 * sgstAmt_clm = "<td style='text-align:right;'>" +
					 * parseFloat(room.taxAmt / 2).toFixed(2) + "</td>"; var
					 * othercountrytaxPrcnt = "<td style='text-align:right;'>" +
					 * parseFloat(room.taxRate).toFixed(2) + "</td>"; var
					 * othercountrytaxammt = "<td style='text-align:right;'>" +
					 * parseFloat(room.taxAmt).toFixed(2) + "</td>"; var
					 * dashlineindia = "<tr style='border-bottom: 1px dashed;'><td colspan='14'></td></tr>"
					 * var dashlineothers = "<tr style='border-bottom: 1px dashed;'><td colspan='9'></td></tr>"
					 * var sl_no = "<td width='5%;'>"+(k+1)+"</td>"; var
					 * endTrline1 = "</tr>"; if(storeCountry == 'INDIA' ||
					 * storeCountry == 'India' || storeCountry == 'india'){
					 * createdrowline1 = startTrline1 + sl_no + firstTdline +
					 * secondTdline + thirdTdline + subtot_clm + disc_amt +
					 * gross_amt + cgstPrcnt_clm + cgstAmt_clm + sgstPrcnt_clm +
					 * sgstAmt_clm + endTrline1; } else{ createdrowline1 =
					 * startTrline1 + sl_no + firstTdline + secondTdline +
					 * thirdTdline + subtot_clm + disc_amt + gross_amt +
					 * othercountrytaxPrcnt + othercountrytaxammt + endTrline1; }
					 * 
					 * 
					 * $("#roomDetailsPrint2100_GST").append(createdrowline1); }
					 * var startTrline2 = "<tr>"; var blank_clm1 = "<td></td><td></td><td></td>";
					 * var total_txt = "<td>Total:</td>"; var grossammt = "<td style='text-align:right;'>"+parseFloat(jsonObj[0].grossAmt).toFixed(2)+"</td>";
					 * var totdiscsammt = "<td style='text-align:right;'>"+parseFloat(jsonObj[0].discAmt).toFixed(2)+"</td>";
					 * var total_amt_clm = "<td style='text-align:right;'>"+parseFloat(totsubtotal).toFixed(2)+"</td>";
					 * var blank_clm3 = "<td></td>"; var blank_clm4 = "<td></td>";
					 * var total_cgstAmt_clm = "<td style='text-align:right;'>" +
					 * parseFloat(parseFloat(jsonObj[0].taxAmt).toFixed(2) /
					 * 2).toFixed(2) + "</td>"; var total_sgstAmt_clm = "<td style='text-align:right;'>" +
					 * parseFloat(parseFloat(jsonObj[0].taxAmt).toFixed(2) /
					 * 2).toFixed(2) + "</td>"; var tottaxammtforothercountry = "<td style='text-align:right;'>" +
					 * parseFloat(jsonObj[0].taxAmt).toFixed(2) + "</td>"; var
					 * endTrline2 = "</tr>";
					 * 
					 * if(storeCountry == "INDIA" || storeCountry == "India" ||
					 * storeCountry == "india"){
					 * 
					 * createdrowline2 = dashlineindia+startTrline2 + blank_clm1 +
					 * total_txt + grossammt + totdiscsammt + total_amt_clm +
					 * blank_clm3 + total_cgstAmt_clm + blank_clm4 +
					 * total_sgstAmt_clm + blank_clm4 +
					 * endTrline2+dashlineindia; } else{
					 * document.getElementById('taxname').innerHTML =
					 * hoteltaxname;
					 * 
					 * createdrowline2 = dashlineothers+startTrline2 +
					 * blank_clm1 + total_txt + grossammt + totdiscsammt +
					 * total_amt_clm + blank_clm3 + tottaxammtforothercountry +
					 * blank_clm4 + endTrline2+dashlineothers; }
					 * 
					 * 
					 * 
					 * $("#roomDetailsPrint2100_GST").append(createdrowline2);
					 * $('#cashtotalamt2100').text(totTaxable);
					 * $("#cashtotalServiceCharge2100px").hide(); if (totCTaxAmt >
					 * 0.00) { $("#cashtotalServiceTax2100px").show();
					 * $('#cashservTax2100').text(totCTaxAmt); } else {
					 * $("#cashtotalServiceTax2100px").hide(); }
					 * 
					 * if (totSTaxAmt > 0) { $("#cashtotalVatTax2100px").show();
					 * $("#cashvatTax2100px").text(totSTaxAmt); } else {
					 * $("#cashtotalVatTax2100px").hide(); }
					 * $("#cashshowDiscount2100px").hide();
					 * 
					 * 
					 * var paidAmt = paidAmountt;
					 * 
					 * var returnAmt = jsonObj[0].netAmt - Number(paidAmountt);
					 * $("#cashgrossAmount2100").text(billAmt);
					 * $("#cashamoutToPay2100").text(returnAmt);
					 * $("#cashgrossAmount2100_gst").text(parseFloat(jsonObj[0].netAmt).toFixed(2));
					 * if(storeCountry == "INDIA" || storeCountry == "India" ||
					 * storeCountry == "india"){
					 * 
					 * $("#cashvatTax2100px_gst").text(parseFloat(jsonObj[0].taxAmt/2).toFixed(2));
					 * $('#cashservTax2100_gst').text(parseFloat(jsonObj[0].taxAmt/2).toFixed(2)); }
					 * else{
					 * $("#cashvatTax2100px_gst").text(parseFloat(jsonObj[0].taxAmt).toFixed(2));
					 * $('#cashservTax2100_gst').text("");
					 *  }
					 * 
					 * var cash_gross_word =
					 * number2text(parseFloat(jsonObj[0].netAmt).toFixed(2));
					 * $("#cashgrossAmount2100_word_gst").text(cash_gross_word);
					 * $('#paidAmount2100').text(paidAmt);
					 * $('#refundAmount2100').text(Math.floor(returnAmt * 100) /
					 * 100);
					 * $('#advPaidAmount2100px_gst').text(parseFloat(advancepaidAmount).toFixed(2));
					 * $('#totalPaidAmount2100px_gst').text(parseFloat(paidAmountt).toFixed(2));
					 * $('#amtToPay2100px_gst').text(parseFloat(returnAmt).toFixed(2));
					 * if(mode == 1){ $("#paidAmtInTotal_2100px").hide();
					 * $("#paidAmtInAdvance_2100px").show(); }else{
					 * $("#paidAmtInAdvance_2100px").hide();
					 * $("#paidAmtInTotal_2100px").show(); } var paymentsObj =
					 * jsonObj[0].payment.length; var paymentmode = ""; var coma =
					 * ','; if (paymentsObj == 2) {
					 * paymentmode=jsonObj[0].payment[1].paymentMode; }else{
					 * for(var i=2;i<paymentsObj;i++){ if(paymentmode == ""){
					 * paymentmode=jsonObj[0].payment[i].paymentMode; }else{
					 * paymentmode = paymentmode + coma +
					 * jsonObj[0].payment[i].paymentMode; } } }
					 * $('#paymentMode2100px_gst').text(paymentmode);
					 * 
					 * 
					 * printCashOrCardLocal2100();
					 */
				   
				/* } */
		});

	  } else { // server print
    
	 }
}

function printCashOrCardLocal2100() {
	// console.log('print here');
	 var divToPrint = document.getElementById('printDiv2100GST');
	 newWin = window.open("");
	 newWin.document.write(divToPrint.outerHTML);
	 newWin.focus();
	 newWin.print();
	 newWin.close();
}
function printCashOrCardLocal2100New(){
	 var divToPrint = document.getElementById('printDiv2100GSTNew');
	 newWin = window.open("");
	 newWin.document.write(divToPrint.outerHTML);
	 newWin.focus();
	 newWin.print();
	 newWin.close();	
	
}

/* ============== Convert number to Word in currency ======================== */

function number2text(value) {
	var fraction = Math.round(frac(value) * 100);
	var f_text = "";

	if (fraction > 0) {
		f_text = "AND " + convert_number(fraction) + " PAISE";
	}

	return convert_number(value) + " RUPEE " + f_text + " ONLY";
}

function frac(f) {
	return f % 1;
}

function convert_number(number) {
	if ((number < 0) || (number > 999999999)) {
		return "NUMBER OUT OF RANGE!";
	}
	var Gn = Math.floor(number / 10000000); /* Crore */
	number -= Gn * 10000000;
	var kn = Math.floor(number / 100000); /* lakhs */
	number -= kn * 100000;
	var Hn = Math.floor(number / 1000); /* thousand */
	number -= Hn * 1000;
	var Dn = Math.floor(number / 100); /* Tens (deca) */
	number = number % 100; /* Ones */
	var tn = Math.floor(number / 10);
	var one = Math.floor(number % 10);
	var res = "";

	if (Gn > 0) {
		res += (convert_number(Gn) + " CRORE");
	}
	if (kn > 0) {
		res += (((res == "") ? "" : " ") + convert_number(kn) + " LAKH");
	}
	if (Hn > 0) {
		res += (((res == "") ? "" : " ") + convert_number(Hn) + " THOUSAND");
	}

	if (Dn) {
		res += (((res == "") ? "" : " ") + convert_number(Dn) + " HUNDRED");
	}

	var ones = Array("", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN",
			"EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE", "THIRTEEN", "FOURTEEN",
			"FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN", "NINETEEN");
	var tens = Array("", "", "TWENTY", "THIRTY", "FOURTY", "FIFTY", "SIXTY",
			"SEVENTY", "EIGHTY", "NINETY");

	if (tn > 0 || one > 0) {
		if (!(res == "")) {
			res += " AND ";
		}
		if (tn < 2) {
			res += ones[tn * 10 + one];
		} else {

			res += tens[tn];
			if (one > 0) {
				res += (ones[one]);
			}
		}
	}

	if (res == "") {
		res = "zero";
	}
	return res;
}


var bookingid="";
var reserveid="";
var fromdate="";
var checkoutdate="";
var todate="";
function showDateExtendModal(bookid,checkinDate,checkoutDate){
	bookingid=bookid;
	document.getElementById('changecheckouterrormsg').innerHTML = '';
	document.getElementById('extendeddate').value = '';
	var ajaxCallObject = new CustomBrowserXMLObject();
/*
 * ajaxCallObject.callAjax(BASE_URL + "/checkout/bookingidetbybookingid/" +
 * bookid + ".htm", function(response){
 */	
		/*
		 * var responseObj = JSON.parse(response); console.log(responseObj); var
		 * length = responseObj[0].roombookinginfo.roomid.length;
		 */
	   /*
		 * reserveid = responseObj[0].roombookinginfo.reserveId; fromdate =
		 * responseObj[0].roombookinginfo.fromDate; checkoutdate =
		 * responseObj[0].roombookinginfo.toDate; todate =
		 * responseObj[0].roombookinginfo.toDate;
		 */
	 	reserveid = bookid;
	    fromdate = checkinDate;
	    checkoutdate = checkoutDate;
	    todate = checkoutDate;
	 
	     
	    // document.getElementById('checkoutdt').value
		// =responseObj[0].roombookinginfo.toDate ;
	    document.getElementById('checkoutdt').value =checkoutDate ;
	    
	    
	/* }); */
	 $('#dateextendmodal').modal('show');
	 
}




/*
 * function setUpdatedRoomBooking(){ var length =
 * document.getElementById('lengthoflist').value; var roombooking = [];
 * roombooking[0].id=bookingid; for(var j=0; j<length; j++){ var
 * roombookinginfo ={}; //roombooking.roombookinginfo.roomid[j].id =
 * document.getElementById('roomid_'+j).value; roombookinginfo.toDate =
 * document.getElementById('dateforextend_'+j).value; var roomid = [];
 * roomid[j].id = document.getElementById('roomid_'+j).value;
 * roombookinginfo.push(roomid);
 * 
 * roombooking.push(roombookinginfo); } $ .ajax({ url : BASE_URL +
 * "/checkout/changecheckoutdetails.htm", type : 'POST', contentType :
 * 'application/json;charset=utf-8', data : JSON.stringify(roombooking), success :
 * function(response) { // called when // successful if (response == 'success') {
 * bookingid =""; $('#dateextendmodal').modal('hide'); } }, error : function(e) { //
 * called when there is // an error // console.log(e.message); } }); }
 */

function setUpdatedRoomBooking(){
	// var bookid = bookingid;
	var pastcheckoutdate = document.getElementById('checkoutdt').value;
	var checkoutdate = document.getElementById('extendeddate').value;
	if(checkoutdate == ''){
		document.getElementById('changecheckouterrormsg').innerHTML = 'Please Input Checkout Date';
	}
	else if(checkoutdate == pastcheckoutdate){
		document.getElementById('changecheckouterrormsg').innerHTML = 'Checkout Date Already Exist!';
	}/*
		 * else if(checkoutdate < pastcheckoutdate){
		 * document.getElementById('changecheckouterrormsg').innerHTML = 'Cannot
		 * Change Date.Please Insert Correct Date.'; }
		 */
	else{
		var operation = "";
		if(checkoutdate < pastcheckoutdate){
			operation =  0;
		}else{
			operation =  1;
		}
		
	document.getElementById('changecheckouterrormsg').innerHTML = '';
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/checkout/changecheckout/" + bookingid +"/" + reserveid + "/" + checkoutdate + "/" + fromdate + "/" + todate + "/" + operation
			+ ".htm", function(response){	
		if(response == "success"){
		
		$('#dateextendmodal').modal('hide');
		$('#checkoutextendsuccess').modal('show');
		
		}
		else{
			$('#dateextendmodal').modal('hide');
			$('#checkoutextendfailed').modal('show');
		}
		bookingid = "";
		reserveid = "";
	});
}
}






function getDiscountAmt(per) {
	// alert("per:"+per);
	// document.getElementById('discpercentage').value=" ";
	var totAmount = document.getElementById('finalcashtotamtcontId').innerHTML;
	var ammttopay = document.getElementById('finalcashamttopaycontId').innerHTML;
	var paidammt = document.getElementById('finalcashpaidamtcontId').innerHTML;
	var grossammt = document.getElementById('finalcashgrossamtcontId').innerHTML;
	var discAmt = 0.0;
	var actualammttopay = 0.0;
	if (per == '') {
		document.getElementById('finalcashamttopaycontId').innerHTML = parseFloat(totAmount).toFixed(2) - parseFloat(paidammt).toFixed(2);
		document.getElementById('discamount').value = '0.00';
	} else if(per>=100){
		document.getElementById('finalcashamttopaycontId').innerHTML = parseFloat(totAmount).toFixed(2) - parseFloat(paidammt).toFixed(2);
		document.getElementById('discpercentage').value = '';
		document.getElementById('discamount').value = '';
	}else if (!isNaN(per)) {
		discAmt = parseFloat(grossammt).toFixed(2) * parseFloat(per).toFixed(2) / 100;
		discAmt = Math.round(discAmt);
		document.getElementById('discamount').value = parseFloat(discAmt).toFixed(2);
		
        actualammttopay = (parseFloat(totAmount).toFixed(2) - parseFloat(discAmt).toFixed(2)) - parseFloat(paidammt).toFixed(2);
		document.getElementById('finalcashamttopaycontId').innerHTML = actualammttopay;	
	}
}


function getDiscountPercentage(amt){
	var totAmount = document.getElementById('finalcashtotamtcontId').innerHTML;
	var ammttopay = document.getElementById('finalcashamttopaycontId').innerHTML;
	var paidammt = document.getElementById('finalcashpaidamtcontId').innerHTML;
	var grossammt = document.getElementById('finalcashgrossamtcontId').innerHTML;
	var discperc = 0.0;
	var actualammttopay = 0.0;
	
	if (amt == '') {
		document.getElementById('finalcashamttopaycontId').innerHTML = parseFloat(totAmount).toFixed(2) - parseFloat(paidammt).toFixed(2);
		document.getElementById('discpercentage').value = '0.00';
	}else if(Number(amt) == Number(grossammt)){
		document.getElementById('discpercentage').value = '';
		document.getElementById('discamount').value = '';
		
	 }else{
		discperc = parseFloat(amt).toFixed(2) * 100 / parseFloat(grossammt).toFixed(2);
		discperc = Math.round(discperc);
		document.getElementById('discpercentage').value = parseFloat(discperc).toFixed(2);
		
        actualammttopay = (parseFloat(totAmount).toFixed(2) - parseFloat(amt).toFixed(2)) - parseFloat(paidammt).toFixed(2);
		document.getElementById('finalcashamttopaycontId').innerHTML = actualammttopay;	
	}
	
	
	
}


function showAddDiscountModal(bookingid,bookingNo,grossAmt){
	var ajaxCallObject = new CustomBrowserXMLObject();
	/*
	 * ajaxCallObject.callAjax(BASE_URL + "/checkout/bookingidetbybookingid/" +
	 * bookingid + ".htm", function(response){
	 */
	 ajaxCallObject.callAjax(BASE_URL + "/customer/getpaymentinfo/" + bookingid
				+ ".htm", function(response){
	var responseObj = JSON.parse(response);
	var totalAmount = responseObj[0].amount;
    var paidAmount = 0.0;
    var amtToPay = 0.0;
    for(var i = 0 ;i< responseObj.length ; i++){
		paidAmount= Number(paidAmount) + Number(responseObj[i].paidamount); 
	}
	amtToPay = Number(totalAmount) - Number(paidAmount);
	document.getElementById('finalcashmodReserveCont').innerHTML=bookingid;
	document.getElementById('finalcashmodReserveContBookingNo').innerHTML=bookingNo;
	document.getElementById('finalcashpaidamtcontId').innerHTML = parseFloat(paidAmount).toFixed(2);
	document.getElementById('finalcashtotamtcontId').innerHTML = parseFloat(totalAmount).toFixed(2);
	document.getElementById('finalcashamttopaycontId').innerHTML=parseFloat(amtToPay).toFixed(2);
	document.getElementById('finalcashgrossamtcontId').innerHTML = parseFloat(grossAmt).toFixed(2);
	
	/*
	 * document.getElementById('finalcashmodReserveCont').innerHTML=bookingid;
	 * document.getElementById('finalcashmodReserveContBookingNo').innerHTML=bookingNo;
	 * document.getElementById('finalhiddenadvpaycustdataopmassagecont').innerHTML=responseObj[0].reserveId;
	 * document.getElementById('finalcashpaidamtcontId').innerHTML =
	 * parseFloat(responseObj[0].roombookinginfo.payment.paidamount).toFixed(2);
	 * document.getElementById('finalcashtotamtcontId').innerHTML =
	 * parseFloat(responseObj[0].roombookinginfo.payment.amount).toFixed(2);
	 * document.getElementById('finalcashamttopaycontId').innerHTML =
	 * parseFloat(responseObj[0].roombookinginfo.payment.amt_to_pay).toFixed(2);
	 * document.getElementById('finalcashgrossamtcontId').innerHTML =
	 * parseFloat(responseObj[0].grossAmt).toFixed(2);
	 * document.getElementById('finalreserveid').value
	 * =responseObj[0].reserveId;
	 */
	$('#adddiscountmodal').modal('show');
	});
	
}

function canceladddiscount(){
	document.getElementById('discpercentage').value="";
	document.getElementById('discamount').value="";
	
}

function addingDiscount(bookingid,discpercentage,discammt,reserveid){
	if(discpercentage == '' || discpercentage == null || discpercentage == "undefined"){
		 document.getElementById('errormessage').innerHTML = "Please Enter Discount%.";
		
	}
	else{
		document.getElementById('errormessage').innerHTML = "";
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/checkout/addingdiscount/" + bookingid + "/" + discpercentage + "/" + discammt + "/" + reserveid
				+ ".htm", function(response){	
		     if(response == 'success'){
		    	 document.getElementById('discountmssg').innerHTML = "Discount Added Successfully.";
		    	 $('#adddiscountmodal').modal('hide');
		    	 $('#discountstatusModal').modal('show');
		    	 
		     }
		     else{
		    	 document.getElementById('discountmssg').innerHTML = "Error Occurred!!.";
		    	 $('#adddiscountmodal').modal('hide');
		    	 $('#discountstatusModal').modal('show');
		     }
	     
	});
		
		
		
	
}
	
	
	
	
}

function refreshpage(){
	location.reload();
}


function openOnlineModal(bookingNo,reserveId,customerId,discamt,taxamt,grossamt) {
	   var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/getpaymenttypebystore.htm",
						function(response) {
							var parseresponse = JSON.parse(response);
							try {
								if ('null' == response) {
									$("#notavailableonlinepaymentModal").modal("show");
								} else if(0 == parseresponse.size){
									$("#notavailableonlinepaymentModal").modal("show");
								}
								else{
									var responseObjpaymenttype = JSON.parse(response);
								        var createdrowline = "";
										var begintable = "<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222;'>";
										var endtable = "</table>";

										for (var j = 0; j < responseObjpaymenttype.paymentTypes.length; j++) {
											var begintr = "<tr style='background:#404040; color:#FFF;'>";
											var firsttd = "<td><input type='radio' name='paymenttypeopt' onchange='getSelectedPaymentTypeval()' value='"
													+ responseObjpaymenttype.paymentTypes[j].paymentTypeName
													+"'/></td>";
											var secondtd = "<td>"
													+ responseObjpaymenttype.paymentTypes[j].paymentTypeName
													+ "</td>";
											var endtr = "</tr>";
											createdrowline += begintr + firsttd
													+ secondtd + endtr;
										}
										$("#reserveId").val(reserveId);
										$("#custId").val(customerId);
										$("#discountAmt").val(discamt);
										$("#taxAmt").val(taxamt);
										$("#grossAmt").val(grossamt);
										$("#bookingNumberOnline").val(bookingNo);
										$("#paymodeselectiondiv").html(begintable + createdrowline+ endtable);
										$("#paymodeselectionModal").modal("show");
									
								}
							} catch (e) {
								alert(e);
							}
						}, null);
	
}




function getpaymod() {
	var selectedPaymentType = $('input[name=paymenttypeopt]:checked').val();
	var reserveId = $("#reserveId").val();
	var customerid = $("#custId").val();
	var discountamt = $("#discountAmt").val();
	var taxamt = $("#taxAmt").val();
	var grossAmt = $("#grossAmt").val();
	var bookingNo = $("#bookingNumberOnline").val();
	if (selectedPaymentType == undefined) {
		$("#paymodeselectiontext").text(getBaseLang.selctPaymentMode);
	} else {
		$("#paymodeselectiontext").text("");
		$("#paymodeselectionModal").modal("hide");
		showAdvPaymentReservationModal(bookingNo,reserveId,selectedPaymentType,3,customerid,discountamt,taxamt,grossAmt)
	}
}



function openOnlineModalCheckout(bookingId,reserveId,bookingNo,discamt,taxamt,grossamt,roomServiceGross,roomServiceTax,roomServiceDiscount) {
	   var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/getpaymenttypebystore.htm",
						function(response) {
							var parseresponse = JSON.parse(response);
							try {
								if ('null' == response) {
									$("#notavailableonlinepaymentModal").modal("show");
								} else if(0 == parseresponse.size){
									$("#notavailableonlinepaymentModal").modal("show");
								}
								else{
									var responseObjpaymenttype = JSON.parse(response);
								        var createdrowline = "";
										var begintable = "<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222;'>";
										var endtable = "</table>";

										for (var j = 0; j < responseObjpaymenttype.paymentTypes.length; j++) {
											var begintr = "<tr style='background:#404040; color:#FFF;'>";
											var firsttd = "<td><input type='radio' name='paymenttypeopt' onchange='getSelectedPaymentTypeval()' value='"
													+ responseObjpaymenttype.paymentTypes[j].paymentTypeName
													+"'/></td>";
											var secondtd = "<td>"
													+ responseObjpaymenttype.paymentTypes[j].paymentTypeName
													+ "</td>";
											var endtr = "</tr>";
											createdrowline += begintr + firsttd
													+ secondtd + endtr;
										}
										$("#reserveId").val(reserveId);
										$("#bookingId").val(bookingId);
										/* $("#cashmodReserveContBookingNo").html(bookingId); */
										$("#bookingNumber").val(bookingNo);
										$("#discountAmt").val(discamt);
										$("#taxAmt").val(taxamt);
										$("#grossAmt").val(grossamt);
										$("#rbroomServiceGross").val(roomServiceGross);
										$("#rbroomServiceTax").val(roomServiceTax);
										$("#rbroomServiceDiscount").val(roomServiceDiscount);
										$("#paymodeselectiondiv").html(begintable + createdrowline+ endtable);
										$("#paymodeselectionModal").modal("show");
									
								}
							} catch (e) {
								alert(e);
							}
						}, null);
	
}

function getpaymodCheckout() {
	var selectedPaymentType = $('input[name=paymenttypeopt]:checked').val();
	var bookingId = $("#bookingId").val();
	var reserveId = $("#reserveId").val();
	var bookingNo = $("#bookingNumber").val();
	var discountamt = $("#discountAmt").val();
	var taxamt = $("#taxAmt").val();
	var roomServiceGross = $("#rbroomServiceGross").val();
	var roomServiceTax = $("#rbroomServiceTax").val();
	var roomServiceDiscount = $("#rbroomServiceDiscount").val();
	var grossAmt = $("#grossAmt").val();
	
	if (selectedPaymentType == undefined) {
		$("#paymodeselectiontext").text(getBaseLang.selctPaymentMode);
	} else {
		$("#paymodeselectiontext").text("");
		$("#paymodeselectionModal").modal("hide");
		showPaymentModal(bookingId,reserveId,selectedPaymentType,3,bookingNo,discountamt,taxamt,grossAmt,roomServiceGross,roomServiceTax,roomServiceDiscount)
	}
}


function openChangeRoomModal(bookingid,reserveId,fromDate,toDate,roomsNos,roomIds){
	var status = 0;
	var roomlist = roomsNos.split(',');
	var roomids =  roomIds.split(',');
	var optionline = "";
	var roombookdetaillist="";
	var res = getBillDetailsByBookingNumber(bookingid);
	console.log("RES IS::",res);
	var startline ="<option value='" + 0+ "'>" + "Select Room" + "</option>";
	if (res != null) {
		
		for(var i=0;i<res.length;i++){
			var roombookdetaillist=res[i].bookingDetail;
			if (roombookdetaillist != "" && roombookdetaillist.length > 0) {
				for(var j=0;j<roombookdetaillist.length;j++){
					var m=roombookdetaillist[j];
					var is_checkedin = m.isCheckIn;
					var is_checkedout = m.isCheckOut;
					var roomNo=m.roomId.roomNo;
					var id=m.roomId.id;
					optionline += "<option value='" + id + "'>" + "Room Number-"+roomNo + "</option>";
					
				}
				
			}
			
		}
		
	}
	
	console.log("STARTLINE AND OPTIONLINE IS:",startline+ optionline)
	document.getElementById('reserveId').value = reserveId;
	document.getElementById('bookingId').value = bookingid;
	document.getElementById('reservedRoomList').innerHTML =startline+ optionline;
	
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/room/getavailablerooms.htm?fromDate=" +fromDate+"&toDate="+toDate,
					function(response) {
						console.log(response);
						var parseresponse = JSON.parse(response);
						try {
							var createdrowline = "";
							var begintable = "<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222;'>";
							var endtable = "</table>";
							var headertr="<tr style='background:#404040; color:#FFF;'><td>Select</td><td>Room Details</td><td>New Rate</td><td style='display:none;'>No Taxable</td></tr>"

							for (var j = 0; j < parseresponse.length; j++) {
								status=0;
								var roomdetails = parseresponse[j];
								       for(var i=0;i<roomids.length;i++){
								    	   if(roomdetails.id ==roomids[i] ){
								    		   status =1;
								    	   }
								       }
								
								if(roomdetails.isBooked !='Y' && status==0){
									var begintr = "<tr style='background:#404040; color:#FFF;font-size: 18px;'>";
									var firsttd = "<td><input type='radio' name='roomopt'  value='"
											+ roomdetails.id
											+"'/></td>";
									var secondtd = "<td style='text-align:left;margin-left:20px;'>"
											+ "Room Number :" + roomdetails.roomNo + "  "
											+ "Capacity:" + roomdetails.roomCapacity + "Persons" + "  "
											+ "Price:" + roomdetails.roomPrice + currency
											+ "</td>";
									var thirdtd = "<td>" +"<input type='text' style='display:none;'  value='"+roomdetails.taxId.id+"'  id='taxid_"+roomdetails.id+"' /><input type='text' style='display:none;'  value='"+roomdetails.taxId.percentage+"'  id='taxpercentage_"+roomdetails.id+"' /><input type='text' style='display:none;'  value='"+roomdetails.roomPrice+"'  id='oldrate_"+roomdetails.id+"' /><input type='text' style='color:black;width:100%;' id='newRate_"
							                             + roomdetails.id
							                             +"'/>";
									var fourthtd = "<td style='display:none;'><input type='checkbox' name='isTaxable_"+roomdetails.id+"' id='istaxable_"+roomdetails.id+"'></td>";
									var endtr = "</tr>";
									createdrowline += begintr + firsttd
											+ secondtd + thirdtd + fourthtd + endtr;
							 }
							}
							$("#roomListDiv").html(begintable +headertr+ createdrowline+ endtable);
							} catch (e) {
							alert(e);
						}
					}, null);
	
	    $("#alertmsg").html('');
	    $("#selectefRoomDetails").html('');
	    $("#roomChangeModal").modal("show");
	
}


function showSelectedRoomDetails(roomid){
	
	if(roomid!=0){
		
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/room/getSelectedRoomData.htm?roomId="+ roomid,
					function(response) {
						console.log("Backend Response "+response);
						var parseresponse = JSON.parse(response);
						try {
							var begintable = "<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222;'>";
							var endtable = "</table>";
							var begintr = "<tr style='background:#404040; color:#FFF;'>";
							var firsttd = "<td>"
								+ "Room Number :" + parseresponse.roomNo + "  "
								+ "Capacity:" + parseresponse.roomCapacity + "Persons" + "  "
								+ "Price:" + parseresponse.roomPrice + currency
								+ "</td>";
						     var endtr = "</tr>";
						     $("#selectefRoomDetails").html(begintable +begintr+ firsttd+endtr+ endtable);
						     
						     
							} catch (e) {
							alert(e);
						}
					}, null);
	
	}
}

function changeRoom(){
	var newRoomId = $("input[name='roomopt']:checked").val();
	var oldRoomId = $("#reservedRoomList").val();
	var reserveId = $("#reserveId").val();
	var bookingId = $("#bookingId").val();
	var newRoomRate = $("#newRate_"+newRoomId).val();
		if(newRoomRate ==""){
			newRoomRate = $("#oldrate_"+newRoomId).val();
		}
	var taxId =$("#taxid_"+newRoomId).val();
	var taxRate = $("#taxpercentage_"+newRoomId).val();
	
	/*
	 * if($('input[name="isTaxable_'+newRoomId+'"]').is(':checked')){ taxRate =
	 * 0; taxId =0; }
	 */
	
	
	if(oldRoomId == 0){
		 $("#alertmsg").html('Please select already reserved room for change.');
	}else{
		 $("#alertmsg").html('');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/room/changeroom/" + newRoomId +"/" + oldRoomId + "/" + reserveId + "/" + bookingId  + "/" + newRoomRate + "/" + taxId + "/" +taxRate
			+ ".htm", function(response){	
		if(response == "success"){
		   $('#roomChangeModal').modal('hide');
		   $("#roomChangeResponseMsg").html("Room changed successfully.");
		   $('#roomChangeResponseModal').modal('show');
		}
		else{
			$('#roomChangeModal').modal('hide');
			$("#roomChangeResponseMsg").html("Error! Room is not changed.");
			$('#roomChangeResponseModal').modal('show');
		}
		
	});
}
	
}






function rateChageModalOpen(){
	/* console.log("Selected room details:"+JSON.stringify(roomDetails)); */
	
	var createdrowline = "";
	var begintable = "<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222; width:100%;'>";
	var endtable = "</table>";
    var headertr="<tr style='background:#404040; color:#FFF;'><td>SL No.</td><td>Room No</td><td>Room Rate</td><td>New Rate</td><td style='display:none;'>No Taxable</td></tr>"
	for (var j = 0; j < roomDetails.length; j++) {
		    var roomdetails=roomDetails[j];
		    var begintr = "<tr style='background:#404040; color:#FFF;'>";
			var firsttd = "<td>"+(j+1)+"</td>";
			var secondtd ="<td>"+roomdetails.roomNo+"</td>";
			var thirdtd = "<td>"+roomdetails.roomPrice+"&nbsp;"+currency+"</td>"; 
			var fourthtd = "<td><input type='text' style='color:black;width:100%;' id='newRate_"
				            + roomdetails.id
				            +"'/></td>";
			var fivethtd = "<td style='display:none;'><input type='checkbox' name='isTaxable_"+roomdetails.id+"' id='istaxable_"+roomdetails.id+"'></td>";
			var endtr = "</tr>";
			createdrowline += begintr + firsttd
					+ secondtd + thirdtd+fourthtd + fivethtd + endtr;
	 
	}
	$("#roomratechagecontent").html(begintable + headertr+createdrowline+ endtable);
	
	$('#roomRateChageModal').modal('show');
}


function changeRoomRate(){
	var roomDetailsNew = roomDetails;
	for (var j = 0; j < roomDetailsNew.length; j++) {
		if($("#newRate_"+roomDetailsNew[j].id).val() != ""){
			 roomDetailsNew[j].roomPrice = $("#newRate_"+roomDetailsNew[j].id).val();
		}
		
		/*
		 * if($('input[name="isTaxable_'+roomDetailsNew[j].id+'"]').is(':checked')){
		 * roomDetailsNew[j].taxId.percentage=0; roomDetailsNew[j].taxId.id=0; }
		 */
	}
	roomDetails=roomDetailsNew;
	console.log(JSON.stringify(roomDetails));
	
}

function taxChange(bookingId,reserveId,bookingNo){
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/checkout/taxchange/" + bookingId +"/" + reserveId
			+ ".htm", function(response){	
		if(response == "success"){
			refreshpage();
		}
		else{
			
		}
		
	});
	
}
/* ===================== End */

// new added 16.7.2019

function openRoomBookingModal(){
	var createdrowline = "";
	var begintable = "<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222; width:90%;' align='center'>";
	var endtable = "</table>";
    var headertr="<tr style='background:#404040; color:#FFF;'><td>SL No.</td><td>Room No</td><td>Room Rate</td><td>New Rate</td><td style='display:none;'>No Taxable</td></tr>"
	for (var j = 0; j < roomDetails.length; j++) {
		    var roomdetails=roomDetails[j];
		    var begintr = "<tr style='background:#404040; color:#FFF;'>";
			var firsttd = "<td>"+(j+1)+"</td>";
			var secondtd ="<td id='roomNo_"+roomdetails.roomNo+"'>"+roomdetails.roomNo+"</td>";
			var thirdtd = "<td>"+roomdetails.roomPrice+"&nbsp;"+currency+"</td>"; 
			var fourthtd = "<td><input type='text' style='color:black;width:50%;' id='newRate_"
				            + roomdetails.id
				            +"' value='"+roomdetails.roomPrice+"'/></td>";
			var fivethtd = "<td style='display:none;'><input type='checkbox' name='isTaxable_"+roomdetails.id+"' id='istaxable_"+roomdetails.id+"'></td>";
			var endtr = "</tr>";
			createdrowline += begintr + firsttd
					+ secondtd + thirdtd+fourthtd + fivethtd + endtr;
	 
	}
	$("#roomdetails").html(begintable + headertr+createdrowline+ endtable);
	
	$("#modroombookcustGender").val('S');
	$("#modroombookcustEmail").val('');
	$("#modroombookcustdob").val('');
	$("#modroombookcustLocation").val('');
	$("#modroombookcustAddress").val('');
	$("#modroombookcusthouseno").val('');
	$("#modroombookcuststreet").val('');
	$("#modroombookcuststate").val('');
	$("#modroombookcustPhone").val('');
	$("#modroombookcustName").val('');
	$("#modroombookcustId").val('');
	
	$("#modroombookcustGender").prop('disabled', true);
	$("#modroombookcustEmail").prop('disabled', true);
	$("#modroombookcustdob").prop('disabled', true);
	$("#modroombookcustLocation").prop('disabled', true);
	$("#modroombookcustAddress").prop('disabled', true);
	$("#modroombookcusthouseno").prop('disabled', true);
	$("#modroombookcuststreet").prop('disabled', true);
	$("#modroombookcuststate").prop('disabled', true);
	$('#roomBookingForm').modal('show');
}
var checkin = 0;
function setCheckIn(){
	if(checkin == 0){
		checkin = 1;
		$("#idtypetr").removeClass('hide');
		$("#idnotr").removeClass('hide');
	}else{
		checkin = 0;
		$("#idtypetr").addClass('hide');
		$("#idnotr").addClass('hide');
	}
	
	
	
	
}

function getRoomBookingDetails(bookingId,checkInDate,checkoutDate){
	var res=null; 
	var url=BASE_URL + "/customer/searchreserveid.htm?term="+bookingId+"&fromDate="+checkInDate+"&toDate="+checkoutDate;
	alert("URL IS:"+url);
	$.ajax({
		url :url,
		type : 'GET',
		contentType : 'application/json;charset=utf-8',
		async:false,
		success : function(response) {
			if(response!=null && response!=""){
				console.log("RESPONSE FOR getRoomBookingDetails IN hotelBaseScript.js FILE IS:");
				console.log(response);
				
				res=JSON.parse(response);
			}
		},
		error:function(error){
			console.log("ERROR IN getRoomBookingDetails FUNCTION IN hotelBaseScript.js FILE IS:");
			console.log(error);
		}
	});	
}
function getSelectedRoomDetails(roomId){
	var res=null;
	var url=BASE_URL + "/room/getSelectedRoomData.htm?roomId="+ roomId;
	$.ajax({
		url :url,
		type : 'GET',
		contentType : 'application/json;charset=utf-8',
		async:false,
		success : function(response) {
			if(response!=null && response!=""){
				console.log("RESPONSE FOR getSelectedRoomDetails IN hotelBaseScript.js FILE IS:");
				console.log(response);
				
				res=JSON.parse(response);
			}
		},
		error:function(error){
			console.log("ERROR IN getSelectedRoomDetails FUNCTION IN hotelBaseScript.js FILE IS:");
			console.log(error);
		}
	});	
	
	console.log("RESPONSE IN getSelectedRoomDetails FUNCTION IS");
	console.log(res);
	return res;
	
}
function selectRoomForDisplayingInAddRoomModal(roomId){
	
	//alert("ROOM ID IS:"+roomId);
	$("#addFurtherRoomsModalBodyTableBody").find("tr").remove();
	var res=getSelectedRoomDetails(roomId);
	var tr="";
	if(res!=null && res!=""){
		console.log("RES IN selectRoomForDisplayingInAddRoomModal IN hotelBaseScript.js FILE IS:");
		console.log(res);
		 var roomid=res.id;
		 var price=res.roomPrice;
		 var roomNum=res.roomNo;
		 var capacity=res.roomCapacity;
		 var design="RoomNo:"+roomNum+" "+"RoomPrice:"+" "+price+" "+"Capacity:"+" "+capacity;
		 var styles='background:#404040; color:#FFF;font-size: 18px;'
		 tr =tr+ "<tr id='"+roomid+"'"+"style="+styles+">";
         //tr=tr+"<td>"+"<input type='checkbox' id='"+roomid+"'"+"</td>"
         tr=tr+"<td>"+design+"</td>" 
         tr=tr+"<td>"+"<input type='text'  style='color:black;' onkeydown='numericcheck(event)'>"+"</input>"+"</td>"
         tr=tr+"</tr>"
		
		
	}
	
	$("#addFurtherRoomsModalBodyTableBody").append(tr);
	
}
/*function numericcheck(e) {
	  
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
        (e.keyCode >= 35 && e.keyCode <= 40)) {  
        return;
    }
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
    }
}*/
function addFurtherRoomsModalFunc(checkInDate,checkoutDate,bookingNumber,bookingId,roomIds,custobj,bookingtypeobject,checkInTimeId,checkOutTypeId){
	var res=getAvailableRoomDetailsForBooking(checkInDate,checkoutDate);
	res=getFilterdAvailableRoomList(res);
	var res2=getBillDetailsByBookingNumber(bookingId);
	var bookingtypeobj=JSON.stringify(bookingtypeobject);
     
	//alert(JSON.stringify(bookingtypeobject));
	//console.log(bookingtypeobject);
	//alert(roomDetails);
	//console.log(roomDetails);
	//console.log("RES2 IS:",res2);
	//console.log(res2);
	//$("#addFurtherRoomsModalDisplayPreviousBookedRoomsTableBody")
	$("#addFurtherRoomsModalDisplayPreviousBookedRoomsTableBody").find("tr").remove();
	//$("#addFurtherRoomsModalDisplayBookingDetailsDivForDisplayingBookedRooms").find("span").remove();
	if(res2!=null && res2!=""){
		var tr ="";
		res2.filter(function(object){
			//console.log("TEST OBJECT IS:");
			//console.log(object);
			
			var bookingDetail=object.bookingDetail;
			
			for(var k=0;k<bookingDetail.length;k++){
				var bookingobj=bookingDetail[k];
				var roomobj=bookingobj.roomId;
				var rid= roomobj.id
				var capacity=roomobj.roomCapacity;
				var roomNumber=roomobj.roomNo;
				//var roomPrice=roomobj.roomPrice;
				var roomPrice=bookingobj.roomRate;
				var design="Booked Rooms: "+" "+"RoomNo:"+roomNumber+" "+"RoomPrice:"+" "+roomPrice+" "+"Capacity:"+" "+capacity;
				//var span="<span class='text-nowrap' id="+rid+">"+design+"</span>";
				//$("#addFurtherRoomsModalDisplayBookingDetailsDivForDisplayingBookedRooms").append(span);
				
				tr =tr+ "<tr style='background:#404040; color:#FFF;font-size: 18px;'>";
		          tr=tr+"<td>"+roomNumber+"</td>"
		          tr=tr+"<td>"+roomPrice+"</td>" 
		          tr=tr+"<td>"+capacity+"</td>"
				
				//$("#addFurtherRoomsModalDisplayBookingDetailsDivForDisplayingBookedRoomsSpan").html(span);
				
				
			}
			
			
			
			
		});
		$("#addFurtherRoomsModalDisplayPreviousBookedRoomsTableBody").append(tr);
		
	}
		
	
	
	$("#addFurtherRoomsModalSelectRoomOption").val("");
	$("#addFurtherRoomsModalBookingId").val(bookingId);
	$("#addFurtherRoomsModalBookingNumber").val(bookingNumber);
	$("#addFurtherRoomsModalCheckInTimeId").val(checkInTimeId);
	$("#addFurtherRoomsModalCheckOutTimeId").val(checkOutTypeId);
	$("#addFurtherRoomsModalBookingNumberSpan").html(bookingNumber);
	$("#tempspanforbookingnumber").html(bookingNumber);
	$("#addFurtherRoomsModalCustomerObject").val(JSON.stringify(custobj));
	$("#addFurtherRoomsModalBookingTypeObject").val(bookingtypeobj);
	
	$("#addFurtherRoomsModalBookingNumber").html(bookingNumber);
	$("#addFurtherRoomsModalCheckInDateSpan").html(checkInDate);
	$("#addFurtherRoomsModalCheckOutDateSpan").html(checkoutDate);
	$("#addFurtherRoomsModalCustomerName").html(custobj.name);
	$("#addFurtherRoomsModalCustomerPhone").html(custobj.contactNo);
	
	
	var tr="";
	var blankoption="<option></option>";
	var option="";
	$("#addFurtherRoomsModalSelectRoomOption").append(blankoption);
	res.filter(function(o){
		//console.log("OBJECT FOR RES IN addFurtherRoomModal IS:");
		//console.log(o);
		 var roomid=o.id;
		 var price=o.roomPrice;
		 var roomNum=o.roomNo;
		 var capacity2=o.roomCapacity;
		var design="RoomNo:"+roomNum+" "+"RoomPrice:"+" "+price+" "+"Capacity:"+" "+capacity2;
		
		 //var design="RoomNo:"+roomNum+"RoomPrice:"+price+"Capacity:"+capacity2;
		 option=option+"<option value='"+roomid+"'"+">"+design+"</option>";
		 
		
		          
		
		         
		
                });
	
    var finaloption=blankoption+option;
	//var finaloption=option;
	$("#addFurtherRoomsModalSelectRoomOption").append(finaloption);
	//$("#addFurtherRoomsModalBodyTableBody").append(tr);
	$("#addFurtherRoomsModal").modal("show");
	//alert("YES TRIGGERED");
	
	
}
function addFurtherRooms(){
	var newRoomRate=$("#addFurtherRoomsModalBodyTableBody>tr>td:nth-child(2)>input").val();
	var bookingId=$("#addFurtherRoomsModalBookingId").val();
	var bookingNumber=$("#addFurtherRoomsModalBookingNumber").val();
	var checkinTimeId=$("#addFurtherRoomsModalCheckInTimeId").val();
	var checkoutTimeId=$("#addFurtherRoomsModalCheckOutTimeId").val();
	var checkInDate1=$("#addFurtherRoomsModalCheckInDateSpan").html();
	var checkOutDate1=$("#addFurtherRoomsModalCheckOutDateSpan").html();
	var custobj=JSON.parse($("#addFurtherRoomsModalCustomerObject").val());
	var bookingtypeobjjsonstring=$("#addFurtherRoomsModalBookingTypeObject").val();
	var bookingTypeObjJson=JSON.parse(bookingtypeobjjsonstring);
	
	var bookingDetailObject={};
	var bookingDetailArray=[];
	var RoomBooking={};
	//RoomBooking Object Parameters//
	var id=bookingId;
	var hotelId=storeID;
	var bookingNo=bookingNumber;
	var custId=JSON.stringify(custobj);
	var checkInDate=checkInDate1;
	var checkoutDate=checkOutDate1;
	
	//List<RoomBookingDetails> bookingDetail
	
    var tablerows=$("#addFurtherRoomsModalBodyTableBody").find("tr");
  //FORMING RoomBookingDetails LIST OF OBJECTS
     for(var i=0;i<tablerows.length;i++){
    	 var obj=tablerows[i];
    	 var roomId=obj.id;
    	 var roomObject=getSelectedRoomDetails(roomId);
    	 var taxId=roomObject.taxId.id
    	 var taxRate=roomObject.taxId.percentage;
    	 var roomRate=roomObject.roomPrice;
    	 console.log("ROOM OBJECT IS:");
    	 console.log(roomObject);
    	 //var roomObject={};
    	// roomObject.id=roomId;
    	 var fromDate=checkInDate1;
    	 var toDate=checkOutDate1;
    	 
    	 var bookingIdObj={};
    	 bookingIdObj.id=bookingId;
    	
    	 
    	 bookingDetailObject.roomId={"id":roomObject.id,"roomNo":roomObject.roomNo};
    	// bookingDetailObject.roomId=roomObject;
    	 bookingDetailObject.hotelId=storeID;
    	 bookingDetailObject.fromDate=checkInDate1;
    	 bookingDetailObject.toDate=checkOutDate1;
    	 bookingDetailObject.customerId=custobj.id;
    	 bookingDetailObject.taxId=taxId;
    	 if(newRoomRate!=null && newRoomRate!=""){
    		 bookingDetailObject.roomRate=newRoomRate; 
    	 }else{
    		bookingDetailObject.roomRate=roomRate;
    	 }
    	 bookingDetailObject.taxId=taxId;
    	 bookingDetailObject.taxRate=taxRate;
    	// bookingDetailObject.bookingId=JSON.stringify(bookingIdObj);
    	 bookingDetailObject.bookingId=bookingIdObj;
    	 bookingDetailObject.bookingNo=bookingNumber;
    	 bookingDetailObject.bookingDate=checkInDate1;
    	 bookingDetailObject.isCheckIn="N";
    	 bookingDetailObject.isCheckOut="N";
    	 bookingDetailArray.push(bookingDetailObject);
    	 
    	 
     }
     console.log("BOOKING DETAILS ARRAY BEFORE POSTING ROOMBOOKING OBJECT TOI ADD ROOMK IS:");
     console.log(bookingDetailArray);
  //FORMING ROOMBOOKING OBJECT HERE
     RoomBooking.id=bookingId;
     RoomBooking.hotelId=storeID;
     RoomBooking.checkInDate=checkInDate1;
     RoomBooking.checkoutDate=checkOutDate1;
     RoomBooking.bookingNo=bookingNumber
     RoomBooking.custId={"id":custobj.id};
     //RoomBooking.custId=custobj;
     RoomBooking.checkinTimeId=checkinTimeId;
     RoomBooking.checkoutTimeId=checkoutTimeId;
     RoomBooking.bookingType=bookingTypeObjJson;
     RoomBooking.bookingDetail=bookingDetailArray;
     callAjaxForAddingRoom(RoomBooking);
  
	
	
}

function callAjaxForAddingRoom(RoomBooking){
	//alert("TRIGGERED SAVE");
	$("#alertmodalbody").find("span").remove();
	var url=BASE_URL +"/room/addMoreRoom.htm";
	$.ajax({
		url : url,
		type : 'POST',
		async:false,
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(RoomBooking),
		success : function(response) {
			obj=JSON.parse(response);
			//console.log("OBJ IN SUCCESS BLOCK OF callAjaxForAddingRoom FUNCTION IN hotelBaseScript.js FILE IS: ");
			//console.log(obj);
			if(obj.status){
				
				var span="<span>"+"Succesfully Added Room"+"</span>"
				$("#alertmodalbody").append(span);
				$("#alertmessagemodal").modal("show");
			}else{
				var span="<span>"+"Failed To Add Room"+"</span>"
				$("#alertmodalbody").append(span);
				$("#alertmessagemodal").modal("show");
				
			}
			//alert("SUCCESS IN ADDING ROOM");
		},
		error:function(error){
			console.log("ERROR IN hotelBaseScript.js FILE FOR ADDING ROOM IN callAjaxForAddingRoom(RoomBooking) FUNCTION  IS:");
			console.log(error);
		}
	});
	
	
}



function getFilterdAvailableRoomList(res){
	
	res=res.filter(function(o){
		  if(o.isStatus=="Y" && o.isBooked=="N" && o.isCheckIn=="N"){
			  return o;  
		  }
	});
	
	return res;
}


function getCustomerDetailsByPhoneOrName(storeID,searchterm,is_phone){
	var res=null;
	url=BASE_URL + "/room/getCustomerDetailsByPhoneOrName.htm";
	$.ajax({
		url :url,
		type : 'GET',
		headers: {"storeId": storeID,"searchterm":searchterm,"is_phone":is_phone},
		contentType : 'application/json;charset=utf-8',
		async:false,
		success : function(response) {
			if(response!=null && response!=""){
				console.log("RESPONSE IS:");
				console.log(response);
				/* alert("RESPONSE FIRST ELEMENT IS:"+response[0]);
				alert("RESPONSE SECOND ELEMENT IS:"+response[1]);
				alert("LENGTH OF RESPONSE IS:"+response.length);
				alert("ENTERS IF response!=null BLOCK"); */
				res=JSON.parse(response);
			}
			//res=JSON.parse(response);
			//console.log("RES getCustomerDetailsByPhoneOrName() FUNCTION  IS:");
			//console.log(res);
		},
		error:function(error){
			console.log("ERROR IN getCustomerDetailsByPhoneOrName FUNCTION IN hotelBaseScript.js FILE IS:");
			console.log(error);
		}
	});
	return res;
	
}
function openNewCustomerData(){
	$("#modroombookcustGender").val('S');
	$("#modroombookcustEmail").val('');
	$("#modroombookcustdob").val('');
	$("#modroombookcustLocation").val('');
	$("#modroombookcustAddress").val('');
	$("#modroombookcusthouseno").val('');
	$("#modroombookcuststreet").val('');
	$("#modroombookcuststate").val('');
	$("#gstno").val('');
	/*
	 * $("#modroombookcustPhone").val(''); $("#modroombookcustName").val('');
	 */
	$("#modroombookcustId").val('');
	$("#gstno").prop('disabled', false);
	$("#modroombookcustGender").prop('disabled', false);
	$("#modroombookcustEmail").prop('disabled', false);
	$("#modroombookcustdob").prop('disabled', false);
	$("#modroombookcustLocation").prop('disabled', false);
	$("#modroombookcustAddress").prop('disabled', false);
	$("#modroombookcusthouseno").prop('disabled', false);
	$("#modroombookcuststreet").prop('disabled', false);
	$("#modroombookcuststate").prop('disabled', false);
}

function GetFormattedDate() {
    var todayTime = new Date();
    var month = format(todayTime .getMonth() + 1);
    var day = format(todayTime .getDate());
    var year = format(todayTime .getFullYear());
    return month + "/" + day + "/" + year;
}
function bookRoom(){
	
	  //console.log("ROOM DETAILS JSON OBJECT BEFORE BOOKING IS:");
	  //console.log(JSON.stringify(roomDetails));
	  
	 
	var pax = $("#paxroomsearch").val();
	var customerId = $("#modroombookcustId").val();
	var gstno = $("#gstno").val();
	var refno = $("#modroombookrefNo").val();
	var remarks = $("#modroombookremarks").val();
	
	//console.log("REMARKS IS:",remarks);
	
	var isCheckIn;
	if(checkin == 0){isCheckIn = 'N';}else{isCheckIn = 'Y';}
		 if (customerId == "")
		 {
			 	saveCustomer();
			 
		 }else{
		        var todayTime = new Date();
			    var roomBooking = {};
			    var custId = {};
			    custId.id=$("#modroombookcustId").val();     
			    roomBooking.custId=custId;
		        roomBooking.checkInDate=$("#fromdateroomsearch").val();
		        roomBooking.checkoutDate= $("#todateroomsearch").val();
		        roomBooking.isCheckedIn=isCheckIn;
		        roomBooking.isCheckedOut='N';
		        roomBooking.refNo=refno;
		        roomBooking.remarks=remarks;
		        roomBooking.hotelId=roomDetails[0].hotelId;
		        roomBooking.bookingDate=todayTime;
		        var roombookinginfo={};
		        roombookinginfo.reserveId="";
		        roomBooking.roombookinginfo = roombookinginfo;
		        var bookingType = {};
		        bookingType.id=$("#modroombookingType").val();     
		        roomBooking.bookingType=bookingType;
		        roomBooking.noOfPersons=pax;
		        var bookingDetail = [];
		        for (var j = 0; j < roomDetails.length; j++) {
			        var bookingDetailData= {};
			        var room = {};
			        room.id=roomDetails[j].id;
			        room.roomNo=roomDetails[j].roomNo;
			        bookingDetailData.roomId=room;
			        bookingDetailData.hotelId=roomDetails[j].hotelId;
			        bookingDetailData.fromDate= $("#fromdateroomsearch").val();
			        bookingDetailData.toDate= $("#todateroomsearch").val();
			        bookingDetailData.isCheckIn=isCheckIn;
			        bookingDetailData.isCheckOut='N';
			        bookingDetailData.customerId=$("#modroombookcustId").val();
			        bookingDetailData.bookingDate=todayTime;
			        var roomRate = $("#newRate_"+roomDetails[j].id).val();
			        if(roomRate == ""){roomRate = roomDetails[j].roomPrice;}
			        bookingDetailData.roomRate=roomRate;
			        bookingDetailData.taxId=roomDetails[j].taxId.id;
			        bookingDetailData.taxRate=roomDetails[j].taxId.percentage;
			        bookingDetail.push(bookingDetailData);
		        }
		        
		        roomBooking.bookingDetail=bookingDetail;
		        console.log("data:"+JSON.stringify(roomBooking));
		        $.ajax({
		        	  url : BASE_URL + '/customer/roombooking.htm',
		        	  type : 'POST',
		        	  contentType : 'application/json;charset=utf-8',
		        	  data : JSON.stringify(roomBooking),
		        	  success : function(response, JSON_UNESCAPED_UNICODE) {
		        	   if (response != 0) {
		        		   if(isCheckIn == 'N')
		        	          location.href = BASE_URL + "/customer/welcome.htm";
		        		   else
		        			   location.href = BASE_URL + "/checkout/welcome.htm";
		        	   } 
		        	  }

		        	 });
		 
		 }
	
	
}
function getAllUniqueId(){
	var res=null;
	var url=BASE_URL + "/guest/getAllUniqueId.htm";
	$.ajax({
		url :url,
		type : 'GET',
		headers: {"storeId": storeID},
		contentType : 'application/json;charset=utf-8',
		async:false,
		success : function(response) {
			res=JSON.parse(response);
			console.log("RES getAllUniqueId() FUNCTION  IS:");
			console.log(res);
		},
		error:function(error){
			console.log("ERROR IN hotelBaseScript.js FILE FOR getAllUniqueId() FUNCTION   IS:");
			console.log(error);
		}
	});
	return res;
	
}
function ValidateEmail(email)
{
	var result=false;
	if(email==null || email==""){
		result=true;
	}else{
		var mailformat =/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
		result=mailformat.test(email);		
	}
	//alert("EMAIL IS:"+email);
	//alert("IN ValidateEmail FUnction check"+result);
return result;
}
function ValidatePhone(phone){
	var msg=null;
	if(phone=="" ||phone==null){
		msg="Please Enter Customer Phone No!";
	}else if(isNaN(phone)){
		msg="Please Enter Valid Phone No.Phone No Cannot Be Character";
		
	}else if(phone.length!=10){
		msg="Phone No must be a 10 digit no"
	}
	return msg;
	
}
function saveCustomer(){
	var gstno = $("#gstno").val();
	var is_valid_email="";
	var msg="";
	var email=$("#modroombookcustEmail").val();
	is_valid_email=ValidateEmail(email);
	var phone=$("#modroombookcustPhone").val();
	msg=ValidatePhone(phone);
	document.getElementById('modroombookCustalertMsg').innerHTML="";
	if ($("#modroombookcustName").val() == "") {
		document.getElementById('modroombookCustalertMsg').innerHTML = "Please Enter Customer Name!";
	}else if(msg != null){
		document.getElementById('modroombookCustalertMsg').innerHTML = msg;
	}else if (checkin == 1 && $("#modroombookuniqueIdType").val() == "0") {
			document.getElementById('modroombookCustalertMsg').innerHTML = "Please Select Id Type!";
	 }else if(checkin == 1 && $("#modroombookuniqueId").val() == ""){
			document.getElementById('modroombookCustalertMsg').innerHTML = "Please enter Id Number!";
	 }else if(is_valid_email==false){
		 //alert("IN saveCustomer FUnction check"+is_valid_email);
			document.getElementById('modroombookCustalertMsg').innerHTML = "Please enter Valid Email Address!";
	 }else{
		 var storeCustomer = {};
		 storeCustomer.id=0;
		 storeCustomer.name = $("#modroombookcustName").val();
		 storeCustomer.address =$("#modroombookcustAddress").val();
		 storeCustomer.contactNo = $("#modroombookcustPhone").val();
		 storeCustomer.emailId = $("#modroombookcustEmail").val(); 
		 storeCustomer.creditCustomer = "N";
		 storeCustomer.creditLimit = 0;
		 storeCustomer.cust_vat_reg_no = gstno;
		 var idtype = $("#modroombookuniqueIdType").val();
		 if(idtype == ""){idtype = 0;}
		 storeCustomer.uniqueidType = idtype;
		 storeCustomer.uniqueidNo = $("#modroombookuniqueId").val();
		 storeCustomer.gender=$("#modroombookcustGender").val();
		 storeCustomer.dob=$("#modroombookcustdob").val();
		 storeCustomer.state=$("#modroombookcuststate").val();
		 storeCustomer.house_no=$("#modroombookcusthouseno").val();
		 storeCustomer.street=$("#modroombookcuststreet").val();
		 storeCustomer.location=$("#modroombookcustLocation").val();
		 $.ajax({
				url : BASE_URL + "/customer/addroomcustomer.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(storeCustomer),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					var resp = JSON.parse(response);
					// alert(resp.id);
					if(resp.id==0){
						document.getElementById('modroombookCustalertMsg').innerHTML = "Error!!"+ resp.type;
					}else{
						 $("#modroombookcustId").val(resp.id);
						 bookRoom();
					}
				   
				    
				 }
			  });
	   }	
  }





function customerDetailSearch(custId) {
	 var ajaxCallObject = new CustomBrowserXMLObject();
	 ajaxCallObject.callAjax(BASE_URL + "/order/getcustomerdetailsbyid/"+ custId + ".htm",
								function(response) {
									try {
										console.log("responsebycustID=" + response);
										var custDetail = JSON.parse(response);
										if ($.isEmptyObject(custDetail)) {
										
										}else{
											
										}
										

									} catch (e) {
										console.log(e);
									}
								}, null);
				     
	}

function getvendorledger_sale(group_code,acc_id,ref_id,para)
 {
	 

	var commonobj={};
	if (para==0) { // for duties and tax

		commonobj.groupCode=group_code;
		commonobj.accountID=0;
		commonobj.referenceID=0;
		commonobj.id=1;


	}


	if (para==1) { // for round off

		commonobj.groupCode=group_code;
		commonobj.accountID=0;
		commonobj.referenceID=0;
		commonobj.id=1;

	}

	if (para==2) { // for sale

		commonobj.groupCode=group_code;
		commonobj.accountID=0;
		commonobj.referenceID=0;
		commonobj.id=1;

	}

	if (para==3) { // for debitor

		if (ref_id==0) { // when customer is not present
			commonobj.groupCode=$('#cash_codef').val();
			commonobj.accountID=0;
			commonobj.referenceID=0;
			commonobj.id=1;
			cash_sale=1;

		}else {
			cash_sale=0;// when customer present
			commonobj.groupCode=group_code;
			commonobj.accountID=0;
			commonobj.referenceID=ref_id;
			commonobj.id=1;
		}


	}

if (para==4) { // for discount

	commonobj.groupCode=group_code;
	commonobj.accountID=0;
	commonobj.referenceID=0;
	commonobj.id=1;

}
if (para==5) { // for cash

	commonobj.groupCode=group_code;
	commonobj.accountID=0;
	commonobj.referenceID=0;
	commonobj.id=1;

}

if (para==6) { // for card

	commonobj.groupCode=group_code;
	commonobj.accountID=0;
	commonobj.referenceID=0;
	commonobj.id=1;

}

if (para==7) { // for service charge

	commonobj.groupCode=group_code;
	commonobj.accountID=0;
	commonobj.referenceID=0;
	commonobj.id=1;

}

// $('#pleasewaitModal').modal('show');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjaxPost(BASE_URL + "/accntsetup/searchledgerusinggroup.htm", commonobj, function(response) {
		$('#pleasewaitModal').modal('hide');

		var status = JSON.parse(response);

		if (para==0) {// for duties and tax
			console.log("duties and tax ");

			$.each(status, function(i) {

				// $('#duties_html1').html("Cr-"+status[i].name);
				 $('#duties_ledger_idf').val(status[i].id);

			});
		}

		if (para==1) {// for round off
			console.log("for round off ");
			$.each(status, function(i) {

				 // $('#round_html1').html(status[i].name);
				 $('#round_ledger_idf').val(status[i].id);

			});
		}
	if (para==2) { // for sale

		console.log("for sale ");
				$.each(status, function(i) {

					// $('#sales_html1').html("Cr-"+status[i].name);
					 $('#sales_ledger_idf').val(status[i].id);

				});
			}

	if (para==3) {// for debitor

		console.log(" for debitor ");

				$.each(status, function(i) {

					// $('#debitor_html1').html("Dr-"+status[i].name );
					 $('#debitor_ledger_idf').val(status[i].id);

				});
		 }

	if (para==4) {// for discount
		console.log("for discount ");
		$.each(status, function(i) {

			// $('#discount_html1').html("Dr-"+status[i].name );
			 $('#discount_ledger_idf').val(status[i].id);

		});
		 }
	if (para==5) {// for cash
		console.log("for cash ");
		$.each(status, function(i) {
			// $('#cash_ledger_html1').html("Dr-"+status[i].name );
			 $('#debitor_cahs_ledger_idf').val(status[i].id);

		});
		 }
	if (para==6) {// for card
		console.log(" for card ");
		$.each(status, function(i) {



		// $('#card_html1').html("Dr-"+status[i].name );
			 $('#card_ledger_idf').val(status[i].id);

		});
		 }


	if (para==7) {// for service charge
		console.log(" for  service charge ");
		$.each(status, function(i) {

			// $('#card_html1').html("Dr-"+status[i].name );
			 $('#service_charge_ledger_idf').val(status[i].id);

		});
		 }

		// chngeResultStat(status);
	});

}






var roomNosForService = [];
var roomIdsForService = [];
function openRoomServiceModal(bookingid,bookingNo,fromDate,toDate,roomsNos,roomIds){

	var status = 0;
	var roomlist = roomsNos.split(',');
	var roomids =  roomIds.split(',');
	var optionline = "";
	
	var res = getBillDetailsByBookingNumber(bookingid);
	
	var startline ="<option value='" + 0+ "'>" + "Select Room" + "</option>"; 
	if (res != null) {
	
		res.filter(function (o) {
			roombookdetaillist = o.bookingDetail;
			if (roombookdetaillist != "" && roombookdetaillist.length > 0) {
				roombookdetaillist.filter(function (m) {
					
					var is_checkedin = m.isCheckIn;
					var is_checkedout = m.isCheckOut;
					status = (is_checkedin == "Y" && is_checkedout == "N") ? "CheckedIn" : (is_checkedin == "Y" && is_checkedout == "Y") ? "CheckedOut" : "";
					if(status=="CheckedIn"){
						var roomNo=m.roomId.roomNo;
						var id=m.roomId.id;
						optionline += "<option value='" + id + "'>" +roomNo + "</option>";
					}
					
				});
				
				
			}
		});
		
	}
	/*
	 * var startline ="<option value='" + 0+ "'>" + "Select Room" + "</option>";
	 * for ( var i = 0; i < roomlist.length; i++) { optionline += "<option
	 * value='" + roomids[i] + "'>" +roomlist[i] + "</option>"; }
	 */
	roomNosForService =roomlist;
	roomIdsForService = roomids;
	
	document.getElementById('reserveIdForService').value = bookingNo;
	document.getElementById('bookingIdForService').value = bookingid;
	document.getElementById('selectedRomm_0').innerHTML = optionline; 
	
	
	
	    $("#alertmsg").html('');
	   // $("#selectefRoomDetails").html('');
	    document.getElementById("servicealertmsg").innerHTML = ""; 
	    $("#roomservicetitle").text("Add Services For Booking Number:"+bookingNo);
	    $("#roomServiceModal").modal("show");
	   
	
}

var cellid = 1; 
function addRow(tableID) {
	var table = document.getElementById(tableID);
	
	var rowCount = table.rows.length;
	var row = table.insertRow(rowCount);
	row.style.background = "#404040";
	row.style.color = "#FFF";
	
    
	var cell1 = row.insertCell(0); // rooms
	cell1.align = "center";
	cell1.style.color = "#000";
	/* cell1.width="10%"; */
	var element1 = document.createElement("SELECT");
	element1.setAttribute("id", "selectedRomm_"+cellid);
	element1.setAttribute("class", "selectedrooms");
	cell1.appendChild(element1);
	element1.style.padding = "2px";
	var z ="";
	var t ="";
	for(var i=0;i<roomNosForService.length;i++){
		 z = document.createElement("option");
		 z.setAttribute("value",roomIdsForService[i]);
		 t = document.createTextNode(roomNosForService[i]);
		 z.appendChild(t);
		 document.getElementById("selectedRomm_"+cellid).appendChild(z);
	}
	
	
	
	var cell2 = row.insertCell(1); // services
	cell2.align = "center";
	cell2.style.color = "#000";
	/* cell1.width="10%"; */
	var element2 = document.createElement("SELECT");
	element2.setAttribute("id", "servicetype_"+cellid);
	element2.setAttribute("class", "serviceType");
	cell2.appendChild(element2);
	element2.style.padding = "2px";
	var roomServices = JSON.parse(roomservices);
	var z1 ="";
	var t1 ="";
	
	 z1 = document.createElement("option");
	 z1.setAttribute("value",0);
	 t1 = document.createTextNode("Select");
	 z1.appendChild(t1);
	 document.getElementById("servicetype_"+cellid).appendChild(z1);
	 
	 
	for(var i=0;i<roomServices.length;i++){
		 z1 = document.createElement("option");
		 z1.setAttribute("value",roomServices[i].id);
		 t1 = document.createTextNode(roomServices[i].name);
		 z1.appendChild(t1);
		 document.getElementById("servicetype_"+cellid).appendChild(z1);
	}
	$(element2).change(selectServiceType);
	
	
	
	var cell3 = row.insertCell(2); // notes
	cell3.align = "center";
	cell3.style.color = "#000";
	/* cell3.width="15%"; */
	var element3 = document.createElement("input");
	element3.type = "text";
	element3.setAttribute("id", "serviceNote_"+cellid);
	element3.setAttribute("class", "servicenote");
	element3.style.width = "200px";
	element3.style.padding = "2px";
	cell3.appendChild(element3);
	
	
	var cell4 = row.insertCell(3); // rate
	cell4.align = "center";
	cell4.style.color = "#000";
	/* cell4.width="10%"; */
	var element4 = document.createElement("input");
	element4.type = "text";
	element4.setAttribute("id", "serviseRate_"+cellid);
	element4.setAttribute("class", "serviserate");
	element4.style.width = "100px";
	element4.style.padding = "2px";
	cell4.appendChild(element4);
	$(element4).keyup(setNetAmt);
	$(element4).keydown(numcheck);
	
		
	var cell5 = row.insertCell(4); // qty
	cell5.align = "center";
	cell5.style.color = "#000";	
	/* cell5.width="20%"; */
	var element5 = document.createElement("input");
	element5.type = "text";
	element5.setAttribute("id", "serviceQty_"+cellid);
	element5.setAttribute("value", "1");
	element5.setAttribute("class", "serviceqty");
	element5.style.width = "50px";
	element5.style.padding = "2px";
	cell5.appendChild(element5);
	$(element5).keyup(setNetAmt);
	$(element5).keydown(numcheck);
	
		
	var cell6 = row.insertCell(5); // gross amount
	cell6.align = "center";
	cell6.style.color = "#000";
	/* cell6.width="10%"; */
	var element6 = document.createElement("input");
	element6.type = "text";
	element6.setAttribute("id", "serviceGross_"+cellid);
	element6.setAttribute("class", "servicegross");
	element6.setAttribute('readonly','true');
	element6.style.width = "100px";
	element6.style.padding = "2px";
	cell6.appendChild(element6);
	
	
	var cell7 = row.insertCell(6); // tax rate
	cell7.align = "center";
	cell7.style.color = "#000";
	/* cell7.width="5%"; */
	var element7 = document.createElement("input");
	element7.type = "text";
	element7.setAttribute("id", "serviceTaxRate_"+cellid);
	element7.setAttribute("class", "servicetaxrate");
	element7.style.width = "50px";
	element7.style.padding = "2px";
	cell7.appendChild(element7);
	$(element7).keyup(setNetAmt);
	$(element7).keydown(numcheck);
	
	
	var cell8 = row.insertCell(7); // taxamt
	cell8.align = "center";
	cell8.style.color = "#000";
	/* cell8.width="10%"; */
	var element8 = document.createElement("input");
	element8.type = "text";
	element8.setAttribute("id", "serviceTaxAmt_"+cellid);
	element8.setAttribute("class", "servicetaxamt");
	element8.setAttribute('readonly','true');
	element8.style.width = "100px";
	element8.style.padding = "2px";
	cell8.appendChild(element8);
	
	
	var cell9 = row.insertCell(8); // netamt
	cell9.align = "center";
	cell9.style.color = "#000";
	/* cell9.width="10%"; */
	var element9 = document.createElement("input");
	element9.type = "text";
	element9.setAttribute("id", "serviceNetamt_"+cellid);
	element9.setAttribute("class", "servicenetamount");
	element9.setAttribute('readonly','true');
	element9.style.width = "100px";
	element9.style.padding = "2px";
	cell9.appendChild(element9);
	
	
	
	
	var cell10 = row.insertCell(9);
	cell10.align = "center";
	cell10.style.color = "#000";
	var element10 = document.createElement("input");
	element10.type = "button";
	element10.setAttribute("class", "btn btn-danger");
	element10.setAttribute("value", "X");
	$(element10).click(remove);
	cell10.appendChild(element10);
	
	cellid = Number(cellid) + 1;
}

function addTableRowForGuestTable(isdisbaled) {
	//alert("CALLED addTableRowForGuestTable() FUNCTION IN hotelBaseScript.js FILE")
  //$("#cancelguesttablerow").removeClass("hide");

	var idjson=getAllUniqueId();
	var option="";
	for(var i=0;i<idjson.length;i++){
		
	    var obj=idjson[i];
		option=option+"<option value="+obj.id+">"+obj.name+"</option>"
	}
	
	
	if(isdisbaled){

		var myvar = '<tr class="item"'+
		'								style="background: #404040; color: #FFF; margin-top: 2px;">'+
		'								<td style="color: #000" align="center" width=""'+
		'									id="tdguestname"><input type="text" id="guestname"disabled style="width:150px;"></input></td>'+
		''+
		'								<td style="color: #000" align="center" width="" id="tdcontactnumber"><input type="number" id="guestcontact" disabled style="width:150px;"></input></td>'+
		'								<td style="color: #000" align="center" width="" id="tdemail"><input'+
		'									type="text" id="email"style="padding: 2px; width: 150px;" disabled /></td>'+
		''+
		'								<td style="color: #000" align="center" width="" id="tdaddress"><input'+
		'									type="text" id="guestaddress" disabled style="width:150px;" /></td>'+
		'								<td style="color: #000" align="center" width="" id="tdgender">'+
		'								<select id="gender" disabled>'+
		'								<option value="M">Male</option>'+
		'								<option value="F">Female</option>'+
		'								</select>'+
		'								'+
		'								</td>'+
		'								<td style="color: #000" align="center" width="" id="tdUniqueIdType">'+
		'								<select id="uniqueIdType" disabled>'+
		option+
		'								</select>'+
		'								'+
		'								</td>'+
		'								<td style="color: #000" align="center" width="" id="tduniqueId"><input  type="text" id="uniqueId" disabled style="width:150px;" /></td>'+
		'<td></td>'+
		'								'+
		''+
		'							</tr>';
			
		$("#addguestmodaltablebody").append(myvar);
	}else{
		var myvar = '<tr class="item"'+
		'								style="background: #404040; color: #FFF; margin-top: 2px;">'+
		'								<td style="color: #000" align="center" width=""'+
		'									id="tdguestname"><input type="text" id="guestname" style="width:150px;"></input></td>'+
		''+
		'								<td style="color: #000" align="center" width="" id="tdcontactnumber"><input type="number" id="guestcontact" style="width:150px;"></input></td>'+
		'								<td style="color: #000" align="center" width="" id="tdemail"><input'+
		'									type="text" id="email"style="padding: 2px; width: 150px;" /></td>'+
		''+
		'								<td style="color: #000" align="center" width="" id="tdaddress"><input'+
		'									type="text" id="guestaddress" style="width:150px;" /></td>'+
		'								<td style="color: #000" align="center" width="" id="tdgender">'+
		'								<select id="gender">'+
		'								<option value="M">Male</option>'+
		'								<option value="F">Female</option>'+
		'								</select>'+
		'								'+
		'								</td>'+
		'								<td style="color: #000" align="center" width="" id="tdUniqueIdType">'+
		'								<select id="uniqueIdType">'+
		option+
		'								</select>'+
		'								'+
		'								</td>'+
		'								<td style="color: #000" align="center" width="" id="tduniqueId"><input  type="text" id="uniqueId" style="width:150px;" /></td>'+
		'								<td style="align="center" width="" id="cancelguesttablerow"><input type="button" class="btn btn-danger" value="X"></td>'+
		'								'+
		''+
		'							</tr>';
		$("#addguestmodaltablebody").append(myvar);
	}
	
}

function addGuestModal(bookingId,bookingNumber){
	var res=getAllGuestList(bookingId);
   // console.log("GET REQUEST RESPONSE FOR ALL GUESTLIST IS:");
    //console.log(res);
	//alert("BOOKING ID IS:"+bookingId);
	//alert("BOOKING NUMBER IS:"+bookingNumber);
    $("#addguestmodaltablebody>tr").remove();
    if(res!=null && res!="" && res.length>0){
    	for(var i=1;i<=res.length;i++){
			var obj=res[i-1];
			if(obj.type=='H'){
			addTableRowForGuestTable(true);
			$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(1)").find("#guestname").val(obj.name);
			$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(2)").find("#guestcontact").val(obj.contactNo);
			$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(3)").find("#email").val(obj.emailId);
			$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(4)").find("#guestaddress").val(obj.address);
			$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(5)").find("#gender").val(obj.gender);
			$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(6)").find("#uniqueIdType").val(obj.uniqueidType);
			$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(7)").find("#uniqueId").val(obj.uniqueidNo);
			}else{
				addTableRowForGuestTable(false);
				$("#addguestmodalfooterdiv>button:nth-child(2)").html("UPDATE GUEST");
				$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(1)").find("#guestname").val(obj.name);
				$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(2)").find("#guestcontact").val(obj.contactNo);
				$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(3)").find("#email").val(obj.emailId);
				$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(4)").find("#guestaddress").val(obj.address);
				$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(5)").find("#gender").val(obj.gender);
				$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(6)").find("#uniqueIdType").val(obj.uniqueidType);
				$("#addguestmodaltablebody").find("tr:nth-child("+(i)+")").find("td:nth-child(7)").find("#uniqueId").val(obj.uniqueidNo);
			}
    	}
    	
    }
    $("#addguestmodaltitle").text("Add Guest For Booking Number:"+bookingNumber);
	$("#bookingId").val(bookingId);		
	$("#bookingNumber").val(bookingNumber);	
	$("#addguestmodal").modal("show");
}


function addGuest(){
	//alert("ADDGUEST")
	
	var bookingId=$("#bookingId").val();		
	var bookingNumber=$("#bookingNumber").val();
	var roomBookingGuestList=[];
	var guestrow=$("#addguestmodaltablebody").find("tr");
	//console.log("GUESTROW IS",guestrow);
	//console.log(guestrow);
	$(guestrow).filter(function(i){
		//alert("FILTER TRIGGERS");
		if(i>0){
			var guestname=$(this).find("td:nth-child(1)").find("#guestname").val();
			var guestcontact=$(this).find("td:nth-child(2)").find("#guestcontact").val();
			var email=$(this).find("td:nth-child(3)").find("#email").val();
			var guestaddress=$(this).find("td:nth-child(4)").find("#guestaddress").val();
			var gender=$(this).find("td:nth-child(5)").find("#gender").val();
			var uniqueIdType=$(this).find("td:nth-child(6)").find("#uniqueIdType").val();
			var uniqueId=$(this).find("td:nth-child(7)").find("#uniqueId").val();
			if(guestname!="" /*&& guestcontact!="" && email!="" && guestaddress!=""*/ && gender!="" && uniqueId!=""  && uniqueIdType!=""){
				var roomBooking ={};
				roomBooking.id=bookingId;
				roomBooking.bookingNo=bookingNumber;
				roomBooking.hotelId=storeID;
				var roomBookingGuestObject={};
				roomBookingGuestObject.hotelId=storeID;
				roomBookingGuestObject.bookingNo=bookingNumber;
				roomBookingGuestObject.createdBy=customer.id;
				roomBookingGuestObject.createdDate=todaydate;
				roomBookingGuestObject.name=guestname;
				roomBookingGuestObject.contactNo=guestcontact;
				roomBookingGuestObject.emailId=email;
				roomBookingGuestObject.address=guestaddress;
				roomBookingGuestObject.gender=gender;
				roomBookingGuestObject.uniqueidType=uniqueIdType;
				roomBookingGuestObject.uniqueidNo=uniqueId;
				roomBookingGuestObject.roomBooking=roomBooking;
				//alert("ROOM BOOKING HOTEL ID IS:"+roomBooking.hotelId);
				//alert("GUEST OBJECT HOTEL ID IS:"+roomBookingGuestObject.hotelId);
				roomBookingGuestList.push(roomBookingGuestObject);
				
			}else{
				
				
			}
			
			
			
			
		}
		
		
	});
	if(roomBookingGuestList.length>0){
	addGuestAjax(roomBookingGuestList);	
	}
	
	
}

function addGuestAjax(roomBookingGuestList){
	//alert("addGuestAjax() IS CALLED");
	var bookingId=$("#bookingId").val();		
	var bookingNumber=$("#bookingNumber").val();
	//alert("BOOKING ID IN addGuestAjax FUNCTION IS:"+bookingId);
	//alert("BOOKING NUMBER IN addGuestAjax FUNCTION IS:"+bookingNumber);
	var msg="";
	var roomBooking ={};
	roomBooking.id=bookingId;
	roomBooking.bookingNo=bookingNumber;
	roomBooking.bookingGuest=roomBookingGuestList;
	roomBooking.hotelId=storeID;
	
	$.ajax({
		url : BASE_URL + "/guest/addRoomBookingGuest.htm",
		type : 'POST',
		async : false,
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(roomBooking),
		success : function(response) {
			obj = JSON.parse(response);
			if(obj.is_success){
				var guestbuttonhtml=$("#addguestmodalfooterdiv>button:nth-child(2)").html();
				msg =(guestbuttonhtml=="UPDATE GUEST")?"Succesfully updated the guest record":"Succesfully saved the guest record";
				$("#alertmodalbody").html(msg);
		        $("#alertmessagemodal").modal("show");
			}
			
		},
		error : function(error) {
			console.log("ERROR IN hotelBaseScript.js FILE FOR ADDING GUESTLIST IS:");
			console.log(error);
		}
	});
	
	
}

function getAllGuestList(bookingId){
	var res=null;
	//var bookingId=$("#bookingId").val();	
	var url = BASE_URL + "/guest/getRoomGuestByBookingId.htm";
	$.ajax({
		url :url,
		type : 'GET',
		headers: {"storeId": storeID,"bookingId":bookingId},
		contentType : 'application/json;charset=utf-8',
		async:false,
		success : function(response) {
			res=JSON.parse(response);
			console.log("RES getAllGuestList() FUNCTION  IS:");
			console.log(res);
		},
		error:function(error){
			console.log("ERROR IN hotelBaseScript.js FILE FOR getAllGuestList() FUNCTION  IS:");
			console.log(error);
		}
	});
	return res;
	
	
}
function selectServiceTypeMain(serviceId){
	var serviceId = $('#servicetype_0').val();
	/*
	 * if(serviceId=="NaN") { return "0"; }
	 */
	var qty = $('#serviceQty_0').val();
	var rate = 0.0;
	var isTax = 0;
	var taxRate = 0.0;
	var isSCharge = 0;
	var sChargeRate = 0.0;
	var roomServices = JSON.parse(roomservices);
	for(var i = 0; i<roomServices.length ; i++){
		if(roomServices[i].id == serviceId){
			rate = roomServices[i].rate;
			isTax = roomServices[i].isTaxable;
			taxRate = roomServices[i].taxRate;
			isSCharge = roomServices[i].isServiceChargable;
			sChargeRate = roomServices[i].serviceChargeRate;
		}
	}
	
	 $('#serviseRate_0').val(parseFloat(rate).toFixed(2));
	 
	 $('#serviceTaxRate_0').val(parseFloat(taxRate).toFixed(2));
	 $('#serviceGross_0').val(parseFloat(Number(rate)*Number(qty)).toFixed(2));
	 $('#serviceTaxAmt_0').val(parseFloat(((Number(rate)*Number(qty))*Number(taxRate))/100).toFixed(2));
	 $('#serviceNetamt_0').val(parseFloat((Number(rate)*Number(qty))+ ((Number(rate)*Number(qty))*Number(taxRate))/100).toFixed(2));
	
	
	
}
function selectServiceType(){
	var serviceId = $(this).closest('tr').find('.serviceType').val();
	var qty = $(this).closest('tr').find('.serviceqty').val();
	var rate = 0.0;
	var isTax = 0;
	var taxRate = 0.0;
	var isSCharge = 0;
	var sChargeRate = 0.0;
	var roomServices = JSON.parse(roomservices);
	for(var i = 0; i<roomServices.length ; i++){
		if(roomServices[i].id == serviceId){
			rate = roomServices[i].rate;
			isTax = roomServices[i].isTaxable;
			taxRate = roomServices[i].taxRate;
			isSCharge = roomServices[i].isServiceChargable;
			sChargeRate = roomServices[i].serviceChargeRate;
		}
	}
	
	$(this).closest('tr').find('.serviserate').val(parseFloat(rate).toFixed(2));
	$(this).closest('tr').find('.servicetaxrate').val(parseFloat(taxRate).toFixed(2));
	$(this).closest('tr').find('.servicegross').val(parseFloat(Number(rate)*Number(qty)).toFixed(2));
	$(this).closest('tr').find('.servicetaxamt').val(parseFloat(((Number(rate)*Number(qty))*Number(taxRate))/100).toFixed(2));
	$(this).closest('tr').find('.servicenetamount').val(parseFloat((Number(rate)*Number(qty))+ ((Number(rate)*Number(qty))*Number(taxRate))/100).toFixed(2));
	
	
	
	
}
function setNetAmt(){
	var rate = $(this).closest('tr').find('.serviserate').val();
	var qty =  $(this).closest('tr').find('.serviceqty').val();
	var taxRate = $(this).closest('tr').find('.servicetaxrate').val();
	
	var gross = Number(rate) * Number(qty);
	var taxAmt =( Number(gross) * Number(taxRate))/100;
	var netAmt = Number(gross) + Number(taxAmt);
	
	
	//$(this).closest('tr').find('.serviserate').val(parseFloat(rate).toFixed(2));
	$(this).closest('tr').find('.serviceqty').val(qty);
	//$(this).closest('tr').find('.servicetaxrate').val(parseFloat(taxRate).toFixed(2));
	$(this).closest('tr').find('.servicegross').val(parseFloat(gross).toFixed(2));
	$(this).closest('tr').find('.servicetaxamt').val(parseFloat(taxAmt).toFixed(2));
	$(this).closest('tr').find('.servicenetamount').val(parseFloat(netAmt).toFixed(2));
	
	
	
	
}

function setNetAmtMain(){
	var rate = $('#serviseRate_0').val();
	if(rate==""){rate=0.0;}
	var qty =  $('#serviceQty_0').val();
	var taxRate = $('#serviceTaxRate_0').val();
	if(taxRate==""){taxRate=0.0}
	var gross = Number(rate) * Number(qty);
	var taxAmt =( Number(gross) * Number(taxRate))/100;
	var netAmt = Number(gross) + Number(taxAmt);
	
	
	//$('#serviseRate_0').val(parseFloat(rate).toFixed(2));
	$('#serviceQty_0').val(qty);
	//$('#serviceTaxRate_0').val(parseFloat(taxRate).toFixed(2));
	$('#serviceGross_0').val(parseFloat(gross).toFixed(2));
	$('#serviceTaxAmt_0').val(parseFloat(taxAmt).toFixed(2));
	$('#serviceNetamt_0').val(parseFloat(netAmt).toFixed(2));
	
	
	
	
}
function numcheck(e) {
	// /$("#serviseRate_0").val("");
	// alert($("#serviseRate_0").val());
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
        (e.keyCode >= 35 && e.keyCode <= 40)) {  
    	
        return;
    }
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
    }
}
function remove() {
	
	$(this).closest('tr').remove();
}

function saveServices(){
	// debugger
	var roomId = null;
	var serviceId = null;
	var note = null;
	var rate = null;
	var qty = null;
	var amt = null;
	var taxrate = null;
	var taxamt = null;
	var netamt = null;
    var bookingId = document.getElementById("bookingIdForService").value; 
    var bookingNo = document.getElementById('reserveIdForService').value;
    
	var table = document.getElementById("tbl");
	
	var status = 0;
	var roomBooking1 = {};
		roomBooking1.id=bookingId;
		roomBooking1.bookingNo = bookingNo;
		roomBooking1.hotelId = storeID;
	var roomBookingServices =[];
	for ( var i = 1; i < table.rows.length; i++) {
        
		var id = i-1;
		roomId = document.getElementById("selectedRomm_"+id).value;
		serviceId = document.getElementById("servicetype_"+id).value;
		note = document.getElementById("serviceNote_"+id).value;
		rate = document.getElementById("serviseRate_"+id).value;
		qty = document.getElementById("serviceQty_"+id).value;
		amt = document.getElementById("serviceGross_"+id).value;
		taxrate = document.getElementById("serviceTaxRate_"+id).value;
		taxamt = document.getElementById("serviceTaxAmt_"+id).value;
		netamt = document.getElementById("serviceNetamt_"+id).value;
		
		if(taxrate == '' && taxamt == ''){
			taxamt = "0.0";
			taxrate = "0.0";
		}
		
		
		if ( rate == 0 || rate == "" || qty == 0 || qty == "") {
			document.getElementById("servicealertmsg").innerHTML = "Please Insert All Important Data!!!"; 
			status = 1;
			return 0;
		} else {
			document.getElementById("servicealertmsg").innerHTML = ""; 
			
			var roomBookingService = {};
			var roomBooking = {};
			var room = {};
			var roomServices = {};
			
			roomBookingService.bookingNo = bookingNo;
			room.id=roomId;
			roomBooking.id=bookingId;
			roomBooking.bookingNo=bookingNo;
			roomServices.id = serviceId;
			roomBookingService.room = room;
			roomBookingService.roomBooking = roomBooking;
			roomBookingService.roomServices=roomServices;
			roomBookingService.serviceNote = note;
			roomBookingService.serviceRate = rate;
			roomBookingService.serviceQty = qty;
			roomBookingService.grossAmount = amt;
			roomBookingService.discPer = 0.0;
			roomBookingService.discAmount = 0.0;
			roomBookingService.taxRate = taxrate;
			roomBookingService.taxAmount = taxamt;
			roomBookingService.serviceChargeRate = 0.0;
			roomBookingService.serviceChargeAmount = 0.0;
			roomBookingService.netAmount = netamt;
			roomBookingService.hotelId=storeID;
			
			roomBookingServices.push(roomBookingService);
			
		 }
		}
	   roomBooking1.bookingServices=roomBookingServices;
	   console.log(JSON.stringify(roomBooking1));	
	  
	   if(status == 0){
		   var ajaxCallObject = new CustomBrowserXMLObject();
			$.ajax({
				url : BASE_URL + '/checkout/addServices.htm',
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(roomBooking1),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					      location.href=BASE_URL+"/checkout/welcome.htm"
				  }
			 })
         }

	
}

var updateroomNosForService = [];
var updateroomIdsForService = [];
function openRoomServiceUpdateModal(bookingid,bookingNo,fromDate,toDate,roomsNos,roomIds){
	var status = 0;
	var roomlist = roomsNos.split(',');
	var roomids =  roomIds.split(',');
	updateroomNosForService =roomlist;
	updateroomIdsForService = roomids;
	
	var optionline = "";
	var startline ="<option value='" + 0+ "'>" + "Select Room" + "</option>";
	for ( var i = 0; i < updateroomNosForService.length; i++) {
		optionline += "<option value='" + updateroomIdsForService[i] + "'>" +updateroomNosForService[i]
				   + "</option>";
	}
	var roomServices = JSON.parse(roomservices);
	var startlineservice ="<option value='" + 0+ "'>" + "Select" + "</option>";
	var optionlineservice = "";
	for ( var i = 0; i < roomServices.length; i++) {
		optionlineservice += "<option value='" + roomServices[i].id + "'>" +roomServices[i].name
				             + "</option>";
	}
	
	
	document.getElementById('reserveIdForServiceUpdate').value = bookingNo;
	document.getElementById('bookingIdForServiceUpdate').value = bookingid;
	document.getElementById("updateservicealertmsg").innerHTML = ""; 
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/checkout/getRoomServicesByBookingId/"+bookingid + ".htm", function(response) {
		try{
			console.log(response);
			
			var serviceList =  JSON.parse(response);
			var createdrowlineupdateservice="";
			for(var i=0;i<serviceList.length;i++){
				var service = serviceList[i];
				
				var trStrat = "<tr  style='background: #404040; color: #FFF; margin-top: 2px;' id='"+i+"'>";
				var idtd = "<td style='color: #000;display:none;' align='center' id='serviceid_"+i+"'>"
							+service.id
							+"</td>";
				var roomtd = "<td style='color: #000' align='center'>"
							 +"<select id='selectRoom_"+i+"'  class='selectedrooms' required='required' style='padding: 2px'>"
					         +optionline
					         +"</select></td>";
				
				var servicetd = "<td style='color: #000' align='center'>"
		                         +"<select id='servicestype_"+i+"'  class='serviceType' required='required' style='padding: 2px' onchange=javascript:selectServiceTypeUpdate("+i+");>"
		                         +startlineservice + optionlineservice
		                         + "</select></td>";	           
					          
				var notetd = "<td align='center' style='color: #000;'>"
							 +"<input type='text' id='servicesNote_"+i+"' class='servicenote' style='width: 200px; padding: 2px;' value='"+service.serviceNote+"'>"
							 +"</td>";
				
				var ratetd = "<td style='color: #000' align='center'>"
							  +"<input type='text' id='servicesRate_"+i+"' name='servicerate' size='4' class='servicerate' required='required' onkeyup=javascript:setNetAmtUpdate("+i+"); onkeydown=javascript:numcheck(event); style='padding: 2px;width:100px;' value='"+parseFloat(service.serviceRate).toFixed(2)+"'>"
							  +"</td>";
				
				
				var qtytd = "<td align='center' style='color: #000;'>"
							+"<input type='text' id='servicesQty_"+i+"' value='"+service.serviceQty+"' class='serviceqty' style='width: 50px; padding: 2px;' onkeyup=javascript:setNetAmtUpdate("+i+"); onkeydown=javascript:numcheck(event);>"
							+"</td>";
				
				var amttd = "<td style='color: #000' align='center'>"
							+"<input readonly='readonly' type='text' id='servicesGross_"+i+"' class='servicegross' name='servicegross' style='padding: 2px;width:100px;' value='"+parseFloat(service.grossAmount).toFixed(2)+"'>"
							+"</td>";
				
				var taxratetd = "<td style='color: #000' align='center'>"
	        					+"<input type='text' id='servicesTaxRate_"+i+"' class='servicetaxrate' name='servicetaxrate' style='padding: 2px;width:50px;' onkeyup=javascript:setNetAmtUpdate("+i+"); onkeydown=javascript:numcheck(event); value='"+parseFloat(service.taxRate).toFixed(2)+"'>"
	        					+"</td>";
				
				var taxamttd = "<td style='color: #000' align='center'>"
	        	               +"<input readonly='readonly' type='text' id='servicesTaxAmt_"+i+"' class='servicetaxamt' name='servicetaxamt' style='padding: 2px;width:100px;' value='"+parseFloat(service.taxAmount).toFixed(2)+"'>"
	        	               +"</td>";
				
				var netamttd = "<td style='color: #000' align='center'>"
 	               				+"<input readonly='readonly' type='text' id='servicesNetamt_"+i+"' class='servicenetamount' name='servicenetamount' style='padding: 2px;width:100px;' value='"+parseFloat(service.netAmount).toFixed(2)+"'>"
 	               				+"</td>";
				
				var removetd = "<td align='center' style='color: #000;'>"
					           +"<input type='button' class='btn btn-danger' value='X' onclick='javascript:removeUpdate("+i+")'>"
					           +"</td>";
				
				var endtr = "</tr>";
				
				createdrowlineupdateservice += trStrat + idtd + roomtd + servicetd + notetd + ratetd + qtytd + amttd + taxratetd + taxamttd + netamttd + removetd +endtr;
				
			}
			$("#tblbdy").html(createdrowlineupdateservice);
			for(var j=0;j<serviceList.length;j++){
				var service = serviceList[j];
				$("#selectedRomm_"+j).val(service.room.id);
				$("#servicestype_"+j).val(service.roomServices.id);
			}
			document.getElementById("updateservicealertmsg").innerHTML = ""; 
			$("#updateRoomServiceModal").modal("show");
			
		}catch(e)
		{
			alert(e);
		}
		}, null);
	
	
		
	}

function removeUpdate(id){
	$("#" + id + "").remove();
	
}


function selectServiceTypeUpdate(id){
	var serviceId = $('#servicestype_'+id).val();
	var qty = $('#servicesQty_'+id).val();
	var rate = 0.0;
	var isTax = 0;
	var taxRate = 0.0;
	var isSCharge = 0;
	var sChargeRate = 0.0;
	var roomServices = JSON.parse(roomservices);
	for(var i = 0; i<roomServices.length ; i++){
		if(roomServices[i].id == serviceId){
			rate = roomServices[i].rate;
			isTax = roomServices[i].isTaxable;
			taxRate = roomServices[i].taxRate;
			isSCharge = roomServices[i].isServiceChargable;
			sChargeRate = roomServices[i].serviceChargeRate;
		}
	}
	
	 $('#servicesRate_'+id).val(parseFloat(rate).toFixed(2));
	 $('#servicesTaxRate_'+id).val(parseFloat(taxRate).toFixed(2));
	 $('#servicesGross_'+id).val(parseFloat(Number(rate)*Number(qty)).toFixed(2));
	 $('#servicesTaxAmt_'+id).val(parseFloat(((Number(rate)*Number(qty))*Number(taxRate))/100).toFixed(2));
	 $('#servicesNetamt_'+id).val(parseFloat((Number(rate)*Number(qty))+ ((Number(rate)*Number(qty))*Number(taxRate))/100).toFixed(2));
	
}



function setNetAmtUpdate(id){
	var rate = $('#servicesRate_'+id).val();
	var qty =  $('#servicesQty_'+id).val();
	var taxRate = $('#servicesTaxRate_'+id).val();
	
	var gross = Number(rate) * Number(qty);
	var taxAmt =( Number(gross) * Number(taxRate))/100;
	var netAmt = Number(gross) + Number(taxAmt);
	
	
	//$('#servicesRate_'+id).val(parseFloat(rate).toFixed(2));
	$('#servicesQty_'+id).val(qty);
	//$('#servicesTaxRate_'+id).val(parseFloat(taxRate).toFixed(2));
	$('#servicesGross_'+id).val(parseFloat(gross).toFixed(2));
	$('#servicesTaxAmt_'+id).val(parseFloat(taxAmt).toFixed(2));
	$('#servicesNetamt_'+id).val(parseFloat(netAmt).toFixed(2));
		
}


function updateServices(){
	var roomId = "";
	var serviceId = "";
	var note = "";
	var rate = "";
	var qty = "";
	var amt = "";
	var taxrate = "";
	var taxamt = "";
	var netamt = "";
	var sid ="";
    var bookingId = document.getElementById("bookingIdForServiceUpdate").value; 
    var bookingNo = document.getElementById('reserveIdForServiceUpdate').value;
    
	var table = document.getElementById("updatetbl");
	
	var status = 0;
	var roomBooking1 = {};
		roomBooking1.id=bookingId;
		roomBooking1.bookingNo = bookingNo;
		roomBooking1.hotelId = storeID;
	var roomBookingServices =[];
	
	$('#updatetbl > tbody  > tr').each(function() {
		var trid = this.id;
		roomId = document.getElementById("selectRoom_"+trid).value;
		serviceId = document.getElementById("servicestype_"+trid).value;
		note = document.getElementById("servicesNote_"+trid).value;
		rate = document.getElementById("servicesRate_"+trid).value;
		qty = document.getElementById("servicesQty_"+trid).value;
		amt = document.getElementById("servicesGross_"+trid).value;
		taxrate = document.getElementById("servicesTaxRate_"+trid).value;
		taxamt = document.getElementById("servicesTaxAmt_"+trid).value;
		netamt = document.getElementById("servicesNetamt_"+trid).value;
		
		if(taxrate == '' && taxamt == ''){
			taxamt = "0.0";
			taxrate = "0.0";
		}
		
		
		if ( rate == 0 || rate == "" || qty == 0 || qty == "") {
			document.getElementById("updateservicealertmsg").innerHTML = "Please Insert All Important Data!!!"; 
			status = 1;
			return 0;
		} else {
			document.getElementById("updateservicealertmsg").innerHTML = ""; 
			
			var roomBookingService = {};
			var roomBooking = {};
			var room = {};
			var roomServices = {};
			
			roomBookingService.bookingNo = bookingNo;
			room.id=roomId;
			roomBooking.id=bookingId;
			roomBooking.bookingNo=bookingNo;
			roomServices.id = serviceId;
			roomBookingService.room = room;
			roomBookingService.roomBooking = roomBooking;
			roomBookingService.roomServices=roomServices;
			roomBookingService.id=0;
			roomBookingService.serviceNote = note;
			roomBookingService.serviceRate = rate;
			roomBookingService.serviceQty = qty;
			roomBookingService.grossAmount = amt;
			roomBookingService.discPer = 0.0;
			roomBookingService.discAmount = 0.0;
			roomBookingService.taxRate = taxrate;
			roomBookingService.taxAmount = taxamt;
			roomBookingService.serviceChargeRate = 0.0;
			roomBookingService.serviceChargeAmount = 0.0;
			roomBookingService.netAmount = netamt;
			roomBookingService.hotelId=storeID;
			
			roomBookingServices.push(roomBookingService);
			
		    }
	  });
	  roomBooking1.bookingServices=roomBookingServices;
	  console.log(JSON.stringify(roomBooking1));	
	  if(status == 0){
		   var ajaxCallObject = new CustomBrowserXMLObject();
			$.ajax({
				url : BASE_URL + '/checkout/addServices.htm',
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(roomBooking1),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					      location.href=BASE_URL+"/checkout/welcome.htm"
				  }
			 })
         }
	
	
}



function addNewRow(updatetbl){
	var table = document.getElementById(updatetbl);
	var rowCount = table.rows.length;
	var i = rowCount - 1;
	var optionline = "";
	var startline ="<option value='" + 0+ "'>" + "Select Room" + "</option>";
	for ( var j = 0; j < updateroomNosForService.length; j++) {
		optionline += "<option value='" + updateroomIdsForService[j] + "'>" +updateroomNosForService[j]
				   + "</option>";
	}
	var roomServices = JSON.parse(roomservices);
	var startlineservice ="<option value='" + 0+ "'>" + "Select" + "</option>";
	var optionlineservice = "";
	for ( var k = 0; k < roomServices.length; k++) {
		optionlineservice += "<option value='" + roomServices[k].id + "'>" +roomServices[k].name
				             + "</option>";
	}
	
 	var trStrat = "<tr  style='background: #404040; color: #FFF; margin-top: 2px;' id='"+i+"'>";
	var roomtd = "<td style='color: #000' align='center'>"
				 +"<select id='selectRoom_"+i+"'  class='selectedrooms' required='required' style='padding: 2px'>"
		         +optionline
		         +"</select></td>";
	
	var servicetd = "<td style='color: #000' align='center'>"
                     +"<select id='servicestype_"+i+"'  class='serviceType' required='required' style='padding: 2px' onchange=javascript:selectServiceTypeUpdate("+i+");>"
                     +startlineservice + optionlineservice
                     + "</select></td>";	           
		          
	var notetd = "<td align='center' style='color: #000;'>"
				 +"<input type='text' id='servicesNote_"+i+"' class='servicenote' style='width: 200px; padding: 2px;' value=''>"
				 +"</td>";
	
	var ratetd = "<td style='color: #000' align='center'>"
				  +"<input type='text' id='servicesRate_"+i+"' name='servicerate' size='4' class='servicerate' required='required' onkeyup=javascript:setNetAmtUpdate("+i+"); onkeydown=javascript:numcheck(event); style='padding: 2px;width:100px;' value=''>"
				  +"</td>";
	
	
	var qtytd = "<td align='center' style='color: #000;'>"
				+"<input type='text' id='servicesQty_"+i+"' value='1' class='serviceqty' style='width: 50px; padding: 2px;' onkeyup=javascript:setNetAmtUpdate("+i+"); onkeydown=javascript:numcheck(event);>"
				+"</td>";
	
	var amttd = "<td style='color: #000' align='center'>"
				+"<input readonly='readonly' type='text' id='servicesGross_"+i+"' class='servicegross' name='servicegross' style='padding: 2px;width:100px;' value=''>"
				+"</td>";
	
	var taxratetd = "<td style='color: #000' align='center'>"
					+"<input type='text' id='servicesTaxRate_"+i+"' class='servicetaxrate' name='servicetaxrate' style='padding: 2px;width:50px;' onkeyup=javascript:setNetAmtUpdate("+i+"); onkeydown=javascript:numcheck(event); value=''>"
					+"</td>";
	
	var taxamttd = "<td style='color: #000' align='center'>"
	               +"<input readonly='readonly' type='text' id='servicesTaxAmt_"+i+"' class='servicetaxamt' name='servicetaxamt' style='padding: 2px;width:100px;' value=''>"
	               +"</td>";
	
	var netamttd = "<td style='color: #000' align='center'>"
       				+"<input readonly='readonly' type='text' id='servicesNetamt_"+i+"' class='servicenetamount' name='servicenetamount' style='padding: 2px;width:100px;' value=''>"
       				+"</td>";
	
	var removetd = "<td align='center' style='color: #000;'>"
		           +"<input type='button' class='btn btn-danger' value='X' onclick='javascript:removeUpdate("+i+")'>"
		           +"</td>";
	
	var endtr = "</tr>";
		
	var createdrowlineupdateservice = trStrat  + roomtd + servicetd + notetd + ratetd + qtytd + amttd + taxratetd + taxamttd + netamttd + removetd +endtr;
	$("#tblbdy").append(createdrowlineupdateservice);
			
 }

function showCustImage(custId)
{
	$("#modroombookCustimgUploadalertMsg").html("");
	$('#custimg').attr('src', '');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/customer/getCustomerDetailsById/" + custId
			+ ".htm", function(response){
		
		 var customerDetails = JSON.parse(response);
		$('#custimgid').val(custId);
		$('#custimgName').val(customerDetails.name);
		$('#custimgPhone').val(customerDetails.contactNo);
		
			});
	$.ajax({
		url : BASE_URL+'/room/getCustImageById.htm',
		type : "GET",
		data : {
			id : custId
		},
		success : function(data) {
			console.log("data=" + data);
			if(data=='failure'){
				$('#custimg').attr('src', BASE_URL+'/assets/images/menu/a/noimage.png');
			}else{
				$('#custimg').attr('src', data);
			}
			
		},
		error : function(error) {
			alert('error: ' + error.message);
		}
	});
	$('#showcustImgModal').modal('show');
}

function closeCustImage(){
	$('#showcustImgModal').modal('hide');
}

function uploadCustImg()
{
	var photofile=$("#fileUpload")[0].files[0];
	var custId=$("#custimgid").val()
	var formData = new FormData();
	formData.append('file', $("#fileUpload")[0].files[0]); 
	formData.append('id', $("#custimgid").val());
	if(photofile!=undefined)
		{
		var res=UploadCustImage(formData);
		if(res.is_upload){
			 $("#modroombookCustimgUploadalertMsg").html("Image Uploaded Successfully");
		 }else{
			 var msg=res.errormsg;
			 $("#modroombookCustimgUploadalertMsg").html(msg);
		 }		
		}
	else
		{
		$("#modroombookCustimgUploadalertMsg").html("File can't be blank");
		}
	
	
}

function UploadCustImage(formData){
	var res='';
	var url='';
       url=BASE_URL + "/room/uploadCustImage.htm";
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
			console.log("ERROR IN hotelbaseScript.js FILE FOR UPLOADING  CUSTOMER IMAGE OR DOCUMENT IS:");
			console.log(error);
		}
	});
	
	
	return res;
	
	
}