/**
 * 
 */


/*function selectOrder(orderid, chk) {
	if (chk.checked) {
		selectedorder.push(orderid);
	} else {
		selectedorder.splice(selectedorder.indexOf(orderid), 1);
	}
}*/

function accessCardPaymentDiv(chk){
	if (chk.checked) {
		 $("#cardpaymentdiv").show();
	} else {
		 $("#cardpaymentdiv").hide();
	}	
  }



var selectedorder = [];
function bulkPay(storeid){
	selectedorder = [];
	var totalamt = 0;
	var v=document.getElementsByName("check_box");
 	for(var i=0;i<v.length;i++)
 		{
 		if(v[i].checked)
 			{
 			selectedorder.push(v[i].value);
 			}
 		}
	
	 if(selectedorder.length == 0){
		 $('#bulkPayAlertModal').modal('show');
		 
		}
	 else{
		  
			for(var j=0;j<selectedorder.length;j++){
				var amt= $('.amttopaycontId_'+selectedorder[j]).html();
				totalamt =parseFloat(Number(totalamt) + Number(amt)).toFixed(2);
			   }
		 
		 document.getElementById('bulk_payment_total_amt_to_pay').innerHTML=totalamt;
		 document.getElementById('bulkpay_salecashtenderAmt').value="";
		 document.getElementById('bulkpay_salecashchangeamtcontId').innerHTML="0.00";
		 document.getElementById('bulk_payalertMsg').innerHTML="";
		 $("#CardPayment").prop("checked", false);
		 $("#cardpaymentdiv").hide();
		 $('#bulkPayModal').modal('show');
	 }
	 
	
	
}



function bulkpay_saleChangeAmt(tenderAmt) {
	var amntToPay = document.getElementById('bulk_payment_total_amt_to_pay').innerHTML;
	if (tenderAmt == '') {
		document.getElementById('bulkpay_salecashchangeamtcontId').innerHTML = '0.00';
	} else if (parseFloat(amntToPay) >= parseFloat(tenderAmt)) {
		document.getElementById('bulkpay_salecashchangeamtcontId').innerHTML = '0.00';
	} else {
		document.getElementById('bulkpay_salecashchangeamtcontId').innerHTML = parseFloat(
				parseFloat(tenderAmt) - parseFloat(amntToPay)).toFixed(2);
	}
}










function bulk_payment(paymentmode){
	//alert(paymentmode);
	var totalAmntToPay = document.getElementById('bulk_payment_total_amt_to_pay').innerHTML;
	var totalTenderAmt = document.getElementById('bulkpay_salecashtenderAmt').value;
	if(Number(totalAmntToPay) > Number(totalTenderAmt)){
		document.getElementById('bulk_payalertMsg').innerHTML = 'Please enter proper tender amount to pay';
	}
	
	else{
		
		for(var i=0;i<selectedorder.length;i++){
			
		    var payableamount  = $('.amttopaycontId_'+selectedorder[i]).html();  // total payable amt
			
		    var date = null;
			var orderno=selectedorder[i];
			var netTotal= $('.amttopaycontId_'+selectedorder[i]).html();
			var tenderAmt=parseFloat($('.amttopaycontId_'+selectedorder[i]).html()).toFixed(2); //amt given for payment by customer
			
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
		    var cardlastfourdigit = "xxxx";
		      
		    if(discountpercentage==100){
		    	discountamt = grossamount = Number($("#unpaidorderdiscamt_"+orderno).val());
			}
		   
			if (isNaN(tenderAmt) || tenderAmt=='')
			{
			document.getElementById('bulk_payalertMsg').innerHTML='Please enter a valid number!';
			}
			else
			{
				if(storedoubleroundoffflag=='Y')
				{
				netTotal=round(netTotal,1);
				}


				var payment1={};
				var order={};
				order.id=orderno;
				payment1.orderPayment=order;
				payment1.amount=netTotal;
				payment1.paidAmount=payableamount;
				payment1.amountToPay=0.00;
			    payment1.tenderAmount=tenderAmt;
				if(paymentmode == "cash"){
					payment1.paymentMode="cash";
				}
				else{
					 cardlastfourdigit= $('#bulkpaycardlastfourDigit').val()
					 if(cardlastfourdigit=='')
		                      {
		                       lastfourdigit='xxxx';
		                      }
					payment1.paymentMode="card";
				}
				payment1.cardLastFourDigits=cardlastfourdigit;
				payment1.source="web";
				payment1.remarks="nil";
				payment1.tipsAmount="0.00";


				if(is_Acc=="Y")
				{
				  if(sale_ledger_id<=0 && duties_ledger_id<= 0 && round_ledger_id<=0 && discount_ledger_id<=0 && debitor_cash_ledger_id<=0 && service_charge_ledger_id<=0 && card_ledger_id<=0) {
				   document.getElementById('bulk_payalertMsg').innerHTML = "ledger missing";
						return;
					 }else {
						  document.getElementById('bulk_payalertMsg').innerHTML = "";

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

				
				$.ajax({
					url : BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(payment1),
					success : function(response) {
				       try{
						if(response=='success'){
							}
						}catch(e){alert(e);}

					},
		            error : function(e) {
		          }
		      });
            }
				
		} // end loop
		
		selectedorder = [];
		 $('#bulkPayModal').modal('hide');
		showalertOrderPaidModal();
		
	}
	
}



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
