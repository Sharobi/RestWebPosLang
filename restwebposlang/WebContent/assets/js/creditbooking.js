$(document).ready(function() {
		$('#creditcustomerlisttable').DataTable( {
		        paging:true,
		        "info": false,
		    });
		
		$("#exactamountincashmodal").click(function(){
			var amounttopay=$("#amounttopayincashmodal").html();
			$("#cashtenderAmtinCashModal").val(amounttopay);
		});
		
		
		/*$("#cashpaymenttabletbody>tr>td").click(function(){
			
			var sel=this;
			var td=$(this).html();
			var tdindex=$(this).index();
			console.log("SELECTED TD IS:");
			console.log(td);
			console.log("TD VALUE IS:");
			console.log($(td).html());
			console.log("INDEX OF TD IS:");
			console.log($(this).index());
			
			
		});*/
		//$("#numero100").click()

});
$(document).on("click","#creditcustomerbookingbody>tr>td:nth-child(6)>i:nth-child(1)",function(){
	//alert("CLICKED CASH SELECTION");
	var i=this;
	//console.log("I IS:");
	//console.log(i);
	$("#printbillcheckbox").prop("checked",false);
	var tr=$(this).parent().parent();
	var bookingid=$(tr).attr("id");
	var bookingNumber=$(tr).find("td:nth-child(1)").html();
	var totalamount=$(tr).find("td:nth-child(3)").html();
	var paidamount=$(tr).find("td:nth-child(4)").html();
	var amounttopay=$(tr).find("td:nth-child(5)").html();
	$("#paytypeid").val(1);
	$("#paymentmodeincashmodal").html("CASH");
	$("#totalamountincashmodal").html(totalamount);
	$("#amounttopayincashmodal").html(amounttopay);
	$("#paidamountincashmodal").html(paidamount);
	$("#cashModalHeaderSpanForBookingNumber").html(bookingNumber);
	$("#bookingId").val(bookingid);
	$("#paymentmodeincashmodal").val("CASH");
	$("#cashModal").modal("show");
	
});
$(document).on("click","#creditcustomerbookingbody>tr>td:nth-child(6)>i:nth-child(2)",function(){
	//alert("CLICKED CREDIT CARD SELECTION");
	var i=this;
	$("#printbillcheckbox").prop("checked",false);
	var tr=$(this).parent().parent();
	var bookingid=$(tr).attr("id");
	$("#bookingId").val(bookingid);
	var bookingNumber=$(tr).find("td:nth-child(1)").html();
	var totalamount=$(tr).find("td:nth-child(3)").html();
	var paidamount=$(tr).find("td:nth-child(4)").html();
	var amounttopay=$(tr).find("td:nth-child(5)").html();
	$("#totalamountincashmodal").html(totalamount);
	$("#amounttopayincashmodal").html(amounttopay);
	$("#paidamountincashmodal").html(paidamount);
	$("#cashModalHeaderSpanForBookingNumber").html(bookingNumber);
	$("#paytypeid").val(2);
	$("#cardNoDiv").removeClass("hide");
	$("#paymentmodeincashmodal").html("CARD");
	$("#paymentmodeincashmodal").val("CARD");
	$("#cashModal").modal("show");
	
});

