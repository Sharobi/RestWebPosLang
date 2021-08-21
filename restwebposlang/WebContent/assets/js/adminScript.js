/*start menu category management*/
//[^a-zA-Z0-9\.\-\_\,\ ]/gi
/*function addCategory()
 {
 document.getElementById('addalertMsg').innerHTML='';
 var catName=decodeURIComponent(document.getElementById('addcategorynameContId').value);
 var bgColor=decodeURIComponent(document.getElementById('addbgcolorContId').value);
 if(catName=='' || bgColor=='')
 {
 document.getElementById('addalertMsg').innerHTML= getLang.failtoReq;
 }
 else if((/[#%?\/\\]/gi).test(catName) || (/[#%?\/\\]/gi).test(bgColor))
 {
 document.getElementById('addalertMsg').innerHTML= getLang.charNotAlowd;
 }
 else
 {
 var ajaxCallObject = new CustomBrowserXMLObject();
 ajaxCallObject.callAjax(BASE_URL + "/menumgnt/addmenucategory/" + catName + "/" + bgColor + ".htm", function(response) {
 closenmenucataddModal();
 if(response== success)
 {
 document.getElementById('catdataopmassagecont').innerHTML=getLang.datasucAdd;
 showalertcatdataopModal();
 }
 else{
 document.getElementById('catdataopmassagecont').innerHTML=getLang.datasucNotAdd;
 showalertcatdataopModal();
 }
 //location.href=BASE_URL+'/menumgnt/viewmenumgnt.htm';
 }, null);
 }
 }*/

var cellid = 1; // new 16.5.2018

function showunpaidOrdersList(date,storeId)
{
	var todaydate=document.getElementById('hiddenunpaidorderList').value;
	if(dateformat(date)>dateformat(todaydate))
		{
		showalertunpaidorderModal();
		document.getElementById('dateunpaidorderList').value=todaydate;
		}
	else{
		
		location.href=BASE_URL+'/unpaidorderlist/unpaidorderSpecificDate.htm?storeId='+storeId+'&date='+date;	
	}
}

function showunpaidOrdersListPeriodWise(fromdate,todate,storeId)
{
	//var todaydate=document.getElementById('hiddenunpaidorderList').value;
	if(dateformat(fromdate)>dateformat(todate))
		{
		//alert('bigger');
		showalertunpaidorderModalBiggerFromDate();
		}
	else{
		
		location.href=BASE_URL+'/unpaidorderlist/unpaidorderPeriodWise.htm?storeId='+storeId+'&fromdate='+fromdate+'&todate='+todate;	
	}
}

function showCurrentDateUnpaidOrders()
{
	var todaydate=document.getElementById('hiddenunpaidorderList').value;
	document.getElementById('fromdateunpaidorderList').value=todaydate;
	document.getElementById('todateunpaidorderList').value=todaydate;
	location.href=BASE_URL+'/unpaidorderlist/unpaidorderPeriodWise.htm?storeId='+storeId+'&fromdate='+todaydate+'&todate='+todaydate;
}

var netTotal=0.0;
var pmntTotAmt=null;
var hidstoreroundoffflag=document.getElementById('hidstoreroundoffFlag').value;
var storedoubleroundoffflag=document.getElementById('hidstoredoubleroundoffFlag').value;
var paidAmnt=0.0;
var amntToPay=0.0;

var totCashPrice= null;
var netCashPrice= null;
var netCashTotal= null;


function openCashModal(totPrice,netPrice,netTotal)
{
	checkOrderPaymentStatus();
	netPrice=netPriceFromCheckOrder;
	
	var storebaseordernumber = $("#unpaidorderstrbaseorderno_"+currentId).val(); 

	totCashPrice=totPrice;
	netCashPrice=netPrice;
	netCashTotal=netTotal;
	
		var temppaidAmt=0.0;
		document.getElementById('cashtenderAmt').value='';
		document.getElementById('paycashalertMsg').innerHTML='';
	//	document.getElementById('cashchangeamtcontId').innerHTML='0.00';
		var tableno=document.getElementById('tablenoCont').innerHTML;
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/unpaidorderlist/getpaymentinfo/"+currentId + ".htm", function(response) {
			try{
				var responseObj=[];
				responseObj=JSON.parse(response);
				
				for(var i=0;i<responseObj.length;i++)
				{
					temppaidAmt+=responseObj[i].paidAmount;
				}
				
				paidAmnt=temppaidAmt;
				netTotal=netCashTotal;

				if(roundOffTotalAmtStatus== 'Y')
				{
					pmntTotAmt=parseFloat(totPrice +0.5 - ((totPrice+0.5) % 1)).toFixed(2);
					amntToPay=parseFloat(netPrice +0.5 - ((netPrice+0.5) % 1)).toFixed(2);
				}

				if(roundOffTotalAmtStatus== 'N')
				{
					pmntTotAmt=parseFloat(totPrice).toFixed(2);
					amntToPay=parseFloat(netPrice).toFixed(2);
				}
				
				document.getElementById('cashmodOrderCont').innerHTML=currentId;
				document.getElementById('cashmodStoreBasedOrderCont').innerHTML=storebaseordernumber;
				document.getElementById('cashmodTabCont').innerHTML=tableno;
				document.getElementById('cashtotamtcontId').innerHTML=parseFloat(pmntTotAmt).toFixed(2);
				document.getElementById('cashpaidamtcontId').innerHTML=parseFloat(temppaidAmt).toFixed(2);
				document.getElementById('cashamttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
				document.getElementById('cashtenderAmt').innerHTML=parseFloat(amntToPay).toFixed(2);
				if(printpaidBill=='N')
					{document.getElementById('chkprintBillCash').checked=false;}
				showCashModal();
			}catch(e)
			{
				alert(e);
			}
			}, null);
		
}
function getChangeAmt(tenderAmt)
{
	
//	if(tenderAmt=='')
//		{
//		document.getElementById('cashchangeamtcontId').innerHTML='0.00';
//		}
//	else if(parseFloat(amntToPay)>=parseFloat(tenderAmt))
//		{
//			document.getElementById('cashchangeamtcontId').innerHTML='0.00';
//		}
//	else
//		{
			//document.getElementById('cashchangeamtcontId').innerHTML=parseFloat(parseFloat(tenderAmt)-parseFloat(amntToPay)).toFixed(2);
			// for vfd
			
			if(vfdPort.length>3)
			{
				var changeAmt=tenderAmt-netTotal;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfdpay/" +"TOT IN RM : " + parseFloat(amntToPay).toFixed(2) + "/"+"BAL IN RM : " + parseFloat(changeAmt).toFixed(2)+".htm", function() {
					}, null);
			}
			
	//	}
}
var totCardPrice= null;
var netCardPrice= null;
var netCardTotal= null;
function openCardModal(totPrice,netPrice,netTotal)
{
	checkOrderPaymentStatus();
	netPrice=netPriceFromCheckOrder;
	//alert("totPrice: " + totPrice + "netPrice: " + netPrice + "netTotal: " + netTotal);
	var storebaseordernumber = $("#unpaidorderstrbaseorderno_"+currentId).val(); 
	totCardPrice=totPrice;
	netCardPrice=netPrice;
	netCardTotal=netTotal;
	
	document.getElementById('paycardalertMsg').innerHTML='';
	var orderno=currentId;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	var temppaidAmt=0.0;
	
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/unpaidorderlist/getpaymentinfo/"+orderno + ".htm", function(response) {
			try{
				var responseObj=[];
				responseObj=JSON.parse(response);

				for(var i=0;i<responseObj.length;i++)
				{
					temppaidAmt+=responseObj[i].paidAmount;

				}
				paidAmnt=temppaidAmt;
				netTotal=netCardTotal;
				
				if(roundOffTotalAmtStatus== 'Y')
				{
					pmntTotAmt=parseFloat(totPrice +0.5 - ((totPrice+0.5) % 1)).toFixed(2);
					amntToPay=parseFloat(netPrice +0.5 - ((netPrice+0.5) % 1)).toFixed(2);
				}

				if(roundOffTotalAmtStatus== 'N')
				{
					pmntTotAmt=parseFloat(totPrice).toFixed(2);
					amntToPay=parseFloat(netPrice).toFixed(2);
				}
				
				document.getElementById('cardmodOrderCont').innerHTML=orderno;
				document.getElementById('cardmodStoreBasedOrderCont').innerHTML=storebaseordernumber;	
				document.getElementById('cardmodTabCont').innerHTML=tableno;
				document.getElementById('cardtotamtcontId').innerHTML=parseFloat(pmntTotAmt).toFixed(2);
				document.getElementById('cardpaidamtcontId').innerHTML=parseFloat(temppaidAmt).toFixed(2);
				document.getElementById('cardamttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
				document.getElementById('cardtenderAmt').innerHTML=parseFloat(amntToPay).toFixed(2);
				if(printpaidBill=='N')
				{document.getElementById('chkprintBillCard').checked=false;}
				showCardModal();
			}catch(e)
			{
				alert(e);
			}
			}, null);	
}

function checkCardType(cardType)
{
	if(cardType=='Visa')
		{
		document.getElementById('cardTypeName').value=cardType;
		document.getElementById('cardTypeNameDiv').style.display='none';
		}
	if(cardType=='Master')
		{
		document.getElementById('cardTypeName').value=cardType;
		document.getElementById('cardTypeNameDiv').style.display='none';
		}
	if(cardType=='Other')
		{
		document.getElementById('cardTypeName').value="";
		document.getElementById('cardTypeNameDiv').style.display='block';
		}
	
}
var totOnlinePrice= null;
var netOnlinePrice= null;
var netOnlineTotal= null;
function openOnlineModal(totPrice,netPrice,netTotal)
{
	checkOrderPaymentStatus();
	netPrice=netPriceFromCheckOrder;
	
	totOnlinePrice=totPrice;
	netOnlinePrice=netPrice;
	netOnlineTotal=netTotal;
	
	document.getElementById('paycardalertMsg').innerHTML='';
	var orderno=currentId;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	var temppaidAmt=0.0;
			
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/unpaidorderlist/getpaymenttypebystore.htm", function(response) {
			var parseresponse = JSON.parse(response);
			try{			
				if('null'==response){
					$("#notavailableonlinepaymentModal").modal("show");
				}else if(0 == parseresponse.size){
					$("#notavailableonlinepaymentModal").modal("show");
				}else{
				var responseObjpaymenttype=JSON.parse(response);
				if(responseObjpaymenttype.size==1){
					ajaxCallObject.callAjax(BASE_URL + "/unpaidorderlist/getpaymentinfo/"+orderno + ".htm", function(response) {
						try{
							var responseObj=[];
							responseObj=JSON.parse(response);
							
							for(var i=0;i<responseObj.length;i++)
							{
								temppaidAmt+=responseObj[i].paidAmount;
							}
							paidAmnt=temppaidAmt;
							netTotal=netOnlineTotal;
							
							if(roundOffTotalAmtStatus== 'Y')
							{
								pmntTotAmt=parseFloat(totPrice +0.5 - ((totPrice+0.5) % 1)).toFixed(2);
								amntToPay=parseFloat(netPrice +0.5 - ((netPrice+0.5) % 1)).toFixed(2);
							}

							if(roundOffTotalAmtStatus== 'N')
							{
								pmntTotAmt=parseFloat(totPrice).toFixed(2);
								amntToPay=parseFloat(netPrice).toFixed(2);
							}
							
							document.getElementById('onlinemodOrderCont').innerHTML=orderno;
							document.getElementById('onlinemodTabCont').innerHTML=tableno;
							document.getElementById('onlinetotamtcontId').innerHTML=parseFloat(pmntTotAmt).toFixed(2);
							document.getElementById('onlinepaidamtcontId').innerHTML=parseFloat(temppaidAmt).toFixed(2);
							document.getElementById('onlineamttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
							document.getElementById('onlinetenderAmt').innerHTML=parseFloat(amntToPay).toFixed(2);
							$("#selpaymentmode").val(responseObjpaymenttype.paymentTypes[0].paymentTypeName+"_"+responseObjpaymenttype.paymentTypes[0].id);
							if(printpaidBill=='N')
							{document.getElementById('chkprintBillonline').checked=false;}
							$("#onlineModal").modal("show");
						}catch(e)
						{
							alert(e);
						}
						}, null);
				}else{
//					alert("size="+responseObj.size);
					var createdrowline="";
					var begintable="<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222;'>";
					var endtable="</table>";
					
					for(var j=0;j<responseObjpaymenttype.paymentTypes.length;j++)
					{
						var begintr="<tr style='background:#404040; color:#FFF;'>";
//						var firsttd="<td><input type='radio' name='paymenttypeopt' onchange='getSelectedPaymentTypeval()' value='"+responseObjpaymenttype.paymentTypes[j].id+"'/></td>";
						var firsttd="<td><input type='radio' name='paymenttypeopt' onchange='getSelectedPaymentTypeval()' value='"+responseObjpaymenttype.paymentTypes[j].paymentTypeName+"_"+responseObjpaymenttype.paymentTypes[j].id+"'/></td>";
						var secondtd="<td>"+responseObjpaymenttype.paymentTypes[j].paymentTypeName+"</td>";
						var endtr="</tr>";
						createdrowline+=begintr+firsttd+secondtd+endtr;
					}
					
					$("#paymodeselectiondiv").html(begintable+createdrowline+endtable);
					$("#paymodeselectionModal").modal("show");
				}
			}
			}catch(e)
			{
				alert(e);
			}
			}, null);		
}
function getSelectedPaymentTypeval(){
	var selectedPaymentType =$( 'input[name=paymenttypeopt]:checked' ).val();
	console.log("selectedPaymentType="+selectedPaymentType);
}
function getpaymod(){
	
	var storebaseordernumber = $("#unpaidorderstrbaseorderno_"+currentId).val(); 
	var selectedPaymentType =$( 'input[name=paymenttypeopt]:checked' ).val();
	if(selectedPaymentType==undefined){
		$("#paymodeselectiontext").text("Please select one option.");
	}else{
		$("#paymodeselectiontext").text("");
		$("#paymodeselectionModal").modal("hide");
		//netTotal=document.getElementById('hidnetTotal').value;
		document.getElementById('paycardalertMsg').innerHTML='';
		var orderno=currentId;
		var tableno=document.getElementById('tablenoCont').innerHTML;
		var temppaidAmt=0.0;
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/unpaidorderlist/getpaymentinfo/"+orderno + ".htm", function(response) {
			try{
				var responseObj=[];
				responseObj=JSON.parse(response);
		
				
				for(var i=0;i<responseObj.length;i++)
				{
					temppaidAmt+=responseObj[i].paidAmount;
				}
				
				paidAmnt=temppaidAmt;
				netTotal=netOnlineTotal;
				
				if(roundOffTotalAmtStatus== 'Y')
				{
					pmntTotAmt=parseFloat(totOnlinePrice +0.5 - ((totOnlinePrice+0.5) % 1)).toFixed(2);
					amntToPay=parseFloat(netOnlinePrice +0.5 - ((netOnlinePrice+0.5) % 1)).toFixed(2);
				}

				if(roundOffTotalAmtStatus== 'N')
				{
					pmntTotAmt=parseFloat(totOnlinePrice).toFixed(2);
					amntToPay=parseFloat(netOnlinePrice).toFixed(2);
				}
				
				document.getElementById('onlinemodOrderCont').innerHTML=orderno;
				document.getElementById('onlinemodStoreBasedOrderCont').innerHTML=storebaseordernumber;
				document.getElementById('onlinemodTabCont').innerHTML=tableno;
				document.getElementById('onlinetotamtcontId').innerHTML=parseFloat(pmntTotAmt).toFixed(2);
				document.getElementById('onlinepaidamtcontId').innerHTML=parseFloat(temppaidAmt).toFixed(2);
				document.getElementById('onlineamttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
				document.getElementById('onlinetenderAmt').innerHTML=parseFloat(amntToPay).toFixed(2);
				document.getElementById('onlineselpaymenttype').innerHTML=selectedPaymentType.split("_")[0];
				$("#selpaymentmode").val(selectedPaymentType);
				if(printpaidBill=='N')
				{document.getElementById('chkprintBillonline').checked=false;}
				$("#onlineModal").modal("show");
			}catch(e)
			{
				alert(e);
			}
			}, null);
	}
}
function payByCash(tenderAmt)
{
	var payableamount  = document.getElementById('cashamttopaycontId').innerHTML;
	
	var date = null;
	var caseValue = $("#mobPrintVal").val();
	var orderno=currentId;
	netTotal=netCashTotal;
	
	//alert("pay by cash");
	tenderAmt=parseFloat(document.getElementById('cashtenderAmt').innerHTML).toFixed(2);
	//alert("orderno"+orderno);
    var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
	var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
	var round_ledger_id = parseInt($('#round_ledger_idf').val());
	var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
	var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
    var card_ledger_id=parseInt($('#card_ledger_idf').val());

	var discountamt=$("#unpaidorderdiscamt_"+orderno).val();
	var discountpercentage=$("#unpaidorderdiscpercntg_"+orderno).val();
	var itemtotal=$("#unpaidordersubtotal_"+orderno).val(); //with discount
	var vattax=$("#unpaidordervattax_"+orderno).val();
    var servicetax=$("#unpaidorderstax_"+orderno).val();
    var servicecharge =$("#unpaidorderscharge_"+orderno).val();

	var grossamount = (100 * Number(itemtotal))/(100-Number(discountpercentage)); //without tax
	var discountamt= Number(grossamount)-Number(itemtotal);
    var totaltax=Number(vattax)+Number(servicetax);

     //alert("discountpercentage:"+discountpercentage+" "+"itemtotal:"+itemtotal+" "+"grossamount:"+grossamount+" "+"vattax:"+vattax+" "+"servicetax:"+servicetax+" "+"servicecharge:"+servicecharge+" "+"discountamt:"+discountamt);

    
    if(discountpercentage==100){
    	discountamt = grossamount = Number($("#unpaidorderdiscamt_"+orderno).val());
	}
    
    
   
	if (isNaN(tenderAmt) || tenderAmt=='')
	{
	document.getElementById('paycashalertMsg').innerHTML='Please enter a valid number!';
	}
	else
	{
		
		if(parseFloat(tenderAmt)>=parseFloat(amntToPay))
		{
			paidAmnt=parseFloat(amntToPay);
			amntToPay=0.0;
		}
		else
		{
			paidAmnt=parseFloat(tenderAmt);
			amntToPay=(parseFloat(amntToPay)-parseFloat(tenderAmt)).toFixed(2);
		}
		if(storedoubleroundoffflag=='Y')
		{
		netTotal=round(netTotal,1);
		}


		var payment1={};
		var order={};
		order.id=orderno;
		payment1.orderPayment=order;
		

		if( payableamount < 0){
					payment1.amount=netTotal;
					payment1.paidAmount=0.00;
					payment1.amountToPay=0.00;
					payment1.tenderAmount=0.00;
				}
	    else{
					payment1.amount=netTotal;
					payment1.paidAmount=paidAmnt;
					payment1.amountToPay=amntToPay;
					payment1.tenderAmount=tenderAmt;
					
					
			}
		
		
		
		
		//payment1.amount=netTotal;
		//payment1.paidAmount=paidAmnt;
		//payment1.amountToPay=amntToPay;
		//payment1.tenderAmount=tenderAmt;
		payment1.paymentMode="cash";
		payment1.cardLastFourDigits="0000";
		payment1.source="web";
		payment1.remarks="nil";
		payment1.tipsAmount="0.00";


		if(is_Acc=="Y")
		{
		  if(sale_ledger_id<=0 && duties_ledger_id<= 0 && round_ledger_id<=0 && discount_ledger_id<=0 && debitor_cash_ledger_id<=0 && service_charge_ledger_id<=0 && card_ledger_id<=0) {
		   document.getElementById('paycashalertMsg').innerHTML = "ledger missing";
				return;
			 }else {
				  document.getElementById('paycashalertMsg').innerHTML = "";

				  payment1.duties_ledger_id=duties_ledger_id;
				  payment1.round_ledger_id=round_ledger_id;
				  payment1.sale_ledger_id=sale_ledger_id;
				  payment1.discount_ledger_id=discount_ledger_id;
				  payment1.debitor_cash_ledger_id=debitor_cash_ledger_id;
				  payment1.service_charge_ledger_id=service_charge_ledger_id;
				  payment1.card_ledger_id=card_ledger_id;
				  payment1.grossAmt=grossamount.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.discAmt=discountamt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.taxVatAmt=totaltax.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.serviceChargeAmt=servicecharge.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;


			}
		}

		/*var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/"+orderno +"/"+ netTotal+"/"+ paidAmnt+"/"+ amntToPay+"/"+tenderAmt+"/"+"cash"+"/"+"000"+"/"+"nil"+"/"+"0.00"+".htm", function(response) {*/
		$.ajax({
			url : BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(payment1),
			success : function(response) {
		       try{
				if(response=='success')
					{
					if(smsintegration == 'Y'){
						var subtot=document.getElementById('subtotalcontId').innerHTML;
						//alert("::sms:::"+orderno+"ammt:::"+subtot);
						var ajaxCallObject = new CustomBrowserXMLObject();
						ajaxCallObject.callAjax(BASE_URL+ "/smsintegration/sendsms/"+ orderno+"/subtot/"+subtot + ".htm", function(response) {
								  //alert("response:"+response);
								}, null);
                   }


					if(printpaidBill=='N')
					{
						if(document.getElementById('chkprintBillCash').checked==true)
							{
							//alert('print cash');
							//printPaidBill(orderno);
							if (caseValue == 'Y') {
								//cashOrcardPrintBill();
								printPaidBill(orderno);
							} else {

								var ajaxCallObject = new CustomBrowserXMLObject();
								ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderno+ ".htm", function(response) {
								}, null);
							}
							}

					}
					else
				      {

				      if (caseValue == 'Y') {
				       // cashOrcardPrintBill();

				        //location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
				        printPaidBill(orderno);
				       }
				      }


					if(amntToPay>0)
					{
						//document.getElementById('amttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);

						var nodes = document.getElementsByClassName('amttopaycontId_'+currentId);
						nodes[0].innerHTML=parseFloat(amntToPay).toFixed(2);
						hideCashModal();
					}
					else
						{
						if(document.getElementById('cashmodTabCont').innerHTML=='0')
							{
							hideCashModal();
							showalertOrderPaidModal();
//							date = document.getElementById('dateunpaidorderList').value;
//							location.href=BASE_URL+'/unpaidorderlist/unpaidorderSpecificDate.htm?storeId='+storeId+'&date='+date;
							}
						else{
							if(cdrawerCode.length>0)
								{
								hideCashModal();
								var toPay=document.getElementById('cashamttopaycontId').innerHTML;
								var changeAmt=parseFloat(parseFloat(tenderAmt)-parseFloat(toPay)).toFixed(2);
								document.getElementById('cashamttopaymodcontId').innerHTML=parseFloat(toPay).toFixed(2);
								document.getElementById('cashtenderAmtmodcontId').innerHTML=parseFloat(tenderAmt).toFixed(2);
								document.getElementById('cashchangeamtmodcontId').innerHTML=parseFloat(changeAmt).toFixed(2);
								showCashChangeAmtModal();
								}
							else{
								hideCashModal();
								showalertOrderPaidModal();
//								date = document.getElementById('dateunpaidorderList').value;
//								location.href=BASE_URL+'/unpaidorderlist/unpaidorderSpecificDate.htm?storeId='+storeId+'&date='+date;
								}

							}
						}
					}
				}catch(e){alert(e);}

			},
            error : function(e) {
          }
      });


		//}, null);
	}
}
function payByCard(tenderAmt)
{

	var payableamount  = document.getElementById('cardamttopaycontId').innerHTML;
	var caseValue = $("#mobPrintVal").val();
	netTotal=netCardTotal;
	//alert("payby card");
	tenderAmt=parseFloat(document.getElementById('cardtenderAmt').innerHTML).toFixed(2);
	var orderno=currentId;
	var lastfourdigit = 'xxxx';
    lastfourdigit=document.getElementById('cardlastfourDigit').value;
	var cardType=document.getElementById('cardTypeName').value;
	var tipsamts='0.00';
	  var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
		var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
		var round_ledger_id = parseInt($('#round_ledger_idf').val());
		var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
		var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
	    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
	    var card_ledger_id=parseInt($('#card_ledger_idf').val());

	    var discountamt=$("#unpaidorderdiscamt_"+orderno).val();
		var discountpercentage=$("#unpaidorderdiscpercntg_"+orderno).val();
		var itemtotal=$("#unpaidordersubtotal_"+orderno).val(); //with discount
		var vattax=$("#unpaidordervattax_"+orderno).val();
	    var servicetax=$("#unpaidorderstax_"+orderno).val();
	    var servicecharge =$("#unpaidorderscharge_"+orderno).val();

		var grossamount = (100 * Number(itemtotal))/(100-Number(discountpercentage)); //without tax
		var discountamt= Number(grossamount)-Number(itemtotal);
	    var totaltax=Number(vattax)+Number(servicetax);
	   //alert("discountpercentage:"+discountpercentage+" "+"itemtotal:"+itemtotal+" "+"grossamount:"+grossamount+" "+"vattax:"+vattax+" "+"servicetax:"+servicetax+" "+"servicecharge:"+servicecharge+" "+"discountamt:"+discountamt);
       
	   // alert("ammttopay:"+amntToPay+"tenderAmt:"+tenderAmt);
	    if(discountpercentage==100){
	    	discountamt = grossamount = Number($("#unpaidorderdiscamt_"+orderno).val());
		}
	    
	    
	    
	if(storeID == 157){
	   tipsamts=document.getElementById('tipsamt').value;
	}


	if(isNaN(tenderAmt)|| tenderAmt=='')
	{
		document.getElementById('paycardalertMsg').innerHTML='Please enter a valid number!';
		//document.getElementById('cardtenderAmt').focus();
	}
	else if(cardType=='')
	{
		document.getElementById('paycardalertMsg').innerHTML='Please enter card type!';
	}

	else
	{
		   if(lastfourdigit=='')
		       {
		         lastfourdigit='xxxx';
		       }
	       if(tipsamts==''){tipsamts = '0.00';}
	       if(parseFloat(tenderAmt).toFixed(2)>=parseFloat(amntToPay).toFixed(2))
	          {
		         paidAmnt=parseFloat(amntToPay).toFixed(2);
		         amntToPay=0.0;
	          }
	       else
	          {
		         paidAmnt=parseFloat(tenderAmt).toFixed(2);
		         amntToPay=parseFloat(amntToPay).toFixed(2)-parseFloat(tenderAmt).toFixed(2);
	          }
	        if(storedoubleroundoffflag=='Y')
	          {
	             netTotal=round(netTotal,1);
	          }  
		
		    var payment1={};
			var order={};
			order.id=orderno;
			payment1.orderPayment=order;
			
			if( payableamount < 0){
				payment1.amount=netTotal;
				payment1.paidAmount=0.00;
				payment1.amountToPay=0.00;
				payment1.tenderAmount=0.00;
			}
			else{
				payment1.amount=netTotal;
				payment1.paidAmount=paidAmnt;
				payment1.amountToPay=amntToPay;
				payment1.tenderAmount=tenderAmt;
			}	
			//payment1.amount=netTotal;
			//payment1.paidAmount=tenderAmt;
			//payment1.amountToPay=amntToPay;
			//payment1.tenderAmount=tenderAmt;
			payment1.paymentMode=cardType;
			payment1.cardLastFourDigits=lastfourdigit;
			payment1.source="web";
			payment1.remarks="nil";
			payment1.tipsAmount=tipsamts;

   	if(is_Acc=="Y")
		{
           if(sale_ledger_id<=0 && duties_ledger_id<= 0 && round_ledger_id<=0 && discount_ledger_id<=0 && debitor_cash_ledger_id<=0 && service_charge_ledger_id<=0 && card_ledger_id<=0) {
		   document.getElementById('paycardalertMsg').innerHTML = "ledger missing";
				return;
			 }else {
				  document.getElementById('paycardalertMsg').innerHTML = "";

				  payment1.duties_ledger_id=duties_ledger_id;
				  payment1.round_ledger_id=round_ledger_id;
				  payment1.sale_ledger_id=sale_ledger_id;
				  payment1.discount_ledger_id=discount_ledger_id;
				  payment1.debitor_cash_ledger_id=debitor_cash_ledger_id;
				  payment1.service_charge_ledger_id=service_charge_ledger_id;
				  payment1.card_ledger_id=card_ledger_id;
				  payment1.grossAmt=grossamount.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.discAmt=discountamt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.taxVatAmt=totaltax.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.serviceChargeAmt=servicecharge.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;


			}
		}


		/*var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/"+orderno +"/"+ netTotal+"/"+ paidAmnt+"/"+ amntToPay+"/"+tenderAmt+"/"+cardType+"/"+lastfourdigit + "/" + "nil" +"/" + tipsamts +".htm", function(response) {*/
		$.ajax({
			url : BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(payment1),
			success : function(response) {

		    try{
			if(response=='success')
				{
				if(smsintegration == 'Y'){
				     var subtot=document.getElementById('subtotalcontId').innerHTML;
				      //alert("::sms:::"+orderno+"ammt:::"+subtot);
				         var ajaxCallObject = new CustomBrowserXMLObject();
				         ajaxCallObject.callAjax(BASE_URL+ "/smsintegration/sendsms/"+ orderno+"/subtot/"+subtot + ".htm", function(response) {
						  //alert("response:"+response);
						}, null);

			    }

				if(printpaidBill=='N')
				{
					if(document.getElementById('chkprintBillCard').checked==true)
						{
						//alert('print card');
						//printPaidBill(orderno);
						if (caseValue == 'Y') {
							//cashOrcardPrintBill();
							printPaidBill(orderno);
						} else {
							var ajaxCallObject = new CustomBrowserXMLObject();
							ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderno+ ".htm", function(response) {
								}, null);
							//alert(orderno);
							}
						}

				}
				else
			      {

			      if (caseValue == 'Y') {
			       // cashOrcardPrintBill();

			        //location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
			        printPaidBill(orderno);
			       }
			      }


				if(amntToPay>0)
				{
					//document.getElementById('amttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
					var nodes = document.getElementsByClassName('amttopaycontId_'+currentId);
					nodes[0].innerHTML=parseFloat(amntToPay).toFixed(2);
					hideCardModal();
				}
				else
					{
						if(document.getElementById('cardmodTabCont').innerHTML=='0')
						{
							hideCardModal();
							showalertOrderPaidModal();
//							var date = document.getElementById('dateunpaidorderList').value;
//							location.href=BASE_URL+'/unpaidorderlist/unpaidorderSpecificDate.htm?storeId='+storeId+'&date='+date;
						}

//						else{
//							location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
//							}
					}
				}
			}catch(e){alert(e);}

			},
            error : function(e) {
          }
      });

		//}, null);
	}
}


function payByOnline(tenderAmt){
	
	var payableamount  = document.getElementById('onlineamttopaycontId').innerHTML;
	var caseValue = $("#mobPrintVal").val();
	var orderno=currentId;
	var paymentType=$('#selpaymentmode').val();
	netTotal=netOnlineTotal;

	tenderAmt=parseFloat(document.getElementById('onlinetenderAmt').innerHTML).toFixed(2);
    var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
	var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
	var round_ledger_id = parseInt($('#round_ledger_idf').val());
	var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
	var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
    var card_ledger_id=parseInt($('#card_ledger_idf').val());
	var discountamt=$("#unpaidorderdiscamt_"+orderno).val();
	var discountpercentage=$("#unpaidorderdiscpercntg_"+orderno).val();
	var itemtotal=$("#unpaidordersubtotal_"+orderno).val(); //with discount
	var vattax=$("#unpaidordervattax_"+orderno).val();
    var servicetax=$("#unpaidorderstax_"+orderno).val();
    var servicecharge =$("#unpaidorderscharge_"+orderno).val();

	var grossamount = (100 * Number(itemtotal))/(100-Number(discountpercentage)); //without tax
	var discountamt= Number(grossamount)-Number(itemtotal);
    var totaltax=Number(vattax)+Number(servicetax);

    //alert("discountpercentage:"+discountpercentage+" "+"itemtotal:"+itemtotal+" "+"grossamount:"+grossamount+" "+"vattax:"+vattax+" "+"servicetax:"+servicetax+" "+"servicecharge:"+servicecharge+" "+"discountamt:"+discountamt);
    if(discountpercentage==100){
    	discountamt = grossamount = Number($("#unpaidorderdiscamt_"+orderno).val());
	}

	if(isNaN(tenderAmt)|| tenderAmt=='')
	{
		document.getElementById('payonlinealertMsg').innerHTML='Please enter a valid number!';
	}
	if(parseFloat(tenderAmt).toFixed(2)>=parseFloat(amntToPay).toFixed(2))
	{
		paidAmnt=parseFloat(amntToPay).toFixed(2);
		amntToPay=0.0;
	}
	else
	{
		paidAmnt=parseFloat(tenderAmt).toFixed(2);
		amntToPay=parseFloat(amntToPay).toFixed(2)-parseFloat(tenderAmt).toFixed(2);
	}

	if(storedoubleroundoffflag=='Y')
	{
	netTotal=round(netTotal,1);
	}


	var payment1={};
	var order={};
	order.id=orderno;
	payment1.orderPayment=order;
	
	if( payableamount < 0){
		payment1.amount=netTotal;
		payment1.paidAmount=0.00;
		payment1.amountToPay=0.00;
		payment1.tenderAmount=0.00;
	}
	else{
		payment1.amount=netTotal;
		payment1.paidAmount=paidAmnt;
		payment1.amountToPay=amntToPay;
		payment1.tenderAmount=tenderAmt;
	}	
	//payment1.amount=netTotal;
	//payment1.paidAmount=tenderAmt;
	//payment1.amountToPay=amntToPay;
	//payment1.tenderAmount=tenderAmt;
	payment1.paymentMode=paymentType.split("_")[0];
	payment1.cardLastFourDigits=paymentType.split("_")[1];
	payment1.source="web";
	payment1.remarks="nil";
	payment1.tipsAmount="0.00";

	if(is_Acc=="Y")
	{



	  if(sale_ledger_id<=0 && duties_ledger_id<= 0 && round_ledger_id<=0 && discount_ledger_id<=0 && debitor_cash_ledger_id<=0 && service_charge_ledger_id<=0 && card_ledger_id<=0) {
	   document.getElementById('payonlinealertMsg').innerHTML = "ledger missing";
			return;
		 }else {
			  document.getElementById('payonlinealertMsg').innerHTML = "";

			  payment1.duties_ledger_id=duties_ledger_id;
			  payment1.round_ledger_id=round_ledger_id;
			  payment1.sale_ledger_id=sale_ledger_id;
			  payment1.discount_ledger_id=discount_ledger_id;
			  payment1.debitor_cash_ledger_id=debitor_cash_ledger_id;
			  payment1.service_charge_ledger_id=service_charge_ledger_id;
			  payment1.card_ledger_id=card_ledger_id;
			  payment1.grossAmt=grossamount.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
			  payment1.discAmt=discountamt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
			  payment1.taxVatAmt=totaltax.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
			  payment1.serviceChargeAmt=servicecharge.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;


		}
	}

	/*var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/"+orderno +"/"+ netTotal+"/"+ paidAmnt+"/"+ amntToPay+"/"+tenderAmt+"/"+paymentType.split("_")[0]+"/"+paymentType.split("_")[1] +"/" + "nil" + "/" + "0.00" + ".htm", function(response) {*/

	$.ajax({
		url : BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
		type : 'POST',
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(payment1),
		success : function(response) {
	      try{
		if(response=='success')
			{
			if(smsintegration == 'Y'){

				var subtot=document.getElementById('subtotalcontId').innerHTML;
				//alert("::sms:::"+orderno+"ammt:::"+subtot);
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL+ "/smsintegration/sendsms/"+ orderno+"/subtot/"+subtot + ".htm", function(response) {
						  //alert("response:"+response);
						}, null);

			}
			if (printpaidBill == 'N') {

				 if(document.getElementById('chkprintBillonline').checked==true)
				 {
				// alert('print card');
				// printPaidBill(orderno);
				/*
				 * var ajaxCallObject = new
				 * CustomBrowserXMLObject();
				 * ajaxCallObject.callAjax(BASE_URL +
				 * "/order/printbill/"+orderno+ ".htm",
				 * function(response) { }, null);
				 */
				// alert(orderno);
				if (caseValue == 'Y') {

					//cashOrcardPrintBill();
					printPaidBill(orderno);
				} else {
					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL
							+ "/order/printbill/" + orderno
							+ ".htm", function(response) {
					}, null);
				}
				 }
			}
				 else
			      {

			      if (caseValue == 'Y') {
			       // cashOrcardPrintBill();

			        //location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
			        printPaidBill(orderno);
			       }
			      }
			//}
//			if(printpaidBill=='N')
//			{
//				if(document.getElementById('chkprintBillCard').checked==true)
//					{
//					//alert('print card');
//					//printPaidBill(orderno);
//					var ajaxCallObject = new CustomBrowserXMLObject();
//					ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderno+ ".htm", function(response) {
//						}, null);
//					//alert(orderno);
//					}
//
//			}
//			if(amntToPay>0)
//			{
//				document.getElementById('amttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
//				$("#onlineModal").modal("hide");
//			}
//			else
//				{
					//alert(document.getElementById('cardmodTabCont').innerHTML);
					if(document.getElementById('cardmodTabCont').innerHTML=='00')
					{
						$("#onlineModal").modal("hide");
						showalertOrderPaidModal();
//						var date = document.getElementById('dateunpaidorderList').value;
//						location.href=BASE_URL+'/unpaidorderlist/unpaidorderSpecificDate.htm?storeId='+storeId+'&date='+date;
					}
//					else {

			//	}
			//}
			}
			//}
		}catch(e){alert(e);}
		},
        error : function(e) {
      }
  });

	//}, null);

}

