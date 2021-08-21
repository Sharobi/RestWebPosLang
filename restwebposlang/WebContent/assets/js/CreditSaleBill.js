/**
 * new added for credit sale bill print from admin panel dated 5.7.2019
 */



function getCreditOrderById(orderId, tableno, billAmt, paidAmt ,storebaseorderno) {
	//alert(orderId);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/unpaidorder/getunpaidorderwithLang/" + orderId + ".htm", function(response) {
		try {
			console.log(response);
			var responseObj = JSON.parse(response);
			printCreditBill(responseObj,tableno,billAmt,paidAmt,storebaseorderno);
		} catch (e) {
			alert(e);
		}

	}, null);

}

function printCreditBill(responseObj,tableno,billAmt,paidAmt,storebaseorderno){
	var jsonObj = responseObj;
	
	var orderNo = jsonObj.id;
	var storeBasedOrderNo = jsonObj.orderNo;
	var tabNo = jsonObj.table_no;
	var customerName = jsonObj.customers.name;
	var orderCustomerName =  $('#creditcustnameContId').html();
	var customerAddr = jsonObj.customers.address;
	var orderCustomerAddr = jsonObj.deliveryAddress;
	var customerPhNo = $('#creditcustcontactContId').html();
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
	var afterdiscount = subToatlAmt - customerDiscount + serviceChargeAmt;
	
	if(printbillpapersize == '80.00') {
		        $('#billtype80').text("CREDIT INVOICE");
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
				$('#cashOrdervalue80').text(storeBasedOrderNo);
				$('#cashOrderdate80').text(orderDate);
				if(tabNo!='0'){
					$('#cashtableNoValue80').text('Table No:'+tabNo);
				}
				else{
					$('#cashtableNoValue80').text(orderTypeOfOrder);
				}
				
				
				/* ********** END STORE INFO PRINT ********** */
				/* ********** START ITEM DETAILS PRINT ********** */
				$("#itemDetailsPrint80").text("");
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
		
				$('#cashtotalamt80').text(parseFloat(subToatlAmt).toFixed(2));
		
				if (serviceChargeAmt > 0) {
		            $("#orderAmtDetails .serviceCharge80px").show();
					$('#cashservChrg80').text(parseFloat(serviceChargeAmt).toFixed(2));
					$('#cashservChrgDisc80').text("(" + serviceChargeDisc +")%");
				} else {
					$("#orderAmtDetails .serviceCharge80px").hide();
				}
		
				if (serviceTaxAmt > 0) {
					$("#cashtotalServiceTax80px").show();
					$('#cashservTax80').text(parseFloat(serviceTaxAmt).toFixed(2));
				} else {
					$("#cashtotalServiceTax80px").hide();
				}
		
				if (vatAmt > 0) {
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
		
				$('#paidAmount80').text(parseFloat(paidAmt).toFixed(2));
				$('#tenderAmount80').text(parseFloat(Math.round(Number(billAmt) - Number(paidAmt))).toFixed(2));
				
				document.getElementById('cusname80').innerHTML =orderCustomerName;				
				document.getElementById("cusnametr80").style.display = "block";
				document.getElementById('cusphno80').innerHTML =customerPhNo;
				document.getElementById("cusphnotr80").style.display = "block";
				printCashOrCardLocal80();	
			
		}else if(printbillpapersize == '2100.00'){
					  $('#cashOrdervalue2100').text(storeBasedOrderNo);
					$('#cashOrderdate2100').text(orderDate);
					if(tabNo!='0'){
						$('#cashtableNoValue2100').text('Table No:'+tabNo);
					}
					else{
						$('#cashtableNoValue2100').text(orderTypeOfOrder);
					}
					/* ********** For GST *********** */
					$('#storeName2100_GST').text(customerName);
					$('#storeAddr2100_GST').text();
					$('#storeEmail2100_GST').text(customerEmail);
					$('#storePhNo2100_GST').text(customerPhNo);
					$('#cashOrdervalue2100_GST').text(storeBasedOrderNo);
					$('#cashOrderDate_GST').text(orderDateWithTime);
					$('#cashCustName_GST').text(orderCustomerName);
					$('#cashCustAddr_GST').text(orderCustomerAddr);
					$('#cashCustState_GST').text(state);
					$('#cashCustGSTIN_GST').text(jsonObj.custVatRegNo);
					$('#cashCustPhone2100_GST').text(customerPhNo);
					
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
					var total_disc_clm = "<td>" + parseFloat(customerDiscount).toFixed(2) + "</td>"; // changed in 2nd Apr 18					
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
					
					$("#paidAmount_paidbill_2100px").text(parseFloat(paidAmt).toFixed(2)); 
					$("#amoutToPay_paidbill_2100px").text(Math.round(Number(billAmt) - Number(paidAmt))); 
					$('#paidAmount2100').text(parseFloat(paidAmt).toFixed(2));
					$('#tenderAmount2100').text(parseFloat(Math.round(Number(billAmt) - Number(paidAmt))).toFixed(2));
					$('#refundAmount2100').text("0.00");
					
					printCashOrCardLocal2100();
					
					
					
				}else{
					
				}
	
	
	
	
	
}

function printCashOrCardLocal80() {
	    var divToPrint = document.getElementById('printDiv80');
		document.getElementById('cashRemovePrint80').style.display = 'none';
		newWin = window.open("");
		newWin.document.write(divToPrint.outerHTML);
		newWin.document.close();
		newWin.focus();
		newWin.print();
		document.getElementById('cashRemovePrint80').style.display = 'block';
	    newWin.close();
		
	}
function printCashOrCardLocal2100() {
	 var divToPrint = document.getElementById('printDiv2100GST');
	 newWin = window.open("");
	 newWin.document.write(divToPrint.outerHTML);
	 newWin.focus();
	 newWin.print();
	 newWin.close();
	
	}

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