function getCreditBookingByCustomerId(custId,custname,custcontact){
	
	$("#creditcustomerbookingbody").empty();
	//$("#creditcustomerbookingdetailsdiv").addClass("hide");
	//$("#waitimage").removeClass("hide");
	//alert("WAITIMAGE DIV CLASS BEFORE FETCVHING DATA IS:"+$("#waitimage").attr("class"));
	
	var spans=$("#customerdisplaydiv>#div1").find("span");
	$(spans[0]).html(custname);
	$(spans[1]).html(custcontact);
	var netbillamount=0;
	var netadvancepayment=0;
	var res=getCreditBookingByCustomerIdData(custId);
	console.log("RES IN getCreditBookingByCustomerIdData(custId) FUNCTION IN creditbvooking.js FILE IS: ");
	console.log(res);
	
	if(res!=null && res!="" && res.length>0){
		//alert("RES IS NOT NULL");
		//$("#creditcustomerbookingdetailsdiv").addClass("hide");
		//$("#waitimage").addClass("hide");
		//alert("WAITIMAGE DIV CLASS IS:"+$("#waitimage").attr("class"))
		//$("#waitimage").removeClass("hide");
		//$("#creditordertableContId").removeClass("hide");
		for(var i=0;i<res.length;i++){
			var temp=res[i];
			var bookingId=temp.id;
			var paymentdetailslist=getCreditBookingPaymentInfoByBookingIdData(bookingId);
			var lastpaymentobj=paymentdetailslist[paymentdetailslist.length-1];
			var paidAmount=lastpaymentobj.amount-lastpaymentobj.amt_to_pay;
			var dueamount=lastpaymentobj.amt_to_pay;
			var netbillamount=lastpaymentobj.amount;
			var bookingNo=temp.bookingNo;
			var bookingDetailList=temp.bookingDetail;
			var bookingDate=temp.bookingDate;
			bookingDate=moment(bookingDate).format("YYYY-MM-DD");
			
			/*for(var j=0;j<bookingDetailList.length;j++){
				
				var obj=bookingDetailList[j];
				var netTotal=obj.netTotal;
				var advPayment=obj.advPayment;
				netbillamount=netbillamount+netTotal;
				netadvancepayment=netadvancepayment+advPayment;
				
			}*/
			
			
			var tr=createTableRow(bookingNo,bookingDate,netbillamount,paidAmount,dueamount,bookingId);
			if(tr!=""){
				$("#creditcustomerbookingbody").append(tr);
			}else{
				
			}
			
		}
		
	}else{
		//$("#waitimage").addClass("hide");
		var tr = '<tr style="background:#404040; color:#FFF;">'+
		'                                        			<td colspan="6">No Data found!</td>'+
		'                                        		</tr>';
			
		$("#creditcustomerbookingbody").append(tr);
		
		
	}
	
}
function numericcheckForAddRoomModal(e) {
	  
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
        (e.keyCode >= 35 && e.keyCode <= 40)) {  
        return;
    }
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
    }
}
function createTableRow(bookingNo,bookingDate,netbillamount,paidAmount,dueamount,bookingId){
	var tr="";

	var printbuttontd = '<td align="center"><a'+
	'															href="javascript:printPaidBill("${checkedinCustomer.id}",1)">'+
	'																<i class="fa fa-print" aria-hidden="true"'+
	'																style="font-size: 30px; color: white; margin-left: 10px;"></i>'+
	'														</a></td>';
		

	 tr=tr+'<tr style="background:#404040; color:#FFF;" '+'id='+bookingId+'>';
	tr=tr+'<td align="center">'+bookingNo+'</td>'
	tr=tr+'<td align="center">'+bookingDate+'</td>'
	tr=tr+'<td align="center">'+netbillamount+'</td>'
	tr=tr+'<td align="center">'+paidAmount+'</td>'
	tr=tr+'<td align="center">'+dueamount+'</td>'
	tr=tr+'<td align="center" id="paymenttd">'+'<i class="fa fa-money cursorpointer" aria-hidden="true" style="font-size: 30px; color: white;"></i>'+'<i class="fa fa-credit-card cursorpointer" aria-hidden="true" style="font-size: 26px; color: white; margin-left: 10px; top: -1px;position:relative;"></i>'+'</td>'
	//tr=tr+printbuttontd
	
	return tr;
	/*var trows=$("#creditcustomerbookingbody").find("tr");
	
	if(trows.length>0){
		$("#waitimage").addClass("hide");
		
	}*/
	
}
/*function payBillInCash(amount)
{ 
	var bookingId=$("#bookingId").val();
	var paymentMode=$("#paymentmodeincashmodal").val();
	var dr_legder_id=$("#dr_legder_id").val();
	var cr_legder_id= $("#cr_legder_id").val();
	//alert("DR LEDGER ID IS:"+dr_legder_id);
	//alert("CR LEDGER ID IS:"+cr_legder_id);
	//alert("BOOKING ID WHILE PAYING IS:"+bookingId);
	var roomBookingPayment = {};
	//roomBookingPayment.reserveId =reserveId;
	roomBookingPayment.booking_id = bookingId;
	roomBookingPayment.tenderamount = amount;
	roomBookingPayment.paymentMode = paymentMode;
	
	$.ajax({
		url : BASE_URL + "/customer/advancePayment.htm",
		type : 'POST',
		async:false,
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(roomBookingPayment),
		success : function(response) {
			if(response=="success"){
				var msg="Advance Payment is done Succesfully ";
				$("#alertmodalbody").html(msg);
		        $("#alertmessagemodal").modal("show");
			}
		},
		error:function(error){
			console.log("ERROR IN creditbooking.js FILE FOR PAYING IN CASH IS:");
			console.log(error);
		}
	});
	
	
	
	
	
}*/
function getCreditBookingByCustomerIdData(custId){
	//$("#waitimage").removeClass("hide");
	var res=null;
	var url="";
	url=BASE_URL + "/room/getCreditBookingByCustomerId.htm";
	$.ajax({
		url :url,
		type : 'GET',
		headers: {"storeId": storeID,"custId":custId},
		contentType : 'application/json;charset=utf-8',
		async:false,
		beforeSend: function(){
			//$("#waitimage").removeClass("hide");
			
		},
		complete: function() {
			//$("#waitimage").addClass("hide");
			//var trows=$("#creditcustomerbookingbody").find("tr");
			//$("#waitimage").addClass("hide");
            /*if(res!=null && res!=""){
				$("#waitimage").addClass("hide");
			}*/
			/*if(trows.length>0){
				
				$("#waitimage").addClass("hide");
			}else{
				
				
			}*/
	        //$("#waitimage").addClass("hide");
	    },
		success : function(response) {
			res=JSON.parse(response);
			
			/*if(res!=null && res!=""){
				$("#waitimage").addClass("hide");
				$("#creditordertableContId").removeClass("hide");
			}*/
			//console.log("RES getCreditBookingByCustomerIdData() FUNCTION  IN creditbooking.js FILE IS:");
			//console.log(res);
			//$("#waitimage").addClass("hide");
		},
		error:function(error){
			console.log("ERROR IN creditbooking.js FILE FOR getCreditBookingByCustomerIdData() FUNCTION IS:");
			console.log(error);
		}
	});
	return res;
	
}