var netPriceFromCheckOrder=0.0;
function checkOrderPaymentStatus()
{
	var orderno=currentId;
	var temppaidAmt=0.0;
	var totalAmtOfOrder=0.0;
	
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/unpaidorderlist/getpaymentinfo/"+orderno + ".htm", function(response) {
			try{
				var responseObj=[];
				responseObj=JSON.parse(response);
                 
            
				for(var i=0;i<responseObj.length;i++)
				{
					temppaidAmt+=responseObj[i].paidAmount;					
				}
				
				var nodes = document.getElementsByClassName('grandtotalcontId_'+currentId);
				totalAmtOfOrder=nodes[0].innerHTML;
				
				var amntToPay = (parseFloat(totalAmtOfOrder) - parseFloat(temppaidAmt));
				amntToPay=parseFloat(amntToPay);
				netPriceFromCheckOrder=amntToPay;
				
				nodes = document.getElementsByClassName('amttopaycontId_'+currentId);
				nodes[0].innerHTML=parseFloat(amntToPay).toFixed(2);
				
			
				
			}catch(e)
			{
				alert(e);
			}
			}, null);	
}


/*function printPaidBill(orderid)
{
	var caseValue =  $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();	
	var order = {};
    //var orderId = document.getElementById('orderNo').value;
	order.id = orderid;
	order.storeId = storeID;
	var ajaxCallObject = new CustomBrowserXMLObject();
	if (caseValue == "Y") {
		$.ajax({
			type : "POST",
			url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(order),
			success : function(response) {
				var jsonObj = JSON.parse(response);
				
				var orderNo = jsonObj.id;
				var storebaseOrderNo2= jsonObj.orderNo;
				var tabNo = jsonObj.table_no;
				var customerName = jsonObj.customers.name;
				var orderCustomerName = jsonObj.customerName;
				var customerAddr = jsonObj.customers.address;
				var orderCustomerAddr = jsonObj.deliveryAddress;
				var customerPhNo = jsonObj.customers.contactNo;
				var customerEmail = jsonObj.customers.emailId;
				var state=jsonObj.customers.state;
				var orderDateWithTime = jsonObj.customers.orderTime;
				var orderTime = jsonObj.customers.time;

				
				var storeId = jsonObj.orderBill.storeid;
				var billAmt = jsonObj.orderBill.billAmount;
				var serviceTaxAmt = jsonObj.orderBill.serviceTaxAmt;
				var vatAmt = jsonObj.orderBill.vatAmt;
				var grossAmt = jsonObj.orderBill.grossAmt;
				var totalDiscount = jsonObj.orderBill.totalDiscount;
				var customerDiscount = jsonObj.orderBill.customerDiscount;
				var roundOffAmt = jsonObj.orderBill.roundOffAmt;
				var discPercentage = jsonObj.orderBill.discountPercentage;
				var serviceChargeAmt = jsonObj.orderBill.serviceChargeAmt;
				var subToatlAmt = jsonObj.orderBill.subTotalAmt;
				var orderDate=jsonObj.orderTime;
				var afterdiscount = subToatlAmt - customerDiscount + serviceChargeAmt; // new added 2nd Apr 2018
	               

				if (printbillpapersize == '58.00') {

					
					$('#storeName58').text(customerName);
					$('#storeAddr58').text(storeAddr);
					$('#storeEmail58').text(customerEmail);
					$('#storePhNo58').text(customerPhNo);
					$('#orderValue58').text(storebaseOrderNo2);
					$('#tableNoValue58').text(tabNo);

					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
                        var createdrowline = "";
						var startTrline = "<tr style='padding: 1px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 50px !important; word-wrap: break-word; font-size: 10px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px; font-size: 10px;font-family: sans-serif;'>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemRate + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemTotalPrice + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

					    //$("#itemDetailsPrint58").append(createdrowline);

					}

					$('#totalAmt58').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#totalServiceChrg_58").show();
						$('#servChrg58').text(serviceChargeAmt);
					} else {
						$("#totalServiceChrg_58").hide();
					}

					if (serviceTaxAmt > 0.00) {
						$("#totalServiceTax_58").show();
						$('#servTax58').text(serviceTaxAmt);
					} else {
						$("#totalServiceTax_58").hide();
					}

					if (vatAmt > 0) {
						$("#totalVatTax_58").show();
						$("#vatTax58").text(vatAmt);
					} else {
						$("#totalVatTax_58").hide();
					}

					if (customerDiscount > 0) {
						$("#showDiscount_58").show();
						$("#discountValue58").text(customerDiscount);
					} else {
						$("#showDiscount_58").hide();
					}

					$("#grossAmount58").text(billAmt);
					$("#amoutToPay58").text(grossAmt);

					var paymentsObj = jsonObj.payments.length;
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount58').text(paidAmt);

						$('#tenderAmount58').text(tenderAmt);
						$('#refund_amount_58px').text(Math.floor(returnAmt * 100) / 100);
						$('#payType_58').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount58').text(paidAmt);
						$('#tenderAmount58').text(tenderAmt);
						$('#refundAmount58').text("0.00");
						$('#payType58').text(type1 + type2);
					}

					//$('#helloPrintModal58').modal('show');	

					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal58();
						}
					}

					if (paymentsObj == 2) {
						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						;
						if (amt2 == paidAmt2) {
							printCashOrCardLocal58();
						}
					}

				} else if(printbillpapersize == '80.00') {
					

					
					$('#storeName80').text(customerName);
					$('#storeAddr80').text(storeAddr);
					$('#storeEmail80').text(customerEmail);
					$('#storePhNo80').text(customerPhNo);
					$('#cashOrdervalue80').text(storebaseOrderNo2);
					$('#cashtableNoValue80').text(tabNo);

					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
                        var createdrowline = "";
						var startTrline = "<tr style='padding: 2px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + itemRate + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + itemTotalPrice + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

						$("#itemDetailsPrint80").append(createdrowline);

					}

					 ********** END ITEM DETAILS PRINT ********** 

					 ********** START AMOUNT INFO PRINT ********** 
					//alert(" << subToatlAmt >> "+subToatlAmt+ " << serviceChargeAmt >>"+serviceChargeAmt+"<< serviceTaxAmt >>"+serviceTaxAmt+" << vatAmt >>"+vatAmt+"<< customerDiscount >>"+customerDiscount+"<< billAmt >> "+billAmt+"<< grossAmt >> "+grossAmt);						
					$('#cashtotalamt80').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#cashtotalServiceCharge80px").show();
						$('#cashservChrg80').text(serviceChargeAmt);
					} else {
						$("#cashtotalServiceCharge80px").hide();
					}

					if (serviceTaxAmt > 0.00) {
						$("#cashtotalServiceTax80px").show();
						$('#cashservTax80').text(serviceTaxAmt);
					} else {
						$("#cashtotalServiceTax80px").hide();
					}

					if (vatAmt > 0) {
						$("#cashtotalVatTax80px").show();
						$("#cashvatTax80px").text(vatAmt);
					} else {
						$("#cashtotalVatTax80px").hide();
					}

					if (customerDiscount > 0) {
						$("#cashshowDiscount80px").show();
						$("#cashdiscountValue80").text(customerDiscount);
					} else {
						$("#cashshowDiscount80px").hide();
					}

					$("#cashgrossAmount80").text(billAmt);
					$("#cashamoutToPay80").text(grossAmt);

					var paymentsObj = jsonObj.payments.length;
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount80').text(paidAmt);
						$('#tenderAmount80').text(tenderAmt);
						$('#refundAmount80').text(Math.floor(returnAmt * 100) / 100);
						$('#payType80').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount80').text(paidAmt);
						$('#tenderAmount80').text(tenderAmt);
						$('#refundAmount80').text("0.00");
						$('#payType80').text(type1 + type2);
					}

					 ********** END AMOUNT INFO PRINT ********** 	

					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal80();
						}
					}

					if (paymentsObj == 2) {

						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						
						if (amt2 == paidAmt2) {
							printCashOrCardLocal80();
						}
					}

				}else if(printbillpapersize == '2100.00'){
					
			//		alert("printbillpapersize 2 >> "+printbillpapersize);
					
					$('#storeName2100').text(customerName);
					$('#storeAddr2100').text(storeAddr);
					$('#storeEmail2100').text("Email :"+customerEmail);
					$('#storePhNo2100').text("Ph :"+customerPhNo);
					$('#cashOrdervalue2100').text(storebaseOrderNo2);
					$('#cashtableNoValue2100').text(tabNo);

					 ********** For GST *********** 
					
					$('#storeName2100_GST').text(customerName);
					$('#storeAddr2100_GST').text(storeAddr);
					$('#storeEmail2100_GST').text(customerEmail);
					$('#storePhNo2100_GST').text(customerPhNo);
					$('#cashOrdervalue2100_GST').text(storebaseOrderNo2);
					$('#cashOrderDate_GST').text(orderDateWithTime);
					
					$('#cashCustName_GST').text(orderCustomerName);
					$('#cashCustAddr_GST').text(orderCustomerAddr);
					//$('#cashCustState_GST').text(customerAddr);
					$('#cashCustGSTIN_GST').text(jsonObj.custVatRegNo);
					
					var formattedDate = new Date(jsonObj.orderDate);
					var d = formattedDate.getDate();
					var m =  formattedDate.getMonth();
					m += 1;  // JavaScript months are 0-11
					var y = formattedDate.getFullYear();
					$("#cashOrderDate_GST").text(y + "-" + m + "-" + d);
					
					 *********** End ************* 
					
					 ********** END STORE INFO PRINT ********** 

					 ********** START ITEM DETAILS PRINT ********** 
					
					$("#itemDetailsPrint2100_GST").html('');

					 var totTaxable = 0.0;
					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
						var itemUnit = item1.item.unit;
						var itemDisc = item1.promotionDiscountAmt;
						var itemTotalAmt = 0.0;
						var itemTaxableAmt = 0.0;
						var cgstPrcnt = item1.vat;
						var cgstAmt = 0.0;
						var sgstPrcnt = item1.serviceTax;
						var sgstAmt = 0.0;
						var itemHsn = "";
						
						if(item1.item.promotionFlag == "Y")
						{							
							itemTotalAmt = (item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem;
							itemTaxableAmt = ((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt;
							cgstAmt = ((((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt) * item1.vat)/100;
							sgstAmt = ((((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt) * item1.serviceTax)/100;
						}
						else
						{
							itemTotalAmt = item1.quantityOfItem*item1.item.price;
							itemTaxableAmt = (item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt;
							cgstAmt = (((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt) * item1.vat)/100;
							sgstAmt = (((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt) * item1.serviceTax)/100;
						}
						
				//		alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);
						totTaxable = totTaxable + itemTaxableAmt;
						var createdrowline = "";
						var startTrline1 = "<tr>";
						var firstTdline = "<td width='30%;'>" + itemName + "</td>";
						var secondTdline = "<td width='6%;'>" + itemQty + "</td>";
						var thirdTdline = "<td width='5%;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
						var fourthTdline = "<td width='5%;'>" + parseFloat(itemTotalAmt).toFixed(2) + "</td>";
						var unit_clm = "<td width='6%;'>" + itemUnit + "</td>";
						var disc_clm = "<td width='5%;'>" + parseFloat(itemDisc).toFixed(2) + "</td>";
						var taxable_clm = "<td width='10%;'>" + parseFloat(itemTaxableAmt).toFixed(2) + "</td>";
						var cgstPrcnt_clm = "<td width='5%;'>" + parseFloat(cgstPrcnt).toFixed(2) + "</td>";
						var cgstAmt_clm = "<td width='10%;'>" + parseFloat(cgstAmt).toFixed(2) + "</td>";
						var sgstPrcnt_clm = "<td width='5%;'>" + parseFloat(sgstPrcnt).toFixed(2) + "</td>";
						var sgstAmt_clm = "<td width='10%;'>" + parseFloat(sgstAmt).toFixed(2) + "</td>";
						var igstPrcnt_clm = "<td width='5%;'></td>";
						var igstAmt_clm = "<td width='10%;'></td>";
						var sl_no = "<td width='5%;'>"+(k+1)+"</td>";
						var hsn_clm = "<td></td>";
						var sac_clm = "<td></td>";
						var endTrline1 = "</tr>";

						createdrowline1 = startTrline1 + sl_no + firstTdline + hsn_clm + sac_clm + secondTdline + unit_clm + thirdTdline + fourthTdline + disc_clm + taxable_clm + cgstPrcnt_clm + cgstAmt_clm + sgstPrcnt_clm + sgstAmt_clm + igstPrcnt_clm + igstAmt_clm + endTrline1;

						$("#itemDetailsPrint2100_GST").append(createdrowline1);

					}
					var startTrline2 = "<tr>";
					var blank_clm1 = "<td></td><td></td><td></td><td></td><td></td><td></td>";
					var total_txt = "<td>Total:</td>";
					var total_amt_clm = "<td>"+parseFloat(subToatlAmt).toFixed(2)+"</td>";
					//var total_disc_clm = "<td>" + parseFloat(totalDiscount).toFixed(2) + "</td>";
					var total_disc_clm = "<td>" + parseFloat(customerDiscount).toFixed(2) + "</td>";// changed in 2nd Apr 18
					//var total_taxable_clm = "<td>" + parseFloat(totTaxable).toFixed(2) + "</td>";
					var total_taxable_clm = "<td>" + parseFloat(afterdiscount).toFixed(2) + "</td>"; // changed in 2nd Apr 18					
					var blank_clm2 = "<td></td>";
					var total_cgstAmt_clm = "<td>" + parseFloat(vatAmt).toFixed(2) + "</td>";
					var blank_clm3 = "<td></td>";
					var total_sgstAmt_clm = "<td>" + parseFloat(serviceTaxAmt).toFixed(2) + "</td>";
					var blank_clm4 = "<td></td>";
					var total_igstAmt_clm = "<td></td>";
					var endTrline2 = "</tr>";

					createdrowline2 = startTrline2 + blank_clm1 + total_txt + total_amt_clm + total_disc_clm + total_taxable_clm + blank_clm2 + total_cgstAmt_clm + blank_clm3 + total_sgstAmt_clm + blank_clm4 + total_igstAmt_clm + endTrline2;

					$("#itemDetailsPrint2100_GST").append(createdrowline2);

					 ********** END ITEM DETAILS PRINT ********** 

					 ********** START AMOUNT INFO PRINT ********** 
					
					$('#cashtotalamt2100').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#cashtotalServiceCharge2100px").show();
						$('#cashservChrg2100').text(serviceChargeAmt);
					} else {
						$("#cashtotalServiceCharge2100px").hide();
					}

					if (serviceTaxAmt > 0.00) {
						$("#cashtotalServiceTax2100px").show();
						$('#cashservTax2100').text(serviceTaxAmt);
					} else {
						$("#cashtotalServiceTax2100px").hide();
					}

					if (vatAmt > 0) {
						$("#cashtotalVatTax2100px").show();
						$("#cashvatTax2100px").text(vatAmt);
					} else {
						$("#cashtotalVatTax2100px").hide();
					}

					if (customerDiscount > 0) {
						$("#cashshowDiscount2100px").show();
						$("#cashdiscountValue2100").text(customerDiscount);
					} else {
						$("#cashshowDiscount2100px").hide();
					}

					$("#cashgrossAmount2100").text(billAmt);
					$("#cashamoutToPay2100").text(grossAmt);

					$("#cashgrossAmount2100_gst").text(parseFloat(grossAmt).toFixed(2));
					$("#cashvatTax2100px_gst").text(parseFloat(vatAmt).toFixed(2));
					$('#cashservTax2100_gst').text(parseFloat(serviceTaxAmt).toFixed(2));
					
					var cash_gross_word = number2text(parseFloat(grossAmt).toFixed(2));
					
					$("#cashgrossAmount2100_word_gst").text(cash_gross_word);
					
					$("#paidAmount_paidbill_2100px").text(parseFloat(grossAmt).toFixed(2)); // new added 10.5.2018
					$("#amoutToPay_paidbill_2100px").text('00.00'); // new added 10.5.2018
					
					
					
					var paymentsObj = jsonObj.payments.length;
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount2100').text(paidAmt);
						$('#tenderAmount2100').text(tenderAmt);
						$('#refundAmount2100').text(Math.floor(returnAmt * 100) / 100);
						$('#payType2100').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount2100').text(paidAmt);
						$('#tenderAmount2100').text(tenderAmt);
						$('#refundAmount2100').text("0.00");
						$('#payType2100').text(type1 + type2);
					}

					 ********** END AMOUNT INFO PRINT ********** 	

					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal2100();
						}
					}

					if (paymentsObj == 2) {

						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						
						if (amt2 == paidAmt2) {
							printCashOrCardLocal2100();
						}
					}
				}

			}
		});

	} else {
	//	var orderid = document.getElementById('orderNo').value;

			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderid+ ".htm", function(response) {
				try{
					if(response=='Success')
						showPaidBillPrintSuccessModal();
					
				}catch(e)
				{alert(e);}
				}, null);
			
		
	}
}
*/
function printPaidBill(orderid) 
{
	var caseValue =  $("#mobPrintVal1").val();
	var printbillpapersize = $("#printbillpapersize1").val();
	var order = {};
	order.id = orderid;
	order.storeId = storeID;
	var ajaxCallObject = new CustomBrowserXMLObject();
    if (caseValue == "Y") {
		$.ajax({
			type : "POST",
			url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(order),
			success : function(response) {
				var jsonObj = JSON.parse(response);
				/* ***** Store Details ***** */
				console.log(response);
				var orderNo = jsonObj.id;
				var storeBasedOrderNo = jsonObj.orderNo;
				var tabNo = jsonObj.table_no;
				var customerName = jsonObj.customers.name;
				var orderCustomerName = jsonObj.customerName;
				var customerAddr = jsonObj.customers.address;
				var orderCustomerAddr = jsonObj.deliveryAddress;
				var customerPhNo = jsonObj.customers.contactNo;
				var customerEmail = jsonObj.customers.emailId;
				var state=jsonObj.state;
				var orderDateWithTime = jsonObj.customers.orderTime;
				var orderTime = jsonObj.customers.time;
                var cuslocation = jsonObj.location;
                var cusstreet = jsonObj.street;
                var cushouseno = jsonObj.houseNo;
                var delivaryboy = jsonObj.deliveryPersonName;
				var ordercustomerphone= jsonObj.customerContact;
				
				/* ***** Bill Amount Details ***** */
				var storeId = jsonObj.orderBill.storeid;
				var billAmt = jsonObj.orderBill.billAmount;
				var serviceTaxAmt = jsonObj.orderBill.serviceTaxAmt;
				var vatAmt = jsonObj.orderBill.vatAmt;
				var grossAmt = jsonObj.orderBill.grossAmt;
				var totalDiscount = jsonObj.orderBill.totalDiscount;
				var customerDiscount = jsonObj.orderBill.customerDiscount;
				var roundOffAmt = jsonObj.orderBill.roundOffAmt;
				var discPercentage = jsonObj.orderBill.discountPercentage;
				var serviceChargeAmt = jsonObj.orderBill.serviceChargeAmt;
				var subToatlAmt = jsonObj.orderBill.subTotalAmt;
				//var serviceChargeDisc = jsonObj.ordertype.serviceChargeValue;
				var serviceChargeDisc = jsonObj.orderBill.serviceChargeRate;
				var orderTypeOfOrder = jsonObj.ordertype.orderTypeName;
				
				var orderDate=jsonObj.orderTime;
				var afterdiscount = subToatlAmt - customerDiscount + serviceChargeAmt; // new added 2nd Apr 2018
				
				if (printbillpapersize == '58.00') {
					$("#itemDetailsPrint58").text("");
					/* ****** Print in 58 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
					/*$('#storeName58').text(customerName);
					$('#storeAddr58').text(storeAddr);
					$('#storeEmail58').text(customerEmail);
					$('#storePhNo58').text(customerPhNo);*/
					//$('#orderValue58').text(orderNo);
					$('#orderValue58').text(storeBasedOrderNo);
					//$('#tableNoValue58').text(tabNo);
					$('#cashOrderdate58').text(orderDate);
					if(tabNo!='0'){
						$('#tableNoValue58').text('Table No:'+tabNo);
					}
					else{
						$('#tableNoValue58').text(orderTypeOfOrder);
					}
					
					
					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;

						// alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

						var createdrowline = "";
						var startTrline = "<tr style='padding: 1px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 50px !important; word-wrap: break-word; font-size: 10px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px; font-size: 10px;font-family: sans-serif;'>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemRate + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemTotalPrice + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

						$("#itemDetailsPrint58").append(createdrowline);  // it was commented by previous developer

					}
                 
				    $('#scharge58').text(serviceChargeDisc);
					$('#totalAmt58').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						//alert("serviceChargeAmt"+serviceChargeAmt);
						$("#totalServiceChrg_58").show();
						$('#servChrg58').text(serviceChargeAmt);
					} else {
						$("#totalServiceChrg_58").hide();
					}

					if (serviceTaxAmt >0) {
						//alert("serviceTaxAmt"+serviceTaxAmt);
						$("#totalServiceTax_58").show();
						$('#servTax58').text(serviceTaxAmt);
					} else {
						$("#totalServiceTax_58").hide();
					}

					if (vatAmt > 0) {
						//alert("vatAmt"+vatAmt);
						$("#totalVatTax_58").show();
						$("#vatTax58").text(vatAmt);
					} else {
						$("#totalVatTax_58").hide();
					}

					if (customerDiscount > 0) {
						$("#showDiscount_58").show();
						$("#discountValue58").text(customerDiscount);
					} else {
						$("#showDiscount_58").hide();
					}

					$("#grossAmount58").text(billAmt);
					$("#amoutToPay58").text(grossAmt);

					var paymentsObj = jsonObj.payments.length;
					
					if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
                        var paidAmt = jsonObj.orderBill.billAmount;
						var tenderAmt = 0.00;
						var returnAmt = 0.00;
						var type = "";
						$('#paidAmount58').text(parseFloat(paidAmt).toFixed(2));
						$('#tenderAmount58').text(parseFloat(tenderAmt).toFixed(2));
						$('#refund_amount_58px').text(returnAmt);
						$('#payType_58').text(type);

					}
				
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount58').text(paidAmt);

						$('#tenderAmount58').text(tenderAmt);
						$('#refund_amount_58px').text(Math.floor(returnAmt * 100) / 100);
						$('#payType_58').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount58').text(paidAmt);
						$('#tenderAmount58').text(tenderAmt);
						$('#refundAmount58').text("0.00");
						$('#payType58').text(type1 + type2);
					}

					//	$('#helloPrintModal58').modal('show');	
					 if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
							var amt1 = jsonObj.orderBill.billAmount;
							var paidAmt1 = jsonObj.orderBill.billAmount;
							if (amt1 == paidAmt1) {												
								printCashOrCardLocal58();					
							}
						}

					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal58();
						}
					}

					if (paymentsObj == 2) {
						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						;
						if (amt2 == paidAmt2) {
							printCashOrCardLocal58();
						}
					}
					
				} else if(printbillpapersize == '80.00') {
					//alert("print paid 80");
					if( gsttext != '' && gsttext.length>0){
						if(gstno != '' && gstno.length>0){
							   var gstText = gsttext+":"+gstno;
							   document.getElementById('paidgstdata').innerHTML = gstText;
							   $("paidgstdata").show();
							   
						   }
					}
					else{
						 $("paidgstdata").hide();
					}
					$("#itemDetailsPrint80").text("");
					/* ****** Print in 80 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
					/*$('#storeName80').text(customerName);
					$('#storeAddr80').text(storeAddr);
					$('#storeEmail80').text(customerEmail);
					$('#storePhNo80').text(customerPhNo);*/
					//$('#cashOrdervalue80').text(orderNo);
					
					$('#cashOrdervalue80').text(storeBasedOrderNo);
					
					console.log('orderDate'+orderDate);
					$('#cashOrderdate80').text(orderDate);
					if(tabNo!='0'){
						$('#cashtableNoValue80').text('Table No:'+tabNo);
					}
					else{
						$('#cashtableNoValue80').text(orderTypeOfOrder);
					}
					//$('#orderType_80px').text(orderTypeOfOrder);

					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */

					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
                        
						var createdrowline = "";
						var startTrline = "<tr style='padding: 2px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemTotalPrice).toFixed(2) + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

						$("#itemDetailsPrint80").append(createdrowline);

					}

					/* ********** END ITEM DETAILS PRINT ********** */

					/* ********** START AMOUNT INFO PRINT ********** */					
					$('#cashtotalamt80').text(parseFloat(subToatlAmt).toFixed(2));
					if (serviceChargeAmt > 0) {
                         // alert("serviceChargeAmt"+serviceChargeAmt);
						$("#orderAmtDetails .serviceCharge80px").show();
						$('#cashservChrg80').text(parseFloat(serviceChargeAmt).toFixed(2));
						$('#cashservChrgDisc80').text("(" + serviceChargeDisc +")%");
					} else {
					
						$("#orderAmtDetails .serviceCharge80px").hide();
					}
					if (serviceTaxAmt > 0) {
						 //alert("serviceTaxAmt"+serviceTaxAmt);
						$("#cashtotalServiceTax80px").show();
						$('#cashservTax80').text(parseFloat(serviceTaxAmt).toFixed(2));
					} else {
						//alert(" else serviceTaxAmt"+serviceTaxAmt);
						$("#cashtotalServiceTax80px").hide();
					}
					if (vatAmt > 0) {
						// alert("vatAmt"+vatAmt);
						$("#cashtotalVatTax80px").show();
						$("#cashvatTax80px").text(parseFloat(vatAmt).toFixed(2));
					} else {
						$("#cashtotalVatTax80px").hide();
					}
					if (customerDiscount > 0) {
						$("#cashshowDiscount80px").show();
						$("#cashdiscountValue80").text(parseFloat(customerDiscount).toFixed(2));
						$("#paidbilldiscpers").text(parseFloat(discPercentage).toFixed(2));
					
					} else {
						$("#cashshowDiscount80px").hide();
					}
					$("#cashgrossAmount80").text(parseFloat(billAmt).toFixed(2));
					$("#cashamoutToPay80").text(parseFloat(grossAmt).toFixed(2));
					var paymentsObj = jsonObj.payments.length;
					
					if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
                        var paidAmt = jsonObj.orderBill.billAmount;
						var tenderAmt = 0.00;
						var returnAmt = 0.00;
						var type = "";
						$('#paidAmount80').text(parseFloat(paidAmt).toFixed(2));
						$('#tenderAmount80').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundAmount80').text(returnAmt);
						$('#payType80').text(type);

					}
					
					
					
					if (paymentsObj == 1) {
						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount80').text(parseFloat(paidAmt).toFixed(2));
						$('#tenderAmount80').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundAmount80').text(parseFloat(Math.floor(returnAmt * 100) / 100).toFixed(2));
						$('#payType80').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount80').text(parseFloat(paidAmt).toFixed(2));
						$('#tenderAmount80').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundAmount80').text(parseFloat(Math.floor(returnAmt * 100) / 100).toFixed(2));
						$('#payType80').text(type1 + " & " + type2);
					}

					/* ********** END AMOUNT INFO PRINT ********** 	*/				
					 
           /* if(tabNo == '0' && parcelAdd == 'Y'){  */   
			 if(parcelAdd == 'Y'){  
            	      if(orderCustomerName != '' && orderCustomerName != null  && orderCustomerName.length >0){
							//alert(orderCustomerName);
							document.getElementById('cusname80').innerHTML =orderCustomerName;				
							document.getElementById("cusnametr80").style.display = "block";
							
						}
						if(orderCustomerAddr != '' && orderCustomerAddr != null && orderCustomerAddr.length >0){
							document.getElementById('cusaddress80').innerHTML =orderCustomerAddr;											
							 document.getElementById("cusaddresstr80").style.display = "block";
						}
						
						if(ordercustomerphone != '' && ordercustomerphone != null && ordercustomerphone.length >0){
							document.getElementById('cusphno80').innerHTML =ordercustomerphone;
							document.getElementById("cusphnotr80").style.display = "block";
							
						}
						
						if(cuslocation != '' && cuslocation != null && cuslocation.length >0){
							document.getElementById('cuslocation80').innerHTML =cuslocation;
							document.getElementById("cuslocationtr80").style.display = "block";
							
						}
						
						if(cusstreet != '' && cusstreet != null && cusstreet.length >0){
							document.getElementById('cusstreet80').innerHTML =cusstreet;
							document.getElementById("cusstreettr80").style.display = "block";
							 
						}
						

						if(cushouseno != '' && cushouseno != null && cushouseno.length >0){
							document.getElementById('cushouseno80').innerHTML =cushouseno;
							document.getElementById("cushousenotr80").style.display = "block";
							 
						}
						
						
						if(delivaryboy != '' && delivaryboy != null && delivaryboy.length >0){
							document.getElementById('deliveryboy80').innerHTML =delivaryboy;	
							document.getElementById("deliveryboytr80").style.display = "block";
							
						}
						
					}
            else{            	
            	 document.getElementById("cusnametr80").style.display = "none";
            	 document.getElementById("cusaddresstr80").style.display = "none";
            	 document.getElementById("cusphnotr80").style.display = "none";
            	 document.getElementById("cuslocationtr80").style.display = "none";
            	 document.getElementById("cusstreettr80").style.display = "none";
            	 document.getElementById("cushousenotr80").style.display = "none";
            	 document.getElementById("deliveryboytr80").style.display = "none";
            }    
            
            if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
				 //alert("paymentsObj == 1");
				var amt1 = jsonObj.orderBill.billAmount;
				var paidAmt1 = jsonObj.orderBill.billAmount;
				if (amt1 == paidAmt1) {
					//alert("paymentammt == 1");					
					printCashOrCardLocal80();					
				}
			}
               
        	if (paymentsObj == 1) {				
				var amt1 = jsonObj.payments[0].amount;
				var paidAmt1 = jsonObj.payments[0].paidAmount;
				if (amt1 == paidAmt1) {								
					printCashOrCardLocal80();					
				}
			}

			if (paymentsObj == 2) {

				var amt2 = jsonObj.payments[0].amount;
				var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
				
				if (amt2 == paidAmt2) {
					//alert("paymentammt == 2");					
					printCashOrCardLocal80();					
				}
			}
		}else if(printbillpapersize == '2100.00'){							
					/*$('#storeName2100').text(customerName);
					$('#storeAddr2100').text(storeAddr);
					$('#storeEmail2100').text("Email :"+customerEmail);
					$('#storePhNo2100').text("Ph :"+customerPhNo);*/
					//$('#cashOrdervalue2100').text(orderNo);
			         $('#cashOrdervalue2100').text(storeBasedOrderNo);
					$('#cashOrderdate2100').text(orderDate);
					if(tabNo!='0'){
						$('#cashtableNoValue2100').text('Table No:'+tabNo);
					}
					else{
						
						$('#cashtableNoValue2100').text(orderTypeOfOrder);
					}										
					//$('#cashtableNoValue2100').text(tabNo);
					
					/* ********** For GST *********** */				
					$('#storeName2100_GST').text(customerName);
					$('#storeAddr2100_GST').text(storeAddr);
					$('#storeEmail2100_GST').text(customerEmail);
					$('#storePhNo2100_GST').text(customerPhNo);
					//$('#cashOrdervalue2100_GST').text(orderNo);
					$('#cashOrdervalue2100_GST').text(storeBasedOrderNo);
					$('#cashOrderDate_GST').text(orderDateWithTime);
					
					$('#cashCustName_GST').text(orderCustomerName);
					$('#cashCustAddr_GST').text(orderCustomerAddr);
					$('#cashCustState_GST').text(state);
					$('#cashCustGSTIN_GST').text(jsonObj.custVatRegNo);
					$('#cashCustPhone2100_GST').text(ordercustomerphone);
					
					var formattedDate = new Date(jsonObj.orderDate);
					var d = formattedDate.getDate();
					var m =  formattedDate.getMonth();
					m += 1;  // JavaScript months are 0-11
					var y = formattedDate.getFullYear();
					$("#cashOrderDate_GST").text(y + "-" + m + "-" + d);
					
					/* *********** End ************* */
					
					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */
					
					$("#itemDetailsPrint2100_GST").html('');

					 var totTaxable = 0.0;
					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
						var itemUnit = item1.item.unit;
						var itemDisc = item1.promotionDiscountAmt;
						var itemTotalAmt = 0.0;
						var itemTaxableAmt = 0.0;
						var cgstPrcnt = item1.vat;
						var cgstAmt = 0.0;
						var sgstPrcnt = item1.serviceTax;
						var sgstAmt = 0.0;
						var itemHsn = "";
						var itemschrgeamt = 0.0;
						
						if(item1.item.promotionFlag == "Y")
						{							
							itemTotalAmt = (item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem;
							if(item1.item.spotDiscount == "Y"){
								itemDisc = (itemTotalAmt * discPercentage)/100; 
							}
							else{
								itemDisc = 0.00;
							}
							
							if(serviceChargeAmt >0){
								itemschrgeamt = ((Number(itemTotalAmt) - Number(itemDisc)) * serviceChargeDisc)/100;	
							}
							
							
							itemTaxableAmt = (((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt)- itemDisc + itemschrgeamt;
							cgstAmt = (((((((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt)) - itemDisc) + itemschrgeamt )* item1.vat)/100;
							sgstAmt = (((((((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt))- itemDisc) + itemschrgeamt) * item1.serviceTax)/100;
						}
						else
						{
							itemTotalAmt = item1.quantityOfItem*item1.item.price;
							if(item1.item.spotDiscount == "Y"){
								itemDisc = (itemTotalAmt * discPercentage)/100; 
							}
							else{
								itemDisc = 0.00;
							}
							if(serviceChargeAmt >0){
								itemschrgeamt = ((Number(itemTotalAmt) - Number(itemDisc)) * serviceChargeDisc)/100;	
							}
							itemTaxableAmt = (((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt) - itemDisc) + itemschrgeamt;
							cgstAmt = ((((((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt))- itemDisc) + itemschrgeamt) * item1.vat)/100;
							sgstAmt = ((((((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt))- itemDisc) + itemschrgeamt) * item1.serviceTax)/100;
						}
										
						totTaxable = totTaxable + itemTaxableAmt;
						var createdrowline = "";
						var startTrline1 = "<tr>";
						var firstTdline = "<td width='30%;'>" + itemName + "</td>";
						var secondTdline = "<td width='6%;'>" + itemQty + "</td>";
						var thirdTdline = "<td width='5%;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
						var fourthTdline = "<td width='5%;'>" + parseFloat(itemTotalAmt).toFixed(2) + "</td>";
						var unit_clm = "<td width='6%;'>" + itemUnit + "</td>";
						var disc_clm = "<td width='5%;'>" + parseFloat(itemDisc).toFixed(2) + "</td>";
						var scharge_clm = "";
						if(serviceChargeAmt >0){
							scharge_clm ="<td width='5%;'>" + Number(itemschrgeamt).toFixed(2) + "</td>";
						}
						var taxable_clm = "<td width='10%;'>" + parseFloat(itemTaxableAmt).toFixed(2) + "</td>";
						var cgstPrcnt_clm = "<td width='5%;'>" + parseFloat(cgstPrcnt).toFixed(2) + "</td>";
						var cgstAmt_clm = "<td width='10%;'>" + parseFloat(cgstAmt).toFixed(2) + "</td>";
						var sgstPrcnt_clm = "<td width='5%;'>" + parseFloat(sgstPrcnt).toFixed(2) + "</td>";
						var sgstAmt_clm = "<td width='10%;'>" + parseFloat(sgstAmt).toFixed(2) + "</td>";
						var igstPrcnt_clm = "<td width='5%;'></td>";
						var igstAmt_clm = "<td width='10%;'></td>";
						var sl_no = "<td width='5%;'>"+(k+1)+"</td>";
						var hsn_clm = "<td></td>";
						var sac_clm = "<td></td>";
						var endTrline1 = "</tr>";

						createdrowline1 = startTrline1 + sl_no + firstTdline + hsn_clm + sac_clm + secondTdline + unit_clm + thirdTdline + fourthTdline + disc_clm + scharge_clm+ taxable_clm + cgstPrcnt_clm + cgstAmt_clm + sgstPrcnt_clm + sgstAmt_clm + igstPrcnt_clm + igstAmt_clm + endTrline1;

						$("#itemDetailsPrint2100_GST").append(createdrowline1);

					}
					var startTrline2 = "<tr style='border-top: 1px dashed;'>";
					var blank_clm1 = "<td></td><td></td><td></td><td></td><td></td><td></td>";
					var total_txt = "<td><b>Total:</b></td>";
					var total_amt_clm = "<td>"+parseFloat(subToatlAmt).toFixed(2)+"</td>";
					
					//var total_disc_clm = "<td>" + parseFloat(totalDiscount).toFixed(2) + "</td>";
					var total_disc_clm = "<td>" + parseFloat(customerDiscount).toFixed(2) + "</td>"; // changed in 2nd Apr 18					
					//var total_taxable_clm = "<td>" + parseFloat(totTaxable).toFixed(2) + "</td>";
					var total_schargeamount_clm="";
					if(serviceChargeAmt >0){
						total_schargeamount_clm = "<td>" + parseFloat(serviceChargeAmt).toFixed(2) + "</td>";
					}
					
					var total_taxable_clm = "<td>" + parseFloat(afterdiscount).toFixed(2) + "</td>"; // changed in 2nd Apr 18
					
					var blank_clm2 = "<td></td>";
					var total_cgstAmt_clm = "<td>" + parseFloat(vatAmt).toFixed(2) + "</td>";
					var blank_clm3 = "<td></td>";
					var total_sgstAmt_clm = "<td>" + parseFloat(serviceTaxAmt).toFixed(2) + "</td>";
					var blank_clm4 = "<td></td>";
					var total_igstAmt_clm = "<td></td>";
					var endTrline2 = "</tr>";

					createdrowline2 = startTrline2 + blank_clm1 + total_txt + total_amt_clm + total_disc_clm +total_schargeamount_clm+ total_taxable_clm + blank_clm2 + total_cgstAmt_clm + blank_clm3 + total_sgstAmt_clm + blank_clm4 + total_igstAmt_clm + endTrline2;

					$("#itemDetailsPrint2100_GST").append(createdrowline2);

					/* ********** END ITEM DETAILS PRINT ********** */

					/* ********** START AMOUNT INFO PRINT ********** */
					
					$('#cashtotalamt2100').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#cashtotalServiceCharge2100px").show();
						$('#cashservChrgPercentage2100').text(serviceChargeDisc);
						$('#cashservChrg2100').text(serviceChargeAmt);
					} else {
						$("#cashtotalServiceCharge2100px").hide();
					}

					if (serviceTaxAmt > 0.00) {
						$("#cashtotalServiceTax2100px").show();
						$('#cashservTax2100').text(serviceTaxAmt);
					} else {
						$("#cashtotalServiceTax2100px").hide();
					}

					if (vatAmt > 0) {
						$("#cashtotalVatTax2100px").show();
						$("#cashvatTax2100px").text(vatAmt);
					} else {
						$("#cashtotalVatTax2100px").hide();
					}

					if (customerDiscount > 0) {
						$("#cashshowDiscount2100px").show();
						$("#cashdiscountValue2100").text(customerDiscount);
					} else {
						$("#cashshowDiscount2100px").hide();
					}

					$("#cashgrossAmount2100").text(billAmt);
					$("#cashamoutToPay2100").text(grossAmt);

					$("#cashgrossAmount2100_gst").text(parseFloat(grossAmt).toFixed(2));
					$("#cashvatTax2100px_gst").text(parseFloat(vatAmt).toFixed(2));
					$('#cashservTax2100_gst').text(parseFloat(serviceTaxAmt).toFixed(2));
					$('#cashTotalTaxAmount2100_gst').text(Number(Number(serviceTaxAmt) + Number(vatAmt)).toFixed(2));
					
					var cash_gross_word = number2text(parseFloat(grossAmt).toFixed(2));
					
					$("#cashgrossAmount2100_word_gst").text(cash_gross_word);
					
					$("#paidAmount_paidbill_2100px").text(parseFloat(grossAmt).toFixed(2)); // new added 10.5.2018
					$("#amoutToPay_paidbill_2100px").text('00.00'); // new added 10.5.2018
					
					var paymentsObj = jsonObj.payments.length;
					
					var paymentmode = "";
					var coma = ',';
					if (paymentsObj == 1) {
						paymentmode=jsonObj.payments[0].paymentMode;
					}else{
						for(var i=0;i<paymentsObj;i++){
							if(paymentmode == ""){
								paymentmode=jsonObj.payments[i].paymentMode;
							}else{
								paymentmode = paymentmode + coma + jsonObj.payments[i].paymentMode;
							}
						}
					}
					$("#paymentmode_paidbill_2100px").text(paymentmode);
					
					
					
					if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt
                        var paidAmt = jsonObj.orderBill.billAmount;
						var tenderAmt = 0.00;
						var returnAmt = 0.00;
						var type = "";
						$('#paidAmount2100').text(parseFloat(paidAmt).toFixed(2));
						$('#tenderAmount2100').text(parseFloat(tenderAmt).toFixed(2));
						$('#refundAmount2100').text(returnAmt);
						$('#payType2100').text(type);

					}
					if (paymentsObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmount2100').text(paidAmt);
						$('#tenderAmount2100').text(tenderAmt);
						$('#refundAmount2100').text(Math.floor(returnAmt * 100) / 100);
						$('#payType2100').text(type);

					}
					if (paymentsObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmount2100').text(paidAmt);
						$('#tenderAmount2100').text(tenderAmt);
						$('#refundAmount2100').text("0.00");
						$('#payType2100').text(type1 + type2);
					}

					/* ********** END AMOUNT INFO PRINT ********** */	
					
					 if (paymentsObj == 0) { // for advance booking with advance payment which amt is > bill amt						
							var amt1 = jsonObj.orderBill.billAmount;
							var paidAmt1 = jsonObj.orderBill.billAmount;
							if (amt1 == paidAmt1) {											
								printCashOrCardLocal2100();					
							}
						}

					if (paymentsObj == 1) {
						var amt1 = jsonObj.payments[0].amount;
						var paidAmt1 = jsonObj.payments[0].paidAmount;
						if (amt1 == paidAmt1) {
							printCashOrCardLocal2100();
						}
					}

					if (paymentsObj == 2) {

						var amt2 = jsonObj.payments[0].amount;
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						
						if (amt2 == paidAmt2) {
							printCashOrCardLocal2100();
						}
					}
				}

			}
		});

	} else {	
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderid+ ".htm", function(response) {
				try{
					if(response=='Success')
						showPaidBillPrintSuccessModal();
					
				}catch(e)
				{alert(e);}
				}, null);
			
		
	}
}



function paymentDone() {
	
	var date = document.getElementById('dateunpaidorderList').value;
	location.href=BASE_URL+'/unpaidorderlist/unpaidorderSpecificDate.htm?storeId='+storeId+'&date='+date;
}


function paymentDonePeriodWise() {
	
	var fromdate = document.getElementById('fromdateunpaidorderList').value;
	var todate = document.getElementById('todateunpaidorderList').value;
	
	location.href=BASE_URL+'/unpaidorderlist/unpaidorderPeriodWise.htm?storeId='+storeId+'&fromdate='+fromdate+'&todate='+todate;
}

//test post
//var storeId= ${sessionScope.loggedinStore.id} ;
function addCategory() {
	document.getElementById('addalertMsg').innerHTML = '';
	var catName = decodeURIComponent(document
			.getElementById('addcategorynameContId').value);
	var bgColor = decodeURIComponent(document
			.getElementById('addbgcolorContId').value);
	// var storeID=storeId;
	if (catName == '' || bgColor == '') {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(catName) || (/[#%?\/\\]/gi).test(bgColor)) {
		document.getElementById('addalertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		var maneCategoryPost = {};
		maneCategoryPost.menuCategoryName = catName;
		maneCategoryPost.bgColor = bgColor;
		maneCategoryPost.storeId = storeID;
		$
				.ajax({
					url : BASE_URL + "/menumgnt/addmenucategory.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(maneCategoryPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'success') {
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

function cancelCategory() {
	
	document.getElementById('editalertMsg').innerHTML = '';
}
function editCategory() {
	document.getElementById('editalertMsg').innerHTML = '';
	var id = document.getElementById('modeditcatidContId').value;
	var name = decodeURIComponent(document
			.getElementById('editcategorynameContId').value);
	var color = decodeURIComponent(document.getElementById('editbgcolorContId').value);
	if (name == '') {
		document.getElementById('editalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(color)) {
		document.getElementById('editalertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		var maneCategoryEditPost = {};
		maneCategoryEditPost.id = id;
		maneCategoryEditPost.menuCategoryName = name;
		maneCategoryEditPost.bgColor = color;
		maneCategoryEditPost.storeId = storeID;
		$
				.ajax({
					url : BASE_URL + "/menumgnt/editmenucategory.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(maneCategoryEditPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						closenmenucateditModal();
						if (response == 'success') {
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
function deleteCategory() {
	var id = document.getElementById('moddeleteconfirmcatidContId').value;
	var name = decodeURIComponent(document
			.getElementById('moddeleteconfirmcatnameContId').value);
	var color = decodeURIComponent(document
			.getElementById('moddeleteconfirmcatbgcolorContId').value);

	var maneCategoryDeletePost = {};
	maneCategoryDeletePost.id = id;
	maneCategoryDeletePost.menuCategoryName = name;
	maneCategoryDeletePost.bgColor = color;
	maneCategoryDeletePost.storeId = storeID;
	$
			.ajax({
				url : BASE_URL + "/menumgnt/deletemenucategory.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(maneCategoryDeletePost),
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

/* end menu category management */
/* start menu sub category management */
function loadsubCategoryPage(menucatid) {
	// alert('hi'+menucatid);
	location.href = BASE_URL + "/menumgnt/loadsubcategorybyid.htm?menucatid="
			+ menucatid;
}

function addSubCategory() {
	document.getElementById('addsubcatalertMsg').innerHTML = '';
	var catId = document.getElementById('menucatId').value;
	var subcatName = decodeURIComponent(document
			.getElementById('addsubcategorynameContId').value);
	var subcatbgColor = decodeURIComponent(document
			.getElementById('addsubcatbgcolorContId').value);
	document.getElementById('alertsubcatiddataopmodal').value = catId;
	// var storeId=storeID;
	if (subcatName == '' || subcatbgColor == '') {
		document.getElementById('addsubcatalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(subcatName)
			|| (/[#%?\/\\]/gi).test(subcatbgColor)) {
		document.getElementById('addsubcatalertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		var maneSubCategoryPost = {};
		maneSubCategoryPost.parentCatId = catId;
		maneSubCategoryPost.menuCategoryName = subcatName;
		maneSubCategoryPost.bgColor = subcatbgColor;
		maneSubCategoryPost.storeId = storeID;
		$
				.ajax({
					url : BASE_URL + "/menumgnt/addmenusubcategory.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(maneSubCategoryPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'success') {
							document.getElementById('subcatdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertsubcatdataopModal();
						} else {
							document.getElementById('subcatdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertsubcatdataopModal();
						}
					}
				});
	}
}

function cancelSubCategory() {
	
	document.getElementById('editsubcatalertMsg').innerHTML = '';
}

function editSubCategory() {
	document.getElementById('editsubcatalertMsg').innerHTML = '';
	var catId = document.getElementById('menucatId').value;
	var id = document.getElementById('modeditsubcatidContId').value;
	var name = decodeURIComponent(document
			.getElementById('editsubcategorynameContId').value);
	var color = decodeURIComponent(document
			.getElementById('editsubcatbgcolorContId').value);
	document.getElementById('alertsubcatiddataopmodal').value = catId;
	if (name == '') {
		document.getElementById('editsubcatalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(color)) {
		document.getElementById('editsubcatalertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		var maneSubCategoryEditPost = {};
		maneSubCategoryEditPost.id = id;
		maneSubCategoryEditPost.parentCatId = catId;
		maneSubCategoryEditPost.menuCategoryName = name;
		maneSubCategoryEditPost.bgColor = color;
		maneSubCategoryEditPost.storeId = storeID;
		$
				.ajax({
					url : BASE_URL + "/menumgnt/editmenusubcategory.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(maneSubCategoryEditPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'success') {
							document.getElementById('subcatdataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertsubcatdataopModal();
						} else {
							document.getElementById('subcatdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertsubcatdataopModal();
						}
					}
				});
		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/menumgnt/editmenusubcategory/" +
		 * id + "/" + name + "/" + color+"/" +catId+ ".htm", function(response) {
		 * closenmenusubcateditModal(); if(response==success) {
		 * document.getElementById('subcatdataopmassagecont').innerHTML=getLang.datasucUpdate;
		 * showalertsubcatdataopModal(); } else{
		 * document.getElementById('subcatdataopmassagecont').innerHTML=getLang.datasucNotUpdate;
		 * showalertsubcatdataopModal(); } //loadsubCategoryPage(catId); },
		 * null);
		 */
	}
}
function deleteSubCategory() {
	var catId = document.getElementById('menucatId').value;
	var id = document.getElementById('moddeleteconfirmsubcatidContId').value;
	var name = decodeURIComponent(document
			.getElementById('moddeleteconfirmsubcatnameContId').value);
	var color = decodeURIComponent(document
			.getElementById('moddeleteconfirmsubcatbgcolorContId').value);
	document.getElementById('alertsubcatiddataopmodal').value = catId;

	var maneSubCategoryDeletePost = {};
	maneSubCategoryDeletePost.id = id;
	maneSubCategoryDeletePost.parentCatId = catId;
	maneSubCategoryDeletePost.menuCategoryName = name;
	maneSubCategoryDeletePost.bgColor = color;
	maneSubCategoryDeletePost.storeId = storeID;
	$
			.ajax({
				url : BASE_URL + "/menumgnt/deletemenusubcategory.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(maneSubCategoryDeletePost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					// closenmenucateditModal();
					if (response == 'success') {
						document.getElementById('subcatdataopmassagecont').innerHTML = getLang.datasucDelete;
						showalertsubcatdataopModal();
					} else {
						document.getElementById('subcatdataopmassagecont').innerHTML = getLang.datasucNotDelete;
						showalertsubcatdataopModal();
					}
				}
			});
	/*
	 * var ajaxCallObject = new CustomBrowserXMLObject();
	 * ajaxCallObject.callAjax(BASE_URL + "/menumgnt/deletemenusubcategory/"
	 * +id+"/"+ name + "/" + color + "/"+catId+".htm", function(response) {
	 * if(response==success) {
	 * document.getElementById('subcatdataopmassagecont').innerHTML=getLang.datasucDelete;
	 * showalertsubcatdataopModal(); } else{
	 * document.getElementById('subcatdataopmassagecont').innerHTML=getLang.datasucNotDelete;
	 * showalertsubcatdataopModal(); } //loadsubCategoryPage(catId); }, null);
	 */
}
/* end menu sub category management */
/* start menu items management */
/*
 * function loadmenuItemsPage() { loadMenuItemsPage(BASE_URL +
 * "/menumgnt/loadmenuitems.htm",document.getElementById('menumgntContainerId')); }
 * function loadMenuItemsPage(url,containerId) { var ajaxCallObject = new
 * CustomBrowserXMLObject(); ajaxCallObject.callAjax(url, function(response) {
 * containerId.innerHTML = response; }, null); }
 */
function loadmenuItems(itemid) {
	// alert(itemid);
	if (itemid.length == 0) {
		showalertnoItemFoundModal();
	} else {
		location.href = BASE_URL + '/menumgnt/loadmenuitemsbyid.htm?itemid='
				+ itemid;
	}
	// loadmenuItems(BASE_URL +
	// "/menumgnt/loadmenuitemsbyid.htm?itemid="+itemid,document.getElementById('menumgntContainerId'));
}
function selectCatValue(catid) {

	var res = catid.split('~');
	var id = res[0];
	var catname = res[1];
	// alert(catname);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/menumgnt/getsubcategorylistbycategory/" + id
							+ ".htm",
					function(response) {
						var responseObj = [];
						responseObj = JSON.parse(response);
						var optionline = "";
						for ( var i = 0; i < responseObj.length; i++) {
							var id = responseObj[i].id;
							var name = responseObj[i].menuCategoryName;
							optionline += "<option value='" + id + "'>" + name
									+ "</option>";
						}
						document.getElementById('menusubcategoryId').innerHTML = optionline;
					}, null);
	if (catname == getLang.splNote) {
		document.getElementById('modaddmenuitemsPrice').value = 0.0;
		document.getElementById('modaddmenuitemsVat').value = 0.0;
		document.getElementById('modaddmenuitemsStax').value = 0.0;
	} else {
		document.getElementById('modaddmenuitemsPrice').value = '';
		document.getElementById('modaddmenuitemsVat').value = vatses;
		document.getElementById('modaddmenuitemsStax').value = staxses;
	}
}
function addMenuItems() {
	document.getElementById('addmenuitemsalertMsg').innerHTML = '';
	var catId = document.getElementById('menusubcategoryId').value;
	/*var name = decodeURIComponent(document
			.getElementById('modaddmenuitemsName').value);*/
	var name = document.getElementById('modaddmenuitemsName').value;
	/*var desc = decodeURIComponent(document
			.getElementById('modaddmenuitemsDesc').value);*/
	var desc = document.getElementById('modaddmenuitemsDesc').value;			
	var price = document.getElementById('modaddmenuitemsPrice').value;
	var vat = document.getElementById('modaddmenuitemsVat').value;
	var stax = document.getElementById('modaddmenuitemsStax').value;
	var typeoption = document.getElementsByName('modaddmenuitemsType');
	var spicyoption = document.getElementsByName('modaddmenuitemsSpicy');
	var promooption = document.getElementsByName('modaddmenuitemsPromo');
	var promodesc = document.getElementById('modaddmenuitemsPromoDesc').value;
	var promovalue = document.getElementById('modaddmenuitemsPromoValue').value;
	var cookingtime = document.getElementById('modaddmenuitemsCookingTime').value;
	var unit = document.getElementById('modaddmenuitemsUnit').value;
	var prRadioValue = document.getElementById('modaddmenuitemspromoYes').value;
	var isKotPrintval= document.getElementById('modaddmenuitemsKotPrint').value;
	//alert("isKotPrintval:"+isKotPrintval);
	promodesc = promodesc == '' ? null : promodesc;
	promovalue = promovalue == '' ? 0 : promovalue;
	var type = null;
	var spicy = null;
	var promo = null;
	for ( var i = 0; i < typeoption.length; i++) {
		if (typeoption[i].checked == true) {
			type = typeoption[i].value;
		}
	}
	for ( var i = 0; i < spicyoption.length; i++) {
		if (spicyoption[i].checked == true) {
			spicy = spicyoption[i].value;
		}
	}
	for ( var i = 0; i < promooption.length; i++) {
		if (promooption[i].checked == true) {
			promo = promooption[i].value;
		}
	}
	// alert(catId+':'+name+':'+desc+':'+price+':'+vat+':'+stax+':'+type+':'+spicy+':'+promo+':'+promodesc+':'+promovalue);
	
		 if (name == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterName;
			} else if (desc == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterDesc;
			} /*else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(desc)) {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.charNotAlowd;
			}*/ else if (isNaN(price) || price == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterPrice;
			} else if (isNaN(vat) || vat == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterVat;
			} else if (isNaN(stax) || stax == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterstax;
			} else if (isNaN(cookingtime) || cookingtime == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEntersCookTime;
			} else {
				var maneItemaddPost = {};
				var menucategory = {};
				menucategory.id = catId;
				maneItemaddPost.menucategory = menucategory;
				maneItemaddPost.name = name;
				maneItemaddPost.description = desc;
				maneItemaddPost.price = price;
				maneItemaddPost.vat = vat;
				maneItemaddPost.serviceTax = stax;
				maneItemaddPost.veg = type;
				maneItemaddPost.spicy = spicy;
				maneItemaddPost.promotionFlag = promo;
				maneItemaddPost.promotionDesc = promodesc;
				maneItemaddPost.promotionValue = promovalue;
				maneItemaddPost.cookingtime = cookingtime;
				maneItemaddPost.unit = unit;
				maneItemaddPost.isKotPrint=isKotPrintval;
				maneItemaddPost.purchasePrice=0.0;

				$
						.ajax({
							url : BASE_URL + "/menumgnt/addmenuitems.htm",
							type : 'POST',
							contentType : 'application/json;charset=utf-8',
							data : JSON.stringify(maneItemaddPost),
							success : function(response, JSON_UNESCAPED_UNICODE) {
								console.log(response);
								// closenmenucateditModal();
								if (response == 'success') {
									document
											.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucAdd;
									showalertmenuitemdataopModal();
								} else {
									document
											.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucNotAdd;
									showalertmenuitemdataopModal();
								}
							}
						});
				/*
				 * var ajaxCallObject = new CustomBrowserXMLObject();
				 * ajaxCallObject.callAjax(BASE_URL + "/menumgnt/addmenuitems/" + catId +
				 * "/" + name +"/"+desc +"/"+price +"/"+vat +"/"+stax +"/"+type
				 * +"/"+spicy +"/"+promo +"/"+promodesc
				 * +"/"+promovalue+"/"+cookingtime+"/"+unit+ ".htm", function(response) {
				 * closenmenuitemsaddModal(); if(response==success) {
				 * document.getElementById('menuitemdataopmassagecont').innerHTML=getLang.datasucAdd;
				 * showalertmenuitemdataopModal(); } else{
				 * document.getElementById('menuitemdataopmassagecont').innerHTML=getLang.datasucNotAdd;
				 * showalertmenuitemdataopModal(); }
				 * //location.href=BASE_URL+'/menumgnt/loadmenuitems.htm'; }, null);
				 */
			}
	
	
	
}

/*
 * function addSplItems() { $(".chk:checked").val(); $('.chk').prop('checked',
 * false);
 * 
 * document.getElementById('addmenuitemsalertMsg').innerHTML=''; var
 * catId=document.getElementById('menusubcategoryId').value; var
 * name=decodeURIComponent(document.getElementById('modaddmenuitemsName').value);
 * var
 * desc=decodeURIComponent(document.getElementById('modaddmenuitemsDesc').value);
 * var price=document.getElementById('modaddmenuitemsPrice').value; var
 * vat=document.getElementById('modaddmenuitemsVat').value; var
 * stax=document.getElementById('modaddmenuitemsStax').value; var
 * typeoption=document.getElementsByName('modaddmenuitemsType'); var
 * spicyoption=document.getElementsByName('modaddmenuitemsSpicy'); var
 * promooption=document.getElementsByName('modaddmenuitemsPromo'); var
 * promodesc=document.getElementById('modaddmenuitemsPromoDesc').value; var
 * promovalue=document.getElementById('modaddmenuitemsPromoValue').value; var
 * cookingtime=document.getElementById('modaddmenuitemsCookingTime').value; var
 * unit=document.getElementById('modaddmenuitemsUnit').value; var
 * bgColor=$(".chk_add:checked").val(); var bgColor1="#"+ bgColor;
 * promodesc=promodesc==''?null:promodesc;
 * promovalue=promovalue==''?0:promovalue; var type=null; var spicy=null; var
 * promo=null; for(var i = 0; i < typeoption.length; i++)
 * {if(typeoption[i].checked == true) {type = typeoption[i].value;}} for(var i =
 * 0; i < spicyoption.length; i++) {if(spicyoption[i].checked == true) {spicy =
 * spicyoption[i].value;}} for(var i = 0; i < promooption.length; i++)
 * {if(promooption[i].checked == true) {promo = promooption[i].value;}}
 * //alert(catId+':'+name+':'+desc+':'+price+':'+vat+':'+stax+':'+type+':'+spicy+':'+promo+':'+promodesc+':'+promovalue);
 * 
 * if(name=='') {
 * document.getElementById('addmenuitemsalertMsg').innerHTML=getLang.plsEnterName; }
 * else if(desc=='') {
 * document.getElementById('addmenuitemsalertMsg').innerHTML=getLang.plsEnterDesc; }
 * else if($(".chk_add:checked").val() ===
 * undefined||$(".chk_add:checked").val()=== null) {
 * document.getElementById('addmenuitemsalertMsg').innerHTML=getLang.plsEnterColor; }
 * else if($(".chk_add:checked").length > 1) {
 * document.getElementById('addmenuitemsalertMsg').innerHTML=getLang.plsSelectColor; }
 * else if((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(desc)) {
 * document.getElementById('addmenuitemsalertMsg').innerHTML=getLang.charNotAlowd; }
 * else if(isNaN(vat) || vat=='') {
 * document.getElementById('addmenuitemsalertMsg').innerHTML=getLang.plsEnterVat; }
 * else if( isNaN(stax) || stax=='') {
 * document.getElementById('addmenuitemsalertMsg').innerHTML=getLang.plsEnterstax; }
 * else if( isNaN(cookingtime) || cookingtime=='') {
 * document.getElementById('addmenuitemsalertMsg').innerHTML=getLang.plsEntersCookTime; }
 * else{ var manusplItemaddPost={}; var menucategory={}; menucategory.id=catId;
 * manusplItemaddPost.menucategory=menucategory; manusplItemaddPost.name=name;
 * manusplItemaddPost.description=desc; manusplItemaddPost.price=price;
 * manusplItemaddPost.vat=vat; manusplItemaddPost.serviceTax=stax;
 * manusplItemaddPost.veg=type; manusplItemaddPost.spicy=spicy;
 * manusplItemaddPost.promotionFlag =promo;
 * manusplItemaddPost.promotionDesc=promodesc; manusplItemaddPost.promotionValue
 * =promovalue; manusplItemaddPost.cookingtime =cookingtime;
 * manusplItemaddPost.unit =unit; manusplItemaddPost.bgColor=bgColor1;
 * 
 * $.ajax({ url: BASE_URL + "/menumgnt/addsplnote.htm", type : 'POST',
 * contentType : 'application/json;charset=utf-8', data :
 * JSON.stringify(manusplItemaddPost), success :
 * function(response,JSON_UNESCAPED_UNICODE){ console.log(response);
 * //closenmenucateditModal(); if(response=='success') {
 * document.getElementById('menuitemdataopmassagecont').innerHTML='Data is
 * sucessfully added!'; showalertmenuitemdataopModal(); } else{
 * document.getElementById('menuitemdataopmassagecont').innerHTML='Data is not
 * added.Please try again!'; showalertmenuitemdataopModal(); } } }); } }
 */
function addSplItems() {
	$(".chk:checked").val();
	$('.chk').prop('checked', false);

	document.getElementById('addmenuitemsalertMsg').innerHTML = '';
	//var catId = document.getElementById('menusubcategoryId').value;
	var catId = document.getElementById('menucategoryId').value;
	var subcatId=document.getElementById('menusubcategoryId').value;
	var name = decodeURIComponent(document.getElementById('modaddmenuitemsName').value);
	var desc = decodeURIComponent(document.getElementById('modaddmenuitemsDesc').value);
	/*var price = document.getElementById('modaddmenuitemsPrice').value;
	var vat = document.getElementById('modaddmenuitemsVat').value;
	var stax = document.getElementById('modaddmenuitemsStax').value;
	var typeoption = document.getElementsByName('modaddmenuitemsType');
	var spicyoption = document.getElementsByName('modaddmenuitemsSpicy');
	var promooption = document.getElementsByName('modaddmenuitemsPromo');
	var promodesc = document.getElementById('modaddmenuitemsPromoDesc').value;
	var promovalue = document.getElementById('modaddmenuitemsPromoValue').value;
	var cookingtime = document.getElementById('modaddmenuitemsCookingTime').value;
	var unit = document.getElementById('modaddmenuitemsUnit').value;*/
	var bgColor = $(".chk_add:checked").val();
	var bgColor1 = "#" + bgColor;
	
	/*promodesc = promodesc == '' ? null : promodesc;
	promovalue = promovalue == '' ? 0 : promovalue;
	var type = null;
	var spicy = null;
	var promo = null;
	for ( var i = 0; i < typeoption.length; i++) {
		if (typeoption[i].checked == true) {
			type = typeoption[i].value;
		}
	}
	for ( var i = 0; i < spicyoption.length; i++) {
		if (spicyoption[i].checked == true) {
			spicy = spicyoption[i].value;
		}
	}
	for ( var i = 0; i < promooption.length; i++) {
		if (promooption[i].checked == true) {
			promo = promooption[i].value;
		}
	}*/
	// alert(catId+':'+name+':'+desc+':'+price+':'+vat+':'+stax+':'+type+':'+spicy+':'+promo+':'+promodesc+':'+promovalue);

	if (name == '') {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterName;
	} else if (desc == '') {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterDesc;
	} else if ($(".chk_add:checked").val() === undefined
			|| $(".chk_add:checked").val() === null) {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterColor;
	} else if ($(".chk_add:checked").length > 1) {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsSelectColor;
	} else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(desc)) {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.charNotAlowd;
	} /*else if (isNaN(vat) || vat == '') {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterVat;
	} else if (isNaN(stax) || stax == '') {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterstax;
	} else if (isNaN(cookingtime) || cookingtime == '') {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEntersCookTime;
	}*/ else {
		var manusplItemaddPost = {};
		var menucategory = {};
		menucategory.id = subcatId;
		manusplItemaddPost.menucategory = menucategory;
		manusplItemaddPost.name = name;
		manusplItemaddPost.description = desc;
		/*manusplItemaddPost.price = price;
		manusplItemaddPost.vat = vat;
		manusplItemaddPost.serviceTax = stax;
		manusplItemaddPost.veg = type;
		manusplItemaddPost.spicy = spicy;
		manusplItemaddPost.promotionFlag = promo;
		manusplItemaddPost.promotionDesc = promodesc;
		manusplItemaddPost.promotionValue = promovalue;
		manusplItemaddPost.cookingtime = cookingtime;
		manusplItemaddPost.unit = unit;*/
		manusplItemaddPost.bgColor = bgColor1;
		manusplItemaddPost.production = 'Y';

		$
				.ajax({
					url : BASE_URL + "/menumgnt/addsplnote.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(manusplItemaddPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucateditModal();
						if (response == 'success') {
							document
									.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertmenuitemdataopModal();
						} else {
							document
									.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertmenuitemdataopModal();
						}
					}
				});

		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/menumgnt/addsplnote/" + catId +
		 * "/" + name +"/"+desc +"/"+price +"/"+vat +"/"+stax +"/"+type
		 * +"/"+spicy +"/"+promo +"/"+promodesc
		 * +"/"+promovalue+"/"+cookingtime+"/"+unit+"/"+bgColor+ ".htm",
		 * function(response) { closenmenuitemsaddModal(); if(response==success) {
		 * document.getElementById('menuitemdataopmassagecont').innerHTML=getLang.datasucAdd;
		 * showalertmenuitemdataopModal(); } else{
		 * document.getElementById('menuitemdataopmassagecont').innerHTML=getLang.datasucNotAdd;
		 * showalertmenuitemdataopModal(); }
		 * //location.href=BASE_URL+'/menumgnt/loadmenuitems.htm'; }, null);
		 */
	}
}

function editSplNote(){
	
	$(".chk:checked").val();
	$('.chk').prop('checked', false);

	document.getElementById('addmenuitemsalertMsg').innerHTML = '';
	var id=document.getElementById('modeditmenuitemsId').value;
	var catId = document.getElementById('menucategoryId').value;
	var subcatId=document.getElementById('menusubcategoryId').value;
	var name = decodeURIComponent(document.getElementById('modeditmenuitemsName').value);
	var desc = decodeURIComponent(document.getElementById('modeditmenuitemsDesc').value);
	var bgColor = $(".clk:checked").val();
	var bgColor1 = "#" + bgColor;

	//alert(catId+':'+name+':'+desc+':'+price+':'+vat+':'+stax+':'+type+':'+spicy+':'+promo+':'+promodesc+':'+promovalue);
	//alert(id+':'+catId+':'+subcatId+":"+name+':'+desc+':'+bgColor1);
	   
	
	
	if (name == '') {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterName;
	} else if (desc == '') {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterDesc;
	} else if ($(".chk_add:checked").val() === undefined
			|| $(".chk_add:checked").val() === null) {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsEnterColor;
	} else if ($(".chk_add:checked").length > 1) {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.plsSelectColor;
	} else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(desc)) {
		document.getElementById('addmenuitemsalertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		var manusplItemeditPost = {};
		var menucategory = {};
		menucategory.id = subcatId;
		manusplItemeditPost.id = id;
		manusplItemeditPost.menucategory = menucategory;
		manusplItemeditPost.name = name;
		manusplItemeditPost.description = desc;
		manusplItemeditPost.bgColor = bgColor1;
		manusplItemeditPost.production = 'Y';

		$
				.ajax({
					url : BASE_URL + "/menumgnt/editsplnote.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(manusplItemeditPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucateditModal();
						if (response == 'success') {
							document
									.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertmenuitemdataopModal();
						} else {
							document
									.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertmenuitemdataopModal();
						}
					}
				});

		
	}
	
}





















function enablePromoFields() {
	document.getElementById('modaddmenuitemsPromoDesc').disabled = '';
	document.getElementById('modaddmenuitemsPromoValue').disabled = '';
	document.getElementById('modeditmenuitemsPromoDesc').disabled = '';
	document.getElementById('modeditmenuitemsPromoValue').disabled = '';
}
function disablePromoFields() {
	document.getElementById('modaddmenuitemsPromoDesc').disabled = 'true';
	document.getElementById('modaddmenuitemsPromoValue').disabled = 'true';
	document.getElementById('modeditmenuitemsPromoDesc').disabled = 'true';
	document.getElementById('modeditmenuitemsPromoValue').disabled = 'true';
}
function cancelMenuItems(){
	document.getElementById('editmenuitemsalertMsg').innerHTML = '';
}
function editMenuItems() {
	// alert('edit');
	document.getElementById('editmenuitemsalertMsg').innerHTML = '';
	var catId = document.getElementById('modeditmenusubcategoryId').value;
	var id = document.getElementById('modeditmenuitemsId').value;
	/*var name = decodeURIComponent(document
			.getElementById('modeditmenuitemsName').value);
	var desc = decodeURIComponent(document
			.getElementById('modeditmenuitemsDesc').value);*/
	var name = document.getElementById('modeditmenuitemsName').value;
	var desc = document.getElementById('modeditmenuitemsDesc').value;
	var price = document.getElementById('modeditmenuitemsPrice').value;
	var vat = document.getElementById('modeditmenuitemsVat').value;
	var stax = document.getElementById('modeditmenuitemsStax').value;
	var typeoption = document.getElementsByName('modeditmenuitemsType');
	var spicyoption = document.getElementsByName('modeditmenuitemsSpicy');
	var promooption = document.getElementsByName('modeditmenuitemsPromo');
	var promodesc = document.getElementById('modeditmenuitemsPromoDesc').value;
	var promovalue = document.getElementById('modeditmenuitemsPromoValue').value;
	var cookingtime = document.getElementById('modeditmenuitemsCookingTime').value;
	var production = document.getElementById('modeditmenuitemsProductionId').value;
	var unit = document.getElementById('modeditmenuitemsUnit').value;
	var spotDisc = document.getElementById('modeditmenuitemsspotDiscId').value;
	var iskotprintval=document.getElementById('modeditmenuitemsKotPrint').value;
	promodesc = promodesc == '' ? null : promodesc;
	promovalue = promovalue == '' ? 0 : promovalue;
	var type = null;
	var spicy = null;
	var promo = null;
	for ( var i = 0; i < typeoption.length; i++) {
		if (typeoption[i].checked == true) {
			type = typeoption[i].value;
		}
	}
	for ( var i = 0; i < spicyoption.length; i++) {
		if (spicyoption[i].checked == true) {
			spicy = spicyoption[i].value;
		}
	}
	for ( var i = 0; i < promooption.length; i++) {
		if (promooption[i].checked == true) {
			promo = promooption[i].value;
		}
	}
	// alert(catId+':'+name+':'+desc+':'+price+':'+vat+':'+stax+':'+type+':'+spicy+':'+promo+':'+promodesc+':'+promovalue);
	if (name == '') {
		document.getElementById('editmenuitemsalertMsg').innerHTML = getLang.plsEnterName;
	} else if (desc == '') {
		document.getElementById('editmenuitemsalertMsg').innerHTML = getLang.plsEnterDesc;
	} /*else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(desc)) {
		document.getElementById('editmenuitemsalertMsg').innerHTML = getLang.charNotAlowd;
	}*/ else if (isNaN(price) || price == '') {
		document.getElementById('editmenuitemsalertMsg').innerHTML = getLang.plsEnterPrice;
	} else if (isNaN(vat) || vat == '') {
		document.getElementById('editmenuitemsalertMsg').innerHTML = getLang.plsEnterVat;
	} else if (isNaN(stax) || stax == '') {
		document.getElementById('editmenuitemsalertMsg').innerHTML = getLang.plsEnterstax;
	} else if (isNaN(cookingtime) || cookingtime == '') {
		document.getElementById('editmenuitemsalertMsg').innerHTML = getLang.plsEntersCookTime;
	} else {
		var maneItemeditPost = {};
		var menucategory = {};
		menucategory.id = catId;
		maneItemeditPost.id = id;
		maneItemeditPost.menucategory = menucategory;
		maneItemeditPost.name = name;
		maneItemeditPost.description = desc;
		maneItemeditPost.price = price;
		maneItemeditPost.vat = vat;
		maneItemeditPost.serviceTax = stax;
		maneItemeditPost.veg = type;
		maneItemeditPost.spicy = spicy;
		maneItemeditPost.promotionFlag = promo;
		maneItemeditPost.promotionDesc = promodesc;
		maneItemeditPost.promotionValue = promovalue;
		maneItemeditPost.cookingtime = cookingtime;
		maneItemeditPost.unit = unit;
		maneItemeditPost.spotDiscount = spotDisc;
		maneItemeditPost.production = production;
		maneItemeditPost.isKotPrint= iskotprintval;
		maneItemeditPost.purchasePrice=0.0;

		$
				.ajax({
					url : BASE_URL + "/menumgnt/editmenuitems.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(maneItemeditPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucateditModal();
						if (response == 'success') {
							document
									.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertmenuitemdataopModal();
						} else {
							document
									.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertmenuitemdataopModal();
						}
					}
				});

		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/menumgnt/editmenuitems/" + catId
		 * +"/"+ id+"/" + name +"/"+desc +"/"+price +"/"+vat +"/"+stax +"/"+type
		 * +"/"+spicy +"/"+promo +"/"+promodesc +"/"+promovalue+
		 * "/"+cookingtime+"/"+production+"/"+unit+"/"+spotDisc+".htm",
		 * function(response) { closenmenuitemseditModal();
		 * if(response==success) {
		 * document.getElementById('menuitemdataopmassagecont').innerHTML=getLang.datasucUpdate;
		 * showalertmenuitemdataopModal(); } else{
		 * document.getElementById('menuitemdataopmassagecont').innerHTML=getLang.datasucNotUpdate;
		 * showalertmenuitemdataopModal(); }
		 * //location.href=BASE_URL+'/menumgnt/loadmenuitems.htm'; }, null);
		 */
	}
}

// TODO: to be worked
/*
 * function editSplNote() { //alert('edit');
 * document.getElementById('editmenuitemsalertMsg').innerHTML=''; var
 * id=$(".chk:checked").val(); //var id =
 * document.getElementsByName('specialnote').value; var
 * catId=document.getElementById('modeditmenusubcategoryId').value; //var
 * id=document.getElementById('modeditmenuitemsId').value; var
 * name=decodeURIComponent(document.getElementById('modeditmenuitemsName').value);
 * //var name=document.getElementById('modeditmenuitemsName').value; var
 * desc=decodeURIComponent(document.getElementById('modeditmenuitemsDesc').value);
 * var bgColor=$(".clk:checked").val(); //var
 * price=document.getElementById('modeditmenuitemsPrice').value; //var
 * vat=document.getElementById('modeditmenuitemsVat').value; ///var
 * stax=document.getElementById('modeditmenuitemsStax').value; //var
 * typeoption=document.getElementsByName('modeditmenuitemsType'); //var
 * spicyoption=document.getElementsByName('modeditmenuitemsSpicy'); //var
 * promooption=document.getElementsByName('modeditmenuitemsPromo'); //var
 * promodesc=document.getElementById('modeditmenuitemsPromoDesc').value; //var
 * promovalue=document.getElementById('modeditmenuitemsPromoValue').value; //var
 * cookingtime=document.getElementById('modeditmenuitemsCookingTime').value;
 * //var
 * production=document.getElementById('modeditmenuitemsProductionId').value;
 * //var unit=document.getElementById('modeditmenuitemsUnit').value; //var
 * spotDisc=document.getElementById('modeditmenuitemsspotDiscId').value;
 * //promodesc=promodesc==''?null:promodesc;
 * //promovalue=promovalue==''?0:promovalue; //var type=null; //var spicy=null;
 * //var promo=null; //for(var i = 0; i < typeoption.length; i++)
 * {if(typeoption[i].checked == true) {type = typeoption[i].value;}} ////for(var
 * i = 0; i < spicyoption.length; i++) {if(spicyoption[i].checked == true)
 * {spicy = spicyoption[i].value;}} //for(var i = 0; i < promooption.length;
 * i++) {if(promooption[i].checked == true) {promo = promooption[i].value;}}
 * //alert(catId+':'+name+':'+desc+':'+price+':'+vat+':'+stax+':'+type+':'+spicy+':'+promo+':'+promodesc+':'+promovalue);
 * //var bgColor=$(".chk_add:checked").val(); var bgColor1="#"+ bgColor;
 * if(name=='') {
 * document.getElementById('editmenuitemsalertMsg').innerHTML=getLang.plsEnterName; }
 * else if(desc=='') {
 * document.getElementById('editmenuitemsalertMsg').innerHTML=getLang.plsEnterDesc; }
 * else if((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(desc)) {
 * document.getElementById('editmenuitemsalertMsg').innerHTML=getLang.charNotAlowd; }
 * else if(bgColor== undefined) {
 * document.getElementById('editmenuitemsalertMsg').innerHTML=getLang.plsEnterColor; }
 * else{ var manesplItemeditPost={}; //var menucategory={};
 * //menucategory.id=catId; manesplItemeditPost.id=id;
 * //manesplItemeditPost.menucategory=menucategory;
 * manesplItemeditPost.name=name; manesplItemeditPost.description=desc;
 * manesplItemeditPost.bgColor=bgColor1; //manesplItemeditPost.vat=vat;
 * //manesplItemeditPost.serviceTax=stax; //manesplItemeditPost.veg=type;
 * //manesplItemeditPost.spicy=spicy; //manesplItemeditPost.promotionFlag
 * =promo; //manesplItemeditPost.promotionDesc=promodesc;
 * //manesplItemeditPost.promotionValue =promovalue;
 * //manesplItemeditPost.cookingtime =cookingtime; //manesplItemeditPost.unit
 * =unit; //manesplItemeditPost.spotDiscount=spotDisc;
 * //manesplItemeditPost.production=production;
 * 
 * $.ajax({ url: BASE_URL + "/menumgnt/editsplnote.htm", type : 'POST',
 * contentType : 'application/json;charset=utf-8', data :
 * JSON.stringify(manesplItemeditPost), success :
 * function(response,JSON_UNESCAPED_UNICODE){ console.log(response);
 * //closenmenucateditModal(); if(response=='success') {
 * document.getElementById('menuitemdataopmassagecont').innerHTML='Data is
 * sucessfully edited!'; showalertmenuitemdataopModal(); } else{
 * document.getElementById('menuitemdataopmassagecont').innerHTML='Data is not
 * edited.Please try again!'; showalertmenuitemdataopModal(); } } }); var
 * ajaxCallObject = new CustomBrowserXMLObject();
 * ajaxCallObject.callAjax(BASE_URL + "/menumgnt/editsplnote/" + id+"/" + name
 * +"/"+desc +"/"+bgColor+".htm", function(response) {
 * closenmenuitemseditModal(); if(response==success) {
 * document.getElementById('menuitemdataopmassagecont').innerHTML=getLang.datasucUpdate;
 * showalertmenuitemdataopModal(); } else{
 * document.getElementById('menuitemdataopmassagecont').innerHTML=getLang.datasucNotUpdate;
 * showalertmenuitemdataopModal(); }
 * //location.href=BASE_URL+'/menumgnt/loadmenuitems.htm'; }, null); } }
 */
function deleteMenuItems() {
	var subcatId = document.getElementById('deletemodmenuitemssubcatId').value;
	var id = document.getElementById('deletemodmenuitemsId').value;

	var maneItemDeletePost = {};
	var menuSubcategory = {};
	menuSubcategory.id = subcatId;
	maneItemDeletePost.menucategory = menuSubcategory;
	maneItemDeletePost.id = id;
	$
			.ajax({
				url : BASE_URL + "/menumgnt/deletemenuitems.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(maneItemDeletePost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					// closenmenucateditModal();
					if (response == 'success') {
						document.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucDelete;
						showalertmenuitemdataopModal();
					} else {
						document.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucNotDelete;
						showalertmenuitemdataopModal();
					}
				}
			});
	/*
	 * var ajaxCallObject = new CustomBrowserXMLObject();
	 * ajaxCallObject.callAjax(BASE_URL +
	 * "/menumgnt/deletemenuitems/"+subcatId+"/"+id+ ".htm", function(response) {
	 * if(response==success) {
	 * document.getElementById('menuitemdataopmassagecont').innerHTML=getLang.datasucDelete;
	 * showalertmenuitemdataopModal(); } else{
	 * document.getElementById('menuitemdataopmassagecont').innerHTML=getLang.datasucNotDelete;
	 * showalertmenuitemdataopModal(); }
	 * //location.href=BASE_URL+'/menumgnt/loadmenuitems.htm'; }, null);
	 */

}
function deleteSplNote() {
	if ($(".chk:checked").length == 1) {
		var id = $(".chk:checked").val();
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
				.callAjax(
						BASE_URL + "/menumgnt/deleteSplNote/" + id + ".htm",
						function(response) {
							if (response == 'success') {
								document
										.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucDelete;
								showalertmenuitemdataopModal();
							} else {
								document
										.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucNotDelete;
								showalertmenuitemdataopModal();
							}
							// location.href=BASE_URL+'/menumgnt/loadmenuitems.htm';
						}, null);
	} else {
		document.getElementById('menuitemdataopmassagecont').innerHTML = getLang.plsSelectColorOneTime;
		showalertmenuitemdataopModal();
	}

}
function disableMenuItems(catid, catname, subcatid, subcatname, id, name, desc,
		rate, vat, stax, type, spicy, promo, promodesc, promovalue, production) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/menumgnt/editmenuitems/" + catId + "/"
			+ id + "/" + name + "/" + desc + "/" + price + "/" + vat + "/"
			+ stax + "/" + type + "/" + spicy + "/" + promo + "/" + promodesc
			+ "/" + promovalue + "/" + production + ".htm", function() {
		location.href = BASE_URL + '/menumgnt/loadmenuitems.htm';
	}, null);
}
function enableMenuItems(catid, catname, subcatid, subcatname, id, name, desc,
		rate, vat, stax, type, spicy, promo, promodesc, promovalue, production) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/menumgnt/editmenuitems/" + catId + "/"
			+ id + "/" + name + "/" + desc + "/" + price + "/" + vat + "/"
			+ stax + "/" + type + "/" + spicy + "/" + promo + "/" + promodesc
			+ "/" + promovalue + "/" + production + ".htm", function() {
		location.href = BASE_URL + '/menumgnt/loadmenuitems.htm';
	}, null);
}
/* end menu items management */
/* start table management */
/*
 * function loadTableMgntPage() { loadtablemgntPage(BASE_URL +
 * "/tablemgnt/loadtablemgnt.htm",document.getElementById('menumgntContainerId')); }
 * function loadtablemgntPage(url,containerId) { var ajaxCallObject = new
 * CustomBrowserXMLObject(); ajaxCallObject.callAjax(url, function(response) {
 * containerId.innerHTML = response; }, null); }
 */
function addTable() {
	document.getElementById('addtablealertMsg').innerHTML = '';
	var tableno = decodeURIComponent(document
			.getElementById('addtablenoContId').value);
	var seatingcapacity = document.getElementById('addseatingcapContId').value;
	var desc = decodeURIComponent(document.getElementById('addtabledescContId').value);
	if (tableno == '' || seatingcapacity == '' || desc == '') {
		document.getElementById('addtablealertMsg').innerHTML = getLang.fieldsReq;
	} else if ((/[#%?\/\\]/gi).test(tableno) || (/[#%?\/\\]/gi).test(desc)) {
		document.getElementById('addtablealertMsg').innerHTML = getLang.charNotAlowd;
	} else if (!parseInt(seatingcapacity)) {
		document.getElementById('addtablealertMsg').innerHTML = getLang.enterSitCapNo;
	} else {

		var tablePost = {};
		tablePost.tableNo = tableno;
		tablePost.seatingCapacity = seatingcapacity;
		tablePost.tableDescription = desc;
		tablePost.storeId = storeID;
		$
				.ajax({
					url : BASE_URL + "/tablemgnt/addtable.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(tablePost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'alreadyexist') {
							document.getElementById('addtablenoContId').value = '';
							document.getElementById('addseatingcapContId').value = '';
							document.getElementById('addtabledescContId').value = '';
							document.getElementById('addtablealertMsg').innerHTML = getLang.tableNoExist;
						} else {
							closetableaddModal();
							if (response == 'Table Created Successfully.') {
								document
										.getElementById('tabledataopmassagecont').innerHTML = getLang.datasucAdd;
								showalerttabledataopModal();
							} else {
								document
										.getElementById('tabledataopmassagecont').innerHTML = getLang.datasucNotAdd;
								showalerttabledataopModal();
							}
							// location.href=BASE_URL+'/tablemgnt/loadtablemgnt.htm';
						}
					}
				});
		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/tablemgnt/addtable/" + tableno +
		 * "/" + seatingcapacity+"/"+desc + ".htm", function(response) {
		 * if(response=='alreadyexist') {
		 * document.getElementById('addtablenoContId').value='';
		 * document.getElementById('addseatingcapContId').value='';
		 * document.getElementById('addtabledescContId').value='';
		 * document.getElementById('addtablealertMsg').innerHTML='Table No
		 * already exist!'getLang.tableNoExist; } else{ closetableaddModal();
		 * if(response=='Table Created Successfully.') {
		 * document.getElementById('tabledataopmassagecont').innerHTML='Data is
		 * sucessfully added!'getLang.datasucAdd; showalerttabledataopModal(); }
		 * else{
		 * document.getElementById('tabledataopmassagecont').innerHTML='Data is
		 * not added.Please try again!'getLang.datasucNotAdd;
		 * showalerttabledataopModal(); }
		 * //location.href=BASE_URL+'/tablemgnt/loadtablemgnt.htm'; } }, null);
		 */
	}
}
function cancelTable(){
	document.getElementById('edittablealertMsg').innerHTML = '';
}
function editTable() {
	document.getElementById('edittablealertMsg').innerHTML = '';
	var tableid = document.getElementById('edittableidContId').value;
	var tableno = decodeURIComponent(document
			.getElementById('edittablenoContId').value);
	var seatingcapacity = document.getElementById('editseatingcapContId').value;
	var desc = decodeURIComponent(document
			.getElementById('edittabledescContId').value);
	var multiorder = 'N';

	if (ismultiOrder == 'Y') {
		multiorder = document.getElementById('edittablemultiorderContId').value;
	}
	// alert(tableid+':'+tableno+':'+seatingcapacity+':'+desc+':'+multiorder+':'+ismultiOrder);
	if (tableno == '' || seatingcapacity == '' || desc == '') {
		document.getElementById('edittablealertMsg').innerHTML = getLang.fieldsReq;
	} else if ((/[#%?\/\\]/gi).test(tableno) || (/[#%?\/\\]/gi).test(desc)) {
		document.getElementById('edittablealertMsg').innerHTML = getLang.charNotAlowd;
	} else if (!parseInt(seatingcapacity)) {
		document.getElementById('edittablealertMsg').innerHTML = getLang.enterSitCapNo;
	} else {

		var tablePost = {};
		tablePost.id = tableid;
		tablePost.tableNo = tableno;
		tablePost.seatingCapacity = seatingcapacity;
		tablePost.tableDescription = desc;
		tablePost.storeId = storeID;
		tablePost.multiOrder = multiorder;
		$
				.ajax({
					url : BASE_URL + "/tablemgnt/edittable.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(tablePost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'alreadyexist') {
							document.getElementById('edittablealertMsg').innerHTML = getLang.tableNoExist;
						} else {
							closetableaddModal();
							if (response == 'Table Updated Successfully.') {
								document
										.getElementById('tabledataopmassagecont').innerHTML = getLang.datasucUpdate;
								showalerttabledataopModal();
							} else {
								document
										.getElementById('tabledataopmassagecont').innerHTML = getLang.datasucNotUpdate;
								showalerttabledataopModal();
							}
							// location.href=BASE_URL+'/tablemgnt/loadtablemgnt.htm';
						}
					}
				});
		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/tablemgnt/edittable/"
		 * +tableid+"/"+ tableno + "/" + seatingcapacity+"/"+desc +
		 * "/"+multiorder+".htm", function(response) {
		 * if(response=='alreadyexist') {
		 * document.getElementById('edittablealertMsg').innerHTML=getLang.tableNoExist; }
		 * else{ closetableeditModal(); if(response=='Table Updated
		 * Successfully.') {
		 * document.getElementById('tabledataopmassagecont').innerHTML=getLang.datasucUpdate;
		 * showalerttabledataopModal(); } else{
		 * document.getElementById('tabledataopmassagecont').innerHTML=getLang.datasucNotUpdate;
		 * showalerttabledataopModal(); }
		 * //location.href=BASE_URL+'/tablemgnt/loadtablemgnt.htm'; } }, null);
		 */
	}
}
function deleteTable() {
	var tableid = document.getElementById('moddeleteconfirmcatidTableId').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/tablemgnt/deletetable/" + tableid + ".htm",
					function(response) {
						if (response == 'success') {
							document.getElementById('tabledataopmassagecont').innerHTML = getLang.datasucDelete;
							showalerttabledataopModal();
						} else {
							document.getElementById('tabledataopmassagecont').innerHTML = getLang.datasucNotDelete;
							showalerttabledataopModal();
						}
						// location.href=BASE_URL+'/tablemgnt/loadtablemgnt.htm';
					}, null);

}
/* end table management */
/* start inventory type management */
function addInventoryType() {
	document.getElementById('addinvtypealertMsg').innerHTML = '';
	var invtypeName = decodeURIComponent(document
			.getElementById('addinvtypenameContId').value);
	var invtypeDesc = decodeURIComponent(document
			.getElementById('addinvtypedescContId').value);
	// alert(invtypeName+':'+invtypeDesc);
	if (invtypeName == '' || invtypeDesc == '') {
		document.getElementById('addinvtypealertMsg').innerHTML = getLang.bothFldReq;
	} else if ((/[#%?\/\\]/gi).test(invtypeName)
			|| (/[#%?\/\\]/gi).test(invtypeDesc)) {
		document.getElementById('addinvtypealertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		var invTypeaddPost = {};
		invTypeaddPost.name = invtypeName;
		invTypeaddPost.description = invtypeDesc;
		invTypeaddPost.storeId = storeID;
		invTypeaddPost.createdBy = user;
		$
				.ajax({
					url : BASE_URL + "/inventorymgnt/addinvtype.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(invTypeaddPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucateditModal();
						if (response != '0') {
							document.getElementById('invtypedataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertinvtypedataopModal();
						} else {
							document.getElementById('invtypedataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertinvtypedataopModal();
						}
					}
				});

		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/inventorymgnt/addinvtype/" +
		 * invtypeName + "/" + invtypeDesc + ".htm", function(response) {
		 * closeinvtypeaddModal(); if(response!='0') {
		 * document.getElementById('invtypedataopmassagecont').innerHTML=getLang.datasucAdd;
		 * showalertinvtypedataopModal(); } else{
		 * document.getElementById('invtypedataopmassagecont').innerHTML=getLang.datasucNotAdd;
		 * showalertinvtypedataopModal(); }
		 * //location.href=BASE_URL+'/inventorymgnt/loadinvtypemgnt.htm'; },
		 * null);
		 */
	}
}
function cancelInventoryType(){
	document.getElementById('editinvtypealertMsg').innerHTML = '';
}
function editInventoryType() {
	document.getElementById('editinvtypealertMsg').innerHTML = '';
	var id = document.getElementById('editinvtypeidContId').value;
	var invtypeName = decodeURIComponent(document
			.getElementById('editinvtypenameContId').value);
	var invtypeDesc = decodeURIComponent(document
			.getElementById('editinvtypedescContId').value);
	// alert(invtypeName+':'+invtypeDesc);
	if (invtypeName == '' || invtypeDesc == '') {
		document.getElementById('editinvtypealertMsg').innerHTML = getLang.bothFldReq;
	} else if ((/[#%?\/\\]/gi).test(invtypeName)
			|| (/[#%?\/\\]/gi).test(invtypeDesc)) {
		document.getElementById('editinvtypealertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		var invTypeaddPost = {};
		invTypeaddPost.id = id;
		invTypeaddPost.name = invtypeName;
		invTypeaddPost.description = invtypeDesc;
		invTypeaddPost.storeId = storeID;
		invTypeaddPost.createdBy = user;
		$
				.ajax({
					url : BASE_URL + "/inventorymgnt/editinvtype.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(invTypeaddPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucateditModal();
						if (response == 'success') {
							document.getElementById('invtypedataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertinvtypedataopModal();
						} else {
							document.getElementById('invtypedataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertinvtypedataopModal();
						}
					}
				});

	}
}
function deleteInventoryType() {
	var id = document.getElementById('moddeleteconfirminvtypeidContId').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/inventorymgnt/deleteinvtype/" + id + ".htm",
					function(response) {
						if (response == 'success') {
							document.getElementById('invtypedataopmassagecont').innerHTML = getLang.datasucDelete;
							showalertinvtypedataopModal();
						} else {
							document.getElementById('invtypedataopmassagecont').innerHTML = getLang.datasucNotDelete;
							showalertinvtypedataopModal();
						}
						// location.href=BASE_URL+'/inventorymgnt/loadinvtypemgnt.htm';
					}, null);
}
/* end inventory type management */
/* start inventory item management */
function addInventoryItem() {
	document.getElementById('addinvitemalertMsg').innerHTML = '';
	var name = decodeURIComponent(document.getElementById('addinvitemnameContId').value);
	var code = decodeURIComponent(document.getElementById('addinvitemcodeContId').value);
	var itemtype = document.getElementById('addinvitemTypeId').value;
	var qty = document.getElementById('addinvitemqtyContId').value;
	var rate = document.getElementById('addinvitemrateContId').value;
	var unit = document.getElementById('addinvitemunitContId').value;
	var unitName = $("#addinvitemunitContId").find("option:selected").text(); 
	var vendorid = document.getElementById('addinvitemvendorTypeId').value;
	var shipping = document.getElementById('addinvitemshippingContId').value;
	var dailyreq = document.getElementById('addinvitemdailyreqContId').value;
	var tax = document.getElementById('addtax').value;
	var taxpercentage = document.getElementById('addinvitemtaxpercentage').value; // add new
	var istaxexclusive = document.getElementById('addinvitemttaxexclusive').value; // add new
	var simpleinvitem = document.getElementById('addcallsimpleinventory').value;
	var isstockable = document.getElementById('addinvitemstockable').value; // add new
	// desc=desc==''?null:desc;
	// rating=rating==''?0:rating;
	// contact=contact==''?0:contact;
	// address=rating==''?null:address;
	if (name == '') {
		document.getElementById('addinvitemalertMsg').innerHTML = getLang.reqName;
	} else if (code == '') {
		document.getElementById('addinvitemalertMsg').innerHTML = getLang.reqCode;
	} else if (isNaN(rate) || rate == '') {
		document.getElementById('addinvitemalertMsg').innerHTML = getLang.enterCorctRate;
	} else if (isNaN(shipping)) {
		document.getElementById('addinvitemalertMsg').innerHTML = getLang.enterCorctShipCharg;
	} else if (isNaN(dailyreq)) {
		document.getElementById('addinvitemalertMsg').innerHTML = getLang.enterCorctDailyReq;
	} else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(code)
			|| (/[#%?\/\\]/gi).test(unit)) {
		document.getElementById('addinvitemalertMsg').innerHTML = getLang.charNotAlowd;
	} else if (tax == 'Y' && taxpercentage== '') { //new added
		document.getElementById('addinvitemalertMsg').innerHTML = getLang.reqTaxRate;
	}else if (tax == "SELECT") { //new added
		document.getElementById('addinvitemalertMsg').innerHTML = getLang.enterCorctTax;//added new getLang.enterCorctTax in admin lang
	}
	
	
	else {

		var invItemPost = {};
		var InvType = {};
		InvType.id = itemtype;
		invItemPost.inventoryType = InvType;
		invItemPost.name = name;
		invItemPost.quantity = qty;
		invItemPost.rate = rate;
		invItemPost.metricUnitId = unit;
		invItemPost.vendorId = vendorid;
		invItemPost.shippingCharge = shipping;
		invItemPost.dailyRequirement = dailyreq;
		invItemPost.tax = tax;
		invItemPost.code = code;
		invItemPost.taxRate = taxpercentage; // add new
		invItemPost.isTaxExclusive = istaxexclusive; // add new
		invItemPost.isStockable = isstockable;// add new
		invItemPost.unit = unitName;
		
		$
				.ajax({
					url : BASE_URL + "/inventorymgnt/addinvitem.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(invItemPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						if (simpleinvitem == 1) {
							if (response != '0') {
								document
										.getElementById('simpleinvitemdataopmassagecont').innerHTML = getLang.datasucAdd;
								showalertsimpleinvitemdataopModal();
							} else {
								document
										.getElementById('simpleinvitemdataopmassagecont').innerHTML = getLang.datasucNotAdd;
								showalertsimpleinvitemdataopModal();
							}
							// location.href=BASE_URL+'/inventorymgnt/loadsimpleinvitemmgnt.htm';
						} else {
							if (response != '0') {
								document
										.getElementById('invitemdataopmassagecont').innerHTML = getLang.datasucAdd;
								showalertinvitemdataopModal();
							} else {
								document
										.getElementById('invitemdataopmassagecont').innerHTML = getLang.datasucNotAdd;
								showalertinvitemdataopModal();
							}
							// location.href=BASE_URL+'/inventorymgnt/loadinvitemmgnt.htm';
						}
					}

				});
	}
}
function cancelInventoryItem(){
	document.getElementById('editinvitemalertMsg').innerHTML = '';
}
function editInventoryItem() {
	
	document.getElementById('editinvitemalertMsg').innerHTML = '';
	var id = document.getElementById('editinvitemidContId').value;
	var name = decodeURIComponent(document
			.getElementById('editinvitemnameContId').value);
	var code = decodeURIComponent(document
			.getElementById('editinvitemcodeContId').value);
	var itemtype = document.getElementById('editinvitemTypeId').value;
	var qty = document.getElementById('editinvitemqtyContId').value;
	var rate = document.getElementById('editinvitemrateContId').value;
	var unit = document.getElementById('editinvitemunitContId').value;
	var vendorid = document.getElementById('editinvitemvendorTypeId').value;
	var shipping = document.getElementById('editinvitemshippingContId').value;
	var dailyreq = document.getElementById('editinvitemdailyreqContId').value;
	var tax = document.getElementById('edittax').value;
	var taxrate = document.getElementById('editinvitemtaxpercentage').value; // added new
	var istaxexclusive = document.getElementById('editinvitemttaxexclusive').value; // added new
	var simpleinvitem = document.getElementById('editcallsimpleinventory').value;
	var isstockable = document.getElementById('editinvitemstockable').value; // added new
	var unitName = $("#editinvitemunitContId").find("option:selected").text();
	// desc=desc==''?null:desc;
	// rating=rating==''?0:rating;
	// contact=contact==''?0:contact;
	// address=rating==''?null:address;
	
	if(taxrate == ''){ // added new
		taxrate = "0.0";
	}

	if (name == '') {
		document.getElementById('editinvitemalertMsg').innerHTML = getLang.reqName;
	} else if (code == '') {
		document.getElementById('editinvitemalertMsg').innerHTML = getLang.reqCode;
	} else if (isNaN(rate) || rate == '') {
		document.getElementById('editinvitemalertMsg').innerHTML = getLang.enterCorctRate;
	} else if (isNaN(shipping)) {
		document.getElementById('editinvitemalertMsg').innerHTML = getLang.enterCorctShipCharg;
	} else if (isNaN(dailyreq)) {
		document.getElementById('editinvitemalertMsg').innerHTML = getLang.enterCorctDailyReq;
	} else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(code)
			|| (/[#%?\/\\]/gi).test(unit)) {
		document.getElementById('editinvitemalertMsg').innerHTML = getLang.charNotAlowd;
	}else if (tax == "SELECT") {//added new
		document.getElementById('editinvitemalertMsg').innerHTML = getLang.enterCorctTax;//added new getLang.enterCorctTax in admin lang
	}  
	
	else {

		var invItemPost = {};
		var InvType = {};
		InvType.id = itemtype;
		invItemPost.id = id;
		invItemPost.inventoryType = InvType;
		invItemPost.name = name;
		invItemPost.quantity = qty;
		invItemPost.rate = rate;
		invItemPost.metricUnitId = unit;
		invItemPost.vendorId = vendorid;
		invItemPost.shippingCharge = shipping;
		invItemPost.dailyRequirement = dailyreq;
		invItemPost.tax = tax;
		invItemPost.code = code;
		invItemPost.taxRate = taxrate; // add new
		invItemPost.isTaxExclusive = istaxexclusive; // add new
		invItemPost.isStockable = isstockable; // add new
		invItemPost.unit=unitName;
		
		$
				.ajax({
					url : BASE_URL + "/inventorymgnt/editinvitem.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(invItemPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {

						/*
						 * var ajaxCallObject = new CustomBrowserXMLObject();
						 * ajaxCallObject .callAjax( BASE_URL +
						 * "/inventorymgnt/editinvitem/" + id + "/" + name + "/" +
						 * code + "/" + itemtype + "/" + qty + "/" + rate + "/" +
						 * unit + "/" + vendorid + "/" + shipping + "/" +
						 * dailyreq + "/" + tax + ".htm", function(response)
						 */
						closeinvitemeditModal();
						if (simpleinvitem == 1) {
							if (response == 'Successfully Updated.') {
								document
										.getElementById('simpleinvitemdataopmassagecont').innerHTML = getLang.datasucUpdate;
								showalertsimpleinvitemdataopModal();
							} else {
								document
										.getElementById('simpleinvitemdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
								showalertsimpleinvitemdataopModal();
							}
							// location.href=BASE_URL+'/inventorymgnt/loadsimpleinvitemmgnt.htm';
						} else {
							if (response == 'Successfully Updated.') {
								document
										.getElementById('simpleinvitemdataopmassagecont').innerHTML = getLang.datasucUpdate;
								showalertsimpleinvitemdataopModal();
							} else {
								document
										.getElementById('simpleinvitemdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
								showalertsimpleinvitemdataopModal();
							}
							// location.href=BASE_URL+'/inventorymgnt/loadinvitemmgnt.htm';
						}
					}
				});
	}
}
function deleteInventoryItem() {
	var simpleinvitem = document.getElementById('deletecallsimpleinventory').value;
	var id = document.getElementById('moddeleteconfirminvitemContId').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/inventorymgnt/deleteinvitem/" + id + ".htm",
					function(response) {
						if (simpleinvitem == 1) {
							if (response == 'success') {
								document
										.getElementById('simpleinvitemdataopmassagecont').innerHTML = getLang.datasucDelete;
								showalertsimpleinvitemdataopModal();
							} else {
								document
										.getElementById('simpleinvitemdataopmassagecont').innerHTML = getLang.datasucNotDelete;
								showalertsimpleinvitemdataopModal();
							}
							// location.href=BASE_URL+'/inventorymgnt/loadsimpleinvitemmgnt.htm';
						} else {
							if (response == 'success') {
								document
										.getElementById('simpleinvitemdataopmassagecont').innerHTML = getLang.datasucDelete;
								showalertsimpleinvitemdataopModal();
							} else {
								document
										.getElementById('simpleinvitemdataopmassagecont').innerHTML = getLang.datasucNotDelete;
								showalertsimpleinvitemdataopModal();
							}
							// location.href=BASE_URL+'/inventorymgnt/loadinvitemmgnt.htm';
						}
					}, null);
}
function loadinvItems(invitemid, simpleinvitem) {
	// alert(invitemid);
	if (invitemid.length == 0) {
		showalertnoInvItemFoundModal();
	} else {
		if (simpleinvitem == 1) {
			location.href = BASE_URL
					+ '/inventorymgnt/loadsimpleinvitemsbyid.htm?invitemid='
					+ invitemid;
		} else {
			location.href = BASE_URL
					+ '/inventorymgnt/loadinvitemsbyid.htm?invitemid='
					+ invitemid;
		}

	}
	// loadmenuItems(BASE_URL +
	// "/menumgnt/loadmenuitemsbyid.htm?itemid="+itemid,document.getElementById('menumgntContainerId'));
}
/* end inventory item management */
/* start vendor management */
function addVendor() {
	document.getElementById('addvendoralertMsg').innerHTML = '';
	var name = decodeURIComponent(document
			.getElementById('addvendornameContId').value);
	var code = decodeURIComponent(document
			.getElementById('addvendorcodeContId').value);
	var desc = decodeURIComponent(document
			.getElementById('addvendordescContId').value);
	var rating = document.getElementById('addvendorratingContId').value;
	var contact = document.getElementById('addvendorcontactContId').value;
	var address = decodeURIComponent(document
			.getElementById('addvendoraddressContId').value);
	var type = document.getElementById('vendorTypeId').value;
	var accountno = document.getElementById('addvendoraccountnoContId').value;
	var creditlimit = document.getElementById('addvendorcreditlimitContId').value;
     if(creditlimit == ''){creditlimit=0.0;}
	// desc=desc==''?null:desc;
	// rating=rating==''?0:rating;
	// contact=contact==''?0:contact;
	// address=rating==''?null:address;

	if (name == '') {
		document.getElementById('addvendoralertMsg').innerHTML = getLang.reqName;
	} else if (code == '') {
		document.getElementById('addvendoralertMsg').innerHTML = getLang.reqCode;
	} else if (desc == '') {
		document.getElementById('addvendoralertMsg').innerHTML = getLang.reqDesc;
	} else if (address == '') {
		document.getElementById('addvendoralertMsg').innerHTML = getLang.reqAddr;
	} else if (rating == '' || isNaN(rating)) {
		document.getElementById('addvendoralertMsg').innerHTML = getLang.plsEnterCorctRate;
	} else if (contact == '' || isNaN(contact)) {
		document.getElementById('addvendoralertMsg').innerHTML = getLang.plsEnterCorctCtNo;
	} else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(code)
			|| (/[#%?\/\\]/gi).test(desc) || (/[#%?\/\\]/gi).test(address)) {
		document.getElementById('addvendoralertMsg').innerHTML = getLang.charNotAlowd;
	} else {

		var vendorPost = {};
		vendorPost.name = name;
		vendorPost.code = code;
		vendorPost.description = desc;
		vendorPost.rating = rating;
		vendorPost.contactNo = contact;
		vendorPost.address = address;
		vendorPost.type = type;
		vendorPost.storeId = storeID;
		vendorPost.createdBy = user;
		vendorPost.accountNumber=accountno;
		vendorPost.creditLimit = creditlimit;
		$
				.ajax({
					url : BASE_URL + "/vendormgnt/addvendor.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(vendorPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucateditModal();
						if (response != '0') {
							document.getElementById('vendordataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertvendordataopModal();
						} else {
							document.getElementById('vendordataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertvendordataopModal();
						}
					}
				});
		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/vendormgnt/addvendor/" + name +
		 * "/" + code +"/"+desc +"/"+rating +"/"+contact +"/"+address +"/"+
		 * type+".htm", function(response) { closevendoraddModal();
		 * if(response!='0') {
		 * document.getElementById('vendordataopmassagecont').innerHTML=getLang.datasucAdd;
		 * showalertvendordataopModal(); } else{
		 * document.getElementById('vendordataopmassagecont').innerHTML=getLang.datasucNotAdd;
		 * showalertvendordataopModal(); }
		 * //location.href=BASE_URL+'/vendormgnt/loadvendormgnt.htm'; }, null);
		 */
	}
}
function cancelVendor(){
	document.getElementById('editvendoralertMsg').innerHTML = '';
}
function editVendor() {
	document.getElementById('editvendoralertMsg').innerHTML = '';
	var id = document.getElementById('editvendoridContId').value;
	var name = decodeURIComponent(document
			.getElementById('editvendornameContId').value);
	var code = decodeURIComponent(document
			.getElementById('editvendorcodeContId').value);
	var desc = decodeURIComponent(document
			.getElementById('editvendordescContId').value);
	var rating = document.getElementById('editvendorratingContId').value;
	var contact = document.getElementById('editvendorcontactContId').value;
	var address = decodeURIComponent(document
			.getElementById('editvendoraddressContId').value);
	var type = document.getElementById('editvendorTypeId').value;
	var crby = document.getElementById('editvendorcreatedbyContId').value;
	var accountno = document.getElementById('editvendoraccountnoContId').value;
	var creditlimit = document.getElementById('editvendorcreditlimitContId').value;
	if(creditlimit == ''){creditlimit=0.0;}
	// var
	// createdDate=document.getElementById('editvendorcreateddateContId').value;
	// desc=desc==''?null:desc;
	// rating=rating==''?0:rating;
	// contact=contact==''?0:contact;
	// address=rating==''?null:address;
	// alert(id+':'+name+':'+code+':'+desc+':'+rating+':'+contact+':'+address+':'+type+':'+crby+':'+crdate);
	if (name == '') {
		document.getElementById('editvendoralertMsg').innerHTML = getLang.reqName;
	} else if (code == '') {
		document.getElementById('editvendoralertMsg').innerHTML = getLang.reqCode;
	} else if (desc == '') {
		document.getElementById('editvendoralertMsg').innerHTML = getLang.reqDesc;
	} else if (address == '') {
		document.getElementById('editvendoralertMsg').innerHTML = getLang.reqAddr;
	} else if (rating == '' || isNaN(rating)) {
		document.getElementById('editvendoralertMsg').innerHTML = getLang.plsEnterCorctRate;
	} else if (contact == '' || isNaN(contact)) {
		document.getElementById('editvendoralertMsg').innerHTML = getLang.plsEnterCorctCtNo;
	} else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(code)
			|| (/[#%?\/\\]/gi).test(desc) || (/[#%?\/\\]/gi).test(address)) {
		document.getElementById('editvendoralertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		var vendorPost = {};
		vendorPost.id = id;
		vendorPost.name = name;
		vendorPost.code = code;
		vendorPost.description = desc;
		vendorPost.rating = rating;
		vendorPost.contactNo = contact;
		vendorPost.address = address;
		vendorPost.type = type;
		vendorPost.storeId = storeID;
		vendorPost.updatedBy = user;
		vendorPost.createdBy = crby;
		vendorPost.deleteFlag = "N";
		vendorPost.accountNumber=accountno;
		vendorPost.creditLimit=creditlimit;
		$
				.ajax({
					url : BASE_URL + "/vendormgnt/editvendor.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(vendorPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucateditModal();
						if (response == 'success') {
							document.getElementById('vendordataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertvendordataopModal();
						} else {
							document.getElementById('vendordataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertvendordataopModal();
						}
					}
				});
		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/vendormgnt/editvendor/"+id +"/"+
		 * name + "/" + code +"/"+desc +"/"+rating +"/"+contact +"/"+address
		 * +"/"+ type+"/"+ crby +".htm", function(response) {
		 * closevendoreditModal(); if(response=='success') {
		 * document.getElementById('vendordataopmassagecont').innerHTML=getLang.datasucUpdate;
		 * showalertvendordataopModal(); } else{
		 * document.getElementById('vendordataopmassagecont').innerHTML=getLang.datasucNotUpdate;
		 * showalertvendordataopModal(); }
		 * //location.href=BASE_URL+'/vendormgnt/loadvendormgnt.htm'; }, null);
		 */
	}
}
function deleteVendor() {
	var id = document.getElementById('moddeleteconfirmvendoridContId').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/vendormgnt/deletevendor/" + id + ".htm",
					function(response) {
						if (response == 'success') {
							document.getElementById('vendordataopmassagecont').innerHTML = getLang.datasucDelete;
							showalertvendordataopModal();
						} else {
							document.getElementById('vendordataopmassagecont').innerHTML = getLang.datasucNotDelete;
							showalertvendordataopModal();
						}
						// location.href=BASE_URL+'/vendormgnt/loadvendormgnt.htm';
					}, null);
}
/* end vendor management */
/* start storecustomer management */

function addStoreCustomer() {

	var storecustname = decodeURIComponent(document
			.getElementById('addstorecustnameContId').value);
	var storecustcontact = decodeURIComponent(document
			.getElementById('addstorecustcontactContId').value);
	var storecustaddress = decodeURIComponent(document
			.getElementById('addstorecustaddressContId').value);
	var storecustemail = decodeURIComponent(document
			.getElementById('addstorecustemailContId').value);
	var storecustcrlimit = document.getElementById('addstorecustcrlimitContId').value;
	var storecustlocation = document.getElementById('addstorelcustlocation').value;
	 var storecusthouseno = document.getElementById('addstorecusthouseno').value;
	 var storecuststreet = document.getElementById('addstorecuststreet').value;
	 var storecustdob = document.getElementById('addstorecustdob').value;
	 var storecustanniversary = document.getElementById('addstorecustanniversarydate').value;
	 var storecustgstno=$("#addstorecustgstno").val();

	// alert(storecustname+':'+storecustcontact+':'+storecustaddress+':'+storecustemail+':'+storecustcrlimit);
	if (storecustname == '' || storecustcontact == '') {
		document.getElementById('addstorecustalertMsg').innerHTML = getLang.bothFldReq;
	} else if ((/[#%?\/\\]/gi).test(storecustname)
			|| (/[#%?\/\\]/gi).test(storecustaddress)) {
		document.getElementById('addstorecustalertMsg').innerHTML = getLang.charNotAlowd;
	} else if (isNaN(storecustcontact)) {
		document.getElementById('addstorecustalertMsg').innerHTML = getLang.entrValidCntctNo;
	}
	/*
	 * else if(storecustcrlimit!='') { if(isNaN(storecustcrlimit)) {
	 * document.getElementById('addstorecustalertMsg').innerHTML='Enter a valid
	 * no!'; } }
	 * 
	 * else if(storecustemail!='') {
	 * if(!(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/).test(storecustemail)) {
	 * document.getElementById('addstorecustalertMsg').innerHTML='Enter a valid
	 * email!'; } }
	 */
	else {
		storecustaddress = storecustaddress == "" ? null : storecustaddress;
		storecustcrlimit = storecustcrlimit == "" ? 0 : storecustcrlimit;
		storecustemail = storecustemail == "" ? null : storecustemail;
		// alert(storecustname+':'+storecustcontact+':'+storecustaddress+':'+storecustemail+':'+storecustcrlimit);
		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * 
		 * 
		 * ajaxCallObject.callAjax(BASE_URL +
		 * "/storecustomermgnt/addstorecustomer/" + storecustname + "/" +
		 * storecustcontact + "/" + storecustaddress + "/" + storecustemail +
		 * "/" + storecustcrlimit + ".htm", function() {
		 * closestorecustaddModal(); location.href = BASE_URL +
		 * '/storecustomermgnt/loadstorecustomermgnt.htm'; }, null);
		 */

		var addStoreCustomer = {};
		addStoreCustomer.name = storecustname;
		addStoreCustomer.contactNo = storecustcontact;
		addStoreCustomer.emailId = storecustemail;
		addStoreCustomer.address = storecustaddress;
		addStoreCustomer.creditLimit = storecustcrlimit;
		addStoreCustomer.location=storecustlocation;
		addStoreCustomer.house_no=storecusthouseno;
		addStoreCustomer.street=storecuststreet;
		addStoreCustomer.dob=storecustdob;
		addStoreCustomer.cust_vat_reg_no=storecustgstno;
		addStoreCustomer.anniversary=storecustanniversary;  
		  
		$
				.ajax({

					url : BASE_URL + "/storecustomermgnt/addstorecustomer.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(addStoreCustomer),
					success : function(response, JSON_UNESCAPED_UNICODE) {

						// console.log(">>>>>> "+response);
						// closenmenucateditModal();
						if (response == 'success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertcatdataopModal();
							closestorecustaddModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotAdd;

						}
					}

				});

	}
}

function cancelStoreCustomer(){
	document.getElementById('editstorecustalertMsg').innerHTML = '';
}
function editStoreCustomer() {
	var storecustid = document.getElementById('editstorecustidContId').value;

	 var storecustname = decodeURIComponent(document
	   .getElementById('editstorecustnameContId').value);
	 var storecustcontact = decodeURIComponent(document
	   .getElementById('editstorecustcontactContId').value);
	 var storecustaddress = decodeURIComponent(document
	   .getElementById('editstorecustaddressContId').value);
	 var storecustlocation=decodeURIComponent(document
	     .getElementById('editstorelcustlocation').value);
	 var storecusthouseno=decodeURIComponent(document
	     .getElementById('editstorecusthouseno').value);
	 var storecuststreet=decodeURIComponent(document
	     .getElementById('editstorecuststreet').value);
	var storecustdob=decodeURIComponent(document
	     .getElementById('editstorecustdob').value);
	 var storecustanniversary=decodeURIComponent(document
	     .getElementById('editstorecustanniversarydate').value);
	 var storecustemail = decodeURIComponent(document
	   .getElementById('editstorecustemailContId').value);
	 var storecustcrlimit = document
	   .getElementById('editstorecustcrlimitContId').value;
	 var storecustcrflag = document
	   .getElementById('editstorecustcreditflagContId').value;
	 var storecustgstno=$("#editstorecustgstno").val();
	 // alert(storecustid+':'+storecustcrflag);
	 // alert(storecustid+':'+storecustname+':'+storecustcontact+':'+storecustaddress+':'+storecustemail+':'+storecustcrlimit+':'+storecustcrflag);
	 if (storecustname == '' || storecustcontact == '') {
	  document.getElementById('editstorecustalertMsg').innerHTML = "Both fields are required!";
	 } else if ((/[#%?\/\\]/gi).test(storecustname)
	   || (/[#%?\/\\]/gi).test(storecustaddress)) {
	  document.getElementById('editstorecustalertMsg').innerHTML = "Please enter correct contact number!";
	 } else if (isNaN(storecustcontact)) {
	  document.getElementById('editstorecustalertMsg').innerHTML = "#,%,?,/,\  characters are not allowed!";
	 }
	 /*
	  * else if(isNaN(storecustcrlimit)) {
	  * document.getElementById('editstorecustalertMsg').innerHTML='Enter a valid
	  * no!'; } else if(storecustemail!='') {
	  * if(!(/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/).test(storecustemail)) {
	  * document.getElementById('editstorecustalertMsg').innerHTML='Enter a valid
	  * email!'; } }
	  */
	 else {
	  storecustaddress = storecustaddress == "" ? null : storecustaddress;
	  storecustcrlimit = storecustcrlimit == "" ? 0 : storecustcrlimit;
	  storecustemail = storecustemail == "" ? null : storecustemail;
	  // alert(storecustid+':'+storecustname+':'+storecustcontact+':'+storecustaddress+':'+storecustemail+':'+storecustcrlimit+':'+storecustcrflag);

	  /*
	   * var ajaxCallObject = new CustomBrowserXMLObject();
	   * ajaxCallObject.callAjax(BASE_URL +
	   * "/storecustomermgnt/editstorecustomer/" + storecustid + "/" +
	   * storecustname + "/" + storecustcontact + "/" + storecustaddress + "/" +
	   * storecustemail + "/" + storecustcrlimit + "/" + storecustcrflag +
	   * ".htm", function() { closestorecusteditModal(); location.href =
	   * BASE_URL + '/storecustomermgnt/loadstorecustomermgnt.htm'; }, null);
	   */

	  var editStoreCust = {};
	  editStoreCust.id = storecustid;
	  editStoreCust.name = storecustname;
	  editStoreCust.contactNo = storecustcontact;
	  editStoreCust.address = storecustaddress;
	  editStoreCust.location = storecustlocation;
	  editStoreCust.house_no = storecusthouseno;
	  editStoreCust.street = storecuststreet;
	  editStoreCust.dob = storecustdob;
	  editStoreCust.cust_vat_reg_no=storecustgstno;
	  editStoreCust.anniversary = storecustanniversary;

	  editStoreCust.emailId = storecustemail;
	  editStoreCust.creditLimit = storecustcrlimit;
	  editStoreCust.creditCustomer = storecustcrflag;

		
				$.ajax({
					url : BASE_URL + "/storecustomermgnt/editstorecustomer.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(editStoreCust),
					success : function(response, JSON_UNESCAPED_UNICODE) {

						console.log(">>>>>> " + response);
						// closenmenucateditModal();
						if (response == 'success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertcatdataopModal();
						}
					}

				})
	}
}
function deleteStoreCustomer() {
	var id = document.getElementById('moddeleteconfirmstorecustidContId').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL
			+ "/storecustomermgnt/deletestorecustomer/" + id + ".htm",
			function(res) {
		         //alert(res);
		         if(res == "inuse"){
		        	 document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotDelete;
		        	 $('#alertcatdataopModal').modal('show');
		         }
		         else{
		        	 document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucDelete;
		        	 $('#alertcatdataopModal').modal('show');
				// loadTableMgntPage();
				/*location.href = BASE_URL
						+ '/storecustomermgnt/loadstorecustomermgnt.htm';*/
		         }
			}, null);
}
/* end storecustomer management */
/* start special note management */
function clickonmenuItems(itemid, itemname) {
	// alert(itemname);
	/*loadSplNotes(BASE_URL + "/menumgnt/loadspecialnotes.htm?itemid=" + itemid
			+ "&itemname=" + decodeURIComponent(itemname) + "", document
			.getElementById('specialnoteContainerId'));*/
	loadSplNotes(BASE_URL + "/menumgnt/loadspecialnotes.htm?itemid=" + itemid
			+ "&itemname=" + itemname + "", document
			.getElementById('specialnoteContainerId'));
}

function loadSplNotes(url, containerId) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(url, function(response) {
		//console.log(response);
		containerId.innerHTML = response;
		// alert('hi');
		showspecialNoteModal();
	}, null);
}
/*
 * var selectedspnoteRows = [];
 * 
 * function checkSpNote(noteid,chk) { if(chk.checked) {
 * selectedspnoteRows.push(noteid); } else{
 * selectedspnoteRows.splice(selectedspnoteRows.indexOf(noteid), 1); } }
 */
function addspecialNote() {
	var selectedspnoteRows = [];
	var itemid = document.getElementById("itemidforspnote").value;
	var checkboxes = document.getElementsByName('spnote');
	for ( var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			selectedspnoteRows.push(checkboxes[i].value);
		}
	}

	if (selectedspnoteRows.length > 0) {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/menumgnt/addspecialnote/" + itemid
				+ "/" + selectedspnoteRows + ".htm", function(response) {
			if (response == 'success') {
				closespecialNoteModal();
			}
		}, null);
	}
}
/* end specila note managemnt */
/* start credit sale */
function getcreditOrderBycustId(id, name, contact) {
	// alert(id+':'+name+':'+contact);
	$("#creditordertableContId").addClass('hide');
	$("#waitimage").removeClass('hide');
	getcustomerledger_pur('SDE',0,id,2)// for customer
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/creditsale/getcreditorderbycustid/"
			+ id + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			prepareCreditOrderHtml(responseObj);
		} catch (e) {
			alert(e);
		}

	}, null);
	document.getElementById('creditcustnameContId').innerHTML = name;
	document.getElementById('creditcustcontactContId').innerHTML = contact;
	document.getElementById('creditcustidContId').value = id;
}

function prepareCreditOrderHtml(responseData) {
	//alert("3394");
	$("#waitimage").addClass('hide');
	$("#creditordertableContId").removeClass('hide');
	
	var creditordercontainerId = document
			.getElementById('creditordertableContId');
	var starttable = "<table class='table table-striped table-bordered table-hover'>"
			+ "<thead style='background:#404040; color:#FFF;'><th style='text-align:center;'>"
			+ getLang.orderNo
			+ "</th><th style='text-align:center;'>"
			+ getLang.date
			+ "</th><th style='text-align:center;'>"
			+ getLang.billAmt
			+ "</th><th style='text-align:center;'>"
			+ getLang.paidAmt
			+ "</th><th style='text-align:center;'>"
			+ getLang.dueAmt
			+ "</th><th style='text-align:center;'>"
			+ getLang.pay + "</th>" + "</thead>";
	"<tbody style='color:#fff;'>";
	var endtable = "</tbody></table>";
	var createdrowline = "";
	var generatedHtml = "";
	var totBillAmt = 0.0;
	var totDiscAmt = 0.0;
	var totPaidAmt = 0.0;
	if (responseData.length > 0) {
		for ( var i = 0; i < responseData.length; i++) {

			var creditOrder = responseData[i];
			var begintr = "<tr style='background:#404040; color:#FFF;'>";
			var firsttd = "<td align='center'>" + creditOrder.id + "</td>";
			var secondtd = "<td align='center'>"
					+ (creditOrder.orderTime).substring(0, 10);
			+"</td>";
			var thirdtd = "<td align='center'>"
					+ parseFloat(creditOrder.orderBill.grossAmt).toFixed(2)
					+ "</td>";
			var thirdtd1 = "<td align='center'>"
					+ parseFloat(creditOrder.orderBill.customerDiscount)
							.toFixed(2) + "</td>";
			var fourthtd = "<td align='center'>"
					+ parseFloat(creditOrder.paidAmt).toFixed(2) + "</td>";
			var fifthtd = "<td align='center'>"
					+ parseFloat(
							creditOrder.orderBill.grossAmt
									- creditOrder.paidAmt).toFixed(2) + "</td>";
			var sixthtd = "<td align='center'><a href='javascript:opencr_saleCashModal("
					+ creditOrder.id
					+ ",&quot;"
					+ creditOrder.table_no
					+ "&quot;,"
					+ creditOrder.orderBill.grossAmt
					+ ","
					+ creditOrder.paidAmt					
					+ ")' class='btn btn-success'>"
					+ getLang.cash
					+ "</a>&nbsp;<a href='javascript:opencr_saleCardModal("
					+ creditOrder.id
					+ ",&quot;"
					+ creditOrder.table_no
					+ "&quot;,"
					+ creditOrder.orderBill.grossAmt
					+ ","
					+ creditOrder.paidAmt
					+ ")' class='btn btn-success'>"
					+ getLang.card + "</a></td>";
			var endtr = "</tr>";
			createdrowline += begintr + firsttd + secondtd + thirdtd + fourthtd
					+ fifthtd + sixthtd + endtr;
			totBillAmt += creditOrder.orderBill.grossAmt;
			totDiscAmt += creditOrder.orderBill.customerDiscount;
			totPaidAmt += creditOrder.paidAmt;
		}
		if (responseData.length > 1) {
			var begintottr = "<tr style='background:#e2e2e2; color:#222222;'>";
			var totaltd = "<td colspan='2' align='center'>" + getLang.total
					+ "</td>";
			var totalbilltd = "<td align='center'>"
					+ parseFloat(totBillAmt).toFixed(2) + "</td>";
			var totaldisctd = "<td align='center'>"
					+ parseFloat(totDiscAmt).toFixed(2) + "</td>";
			var totalpaidtd = "<td align='center'>"
					+ parseFloat(totPaidAmt).toFixed(2) + "</td>";
			var totalduetd = "<td align='center'>"
					+ parseFloat(totBillAmt - totPaidAmt).toFixed(2) + "</td>";
			var totalpaytd = "<td align='center'><a href='javascript:opentotcr_saleCashModal("
					+ totBillAmt
					+ ","
					+ totPaidAmt
					+ ")' class='btn btn-success'>"
					+ getLang.cash
					+ "</a>&nbsp;<a href='javascript:opentotcr_saleCardModal("
					+ totBillAmt
					+ ","
					+ totPaidAmt
					+ ")' class='btn btn-success'>"
					+ getLang.card
					+ "</a></td>";
			var endtottr = "</tr>";
			createdrowline += begintottr + totaltd + totalbilltd + totalpaidtd
					+ totalduetd + totalpaytd + endtottr;
		}
	} else {
		var begintr = "<tr style='background:#404040; color:#FFF;'>";
		var firsttd = "<td colspan='6'>" + getLang.nDf + "</td>";
		var endtr = "</tr>";
		createdrowline += begintr + firsttd + endtr;
	}
	generatedHtml = starttable + createdrowline + endtable;
	creditordercontainerId.innerHTML = generatedHtml;

}
function opencr_saleCashModal(orderno, tableno, billAmt, paidAmt) {
	//alert("3508 line"); 
	document.getElementById('cr_salecashtenderAmt').value = '';
	document.getElementById('cr_salepaycashalertMsg').innerHTML = '';
	document.getElementById('cr_salecashmodOrderCont').innerHTML = orderno;
	document.getElementById('cr_salecashmodTabCont').innerHTML = tableno;
	document.getElementById('cr_salecashtotamtcontId').innerHTML = parseFloat(
			billAmt).toFixed(2);
	// document.getElementById('cr_salecashdiscamtcontId').innerHTML=parseFloat(discAmt).toFixed(2);
	document.getElementById('cr_salecashpaidamtcontId').innerHTML = parseFloat(
			paidAmt).toFixed(2);
	document.getElementById('cr_salecashamttopaycontId').innerHTML = parseFloat(
			billAmt - paidAmt).toFixed(2);
	showcr_saleCashModal();
}
function getcr_saleChangeAmt(tenderAmt) {
	var amntToPay = document.getElementById('cr_salecashamttopaycontId').innerHTML;
	// alert(tenderAmt+':'+amntToPay);
	if (tenderAmt == '') {
		document.getElementById('cr_salecashchangeamtcontId').innerHTML = '0.00';
	} else if (parseFloat(amntToPay) >= parseFloat(tenderAmt)) {
		document.getElementById('cr_salecashchangeamtcontId').innerHTML = '0.00';
	} else {
		document.getElementById('cr_salecashchangeamtcontId').innerHTML = parseFloat(
				parseFloat(tenderAmt) - parseFloat(amntToPay)).toFixed(2);
	}
}
function opencr_saleCardModal(orderno, tableno, billAmt, paidAmt) {
	document.getElementById('cr_salepaycardalertMsg').innerHTML = '';
	document.getElementById('cr_salecardlastfourDigit').value = '';
	document.getElementById('cr_salecardmodOrderCont').innerHTML = orderno;
	document.getElementById('cr_salecardmodTabCont').innerHTML = tableno;
	document.getElementById('cr_salecardtotamtcontId').innerHTML = parseFloat(
			billAmt).toFixed(2);
	// document.getElementById('cr_salecarddiscamtcontId').innerHTML=parseFloat(discAmt).toFixed(2);
	document.getElementById('cr_salecardpaidamtcontId').innerHTML = parseFloat(
			paidAmt).toFixed(2);
	document.getElementById('cr_salecardamttopaycontId').innerHTML = parseFloat(
			billAmt - paidAmt).toFixed(2);
	document.getElementById('cr_salecardtenderAmt').value = parseFloat(
			billAmt - paidAmt).toFixed(2);
	showcr_saleCardModal();
}
/*function cr_salepayByCash(tenderAmt) {
//	alert('hi');
	var custid = document.getElementById('creditcustidContId').value;
	var orderno = document.getElementById('cr_salecashmodOrderCont').innerHTML;
	var billAmt = document.getElementById('cr_salecashtotamtcontId').innerHTML;
	// var
	// discAmt=document.getElementById('cr_salecashdiscamtcontId').innerHTML;
	var paidAmnt = document.getElementById('cr_salecashpaidamtcontId').innerHTML;
	var amntToPay = document.getElementById('cr_salecashamttopaycontId').innerHTML;
	if (!parseFloat(tenderAmt)) {
		// alert('Please enter a valid number!');
		document.getElementById('cr_salepaycashalertMsg').innerHTML = getLang.plsEntrVldNo;
		document.getElementById('cr_salecashtenderAmt').focus();
	} else {
		if (parseFloat(tenderAmt) >= parseFloat(amntToPay)) {
			paidAmnt = parseFloat(amntToPay);
			amntToPay = 0.0;
		} else {
			paidAmnt = parseFloat(tenderAmt);
			amntToPay = (parseFloat(amntToPay) - parseFloat(tenderAmt))
					.toFixed(2);
		}
		
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/" + orderno +
		 * "/" + billAmt + "/" + paidAmnt + "/" + amntToPay + "/" + tenderAmt +
		 * "/" + "cash" + "/" + "0000" + ".htm", function( response) { try {
		 * alert("response is >> "+response); if (response == 'success') { var
		 * ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL +
		 * "/creditsale/getcreditorderbycustid/" + custid + ".htm",
		 * function(response) { try { var responseObj = JSON.parse(response);
		 * prepareCreditOrderHtml(responseObj); } catch (e) { alert(e); } },
		 * null); hidecr_saleCashModal(); } } catch (e) { alert(e); } }, null);
		 

		var paymentAdmin = {};
		var order = {};

		order.id = orderno;
		paymentAdmin.amount = billAmt;
		paymentAdmin.paidAmount = paidAmnt;
		paymentAdmin.amountToPay = amntToPay;
		paymentAdmin.tenderAmount = tenderAmt;
		paymentAdmin.paymentMode = "cash";
		paymentAdmin.cardLastFourDigits = "0000";
		paymentAdmin.orderPayment = order;

		$.ajax({
			url : BASE_URL + '/order/orderpaymentFromAdmin.htm',
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(paymentAdmin),
			success : function(response, JSON_UNESCAPED_UNICODE) {

				if (response == 'success') {
					
					hidecr_saleCashModal();
					showalertOrderPaidModal();
				}
			}
		});

	}
}*/
/*function cr_salepayByCard(tenderAmt) {
	//alert('hi');
	var custid = document.getElementById('creditcustidContId').value;
	var orderno = document.getElementById('cr_salecardmodOrderCont').innerHTML;
	var billAmt = document.getElementById('cr_salecardtotamtcontId').innerHTML;
	// var
	// discAmt=document.getElementById('cr_salecarddiscamtcontId').innerHTML;
	var paidAmnt = document.getElementById('cr_salecardpaidamtcontId').innerHTML;
	var amntToPay = document.getElementById('cr_salecardamttopaycontId').innerHTML;
	var lastfourdigit = document.getElementById('cr_salecardlastfourDigit').value;
	if(isNaN(lastfourdigit)) {
		lastfourdigit =  'xxxx';
	}
	if (!parseFloat(tenderAmt)) {
		// alert('Please enter a valid number!');
		document.getElementById('cr_salepaycardalertMsg').innerHTML = getLang.plsEntrVldNo;
		document.getElementById('cr_salecardtenderAmt').focus();
	} else if (!parseFloat(lastfourdigit)) {
		// alert('Please enter a valid card number!');
		document.getElementById('cr_salepaycardalertMsg').innerHTML = getLang.plsEntrVldCardNo;
		document.getElementById('cr_salecardlastfourDigit').focus();
	} else if (lastfourdigit.length != 4) {
		// alert('Please enter 4 digit valid card number!');
		document.getElementById('cr_salepaycardalertMsg').innerHTML = getLang.plsEntr4DgtNo;
		document.getElementById('cr_salecardlastfourDigit').focus();
	} else {
		if (parseFloat(tenderAmt).toFixed(2) >= parseFloat(amntToPay)
				.toFixed(2)) {
			paidAmnt = parseFloat(amntToPay).toFixed(2);
			amntToPay = 0.0;
		} else {
			paidAmnt = parseFloat(tenderAmt).toFixed(2);
			amntToPay = parseFloat(amntToPay).toFixed(2)
					- parseFloat(tenderAmt).toFixed(2);
		}
		
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/" + orderno +
		 * "/" + billAmt + "/" + paidAmnt + "/" + amntToPay + "/" + tenderAmt +
		 * "/" + "card" + "/" + lastfourdigit + ".htm", function(response) { try {
		 * if (response == 'success') { var ajaxCallObject = new
		 * CustomBrowserXMLObject(); ajaxCallObject.callAjax(BASE_URL +
		 * "/creditsale/getcreditorderbycustid/" + custid + ".htm",
		 * function(response) { try { var responseObj = JSON.parse(response);
		 * prepareCreditOrderHtml(responseObj); } catch (e) { alert(e); } },
		 * null); hidecr_saleCardModal(); } } catch (e) { alert(e); } }, null);
		 

		var paymentAdminCard = {};
		var orderCardAdmin = {};

		orderCardAdmin.id = orderno;

		paymentAdminCard.amount = billAmt;
		paymentAdminCard.paidAmount = paidAmnt;
		paymentAdminCard.amountToPay = amntToPay;
		paymentAdminCard.tenderAmount = tenderAmt;
		paymentAdminCard.paymentMode = "card";
		paymentAdminCard.cardLastFourDigits = lastfourdigit;
		paymentAdminCard.orderPayment = orderCardAdmin;

		$.ajax({
			url : BASE_URL + '/order/orderpaymentFromAdmin.htm',
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(paymentAdminCard),
			success : function(response, JSON_UNESCAPED_UNICODE) {

				try {
					if (response == 'success') {
						
						hidecr_saleCardModal();
						showalertOrderPaidModal();
					}
				} catch (e) {
					alert(e);
				}

			}
		});

	}
}
*/
function creditPaymentDone() {
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL
			+ "/creditsale/getcreditorderbycustid/"
			+ custid + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			prepareCreditOrderHtml(responseObj);
		} catch (e) {
			alert(e);
		}

	}, null);
}

function opentotcr_saleCashModal(billAmt, paidAmt) {
	document.getElementById('totcr_salecashtenderAmt').value = '';
	document.getElementById('totcr_salepaycashalertMsg').innerHTML = '';

	document.getElementById('totcr_salecashtotamtcontId').innerHTML = parseFloat(
			billAmt).toFixed(2);
	document.getElementById('totcr_salecashpaidamtcontId').innerHTML = parseFloat(
			paidAmt).toFixed(2);
	document.getElementById('totcr_salecashamttopaycontId').innerHTML = parseFloat(
			billAmt - paidAmt).toFixed(2);
	showtotcr_saleCashModal();
}
function gettotcr_saleChangeAmt(tenderAmt) {
	var amntToPay = document.getElementById('totcr_salecashamttopaycontId').innerHTML;
	// alert(tenderAmt+':'+amntToPay);
	if (tenderAmt == '') {
		document.getElementById('totcr_salecashchangeamtcontId').innerHTML = '0.00';
	} else if (parseFloat(amntToPay) >= parseFloat(tenderAmt)) {
		document.getElementById('totcr_salecashchangeamtcontId').innerHTML = '0.00';
	} else {
		document.getElementById('totcr_salecashchangeamtcontId').innerHTML = parseFloat(
				parseFloat(tenderAmt) - parseFloat(amntToPay)).toFixed(2);
	}
}
function opentotcr_saleCardModal(billAmt, paidAmt) {
	document.getElementById('totcr_salepaycardalertMsg').innerHTML = '';
	document.getElementById('totcr_salecardlastfourDigit').value = '';
	document.getElementById('totcr_salecardtotamtcontId').innerHTML = parseFloat(
			billAmt).toFixed(2);
	document.getElementById('totcr_salecardpaidamtcontId').innerHTML = parseFloat(
			paidAmt).toFixed(2);
	document.getElementById('totcr_salecardamttopaycontId').innerHTML = parseFloat(
			billAmt - paidAmt).toFixed(2);
	document.getElementById('totcr_salecardtenderAmt').value = parseFloat(
			billAmt - paidAmt).toFixed(2);
	showtotcr_saleCardModal();
}

/*function totcr_salepayByCash(tenderAmt) {
 * alert(total pay by cash);
	var custid = document.getElementById('creditcustidContId').value;

	// var
	// billAmt=document.getElementById('totcr_salecashtotamtcontId').innerHTML;
	// var
	// paidAmnt=document.getElementById('totcr_salecashpaidamtcontId').innerHTML;
	// var
	// amntToPay=document.getElementById('totcr_salecashamttopaycontId').innerHTML;
	// alert(custid+':'+tenderAmt);
	if (!parseFloat(tenderAmt)) {
		// alert('Please enter a valid number!');
		document.getElementById('totcr_salepaycashalertMsg').innerHTML = getLang.plsEntrVldNo;
		document.getElementById('totcr_salecashtenderAmt').focus();
	} else {
		document.getElementById('totcashpaySpinner').style.display = "inline";
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/creditsale/paybulkcashbycustid/"
				+ custid + "/" + tenderAmt + ".htm", function(response) {
			try {
				var responseObj = JSON.parse(response);
				prepareCreditOrderHtml(responseObj);
				hidetotcr_saleCashModal();
			} catch (e) {
				alert(e);
			}

		}, null);

		
		 * var paymentString = {}; var orderString = {};
		 * 
		 * paymentString.tenderAmount = tenderAmt; orderString.customers =
		 * custid; paymentString.orderPayment = orderString;
		 * 
		 * $.ajax({
		 * 
		 * url : BASE_URL + '/creditsale/paybulkcashbycustid.htm', type :
		 * 'POST', contentType : 'application/json;charset=utf-8', data :
		 * JSON.stringify(paymentString), success : function(response,
		 * JSON_UNESCAPED_UNICODE){ try { var responseObj =
		 * JSON.parse(response); prepareCreditOrderHtml(responseObj);
		 * hidetotcr_saleCashModal(); } catch (e) { alert(e); }
		 *  } })
		 

	}
}
*/
/*function totcr_salepayByCard(tenderAmt) {
 * alert("total pay by card");
	var custid = document.getElementById('creditcustidContId').value;

	var lastfourdigit = document.getElementById('totcr_salecardlastfourDigit').value;
	if (!parseFloat(tenderAmt)) {
		// alert('Please enter a valid number!');
		document.getElementById('totcr_salepaycardalertMsg').innerHTML = getLang.plsEntrVldNo;
		document.getElementById('totcr_salecardtenderAmt').focus();
	} else if (!parseFloat(lastfourdigit)) {
		// alert('Please enter a valid card number!');
		document.getElementById('totcr_salepaycardalertMsg').innerHTML = getLang.plsEntrVldCardNo;
		document.getElementById('totcr_salecardlastfourDigit').focus();
	} else if (lastfourdigit.length != 4) {
		// alert('Please enter 4 digit valid card number!');
		document.getElementById('totcr_salepaycardalertMsg').innerHTML = getLang.plsEntr4DgtNo;
		document.getElementById('totcr_salecardlastfourDigit').focus();
	} else {
		// alert(custid+':'+tenderAmt);
		document.getElementById('totcardpaySpinner').style.display = "inline";
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/creditsale/paybulkcardbycustid/"
				+ custid + "/" + tenderAmt + "/" + lastfourdigit + ".htm",
				function(response) {
					try {
						var responseObj = JSON.parse(response);
						prepareCreditOrderHtml(responseObj);
						hidetotcr_saleCardModal();
					} catch (e) {
						alert(e);
					}

				}, null);
	}
}*/
/* end credit sale */
/* start kot printer setup */
function showCatKOTPrinterModal(id, name) {
	document.getElementById('modcatkotcatidTd').innerHTML = id;
	document.getElementById('modcatkotcatnameTd').innerHTML = name;
	document.getElementById('modcatkotprintername').value = "";
	document.getElementById('modcatkotkitchenname').value = name;
	document.getElementById('addcatkotalertMsg').innerHTML = "";
	var optionline = "";
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/menumgnt/getallinstalledprinters.htm",
					function(response) {
						try {
							var responseObj = [];
							responseObj = JSON.parse(response);
							for ( var i = 0; i < responseObj.length; i++) {
								optionline += "<option value='"
										+ responseObj[i].name + "'>"
										+ responseObj[i].name + "</option>";
							}
							document.getElementById('modcatkotprinterloc').innerHTML = optionline;
						} catch (e) {
							alert(e);
						}

					}, null);
	showmenucatkotaddModal();
}
function AddCatKOTPrinter() {
	var cuisineid = document.getElementById('modcatkotcatidTd').innerHTML;
	var printerloc = encodeURIComponent(document
			.getElementById('modcatkotprinterloc').value);
	var printername = document.getElementById('modcatkotprintername').value;
	var kitchenname = document.getElementById('modcatkotkitchenname').value;
	printername = printername == '' ? null : printername;
	kitchenname = kitchenname == '' ? null : kitchenname;
	//printerloc = printerloc.replace(/%5C/g, "|");
	  printerloc = printerloc.replace(/%20/g, " ");
	  //alert("printerloc:"+printerloc);
	// alert(cuisineid+':'+printerloc+':'+printername+':'+kitchenname);
	/*
	 * var ajaxCallObject = new CustomBrowserXMLObject(); ajaxCallObject
	 * .callAjax( BASE_URL + "/menumgnt/assignkotprinter/" + cuisineid + "/" +
	 * printerloc + "/" + printername + "/" + kitchenname + ".htm",
	 * function(response) { if (response == '0') {
	 * document.getElementById('addcatkotalertMsg').innerHTML =
	 * getLang.someErrOcor; } else { closemenucatkotaddModal(); } }, null);
	 */

	var printerString = {};
    printerString.cuisineTypeId = cuisineid;
	printerString.name = printername;
    printerString.kitchenLocation = printerloc;
    printerString.String = kitchenname;
    printerString.printerIp = printerloc;
	$
			.ajax({

				url : BASE_URL + "/menumgnt/assignkotprinter.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(printerString),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(">> " + response);
					closenmenucateditModal();

					if (response == 0) {
						document.getElementById('catdataopmassagecont').innerHTML = getLang.someErrOcor;
						showalertcatdataopModal();
					} else {
						document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
						showalertcatdataopModal();
					}
				}

			})

}
function showSubCatKOTPrinterModal(id, name) {
	// alert(id+':'+name);
	document.getElementById('modsubcatkotsubcatidTd').innerHTML = id;
	document.getElementById('modsubcatkotsubcatnameTd').innerHTML = name;
	document.getElementById('modsubcatkotprintername').value = "";
	document.getElementById('modsubcatkotkitchenname').value = name;
	document.getElementById('addsubcatkotalertMsg').innerHTML = "";
	var optionline = "";
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/menumgnt/getallinstalledprinters.htm",
					function(response) {
						try {
							var responseObj = [];
							responseObj = JSON.parse(response);
							for ( var i = 0; i < responseObj.length; i++) {
								optionline += "<option value='"
										+ responseObj[i].name + "'>"
										+ responseObj[i].name + "</option>";
							}
							document.getElementById('modsubcatkotprinterloc').innerHTML = optionline;
						} catch (e) {
							alert(e);
						}

					}, null);
	showmenusubcatkotaddModal();
}
function AddSubCatKOTPrinter() {
	var cuisineid = document.getElementById('modsubcatkotsubcatidTd').innerHTML;
	var printerloc = encodeURIComponent(document
			.getElementById('modsubcatkotprinterloc').value);
	//printerloc = printerloc.replace(/%5C/g, "|");
	printerloc = printerloc.replace(/%20/g, " ");
	var printername = document.getElementById('modsubcatkotprintername').value;
	var kitchenname = document.getElementById('modsubcatkotkitchenname').value;
	printername = printername == '' ? null : printername;
	kitchenname = kitchenname == '' ? null : kitchenname;
	// alert(cuisineid+':'+printerloc+':'+printername+':'+kitchenname);
	/*var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/menumgnt/assignkotprinter/" + cuisineid + "/"
							+ printerloc + "/" + printername + "/"
							+ kitchenname + ".htm",
					function(response) {
						if (response == '0') {
							document.getElementById('addsubcatkotalertMsg').innerHTML = getLang.someErrOcor;
						} else {
							closemenusubcatkotaddModal();
						}

					}, null);*/
	
	 var printerString = {};
	    printerString.cuisineTypeId = cuisineid;
		printerString.name = printername;
	    printerString.kitchenLocation = printerloc;
	    printerString.String = kitchenname;
	    printerString.printerIp = printerloc;
	    $
		.ajax({

			url : BASE_URL + "/menumgnt/assignkotprinter.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(printerString),
			success : function(response, JSON_UNESCAPED_UNICODE) {
				console.log(">> " + response);
				if (response == 0) {
					document.getElementById('addsubcatkotalertMsg').innerHTML = getLang.someErrOcor;
				} else {
					document.getElementById('addsubcatkotalertMsg').innerHTML = getLang.datasucAdd;
					closemenusubcatkotaddModal();
				}
			}

		})	
}
function showItemKOTPrinterModal(id, name) {
	// alert(id+':'+name+':'+printerlist);
	var printerlist = document.getElementById('hidprevprinterlist_' + id).value;
	// alert(id+':'+name+':'+printerlist);
	document.getElementById('moditemkotitemidTd').innerHTML = id;
	document.getElementById('moditemkotitemnameTd').innerHTML = name;
	document.getElementById('additemkotalertMsg').innerHTML = "";
	var prevprinter1 = 0;
	var prevprinter2 = 0;
	var prevprinter3 = 0;
	var prevprintername1 = "";
	var prevprintername2 = "";
	var prevprintername3 = "";
	if (printerlist.length > 0 || printerlist != '') {
		var res = printerlist.split('~');
		prevprinter1 = res[0];
		prevprinter2 = res[1];
		prevprinter3 = res[2];
	}
	var printer1optionline = "";
	var printer2optionline = "";
	var printer3optionline = "";
	var printerArr = [];
	var ajaxCallObject = new CustomBrowserXMLObject();

	ajaxCallObject
			.callAjax(
					BASE_URL + "/menumgnt/getallserverprinters.htm",
					function(response) {
						try {
							var responseObj = [];
							responseObj = JSON.parse(response);
							var printer = {};
							printer.id = 0;
							printer.name = getLang.noPrinter;
							printerArr.push(printer);
							optionline = "<option value='0'>getLang.noPrinter</option>";
							for ( var i = 0; i < responseObj.length; i++) {
								var printer = {};
								printer.id = responseObj[i].id;
								printer.name = responseObj[i].printerIp;
								printerArr.push(printer);
								if (prevprinter1 != 0) {
									if (prevprinter1 == responseObj[i].id) {
										prevprintername1 = responseObj[i].printerIp;
									}
								}
								if (prevprinter2 != 0) {
									if (prevprinter2 == responseObj[i].id) {
										prevprintername2 = responseObj[i].printerIp;
									}
								}
								if (prevprinter3 != 0) {
									if (prevprinter3 == responseObj[i].id) {
										prevprintername3 = responseObj[i].printerIp;
									}
								}
								/* >>>>>>> .r1049 */
							}
							if (prevprinter1 != 0) {
								printer1optionline += "<option value='"
										+ prevprinter1 + "'>"
										+ prevprintername1 + "</option>";
							}
							if (prevprinter2 != 0) {
								printer2optionline += "<option value='"
										+ prevprinter2 + "'>"
										+ prevprintername2 + "</option>";
							}
							if (prevprinter3 != 0) {
								printer3optionline += "<option value='"
										+ prevprinter3 + "'>"
										+ prevprintername3 + "</option>";
							}
							for ( var j = 0; j < printerArr.length; j++) {
								if (prevprinter1 != 0) {
									if (printerArr[j].id != prevprinter1) {
										printer1optionline += "<option value='"
												+ printerArr[j].id + "'>"
												+ printerArr[j].name
												+ "</option>";
									}
								} else {
									printer1optionline += "<option value='"
											+ printerArr[j].id + "'>"
											+ printerArr[j].name + "</option>";
								}
								if (prevprinter2 != 0) {
									if (printerArr[j].id != prevprinter2) {
										printer2optionline += "<option value='"
												+ printerArr[j].id + "'>"
												+ printerArr[j].name
												+ "</option>";
									}
								} else {
									printer2optionline += "<option value='"
											+ printerArr[j].id + "'>"
											+ printerArr[j].name + "</option>";
								}
								if (prevprinter3 != 0) {
									if (printerArr[j].id != prevprinter3) {
										printer3optionline += "<option value='"
												+ printerArr[j].id + "'>"
												+ printerArr[j].name
												+ "</option>";
									}
								} else {
									printer3optionline += "<option value='"
											+ printerArr[j].id + "'>"
											+ printerArr[j].name + "</option>";
								}
							}
							document.getElementById('moditemkotprinterloc1').innerHTML = printer1optionline;
							document.getElementById('moditemkotprinterloc2').innerHTML = printer2optionline;
							document.getElementById('moditemkotprinterloc3').innerHTML = printer3optionline;
						} catch (e) {
							alert(e);
						}

					}, null);
	showmenuitemkotaddModal();
}
function AddItemKOTPrinter() {

	var itemid = document.getElementById('moditemkotitemidTd').innerHTML;
	var printerlocid1 = document.getElementById('moditemkotprinterloc1').value;
	var printerlocid2 = document.getElementById('moditemkotprinterloc2').value;
	var printerlocid3 = document.getElementById('moditemkotprinterloc3').value;

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/menumgnt/assignkotprintertoitem/" + itemid
							+ "/" + printerlocid1 + "/" + printerlocid2 + "/"
							+ printerlocid3 + ".htm",
					function(response) {
						if (response == 'failure') {
							document.getElementById('additemkotalertMsg').innerHTML = getLang.someErrOcor;
						} else {
							var newprntlist = printerlocid1 + '~'
									+ printerlocid2 + '~' + printerlocid3;
							document.getElementById('hidprevprinterlist_'
									+ itemid).value = newprntlist;
							closemenuitemkotaddModal();
						}

					}, null);
}

/* end kot printer setup */


/* start service charge setup */

function enableserviceChargeTxt(chk, orderTypeId) {
	
	if (chk.checked == true)
		document.getElementById(orderTypeId).disabled = false;
	else
		document.getElementById(orderTypeId).disabled = true;
}


function updateserviceCharge() {
	
	var sChargeRows = [];
	var sChargeTxt = [];
	var sChargeAmt = [];

	var checkboxes = document.getElementsByName('serviceChargeChk');
	for ( var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			sChargeRows.push(checkboxes[i].value);
		}
	}
	
	var correctVal='Y';
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/servicecharge/getOrderType.htm", function(response) {
		try {

				var orderTypeListObj = [];
				orderTypeListObj = JSON.parse(response);
		
				
				if (sChargeRows.length > 0) {
					for ( var j = 0; j < sChargeRows.length; j++) {						
						for ( var k = 0; k < orderTypeListObj.length; k++) {
								if (sChargeRows[j] ==orderTypeListObj[k].orderTypeName) {
																		
										sChargeTxt.push(document.getElementById(orderTypeListObj[k].orderTypeName).value);
											sChargeAmt.push(document.getElementById(orderTypeListObj[k].id).value);
											
												if (sChargeAmt.length>0) {
													for ( var l = 0; l < sChargeAmt.length; l++) {
														if (isNaN(sChargeAmt[l])) {
															correctVal='N';
														showcorrectnumberModal();
														return;
														}
													}
												}
												break;
								}
						}
					}
					
					if(correctVal!='N')
					{
						var orderTypeSCharge = [];
						for(var m=0;m<sChargeTxt.length;m++)
						{
							var serviceCharge = {};
							serviceCharge.orderTypeShortName = sChargeTxt[m];
							serviceCharge.scValue = sChargeAmt[m];
							serviceCharge.storeId = storeID;
							
							orderTypeSCharge.push(serviceCharge);
						}
						
						console.log(orderTypeSCharge);
						
						$.ajax({
							url : BASE_URL + '/servicecharge/updateServiceCharge.htm',
							type : 'POST',
							contentType : 'application/json;charset=utf-8',
							data : JSON.stringify(orderTypeSCharge),
							success : function(response, JSON_UNESCAPED_UNICODE) {
								if (response == 'success' || response == 'SUCCESS') {
									showtaxupdatesuccessModal();
								} else {
				
								}
							}
				
						});
					
					}																
				}
				else {
					showselcttaxModal();
				}

		} catch (e) {
			alert(e);
		}
	}, null);

}
		

/* end service charge setup */



/* start tax setup */
function enablevatTxt(chk) {
	if (chk.checked == true)
		document.getElementById('vatAmtTxt').disabled = false;
	else
		document.getElementById('vatAmtTxt').disabled = true;
}
function enablestTxt(chk) {
	if (chk.checked == true)
		document.getElementById('stAmtTxt').disabled = false;
	else
		document.getElementById('stAmtTxt').disabled = true;
}
function updatetaxAllItem() {
	var taxRows = [];
	var vattxt = null;
	var vatamt = 0.0;
	var sttxt = null;
	var stamt = 0.0;
	var checkboxes = document.getElementsByName('taxChk');
	for ( var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			taxRows.push(checkboxes[i].value);
		}
	}
	if (taxRows.length > 0) {
		for ( var j = 0; j < taxRows.length; j++) {
			if (taxRows[j] == 'vatval') {
				vattxt = document.getElementById('hidvattxt').value;
				vatamt = document.getElementById('vatAmtTxt').value;
				if (isNaN(vatamt)) {
					showcorrectnumberModal();
					return;
				}
			}
			if (taxRows[j] == 'stval') {
				sttxt = document.getElementById('hidsttxt').value;
				stamt = document.getElementById('stAmtTxt').value;
				if (isNaN(vatamt)) {
					showcorrectnumberModal();
					return;
				}
			}
		}
		// alert(vattxt+':'+vatamt+':'+sttxt+':'+stamt);
		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/taxmgnt/updatetaxforallitem/" +
		 * vattxt + "/" + vatamt + "/" + sttxt + "/" + stamt + ".htm",
		 * function(response) { if (response == 'success') {
		 * showtaxupdatesuccessModal(); } }, null);
		 */

		var taxString = {};
		taxString.vatTaxText = vattxt;
		taxString.vatAmt = vatamt;
		taxString.serviceTaxText = sttxt;
		taxString.serviceTaxAmt = stamt;

		$.ajax({
			url : BASE_URL + '/taxmgnt/updatetaxforallitem.htm',
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(taxString),
			success : function(response, JSON_UNESCAPED_UNICODE) {
				if (response == 'success') {
					showtaxupdatesuccessModal();
				} else {

				}
			}

		})

	} else {
		showselcttaxModal();
	}
}
function jLogout() {
	location.href = BASE_URL + '/authentication/logout.htm';
}
/* end tax setup */

/* start expense */
$(document).ready(function() {
	$('#add').click(function() {
		addRow('tbdy')
	})
});
/*
 * $(document).ready(function() { $('#remove').click(function() {
 * $(this).closest ('tr').remove (); }) });
 */

function remove() {
	
	$(this).closest('tr').remove();
}

function keyup() {
	/*var a = $(this).closest('tr').find('.expAmt').val();
	// var b = $(this).val();
	$(this).closest('tr').find('.expAmt').val(a);
	$(this).closest('tr').find('.netAmt').val(parseFloat(a).toFixed(2));//new added
	calculateSum();*/
	
	
	var amt = $(this).closest('tr').find('.expAmt').val();
	var taxrate = $(this).closest('tr').find('.taxRate').val();
	if(amt == '' || amt == 0){
		  $(this).closest('tr').find('.expAmt').val('');
		  $(this).closest('tr').find('.taxAmt').val('');
	      $(this).closest('tr').find('.netAmt').val('');
		}
	 else{
		   if(taxrate == '' || taxrate == 0){
			    $(this).closest('tr').find('.expAmt').val(amt);
			    $(this).closest('tr').find('.netAmt').val(parseFloat(amt).toFixed(2));				         
			  }
		  else{
			    var taxamt = ((parseFloat(amt).toFixed(2) * parseFloat(taxrate).toFixed(2)) / 100);
				var netamt = Number(amt)+Number(taxamt);
				$(this).closest('tr').find('.taxAmt').val(parseFloat(taxamt).toFixed(2));
			    $(this).closest('tr').find('.netAmt').val(parseFloat(netamt).toFixed(2));
		      }
		}
	  calculateSum();
	}

function keyup2() { //new added
	/*var a = $(this).closest('tr').find('.taxRate').val();
	var b = $(this).closest('tr').find('.expAmt').val();
	
	var c= (parseFloat(a).toFixed(2) * parseFloat(b).toFixed(2)) / 100;
	$(this).closest('tr').find('.taxAmt').val(parseFloat(c).toFixed(2));
	
	var d = Number(b) + Number(c);
	$(this).closest('tr').find('.netAmt').val("");
	$(this).closest('tr').find('.netAmt').val(parseFloat(d).toFixed(2));
	
	if (a == ''){
		$(this).closest('tr').find('.taxAmt').val("");
		$(this).closest('tr').find('.netAmt').val(parseFloat(b).toFixed(2));
	}
	//alert("expamt:"+b+" "+"taxrate:"+a+" "+"taxamt::"+c+" "+"netAmt:"+d);
	calculateSum();*/
	
	
	var taxrate = $(this).closest('tr').find('.taxRate').val();
    var amt = $(this).closest('tr').find('.expAmt').val();
     
	if(taxrate == '' || taxrate == 0){
	        if(amt != '' || amt != 0){
			  $(this).closest('tr').find('.netAmt').val(parseFloat(amt).toFixed(2));
			}
	        else{
			 $(this).closest('tr').find('.netAmt').val('');
			}
	        $(this).closest('tr').find('.taxAmt').val('');
	  
	    }
    else{
    	  if(amt == '' || amt == 0){
    		  $(this).closest('tr').find('.taxAmt').val('');
    	      $(this).closest('tr').find('.netAmt').val('');				    
         }
    	  else{
    	
	      var taxamt = ((parseFloat(amt).toFixed(2) * parseFloat(taxrate).toFixed(2)) / 100);
	      var netamt = Number(amt)+Number(taxamt);
		  $(this).closest('tr').find('.taxAmt').val(parseFloat(taxamt).toFixed(2));
	      $(this).closest('tr').find('.netAmt').val(parseFloat(netamt).toFixed(2));				    
    	  }
      }
	calculateSum();
}





function calculateSum() {
	var sum = 0;
	// iterate through each textboxes and add the values
	$(".expAmt").each(function() {

		// add only if the value is number
		if (!isNaN(this.value) && this.value.length != 0) {
			sum += parseFloat(this.value);
		}
	});
	// .toFixed() method will roundoff the final sum to 2 decimal places
	$(".totExp").val(sum.toFixed(2));
}




function selectExpenditure(){ // new 16.5.2018
	var aa = $(this).closest('tr').find('.expTyp').val();
	if(aa == 1){
		$(this).closest('tr').find('.vendName').attr('readonly', false);
	}else{
		$(this).closest('tr').find('.vendName').attr('readonly', true);
	}	
 }


function selectExpType(id){ // new 5.15.2018  test case
	if(id == 1){
		document.getElementById("vendorname").readOnly = false;	
	}
	else{
		document.getElementById("vendorname").readOnly = true;
	}
}


function taxratecheck(){
	var e = $(this).closest('tr').find('.taxRate').val();
	if(isNaN(e)){
		$(this).closest('tr').find('.taxRate').val('');
		var amt = $(this).closest('tr').find('.expAmt').val();
		    if(amt == '') {amt = 0;}
		$(this).closest('tr').find('.netAmt').val(parseFloat(amt).toFixed(2));
		$(this).closest('tr').find('.taxAmt').val('');
		}	
}
function expamtcheck(e){
	var e = $(this).closest('tr').find('.expAmt').val();
	if(isNaN(e)){
	$(this).closest('tr').find('.expAmt').val('');
	$(this).closest('tr').find('.netAmt').val('');
	
	}	
}




function addRow(tableID) {
	var table = document.getElementById(tableID);
	//alert("tab2:"+tableID);
	var rowCount = table.rows.length;
	var row = table.insertRow(rowCount);
	row.style.background = "#404040";
	row.style.color = "#FFF";
	
    
	var cell1 = row.insertCell(0); // expence type
	cell1.align = "center";
	cell1.style.color = "#000";
	cell1.width="10%";
	var element1 = document.createElement("SELECT");
	element1.setAttribute("id", "expstype_"+cellid);
	element1.setAttribute("class", "expTyp");
	cell1.appendChild(element1);
	element1.style.width = "100%";
	element1.style.padding = "2px";
	
	
	//cell1.innerHTML = $("#expenditureTypeList").html();

	var changedExpTypes = JSON.parse(expTypes);
	var z ="";
	var t ="";
	for(var i=0;i<changedExpTypes.length;i++){
		 z = document.createElement("option");
		 z.setAttribute("value",changedExpTypes[i].id);
		 t = document.createTextNode(changedExpTypes[i].typeName);
		 z.appendChild(t);
		 document.getElementById("expstype_"+cellid).appendChild(z);
	}
	$(element1).change(selectExpenditure);
	cellid = Number(cellid) + 1;
	
	
	
	var cell2 = row.insertCell(1); // date
	cell2.align = "center";
	cell2.style.color = "#000";
	cell2.width="10%";
	var element2 = document.createElement("input");
	element2.type = "text";
	element2.setAttribute("class", "vocdate");
	element2.style.width = "100%";
	element2.style.padding = "2px";
	cell2.appendChild(element2);
	
	$(document).find('.vocdate').datepicker({
		format : "yyyy-mm-dd",
		autoclose : true,
		endDate: '0'
	});
	
	
	
	var cell3 = row.insertCell(2); // vocno
	cell3.align = "center";
	cell3.style.color = "#000";
	cell3.width="15%";
	var element3 = document.createElement("input");
	element3.type = "text";
	element3.style.width = "100%";
	element3.style.padding = "2px";
	cell3.appendChild(element3);
	
	
	var cell4 = row.insertCell(3); // vendorname
	cell4.align = "center";
	cell4.style.color = "#000";
	cell4.width="10%";
	var element4 = document.createElement("input");
	element4.type = "text";
	element4.setAttribute("class", "vendName");
	element4.style.width = "100%";
	element4.style.padding = "2px";
	cell4.appendChild(element4);
	
		
	var cell5 = row.insertCell(4); // particular
	cell5.align = "center";
	cell5.style.color = "#000";	
	cell5.width="20%";
	var element5 = document.createElement("input");
	element5.type = "text";
	element5.style.width = "100%";
	element5.style.padding = "2px";
	cell5.appendChild(element5);
	
		
	var cell6 = row.insertCell(5); // expamt
	cell6.align = "center";
	cell6.style.color = "#000";
	cell6.width="10%";
	var element6 = document.createElement("input");
	element6.type = "text";
	element6.setAttribute("class", "expAmt");
	element6.setAttribute("size", "4");
	element6.style.width = "100%";
	element6.style.padding = "2px";
	cell6.appendChild(element6);
	$(element6).keyup(keyup);
	$(element6).keyup(expamtcheck);
	
	var cell7 = row.insertCell(6); // taxrate
	cell7.align = "center";
	cell7.style.color = "#000";
	cell7.width="5%";
	var element7 = document.createElement("input");
	element7.type = "text";
	element7.setAttribute("class", "taxRate");
	element7.style.width = "100%";
	element7.style.padding = "2px";
	cell7.appendChild(element7);
	$(element7).keyup(keyup2);
	$(element7).keyup(taxratecheck);
	
	
	var cell8 = row.insertCell(7); // taxamt
	cell8.align = "center";
	cell8.style.color = "#000";
	cell8.width="10%";	
	var element8 = document.createElement("input");
	element8.type = "text";
	element8.setAttribute("class", "taxAmt");
	element8.setAttribute('readonly','true');
	element8.style.width = "100%";
	element8.style.padding = "2px";
	cell8.appendChild(element8);
	
	
	var cell9 = row.insertCell(8); // netamt
	cell9.align = "center";
	cell9.style.color = "#000";
	cell9.width="10%";
	var element9 = document.createElement("input");
	element9.type = "text";
	element9.setAttribute("class", "netAmt");
	element9.setAttribute('readonly','true');
	element9.style.width = "100%";
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
}

function saveExpenditure() {
	var vocDate = null;
	var vocNo = null;
	var vocPart = null;
	var expAmt = null;
	var vendorname = null;
	var taxrate = null;
	var taxamt = null;
	var netamt = null;
    var voexptypeid =null;
    
	var table = document.getElementById("tbl");
	//alert("table length:"+table.rows.length);
	for ( var i = 1; i < table.rows.length; i++) {
        
		var id = i-1;
		voexptypeid = document.getElementById("expstype_"+id).value;
		//alert("voexptypeid:"+voexptypeid);
		vocDate = table.rows[i].cells[1].firstChild.value;
		//alert("vocDate:"+vocDate);
		vocNo = table.rows[i].cells[2].firstChild.value;
		//alert("vocNo:"+vocNo);
		vendorname = table.rows[i].cells[3].firstChild.value;
		//alert("vendorname:"+vendorname);
		vocPart = table.rows[i].cells[4].firstChild.value;
		//alert("vocPart:"+vocPart);
		expAmt = table.rows[i].cells[5].firstChild.value;
		//alert("expAmt:"+expAmt);
		taxrate = table.rows[i].cells[6].firstChild.value;
		//alert("taxrate:"+taxrate);
		taxamt = table.rows[i].cells[7].firstChild.value;
		//alert("taxamt:"+taxamt);
		netamt = table.rows[i].cells[8].firstChild.value;
		//alert("netamt:"+netamt);
		if(taxrate == '' && taxamt == ''){
			taxamt = "0.0";
			taxrate = "0.0";
		}
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		if (table.rows[i].cells[1].firstChild.value == 0
				|| table.rows[i].cells[2].firstChild.value == 0
				|| table.rows[i].cells[5].firstChild.value == 0
				|| table.rows[i].cells[8].firstChild.value == 0) {
			showExpAlertModal();
		} else {
			/*
			 * ajaxCallObject.callAjax(BASE_URL +
			 * "/expendituremgmt/addexpenditure/" + vocDate + "/" + vocNo + "/" +
			 * vocPart + "/" + expAmt + ".htm", function() { location.href =
			 * BASE_URL + '/expendituremgmt/loadexpendituremgmt.htm'; }, null);
			 */
			
			var addexpenditureString = {};
			addexpenditureString.expenditureTypeId = voexptypeid;
			addexpenditureString.voucherDate = vocDate;
			addexpenditureString.voucherId = vocNo;
			addexpenditureString.particulars = vocPart;
			addexpenditureString.amount = expAmt;
			addexpenditureString.vendorName = vendorname;
			addexpenditureString.taxRate = taxrate;
			addexpenditureString.taxAmt = taxamt;
			addexpenditureString.netAmt = netamt;
             console.log(addexpenditureString);
			$.ajax({
				url : BASE_URL + '/expendituremgmt/addexpenditure.htm',
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(addexpenditureString),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					
					location.href = BASE_URL
							+ '/expendituremgmt/loadexpendituremgmt.htm';
				}

			})

		}

	}
	
}

// for yyyy-mm-dd
function dateformat(str) {
	var dt = parseInt(str.substring(8, 10), 10);
	var mon = parseInt(str.substring(5, 7), 10);
	var yr = parseInt(str.substring(0, 4), 10);
	str = new Date(yr, mon - 1, dt);
	return str;
}

function formatDate(date) {
	var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
			+ d.getDate(), year = d.getFullYear();

	if (month.length < 2)
		month = '0' + month;
	if (day.length < 2)
		day = '0' + day;

	return [ year, month, day ].join('-');
}

function showdailyExp(date, storeId) {
	var todaydate = document.getElementById('hiddatedailyExp').value;
	if (dateformat(date) > dateformat(todaydate)) {
		showExpGreaterAlertModal();
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL
				+ "/expendituremgmt/loaddailyexpenditure/" + date + "/"
				+ storeId + ".htm", function(response) {
			try {
				var responseObj = JSON.parse(response);				
				prepareDailyExpTable(responseObj);
			} catch (e) {
				alert(e);
			}

		}, null);
	}
}

function showCurrentDateExp(storeId) {
	
	var todaydate=document.getElementById('hiddenexpList').value;
	
	document.getElementById('fromdateexpList').value=todaydate;
	document.getElementById('todateexpList').value=todaydate;
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL
			+ "/expendituremgmt/loadperiodexpenditure/" + todaydate + "/" + todaydate + "/" + storeId + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			prepareDailyExpTable(responseObj);
		} catch (e) {
			alert(e);
		}
	}, null);
}

function showPeriodWiseExp(fromdate, todate, storeId) {
	
	var todaydate=document.getElementById('hiddenexpList').value;
	if(dateformat(fromdate)>dateformat(todate))
		{
		//alert('bigger');
		showalertexpModalBiggerFromDate();
		//document.getElementById('dateexpList').value=todaydate;
		}
	else{
				
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL
				+ "/expendituremgmt/loadperiodexpenditure/" + fromdate + "/" + todate + "/" + storeId + ".htm", function(response) {
			try {
				var responseObj = JSON.parse(response);
				console.log(responseObj);
				prepareDailyExpTable(responseObj);
			} catch (e) {
				alert(e);
			}
		}, null);
	}
}


function prepareDailyExpTable(responseData) {
	var dailyexpContainerId = document.getElementById("dailyexpContainerId");

	var starttable = "<table class='table table-striped table-bordered table-hover'>"
		+ "<thead style='background:#404040; color:#FFF;'><th style='text-align:center;'>"
		+ getLang.exptype
		+"</th><th style='text-align:center;'>"
		+ getLang.vchrDate
		+ "</th><th style='text-align:center;'>"
		+ getLang.vchrNo
		+ "</th><th style='text-align:center;'>"
		+ getLang.vendor
		+ "</th><th style='text-align:center;'>"
		+ getLang.partculrs
		+"</th><th style='text-align:center;'>"
		+ getLang.amount 
		+ "</th><th style='text-align:center;'>"
		+ getLang.taxrate
		+ "</th><th style='text-align:center;'>"
		+ getLang.taxamt
		+ "</th><th style='text-align:center;'>"
		+ getLang.netamount 
		+ "</th><th style='text-align:center;'>"
		+ getLang.edit
		+"</th><th style='text-align:center;'>"
		+ getLang.del
		+"</th></thead><tbody style='color:#fff;'>";

	/*"<tbody style='color:#fff;'>";*/
	var endtable = "</tbody></table>";
	var createdrowline = "";
	var generatedHtml = "";
	var totExpAmt = 0.0;
	if (responseData.length > 0) {
		for ( var i = 0; i < responseData.length; i++) {
			// var date = new Date(dailyExp.voucherDate);
			var dailyExp = responseData[i];
			var begintr = "<tr style='background:#404040; color:#FFF;'>";
			var exptypetd = "<td align='center'>"+ dailyExp.expenditureTypeName +"</td>";
			var firsttd = "<td align='center'>" + formatDate(dailyExp.voucherDate) + "</td>";
			var secondtd = "<td align='center'>" + dailyExp.voucherId + "</td>";
			var thirdtd = "<td align='center'>" + dailyExp.vendorName + "</td>";
			var fourthtd = "<td align='center'>" + dailyExp.particulars+ "</td>";
			var amttd = "<td align='center'>" +parseFloat(dailyExp.amount).toFixed(2)+ "</td>";
			var fifthtd = "<td align='center'>" + dailyExp.taxRate  + "</td>";
			var sixthtd = "<td align='center'>" + parseFloat(dailyExp.taxAmt).toFixed(2) + "</td>";					
			var seventhtd = "<td align='center'>" + parseFloat(dailyExp.netAmt).toFixed(2) + "</td>"; //changed netAmt from ammt
			
			var edittd ="<td align='center'><a href='javascript:showdailyexpeditModal("+dailyExp.id+","+"&quot;"+formatDate(dailyExp.voucherDate)+"&quot;"+","+"&quot;"+dailyExp.voucherId+"&quot;"+","+"&quot;"+dailyExp.vendorName+"&quot;"+","+"&quot;"+dailyExp.particulars+"&quot;"+","+dailyExp.taxRate+","+dailyExp.taxAmt+","+parseFloat(dailyExp.amount).toFixed(2)+","+parseFloat(dailyExp.netAmt).toFixed(2)+","+dailyExp.expenditureTypeId+")'> <input type='image' src='"+ BASE_URL +"/assets/images/admin/g/g_edit.png'></a>"  + "</td>";
			var deletetd = "<td align='center'><a href='javascript:showConfirmdeletedailyexpModal("+dailyExp.id+")'><input type='image' src='"+ BASE_URL +"/assets/images/admin/g/g_delete.png'></a></td>";
			
			
			
			var endtr = "</tr>";
			createdrowline += begintr + exptypetd + firsttd + secondtd + thirdtd + fourthtd + amttd + fifthtd + sixthtd + seventhtd + edittd + deletetd + endtr;
			// += creditOrder.orderBill.grossAmt;
			//totDiscAmt += creditOrder.orderBill.customerDiscount;
			totExpAmt += dailyExp.netAmt; //changed netAmt from ammt
		}
		
		if (responseData.length > 1) {
			var begintottr = "<tr style='background:#e2e2e2; color:#222222;'>";
			var totaltd = "<td colspan='8' align='center'>"+ "<strong>" +  getLang.total
			+ "</strong>"+ "</td>";
			
			var totalduetd = "<td align='center' colspan='3'>"
					+ "<strong>" + parseFloat(totExpAmt).toFixed(2) + "</strong>"+ "</td>"; //changed netAmt from ammt
		
			var endtottr = "</tr>";
			createdrowline += begintottr + totaltd  
					+ totalduetd +  endtottr;
		}
	} else {
		var begintr = "<tr style='background:#404040; color:#FFF;'>";
		var firsttd = "<td colspan='11'>No Data found!</td>";
		var endtr = "</tr>";
		createdrowline += begintr + firsttd + endtr;
	}
	generatedHtml = starttable + createdrowline + endtable;
	dailyexpContainerId.innerHTML = generatedHtml;
	
	
}


function showdailyexpeditModal(id,voucherDate,voucherId,vendorName,particulars,taxRate,taxAmt,amount,netAmt,expenditureTypeId){
	//alert("id"+id+" "+"date:"+voucherDate+" "+"ID"+voucherId+" "+"vname:"+vendorName+" "+"perti:"+particulars+" "+"taxrate:"+taxRate+" "+"taxAmt:"+taxAmt+" "+"amount:"+amount+" "+"netAmt:"+netAmt);
	
	document.getElementById('editexpensetype').value=expenditureTypeId;
	document.getElementById('editdailyexpid').value=id;
	document.getElementById('editdailyexpvoucherno').value=voucherId;
	document.getElementById('editdailyexpdate').value=voucherDate;
	document.getElementById('editdailyexpvendor').value=vendorName;
	document.getElementById('editdailyexpparticulars').value=particulars;
	document.getElementById('editdailyexpamount').value= parseFloat(amount).toFixed(2);
	document.getElementById('editdailyexptaxrate').value=parseFloat(taxRate).toFixed(2);
	document.getElementById('editdailyexptaxamt').value=parseFloat(taxAmt).toFixed(2);
	document.getElementById('editdailyexpnetamt').value=parseFloat(netAmt).toFixed(2);
	document.getElementById('editdailyexpalertMsg').innerHTML = "";
	if(expenditureTypeId == 1){
		document.getElementById('editdailyexpvendor').readOnly = false;
	}
	else{
		document.getElementById('editdailyexpvendor').readOnly = true;
	}
	
	
    $('#dailyExpenditureEditModal').modal('show');

}

function showConfirmdeletedailyexpModal(id){
	 document.getElementById('moddeleteconfirmdailyexpId').value=id;
	   $('#confirmdeleteDailyExpModal').modal('show');
}

function changeCalculationOnAmount(amount){
	//var amount=document.getElementById('editdailyexpamount').value;
	var taxRate=document.getElementById('editdailyexptaxrate').value;
	var taxAmt=document.getElementById('editdailyexptaxamt').value;
	var netAmt=document.getElementById('editdailyexpnetamt').value;
	
	if(amount == ''){
		document.getElementById('editdailyexpnetamt').value ="";
		document.getElementById('editdailyexptaxamt').value ="";
	}
	if(amount != '' && taxRate == ''){
		document.getElementById('editdailyexptaxamt').value = "";
		document.getElementById('editdailyexptaxamt').value = "";
		document.getElementById('editdailyexpnetamt').value = parseFloat(amount).toFixed(2);
	}
	if(amount != '' && taxRate != ''){
		var currenttaxamt = Number(amount) * Number(taxRate) / 100;
		var currentnetamt = Number(amount) + Number(currenttaxamt);
		document.getElementById('editdailyexpnetamt').value = parseFloat(currentnetamt).toFixed(2);
		document.getElementById('editdailyexptaxamt').value = parseFloat(currenttaxamt).toFixed(2);
	}
	
	
}

function changeCalculationOnTaxRate(tax){
	var amount=document.getElementById('editdailyexpamount').value;
	var taxRate=document.getElementById('editdailyexptaxrate').value;
	var taxAmt=document.getElementById('editdailyexptaxamt').value;
	var netAmt=document.getElementById('editdailyexpnetamt').value;
	
	
	if(amount == ''){
		document.getElementById('editdailyexptaxamt').value = "";
		document.getElementById('editdailyexpnetamt').value = "";
	}
	
	if(tax == '' && amount != ''){
		document.getElementById('editdailyexpnetamt').value = parseFloat(amount).toFixed(2);
		document.getElementById('editdailyexptaxamt').value = "";
	}
	
	if(tax == '' && amount == ''){
		document.getElementById('editdailyexpnetamt').value = "";
		document.getElementById('editdailyexptaxamt').value = "";
	}
	
	if(tax != '' && amount != ''){
		var currenttaxamt=Number(amount)*Number(tax)/100;
		var currentnetamt=Number(amount)+Number(currenttaxamt);
		document.getElementById('editdailyexpnetamt').value = parseFloat(currentnetamt).toFixed(2);
		document.getElementById('editdailyexptaxamt').value = parseFloat(currenttaxamt).toFixed(2);
	}
	
	
	
	
	
}



function editDailyExpenditure(){
	var id=document.getElementById('editdailyexpid').value;
	var voucherId=document.getElementById('editdailyexpvoucherno').value;
	var voucherDate=document.getElementById('editdailyexpdate').value;
	var vendorName=document.getElementById('editdailyexpvendor').value;
	var particulars=document.getElementById('editdailyexpparticulars').value;
	var amount=document.getElementById('editdailyexpamount').value;
	var taxRate=document.getElementById('editdailyexptaxrate').value;
	var taxAmt=document.getElementById('editdailyexptaxamt').value;
	var netAmt=document.getElementById('editdailyexpnetamt').value;
	var expensetypeid = document.getElementById('editexpensetype').value;
	
	if(taxRate == ''){
		taxRate = "0.0";
	}
	if(taxAmt == ''){
		taxAmt = "0.0";
	}
	
	if(voucherId == '' || voucherDate == '' || amount == ''){
		document.getElementById('editdailyexpalertMsg').innerHTML = getLang.failtoReq;
		
	}else{
		document.getElementById('editdailyexpalertMsg').innerHTML = "";
		var dailyexpenditure = {};
		dailyexpenditure.id=id;
		dailyexpenditure.voucherId=voucherId;
		dailyexpenditure.voucherDate=voucherDate;
		dailyexpenditure.vendorName=vendorName;
		dailyexpenditure.particulars=particulars;
		dailyexpenditure.amount=parseFloat(amount).toFixed(2);
		dailyexpenditure.taxRate=parseFloat(taxRate).toFixed(2);
		dailyexpenditure.taxAmt=parseFloat(taxAmt).toFixed(2);
		dailyexpenditure.netAmt=parseFloat(netAmt).toFixed(2);
		dailyexpenditure.expenditureTypeId=expensetypeid;
		
		$.ajax({
			url : BASE_URL + "/expendituremgmt/editdailyexp.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(dailyexpenditure),
			success : function(response, JSON_UNESCAPED_UNICODE) {
				console.log(response);
				// closenmenucateditModal();
				if (response == 'success') {
					 $('#dailyExpenditureEditModal').modal('hide');
					document.getElementById('dailyexpdataopmassagecont').innerHTML = getLang.datasucUpdate;
					showalertdailyexpdataopModal();
				} else {
					 $('#dailyExpenditureEditModal').modal('hide');
					document.getElementById('dailyexpdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
					showalertdailyexpdataopModal();
				}
			}
		});
			
	}
	
}


function deleteDailyExpenditure(){
	var id = document.getElementById("moddeleteconfirmdailyexpId").value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/expendituremgmt/deleteexpenditure/" + id + ".htm",
					function(response) {
						if (response == 'success') {
							document.getElementById('dailyexpdataopmassagecont').innerHTML = getLang.datasucDelete;
							showalertdailyexpdataopModal();
						} else {
							document.getElementById('dailyexpdataopmassagecont').innerHTML = getLang.datasucNotDelete;
							showalertdailyexpdataopModal();
						}
						 
					}, null);
}

/* end expense */
/* start clean log files */
function cleanLogfile() {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/admin/cleanlogfile.htm",
					function(response) {
						if (response == 'success') {
							document.getElementById("cleanlogfileMsgContId").innerHTML = getLang.logSucDelt;
						} else {
							document.getElementById("cleanlogfileMsgContId").innerHTML = getLang.errDeltTime;
						}
						showscleanLogfileModal();
					}, null);
}
/* end clean log files */

function translatemenuItem() {
	var name;
	var desc;
	var menuItemTranslatedpost = {};
	var menulist = [];
	var selectedRows = [];
	var checkboxes = document.getElementsByName('checkbox'); 
	for ( var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			selectedRows.push(checkboxes[i].value);
		}
	}if (selectedRows.length > 0) {
	$("#translatemenuitem tbody tr").each(
			function(index) {
				var trid = this.id;
				$row = $(this);				
				if (($row.find('input[type="checkbox"]').is(':checked'))) {

					var menuItemTranslated = {};
					var menuitem = {};
					console.log($row.find("td").eq(1).text());
					menuitem.id = $row.find("td").eq(1).text();
					menuItemTranslated.menuItem = menuitem;
					menuItemTranslated.language = document
							.getElementById('changelangId').value;
					menuItemTranslated.id = $row.find('.translationid').val();
					menuItemTranslated.name = $row.find(
							'.translateMenuitemName').val();/* $row.find("td").eq(3).val(); */
					menuItemTranslated.description = $row.find(
							'.translateMenuitemDescription').val();
					name = menuItemTranslated.name;
					desc = menuItemTranslated.description;
					
			//		alert('hi'+$row.find('.translateMenuitemDescription').val());
					menuItemTranslated.storeId = storeID;
					menulist.push(menuItemTranslated);
					console.log(menulist);
				}
			});
	menuItemTranslatedpost.itemLangMaps = menulist;
	if(name === '' || desc === '' ){
		document.getElementById('menuitemdataopmassagecont_cancel').innerHTML = getLang.plsEntrNameOrDesc;
		// alert("ENTER");
		// showalertmenuitemdataopModal();
		showalertmenuitemdataopModal_cancel();
		return false;
	}else {
		$.ajax({
			url : BASE_URL + "/menutranslation/translatemenuitems.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(menuItemTranslatedpost),
			success : function(response, JSON_UNESCAPED_UNICODE) {
				console.log(response);
				// closenmenucateditModal();
				if (response == 'success') {
					document.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucUpdate;
					showalertmenuitemdataopModal();
				} else {
					document.getElementById('menuitemdataopmassagecont_cancel').innerHTML = getLang.datasucNotUpdate;
				//	showalertmenuitemdataopModal();
					showalertmenuitemdataopModal_cancel();
				}
			}
		});
	}
	
			}else{
				document.getElementById('menuitemdataopmassagecont_cancel').innerHTML = getLang.plsEnterOneRow;
				// showalertmenuitemdataopModal();	
				showalertmenuitemdataopModal_cancel();
			}
}

// posttranslatedcatnsubcat
function translatemenucatnsubcat() {

	var tname;
	var catnsubcatTranslatedpost = {};
	var catnsubcatlist = [];
	var selectedRows = [];
	var checkboxes = document.getElementsByName('checkbox'); 
	for ( var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			selectedRows.push(checkboxes[i].value);
			//alert('hi'+selectedRows.length);
		}
	}if (selectedRows.length > 0) {
		$("#translatemenuitem tbody tr").each(
				function(index) {
					var trid = this.id;
					$row = $(this);
					if ($row.find('input[type="checkbox"]').is(':checked')) {

						var catnsubcatTranslated = {};
						var menucategory = {};
						menucategory.id = $row.find("td").eq(1).text();
						catnsubcatTranslated.menucategory = menucategory;
						catnsubcatTranslated.language = document
								.getElementById('changelangId').value;
						catnsubcatTranslated.id = $row.find('.translationid')
								.val();
						catnsubcatTranslated.catSubCatId = $row.find("td")
								.eq(1).text();
						catnsubcatTranslated.englishName = $row.find("td")
								.eq(2).text();
						catnsubcatTranslated.menuItemName = $row.find(
								'.translateMenuitemName').val();
						tname = catnsubcatTranslated.menuItemName;
						catnsubcatTranslated.storeId = storeID;
						catnsubcatlist.push(catnsubcatTranslated);
						console.log(catnsubcatlist);
					}

				});
		catnsubcatTranslatedpost.categoryLangMaps = catnsubcatlist;
		
		if(tname === ''){
			document.getElementById('menuitemdataopmassagecont_cancel').innerHTML = getLang.plsEnterTranslatedName;
			// showalertmenuitemdataopModal();
			showalertmenuitemdataopModal_cancel();
			return false;
			
		}else {
			$.ajax({
				url : BASE_URL
						+ "/catNSubcattranslation/translatecatnsubcat.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(catnsubcatTranslatedpost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					// closenmenucateditModal();
					
					if (response == 'success') {
						document.getElementById('menuitemdataopmassagecont').innerHTML = getLang.datasucUpdate;
						showalertmenuitemdataopModal();
					} else {
						document.getElementById('menuitemdataopmassagecont_cancel').innerHTML = getLang.datasucNotUpdate;
						// showalertmenuitemdataopModal();
						showalertmenuitemdataopModal_cancel();
					}
				}
			
			});
		}
		
	}else{
		document.getElementById('menuitemdataopmassagecont_cancel').innerHTML = getLang.plsEnterOneRow;
		showalertmenuitemdataopModal_cancel();	
	}
	
	}

function loadmenucatnsubcattotranslatewithlang(language) {
	// alert('hi'+language);
	location.href = BASE_URL
			+ "/catNSubcattranslation/loadmenucatnsubcattotranslatewithlang.htm?lang="
			+ language;
}

function getitemfortranslationwithlang(lang) {
	// alert('hi'+menucatid);
	location.href = BASE_URL
			+ "/menutranslation/loadmenuitemtotranslatewithlang.htm?lang="
			+ lang;
}


/* start credit sale */
function getcreditOrderBycustId(id, name, contact) {
	// alert(id+':'+name+':'+contact);
	$("#creditordertableContId").addClass('hide');
	$("#waitimage").removeClass('hide');
	getcustomerledger_pur('SDE',0,id,2)// for customer
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/creditsale/getcreditorderbycustid/"
			+ id + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			prepareCreditOrderHtml(responseObj);
		} catch (e) {
			alert(e);
		}

	}, null);
	document.getElementById('creditcustnameContId').innerHTML = name;
	document.getElementById('creditcustcontactContId').innerHTML = contact;
	document.getElementById('creditcustidContId').value = id;
}

function prepareCreditOrderHtml(responseData) {
	//alert("This is active function");
	$("#waitimage").addClass('hide');
	$("#creditordertableContId").removeClass('hide');
	
	var creditordercontainerId = document
			.getElementById('creditordertableContId');
	var starttable = "<table class='table table-striped table-bordered table-hover'>"
			+ "<thead style='background:#404040; color:#FFF;'><th style='text-align:center;'>"
			+ "ORDER NO"
			+ "</th><th style='text-align:center;'>"
			+ "DATE"
			+ "</th><th style='text-align:center;'>"
			+ "BILL AMT"
			+ "</th><th style='text-align:center;'>"
			+ "PAID AMT"
			+ "</th><th style='text-align:center;'>"
			+ "DUE AMT"
			+ "</th><th style='text-align:center;'>"
			+ "PAY" + "</th>"+"<th style='text-align:center;'>"
			+ "ACTION" + "</th>"  + "</thead>";
	"<tbody style='color:#fff;'>";
	var endtable = "</tbody></table>";
	var createdrowline = "";
	var generatedHtml = "";
	var totBillAmt = 0.0;
	var totDiscAmt = 0.0;
	var totPaidAmt = 0.0;
	if (responseData.length > 0) {
		for ( var i = 0; i < responseData.length; i++) {

			var creditOrder = responseData[i];
			var begintr = "<tr style='background:#404040; color:#FFF;'>";
			var firsttd = "<td align='center'>" + creditOrder.orderNo + "</td>";
			var secondtd = "<td align='center'>"
					+ (creditOrder.orderTime).substring(0, 10);
			+"</td>";
			var thirdtd = "<td align='center'>"
					+ parseFloat(creditOrder.orderBill.grossAmt).toFixed(2)
					+ "</td>";
			var thirdtd1 = "<td align='center'>"
					+ parseFloat(creditOrder.orderBill.customerDiscount)
							.toFixed(2) + "</td>";
			var fourthtd = "<td align='center'>"
					+ parseFloat(creditOrder.paidAmt).toFixed(2) + "</td>";
			var fifthtd = "<td align='center'>"
					+ parseFloat(
							creditOrder.orderBill.grossAmt
									- creditOrder.paidAmt).toFixed(2) + "</td>";
			var sixthtd = "<td align='center' style='width:25%;'><a href='javascript:opencr_saleCashModal("
					+ creditOrder.id
					+ ",&quot;"
					+ creditOrder.table_no
					+ "&quot;,"
					+ creditOrder.orderBill.grossAmt
					+ ","
					+ creditOrder.paidAmt
					+ ","
					+ creditOrder.orderNo
					+ ")' class='btn btn-success'>"
					+ "CASH"
					+ "</a>&nbsp;<a href='javascript:opencr_saleCardModal("
					+ creditOrder.id
					+ ",&quot;"
					+ creditOrder.table_no
					+ "&quot;,"
					+ creditOrder.orderBill.grossAmt
					+ ","
					+ creditOrder.paidAmt
					+ ","
					+ creditOrder.orderNo
					+ ")' class='btn btn-success'>"
					+ "CARD" + "</a></td>";
			var printline ="<td align='center'><a href='javascript:getCreditOrderById("
					+ creditOrder.id
					+ ",&quot;"
					+ creditOrder.table_no
					+ "&quot;,"
					+ creditOrder.orderBill.grossAmt
					+ ","
					+ creditOrder.paidAmt
					+ ","
					+ creditOrder.orderNo
					+ ")' class='btn btn-success'>"
					+ "PRINT"+ "</a></td>";
			
			var endtr = "</tr>";
			createdrowline += begintr + firsttd + secondtd + thirdtd + fourthtd
					+ fifthtd + sixthtd +  printline + endtr;
			totBillAmt += creditOrder.orderBill.grossAmt;
			totDiscAmt += creditOrder.orderBill.customerDiscount;
			totPaidAmt += creditOrder.paidAmt;
		}
		if (responseData.length > 1) {
			var begintottr = "<tr style='background:#e2e2e2; color:#222222;'>";
			var totaltd = "<td colspan='2' align='center'>" + "TOTAL"
					+ "</td>";
			var totalbilltd = "<td align='center'>"
					+ parseFloat(totBillAmt).toFixed(2) + "</td>";
			var totaldisctd = "<td align='center'>"
					+ parseFloat(totDiscAmt).toFixed(2) + "</td>";
			var totalpaidtd = "<td align='center'>"
					+ parseFloat(totPaidAmt).toFixed(2) + "</td>";
			var totalduetd = "<td align='center'>"
					+ parseFloat(totBillAmt - totPaidAmt).toFixed(2) + "</td>";
			var totalpaytd = "<td align='center'><a href='javascript:opentotcr_saleCashModal("
					+ totBillAmt
					+ ","
					+ totPaidAmt
					+ ")' class='btn btn-success'>"
					+ "CASH"
					+ "</a>&nbsp;<a href='javascript:opentotcr_saleCardModal("
					+ totBillAmt
					+ ","
					+ totPaidAmt
					+ ")' class='btn btn-success'>"
					+ "CARD"
					+ "</a></td>";
			var endtottr = "</tr>";
			createdrowline += begintottr + totaltd + totalbilltd + totalpaidtd
					+ totalduetd + totalpaytd + endtottr;
		}
	} else {
		var begintr = "<tr style='background:#404040; color:#FFF;'>";
		var firsttd = "<td colspan='6'>" + "No Data found!" + "</td>";
		var endtr = "</tr>";
		createdrowline += begintr + firsttd + endtr;
	}
	generatedHtml = starttable + createdrowline + endtable;
	creditordercontainerId.innerHTML = generatedHtml;
 
}
function opencr_saleCashModal(orderno, tableno, billAmt, paidAmt ,storebaseorderno) {
	//alert("5426 line");
	getcustomerledger_pur('CIH',0,0,1)// for cash in hand
	document.getElementById('cr_salecashtenderAmt').value = '';
	document.getElementById('cr_salepaycashalertMsg').innerHTML = '';
	document.getElementById('cr_salecashmodOrderCont').innerHTML = orderno;
	document.getElementById('cr_salecashmodStoreBaseOrderCont').innerHTML = storebaseorderno;
	document.getElementById('cr_salecashmodTabCont').innerHTML = tableno;
	document.getElementById('cr_salecashtotamtcontId').innerHTML = parseFloat(
			billAmt).toFixed(2);
	// document.getElementById('cr_salecashdiscamtcontId').innerHTML=parseFloat(discAmt).toFixed(2);
	document.getElementById('cr_salecashpaidamtcontId').innerHTML = parseFloat(
			paidAmt).toFixed(2);
	document.getElementById('cr_salecashamttopaycontId').innerHTML = parseFloat(
			billAmt - paidAmt).toFixed(2);
	showcr_saleCashModal();
}  
function getcr_saleChangeAmt(tenderAmt) {
	var amntToPay = document.getElementById('cr_salecashamttopaycontId').innerHTML;
	// alert(tenderAmt+':'+amntToPay);
	if (tenderAmt == '') {
		document.getElementById('cr_salecashchangeamtcontId').innerHTML = '0.00';
	} else if (parseFloat(amntToPay) >= parseFloat(tenderAmt)) {
		document.getElementById('cr_salecashchangeamtcontId').innerHTML = '0.00';
	} else {
		document.getElementById('cr_salecashchangeamtcontId').innerHTML = parseFloat(
				parseFloat(tenderAmt) - parseFloat(amntToPay)).toFixed(2);
	}
}
function opencr_saleCardModal(orderno, tableno, billAmt, paidAmt,storebaseorderno) {
	//alert("storebaseorderno"+storebaseorderno);
	getcustomerledger_pur('CAB',0,0,3)// for bank account
	document.getElementById('cr_salepaycardalertMsg').innerHTML = '';
	document.getElementById('cr_salecardlastfourDigit').value = '';
	document.getElementById('cr_salecardmodOrderCont').innerHTML = orderno;
	document.getElementById('cr_salecardmodStoreBaseOrderCont').innerHTML = storebaseorderno;
	document.getElementById('cr_salecardmodTabCont').innerHTML = tableno;
	document.getElementById('cr_salecardtotamtcontId').innerHTML = parseFloat(
			billAmt).toFixed(2);
	// document.getElementById('cr_salecarddiscamtcontId').innerHTML=parseFloat(discAmt).toFixed(2);
	document.getElementById('cr_salecardpaidamtcontId').innerHTML = parseFloat(
			paidAmt).toFixed(2);
	document.getElementById('cr_salecardamttopaycontId').innerHTML = parseFloat(
			billAmt - paidAmt).toFixed(2);
	document.getElementById('cr_salecardtenderAmt').value = parseFloat(
			billAmt - paidAmt).toFixed(2);
	showcr_saleCardModal();
}
var custID=null;
function cr_salepayByCash(tenderAmt) {
	//alert("singlie crefid cash pay:"+tenderAmt);
	var custid = document.getElementById('creditcustidContId').value;
	var orderno = document.getElementById('cr_salecashmodOrderCont').innerHTML;
	var billAmt = Number(document.getElementById('cr_salecashtotamtcontId').innerHTML);
	var remarks = document.getElementById('creditpayremarkbycash').value;
	custID=custid;
	// var
	// discAmt=document.getElementById('cr_salecashdiscamtcontId').innerHTML;
	var paidAmnt = Number(document.getElementById('cr_salecashpaidamtcontId').innerHTML);
	var amntToPay = Number(document.getElementById('cr_salecashamttopaycontId').innerHTML);
	tenderAmt = Number(tenderAmt);
	var cr_ledger_id=document.getElementById('cr_legder_id').value;
	var dr_ledger_id=document.getElementById('dr_legder_id').value;
	
	if (!parseFloat(tenderAmt)) {
		// alert('Please enter a valid number!');
		document.getElementById('cr_salepaycashalertMsg').innerHTML = "Please enter a valid number!";
		document.getElementById('cr_salecashtenderAmt').focus();
	} else {
		if (Number(parseFloat(tenderAmt)) >= Number(parseFloat(amntToPay))) {
			paidAmnt = parseFloat(amntToPay);
			amntToPay = 0.0;
		} else {
			paidAmnt = parseFloat(tenderAmt);
			amntToPay = (Number(parseFloat(amntToPay)) - Number(parseFloat(tenderAmt)))
					.toFixed(2);
		}
		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/" + orderno +
		 * "/" + billAmt + "/" + paidAmnt + "/" + amntToPay + "/" + tenderAmt +
		 * "/" + "cash" + "/" + "0000" + ".htm", function( response) { try {
		 * alert("response is >> "+response); if (response == 'success') { var
		 * ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL +
		 * "/creditsale/getcreditorderbycustid/" + custid + ".htm",
		 * function(response) { try { var responseObj = JSON.parse(response);
		 * prepareCreditOrderHtml(responseObj); } catch (e) { alert(e); } },
		 * null); hidecr_saleCashModal(); } } catch (e) { alert(e); } }, null);
		 */

		var paymentAdmin = {};
		var order = {};

		order.id = orderno;
		paymentAdmin.amount = billAmt;
		paymentAdmin.paidAmount = paidAmnt;
		paymentAdmin.amountToPay = amntToPay;
		paymentAdmin.tenderAmount = tenderAmt;
		paymentAdmin.paymentMode = "cash";
		paymentAdmin.cardLastFourDigits = "0000";
		paymentAdmin.orderPayment = order;
		paymentAdmin.remarks = remarks;
		
		if (is_Acc=='Y') {
			if (cr_ledger_id<=0 || dr_ledger_id<=0) {
				document.getElementById('cr_salepaycashalertMsg').innerHTML=' ledger missing !!! ';
				return;
			}else {
				document.getElementById('cr_salepaycashalertMsg').innerHTML='';
				paymentAdmin.cr_amount=paidAmnt;
				paymentAdmin.dr_amount=paidAmnt;
				paymentAdmin.cr_legder_id=cr_ledger_id;
				paymentAdmin.dr_legder_id=dr_ledger_id;
			}
		}

		$.ajax({
			url : BASE_URL + '/order/orderpaymentFromAdmin.htm',
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(paymentAdmin),
			success : function(response, JSON_UNESCAPED_UNICODE) {

				if (response == 'success') {
					document.getElementById('creditpayremarkbycash').value = " ";
					hidecr_saleCashModal();
					showalertOrderPaidModal();
				}
			}
		});

	}
}
function cr_salepayByCard(tenderAmt) {
   // alert("single credit pay by card:"+tenderAmt);
	var custid = document.getElementById('creditcustidContId').value;
	var orderno = document.getElementById('cr_salecardmodOrderCont').innerHTML;
	var billAmt = Number(document.getElementById('cr_salecardtotamtcontId').innerHTML);
	var remarks = document.getElementById('creditpayremarkbycard').value;
	custID=custid;
	// var
	// discAmt=document.getElementById('cr_salecarddiscamtcontId').innerHTML;
	var paidAmnt = Number(document.getElementById('cr_salecardpaidamtcontId').innerHTML);
	var amntToPay =Number( document.getElementById('cr_salecardamttopaycontId').innerHTML);
	var lastfourdigit = document.getElementById('cr_salecardlastfourDigit').value;
	tenderAmt=Number(tenderAmt);
	var cr_ledger_id=document.getElementById('cr_legder_id').value;
	var dr_ledger_id=document.getElementById('dr_legder_id').value;
	
	
	if(lastfourdigit == ''){
		lastfourdigit = 'xxxx';
	}
	if (!parseFloat(tenderAmt)) {
		// alert('Please enter a valid number!');
		document.getElementById('cr_salepaycardalertMsg').innerHTML = "Please enter a valid number!";
		document.getElementById('cr_salecardtenderAmt').focus();
	} /*else if (!parseFloat(lastfourdigit)) {
		// alert('Please enter a valid card number!');
		document.getElementById('cr_salepaycardalertMsg').innerHTML = "Please enter a valid card number!";
		document.getElementById('cr_salecardlastfourDigit').focus();
	} else if (lastfourdigit.length != 4) {
		// alert('Please enter 4 digit valid card number!');
		document.getElementById('cr_salepaycardalertMsg').innerHTML = "Please enter 4 digit valid card number!";
		document.getElementById('cr_salecardlastfourDigit').focus();
	}*/ else {
		if (Number(parseFloat(tenderAmt).toFixed(2)) >= Number(parseFloat(amntToPay)
				.toFixed(2))) {
			//alert("if");
			paidAmnt = parseFloat(amntToPay).toFixed(2);
			amntToPay = 0.0;			
		} else {
			//alert("else");
			paidAmnt = parseFloat(tenderAmt).toFixed(2);
			amntToPay = Number(parseFloat(amntToPay).toFixed(2))
					- Number(parseFloat(tenderAmt).toFixed(2));			
		}
		
		var paymentAdminCard = {};
		var orderCardAdmin = {};

		orderCardAdmin.id = orderno;

		paymentAdminCard.amount = billAmt;
		paymentAdminCard.paidAmount = paidAmnt;
		paymentAdminCard.amountToPay = amntToPay;
		paymentAdminCard.tenderAmount = tenderAmt;
		paymentAdminCard.paymentMode = "card";
		paymentAdminCard.cardLastFourDigits = lastfourdigit;
		paymentAdminCard.orderPayment = orderCardAdmin;
		paymentAdminCard.remarks = remarks;
		
		if (is_Acc=='Y') {
			if (cr_ledger_id<=0 || dr_ledger_id<=0) {
				document.getElementById('cr_salepaycardalertMsg').innerHTML='ledger missing !!! ';
				return;
			}else {
				document.getElementById('cr_salepaycardalertMsg').innerHTML='';
				paymentAdminCard.cr_amount=paidAmnt;
				paymentAdminCard.dr_amount=paidAmnt;
				paymentAdminCard.cr_legder_id=cr_ledger_id;
				paymentAdminCard.dr_legder_id=dr_ledger_id;
			}
		}
		$.ajax({
			url : BASE_URL + '/order/orderpaymentFromAdmin.htm',
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(paymentAdminCard),
			success : function(response, JSON_UNESCAPED_UNICODE) {

				try {
					if (response == 'success') {
						document.getElementById('creditpayremarkbycard').value = '';
						hidecr_saleCardModal();
						showalertOrderPaidModal();
					}
				} catch (e) {
					alert(e);
				}

			}
		});

	}
}

function creditPaymentDone() {
	//alert("custID:"+custID);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL
			+ "/creditsale/getcreditorderbycustid/"
			+ custID + ".htm", function(response) {
		try {
			custID=null;
			var responseObj = JSON.parse(response);
			prepareCreditOrderHtml(responseObj);
		} catch (e) {
			alert(e);
		}

	}, null);
}
function opentotcr_saleCashModal(billAmt, paidAmt) {
	
	getcustomerledger_pur('CIH',0,0,1)// for cash in hand
	document.getElementById('totcr_salecashtenderAmt').value = '';
	document.getElementById('totcr_salepaycashalertMsg').innerHTML = '';

	document.getElementById('totcr_salecashtotamtcontId').innerHTML = parseFloat(
			billAmt).toFixed(2);
	document.getElementById('totcr_salecashpaidamtcontId').innerHTML = parseFloat(
			paidAmt).toFixed(2);
	document.getElementById('totcr_salecashamttopaycontId').innerHTML = parseFloat(
			billAmt - paidAmt).toFixed(2);
	showtotcr_saleCashModal();
}
function gettotcr_saleChangeAmt(tenderAmt) {
	var amntToPay = document.getElementById('totcr_salecashamttopaycontId').innerHTML;
	// alert(tenderAmt+':'+amntToPay);
	if (tenderAmt == '') {
		document.getElementById('totcr_salecashchangeamtcontId').innerHTML = '0.00';
	} else if (parseFloat(amntToPay) >= parseFloat(tenderAmt)) {
		document.getElementById('totcr_salecashchangeamtcontId').innerHTML = '0.00';
	} else {
		document.getElementById('totcr_salecashchangeamtcontId').innerHTML = parseFloat(
				parseFloat(tenderAmt) - parseFloat(amntToPay)).toFixed(2);
	}
}
function opentotcr_saleCardModal(billAmt, paidAmt) {
	getcustomerledger_pur('CAB',0,0,3)// for bank account
	document.getElementById('totcr_salepaycardalertMsg').innerHTML = '';
	document.getElementById('totcr_salecardlastfourDigit').value = '';
	document.getElementById('totcr_salecardtotamtcontId').innerHTML = parseFloat(
			billAmt).toFixed(2);
	document.getElementById('totcr_salecardpaidamtcontId').innerHTML = parseFloat(
			paidAmt).toFixed(2);
	document.getElementById('totcr_salecardamttopaycontId').innerHTML = parseFloat(
			billAmt - paidAmt).toFixed(2);
	document.getElementById('totcr_salecardtenderAmt').value = parseFloat(
			billAmt - paidAmt).toFixed(2);
	showtotcr_saleCardModal();
}

function totcr_salepayByCash(tenderAmt) {
	//alert("totcrcash");
	var custid = document.getElementById('creditcustidContId').value;
    var remarks = document.getElementById('totcreditpayremarkbycash').value;

    var cr_ledger_id=document.getElementById('cr_legder_id').value;
    var dr_ledger_id=document.getElementById('dr_legder_id').value;
    
    //alert(remarks);
	// var
	// billAmt=document.getElementById('totcr_salecashtotamtcontId').innerHTML;
	// var
	// paidAmnt=document.getElementById('totcr_salecashpaidamtcontId').innerHTML;
	// var
	// amntToPay=document.getElementById('totcr_salecashamttopaycontId').innerHTML;
	// alert(custid+':'+tenderAmt);
	if (!parseFloat(tenderAmt)) {
		// alert('Please enter a valid number!');
		document.getElementById('totcr_salepaycashalertMsg').innerHTML = "Please enter a valid number!";
		document.getElementById('totcr_salecashtenderAmt').focus();
	} else {
		/*
		document.getElementById('totcashpaySpinner').style.display = "inline";
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/creditsale/paybulkcashbycustid/"
				+ custid + "/" + remarks + "/" + tenderAmt + ".htm", function(response) {
			try {
				var responseObj = JSON.parse(response);
				prepareCreditOrderHtml(responseObj);
				document.getElementById('totcreditpayremarkbycash').value = '';
				hidetotcr_saleCashModal();
			} catch (e) {
				alert(e);
			}

		}, null);*/

		/*
		 * var paymentString = {}; var orderString = {};
		 * 
		 * paymentString.tenderAmount = tenderAmt; orderString.customers =
		 * custid; paymentString.orderPayment = orderString;
		 * 
		 * $.ajax({
		 * 
		 * url : BASE_URL + '/creditsale/paybulkcashbycustid.htm', type :
		 * 'POST', contentType : 'application/json;charset=utf-8', data :
		 * JSON.stringify(paymentString), success : function(response,
		 * JSON_UNESCAPED_UNICODE){ try { var responseObj =
		 * JSON.parse(response); prepareCreditOrderHtml(responseObj);
		 * hidetotcr_saleCashModal(); } catch (e) { alert(e); }
		 *  } })
		 */
		
		var paymentAdmin = {};
		var order = {};

		order.customerId = custid;
		paymentAdmin.tenderAmount = tenderAmt;
		paymentAdmin.remarks = remarks;
		paymentAdmin.orderPayment = order;

		if (is_Acc=='Y') {
				if (cr_ledger_id<=0 || dr_ledger_id<=0) {
					document.getElementById('totcr_salepaycashalertMsg').innerHTML=' ledger missing !!! ';
					return;
				}else {
					document.getElementById('totcr_salepaycashalertMsg').innerHTML='';
					paymentAdmin.cr_amount=tenderAmt;
					paymentAdmin.dr_amount=tenderAmt;
					paymentAdmin.cr_legder_id=cr_ledger_id;
					paymentAdmin.dr_legder_id=dr_ledger_id;
				}
			}

		$.ajax({
			url : BASE_URL + '/creditsale/paybulkcashbycustid.htm',
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(paymentAdmin),
			success : function(response, JSON_UNESCAPED_UNICODE) {

				var responseObj = JSON.parse(response);
				prepareCreditOrderHtml(responseObj);
				document.getElementById('totcreditpayremarkbycash').value = '';
				hidetotcr_saleCashModal();
			}
		});
	}
}

function totcr_salepayByCard(tenderAmt) {
	//alert("bulkbycard");
	var custid = document.getElementById('creditcustidContId').value;
    var remarks = document.getElementById('totcreditpayremarkbycard').value;
    
    var cr_ledger_id=document.getElementById('cr_legder_id').value;
	var dr_ledger_id=document.getElementById('dr_legder_id').value;
	
	
    //alert(remarks);
	var lastfourdigit = document.getElementById('totcr_salecardlastfourDigit').value;
	if(isNaN(lastfourdigit)){
		lastfourdigit = 'xxxx';
	}
	if(lastfourdigit == ''){
		lastfourdigit = 'xxxx';
	}
	if (!parseFloat(tenderAmt)) {
		// alert('Please enter a valid number!');
		document.getElementById('totcr_salepaycardalertMsg').innerHTML = "Please enter a valid number!";
		document.getElementById('totcr_salecardtenderAmt').focus();
	} /*else if (!parseFloat(lastfourdigit)) {
		// alert('Please enter a valid card number!');
		document.getElementById('totcr_salepaycardalertMsg').innerHTML = "Please enter a valid card number!";
		document.getElementById('totcr_salecardlastfourDigit').focus();
	} else if (lastfourdigit.length != 4) {
		// alert('Please enter 4 digit valid card number!');
		document.getElementById('totcr_salepaycardalertMsg').innerHTML = "Please enter 4 digit valid card number!";
		document.getElementById('totcr_salecardlastfourDigit').focus();
	} */else {
		// alert(custid+':'+tenderAmt);
		/*document.getElementById('totcardpaySpinner').style.display = "inline";
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/creditsale/paybulkcardbycustid/"
				+ custid + "/" + tenderAmt + "/" + lastfourdigit + "/" + remarks + ".htm",
				function(response) {
					try {
						var responseObj = JSON.parse(response);
						prepareCreditOrderHtml(responseObj);
						document.getElementById('totcreditpayremarkbycard').value = '';
						hidetotcr_saleCardModal();
					} catch (e) {
						alert(e);
					}

				}, null);*/
		
		var paymentAdmin = {};
		var order = {};

		order.customerId = custid;
		paymentAdmin.tenderAmount = tenderAmt;
		paymentAdmin.remarks = remarks;
		paymentAdmin.cardLastFourDigits = lastfourdigit;
		paymentAdmin.orderPayment = order;

		
		if (is_Acc=='Y') {
			if (cr_ledger_id<=0 || dr_ledger_id<=0) {
				document.getElementById('totcr_salepaycardalertMsg').innerHTML=' ledger missing !!! ';
				return;
			}else {
				document.getElementById('totcr_salepaycardalertMsg').innerHTML='';
				paymentAdmin.cr_amount=tenderAmt;
				paymentAdmin.dr_amount=tenderAmt;
				paymentAdmin.cr_legder_id=cr_ledger_id;
				paymentAdmin.dr_legder_id=dr_ledger_id;
			}
		}
        $.ajax({
			url : BASE_URL + '/creditsale/paybulkcardbycustid.htm',
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(paymentAdmin),
			success : function(response, JSON_UNESCAPED_UNICODE) {

				var responseObj = JSON.parse(response);
				prepareCreditOrderHtml(responseObj);
				document.getElementById('totcreditpayremarkbycard').value = '';
				hidetotcr_saleCardModal();
			}
		});
				
	}
}
/* end credit sale */

function cashOrcardPrintBill() {

	var caseValue = $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();

	//alert(caseValue + '  ' + printbillpapersize);
	var order = {};
	var orderId = currentId;
	order.id = orderId;
	order.storeId = storeID;
	// alert(order.id+ " >> "+order.storeId+ ">> "+BASE_URL);
	var ajaxCallObject = new CustomBrowserXMLObject();

	if (caseValue == "Y") {
		$
				.ajax({
					type : "POST",
					url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(order),
					success : function(response) {
						var jsonObj = JSON.parse(response);
						/* ***** Store Details ***** */
						
						console.log(response);
						
						var orderNo = jsonObj.id;
						var tabNo = jsonObj.table_no;
						var customerName = jsonObj.customers.name;
						var customerAddr = jsonObj.customers.address;
						var customerPhNo = jsonObj.customers.contactNo;
						var customerEmail = jsonObj.customers.emailId;
						var orderDateWithTime = jsonObj.customers.orderTime;
						var orderTime = jsonObj.customers.time;

						var billingCustomerName = jsonObj.customerName;
						var billingCustomerAddr = jsonObj.deliveryAddress;

						var billingCustomerVatRegNo = jsonObj.custVatRegNo;

						var billingCustomerDate = new Date(jsonObj.orderDate)
								.toISOString().slice(0, 10);

						console.log(response);

						/* ***** Bill Amount Details ***** */
						var storeId = jsonObj.orderBill.storeid;
						var billAmt = jsonObj.orderBill.billAmount;
						var serviceTaxAmt = jsonObj.orderBill.serviceTaxAmt;
						var vatAmt = jsonObj.orderBill.vatAmt;
						var grossAmt = jsonObj.orderBill.grossAmt;
						var totalDiscount = jsonObj.orderBill.totalDiscount;
						var customerDiscount = jsonObj.orderBill.customerDiscount;
						var roundOffAmt = jsonObj.orderBill.roundOffAmt;
						var discPercentage = jsonObj.orderBill.discountPercentage;
						var serviceChargeAmt = jsonObj.orderBill.serviceChargeAmt;
						var subToatlAmt = jsonObj.orderBill.subTotalAmt;

						if (printbillpapersize == '58.00') {

							/* ****** Print in 58 paper size ***** */

							/* ********** START STORE INFO PRINT ********** */
							$('#storeName58').text(customerName);
							$('#storeAddr58').text(customerAddr);
							$('#storeEmail58').text(customerEmail);
							$('#storePhNo58').text(customerPhNo);
							$('#orderValue58').text(orderNo);
							$('#tableNoValue58').text(tabNo);

							for (var k = 0; k < jsonObj.orderitem.length; k++) {
								var item1 = jsonObj.orderitem[k];

								var itemName = item1.item.name;
								var itemQty = item1.quantityOfItem;
								var itemRate = item1.rate;
								var itemTotalPrice = item1.totalPriceByItem;

								// alert(" << NAME ????? "+item1.item.name + "
								// << QTY ?? "+itemQty+" << itemRate ???
								// "+itemRate+" << itemTotalPrice ???
								// "+itemTotalPrice);

								var createdrowline = "";
								var startTrline = "<tr style='padding: 1px;'>";
								var firstTdline = "<td style='padding: 1px; max-width: 50px !important; word-wrap: break-word; font-size: 10px;font-family: sans-serif;'>"
										+ itemName + "</td>";
								var secondTdline = "<td style='padding: 1px; font-size: 10px;font-family: sans-serif;'>"
										+ itemQty + "</td>";
								var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>"
										+ itemRate + "</td>";
								var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>"
										+ itemTotalPrice + "</td>";
								var endTrline = "</tr>";

								createdrowline = startTrline + firstTdline
										+ secondTdline + thirdTdline
										+ fourthTdline + endTrline;

								$("#itemDetailsPrint58").append(createdrowline);

							}

							$('#totalAmt58').text(subToatlAmt);

							if (serviceChargeAmt > 0) {
								$("#totalServiceChrg_58").show();
								$('#servChrg58').text(serviceChargeAmt);
							} else {
								$("#totalServiceChrg_58").hide();
							}

							if (serviceTaxAmt > 0.00) {
								$("#totalServiceTax_58").show();
								$('#servTax58').text(serviceTaxAmt);
							} else {
								$("#totalServiceTax_58").hide();
							}

							if (vatAmt > 0) {
								$("#totalVatTax_58").show();
								$("#vatTax58").text(vatAmt);
							} else {
								$("#totalVatTax_58").hide();
							}

							if (customerDiscount > 0) {
								$("#showDiscount_58").show();
								$("#discountValue58").text(customerDiscount);
							} else {
								$("#showDiscount_58").hide();
							}

							$("#grossAmount58").text(billAmt);
							$("#amoutToPay58").text(grossAmt);

							var paymentsObj = jsonObj.payments.length;
							if (paymentsObj == 1) {

								var paidAmt = jsonObj.payments[0].paidAmount;
								var tenderAmt = jsonObj.payments[0].tenderAmount;
								var returnAmt = tenderAmt - paidAmt;
								var type = jsonObj.payments[0].paymentMode;

								$('#paidAmount58').text(paidAmt);

								$('#tenderAmount58').text(tenderAmt);
								$('#refund_amount_58px').text(returnAmt);
								$('#payType_58').text(type);

							}
							if (paymentsObj == 2) {

								var paidAmt = jsonObj.payments[0].paidAmount
										+ jsonObj.payments[1].paidAmount;
								var tenderAmt = jsonObj.payments[0].tenderAmount
										+ jsonObj.payments[1].tenderAmount;
								var returnAmt = tenderAmt - paidAmt;
								var type1 = jsonObj.payments[0].paymentMode;
								var type2 = jsonObj.payments[1].paymentMode;

								$('#paidAmount58').text(paidAmt);
								$('#tenderAmount58').text(tenderAmt);
								$('#refundAmount58').text("0.00");
								$('#payType58').text(type1 + " + " + type2);
							}

							// $('#helloPrintModal58').modal('show');

							if (paymentsObj == 1) {
								var amt1 = jsonObj.payments[0].amount;
								var paidAmt1 = jsonObj.payments[0].paidAmount;
								if (amt1 == paidAmt1) {
									printCashOrCardLocal58();
								}
							}

							if (paymentsObj == 2) {
								var amt2 = jsonObj.payments[0].amount;
								var paidAmt2 = jsonObj.payments[0].paidAmount
										+ jsonObj.payments[1].paidAmount;
								;
								if (amt2 == paidAmt2) {
									printCashOrCardLocal58();
								}
							}

						} else if (printbillpapersize == '80.00') {
							/* ****** Print in 80 paper size ***** */

							/* ********** START STORE INFO PRINT ********** */
							$('#storeName80').text(customerName);
							$('#storeAddr80').text(customerAddr);
							$('#storeEmail80').text(customerEmail);
							$('#storePhNo80').text(customerPhNo);
							$('#cashOrdervalue80').text(orderNo);
							$('#cashtableNoValue80').text(tabNo);

							/* ********** END STORE INFO PRINT ********** */

							/* ********** START ITEM DETAILS PRINT ********** */

							for (var k = 0; k < jsonObj.orderitem.length; k++) {
								var item1 = jsonObj.orderitem[k];

								var itemName = item1.item.name;
								var itemQty = item1.quantityOfItem;
								var itemRate = item1.rate;
								var itemTotalPrice = item1.totalPriceByItem;

								// alert(" << NAME ????? "+item1.item.name + "
								// << QTY ?? "+itemQty+" << itemRate ???
								// "+itemRate+" << itemTotalPrice ???
								// "+itemTotalPrice);

								var createdrowline = "";
								var startTrline = "<tr style='padding: 2px;'>";
								var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>"
										+ itemName + "</td>";
								var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>"
										+ itemQty + "</td>";
								var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>"
										+ itemRate + "</td>";
								var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>"
										+ itemTotalPrice + "</td>";
								var endTrline = "</tr>";

								createdrowline = startTrline + firstTdline
										+ secondTdline + thirdTdline
										+ fourthTdline + endTrline;

								$("#itemDetailsPrint80").append(createdrowline);

							}

							/* ********** END ITEM DETAILS PRINT ********** */

							/* ********** START AMOUNT INFO PRINT ********** */
							// alert(" << subToatlAmt >> "+subToatlAmt+ " <<
							// serviceChargeAmt >>"+serviceChargeAmt+"<<
							// serviceTaxAmt >>"+serviceTaxAmt+" << vatAmt
							// >>"+vatAmt+"<< customerDiscount
							// >>"+customerDiscount+"<< billAmt >> "+billAmt+"<<
							// grossAmt >> "+grossAmt);
							$('#cashtotalamt80').text(subToatlAmt);

							if (serviceChargeAmt > 0) {
								$("#cashtotalServiceCharge80px").show();
								$('#cashservChrg80').text(serviceChargeAmt);
							} else {
								$("#cashtotalServiceCharge80px").hide();
							}

							if (serviceTaxAmt > 0.00) {
								$("#cashtotalServiceTax80px").show();
								$('#cashservTax80').text(serviceTaxAmt);
							} else {
								$("#cashtotalServiceTax80px").hide();
							}

							if (vatAmt > 0) {
								$("#cashtotalVatTax80px").show();
								$("#cashvatTax80px").text(vatAmt);
							} else {
								$("#cashtotalVatTax80px").hide();
							}

							if (customerDiscount > 0) {
								$("#cashshowDiscount80px").show();
								$("#cashdiscountValue80")
										.text(customerDiscount);
							} else {
								$("#cashshowDiscount80px").hide();
							}

							$("#cashgrossAmount80").text(billAmt);
							$("#cashamoutToPay80").text(grossAmt);

							var paymentsObj = jsonObj.payments.length;
							if (paymentsObj == 1) {

								var paidAmt = jsonObj.payments[0].paidAmount;
								var tenderAmt = jsonObj.payments[0].tenderAmount;
								var returnAmt = tenderAmt - paidAmt;
								var type = jsonObj.payments[0].paymentMode;

								$('#paidAmount80').text(paidAmt);
								$('#tenderAmount80').text(tenderAmt);
								$('#refundAmount80').text(returnAmt);
								$('#payType80').text(type);

							}
							if (paymentsObj == 2) {

								var paidAmt = jsonObj.payments[0].paidAmount
										+ jsonObj.payments[1].paidAmount;
								var tenderAmt = jsonObj.payments[0].tenderAmount
										+ jsonObj.payments[1].tenderAmount;
								var returnAmt = tenderAmt - paidAmt;
								var type1 = jsonObj.payments[0].paymentMode;
								var type2 = jsonObj.payments[1].paymentMode;

								$('#paidAmount80').text(paidAmt);
								$('#tenderAmount80').text(tenderAmt);
								$('#refundAmount80').text("0.00");
								$('#payType80').text(type1 + " + " + type2);
							}

							/* ********** END AMOUNT INFO PRINT ********** 	*/

							if (paymentsObj == 1) {
								var amt1 = jsonObj.payments[0].amount;
								var paidAmt1 = jsonObj.payments[0].paidAmount;
								if (amt1 == paidAmt1) {
									printCashOrCardLocal80();
								}
							}

							if (paymentsObj == 2) {

								var amt2 = jsonObj.payments[0].amount;
								var paidAmt2 = jsonObj.payments[0].paidAmount
										+ jsonObj.payments[1].paidAmount;
								;
								if (amt2 == paidAmt2) {
									printCashOrCardLocal80();
								}
							}

						} else if (printbillpapersize == '2100.00') {

								

							$('#storeName2100').text(customerName);
							$('#storeAddr2100').text(storeAddr);
							$('#storeEmail2100')
									.text("Email :" + customerEmail);
							$('#storePhNo2100').text("Ph :" + customerPhNo);
							$('#ordervalue_2100px_gst').text(orderNo);
							$('#showcustomerNameValue_2100px').text(
									billingCustomerName);
							$('#showdeliveryAddressValue_2100px').text(
									billingCustomerAddr);
							$('#showbillingCustomerVatRegNo_2100px').text(
									billingCustomerVatRegNo);
							$('#showbillingCustomerDate_2100px').text(
									billingCustomerDate);
							//$('#cashtableNoValue2100').text(tabNo);

							/* ********** END STORE INFO PRINT ********** */

							/* ********** START ITEM DETAILS PRINT ********** */

							for (var k = 0; k < jsonObj.orderitem.length; k++) {
								var item1 = jsonObj.orderitem[k];

								var itemName = item1.item.name;
								var itemQty = item1.quantityOfItem;
								var itemRate = item1.rate;
								var itemTotalPrice = item1.totalPriceByItem;

								//		alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

								var createdrowline = "";
								var startTrline = "<tr style='padding: 2px;'>";
								//								var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 14px;font-family: sans-serif;'>" + itemName + "</td>";
								//								var secondTdline = "<td style='float:right;font-size: 14px;font-family: sans-serif;padding-right:170px;text-align:center'>" + itemQty + "</td>";
								//								var thirdTdline = "<td style='font-size: 14px;font-family: sans-serif;padding-right:110px;text-align:center'>" + itemRate + "</td>";
								//								var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: center; font-size: 14px'>" + itemTotalPrice + "</td>";
								var endTrline = "</tr>";

								//createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

								var oneTdline = "<td width='5%;'>"
										+ Number(k + 1) + "</td>";

								if (item1.ordertype == '2') {

									itemName = item1.item.name + "(P)"; //itemName.substring(0,18)+"(P)..." +
								} else {
									itemName = item1.item.name + ""; //itemName.substring(0,18)+"..." +
								}
								var twoTdline = "<td width='30%;'>" + itemName
										+ "</td>";

								var itemCode = '';
								if (isNaN(item1.item.code)
										|| item1.item.code == '') {

									itemCode = '';
								} else {

									itemCode = item1.item.code;
								}
								var threeTdline = "<td>" + itemCode + "</td>";
								var extraTdline = "<td></td>";
								var fourTdline = "<td width='6%;'>"
										+ item1.quantityOfItem + "</td>";
								var fiveTdline = "<td width='6%;'>"
										+ item1.item.unit + "</td>";
								var sixTdline = "<td width='5%;'>"
										+ parseFloat(item1.item.price).toFixed(
												2) + "</td>";

								var totalPrice = 0.00;
								var totalTaxAmt = 0.00;
								var totalRate = 0.00;
								var totalServiceTax = 0.00;
								var totalAmt = 0.00;

								var discount = 0.00;

								if (item1.item.promotionFlag == 'Y') {
									totalPrice = parseFloat(
											(item1.item.price - item1.item.price
													* item1.item.promotionValue
													/ 100)
													* item1.quantityOfItem)
											.toFixed(2);
									if (isNaN(item1.discount)
											|| item1.discount == '') {

										discount = 0.00;
									} else {

										discount = Number(item1.discount);
									}
									totalTaxAmt = parseFloat(
											((item1.item.price - item1.item.price
													* item1.item.promotionValue
													/ 100) * item1.quantityOfItem)
													- discount).toFixed(2);
									totalRate = parseFloat(
											((((item1.item.price - item1.item.price
													* item1.item.promotionValue
													/ 100) * item1.quantityOfItem) - discount) * item1.vat) / 100)
											.toFixed(2);
									totalServiceTax = parseFloat(
											((((item1.item.price - item1.item.price
													* item1.item.promotionValue
													/ 100) * item1.quantityOfItem) - discount) * item1.serviceTax) / 100)
											.toFixed(2);
									totalAmt = parseFloat(
											(((((item1.item.price - item1.item.price
													* item1.item.promotionValue
													/ 100) * item1.quantityOfItem) - discount) * item1.vat) / 100)
													+ (((((item1.item.price - item1.item.price
															* item1.item.promotionValue
															/ 100) * item1.quantityOfItem) - discount) * item1.serviceTax) / 100))
											.toFixed(2);
								}
								if (item1.item.promotionFlag == 'N') {
									totalPrice = parseFloat(
											item1.quantityOfItem
													* item1.item.price)
											.toFixed(2);
									if (isNaN(item1.discount)
											|| item1.discount == '') {

										discount = 0.00;
									} else {

										discount = Number(item1.discount);
									}
									totalTaxAmt = parseFloat(
											(item1.quantityOfItem * item1.item.price)
													- discount).toFixed(2);
									totalRate = parseFloat(
											(((item1.quantityOfItem * item1.item.price) - discount) * item1.vat) / 100)
											.toFixed(2);
									totalServiceTax = parseFloat(
											(((item1.quantityOfItem * item1.item.price) - discount) * item1.serviceTax) / 100)
											.toFixed(2);
									totalAmt = parseFloat(
											((((item1.quantityOfItem * item1.item.price) - discount) * item1.vat) / 100)
													+ ((((item1.quantityOfItem * item1.item.price) - discount) * item1.serviceTax) / 100))
											.toFixed(2);
								}

								var sevenTdline = "<td width='5%;'>"
										+ totalPrice + "</td>";
								var eightTdline = "<td width='5%;' id='tbl_orderItemDisc'>"
										+ discount + "</td>";
								var nineTdline = "<td width='10%;' id='tbl_orderItemTaxAmt'>"
										+ totalTaxAmt + "</td>";
								var tenTdline = "<td width='5%;'>" + item1.vat
										+ "</td>";
								var eleventdline = "<td width='10%;'>"
										+ totalRate + "</td>";
								var twelveTdline = "<td width='5%;'>"
										+ item1.serviceTax + "</td>";
								var thirteenTdline = "<td width='10%;'>"
										+ totalServiceTax + "</td>";
								var fourteenTdline = "<td width='5%;'>"
										+ Number(item1.vat + item1.serviceTax)
										+ "</td>";
								var fifteenTdline = "<td width='10%;'>"
										+ totalAmt + "</td>";

								createdrowline = startTrline + oneTdline
										+ twoTdline + threeTdline + extraTdline
										+ fourTdline + fiveTdline + sixTdline
										+ sevenTdline + eightTdline
										+ nineTdline + tenTdline + eleventdline
										+ twelveTdline + thirteenTdline
										+ fourteenTdline + fifteenTdline
										+ endTrline;

								$("#itemDetailsPrint2100").append(
										createdrowline);

							}

							/* ********** END ITEM DETAILS PRINT ********** */

							/* ********** START AMOUNT INFO PRINT ********** */

							$('#cashtotalamt2100').text(subToatlAmt);

							if (serviceChargeAmt > 0) {
								$("#cashtotalServiceCharge2100px").show();
								$('#cashservChrg2100').text(serviceChargeAmt);
							} else {
								$("#cashtotalServiceCharge2100px").hide();
							}

							if (serviceTaxAmt > 0.00) {
								$("#cashtotalServiceTax2100px").show();
								$('#cashservTax2100').text(serviceTaxAmt);
							} else {
								$("#cashtotalServiceTax2100px").hide();
							}

							if (vatAmt > 0) {
								$("#cashtotalVatTax2100px").show();
								$("#cashvatTax2100px").text(vatAmt);
							} else {
								$("#cashtotalVatTax2100px").hide();
							}

							if (customerDiscount > 0) {
								$("#cashshowDiscount2100px").show();
								$("#cashdiscountValue2100").text(
										customerDiscount);
							} else {
								$("#cashshowDiscount2100px").hide();
							}

							$("#cashgrossAmount2100").text(billAmt);
							$("#cashamoutToPay2100").text(grossAmt);

							var paymentsObj = jsonObj.payments.length;
							
							//alert("paymentsObj >>  "+paymentsObj);
							
							if (paymentsObj == 1) {

								var paidAmt = jsonObj.payments[0].paidAmount;
								var tenderAmt = jsonObj.payments[0].tenderAmount;
								var returnAmt = tenderAmt - paidAmt;
								var type = jsonObj.payments[0].paymentMode;

								//	alert("<< paidAmt >> "+paidAmt+ "<< tenderAmt >> "+tenderAmt+ "<< returnAmt >> "+returnAmt);	

								$('#paidAmount2100').text(paidAmt);
								$('#tenderAmount2100').text(tenderAmt);
								$('#refundAmount2100').text(
										Math.floor(returnAmt * 100) / 100);
								$('#payType2100').text("Paid By " + type);

							}
							if (paymentsObj == 2) {

								var paidAmt = jsonObj.payments[0].paidAmount
										+ jsonObj.payments[1].paidAmount;
								var tenderAmt = jsonObj.payments[0].tenderAmount
										+ jsonObj.payments[1].tenderAmount;
								var returnAmt = tenderAmt - paidAmt;
								var type1 = jsonObj.payments[0].paymentMode;
								var type2 = jsonObj.payments[1].paymentMode;

								$('#paidAmount2100').text(paidAmt);
								$('#tenderAmount2100').text(tenderAmt);
								$('#refundAmount2100').text("0.00");
								$('#payType2100').text(
										"Paid By " + type1 + " + " + type2);
							}

							/* ********** END AMOUNT INFO PRINT ********** */

							if (paymentsObj == 1) {
								var amt1 = jsonObj.payments[0].amount;
								var paidAmt1 = jsonObj.payments[0].paidAmount;
								if (amt1 == paidAmt1) {
									printCashOrCardLocal2100();
								}
							}

							if (paymentsObj == 2) {

								var amt2 = jsonObj.payments[0].amount;
								var paidAmt2 = jsonObj.payments[0].paidAmount
										+ jsonObj.payments[1].paidAmount;

								if (amt2 == paidAmt2) {
									printCashOrCardLocal2100();
								}
							}

						}

					}
				});

	} else {
		var orderid = document.getElementById('orderNo').value;

		//alert(orderid);
		// var tableno=document.getElementById('tablenoCont').innerHTML;
		if (orderid == 0 || forspNoteData.length > 0) {
			// alert('Please save the order first!');
			showalertsaveorderModal();
		} else {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/printbill/" + orderid
					+ ".htm", function(response) {
				try {
					if (response == 'Success')
						showBillPrintSuccessModal();

				} catch (e) {
					alert(e);
				}
			}, null);
		}
	}

}

//function printCashOrCardLocal2100() {
//	// $('#printDiv2100').modal('show');
//	var divToPrint = document.getElementById('printDiv2100_GST');
//	document.getElementById('cashRemovePrint2100').style.display = 'none';
//	newWin = window.open("");
//	newWin.document.write(divToPrint.outerHTML);
//	newWin.document.close();
//	newWin.focus();
//	newWin.print();
//	document.getElementById('cashRemovePrint2100').style.display = 'block';
//
//	newWin.close();
//	// location.href = BASE_URL + '/table/viewtable.htm';
//
//}
function printCashOrCardLocal2100() {
	 // $('#printDiv2100GST').modal('show');
	 //var divToPrint = document.getElementById('printDiv2100');
	 var divToPrint = document.getElementById('printDiv2100GST');
	 //document.getElementById('cashRemovePrint2100').style.display = 'none';
	 newWin = window.open("");
	 newWin.document.write(divToPrint.outerHTML);
	 //newWin.document.close();
	 newWin.focus();
	 newWin.print();
	 //document.getElementById('cashRemovePrint2100').style.display = 'block';
	 
	 newWin.close();
	// location.href = BASE_URL + '/table/viewtable.htm';
	 //location.href = '#';
	}
//function printCashOrCardLocal2100() {
//	// $('#printDiv2100').modal('show');
//	//alert('printCashOrCardLocal2100');
//	var divToPrint = document.getElementById('printDiv2100_GST');
//	document.getElementById('cashRemovePrint2100').style.display = 'none';
//	newWin = window.open("");
//	newWin.document.write(divToPrint.outerHTML);
//	newWin.document.close();
//	newWin.focus();
//	newWin.print();
//	document.getElementById('cashRemovePrint2100').style.display = 'block';
//
//	newWin.close();
//	// location.href = BASE_URL + '/table/viewtable.htm';
//
//}


/* ============== Convert number to Word in currency ========================*/

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
/* ===================== End */


function addDeliveryBoy()
{
	document.getElementById('adddelboyalertMsg').innerHTML = '';
	var name = decodeURIComponent(document.getElementById('adddelboyname').value);
	var phone = decodeURIComponent(document.getElementById('adddelboyphone').value);
	var email = decodeURIComponent(document.getElementById('adddelboyemail').value);
	var uniqueId = document.getElementById('adddelboyuniqueid').value;
	var address = decodeURIComponent(document.getElementById('adddelboyaddress').value);
	var dob = document.getElementById('adddelboydob').value;
	var doj = decodeURIComponent(document.getElementById('adddelboydoj').value);
	
	if (name == '') {
		document.getElementById('adddelboyalertMsg').innerHTML = getLang.reqName;
	}  else if (phone == '' || isNaN(phone)) {
		document.getElementById('adddelboyalertMsg').innerHTML = getLang.plsEnterCorctCtNo;
	} else if ((/[#%?\/\\]/gi).test(name) ||  (/[#%?\/\\]/gi).test(address)) {
		document.getElementById('adddelboyalertMsg').innerHTML = getLang.charNotAlowd;
	} else {

		var deliveryboyPost = {};
		deliveryboyPost.name = name;
		deliveryboyPost.phone_no = phone;
		deliveryboyPost.email = email;
		deliveryboyPost.uniqueId = uniqueId;
		deliveryboyPost.address = address;
		deliveryboyPost.store_id = storeID;
		deliveryboyPost.DOB = dob;
		deliveryboyPost.DOJ = doj;

		$.ajax({
					url : BASE_URL + "/deliveryboy/adddelboymgnt.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(deliveryboyPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						if (response === 'success') {
							closedeliveryboyaddModal();
							document.getElementById('deliveryboydataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertdeliveryboydataopModal();
						} else {
							document.getElementById('deliveryboydataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertdeliveryboydataopModal();
						}
					}
				});
	}
}

function cancelDeliveryBoy()
{

	document.getElementById('adddelboyalertMsg').innerHTML = '';
	document.getElementById('adddelboyname').value = '';
	document.getElementById('adddelboyphone').value = '';
	document.getElementById('adddelboyemail').value = '';
	document.getElementById('adddelboyuniqueid').value = '';
	document.getElementById('adddelboyaddress').value = '';
	document.getElementById('adddelboydob').value = '';
	document.getElementById('adddelboydoj').value = '';
}

function editDeliveryBoy()
{
	document.getElementById('editdelboyalertMsg').innerHTML = '';
	var id = decodeURIComponent(document.getElementById('editdelboyidContId').value);
	var name = decodeURIComponent(document.getElementById('editdelboyname').value);
	var phone = decodeURIComponent(document.getElementById('editdelboyphone').value);
	var email = decodeURIComponent(document.getElementById('editdelboyemail').value);
	var uniqueId = document.getElementById('editdelboyuniqueid').value;
	var address = decodeURIComponent(document.getElementById('editdelboyaddress').value);
	var dob = document.getElementById('editdelboydob').value;
	var doj = decodeURIComponent(document.getElementById('editdelboydoj').value);
	

	if (name == '') {
		document.getElementById('editdelboyalertMsg').innerHTML = getLang.reqName;
	}  else if (phone == '' || isNaN(phone)) {
		document.getElementById('editdelboyalertMsg').innerHTML = getLang.plsEnterCorctCtNo;
	} else if ((/[#%?\/\\]/gi).test(name) ||  (/[#%?\/\\]/gi).test(address)) {
		document.getElementById('editdelboyalertMsg').innerHTML = getLang.charNotAlowd;
	} else {

		var deliveryboyeditPost = {};
		deliveryboyeditPost.id = id;
		deliveryboyeditPost.name = name;
		deliveryboyeditPost.phone_no = phone;
		deliveryboyeditPost.email = email;
		deliveryboyeditPost.uniqueId = uniqueId;
		deliveryboyeditPost.address = address;
		deliveryboyeditPost.store_id = storeID;
		deliveryboyeditPost.DOB = dob;
		deliveryboyeditPost.DOJ = doj;

		//console.log('hello-edit'+name+phone+email+uniqueId+address+storeID+dob+doj+JSON.stringify(deliveryboyeditPost));
		
		$.ajax({
			url : BASE_URL + "/deliveryboy/editdelboymgnt.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(deliveryboyeditPost),
			success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						if (response === 'success') {
							closedeliveryboyeditModal();
							document.getElementById('deliveryboydataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertdeliveryboydataopModal();
						} else {
							document.getElementById('deliveryboydataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertdeliveryboydataopModal();
						}
					}
				});
	}
}

function deleteDeliveryBoy()
{
	document.getElementById('adddelboyalertMsg').innerHTML = '';
	var id = decodeURIComponent(document.getElementById('moddeleteconfirmdelboyidContId').value);

	if (id == '' || id==0) {
		document.getElementById('addvendoralertMsg').innerHTML = "Select a Delvery Boy First !!";
	}  else {
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
				.callAjax(
						BASE_URL + "/deliveryboy/deletedelboy/" + id + ".htm",
						function(response) {
							if (response == 'success') {
								closedeliveryboydeleteModal();
								document.getElementById('deliveryboydataopmassagecont').innerHTML = getLang.datasucDelete;
								showalertdeliveryboydataopModal();
							} else {
								document.getElementById('deliveryboydataopmassagecont').innerHTML = getLang.datasucNotDelete;
								showalertdeliveryboydataopModal();
							}
						}, null);
	}
}




/*start vendor payment added 2/5/2018 */

function getcreditInvinvoiceByvendorId(id,name,contact)
{
	//alert(id+':'+name+':'+contact);
	 getvendorledger_pur('SCR',0,id,2);// for creditor
	console.log("id="+id);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/vendormgnt/getvendorpaymentinfobyid/" + id +".htm", function(response) {
		try{
			console.log("response="+response);
			var responseObj=JSON.parse(response);
			prepareCreditVendorPaymentHtml(responseObj);
		}catch(e)
		{
			alert(e);
		}
		
	}, null);
	document.getElementById('creditvendornameContId').innerHTML=name;
	document.getElementById('creditvendorcontactContId').innerHTML=contact;
	document.getElementById('creditvendoridContId').value=id;  
}
function prepareCreditVendorPaymentHtml(responseData)
{
	var creditvendorcontainerId=document.getElementById('creditinvinvoicetableContId');
	var starttable="<table class='table table-striped table-bordered table-hover'>"+
    				"<thead style='background:#404040; color:#FFF;'><th style='text-align:center;'>INVOICE NO</th><th style='text-align:center;'>DATE</th><th style='text-align:center;'>BILL AMT</th><th style='text-align:center;'>PAID AMT</th><th style='text-align:center;display:none;'>RET AMT</th><th style='text-align:center;'>DUE AMT</th><th style='text-align:center;'>PAY</th>"+
    				"</thead>";
    				"<tbody >";
    var endtable="</tbody></table>";
    var createdrowline="";
    var generatedHtml = "";
    var totBillAmt=0.0;
    var totAmttoPay=0.0;
    var totPaidAmt=0.0;
    var totRetAmt=0.0;
    if(responseData.length>0)
    	{
    	for(var i=0;i<responseData.length;i++)
    		{
    		
    		var creditinvinvoice=responseData[i];
    		var begintr="<tr style='background:#404040; color:#FFF;'>";
    		var firsttd="<td align='center'>"+creditinvinvoice.stockInId+"</td>";
    		var secondtd="<td align='center'>"+creditinvinvoice.stockInDate +"</td>";
    		var thirdtd="<td align='center'>"+parseFloat(creditinvinvoice.billAmount).toFixed(2)+"</td>";
    		//var thirdtd1="<td align='center'>"+parseFloat(creditOrder.orderBill.customerDiscount).toFixed(2)+"</td>";
    		var fourthtd="<td align='center'>"+parseFloat(creditinvinvoice.paidAmount).toFixed(2)+"</td>";
    		var fourthtd1="<td align='center' style='display:none;'>"+parseFloat(creditinvinvoice.returnAmount).toFixed(2)+"</td>";
    		var fifthtd="<td align='center'>"+parseFloat(creditinvinvoice.amountToPay).toFixed(2)+"</td>";
    		var sixthtd="<td align='center'><a href='javascript:opencr_vendorCashModal("+creditinvinvoice.stockInId+","+creditinvinvoice.poId+",&quot;"+creditinvinvoice.stockInDate+"&quot;,"+creditinvinvoice.billAmount+","+creditinvinvoice.paidAmount+","+creditinvinvoice.amountToPay+")' class='btn btn-success'>PAY</a></td>";
    		var endtr="</tr>";
    		createdrowline+=begintr+firsttd+secondtd+thirdtd+fourthtd+fourthtd1+fifthtd+sixthtd+endtr;
    		totBillAmt+=creditinvinvoice.billAmount;
    		totAmttoPay+=creditinvinvoice.amountToPay;
    		totPaidAmt+=creditinvinvoice.paidAmount;
    		totRetAmt+=creditinvinvoice.returnAmount;
    		}
    	if(responseData.length>1)
    	{
    		var begintottr="<tr style='background:#e2e2e2; color:#222222;'>";
    		var totaltd="<td colspan='2' align='center'>TOTAL</td>";
    		var totalbilltd="<td align='center'>"+parseFloat(totBillAmt).toFixed(2)+"</td>";
    		//var totaldisctd="<td align='center'>"+parseFloat(totDiscAmt).toFixed(2)+"</td>";
    		var totalpaidtd="<td align='center'>"+parseFloat(totPaidAmt).toFixed(2)+"</td>";
    		var totalrettd="<td align='center' style='display:none;'>"+parseFloat(totRetAmt).toFixed(2)+"</td>";
    		var totalduetd="<td align='center'>"+parseFloat(totAmttoPay).toFixed(2)+"</td>";
    		var totalpaytd="<td align='center'><a href='javascript:opentotcr_vendorCashModal("+totBillAmt+","+totPaidAmt+","+totAmttoPay+")' class='btn btn-success'>PAY</a></td>";
    		var endtottr="</tr>";
    		createdrowline+=begintottr+totaltd+totalbilltd+totalpaidtd+totalrettd+totalduetd+totalpaytd+endtottr;
    	}
    	}
    else
    	{
    	var begintr="<tr style='background:#404040; color:#FFF;'>";
    	var firsttd="<td colspan='7'>No Data found!</td>";
    	var endtr="</tr>";
    	createdrowline+=begintr+firsttd+endtr;
    	}
    generatedHtml=starttable+createdrowline+endtable;
    creditvendorcontainerId.innerHTML=generatedHtml;
}
function opencr_vendorCashModal(invoiceno,poNo,invoiceDate,billAmt,paidAmt,amttoPay)
{
	document.getElementById('cr_vendorcashtenderAmt').value='';
	document.getElementById('cr_vendorpaycashalertMsg').innerHTML='';
	document.getElementById('cr_vendorcashmodNameCont').innerHTML=document.getElementById('creditvendornameContId').innerHTML;
	document.getElementById('cr_vendorcashmodInvoiceNoCont').innerHTML=invoiceno;
	document.getElementById('cr_vendorcashmodPoNoCont').value=poNo;
	document.getElementById('cr_vendorcashmodInvoiceDateCont').value=invoiceDate;
	document.getElementById('cr_vendorcashtotamtcontId').innerHTML=parseFloat(billAmt).toFixed(2);
	//document.getElementById('cr_salecashdiscamtcontId').innerHTML=parseFloat(discAmt).toFixed(2);
	document.getElementById('cr_vendorcashpaidamtcontId').innerHTML=parseFloat(paidAmt).toFixed(2);
	document.getElementById('cr_vendorcashamttopaycontId').innerHTML=parseFloat(amttoPay).toFixed(2);
	showcr_vendorCashModal();
}
function getcr_vendorChangeAmt(tenderAmt)
{
	var amntToPay=document.getElementById('cr_vendorcashamttopaycontId').innerHTML;
	//alert(tenderAmt+':'+amntToPay);
	if(tenderAmt=='')
		{
		document.getElementById('cr_vendorcashchangeamtcontId').innerHTML='0.00';
		}
	else if(parseFloat(amntToPay)>=parseFloat(tenderAmt))
		{
			document.getElementById('cr_vendorcashchangeamtcontId').innerHTML='0.00';
		}
	else
		{
			document.getElementById('cr_vendorcashchangeamtcontId').innerHTML=parseFloat(parseFloat(tenderAmt)-parseFloat(amntToPay)).toFixed(2);
		}
}
function cr_vendorpayByCash(tenderAmt)
{
	var vendorid=document.getElementById('creditvendoridContId').value;
	var invoiceno=document.getElementById('cr_vendorcashmodInvoiceNoCont').innerHTML;
	var poNo=document.getElementById('cr_vendorcashmodPoNoCont').value;
	var invoiceDate=document.getElementById('cr_vendorcashmodInvoiceDateCont').value;
	var billAmt=document.getElementById('cr_vendorcashtotamtcontId').innerHTML;
	//var discAmt=document.getElementById('cr_salecashdiscamtcontId').innerHTML;
	var paidAmnt=document.getElementById('cr_vendorcashpaidamtcontId').innerHTML;
	var amntToPay=document.getElementById('cr_vendorcashamttopaycontId').innerHTML;
	
	var cr_ledger_id=document.getElementById('cr_legder_id').value;
	var dr_ledger_id=document.getElementById('dr_legder_id').value;
	
	
	if (is_Acc=='Y') {
		if (cr_ledger_id<=0 || dr_ledger_id<=0) {
			document.getElementById('cr_vendorpaycashalertMsg').innerHTML='Creditor ledger missing !!! ';
			return;
		}else {
			document.getElementById('cr_vendorpaycashalertMsg').innerHTML='';
		}
	}

	
	if (!parseFloat(tenderAmt))
	{
	//alert('Please eneter a valid number!');
	document.getElementById('cr_vendorpaycashalertMsg').innerHTML='Please eneter a valid number!';
	document.getElementById('cr_vendorcashtenderAmt').focus();
	
	}
	else
	{
		dsblSinglepaybtnButton();
		if(parseFloat(tenderAmt)>=parseFloat(amntToPay))
		{
			paidAmnt=parseFloat(amntToPay);
			amntToPay=0.0;
		}
		else
		{
			paidAmnt=parseFloat(tenderAmt);
			amntToPay=(parseFloat(amntToPay)-parseFloat(tenderAmt)).toFixed(2);
		}
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/vendormgnt/vendorpayment/"+invoiceno +"/"+ poNo+"/"+ invoiceDate+"/"+ vendorid+"/"+ billAmt+"/"+ paidAmnt+"/"+ amntToPay + "/"+cr_ledger_id+ "/"+dr_ledger_id+".htm", function(response) {
			try{
				if(response=='success')
					{
					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/vendormgnt/getvendorpaymentinfobyid/" + vendorid +".htm", function(response) {
						try{
							var responseObj=JSON.parse(response);
							prepareCreditVendorPaymentHtml(responseObj);
						}catch(e)
						{
							alert(e);
						}

					}, null);
					enblSinglepaybtnButton();
					hidecr_vendorCashModal();
					}
				}catch(e){alert(e);}
			}, null);
	}
}

function dsblSinglepaybtnButton(){
	 document.getElementById('singlepaybtn').style.backgroundColor="#F00";
	 document.getElementById('singlepaybtn').disabled = true; 
	}

function enblSinglepaybtnButton(){
	 document.getElementById('singlepaybtn').style.backgroundColor="#72BB4F";
	 document.getElementById('singlepaybtn').disabled = false; 
	}


function opentotcr_vendorCashModal(billAmt,paidAmt,amttoPay)
{
	document.getElementById('totcr_vendorcashtenderAmt').value='';
	document.getElementById('totcr_vendorpaycashalertMsg').innerHTML='';
	document.getElementById('totvendorcashpaySpinner').style.display="none";
	document.getElementById('totcr_vendorcashtotamtcontId').innerHTML=parseFloat(billAmt).toFixed(2);
	document.getElementById('totcr_vendorcashpaidamtcontId').innerHTML=parseFloat(paidAmt).toFixed(2);
	document.getElementById('totcr_vendorcashamttopaycontId').innerHTML=parseFloat(amttoPay).toFixed(2);
	showtotcr_vendorCashModal();
}
function gettotcr_vendorChangeAmt(tenderAmt)
{
	var amntToPay=document.getElementById('totcr_vendorcashamttopaycontId').innerHTML;
	//alert(tenderAmt+':'+amntToPay);
	if(tenderAmt=='')
		{
		document.getElementById('totcr_vendorcashchangeamtcontId').innerHTML='0.00';
		}
	else if(parseFloat(amntToPay)>=parseFloat(tenderAmt))
		{
			document.getElementById('totcr_vendorcashchangeamtcontId').innerHTML='0.00';
		}
	else
		{
			document.getElementById('totcr_vendorcashchangeamtcontId').innerHTML=parseFloat(parseFloat(tenderAmt)-parseFloat(amntToPay)).toFixed(2);
		}
}
function totcr_vendorpayByCash(tenderAmt)
{
	var vendorid=document.getElementById('creditvendoridContId').value;
	var cr_ledger_id=document.getElementById('cr_legder_id').value;
	var dr_ledger_id=document.getElementById('dr_legder_id').value;
	//var billAmt=document.getElementById('totcr_salecashtotamtcontId').innerHTML;
	//var paidAmnt=document.getElementById('totcr_salecashpaidamtcontId').innerHTML;
	//var amntToPay=document.getElementById('totcr_salecashamttopaycontId').innerHTML;
	//alert(custid+':'+tenderAmt);
	

	if (is_Acc=='Y') {
		if (cr_ledger_id<=0 || dr_ledger_id<=0) {
			document.getElementById('totcr_vendorpaycashalertMsg').innerHTML='Creditor ledger missing !!! ';
			return;
		}else {
			document.getElementById('totcr_vendorpaycashalertMsg').innerHTML='';
		}
	}

	
	if (!parseFloat(tenderAmt))
	{
	//alert('Please eneter a valid number!');
	document.getElementById('totcr_vendorpaycashalertMsg').innerHTML='Please eneter a valid number!';
	document.getElementById('totcr_vendorcashtenderAmt').focus();
	}
	else
	{
		dsblTotalpaybtnButton();
		document.getElementById('totvendorcashpaySpinner').style.display="inline";
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/vendormgnt/payvendorbulkcashbycustid/" + vendorid +"/"+tenderAmt+"/"+cr_ledger_id+"/"+dr_ledger_id+".htm", function(response) {
			try{
				var responseObj=JSON.parse(response);
				prepareCreditVendorPaymentHtml(responseObj);
				enblTotalpaybtnButton();
				hidetotcr_vendorCashModal();
			}catch(e)
			{
				alert(e);
			}
			
		}, null);
	
	}
}

function dsblTotalpaybtnButton(){
	 document.getElementById('totalpaybtn').style.backgroundColor="#F00";
	 document.getElementById('totalpaybtn').disabled = true; 
	}

function enblTotalpaybtnButton(){
	 document.getElementById('totalpaybtn').style.backgroundColor="#72BB4F";
	 document.getElementById('totalpaybtn').disabled = false; 
	}

/*end vendor payment*/


function numcheck(e) {
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
        (e.keyCode >= 35 && e.keyCode <= 40)) {  
        return;
    }
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
    }
}
function round(value, places) {
	var factor = Math.pow(10, places);
	value = parseFloat(value).toFixed(2);
	value = value * factor;
	var tmp = value;
	var mod = value % 1;
	if (mod != 0.5) {
		tmp = Math.round(value);
	}
	// var tmp = Math.round(value);
	return tmp / factor;
}



/*
 * for search ledger
 */

function getvendorledger_pur(group_code,acc_id,ref_id,para)
{

	/*
	 * 	commonobj.id=1; is call another procedure
	 */
	var commonobj={};

	if (para==1) { // for cash account

		commonobj.groupCode=group_code;
		commonobj.accountID=0;
		commonobj.referenceID=0;
		commonobj.id=1;

	}

	if (para==2) { // for credior

			commonobj.groupCode=group_code;
			commonobj.accountID=0;
			commonobj.referenceID=ref_id;
			commonobj.id=1;
		}

//$('#pleasewaitModal').modal('show');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjaxPost(BASE_URL + "/accntsetup/searchledgerusinggroup.htm", commonobj, function(response) {


		var status = JSON.parse(response);

		if (para==1) {// for cash in hand
			console.log("cash in hand ");

			$.each(status, function(i) {


				 $('#cr_legder_id').val(status[i].id);

			});
		}




		if (para==2) {// for credior
			console.log(" for credior ");

			if (status.length>0) {
				$.each(status, function(i) {
					$('#dr_legder_id').val(status[i].id);

			});
			}else {
				$('#dr_legder_id').val(0);
			}

		}





	//	$('#pleasewaitModal').modal('hide');
		//chngeResultStat(status);
	});

}



/*
 * for search ledger customerpayment
 */

function getcustomerledger_pur(group_code,acc_id,ref_id,para)
{
   
	/*
	 * 	commonobj.id=1; is call another procedure
	 */
	var commonobj={};

	if (para==1) { // for cash account

		commonobj.groupCode=group_code;
		commonobj.accountID=0;
		commonobj.referenceID=0;
		commonobj.id=1;

	}

	if (para==2) { // for customer

			commonobj.groupCode=group_code;
			commonobj.accountID=0;
			commonobj.referenceID=ref_id;
			commonobj.id=1;
		}



	if (para==3) { // for  bank account

		commonobj.groupCode=group_code;
		commonobj.accountID=0;
		commonobj.referenceID=0;
		commonobj.id=1;

	}

//$('#pleasewaitModal').modal('show');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjaxPost(BASE_URL + "/accntsetup/searchledgerusinggroup.htm", commonobj, function(response) {


		var status = JSON.parse(response);

		if (para==1) {// for cash in hand
			console.log("cash in hand ");

			$.each(status, function(i) {


				 $('#dr_legder_id').val(status[i].id);

			});
		}




		if (para==2) {// for debitor
			console.log(" for debitor ");

			if (status.length>0) {
				$.each(status, function(i) {
					$('#cr_legder_id').val(status[i].id);


			});
			}else {
				$('#cr_legder_id').val(0);
			}

		}

		if (para==3) {// for bank account
			console.log("for bank account");

			$.each(status, function(i) {


				 $('#dr_legder_id').val(status[i].id);

			});
		}




	//	$('#pleasewaitModal').modal('hide');
		//chngeResultStat(status);
	});

}




function getledgerupain_from_admin_sal(group_code,acc_id,ref_id,para)
{
	 //var keyword=ref_id.toString();
	//  var trackname=keyword.split("_");
	/*
	 * 	commonobj.id=1; is call another procedure
	 */


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

				 //$('#round_html1').html(status[i].name);
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



		//	 $('#card_html1').html("Dr-"+status[i].name );
			 $('#card_ledger_idf').val(status[i].id);

		});
		 }


	if (para==7) {// for  service charge
		console.log(" for  service charge ");
		$.each(status, function(i) {

			//	 $('#card_html1').html("Dr-"+status[i].name );
			 $('#service_charge_ledger_idf').val(status[i].id);

		});
		 }

		//chngeResultStat(status);
	});

}



function printCashOrCardLocal58() {

	var divToPrint = document.getElementById('printDiv58');
	document.getElementById('removePrint58').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('removePrint58').style.display = 'block';

	newWin.close();
	// location.href = BASE_URL + '/table/viewtable.htm';
}
function printCashOrCardLocal80() {
   //alert("printCashOrCardLocal80");
	//console.log("print bill");
	var divToPrint = document.getElementById('printDiv80');
	document.getElementById('cashRemovePrint80').style.display = 'none';
	newWin = window.open("");
	//alert('hello1');
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	
	document.getElementById('cashRemovePrint80').style.display = 'block';
    
	newWin.close();
	//console.log("print bill end");
	// location.href = BASE_URL + '/table/viewtable.htm';
}