function getCreditBookingPaymentInfoByBookingIdData(bookingId){
	
	var res=null;
	var url="";
	url= BASE_URL+"/room/getPaymentInfoByBookingId.htm";
	$.ajax({
		url :url,
		type : 'GET',
		headers: {"bookingId": bookingId},
		contentType : 'application/json;charset=utf-8',
		async:false,
		success : function(response) {
			res=JSON.parse(response);
			//console.log("RES getCreditBookingPaymentInfoByBookingIdData(bookingId) FUNCTION  IN creditbooking.js FILE IS:");
			//console.log(res);
		},
		error:function(error){
			console.log("ERROR IN creditbooking.js FILE FOR getCreditBookingPaymentInfoByBookingIdData(bookingId) FUNCTION IS:");
			console.log(error);
		}
	});
	return res;
	
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

//$('#pleasewaitModal').modal('show');
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
function getRoomBookingDetailsByBookingNumber(bookingId){
	var res=null;
	$
	.ajax({
		url :BASE_URL + "/checkout/bookingidetbybookingid/" + bookingId + ".htm", 
		type : 'GET',
		async:false,
		contentType : 'application/json;charset=utf-8',
		success : function(response) {
			   res=JSON.parse(response);
			
		},
		error:function(error){
			console.log("ERROR IN creditbooking.js FILE IN getBillDetailsByBookingNumber(bookingId) FUNCTION IS:");
			console.log(error);
		}
	});
	return res;
}

function payBillInCash(amount)
{  
	// var bookingId=document.getElementById('hiddenbookingid').value;
	var bookingId=$("#bookingId").val();
	//alert("BOOKING ID IS:"+bookingId);
	var paymentMode=$("#paymentmodeincashmodal").val();
	var paymentTypeId=$("#paytypeid").val();
	var cardLastFourDigits=$("#cardlastfourDigit").val();
	var bookingdetailslistjson=getRoomBookingDetailsByBookingNumber(bookingId);
	var isprintbill=$("#printbillcheckbox").prop("checked");
	//console.log("BOOKING DETAILS LIST JSON IS:");
	//console.log(bookingdetailslistjson);
	
	// alert("bookingId:"+bookingId);
	//var amttopay=document.getElementById('cashamttopaycontId').innerHTML;
	//var totalAmt = document.getElementById('cashtotamtcontId').innerHTML;
	//var tenderamt=document.getElementById('cashtenderAmt').value;
	//var reserveId = document.getElementById('hiddenadvpaycustdataopmassagecont1').value;
	//var paymentMode = document.getElementById('onlineselpaymenttype').innerHTML;
	//var paymentTypeId = document.getElementById('paytypeid').value;
	//var cardLastDigits = document.getElementById('cardlastfourDigit').value;
	//var discamt = document.getElementById('discamt').value;
	//var taxamt = document.getElementById('taxamount').value;
	//var grossAmt = document.getElementById('grossamount').value;
	
	//var roomServiceGross = document.getElementById('roomServiceGross').value;
	//var roomServiceTax = document.getElementById('roomServiceTax').value;
	//var roomServiceDiscount = document.getElementById('roomServiceDiscount').value;
	
	//var greaterValue=0;
	/*if(amttopay== totalAmt){
		greaterValue=totalAmt;
	}
	else if(amttopay== 0.0){
		greaterValue=amttopay;
	}
	else{
		greaterValue = amttopay;       // totalAmt >= amttopay ? totalAmt :
										// amttopay;
	}*/
	
	var roomBookingPayment = {};
	//roomBookingPayment.reserveId =reserveId;
	roomBookingPayment.booking_id = bookingId;
	roomBookingPayment.tenderamount = amount;
	roomBookingPayment.paymentMode = paymentMode;
	if(paymentTypeId == 2){
	  roomBookingPayment.cardLastFourDigits = cardLastFourDigits;
	}
	else{ 
      roomBookingPayment.cardLastFourDigits = "xxxx";
	}
	//roomBookingPayment.discAmt=(Number(discamt) + Number(roomServiceDiscount)).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
	//roomBookingPayment.taxVatAmt=(Number(taxamt)+Number(roomServiceTax)).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
	//roomBookingPayment.grossAmt=(Number(grossAmt)+Number(roomServiceGross)).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
	
	
	/*if(Number(tenderamt)<=Number(greaterValue)){*/
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
	    console.log("SALE LEDGER ID IS:",sale_ledger_id);
	    console.log("DUTIES LEDGER ID IS:",duties_ledger_id);
	    console.log("ROUND LEDGER ID IS:",round_ledger_id);
	    console.log("DISCOUNT LEDGER ID IS:",discount_ledger_id);
	    console.log("DEBITOR CASH LEDGER ID IS:",debitor_cash_ledger_id);
	    console.log("SERVICE CHARGE LEDGER ID IS:",service_charge_ledger_id);
	    console.log("CARD LEDGER ID IS:",card_ledger_id);
	     
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
		var bookingdetailobj=bookingdetailslistjson[0];
		
		var netdiscount=bookingdetailobj.discAmt+bookingdetailobj.roomServiceDiscount;
		var nettax=bookingdetailobj.taxAmt+bookingdetailobj.roomServiceTax;
		var netgrossamount=bookingdetailobj.grossAmt+bookingdetailobj.roomServiceGross;
		console.log("NET DISCOUNT IS",netdiscount);
		console.log("NET TAX IS",nettax);
		console.log("NET GROSS AMOUNT IS",netgrossamount);
		roomBookingPayment.discAmt=netdiscount;
		roomBookingPayment.taxVatAmt=nettax;
		roomBookingPayment.grossAmt=netgrossamount;
		/*roomBookingPayment.discAmt=(Number(discamt) + Number(roomServiceDiscount)).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
		roomBookingPayment.taxVatAmt=(Number(taxamt)+Number(roomServiceTax)).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
		roomBookingPayment.grossAmt=(Number(grossAmt)+Number(roomServiceGross)).toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];*/
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjaxPost(BASE_URL + "/customer/advancePayment.htm", roomBookingPayment, function(response) {
		   try {
					if (response == 'success') {
						//document.getElementById('catdataopmassagecont').innerHTML = 'Advance Payment Successfully done.' ;
						//$('#cashModal').modal('hide');
						//showalertcatdataopModal();
						//alert("SUCCESS");
						
						if(isprintbill){
							printPaidBill(bookingId,paymentTypeId);
						}
						var msg="Payment is done Succesfully ";
						$("#alertmodalbody").html(msg);
				        $("#alertmessagemodal").modal("show");
				}
				else
				{
					//document.getElementById('catdataopmassagecont').innerHTML =  "Advance Payment Unsuccessful. Please try again!";
					//$('#cashModal').modal('hide');
					//showalertcatdataopModal();
				}
				
			} catch (e) {
				alert(e);
			}
		
           }, null);
		
		
		
	/*}*/
	/*else if(tenderamt == 0)
	{
		document.getElementById('paycashalertMsg').innerHTML='Tender Amount should not be empty';

	}
	else
		{
		document.getElementById('paycashalertMsg').innerHTML='Tender Amount should be less than or equal to Amount to pay';

		}*/
	
	
}


function printPaidBill(bookingId,mode)
{ 
	// alert(bookingId);
	// alert("printPaidBill() IS CALLED IN hotelBaseScript.js FILE");
	//alert("MODE IS:"+mode);
	mode=1;
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






function printCashOrCardLocal2100New(){
	 var divToPrint = document.getElementById('printDiv2100GSTNew');
	 newWin = window.open("");
	 newWin.document.write(divToPrint.outerHTML);
	 newWin.focus();
	 newWin.print();
	 newWin.close();	
	
}