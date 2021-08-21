var itemObjValue = new Array();
var itemUnique;
var ordVal;
var ordItemVal;
var tableNoValue;

function updatetableStatus(operation) {
	var tableData = document.getElementById('TableId').value;
	if (tableData == 0) {
		// alert('Please select a table');
		showselectTablealertModal();
	} else {
		var status = document.getElementById('tabstatus' + tableData).value;
		if (status == 'Y') {
			// alert('This table is booked,cannot be disabled');
			showbookedTablealertModal();
		} else {
			/*
			 * if (confirm("Are you sure?")) { var ajaxCallObject = new
			 * CustomBrowserXMLObject(); ajaxCallObject.callAjax(BASE_URL +
			 * "/table/updatetableStatus/" + tableData + "/" + operation +
			 * ".htm", function() {
			 * location.href=BASE_URL+'/table/viewtable.htm'; }, null); }
			 */
			showconfirmTablealertModal(tableData, operation);
		}
	}
}
function updateTableOperation() {
	var tableData = document.getElementById('targettableId').value;
	var operation = document.getElementById('targettableOpt').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/table/updatetableStatus/" + tableData + "/" + operation + ".htm", function() {
		location.href = BASE_URL + '/table/viewtable.htm';
	}, null);
}
function showtablebookingData() {
	//	 alert('tablebookingdata');
	document.getElementById('tablebookingheaderdata').style.display = 'block';
	document.getElementById('changetableheaderdata').style.display = 'block';
	document.getElementById('changetableheaderdataordersearch').style.display = 'block';
	$('#posliId').removeClass('hide');
	//	document.getElementById('posliId').removeClass('hide');
}
function directOrderCheck(val) {
	if (val == 'xx') {
		showdirectOrderModal();
	}
}
//function searchbyorderno(orderno){
//	var ajaxCallObject = new CustomBrowserXMLObject();
//	ajaxCallObject.callAjax(BASE_URL + "/order/searchorderbyid/" + orderno + ".htm", function(res) {
//		console.log(res);
//		var resoderdet=JSON.parse(res);
//		var orderNo = resoderdet.id;
//		if(orderNo==0){
//			$("#noOrderRecordsFoundModal").modal("show");
//		}else{
////			var orderNo=orderNo_withordertype.split("_")[0];
//			var orderType = resoderdet.ordertype.id;
//			var tabno = resoderdet.table_no;
//			var seatno =( resoderdet.seatNo==null)?0:resoderdet.seatNo;
//			//	alert(orderType);
//			// alert('select:'+orderNo+':'+tabno+':'+seatno);
//			if (orderType == 1) {
//				location.href = BASE_URL + '/order/vieworderHD.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=h';
//			} else if (orderType == 5) {
//				location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=s';
//			} else if (orderType == 6) {
//				location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=z';
//			} else {
//				location.href = BASE_URL + '/order/vieworder.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + seatno;
//			}
//		}
//		
//	}, null);
//}
function clickonSubmenu(subMenuId,
						cssIndex) {
	loadMenuItems(BASE_URL + "/menu/menuitems.htm?menuid=" + subMenuId + "&index=" + cssIndex + "", document.getElementById('menu_items_container'));
}

function loadMenuItems(	url,
						containerId) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(url, function(response) {
		containerId.innerHTML = response;
	}, null);
}

function clickOnTable(	tableId,
						tableNo,
						orderNo,
						seatNo) {
	// alert(tableId+":"+tableNo+":"+orderNo);
	location.href = BASE_URL + '/order/vieworder.htm?ono=' + orderNo + '&tno=' + tableNo + '&sno=' + seatNo;

}
var orderitemdata = null;
function additemtoOrder(itId,
						itName,
						itPrice,
						disc,
						vat,
						serviceTax,
						promoFlag,
						promoValue) {
	// alert('itemId:'+itId+':itemName:'+itName+':itemPrice:'+itPrice+':disc:'+disc+':vat:'+vat+':servicetax:'+serviceTax);
	var menuitempost = {};
	menuitempost.id = itId;
	menuitempost.name = itName;
	menuitempost.price = itPrice;
	menuitempost.vat = vat;
	menuitempost.serviceTax = serviceTax;
	menuitempost.promotionFlag = promoFlag;
	menuitempost.promotionValue = promoValue;
	$.ajax({
		url : BASE_URL + "/order/addorderitempost.htm",
		type : 'POST',
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(menuitempost),
		success : function(	response,
							JSON_UNESCAPED_UNICODE) {
			console.log(response);
			// called when
			// successful
			try {
				var responseObj = JSON.parse(response);
				prepareOrderHtml(responseObj);
				var qty = null;
				for ( var i = 0; i < responseObj.length; i++) {
					var orderitem = responseObj[i];
					if (itId == orderitem.itemId) {
						qty = orderitem.quantityOfItem;
					}
				}
				// for vfd
				if (vfdPort.length > 3) {
					if (itName.length > 12)
						itName = itName.substring(0, 12);
					var tot = document.getElementById('amttopaycontId').innerHTML;
					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" + qty + "x" + itName + ":" + parseFloat(itPrice).toFixed(2) + "/" + "TOT IN RM : " + parseFloat(tot).toFixed(2) + ".htm", function() {
					}, null);
				}
			} catch (e) {
				alert(e);
			}

		},
		error : function(e) {
			// called when there is
			// an error
			// console.log(e.message);
		}
	});

	/*var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/addorderitem/" + itId + "/"
			+ decodeURIComponent(itName) + "/" + itPrice + "/" + disc + "/"
			+ vat + "/" + serviceTax + "/" + promoFlag + "/" + promoValue
			+ ".htm", function(response) {
		

	}, null);*/
	// for vfd
	/*
	 * if(vfdPort.length>3) { if(itName.length>15)
	 * itName=itName.substring(0,15); var
	 * tot=document.getElementById('amttopaycontId').innerHTML; var
	 * ajaxCallObject = new CustomBrowserXMLObject();
	 * ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" +itName+" :
	 * "+parseFloat(itPrice).toFixed(2) + "/" +
	 * parseFloat(tot).toFixed(2)+".htm", function() { }, null); }
	 */
}

var total = 0.0;
var totDisc = 0.0;
var forspNoteData = [];
function prepareOrderHtml(responseData) {
	forspNoteData = [];
	var itemObj = {};
	orderitemdata = responseData;
	var staticVat = 14.5;
	var staticST = 5.6;
	var subtotal = 0.0;
	var disc = 0.0;
	var staxAmt = 0.0;
	var vatAmt = 0.0;
	var grandTotal = 0.0;
	var netPrice = 0.0;
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var storedoubleroundoffflag = document.getElementById('hidstoredoubleroundoffFlag').value;
	var servicetaxText = document.getElementById('hidserviceTaxTextVal').value;
	var vattaxText = document.getElementById('hidvatTaxTextVal').value;
	var paidAmtVal = document.getElementById('hidpaidAmtVal').value;
	var custdiscAmtVal = document.getElementById('hidcustDiscVal').value;
	var orderitemcontainerId = document.getElementById('orderitemContId');
	var subtotalcontainerId = document.getElementById('subtotalcontId');
	// var servicetaxcontainerId=document.getElementById('servicetaxcontId');
	// var vatcontainerId=document.getElementById('vatcontId');
	var amttopaycontainerId = document.getElementById('amttopaycontId');
	var grandtotalcontainerId = document.getElementById('grandtotalcontId');
	// var discAmtcontainerId=document.getElementById('discAmtCont');
	var tableno = document.getElementById('tablenoCont').innerHTML;
	var parcelST = document.getElementById('hidparcelST').value;
	var parcelVat = document.getElementById('hidparcelVat').value;
	var scharge = $('#serviceChargeRate').val();
	var schargetext = $('#hidserviceChargeText').val();
	var directordertaking = $("#directordertakingContId").val();
	//	alert(directordertaking);

	var createdrowline = "";
	var generatedHtml = "";
	// for saravana
	//	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th></th><th>NAME</th><th style='text-align:center;'>QUANTITY</th><th>TOTAL</th><th>RATE</th>";
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th></th><th>" + getBaseLang.name + "</th><th style='text-align:center;'>" + getBaseLang.qty + "</th><th>" + getBaseLang.tot + "</th><th>" + getBaseLang.rate + "</th>";
	// for other
	// var tableline="<table class='table table-striped table-bordered'
	// style='color:#FFF; border:1px solid
	// #222222;'><thead><th></th><th>NAME</th><th
	// style='text-align:center;'>QUANTITY</th><th>TOTAL</th><th>DISCNT</th><th>RATE</th>";
	// for saravana commented the following code
	/*
	 * if(vattaxText.length!=0) { tableline+="<th>"+vattaxText+"(%)</th>"; }
	 * if(servicetaxText.length!=0) { tableline+="<th>"+servicetaxText+"(%)</th>"; }
	 */
	var headerline = "<tbody style='color:#fff; padding:1px;' >";
	var footerline = "</tbody></table>";
	// var table = document.getElementById("orderItemtable");
	for ( var i = 0; i < responseData.length; i++) {

		var orderitem = responseData[i];
		//alert(decode_utf8(orderitem.itemName));
		ordItemVal = responseData[i];
		var disc1 = 0.0;
		var begintrline = "";
		var firsttdline = "";
		var secondtdline = "";
		var thirdtdline = "";
		if (orderitem.isinOrder == 'Y') {
			var trbgColor = "#2E2E2E";
			if (orderitem.itemName.indexOf("CONTAINER") == 0) {
				trbgColor = "#1c91bc";
			}
			begintrline = "<tr style='background:" + trbgColor + "; padding:2px;'>";
			firsttdline = "<td style='padding:1px;text-align:center;'>" + (i + 1) + "</td>";
			if (orderitem.ordertype == 2) {
				secondtdline = "<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>" + orderitem.itemName + "(P)</td>";
			} else {
				secondtdline = "<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>" + orderitem.itemName + "</td>";
			}
			thirdtdline = "<td valign='middle' align='center' style='padding:3px;'> " + orderitem.quantityOfItem +
			// "<input type='text' size='1' disabled='disabled'
			// value='"+orderitem.quantityOfItem+"'
			// style='text-align:center;color:#fff;
			// background-color:#333;height:22px;width:30px;'>" +
			"</td>";

		} else {
			// forspNoteData=[];
			forspNoteData.push(orderitem);
			var trbgColor = "#222222";
			if (orderitem.itemName.indexOf("CONTAINER") == 0) {
				trbgColor = "#1c91bc";
			}
			begintrline = "<tr id='row_" + orderitem.itemId + "' style='background:" + trbgColor + "; padding:2px;'>";
			firsttdline = "<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRow(" + orderitem.itemId + ",this)' id='chk_" + orderitem.itemId + "'></td>";
			secondtdline = "<td width='50%'  onclick='javascript:selectRow(" + orderitem.itemId + ")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>" + orderitem.itemName + "</td>";
			thirdtdline = "<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:decreaseItemQuantity(" + orderitem.itemId + ",&quot;" + orderitem.itemName + "&quot;," + orderitem.rate + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/base/d/d_delete.png' height='22' width='18'></a> " + "<input type='text' onClick='this.select();' id='qty" + orderitem.itemId + "' size='1' onkeyup='javascript:enterManualQuantity(this.value," + orderitem.itemId + ")' value='" + orderitem.quantityOfItem + "' style='text-align:center;color:#fff; background-color:#333;height:22px;width:30px;' class='ordermanualQty'>" + " <a href='javascript:increaseItemQuantity(" + orderitem.itemId + ",&quot;" + orderitem.itemName + "&quot;," + orderitem.rate + ")'><img border='0'  alt='' src='" + BASE_URL + "/assets/images/base/d/d_add.png' height='22' width='18'></a></td>";
		}
		if (orderitem.item.promotionFlag == 'Y') {
			disc1 = (orderitem.rate * orderitem.quantityOfItem) * orderitem.discount / 100;
		}
		// staxAmt+=(orderitem.rate*orderitem.quantityOfItem-disc1)*orderitem.serviceTax/100;
		// vatAmt+=(orderitem.rate*orderitem.quantityOfItem-disc1)*orderitem.vat/100;
		if (storeID == '35' && tableno != '0' && orderitem.serviceTax == '0') {
			staxAmt += (orderitem.rate * orderitem.quantityOfItem - disc1) * staticST / 100;
		} else {
			staxAmt += (orderitem.rate * orderitem.quantityOfItem - disc1) * orderitem.serviceTax / 100;
		}
		if (storeID == '35' && tableno != '0' && orderitem.vat == '0') {
			vatAmt += (orderitem.rate * orderitem.quantityOfItem - disc1) * staticVat / 100;
		} else {
			vatAmt += (orderitem.rate * orderitem.quantityOfItem - disc1) * orderitem.vat / 100;
		}
		disc += disc1;
		subtotal += (orderitem.rate * orderitem.quantityOfItem) - disc1;
		var fourthtdline = "<td  style='padding:1px;text-align: center;'>" + parseFloat(orderitem.rate * orderitem.quantityOfItem - disc1).toFixed(2) + "</td>";
		var fifthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(disc1).toFixed(2) + "</td>";
		var sixthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(orderitem.rate).toFixed(2) + "</td>";
		var seventhhtdline = "";
		var eighthtdline = "";
		if (vattaxText.length != 0) {
			seventhhtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(orderitem.vat).toFixed(2) + "</td>";
		}
		if (servicetaxText.length != 0) {
			eighthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(orderitem.serviceTax).toFixed(2) + "</td>";
		}

		var endtrline = "</tr>";

		// disc+=(orderitem.rate*orderitem.discount/100)*orderitem.quantityOfItem;

		// createdrowline+=begintrline+firsttdline+secondtdline+orderitem.itemName+thirdtdline+fourthtdline+parseFloat(orderitem.rate*orderitem.quantityOfItem).toFixed(2)+endtrline;
		// for saravana
		createdrowline += begintrline + firsttdline + secondtdline + thirdtdline + fourthtdline + sixthtdline + endtrline;
		// for other
		// createdrowline+=begintrline+firsttdline+secondtdline+thirdtdline+fourthtdline+fifthtdline+sixthtdline+seventhhtdline+eighthtdline+endtrline;

		// createdrowline+=begintrline+firsttdline+secondtdline+orderitem.itemName+thirdtdline+fourthtdline+parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2)+fifthtdline+parseFloat(disc1).toFixed(2)+sixthtdline+parseFloat(orderitem.rate).toFixed(2)+seventhhtdline+orderitem.vat+eighthtdline+orderitem.serviceTax+endtrline;
		// createdrowline+=begintrline+firsttdline+secondtdline+orderitem.itemName+thirdtdline+fourthtdline+parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2)+fifthtdline+parseFloat(disc1).toFixed(2)+sixthtdline+parseFloat(orderitem.rate).toFixed(2)+seventhhtdline+parseFloat(orderitem.vat).toFixed(2)+eighthtdline+endtrline;
	
		
	}
	/*itemObj.id = orderValue.itemId;
	for(var j = 0; i < itemObjValue;j++){
		if(itemObjValue[j].id ==  orderValue.itemId){
			if(itemObj.quantity == orderValue.quantityOfItem){
				
			}else{
				
			}
		}else{
			itemObj.quantity = orderValue.quantityOfItem;
		}
	}
	
	
	itemObj.name = orderValue.itemName;
	itemObj.quantity = $("#qty"+ itemObj.id).val();*/
	itemObjValue.push(ordItemVal.itemId);
	itemUnique = $.unique(itemObjValue);

	generatedHtml = tableline + headerline + createdrowline + footerline;
	if (tableno == '0' && parcelST == 'N') {
		staxAmt = 0.0;
	}
	if (tableno == '0' && parcelVat == 'N') {
		vatAmt = 0.0;
	}
	// alert(generatedHtml);
	// grandTotal=(subtotal+staxAmt+vatAmt)-disc;
	// alert('subtotal:'+subtotal+'stax:'+staxAmt+':vat:'+vatAmt);

	//	alert(orderType);
	if (schargetext != '' && scharge != 0.00) {
		if (currentTable == 0 && orderType == '') {
			scharge = 0;
		} else {
			staxAmt = staxAmt + staxAmt * scharge / 100;
			vatAmt = vatAmt + vatAmt * scharge / 100;
			scharge = subtotal * scharge / 100;
		}

	}

	grandTotal = (subtotal + parseFloat(scharge) + staxAmt + vatAmt);
	// alert('paid:'+paidAmtVal+'disc:'+custAmtVal+':flag:'+storeroundoffflag);
	// alert('s text:'+servicetaxText.length);
	netPrice = grandTotal - paidAmtVal - custdiscAmtVal;
	orderitemcontainerId.innerHTML = generatedHtml;
	if (storeroundoffflag == 'Y') {
		grandTotal = Math.round(grandTotal);
		netPrice = Math.round(netPrice);
	}
	if (storedoubleroundoffflag == 'Y') {
		netPrice = round(netPrice, 1);
	}
	subtotalcontainerId.innerHTML = parseFloat(subtotal).toFixed(2);
	if (schargetext != '') {
		if (currentTable == 0 && orderType == '') {
			$("#schrgId").html(parseFloat(0).toFixed(2));
		} else {
			$("#schrgId").html(parseFloat(scharge).toFixed(2));
		}

	}
	if (servicetaxText.length != 0) {
		document.getElementById('servicetaxcontId').innerHTML = parseFloat(staxAmt).toFixed(2);
	}
	if (vattaxText.length != 0) {
		document.getElementById('vatcontId').innerHTML = parseFloat(vatAmt).toFixed(2);
	}

	amttopaycontainerId.innerHTML = parseFloat(netPrice).toFixed(2);
	grandtotalcontainerId.innerHTML = parseFloat(grandTotal).toFixed(2);
	// discAmtcontainerId.value=parseFloat(disc).toFixed(2);
	total = grandTotal;
	totDisc = disc;
	$("#itemCodeSearch").val("");
	$("#itemBarCodeSearch").val("");
	
}

function encode_utf8(s) {
	return unescape(encodeURIComponent(s));
}

function decode_utf8(s) {
	return decodeURIComponent(escape(s));
}

function increaseItemQuantity(	itemId,
								itemName,
								itemRate) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/increaseitemquantity/" + itemId + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			prepareOrderHtml(responseObj);
			var qty = null;
			for ( var i = 0; i < responseObj.length; i++) {
				var orderitem = responseObj[i];
				if (itemId == orderitem.itemId) {
					qty = orderitem.quantityOfItem;
				}
			}
			// for vfd
			if (vfdPort.length > 3) {
				if (itemName.length > 12)
					itemName = itemName.substring(0, 12);
				var tot = document.getElementById('amttopaycontId').innerHTML;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" + qty + "x" + itemName + ":" + parseFloat(itemRate).toFixed(2) + "/" + "TOT IN RM : " + parseFloat(tot).toFixed(2) + ".htm", function() {
				}, null);
			}
		} catch (e) {
			alert(e);
		}
	}, null);
}
function decreaseItemQuantity(	itemId,
								itemName,
								itemRate) {
	// alert(itemId);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/decreaseitemquantity/" + itemId + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			prepareOrderHtml(responseObj);

			// for vfd
			if (vfdPort.length > 3) {
				if (itemName.length > 13)
					itemName = itemName.substring(0, 13);
				var tot = document.getElementById('amttopaycontId').innerHTML;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" + itemName + ":-" + parseFloat(itemRate).toFixed(2) + "/" + "TOT IN RM : " + parseFloat(tot).toFixed(2) + ".htm", function() {
				}, null);
			}
		} catch (e) {
			alert(e);
		}
	}, null);
}

function enterManualQuantity(	qty,
								itemId) {
	// alert(qty+":"+itemId);
	// var newqty=qty.trim();
	if (parseInt(qty) > 0) {

		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/manualitemquantity/" + qty + "/" + itemId + ".htm", function(response) {
			try {
				var responseObj = JSON.parse(response);
				prepareOrderHtml(responseObj);
				document.getElementById('qty'+itemId).focus();
				var len=document.getElementById('qty'+itemId).value.length;
				document.getElementById('qty'+itemId).setSelectionRange(len, len);
			} catch (e) {
				alert(e);
			}
		}, null);
		 //document.getElementById('qty'+itemId).focus();
	} else if (qty == '') {
		showalerteditOrderQuantityModal(itemId);
		document.getElementById('qty' + itemId).focus();
	} else if (parseInt(qty) == 0) {
		showalerteditOrderQuantityModal(itemId);
		document.getElementById('qty' + itemId).value = 1;
	} else {
		showalerteditOrderQuantityModal(itemId);
		document.getElementById('qty' + itemId).value = 1;
	}
}
function setOrderItemManualQty() {
	var itId = document.getElementById('hiddmanualeditItemId').value;
	document.getElementById('qty' + itId).value = 1;
}
function createOrder() {

	// var option =document.getElementsByName("deliveryOption");
	var option;
	var selOption = null;
	/*
	 * for(var i = 0; i < option.length; i++) { if(option[i].checked == true) {
	 * selOption = option[i].value; } }
	 */

	var custName = null;
	var custPhone = null;
	var custAddress = null;
	var deliveryPerson = null;
	var custvatregno=null;
	var location=null;
	var houseno=null;
	var streetno=null;
	
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
	var seatno = document.getElementById('hidcurrentSeat').value;
	var pax = document.getElementById('hidnoofPax').value;
	option = document.getElementsByName("deliveryOption");
	//	document.getElementById("modparcelcustPhone").value = "";
	/*
	 * if(tableno=='0') {
	 */
	if (parcelAdd == 'Y' && itcatId == '') {
		// option =document.getElementsByName("deliveryOptionParcel");
		custName = decodeURIComponent(document.getElementById('modparcelcustName').value);
		custPhone = document.getElementById('modparcelcustPhone').value;
		custAddress = decodeURIComponent(document.getElementById('modparcelcustAddress').value);
		deliveryPerson = decodeURIComponent(document.getElementById('modparceldeliveryPersonName').value);
		custvatregno= decodeURIComponent(document.getElementById('modparcelcustvatorcst').value);
		location= decodeURIComponent(document.getElementById('modparcelcustlocation').value);
		houseno= decodeURIComponent(document.getElementById('modparcelcusthouseno').value);
		streetno= decodeURIComponent(document.getElementById('modparcelcuststreet').value);
		
	} else {
		option = document.getElementsByName("deliveryOption");
	}

	/*
	 * } else { option =document.getElementsByName("deliveryOption"); }
	 */
	for ( var i = 0; i < option.length; i++) {
		if (option[i].checked == true) {
			selOption = option[i].value;
		}
	}
	// alert(selOption);
	// alert('custname:'+custName+':custphone:'+custPhone+':custaddress:'+custAddress+':deliveryperson:'+deliveryPerson);
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var storedoubleroundoffflag = document.getElementById('hidstoredoubleroundoffFlag').value;
	var netamt = 0.0;
	// alert(orderno+":"+tableno);

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/createorder.htm?delOption=" + selOption + "&orderno=" + orderno + "&tableno=" + tableno + "&custname=" + custName + "&custphone=" + custPhone + "&custaddress=" + custAddress + "&deliveryperson=" + deliveryPerson + "&seatno=" + seatno + "&pax=" + pax+"&custvatregno="+custvatregno+"&location="+location+"&houseno="+houseno+"&streetno="+streetno, function(response) {
		try {

			var responseObj = JSON.parse(response);
			// alert(responseObj);
			if (responseObj.length > 0 || responseObj != null) {

				netamt = total - totDisc;
				if (storeroundoffflag == 'Y') {
					netamt = Math.round(netamt);
					total = Math.round(total);
				}
				if (storedoubleroundoffflag == 'Y') {
					netamt = round(netamt, 1);
				}
				document.getElementById('modTabCont').innerHTML = tableno;
				tableNoValue = tableno;
				ordVal = responseObj;
				document.getElementById('modOrderCont').innerHTML = responseObj;
				document.getElementById('modAmtCont').innerHTML = parseFloat(total).toFixed(2);
				document.getElementById('modDiscCont').innerHTML = parseFloat(totDisc).toFixed(2);
				document.getElementById('modtotAmtCont').innerHTML = parseFloat(netamt).toFixed(2);
				/*
				 * if(tableno=='0') { var instantPrintBill="<button
				 * type='button'
				 * onclick='javascript:printinstantBill("+responseObj+");()'
				 * style='background: #72BB4F;font-weight:
				 * bold;' data-dismiss='modal' class='btn
				 * btn-success'>PRINT BILL</button>";
				 * document.getElementById('parcelInstantPrintBillContId').innerHTML=instantPrintBill; }
				 */
				showOrderModal();
			}

		} catch (e) {
			alert(e);
		}
	}, null);
}

function orderSuccessOK() {
	
	var printbillpapersize = $("#printbillpapersize").val();
	var kotPrintValue = $("#kotPrintVal").val();
	//alert(kotPrintValue);
	var table_no = document.getElementById('modTabCont').innerHTML;
	order_no = document.getElementById('modOrderCont').innerHTML;
	// alert(table_no+':'+order_no+':'+itcatId);

	if (kotPrintValue == "Y") {
		if (printbillpapersize == '58.00') {

			for ( var j = 0; j < itemUnique.length; j++) {
				var name = $("#row_" + itemUnique[j]).find('td:eq(1)').text();
				var quantity = $("#qty" + itemUnique[j]).val();
				/* var total = $("#row_" +itemUnique[j] ).find('td:eq(3)').text();
				 var rate = $("#row_" +itemUnique[j] ).find('td:eq(4)').text();*/
				if (quantity != undefined) {
					var rowline = "";
					var starttrline = "<tr>";
					var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 13px; word-wrap: break-word;'>" + name + "</td>";
					var secondtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 13px;'>" + quantity + "</td>";
					//var thirdtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 11px;'>"+total+"</td>";
					//var fourthtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 11px;'>"+rate+"</td>";
					var endtrline = "</tr>";
					rowline = starttrline + firsttdline + secondtdline /*+ thirdtdline + fourthtdline*/+ endtrline;
					//alert(rowline);
					var splnoterowline = "";
					//alert(forspNoteData.length);
					for ( var i = 0; i < forspNoteData.length; i++) {
						var item = forspNoteData[i];
						var id = item.itemId;
						if(id==itemUnique[j]){
							var note = decodeURIComponent($('#spnoteinput_' + id).val());
							if (undefined !=  note && note != "undefined" && note != "") {
							splnoterowline = "";
							var splnotestarttrline = "<tr>";
							var firsttdline ="<td style='padding: 1px; width: 300px !important;  font-size: 12px; word-wrap: break-word;'>#" + note + "</td>";
							var splnoteendtrline = "</tr>";
							splnoterowline=splnotestarttrline+firsttdline+splnoteendtrline;
							}
						}
						
//						 alert(id+':'+note);
					}
					$("#kotitems58").append(rowline+splnoterowline);
				}

			}

			var todayDate = new Date();
			var dateDate = todayDate.getDate();
			var monthMonth = todayDate.getMonth() + 1;
			var yyyy = todayDate.getFullYear();
			var hours = todayDate.getHours();
			var minutes = todayDate.getMinutes();
			var ampm = hours >= 12 ? 'PM' : 'AM';
			hours = hours % 12;
			hours = hours ? hours : 12; // the hour '0' should be '12'
			minutes = minutes < 10 ? '0' + minutes : minutes;
			var strTime = hours + ':' + minutes + ' ' + ampm;
			if (dateDate < 10) {
				dateDate = '0' + dateDate;
			}

			if (monthMonth < 10) {
				monthMonth = '0' + monthMonth;
			}

			todayDate = yyyy + '-' + monthMonth + '-' + dateDate;

			//alert(todayDate);
			document.getElementById('dateTimeValue58').innerHTML = todayDate + " " + strTime;
			document.getElementById('ordValue58').innerHTML = ordVal;
			if (currentTable == 0) {
				$("#kottable58").hide();
				$("#kothdorpercel58").show();
				if (orderType == 'h') {
					$("#hdorpercelValue58").text("Home Delivery");
				}else if (orderType == 's'){
					$("#hdorpercelValue58").text("Swiggy");
				} else if (orderType == 'z'){
					$("#hdorpercelValue58").text("Zomato");
				} else {

				}
			} else {
				$("#kothdorpercel58").hide();
				document.getElementById('tblValue58').innerHTML = tableNoValue;
			}

			itemUnique = "";
			kotPrint58();

		} else {
			for ( var j = 0; j < itemUnique.length; j++) {
				var name = $("#row_" + itemUnique[j]).find('td:eq(1)').text();
				var quantity = $("#qty" + itemUnique[j]).val();
				/* var total = $("#row_" +itemUnique[j] ).find('td:eq(3)').text();
				 var rate = $("#row_" +itemUnique[j] ).find('td:eq(4)').text();*/
				if (quantity != undefined) {
					var rowline = "";
					var starttrline = "<tr>";
					var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 13px; word-wrap: break-word;'>" + name + "</td>";
					var secondtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 13px;'>" + quantity + "</td>";
					//var thirdtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 11px;'>"+total+"</td>";
					//var fourthtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 11px;'>"+rate+"</td>";
					var endtrline = "</tr>";
					rowline = starttrline + firsttdline + secondtdline /*+ thirdtdline + fourthtdline*/+ endtrline;
					//alert(rowline);
					var splnoterowline = "";
					//alert(forspNoteData.length);
					for ( var i = 0; i < forspNoteData.length; i++) {
						var item = forspNoteData[i];
						var id = item.itemId;
						if(id==itemUnique[j]){
							var note = decodeURIComponent($('#spnoteinput_' + id).val());
							if (undefined !=  note && note != "undefined" && note != "") {
							splnoterowline = "";
							var splnotestarttrline = "<tr>";
							var firsttdline ="<td style='padding: 1px; width: 300px !important;  font-size: 12px; word-wrap: break-word;'>#" + note + "</td>";
							var splnoteendtrline = "</tr>";
							splnoterowline=splnotestarttrline+firsttdline+splnoteendtrline;
							}
						}
					}
					$("#kotitems").append(rowline+splnoterowline);
				}

			}

			var todayDate = new Date();
			var dateDate = todayDate.getDate();
			var monthMonth = todayDate.getMonth() + 1;
			var yyyy = todayDate.getFullYear();
			var hours = todayDate.getHours();
			var minutes = todayDate.getMinutes();
			var ampm = hours >= 12 ? 'PM' : 'AM';
			hours = hours % 12;
			hours = hours ? hours : 12; // the hour '0' should be '12'
			minutes = minutes < 10 ? '0' + minutes : minutes;
			var strTime = hours + ':' + minutes + ' ' + ampm;
			if (dateDate < 10) {
				dateDate = '0' + dateDate;
			}

			if (monthMonth < 10) {
				monthMonth = '0' + monthMonth;
			}

			todayDate = yyyy + '-' + monthMonth + '-' + dateDate;

			//alert(todayDate);
			document.getElementById('dateTimeValue').innerHTML = todayDate + " " + strTime;
			document.getElementById('ordValue').innerHTML = ordVal;
			if (currentTable == 0) {
				$("#kottable").hide();
				$("#kothdorpercel").show();
				if (orderType == 'h') {
					$("#hdorpercelValue").text("Home Delivery");
				}else if (orderType == 's'){
					$("#hdorpercelValue").text("Swiggy");
				} else if (orderType == 'z'){
					$("#hdorpercelValue").text("Zomato");
				} else {

				}
			} else {
				$("#kothdorpercel").hide();
				document.getElementById('tblValue').innerHTML = tableNoValue;
			}

			itemUnique = "";
			kotPrint();
			//printKotForPos();
		}

	} else {
		if (table_no == '0' && itcatId != '') {
			var option = document.getElementsByName("instantpayOption");
			var setOption = null;
			for ( var i = 0; i < option.length; i++) {
				if (option[i].checked == true) {
					selOption = option[i].value;
				}
			}
			// document.getElementById('hidinstantPaymentType').value=selOption;
			// document.getElementById('hidinstantPaymentFlag').value="Y";
			location.href = BASE_URL + '/order/vieworders.htm?ono=' + order_no + '&tno=' + table_no + '&sno=0' + '&itcno=' + itcatId + '&flg=Y&ptype=' + selOption;
		} else if (table_no == '0') {
			if (orderType == 'h') {
				location.href = BASE_URL + '/order/vieworderHD.htm?ono=' + order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=h';
			} else if (orderType == 's') {
				location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' + order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=s';
			} else if (orderType == 'z') {
				location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' + order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=z';
			} else {
				location.href = BASE_URL + '/order/vieworder.htm?ono=' + order_no + '&tno=' + table_no + '&sno=0';
			}

		} else {
			location.href = BASE_URL + '/table/viewtable.htm';
		}
	}
}

function formatAMPM(date) {
	var hours = date.getHours();
	var minutes = date.getMinutes();
	var ampm = hours >= 12 ? 'pm' : 'am';
	hours = hours % 12;
	hours = hours ? hours : 12; // the hour '0' should be '12'
	minutes = minutes < 10 ? '0' + minutes : minutes;
	var strTime = hours + ':' + minutes + ' ' + ampm;
	return strTime;
}

//function selectOderNo() {
//	var orderNo = document.getElementById('orderNo').value;
//	//	var orderNo=orderNo_withordertype.split("_")[0];
//	var orderType = $("#orderTypeid" + orderNo).val();
//	var tabno = document.getElementById('tno' + orderNo).value;
//	var seatno = document.getElementById('sno' + orderNo).value;
//	//	alert(orderType);
//	// alert('select:'+orderNo+':'+tabno+':'+seatno);
//	if (orderType == 1) {
//		location.href = BASE_URL + '/order/vieworderHD.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=h';
//	} else if (orderType == 5) {
//		location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=s';
//	} else if (orderType == 6) {
//		location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=z';
//	} else {
//		location.href = BASE_URL + '/order/vieworder.htm?ono=' + orderNo + '&tno=' + tabno + '&sno=' + seatno;
//	}
//
//}

function validateCreateOrder() {
	// alert(orderitemdata);
	if (orderitemdata != null) {
		return true;
	}
	return false;
}
function printBillWithReason() {
	//var printbillcount=$("#printbillcount").val();
	$("#printbillresonreq").addClass("hide");
	//alert(">>reason<<");
	var orderid = document.getElementById('orderNo').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getprintcount/" + orderid + ".htm", function(response) {
		//alert(response);
		if (response == 0) {
			$("#printbillcount").val(0);
			//alert($("#printbillcount").val());
			printBill();
		} else {
			$("#printbillcount").val(response);
			$("#printBillReasonModal").modal("show");
		}
	}, null);

}
function printBillCountt(printbillcount) {
	//var printbillcount = $("#printbillcount").val();
	var printreason = $("#printbillreasonId").val();
	
	if (printbillcount == 0) {
		printBill();
	} else {
		if (printreason == '') {
			$("#printbillresonreq").removeClass("hide");
		} else {
			$("#printbillresonreq").addClass("hide");
			$("#printBillReasonModal").modal("hide");
			printBill();
		}
	}
}
function printBill() {
	var commBean = {};
	commBean.orderId = document.getElementById('orderNo').value;
	commBean.billPrintReason = $("#printbillreasonId").val();
	$.ajax({
		url : BASE_URL + "/order/updateprintcount.htm",
		type : 'POST',
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(commBean),
		success : function(	response,
							JSON_UNESCAPED_UNICODE) {

			console.log(">>>>>> " + response);
		}
	});
	var caseValue = $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();
	/*for (var i = 0; i < forspNoteData.length; i++) {
	    alert(forspNoteData[i]);
	    //Do something
	}*/
	//alert(forspNoteData.toString());
	if (caseValue == "Y") {
		var orderid = document.getElementById('orderNo').value;
		var tableno = document.getElementById('tablenoCont').innerHTML;
		var totalAmt = document.getElementById('subtotalcontId').innerHTML;
		var servicechrg = $("#schrgId").html();
		var serviceTax = document.getElementById('servicetaxcontId').innerHTML;
		var vatTax = document.getElementById('vatcontId').innerHTML;
		var grossAmt = document.getElementById('grandtotalcontId').innerHTML;
		var amountPay = document.getElementById('amttopaycontId').innerHTML;
		var discountValue = document.getElementById('discBtnContId').innerHTML;
		var discountTxt = document.getElementById('discPerContId').innerHTML;
		//helloBillPrint();
		if (printbillpapersize == '58.00') {
			document.getElementById('ordervalue').innerHTML = orderid;
			document.getElementById('tableNoValue').innerHTML = tableno;
			document.getElementById('totalamt').innerHTML = totalAmt;
			document.getElementById('servTax').innerHTML = serviceTax;
			document.getElementById('vatTax').innerHTML = vatTax;
			document.getElementById('grossAmount').innerHTML = grossAmt;
			document.getElementById('amoutToPay').innerHTML = amountPay;
			document.getElementById('discountValue').innerHTML = discountValue;
			document.getElementById('discountTxt').innerHTML = discountTxt;
			document.getElementById('servChrg').innerHTML = servicechrg;

			/*if (currentTable == 0 && orderType == '') {
				$("#totalServiceChrg").hide();
			} else {
				$("#totalServiceChrg").show();
			}*/
			$("#totalServiceChrg").hide();

			if (serviceTax > 0.00) {
				$("#totalServiceTax").show();
			} else {
				//$("#totalServiceTax").addClass('hide');
				$("#totalServiceTax").hide();
			}
			if (vatTax > 0) {
				$("#totalVatTax").show();
			} else {
				$("#totalVatTax").hide();
			}

			if (discountValue > 0) {
				$("#showDiscount").show();
			} else {
				$("#showDiscount").hide();
			}
			//			$("#showtableno").hide();
			localPrint();
		} else if(printbillpapersize == '80.00') {
			document.getElementById('ordervalue80px').innerHTML = orderid;
			document.getElementById('tableNoValue80px').innerHTML = tableno;
			document.getElementById('totalamt80px').innerHTML = totalAmt;
			document.getElementById('servTax80px').innerHTML = serviceTax;
			document.getElementById('vatTax80px').innerHTML = vatTax;
			document.getElementById('grossAmount80px').innerHTML = grossAmt;
			document.getElementById('amoutToPay80px').innerHTML = amountPay;
			document.getElementById('discountValue80px').innerHTML = discountValue;
			document.getElementById('discountTxt80px').innerHTML = discountTxt;
			document.getElementById('servChrg80px').innerHTML = servicechrg;

			/*if (currentTable == 0 && orderType == '') {
				$("#totalServiceCharge80px").hide();
			} else {
				$("#totalServiceCharge80px").show();
			}
			*/
			$("#totalServiceCharge80px").hide();
			if (serviceTax > 0.00) {
				$("#totalServiceTax80px").show();
			} else {
				//$("#totalServiceTax").addClass('hide');
				$("#totalServiceTax80px").hide();
			}
			if (vatTax > 0) {
				$("#totalVatTax80px").show();
			} else {
				$("#totalVatTax80px").hide();
			}

			if (discountValue > 0) {
				$("#showDiscount80px").show();
			} else {
				$("#showDiscount80px").hide();
			}
			//			$("#showtableno80px").hide();
			localPrint80px();
		}else if(printbillpapersize == '2100.00'){

			
			document.getElementById('ordervalue_2100px').innerHTML = orderid;
			document.getElementById('tableNoValue_2100px').innerHTML = tableno;
		//	document.getElementById('orderType_2100px').innerHTML = tableno;
			document.getElementById('totalamt_2100px').innerHTML = totalAmt;
			document.getElementById('servTax_2100px').innerHTML= serviceTax;
			document.getElementById('vatTax_2100px').innerHTML = vatTax;
			document.getElementById('grossAmount_2100px').innerHTML = grossAmt;
			document.getElementById('amoutToPay_2100px').innerHTML = amountPay;
			document.getElementById('discountValue_2100px').innerHTML = discountValue;
			document.getElementById('discountTxt_2100px').innerHTML =  discountTxt;
			
			
			if(serviceTax > 0.00){
				    $("#totalServiceTax_2100px").show();
			}else{
				    //$("#totalServiceTax").addClass('hide');
				    $("#totalServiceTax_2100px").hide();
			}
			if(vatTax > 0){
				$("#totalVatTax_2100px").show();
			}else{
				$("#totalVatTax_2100px").hide();
			}
			
			if(discountValue > 0){
				$("#showDiscount_2100px").show();
			}else{
				$("#showDiscount_2100px").hide();
			}
			$("#showtableno_2100px").hide();
			localPrint_2100px();
		
		}

	} else {
		var orderid = document.getElementById('orderNo').value;

		//alert(orderid);
		// var tableno=document.getElementById('tablenoCont').innerHTML;
		if (orderid == 0 || forspNoteData.length > 0) {
			// alert('Please save the order first!');
			showalertsaveorderModal();
		} else {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/printbill/" + orderid + ".htm", function(response) {
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
function printPaidBill(orderid) {

	var caseValue = $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();
	var order = {};
	order.id = orderid;
	order.storeId = storeID;
	//  alert(order.id+ " >> "+order.storeId+ ">> "+BASE_URL);
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
				//	  alert("+jsonObj >> "+jsonObj);
				//console.log(response);
				var orderNo = jsonObj.id;
				var tabNo = jsonObj.table_no;
				var customerName = jsonObj.customers.name;
				var customerAddr = jsonObj.customers.address;
				var customerPhNo = jsonObj.customers.contactNo;
				var customerEmail = jsonObj.customers.emailId;
				var orderDateWithTime = jsonObj.customers.orderTime;
				var orderTime = jsonObj.customers.time;
				
				var billingCustomerName=jsonObj.customerName;
				var billingCustomerAddr=jsonObj.deliveryAddress;
				
				var billingCustomerVatRegNo=jsonObj.custVatRegNo;

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
				var totalTenderAmount = 0;
				var paymentsObj = jsonObj.payments;

				if (printbillpapersize == '58.00') {

					/* ****** Print in 58 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
					$('#storeNamePaidOrder58').text(customerName);
					$('#storeAddrPaidOrder58').text(storeAddr);
					$('#storeEmailPaidOrder58').text(customerEmail);
					$('#storePhNoPaidOrder58').text(customerPhNo);
					$('#ordervaluePaidOrder58').text(orderNo);
					$('#tableNoValuePaidOrder58').text(tabNo);

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

						$("#itemDetailsPrintPaidOrder58").append(createdrowline);

					}

					$('#totalamtPaidOrder58').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#totalServiceChrg_58").show();
						$('#servChrgPaidOrder58').text(serviceChargeAmt);
					} else {
						$("#totalServiceChrg_58").hide();
					}

					if (serviceTaxAmt > 0.00) {
						$("#totalServiceTax_58").show();
						$('#servTaxPaidOrder58').text(serviceTaxAmt);
					} else {
						$("#totalServiceTax_58").hide();
					}

					if (vatAmt > 0) {
						$("#totalVatTax_58").show();
						$("#vatTaxPaidOrder58").text(vatAmt);
					} else {
						$("#totalVatTax_58").hide();
					}

					if (customerDiscount > 0) {
						$("#showDiscount_58").show();
						$("#discountValuePaidOrder58").text(customerDiscount);
					} else {
						$("#showDiscount_58").hide();
					}

					$("#grossAmountPaidOrder58").text(billAmt);
					$("#amoutToPayPaidOrder58").text(grossAmt);

					var paidOrderPayObj = jsonObj.payments.length;
					if (paidOrderPayObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmountPaidOrder58').text(paidAmt);
						$('#tenderAmountPaidOrder58').text(tenderAmt);
						$('#refundAmountPaidOrder58').text(returnAmt);
						$('#payOrderTypePaidOrder58').text(type);

					}
					if (paidOrderPayObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmountPaidOrder58').text(paidAmt);
						$('#tenderAmountPaidOrder58').text(tenderAmt);
						$('#refundAmountPaidOrder58').text("0.00");
						$('#payOrderTypePaidOrder58').text(type1+" + "+type2);
					}

					paidOrder58();

				} else if(printbillpapersize == '80.00'){
					/* ****** Print in 80 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
					$('#storeNamePaidOrder80').text(customerName);
					$('#storeAddrPaidOrder80').text(storeAddr);
					$('#storeEmailPaidOrder80').text(customerEmail);
					$('#storePhNoPaidOrder80').text(customerPhNo);
					$('#cashOrdervaluePaidOrder80').text(orderNo);
					$('#cashtableNoValuePaidOrder80').text(tabNo);

					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */

					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;

						// alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

						var createdrowline = "";
						var startTrline = "<tr style='padding: 2px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + itemRate + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + itemTotalPrice + "</td>";
						var endTrline = "</tr>";

						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

						$("#itemDetailsPrintPaidOrder80").append(createdrowline);

					}

					/* ********** END ITEM DETAILS PRINT ********** */

					/* ********** START AMOUNT INFO PRINT ********** */
					//alert(" << subToatlAmt >> "+subToatlAmt+ " << serviceChargeAmt >>"+serviceChargeAmt+"<< serviceTaxAmt >>"+serviceTaxAmt+" << vatAmt >>"+vatAmt+"<< customerDiscount >>"+customerDiscount+"<< billAmt >> "+billAmt+"<< grossAmt >> "+grossAmt);						
					$('#cashtotalamtPaidOrder80').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#cashtotalServiceCharge80px").show();
						$('#cashservChrgPaidOrder80').text(serviceChargeAmt);
					} else {
						$("#cashtotalServiceCharge80px").hide();
					}

					if (serviceTaxAmt > 0.00) {
						$("#cashtotalServiceTax80px").show();
						$('#cashservTaxPaidOrder80').text(serviceTaxAmt);
					} else {
						$("#cashtotalServiceTax80px").hide();
					}

					if (vatAmt > 0) {
						$("#cashtotalVatTax80px").show();
						$("#cashvatTaxPaidOrder80").text(vatAmt);
					} else {
						$("#cashtotalVatTax80px").hide();
					}

					if (customerDiscount > 0) {
						$("#cashshowDiscount80px").show();
						$("#cashdiscountValuePaidOrder80").text(customerDiscount);
					} else {
						$("#cashshowDiscount80px").hide();
					}

					$("#cashgrossAmountPaidOrder80").text(billAmt);
					$("#cashamoutToPayPaidOrder80").text(grossAmt);

					var paidOrderPayObj = jsonObj.payments.length;
					if (paidOrderPayObj == 1) {

						var paidAmt = jsonObj.payments[0].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type = jsonObj.payments[0].paymentMode;

						$('#paidAmountPaidOrder80').text(paidAmt);
						$('#tenderAmountPaidOrder80').text(tenderAmt);
						$('#refundAmountPaidOrder80').text(returnAmt);
						$('#payOrderTypePaidOrder80').text(type);

					}
					if (paidOrderPayObj == 2) {

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;

						$('#paidAmountPaidOrder80').text(paidAmt);
						$('#tenderAmountPaidOrder80').text(tenderAmt);
						$('#refundAmountPaidOrder80').text("0.00");
						$('#payOrderTypePaidOrder80').text(type1+" + "+type2);
					}

					paidOrder80(); // Print For 80
				}else if(printbillpapersize == '2100.00'){

					
						//	alert("printbillpapersize 2 >> "+printbillpapersize);
					
				//	console.log(response);
							
							$('#storeName2100').text(customerName);
							$('#storeAddr2100').text(storeAddr);
							$('#storeEmail2100').text("Email :"+customerEmail);
							$('#storePhNo2100').text("Ph :"+customerPhNo);
							$('#ordervalue_2100px_gst').text(orderNo);
							$('#showcustomerNameValue_2100px').text(billingCustomerName);
							$('#showdeliveryAddressValue_2100px').text(billingCustomerAddr);
							$('#showbillingCustomerVatRegNo_2100px').text(billingCustomerVatRegNo);
							//$('#cashtableNoValue2100').text(tabNo);

							/* ********** END STORE INFO PRINT ********** */

							/* ********** START ITEM DETAILS PRINT ********** */

							$('#itemDetailsPrint2100').html('');
							
							
							for ( var k = 0; k < jsonObj.orderitem.length; k++) {
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

								var oneTdline = "<td width='5%;'>" + Number(k+1) + "</td>";
								
								if(item1.ordertype=='2') {
									
									itemName=item1.item.name + "(P)"; // itemName.substring(0,18)+"(P)..." +
								}
								else 
								{
									itemName=item1.item.name +"";  //itemName.substring(0,18)+"..." +
								}
								var twoTdline = "<td width='30%;'>"+itemName+"</td>";
								
								var itemCode='';
								if (isNaN(item1.item.code) || item1.item.code == '') {
									   
									itemCode='';
								}
								else {
									
									itemCode=item1.item.code;
								}
								var threeTdline = "<td>"+itemCode+"</td>";					
								var extraTdline = "<td></td>";
								var fourTdline = "<td width='6%;'>"+item1.quantityOfItem+"</td>";
								var fiveTdline = "<td width='6%;'>" + item1.item.unit + "</td>";
								var sixTdline = "<td width='5%;'>" +parseFloat(item1.item.price).toFixed(2)+ "</td>";
								
								var totalPrice=0.00;
								var totalTaxAmt=0.00;
								var totalRate=0.00;
								var totalServiceTax=0.00;
								var totalAmt=0.00;
								
								var discount=0.00;
								
								if(item1.item.promotionFlag=='Y') {
									totalPrice= parseFloat((item1.item.price-item1.item.price*item1.item.promotionValue/100)*item1.quantityOfItem).toFixed(2);
									if (isNaN(item1.discount) || item1.discount == '') {
										   
										discount=0.00;
									}
									else {
										
										discount=Number(item1.discount);
									}
									totalTaxAmt=parseFloat(((item1.item.price-item1.item.price*item1.item.promotionValue/100)*item1.quantityOfItem)-discount).toFixed(2);
									totalRate=parseFloat(((((item1.item.price-item1.item.price*item1.item.promotionValue/100)*item1.quantityOfItem)-discount) * item1.vat)/100).toFixed(2);
									totalServiceTax=parseFloat(((((item1.item.price-item1.item.price*item1.item.promotionValue/100)*item1.quantityOfItem)-discount) * item1.serviceTax)/100).toFixed(2);
									totalAmt=parseFloat((((((item1.item.price-item1.item.price*item1.item.promotionValue/100)*item1.quantityOfItem)-discount) * item1.vat)/100) + (((((item1.item.price-item1.item.price*item1.item.promotionValue/100)*item1.quantityOfItem)-discount) * item1.serviceTax)/100)).toFixed(2);
								}
								if(item1.item.promotionFlag=='N') {
									totalPrice= parseFloat(item1.quantityOfItem*item1.item.price).toFixed(2);
									if (isNaN(item1.discount) || item1.discount == '') {
									   
										discount=0.00;
									}
									else {
										
										discount=Number(item1.discount);
									}
									totalTaxAmt=parseFloat((item1.quantityOfItem*item1.item.price)-discount).toFixed(2);
									totalRate= parseFloat((((item1.quantityOfItem*item1.item.price)-discount) * item1.vat)/100).toFixed(2);
									totalServiceTax=parseFloat((((item1.quantityOfItem*item1.item.price) - discount) * item1.serviceTax)/100).toFixed(2);
									totalAmt=parseFloat(((((item1.quantityOfItem*item1.item.price) - discount) * item1.vat)/100) + ((((item1.quantityOfItem*item1.item.price) - discount) * item1.serviceTax)/100)).toFixed(2);
								}
								
								var sevenTdline = "<td width='5%;'>"+totalPrice+"</td>";
								var eightTdline = "<td width='5%;' id='tbl_orderItemDisc'>"+discount+"</td>";								
								var nineTdline="<td width='10%;' id='tbl_orderItemTaxAmt'>" + totalTaxAmt + "</td>";					
								var tenTdline="<td width='5%;'>" + item1.vat + "</td>";															
								var eleventdline = "<td width='10%;'>"+totalRate+"</td>";								
								var twelveTdline = "<td width='5%;'>" + item1.serviceTax + "</td>";
								var thirteenTdline = "<td width='10%;'>" + totalServiceTax + "</td>";
								var fourteenTdline = "<td width='5%;'>" + Number(item1.vat + item1.serviceTax) + "</td>";									
								var fifteenTdline = "<td width='10%;'>" +  totalAmt + "</td>";
							
								createdrowline = startTrline + oneTdline + twoTdline + threeTdline + extraTdline + fourTdline + fiveTdline + sixTdline + sevenTdline + eightTdline 
								                 + nineTdline + tenTdline + eleventdline + twelveTdline + thirteenTdline + fourteenTdline + fifteenTdline + endTrline;
														
								$("#itemDetailsPrint2100").append(createdrowline);

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
								$("#cashdiscountValue2100").text(customerDiscount);
							} else {
								$("#cashshowDiscount2100px").hide();
							}

							$("#cashgrossAmount2100").text(billAmt);
							$("#cashamoutToPay2100").text(grossAmt);

							var paymentsObj = jsonObj.payments.length;
							if (paymentsObj == 1) {

								var paidAmt = jsonObj.payments[0].paidAmount;
								var tenderAmt = jsonObj.payments[0].tenderAmount;
								var returnAmt = tenderAmt - paidAmt;
								var type = jsonObj.payments[0].paymentMode;

								$('#paidAmount2100').text(paidAmt);
								$('#tenderAmount2100').text(tenderAmt);
								$('#refundAmount2100').text(Math.floor(returnAmt * 100) / 100);
								$('#payType2100').text('Paid By ' + type);

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
								$('#payType2100').text(type1+" + "+type2);
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
		ajaxCallObject.callAjax(BASE_URL + "/order/printbill/" + orderid + ".htm", function(response) {
			try {
				if (response == 'Success')
					showPaidBillPrintSuccessModal();

			} catch (e) {
				alert(e);
			}
		}, null);
	}

}
function printKotCheckList() {
	var orderid = document.getElementById('orderNo').value;
	// var tableno=document.getElementById('tablenoCont').innerHTML;
	if (orderid == 0 || forspNoteData.length > 0) {
		// alert('Please save the order first!');
		showalertsaveorderModal();
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/printkotchecklist/" + orderid + ".htm", function(response) {
			try {
				if (response == 'Success')
					showKotCheckListPrintSuccessModal();
			} catch (e) {
				alert(e);
			}
		}, null);
	}
}
function showDirectPaymentforPacel() {
	var tableno = document.getElementById('tablenoCont').innerHTML;
	if (tableno == '0') {
		// for saravanaa
		// showparcelPaymentModal();
	}
}
function localPrint() {

	var divToPrint = document.getElementById('localPrint');
	document.getElementById('removePrint').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('removePrint').style.display = 'block';

	newWin.close();

}
function localPrint80px() {

	var divToPrint = document.getElementById('localPrint80px');
	document.getElementById('removePrint80px').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('removePrint80px').style.display = 'block';

	newWin.close();

}
function kotPrint() {

	var divToPrint = document.getElementById('kotPrint');
	document.getElementById('removeKotPrint').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.print();
	document.getElementById('removeKotPrint').style.display = 'block';

	newWin.close();

	var table_no = document.getElementById('modTabCont').innerHTML;
	order_no = document.getElementById('modOrderCont').innerHTML;
	// alert(table_no+':'+order_no+':'+itcatId);
	if (table_no == '0' && itcatId != '') {
		var option = document.getElementsByName("instantpayOption");
		var setOption = null;
		for ( var i = 0; i < option.length; i++) {
			if (option[i].checked == true) {
				selOption = option[i].value;
			}
		}
		// document.getElementById('hidinstantPaymentType').value=selOption;
		// document.getElementById('hidinstantPaymentFlag').value="Y";
		location.href = BASE_URL + '/order/vieworders.htm?ono=' + order_no + '&tno=' + table_no + '&sno=0' + '&itcno=' + itcatId + '&flg=Y&ptype=' + selOption;
	} else if (table_no == '0') {
		if (orderType == 'h') {
			location.href = BASE_URL + '/order/vieworderHD.htm?ono=' + order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=h';
		} else if (orderType == 's') {
			location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' + order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=s';
		} else if (orderType == 'z') {
			location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' + order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=z';
		} else {
			location.href = BASE_URL + '/order/vieworder.htm?ono=' + order_no + '&tno=' + table_no + '&sno=0';
		}

	} else {
		location.href = BASE_URL + '/table/viewtable.htm';
	}

}

function kotPrint58() {

	var divToPrint = document.getElementById('kotPrint58');
	document.getElementById('removeKotPrint58').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.print();
	document.getElementById('removeKotPrint58').style.display = 'block';

	newWin.close();

	var table_no = document.getElementById('modTabCont').innerHTML;
	order_no = document.getElementById('modOrderCont').innerHTML;
	// alert(table_no+':'+order_no+':'+itcatId);
	if (table_no == '0' && itcatId != '') {
		var option = document.getElementsByName("instantpayOption");
		var setOption = null;
		for ( var i = 0; i < option.length; i++) {
			if (option[i].checked == true) {
				selOption = option[i].value;
			}
		}
		// document.getElementById('hidinstantPaymentType').value=selOption;
		// document.getElementById('hidinstantPaymentFlag').value="Y";
		location.href = BASE_URL + '/order/vieworders.htm?ono=' + order_no + '&tno=' + table_no + '&sno=0' + '&itcno=' + itcatId + '&flg=Y&ptype=' + selOption;
	} else if (table_no == '0') {
		if (orderType == 'h') {
			location.href = BASE_URL + '/order/vieworderHD.htm?ono=' + order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=h';
		} else if (orderType == 's') {
			location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' + order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=s';
		} else if (orderType == 'z') {
			location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' + order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=z';
		} else {
			location.href = BASE_URL + '/order/vieworder.htm?ono=' + order_no + '&tno=' + table_no + '&sno=0';
		}

	} else {
		location.href = BASE_URL + '/table/viewtable.htm';
	}

}
function parcelPayment() {
	var option = document.getElementsByName("parcelpayOption");
	var payOption = null;
	for ( var i = 0; i < option.length; i++) {
		if (option[i].checked == true) {
			payOption = option[i].value;
		}
	}
	if (payOption == 'cash') {
		openCashModal();
	} else {
		openCardModal();
	}
}
var pmntTotAmt = document.getElementById('grandtotalcontId').innerHTML;
var netPrice = document.getElementById('amttopaycontId').innerHTML;
var netTotal = 0.0;
var hidstoreroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
var storedoubleroundoffflag = document.getElementById('hidstoredoubleroundoffFlag').value;
var paidAmnt = 0.0;
var amntToPay = 0.0;
function openCashModal() {
	netTotal = document.getElementById('hidnetTotal').value;
	document.getElementById('cashtenderAmt').value = '';
	document.getElementById('paycashalertMsg').innerHTML = '';
	document.getElementById('cashchangeamtcontId').innerHTML = '0.00';
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
	var temppaidAmt = 0.0;
	if (orderno == 0 || forspNoteData.length > 0) {
		// alert('Please save the order first!');
		showalertsaveorderModal();
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/" + orderno + ".htm", function(response) {
			try {
				var responseObj = [];
				responseObj = JSON.parse(response);
				for ( var i = 0; i < responseObj.length; i++) {
					temppaidAmt += responseObj[i].paidAmount;
				}
				paidAmnt = temppaidAmt;
				if (hidstoreroundoffflag == 'Y') {
					netTotal = Math.round(netTotal);
				}
				if (storedoubleroundoffflag == 'Y') {
					netTotal = round(netTotal, 1);
				}
				amntToPay = parseFloat(netTotal) - parseFloat(temppaidAmt);
				document.getElementById('cashmodOrderCont').innerHTML = orderno;
				document.getElementById('cashmodTabCont').innerHTML = tableno;
				document.getElementById('cashtotamtcontId').innerHTML = parseFloat(pmntTotAmt).toFixed(2);
				document.getElementById('cashpaidamtcontId').innerHTML = parseFloat(temppaidAmt).toFixed(2);
				if (temppaidAmt > 0) {
					$('#cashpaidamtdivId').removeClass('hide');
				}
				document.getElementById('cashamttopaycontId').innerHTML = parseFloat(amntToPay).toFixed(2);
				if (printpaidBill == 'N') {
					document.getElementById('chkprintBillCash').checked = false;
				}
				showCashModal();

			} catch (e) {
				alert(e);
			}
		}, null);

	}
}

function getChangeAmt(tenderAmt) {
	if (tenderAmt == '') {
		document.getElementById('cashchangeamtcontId').innerHTML = '0.00';
	} else if (parseFloat(amntToPay) >= parseFloat(tenderAmt)) {
		document.getElementById('cashchangeamtcontId').innerHTML = '0.00';
	} else {
		if ($.isNumeric(tenderAmt)) {
			document.getElementById('cashchangeamtcontId').innerHTML = parseFloat(parseFloat(tenderAmt) - parseFloat(amntToPay)).toFixed(2);
			// for vfd
			if (vfdPort.length > 3) {
				var changeAmt = tenderAmt - netTotal;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfdpay/" + "TOT IN RM : " + parseFloat(amntToPay).toFixed(2) + "/" + "BAL IN RM : " + parseFloat(changeAmt).toFixed(2) + ".htm", function() {
				}, null);
			}

		} else {
			document.getElementById('cashchangeamtcontId').innerHTML = getBaseLang.plsEntrVdNo;
		}

	}
}
function openCardModal() {
	netTotal = document.getElementById('hidnetTotal').value;
	document.getElementById('paycardalertMsg').innerHTML = '';
	document.getElementById('cardlastfourDigit').value = '';
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
	var temppaidAmt = 0.0;
	if (orderno == 0 || forspNoteData.length > 0) {
		// alert('Please save the order first!');
		showalertsaveorderModal();
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/" + orderno + ".htm", function(response) {
			try {
				var responseObj = [];
				responseObj = JSON.parse(response);
				for ( var i = 0; i < responseObj.length; i++) {
					temppaidAmt += responseObj[i].paidAmount;
				}
				paidAmnt = temppaidAmt;
				if (hidstoreroundoffflag == 'Y') {
					netTotal = Math.round(netTotal);
				}
				if (storedoubleroundoffflag == 'Y') {
					netTotal = round(netTotal, 1);
				}
				amntToPay = parseFloat(netTotal) - parseFloat(temppaidAmt);
				document.getElementById('cardmodOrderCont').innerHTML = orderno;
				document.getElementById('cardmodTabCont').innerHTML = tableno;
				document.getElementById('cardtotamtcontId').innerHTML = parseFloat(pmntTotAmt).toFixed(2);
				document.getElementById('cardpaidamtcontId').innerHTML = parseFloat(temppaidAmt).toFixed(2);
				if (temppaidAmt > 0) {
					$('#cardpaidamtdivId').removeClass('hide');
				}
				document.getElementById('cardamttopaycontId').innerHTML = parseFloat(amntToPay).toFixed(2);
				document.getElementById('cardtenderAmt').value = parseFloat(amntToPay).toFixed(2);
				if (printpaidBill == 'N') {
					document.getElementById('chkprintBillCard').checked = false;
				}
				showCardModal();
			} catch (e) {
				alert(e);
			}
		}, null);

	}
}
function checkCardType(cardType) {
	if (cardType == 'Visa') {
		document.getElementById('cardTypeName').value = cardType;
		document.getElementById('cardTypeNameDiv').style.display = 'none';
	}
	if (cardType == 'Master') {
		document.getElementById('cardTypeName').value = cardType;
		document.getElementById('cardTypeNameDiv').style.display = 'none';
	}
	if (cardType == 'Other') {
		document.getElementById('cardTypeName').value = "";
		document.getElementById('cardTypeNameDiv').style.display = 'block';
	}

}
function payByCash(tenderAmt) {
	var caseValue = $("#mobPrintVal").val();
	netTotal = document.getElementById('hidnetTotal').value;
	var orderno = document.getElementById('orderNo').value;
	if (isNaN(tenderAmt) || tenderAmt == '') {
		// alert('Please eneter a valid number!');
		document.getElementById('paycashalertMsg').innerHTML = getBaseLang.plsEntrVdNo;
		document.getElementById('cashtenderAmt').focus();
	} else {
		if (parseFloat(tenderAmt) >= parseFloat(amntToPay)) {
			paidAmnt = parseFloat(amntToPay);
			amntToPay = 0.0;
		} else {
			paidAmnt = parseFloat(tenderAmt);
			amntToPay = (parseFloat(amntToPay) - parseFloat(tenderAmt)).toFixed(2);
		}
		if (storedoubleroundoffflag == 'Y') {
			netTotal = round(netTotal, 1);
		}
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/" + orderno + "/" + netTotal + "/" + paidAmnt + "/" + amntToPay + "/" + tenderAmt + "/" + "cash" + "/" + "000" + ".htm", function(response) {
			try {
				if (response == 'success') {
					if (printpaidBill == 'N') {
						if (document.getElementById('chkprintBillCash').checked == true) {
							// alert('print cash');
							// printPaidBill(orderno);
							if (caseValue == 'Y') {
								cashOrcardPrintBill();
								
							} else {
								var ajaxCallObject = new CustomBrowserXMLObject();
								ajaxCallObject.callAjax(BASE_URL + "/order/printbill/" + orderno + ".htm", function(response) {
								}, null);
							}

							// alert(orderno);
						}

					}

					if (amntToPay > 0) {
						document.getElementById('amttopaycontId').innerHTML = parseFloat(amntToPay).toFixed(2);
						hideCashModal();
					} else {
						if (document.getElementById('cashmodTabCont').innerHTML == '0' && itcatId != '') {
							location.href = BASE_URL + '/order/vieworders.htm?ono=0&tno=0&sno=0' + '&itcno=' + itcatId + '&flg=N&ptype=';
						} else {
							if (cdrawerCode.length > 0) {
								hideCashModal();
								var toPay = document.getElementById('cashamttopaycontId').innerHTML;
								var changeAmt = parseFloat(parseFloat(tenderAmt) - parseFloat(toPay)).toFixed(2);
								// document.getElementById('cashchangeamtmodcontId').innerHTML=document.getElementById('cashchangeamtcontId').innerHTML;
								document.getElementById('cashamttopaymodcontId').innerHTML = parseFloat(toPay).toFixed(2);
								document.getElementById('cashtenderAmtmodcontId').innerHTML = parseFloat(tenderAmt).toFixed(2);
								document.getElementById('cashchangeamtmodcontId').innerHTML = parseFloat(changeAmt).toFixed(2);
								showCashChangeAmtModal();
							} else {
								location.href = BASE_URL + '/table/viewtable.htm';
							}
						}
					}
				}
			} catch (e) {
				alert(e);
			}
		}, null);
	}

	/*var tenderAmountField = $('#cashtenderAmt').val();

	if(tenderAmountField >= 0){

	                cashOrcardPrintBill();
	                location.href = BASE_URL + '/table/viewtable.htm';

	}*/
}
function payByCard(tenderAmt) {
	var caseValue = $("#mobPrintVal").val();
	netTotal = document.getElementById('hidnetTotal').value;
	var orderno = document.getElementById('orderNo').value;
	var lastfourdigit = document.getElementById('cardlastfourDigit').value;
	var cardType = document.getElementById('cardTypeName').value;

	if (isNaN(tenderAmt) || tenderAmt == '') {
		document.getElementById('paycardalertMsg').innerHTML = getBaseLang.plsEntrVdNo;
		document.getElementById('cardtenderAmt').focus();
	} else if (cardType == '') {
		document.getElementById('paycardalertMsg').innerHTML = getBaseLang.plsEntrCardType;
	} else if (!parseFloat(lastfourdigit)) {
		document.getElementById('paycardalertMsg').innerHTML = getBaseLang.plsEntrVldCardNo;
		document.getElementById('cardlastfourDigit').focus();
	} else if (isNaN(lastfourdigit) || lastfourdigit.length != 4) {
		// alert('Please enter 4 digit valid card number!');
		document.getElementById('paycardalertMsg').innerHTML = getBaseLang.plsEntr4DgtNo;
		document.getElementById('cardlastfourDigit').focus();
	}

	else {
		if (lastfourdigit == '') {
			lastfourdigit = 'xxxx';
		}
		if (parseFloat(tenderAmt).toFixed(2) >= parseFloat(amntToPay).toFixed(2)) {
			paidAmnt = parseFloat(amntToPay).toFixed(2);
			amntToPay = 0.0;
		} else {
			paidAmnt = parseFloat(tenderAmt).toFixed(2);
			amntToPay = parseFloat(amntToPay).toFixed(2) - parseFloat(tenderAmt).toFixed(2);
		}
		if (storedoubleroundoffflag == 'Y') {
			netTotal = round(netTotal, 1);
		}
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/" + orderno + "/" + netTotal + "/" + paidAmnt + "/" + amntToPay + "/" + tenderAmt + "/" + cardType + "/" + lastfourdigit + ".htm", function(response) {
			try {
				if (response == 'success') {
					if (printpaidBill == 'N') {
						if (document.getElementById('chkprintBillCard').checked == true) {
							// alert('print card');
							// printPaidBill(orderno);
							if (caseValue == 'Y') {
								cashOrcardPrintBill();
							} else {
								var ajaxCallObject = new CustomBrowserXMLObject();
								ajaxCallObject.callAjax(BASE_URL + "/order/printbill/" + orderno + ".htm", function(response) {
								}, null);
							}
							// alert(orderno);
						}

					}

					if (amntToPay > 0) {
						document.getElementById('amttopaycontId').innerHTML = parseFloat(amntToPay).toFixed(2);
						hideCardModal();
					} else {
						if (document.getElementById('cardmodTabCont').innerHTML == '0' && itcatId != '') {
							location.href = BASE_URL + '/order/vieworders.htm?ono=0&tno=0&sno=0' + '&itcno=' + itcatId + '&flg=N&ptype=';
						} else {
							location.href = BASE_URL + '/table/viewtable.htm';
						}
					}
				}
			} catch (e) {
				alert(e);
			}
		}, null);
	}

	/*if (isNaN(lastfourdigit) || lastfourdigit.length == 4){

	    cashOrcardPrintBill();

	    location.href = BASE_URL + '/table/viewtable.htm';

	}*/
}

function openOnlineModal()
{
	netTotal=document.getElementById('hidnetTotal').value;
	document.getElementById('paycardalertMsg').innerHTML='';
	var orderno=document.getElementById('orderNo').value;
	var tableno=document.getElementById('tablenoCont').innerHTML;
	var temppaidAmt=0.0;
	if(orderno==0 || forspNoteData.length>0)
	{
		showalertsaveorderModal();
	}
	else
	{
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getpaymenttypebystore.htm", function(response) {
			try{
				//console.log("getpaymenttypebystore="+response);
				if('null'==response){
					$("#notavailableonlinepaymentModal").modal("show");
				}else{
				var responseObjpaymenttype=JSON.parse(response);
				console.log("responseObjpaymenttype="+response);
				console.log(responseObjpaymenttype.paymentTypes[0].paymentTypeName);
				if(responseObjpaymenttype.size==1){
					ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/"+orderno + ".htm", function(response) {
						try{
							var responseObj=[];
							responseObj=JSON.parse(response);
							for(var i=0;i<responseObj.length;i++)
							{
								temppaidAmt+=responseObj[i].paidAmount;
							}
							paidAmnt=temppaidAmt;
							if(hidstoreroundoffflag=='Y')
								{
								netTotal=Math.round(netTotal);
								}
							if(storedoubleroundoffflag=='Y')
							{
							netTotal=round(netTotal,1);
							}
							amntToPay=parseFloat(netTotal)-parseFloat(temppaidAmt);
							document.getElementById('onlinemodOrderCont').innerHTML=orderno;
							document.getElementById('onlinemodTabCont').innerHTML=tableno;
							document.getElementById('onlinetotamtcontId').innerHTML=parseFloat(pmntTotAmt).toFixed(2);
							document.getElementById('onlinepaidamtcontId').innerHTML=parseFloat(temppaidAmt).toFixed(2);
							document.getElementById('onlineamttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
							document.getElementById('onlinetenderAmt').value=parseFloat(amntToPay).toFixed(2);
							document.getElementById('onlineselpaymenttype').innerHTML=responseObjpaymenttype.paymentTypes[0].paymentTypeName;
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
}
function getSelectedPaymentTypeval(){
	var selectedPaymentType =$( 'input[name=paymenttypeopt]:checked' ).val();
	console.log("selectedPaymentType="+selectedPaymentType);
}
function getpaymod(){
	var selectedPaymentType =$( 'input[name=paymenttypeopt]:checked' ).val();
	if(selectedPaymentType==undefined){
		$("#paymodeselectiontext").text(getBaseLang.selctPaymentMode);
	}else{
		$("#paymodeselectiontext").text("");
		$("#paymodeselectionModal").modal("hide");
		netTotal=document.getElementById('hidnetTotal').value;
		document.getElementById('paycardalertMsg').innerHTML='';
		var orderno=document.getElementById('orderNo').value;
		var tableno=document.getElementById('tablenoCont').innerHTML;
		var temppaidAmt=0.0;
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/"+orderno + ".htm", function(response) {
			try{
				var responseObj=[];
				responseObj=JSON.parse(response);
				for(var i=0;i<responseObj.length;i++)
				{
					temppaidAmt+=responseObj[i].paidAmount;
				}
				paidAmnt=temppaidAmt;
				if(hidstoreroundoffflag=='Y')
					{
					netTotal=Math.round(netTotal);
					}
				if(storedoubleroundoffflag=='Y')
				{
				netTotal=round(netTotal,1);
				}
				amntToPay=parseFloat(netTotal)-parseFloat(temppaidAmt);
				document.getElementById('onlinemodOrderCont').innerHTML=orderno;
				document.getElementById('onlinemodTabCont').innerHTML=tableno;
				document.getElementById('onlinetotamtcontId').innerHTML=parseFloat(pmntTotAmt).toFixed(2);
				document.getElementById('onlinepaidamtcontId').innerHTML=parseFloat(temppaidAmt).toFixed(2);
				document.getElementById('onlineamttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
				document.getElementById('onlinetenderAmt').value=parseFloat(amntToPay).toFixed(2);
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

function payByOnline(tenderAmt){
	$("#onlineModal").modal("hide");
	var caseValue = $("#mobPrintVal").val();
	netTotal=document.getElementById('hidnetTotal').value;
	var orderno=document.getElementById('orderNo').value;
	var paymentType=$('#selpaymentmode').val();
	if(isNaN(tenderAmt)|| tenderAmt=='')
	{
		document.getElementById('payonlinealertMsg').innerHTML='Please enter a valid number!';
		document.getElementById('onlinetenderAmt').focus();
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
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/"+orderno +"/"+ netTotal+"/"+ paidAmnt+"/"+ amntToPay+"/"+tenderAmt+"/"+paymentType.split("_")[0]+"/"+paymentType.split("_")[1] + ".htm", function(response) {
	try{
		if(response=='success')
			{
			if(printpaidBill=='N')
			{
				
				if(document.getElementById('chkprintBillCard').checked==true)
					{
					//alert('print card');
					//printPaidBill(orderno);
					/*var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderno+ ".htm", function(response) {
						}, null);*/
					//alert(orderno);
					if (caseValue == 'Y') {
						
						cashOrcardPrintBill();
					} else {
						var ajaxCallObject = new CustomBrowserXMLObject();
						ajaxCallObject.callAjax(BASE_URL + "/order/printbill/" + orderno + ".htm", function(response) {
						}, null);
					}
					}
			}
			if(amntToPay>0)
			{
				document.getElementById('amttopaycontId').innerHTML=parseFloat(amntToPay).toFixed(2);
				$("#onlineModal").modal("hide");
			}
			else
				{
					if(document.getElementById('cardmodTabCont').innerHTML=='0' && itcatId!='')
					{
						location.href=BASE_URL+'/order/vieworders.htm?ono=0&tno=0&sno=0'+'&itcno='+itcatId+'&flg=N&ptype=';
					}
					else{
						if (caseValue == 'Y') {
							cashOrcardPrintBill();
						}
						location.href=BASE_URL+'/table/viewtable.htm';
						
						
						}
				}
			}
		}catch(e){alert(e);}
	}, null);
	
}

function openAddDiscount() {
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
	var totAmt = document.getElementById('grandtotalcontId').innerHTML;
	var totnonspotDiscAmt = document.getElementById('hidtotnonspotDiscAmt').value;
	if (orderno == 0 || forspNoteData.length > 0) {
		// alert('Please save the order first!');
		showalertsaveorderModal();
	} else {
		document.getElementById('discmodOrderCont').innerHTML = orderno;
		document.getElementById('discmodTabCont').innerHTML = tableno;
		document.getElementById('discmodtotamtcontId').innerHTML = totAmt;
		document.getElementById('discmoddiscountableamtcontId').innerHTML = parseFloat(totAmt - totnonspotDiscAmt).toFixed(2);
		if (totnonspotDiscAmt > 0) {
			$('#totdiscountableAmtrowId').removeClass('hide');
		}
		showaddDiscountModal();
	}

}
function calculateDiscAmt(per) {
	var totAmount = document.getElementById('discmodtotamtcontId').innerHTML;
	var totdiscountableAmount = document.getElementById('discmoddiscountableamtcontId').innerHTML;
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var discAmt = 0.0;
	if (per == '') {
		document.getElementById('discModdiscAmt').value = '0.00';
	} else if (!isNaN(per)) {
		discAmt = parseFloat(totdiscountableAmount).toFixed(2) * parseFloat(per).toFixed(2) / 100;
		if (storeroundoffflag == 'Y') {
			discAmt = Math.round(discAmt);
		}
		document.getElementById('discModdiscAmt').value = parseFloat(discAmt).toFixed(2);
	}
}

$('#ncbill').click(function() {
	if ($(this).prop("checked") == true) {
		$("#trdiscperc").hide();
		$("#trdiscamt").hide();
	} else if ($(this).prop("checked") == false) {
		$("#trdiscperc").show();
		$("#trdiscamt").show();
	}
});
function AddDiscount() {
	var orderid = document.getElementById('discmodOrderCont').innerHTML;
	var discper = document.getElementById('discModdiscPer').value;
	var discamt = document.getElementById('discModdiscAmt').value;
	var storediscflag = document.getElementById('discmodstorediscFlagcontId').value;
	var storecurrency = document.getElementById('discmodstorecurrencycontId').value;
	var netAmt = document.getElementById('amttopaycontId').innerHTML;
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var discreason = $("#discreason").val();
	var isnoncharge = 'N';
	if ($('#ncbill').is(':checked')) {
		discper = 100;
		discamt = parseFloat(netAmt).toFixed(2);
		isnoncharge = 'Y';
	}
	var nettot = 0.0;

	if (isNaN(discper) || isNaN(discamt) || discper == '' || discamt == '') {
		document.getElementById('discAddalertMsg').innerHTML = getBaseLang.plsEntrVdNo;
	} else if (discper > 100) {
		document.getElementById('discAddalertMsg').innerHTML = getBaseLang.discNotmrthn;
	} else if ($.trim(discreason) == '') {
		document.getElementById('discAddalertMsg').innerHTML = getBaseLang.discreason;
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/adddiscount/" + orderid + "/" + discper + "/" + discamt + "/" + discreason + "/" + isnoncharge + ".htm", function(response) {
			try {
				if (response == 'success') {
					nettot = netAmt - discamt;
					if (storediscflag == 'Y') {
						document.getElementById('discBtnContId').style.width = '';
						document.getElementById('discPerContId').innerHTML = getBaseLang.discount + discper + '%:';
						document.getElementById('discBtnContId').innerHTML = discamt;
						if (storeroundoffflag == 'Y') {
							nettot = Math.round(nettot);
						}
						document.getElementById('amttopaycontId').innerHTML = parseFloat(nettot).toFixed(2);
					} else {
						document.getElementById('discPerContId').innerHTML = getBaseLang.discIn + storecurrency + ':';
						document.getElementById('discBtnContId').innerHTML = discamt;
						if (storeroundoffflag == 'Y') {
							nettot = Math.round(nettot);
						}
						document.getElementById('amttopaycontId').innerHTML = parseFloat(nettot).toFixed(2);
					}
					document.getElementById('hidnetTotal').value = nettot;
					closeaddDiscountModal();
				} else {
					document.getElementById('discAddalertMsg').innerHTML = '' + response + '';
				}
			} catch (e) {
				alert(e);
			}
		}, null);
	}
}
function totPaidAmount(orderno) {
	var totPaidAmt = 0.0;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/" + orderno + ".htm", function(response) {
		try {
			var responseObj = [];
			responseObj = JSON.parse(response);
			for ( var i = 0; i < responseObj.length; i++) {
				totPaidAmt += responseObj[i].paidAmount;
			}
		} catch (e) {
			alert(e);
		}
	}, null);
	return totPaidAmt;
}
var selectedRows = [];
function selectAllRow() {
	var checkboxes = document.getElementsByTagName('input');
	for ( var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].type == 'checkbox') {
			if (checkboxes[i].checked) {
			} else {
				checkboxes[i].checked = true;
				chkid = checkboxes[i].id;
				document.getElementById('row_' + chkid.substr(4)).style.background = '#373737';
				selectedRows.push(chkid.substr(4));
			}
		}
	}
}
function selectRow(trId) {
	if (document.getElementById('chk_' + trId).checked == false) {
		document.getElementById('row_' + trId).style.background = '#373737';
		document.getElementById('chk_' + trId).checked = true;
		selectedRows.push(trId);
	} else {
		document.getElementById('row_' + trId).style.background = '#222222';
		document.getElementById('chk_' + trId).checked = false;
		selectedRows.splice(selectedRows.indexOf(trId), 1);
	}
}
function checkRow(	trId,
					chk) {
	if (chk.checked) {
		document.getElementById('row_' + trId).style.background = '#373737';
		selectedRows.push(trId);
	} else {
		document.getElementById('row_' + trId).style.background = '#222222';
		selectedRows.splice(selectedRows.indexOf(trId), 1);
	}
}
function deleteRows() {
	if (selectedRows.length > 0) {
		showconfirmdeleteOrderItemModal();
		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/order/deleteitems/"+selectedRows +
		 * ".htm", function(response) { try{ var
		 * responseObj=JSON.parse(response); prepareOrderHtml(responseObj);
		 * }catch(e) { alert(e); } }, null); selectedRows = [];
		 */
	} else {
		showselectitemalertModal();
	}
}
function deleteorderItemRow() {
	var noofremoveItem = selectedRows.length;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/deleteitems/" + selectedRows + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			prepareOrderHtml(responseObj);
			if (vfdPort.length > 3) {
				var tot = document.getElementById('amttopaycontId').innerHTML;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" + noofremoveItem + " ITEM(S) REMOVED" + "/" + "TOT IN RM : " + parseFloat(tot).toFixed(2) + ".htm", function() {
				}, null);
			}
		} catch (e) {
			alert(e);
		}
	}, null);
	selectedRows = [];
}
function openpecialNoteModal() {

	var spnoteitemlistContId = document.getElementById('spnoteitemlistContId');
	var createdtd = "";
	if (storeID == 37 || storeID == 38) {
		if (forspNoteData.length > 0) {
			for ( var i = 0; i < forspNoteData.length; i++) {
				var item = forspNoteData[i];
				var spnote = item.specialNote == undefined ? "" : item.specialNote;
				var namediv = "<div style='text-align: left;'>" + item.itemName + "</div>";
				var inputdiv = "<div style='color: #000'><input type='text' style='width:60%;' value='" + spnote + "' id='spnoteinput_" + item.itemId + "'>&nbsp;&nbsp;<button type='button' onclick='javascript:getspecialNotebyitemIdOnly(" + item.itemId + ",&quot;" + item.itemName + "&quot;);' style='background: #72BB4F;font-weight: bold;height:30px;'  class='btn btn-success'>" + getBaseLang.getNote + "</button></div>";
				createdtd += namediv + inputdiv;
			}
			spnoteitemlistContId.innerHTML = createdtd;
			showspecialnoteModal();
		} else {
			// alert('Please select any item!');
			showselectitemalertModal();
		}
	} else {
		/*var spnoteitemlistContId = document
				.getElementById('spnoteitemlistContId');
		var createdtd = "";*/
		if (forspNoteData.length > 0) {
			for ( var i = 0; i < forspNoteData.length; i++) {
				var item = forspNoteData[i];
				var spnote = item.specialNote == undefined ? "" : item.specialNote;
				var namediv = "<div style='text-align: left;'>" + item.itemName + "</div>";
				var inputdiv = "<div style='color: #000'><input type='text' style='width:60%;' value='" + spnote + "' id='spnoteinput_" + item.itemId + "'>&nbsp;&nbsp;<button type='button' onclick='javascript:getspecialNotebyitemId(" + item.itemId + ",&quot;" + item.itemName + "&quot;);' style='background: #72BB4F;font-weight: bold;height:30px;'  class='btn btn-success'>" + getBaseLang.getNote + "</button></div>";
				createdtd += namediv + inputdiv;
			}
			spnoteitemlistContId.innerHTML = createdtd;
			showspecialnoteModal();
		} else {
			// alert('Please select any item!');
			showselectitemalertModal();
		}
	}
}

function getspecialNotebyitemIdOnly(itemid,
									itemname) {
	var spnotecontId = document.getElementById("specialnoteforOrderContainerId");
	var headeritemname = document.getElementById("headerforitemnamespnote");
	document.getElementById("itemidforsetsplnote").value = itemid;
	var spnoteHtml = "";
	var createdrowline = "";
	var begintable = "<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222;'>";
	var endtable = "</table>";
	headeritemname.innerHTML = itemname;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getspecialnotesbyitemid/" + itemid + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			if (responseObj.length > 0) {
				for ( var i = 0; i < responseObj.length; i++) {
					var spnote = responseObj[i];
					var begintr = "<tr style='background:#404040; color:#FFF;'>";
					var firsttd = "<td>" + spnote.menuItem.name + "</td>";
					var secondtd = "<td><input type='checkbox' name='specialnote' value='" + spnote.menuItem.name + "'/></td>";
					var endtr = "</tr>";
					createdrowline += begintr + firsttd + secondtd + endtr;
				}
				spnotecontId.innerHTML = begintable + createdrowline + endtable;
			} else {
				spnotecontId.innerHTML = getBaseLang.noSplNoteFound;
			}
			// prepareOrderHtml(responseObj);
		} catch (e) {
			alert(e);
		}
	}, null);
	showspecialNoteforOrderModal();
}

function getspecialNotebyitemId(itemid,
								itemname) {
	// alert(itemid);
	var count;
	var storewisesplnote = document.getElementById("hidstorespltype").value;
	var spnotecontId = document.getElementById("specialnoteforOrderContainerId");
	var headeritemname = document.getElementById("headerforitemnamespnote");
	document.getElementById("itemidforsetsplnote").value = itemid;
	var spnoteHtml = "";
	var createdrowline = "";
	/*
	 * var createdcoloumnline=""; var begintable="<table class='table
	 * table-striped table-bordered' style='color:#FFF; border:1px solid
	 * #222222;'>"; var endtable="</table>";
	 */
	headeritemname.innerHTML = itemname;
	var ajaxCallObject = new CustomBrowserXMLObject();
	if (storewisesplnote == "item_wise") {
		ajaxCallObject.callAjax(BASE_URL + "/order/getspecialnotesbyitemid/" + itemid + ".htm", function(response) {
			try {
				var responseObj = JSON.parse(response);
				if (responseObj.length > 0) {
					count = 0;
					for ( var i = 0; i < responseObj.length; i++) {
						var spnote = responseObj[count];
						count++;
						createdrowline += "<label class='check-label'<div class='btn-order-taking' style='background:" + spnote.menuItem.bgColor + ";text-align:center;height:80px;width:30%;margin:6px;border-radius: 30px 3px;'><div>" + spnote.menuItem.name + "</div><div style='font-size:11px;white-space:normal;'> <td><input type='checkbox' name='specialnote' value='" + spnote.menuItem.name + "'/></td></div></div></label>";
						spnotecontId.innerHTML = createdrowline;

					}
				} else {
					spnotecontId.innerHTML = getBaseLang.noSplNoteFound;
				}
			} catch (e) {
				alert(e);
			}
		}, null);
	} else if (storewisesplnote == "store_wise") {
		ajaxCallObject.callAjax(BASE_URL + "/order/getspecialnotesforstore.htm", function(response) {
			try {
				var responseObj = JSON.parse(response);
				//count = 0;
				for ( var i = 0; i < responseObj.menucategory.length; i++) {
					var jsonmenucategory = responseObj.menucategory[i];

					for ( var j = 0; j < jsonmenucategory.menucategory.length; j++) {
						var jsonmenucategory2 = jsonmenucategory.menucategory[j];
						for ( var k = 0; k < jsonmenucategory2.items.length; k++) {
							var jsonmenucategoryitem = jsonmenucategory2.items[k];
							//count++
							//alert(jsonmenucategoryitem.name);;
							createdrowline += "<label class='check-label'<div class='btn-order-taking' style='background:" + jsonmenucategoryitem.bgColor + ";text-align:center;height:80px;width:30%;margin:6px;border-radius: 30px 3px;'><div>" + jsonmenucategoryitem.name + "</div><div style='font-size:11px;white-space:normal;'> <td><input type='checkbox' name='specialnote' value='" + jsonmenucategoryitem.name + "'/></td></div></div></label>";
							spnotecontId.innerHTML = createdrowline;

						}
					}

				}
				/*
				 * } else { spnotecontId.innerHTML = "No special
				 * note found!"; }
				 */
				// prepareOrderHtml(responseObj);
			} catch (e) {
				alert(e);
			}
		}, null);
	}
	showspecialNoteforOrderModal();

}
function setspecialNoteforOrder() {
	var itemid = document.getElementById("itemidforsetsplnote").value;
	var spclvalue = "";
	var selectedspnotefororderRows = [];
	var checkboxes = document.getElementsByName('specialnote');
	for ( var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			selectedspnotefororderRows.push(checkboxes[i].value);
		}
	}
	if (selectedspnotefororderRows.length > 0) {
		for ( var i = 0; i < selectedspnotefororderRows.length; i++) {
			spclvalue += selectedspnotefororderRows[i] + ",";
		}

	}
	// closespecialNoteforOrderModal();
	var prevnote = document.getElementById("spnoteinput_" + itemid).value;
	document.getElementById("spnoteinput_" + itemid).value = prevnote + spclvalue;
}
function cancelSpecialNote(){
	
}
function savespecialNote() {

	for ( var i = 0; i < forspNoteData.length; i++) {
		var item = forspNoteData[i];
		var id = item.itemId;
		var note = decodeURIComponent(document.getElementById('spnoteinput_' + item.itemId).value);
//		 alert(id+':'+note);

		//document.getElementById('specialAlert').innerHTML = getBaseLang.plsEnterSpecialNote;
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/addspecialnote/" + id + "/" + note + ".htm", function() {
		}, null);
	}

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/showspecialnote.htm", function(response) {
		try {
			// alert(response);
			forspNoteData = [];
			var responseObj = JSON.parse(response);
			if (responseObj.length > 0) {
				for ( var i = 0; i < responseObj.length; i++) {
					var item = responseObj[i];
					forspNoteData.push(item);
				}
			}
		} catch (e) {
			alert(e);
		}
	}, null);

}

function instantPaymentOpenModal() {
	// alert('instant');
	var flag = document.getElementById('hidinstantPaymentFlag').value;
	var ptype = document.getElementById('hidinstantPaymentType').value;
	if (flag == 'Y') {
		if (ptype == 'cash') {
			openCashModal();
		} else {
			openCardModal();
		}
	}
}

/* start credit sale */
function openCreditSaleModal() {
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
	document.getElementById("creditsalemodOrderCont").innerHTML = orderno;
	document.getElementById("creditsalemodTabCont").innerHTML = tableno;
	document.getElementById("creditsalecustname").value = "";
	document.getElementById("creditsalecustcontact").value = "";
	document.getElementById("hidcredisalecustid").value = "";
	document.getElementById('creditsalecustdetailcontId').innerHTML = "";
	document.getElementById("creditsalepaymentdetailcontId").innerHTML = "";
	document.getElementById("creditsalepayButton").disabled = true;
	document.getElementById('paycreditsalealertMsg').innerHTML = '';
	if (orderno == 0 || forspNoteData.length > 0) {
		showalertsaveorderModal();
	} else {
		showCreditSaleModal();
	}
}
function showcreditsalePaydetail(val) {
	var createdline = "";
	var netPrice = document.getElementById('amttopaycontId').innerHTML;
	var line1 = "<div style='padding: 5px;'>Total Amount :&nbsp;&nbsp;&nbsp;" + parseFloat(pmntTotAmt).toFixed(2) + "</div>";
	var line2 = "<div style='padding: 5px;'>Amount to Pay :&nbsp;&nbsp;&nbsp;" + parseFloat(netPrice).toFixed(2) + "</div>";
	var line3 = "<div style='padding: 3px;'>" + getBaseLang.tndrAmount + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type='text' id='creditsaletenderAmount' style='text-align:center; color: #222222' size='4'/> </div>";
	// var line4="<div style='padding: 5px;'>Card Last 4 Digit :&nbsp;<input
	// type='text' id='creditsalecardlastfourDigit' style='text-align:center;
	// color: #222222' size='4'/> </div>";
	if (val == 'cash') {
		createdline = line1 + line2 + line3;
		document.getElementById('creditsalecardlastfourDigit').value = "0000";
		document.getElementById("hidcreditsalelastfourdigitcontid").style.display = "none";
		document.getElementById('paycreditsalealertMsg').innerHTML = "";
	} else if (val == 'card') {
		createdline = line1 + line2 + line3;
		document.getElementById('paycreditsalealertMsg').innerHTML = "";
	}
	document.getElementById("creditsalepaymentdetailcontId").innerHTML = createdline;
	if (val == 'card') {
		document.getElementById('creditsalecardlastfourDigit').value = "";
		document.getElementById("hidcreditsalelastfourdigitcontid").style.display = "block";
	}
	document.getElementById("creditsalepayButton").disabled = false;
}
function payCreditSale() {

	var netAmt = document.getElementById('hidnetTotal').value;
	var orderno = document.getElementById('orderNo').value;
	var custid = document.getElementById('hidcredisalecustid').value;
	var option = document.getElementsByName("creditsalepayOption");
	var lastdigit = document.getElementById('creditsalecardlastfourDigit').value;
	var selOption = null;
	for ( var i = 0; i < option.length; i++) {
		if (option[i].checked == true) {
			selOption = option[i].value;
		}
	}
	var tenderAmt = 0;
	if (selOption == 'nopay') {
		tenderAmt = 0;
	} else {
		tenderAmt = document.getElementById('creditsaletenderAmount').value;
	}

	// alert('net:'+netAmt+':ord:'+orderno+':cust:'+custid+':payoption:'+selOption+':tender:'+tenderAmt+':lastdigit:'+lastdigit);
	if (isNaN(tenderAmt) || tenderAmt === '') {
		// alert('Please eneter a valid number!');
		document.getElementById('paycreditsalealertMsg').innerHTML = getBaseLang.plsEntrVdNo;
		document.getElementById('creditsaletenderAmount').focus();
	}

	else if (isNaN(lastdigit)) {
		// alert('Please enter a valid card number!');
		document.getElementById('paycreditsalealertMsg').innerHTML = getBaseLang.plsEntrVldCardNo;
		document.getElementById('creditsalecardlastfourDigit').focus();
	} else if (lastdigit.length != 4) {
		// alert('Please enter 4 digit valid card number!');
		document.getElementById('paycreditsalealertMsg').innerHTML = getBaseLang.plsEntr4DgtNo;
		document.getElementById('creditsalecardlastfourDigit').focus();
	} else {
		var amttoPay = parseFloat(netAmt).toFixed(2) - tenderAmt;
		// alert('success:'+amttoPay);
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/updatecreditsalestatus/" + orderno + "/" + custid + ".htm", function(response) {
			try {
				// alert(response);
				if (response == 'success') {
					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/" + orderno + "/" + netAmt + "/" + parseFloat(tenderAmt).toFixed(2) + "/" + amttoPay + "/" + tenderAmt + "/" + selOption + "/" + lastdigit + ".htm", function(response) {
						try {
							// alert(response);
							if (response == 'success') {
								hideCreditSaleModal();
								location.href = BASE_URL + '/table/viewtable.htm';

							}
						} catch (e) {
							alert(e);
						}
					}, null);

				}
			} catch (e) {
				alert(e);
			}
		}, null);
	}
}
/* end credit sale */
/* add no of pax */
function addnoofPax(noofPax) {
	// alert(noofPax);
	var orderno = document.getElementById('orderNo').value;
	// alert(orderno);
	if (!parseInt(noofPax)) {
		document.getElementById('paxalertMsg').innerHTML = getBaseLang.plsEntrCorctVal;
	} else {
		if (orderno == '0') {
			document.getElementById('noofPaxId').innerHTML = noofPax;
			document.getElementById('hidnoofPax').value = noofPax;
			closePaxModal();
		} else {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/updatepax/" + orderno + "/" + noofPax + ".htm", function(response) {
				try {
					// alert(response);
					if (response == 'success') {
						document.getElementById('noofPaxId').innerHTML = noofPax;
						document.getElementById('hidnoofPax').value = noofPax;
						closePaxModal();
					} else {
						document.getElementById('paxalertMsg').innerHTML = '' + response + '';
					}
				} catch (e) {
					alert(e);
				}
			}, null);
		}

	}
}
/* end add no of pax */
/* start change table */
function showchangeTable() {
	var tableno = document.getElementById('tablenoCont').innerHTML;
	if (tableno != '0') {
		openChangeTableModal();
	}
}
function updateTableNo(tabVal) {
	var orderno = document.getElementById('orderNo').value;
	var res = tabVal.split('~');
	var tabno = res[0];
	var tabstat = res[1];
	if (tabstat == 'Y') {
		document.getElementById('changetablealertMsg').innerHTML = getBaseLang.tableNo + tabno + getBaseLang.isBooked;
	} else {
		if (orderno == '0') {
			document.getElementById('tablenoCont').innerHTML = tabno;
			closeChangeTableModal();
		} else {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/updatetable/" + orderno + "/" + tabno + ".htm", function(response) {
				try {
					// alert(response);
					if (response == 'success') {
						document.getElementById('tablenoCont').innerHTML = tabno;
						closeChangeTableModal();
					} else {
						document.getElementById('changetablealertMsg').innerHTML = '' + response + '';
					}
				} catch (e) {
					alert(e);
				}
			}, null);
		}
	}
}
/* end change table */
/* start split bill */
function openSplitBill(storeid) {
	$("#submitSplitBillBut").hide();
	document.getElementById('splitBillContainerId').innerHTML = "";
	document.getElementById('splitbillalertMsg').innerHTML = "";
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
	if (orderno != 0 && tableno != '0') {
		// alert('Please save the order first!');
		if (storeid == 37 || storeid == 38 || storeid == 111) {
			var noofPax = document.getElementById('noofPaxId').innerHTML;
			var NOPAX = parseInt(noofPax);
			document.getElementById('noofsplitBill').value = NOPAX;
		} else {
			document.getElementById('noofsplitBill').value = 2;
		}

		document.getElementById('splitbillmodOrderCont').innerHTML = orderno;
		document.getElementById('splitbillmodTabCont').innerHTML = tableno;

		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlistbyoderid/" + orderno + ".htm", function(response) {
			if (response == 'success') {
				showsplitBillModal();
			}
		}, null);

	}

}

var splitservicetaxText = document.getElementById('hidserviceTaxTextVal').value;
var splitvattaxText = document.getElementById('hidvatTaxTextVal').value;
var splitvatAmt = document.getElementById('hidvatTaxVal').value;
var splitstaxAmt = document.getElementById('hidserviceTaxVal').value;
function showSplitBillContent(	pax,
								storeid) {
	$("#submitSplitBillBut").show();
	if (storeid == 37 || storeid == 38) {
		var noofPax = document.getElementById('noofPaxId').innerHTML;
		/*
		 * var
		 * servicetaxText=document.getElementById('hidserviceTaxTextVal').value;
		 * var vattaxText=document.getElementById('hidvatTaxTextVal').value; var
		 * vatAmt=document.getElementById('hidvatTaxVal').value; var
		 * staxAmt=document.getElementById('hidserviceTaxVal').value;
		 */
		var billsplittype = $('input:radio[name=radioGroup]:checked').val();
		if (billsplittype == 1) {
			// item wise split
			if (parseInt(pax) > 1 && parseInt(pax) <= parseInt(noofPax)) {
				generateHTMLForItemWiseSplitting(pax);
			}
		} else {
			// category wise split
			if (parseInt(pax) > 1 && parseInt(pax) <= parseInt(noofPax)) {
				var orderno = document.getElementById('orderNo').value;
				var tableno = document.getElementById('tablenoCont').innerHTML;
				if (orderno != 0 && tableno != '0') {
					// alert('Please save the order first!');

					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlistcategorywisebyoderid/" + orderno + ".htm", function(response) {
						if (response == 'success') {
							// showsplitBillModal();
						}
					}, null);
					generateHTMLForCategoryWiseSplitting(pax);
				}

			}
		}

	} else {
		/*
		 * var
		 * servicetaxText=document.getElementById('hidserviceTaxTextVal').value;
		 * var vattaxText=document.getElementById('hidvatTaxTextVal').value; var
		 * vatAmt=document.getElementById('hidvatTaxVal').value; var
		 * staxAmt=document.getElementById('hidserviceTaxVal').value;
		 */
		var billsplittype = $('input:radio[name=radioGroup]:checked').val();
		if (billsplittype == 1) {
			// item wise split
			generateHTMLForItemWiseSplitting(pax);
		} else {
			// category wise split
			var orderno = document.getElementById('orderNo').value;
			var tableno = document.getElementById('tablenoCont').innerHTML;
			if (orderno != 0 && tableno != '0') {
				// alert('Please save the order first!');

				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlistcategorywisebyoderid/" + orderno + ".htm", function(response) {
					if (response == 'success') {
						// showsplitBillModal();
					}
				}, null);
				generateHTMLForCategoryWiseSplitting(pax);
			}

		}
	}

}

function generateHTMLForItemWiseSplitting(pax) {
	var generatedHtml = "";
	for ( var i = 1; i <= pax; i++) {
		var createddiv = "";
		var headerDiv = "<div align='left'>" + getBaseLang.billNo + " " + i + " <button type='button' onclick='javascript:opensplitBillItemListModal(" + i + ")' style='background: #72BB4F;font-weight: bold;margin-left:65%' class='btn btn-success'>" + getBaseLang.selectItem + "</button></div>";
		var tableline = "<div id='sbillcontid_" + i + "'><table id='tbl_" + i + "'class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>" + getBaseLang.name + "</th><th style='text-align:center;'>" + getBaseLang.qty + "</th><th style='text-align:center;'>" + getBaseLang.rate + "</th><th style='text-align:center;'>" + getBaseLang.tot + "</th>";
		var headerline = "<tbody style='color:#fff; padding:1px;' id='tbodycontid_" + i + "'>";
		var endtbody = "</tbody></table>";
		var subtotdiv = "<div align='left' style='width:77%'>" + getBaseLang.subTot + "<span style='float:right' id='subtotdiv_" + i + "'>0.00</span></div>";
		var taxdiv = "";
		var staxdiv = "";
		if (splitvattaxText.length != 0) {
			taxdiv = "<div align='left' style='width:77%'>" + splitvattaxText + "(" + splitvatAmt + "%)<span style='float:right' id='taxdiv_" + i + "'>0.00</span></div>";
		}
		if (splitservicetaxText.length != 0) {
			staxdiv = "<div align='left' style='width:77%'>" + splitservicetaxText + "(" + splitstaxAmt + "%)<span style='float:right' id='staxdiv_" + i + "'>0.00</span></div>";
		}
		// var taxdiv="<div align='left' style='width:77%'>GST(6%)<span
		// style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
		var grandtotdiv = "<div align='left' style='width:77%'>" + getBaseLang.grndTot + "<span style='float:right' id='grandtotdiv_" + i + "'>0.00</span></div>";
		var footerline = "</div>";
		createddiv = headerDiv + tableline + headerline + endtbody + subtotdiv + taxdiv + staxdiv + grandtotdiv + footerline;
		generatedHtml += createddiv;
	}
	// alert(generatedHtml);
	document.getElementById('splitBillContainerId').innerHTML = generatedHtml;
}

function generateHTMLForCategoryWiseSplitting(pax) {
	var generatedHtml = "";
	for ( var i = 1; i <= pax; i++) {
		var createddiv = "";
		var headerDiv = "<div align='left'>" + getBaseLang.billNo + " " + i + " <button type='button' onclick='javascript:opensplitBillItemListModalCategoryWise(" + i + ")' style='background: #72BB4F;font-weight: bold;margin-left:65%' class='btn btn-success'>" + getBaseLang.selctCat + "</button></div>";
		var tableline = "<div id='sbillcontid_" + i + "'><table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>" + getBaseLang.name + "</th><th style='text-align:center;'>" + getBaseLang.qty + "</th><th style='text-align:center;'>" + getBaseLang.rate + "</th><th style='text-align:center;'>" + getBaseLang.tot + "</th>";
		var headerline = "<tbody style='color:#fff; padding:1px;' id='tbodycontid_" + i + "'>";
		var endtbody = "</tbody></table>";
		var subtotdiv = "<div id='subtotdivcont_" + i + "' align='left' style='width:77%'>" + getBaseLang.subTot + "<span style='float:right' id='subtotdiv_" + i + "'>0.00</span></div>";
		var taxdiv = "";
		var staxdiv = "";
		if (splitvattaxText.length != 0) {
			// taxdiv="<div id='taxdivcont_"+i+"' align='left'
			// style='width:77%'>"+splitvattaxText+"("+splitvatAmt+"%)<span
			// style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
			taxdiv = "<div id='taxdivcont_" + i + "' align='left' style='width:77%'>" + splitvattaxText + "<span style='float:right' id='taxdiv_" + i + "'>0.00</span></div>";
		}
		if (splitservicetaxText.length != 0) {
			// staxdiv="<div id='staxdivcont_"+i+"' align='left'
			// style='width:77%'>"+splitservicetaxText+"("+splitstaxAmt+"%)<span
			// style='float:right' id='staxdiv_"+i+"'>0.00</span></div>";
			staxdiv = "<div id='staxdivcont_" + i + "' align='left' style='width:77%'>" + splitservicetaxText + "<span style='float:right' id='staxdiv_" + i + "'>0.00</span></div>";
		}
		// var taxdiv="<div align='left' style='width:77%'>GST(6%)<span
		// style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
		var grandtotdiv = "<div id='grandtotdivcont_" + i + "' align='left' style='width:77%'>GrandTotal<span style='float:right' id='grandtotdiv_" + i + "'>0.00</span></div>";
		var footerline = "</div>";
		createddiv = headerDiv + tableline + headerline + endtbody + subtotdiv + taxdiv + staxdiv + grandtotdiv + footerline;
		generatedHtml += createddiv;
	}
	// alert(generatedHtml);
	document.getElementById('splitBillContainerId').innerHTML = generatedHtml;
}

var splitbillid = 0;
function opensplitBillItemListModal(id) {
	splitbillid = id;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlist.htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			preparesplitbillitemListHtml(responseObj);

		} catch (e) {
			alert(e);
		}

	}, null);
	showsplitBillItemListModal();
}
function opensplitBillItemListModalCategoryWise(id) {
	splitbillid = id;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlistcategorywise.htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			preparesplitbillitemListCategoryWiseHtml(responseObj);
			// console.log(response);
			// alert(response);

		} catch (e) {
			alert(e);
		}

	}, null);
	showsplitBillItemListModalcatwise();
}
function preparesplitbillitemListCategoryWiseHtml(responseData) {
	selectedsplitRowscatwise = [];
	var createdrowline = "";
	var generatedHtml = "";
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th style='width:5%'></th><th style='text-align:center'>" + getBaseLang.catName + "</th>";
	var headerline = "<tbody style='color:#fff; padding:1px;' >";
	var footerline = "</tbody></table>";
	for ( var i = 0; i < responseData.length; i++) {
		var itemcatgory = responseData[i];
		var disc1 = 0.0;
		var begintrline = "";
		var firsttdline = "";
		var secondtdline = "";
		var trbgColor = "#222222";
		// alert(orderitem.id);
		begintrline = "<tr id='rowsplitcatwise_" + itemcatgory.id + "' style='background:" + trbgColor + "; padding:2px;'>";
		firsttdline = "<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRowSplitcatwise(" + itemcatgory.id + ",this)' id='chksplitcatwise_" + itemcatgory.id + "'></td>";
		secondtdline = "<td width='50%'  onclick='javascript:selectRowSplitcatwise(" + itemcatgory.id + ")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>" + itemcatgory.menuCategoryName + "</td>";
		var endtrline = "</tr>";
		createdrowline += begintrline + firsttdline + secondtdline + endtrline;

	}
	generatedHtml = tableline + headerline + createdrowline + footerline;
	document.getElementById('splitBillItemListContIdcatwise').innerHTML = generatedHtml;
}

var selectedsplitRowscatwise = [];
function selectRowSplitcatwise(trId) {
	if (document.getElementById('chksplitcatwise_' + trId).checked == false) {
		document.getElementById('rowsplitcatwise_' + trId).style.background = '#373737';
		document.getElementById('chksplitcatwise_' + trId).checked = true;
		selectedsplitRowscatwise.push(trId);
	} else {
		document.getElementById('rowsplitcatwise_' + trId).style.background = '#222222';
		document.getElementById('chksplitcatwise_' + trId).checked = false;
		selectedsplitRowscatwise.splice(selectedsplitRowscatwise.indexOf(trId), 1);
	}
}
function checkRowSplitcatwise(	trId,
								chk) {
	if (chk.checked) {
		document.getElementById('rowsplitcatwise_' + trId).style.background = '#373737';
		selectedsplitRowscatwise.push(trId);
	} else {
		document.getElementById('rowsplitcatwise_' + trId).style.background = '#222222';
		selectedsplitRowscatwise.splice(selectedsplitRowscatwise.indexOf(trId), 1);
	}
}
function addItemToSplitBillcatwise() {
	// alert(selectedsplitRows);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/additemlisttosplitbillcatwise/" + selectedsplitRowscatwise + ".htm", function(response) {
		try {
			console.log(response);
			var responseObj = JSON.parse(response);
			preparesplitbillitemListHtmlCatWise(responseObj);

		} catch (e) {
			alert(e);
		}

	}, null);
	hidesplitBillItemListModalcatwise();
}

function preparesplitbillitemListHtmlCatWise(responseData) {
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var subtot = 0.0;
	subtot = document.getElementById('subtotdiv_' + splitbillid).innerHTML;
	subtot = parseFloat(subtot);
	var catidbeverage = 0.0;
	var taxamt = 0.0;
	var staxamt = 0.0;
	var grandtot = 0.0;
	var generatedHtml = "";
	var createddiv = "";
	var createdrowline = "";
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>" + getBaseLang.sl + "</th><th>" + getBaseLang.name + "</th><th style='text-align:center;'>" + getBaseLang.qty + "</th><th>" + getBaseLang.rate + "</th><th>" + getBaseLang.tot + "</th><th>" + getBaseLang.action + "</th>";
	var headerline = "<tbody style='color:#fff; padding:1px;' >";
	var endtbody = "</tbody>";
	var footerline = "</tbody><tfoot><tr><td>" + getBaseLang.subTot + "</td><td></td><td></td><td></td><td>" + getBaseLang.no1 + "</td></tr><tr><td>" + getBaseLang.gst + "</td><td></td><td></td><td></td><td>" + getBaseLang.no2 + "</td></tr><tr><td>" + getBaseLang.subTot + "</td><td></td><td></td><td></td><td>" + getBaseLang.no3 + "</td></tr></tfoot></table>";

	for ( var i = 0; i < responseData.length; i++) {
		var Menu = responseData[i];
		for ( var j = 0; j < Menu.items.length; j++) {
			var item = Menu.items[j];
			var disc1 = 0.0;
			var begintrline = "";
			var firsttdline = "";
			var secondtdline = "";
			var thirdtdline = "";
			var trbgColor = "#222222";

			begintrline = "<tr id='" + item.id + "' style='padding:2px;background:#404040'>";
			var hidcatid = "<input type='hidden'  value='" + item.categoryId + "'>";
			secondtdline = "<td width='50%' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>" + item.name + " ## " + item.categoryName + "</td>";
			thirdtdline = "<td valign='middle' align='center' style='padding:3px;'>" + item.quantityOfItem + "</td>";
			var fourthtdline = "<td  style='padding:1px;text-align: center;'>" + parseFloat(item.price).toFixed(2) + "</td>";
			var fifthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(disc1).toFixed(2) + "</td>";
			var sixthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(item.price * item.quantityOfItem - disc1).toFixed(2) + "</td>";
			subtot += item.price * item.quantityOfItem - disc1;
			taxamt += (item.price * item.quantityOfItem - disc1) * item.vat / 100;
			staxamt += (item.price * item.quantityOfItem - disc1) * item.serviceTax / 100;
			var endtrline = "</tr>";
			createdrowline += begintrline + hidcatid + secondtdline + thirdtdline + fourthtdline + sixthtdline + endtrline;
			if (item.categoryId == 1025) {
				catidbeverage = item.categoryId;

			}
		}

	}
	if (splitvattaxText.length != 0) {
		taxamt = taxamt;
	}
	if (storeID == 53 && catidbeverage == 1025) {
		staxamt = staxamt;
	} else {
		if (splitservicetaxText.length != 0) {
			staxamt = staxamt;
		}
	}

	// taxamt=subtot*6/100;
	grandtot = subtot + taxamt + staxamt;
	generatedHtml = createdrowline;
	// alert(generatedHtml);
	$("#tbodycontid_" + splitbillid).append(generatedHtml);
	document.getElementById('subtotdivcont_' + splitbillid).style.width = "86%";
	document.getElementById('subtotdiv_' + splitbillid).innerHTML = parseFloat(subtot).toFixed(2);
	if (storeID == 53 && catidbeverage == 1025) {
		document.getElementById('taxdivcont_' + splitbillid).innerHTML = " " + getBaseLang.salesTax + " <span style='float:right' id='taxdiv_" + splitbillid + "'>" + getBaseLang.no4 + "</span>";
		document.getElementById('taxdivcont_' + splitbillid).style.width = "86%";
		document.getElementById('taxdiv_' + splitbillid).innerHTML = parseFloat(taxamt).toFixed(2);

	} else {

		if (splitvattaxText.length != 0) {
			document.getElementById('taxdivcont_' + splitbillid).style.width = "86%";
			document.getElementById('taxdiv_' + splitbillid).innerHTML = parseFloat(taxamt).toFixed(2);
		}
	}

	if (splitservicetaxText.length != 0) {
		document.getElementById('staxdivcont_' + splitbillid).style.width = "86%";
		document.getElementById('staxdiv_' + splitbillid).innerHTML = parseFloat(staxamt).toFixed(2);
	}

	document.getElementById('grandtotdivcont_' + splitbillid).style.width = "86%";
	if (storeroundoffflag == 'Y') {
		grandtot = Math.round(grandtot);
	}
	document.getElementById('grandtotdiv_' + splitbillid).innerHTML = parseFloat(grandtot).toFixed(2);
	// document.getElementById('tbodycontid_'+splitbillid).innerHTML=generatedHtml;
}

function preparesplitbillitemListHtml(responseData) {
	selectedsplitRows = [];
	var createdrowline = "";
	var generatedHtml = "";
	// for saravana
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th></th><th>" + getBaseLang.name + "</th><th style='text-align:center;'>" + getBaseLang.qty + "</th><th>" + getBaseLang.rate + "</th><th>" + getBaseLang.tot + "</th>";
	var headerline = "<tbody style='color:#fff; padding:1px;' >";
	var footerline = "</tbody></table>";
	for ( var i = 0; i < responseData.length; i++) {
		var orderitem = responseData[i];
		var disc1 = 0.0;
		var begintrline = "";
		var firsttdline = "";
		var secondtdline = "";
		var thirdtdline = "";
		var trbgColor = "#222222";
		// alert(orderitem.id);
		begintrline = "<tr id='rowsplit_" + orderitem.id + "' style='background:" + trbgColor + "; padding:2px;'>";
		var hiditemid = "<input type='hidden' id='" + splitbillid + "_" + orderitem.item.id + "' value='" + orderitem.item.id + "'>";
		firsttdline = "<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRowSplit(" + orderitem.id + ",this)' id='chksplit_" + orderitem.id + "'></td>";
		secondtdline = "<td width='50%'  onclick='javascript:selectRowSplit(" + orderitem.id + ")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>" + orderitem.item.name + "</td>";
		thirdtdline = "<td valign='middle' align='center' style='padding:3px;'>" + orderitem.quantityOfItem + "</td>";
		var fourthtdline = "<td  style='padding:1px;text-align: center;'>" + parseFloat(orderitem.rate).toFixed(2) + "</td>";
		var fifthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(disc1).toFixed(2) + "</td>";
		var sixthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(orderitem.rate * orderitem.quantityOfItem - disc1).toFixed(2) + "</td>";
		var seventhhtdline = "";
		var eighthtdline = "";
		/*
		 * if(vattaxText.length!=0) { seventhhtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.vat).toFixed(2)+"</td>"; }
		 * if(servicetaxText.length!=0) { eighthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.serviceTax).toFixed(2)+"</td>"; }
		 */

		var endtrline = "</tr>";
		createdrowline += begintrline + firsttdline + secondtdline + thirdtdline + fourthtdline + sixthtdline + endtrline;

	}
	generatedHtml = tableline + headerline + createdrowline + footerline;
	document.getElementById('splitBillItemListContId').innerHTML = generatedHtml;
}
var selectedsplitRows = [];
function selectRowSplit(trId) {
	if (document.getElementById('chksplit_' + trId).checked == false) {
		document.getElementById('rowsplit_' + trId).style.background = '#373737';
		document.getElementById('chksplit_' + trId).checked = true;
		selectedsplitRows.push(trId);
	} else {
		document.getElementById('rowsplit_' + trId).style.background = '#222222';
		document.getElementById('chksplit_' + trId).checked = false;
		selectedsplitRows.splice(selectedsplitRows.indexOf(trId), 1);
	}
}
function checkRowSplit(	trId,
						chk) {
	if (chk.checked) {
		document.getElementById('rowsplit_' + trId).style.background = '#373737';
		selectedsplitRows.push(trId);
	} else {
		document.getElementById('rowsplit_' + trId).style.background = '#222222';
		selectedsplitRows.splice(selectedsplitRows.indexOf(trId), 1);
	}
}
function addItemToSplitBill() {
	// alert(selectedsplitRows);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/additemlisttosplitbill/" + selectedsplitRows + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			preparesplitbillitemListHtmltoBill(responseObj);

		} catch (e) {
			alert(e);
		}

	}, null);
	hidesplitBillItemListModal();
}
function deleteItemFromSplitBill(	billid,
									deleteitemid) {
	// alert(deleteitemid);
	var orderid = document.getElementById('splitbillmodOrderCont').innerHTML;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/deleteitemlisttosplitbill/" + deleteitemid + "/" + orderid + ".htm", function(response) {
		preparesplitbillitemListHtmltoBillDelete(billid, deleteitemid);
	}, null);

	hidesplitBillItemListModal();
}

function preparesplitbillitemListHtmltoBill(responseData) {
	//console.log(responseData);
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var splitbillids = [];
	var subtot = 0.0;
	subtot = document.getElementById('subtotdiv_' + splitbillid).innerHTML;
	subtot = parseFloat(subtot);
	
	var table=document.getElementById("tbl_"+splitbillid); //new
	//alert(table);
	var quantity=1;
	var taxamt = 0.0;
	var staxamt = 0.0;
	var grandtot = 0.0;
	var generatedHtml = "";
	var createddiv = "";
	var createdrowline = "";
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>" + getBaseLang.sl + "</th><th>" + getBaseLang.name + "</th><th style='text-align:center;'>" + getBaseLang.qty + "</th><th>" + getBaseLang.rate + "</th><th>" + getBaseLang.tot + "</th><th>" + getBaseLang.action + "</th>";
	var headerline = "<tbody style='color:#fff; padding:1px;' >";
	var endtbody = "</tbody>";
	var footerline = "</tbody><tfoot><tr><td>" + getBaseLang.subTot + "</td><td></td><td></td><td></td><td>" + getBaseLang.no1 + "</td></tr><tr><td>" + getBaseLang.gst + "</td><td></td><td></td><td></td><td>" + getBaseLang.no2 + "</td></tr><tr><td>" + getBaseLang.tototAmount + "</td><td></td><td></td><td></td><td>" + getBaseLang.no3 + "</td></tr></tfoot></table>";
	$("#tbodycontid_" + splitbillid + " > tr").each(function() {
		// alert("id:"+this.id);
		splitbillids.push(this.id);
	});

	for ( var i = 0; i < responseData.length; i++) {
		//alert("responseData i:::"+i);
		//alert("responseData:::"+responseData.length);
		/*
		 * $.each( splitbillids, function( index,value ) { alert("value: " +
		 * value ); });
		 */     
		var orderitem = responseData[i];
		//alert("itemid:"+orderitem.item.id);
		var disc1 = 0.0;
		var begintrline = "";
		var firsttdline = "";
		var secondtdline = "";
		var thirdtdline = "";
		var trbgColor = "#222222";	
		
		
		
		
		if (splitbillids.length > 0) {			
			for ( var j = 0; j < splitbillids.length; j++) {				
					  //your code to be executed after 1 second
					if (splitbillids[j] == orderitem.id) {	
						
						orderitem.quantityOfItem =parseInt(orderitem.quantityOfItem) + 1;											
						subtot = subtot - orderitem.rate * 1;
						
						//orderitem.quantityOfItem=subtot/orderitem.rate;
						//alert("orderitem.id::::"+orderitem.id);
						
						//
						for ( var k = 1; k < table.rows.length; k++) {
							var row=table.rows[k];
							//alert("rowid:::"+row.id+"::orderitem.id::"+orderitem.id);
							if(row.id==orderitem.id){
								  quantity= parseInt(table.rows[k].cells[1].innerHTML)+1;
								 
								  //alert("newquantity:"+quantity); //new
							}
						}
                       //
						
						$("#tbodycontid_" + splitbillid + " tr#" + orderitem.id).remove();
						//alert("length:"+splitbillids.length);
					}
			}
		}
		
		
		       subtot += orderitem.rate * orderitem.quantityOfItem - disc1;
		       
			  //your code to be executed after 1 second
			begintrline = "<tr id='" + orderitem.id + "' style='padding:2px;background:#404040'>";
			var hiditemid = "<input type='hidden' id='" + splitbillid + "_" + orderitem.item.id + "' value='" + orderitem.item.id + "'>";
			// firsttdline="<td style='padding:1px;'>"+(i+1)+"</td>";
			secondtdline = "<td width='50%' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>" + orderitem.item.name + "</td>";
			thirdtdline = "<td valign='middle' align='center' style='padding:3px;'>" + quantity + "</td>";
			var fourthtdline = "<td  style='padding:1px;text-align: center;'>" + parseFloat(orderitem.rate).toFixed(2) + "</td>";
			var fifthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(disc1).toFixed(2) + "</td>";
			var sixthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(orderitem.rate * quantity - disc1).toFixed(2) + "</td>";
			var seventhhtdline = "<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:deleteItemFromSplitBill(" + splitbillid + "," + orderitem.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/base/d/d_delete.png' height='22' width='18'></a></td>";
			var eighthtdline = "";
			/*
			 * if(vattaxText.length!=0) { seventhhtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.vat).toFixed(2)+"</td>"; }
			 * if(servicetaxText.length!=0) { eighthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.serviceTax).toFixed(2)+"</td>"; }
			 */
			// alert(parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2));
			//var g=parseInt(orderitem.quantityOfItem);
			
			//alert("subtot:"+subtot+"::rate::"+orderitem.rate+"::quantity::"+ orderitem.quantityOfItem+":Disc:"+disc1);						
			var endtrline = "</tr>";
			createdrowline += begintrline + hiditemid + secondtdline + thirdtdline + fourthtdline + sixthtdline + seventhhtdline + endtrline;					

	}
	
	
	if (splitvattaxText.length != 0) {
		taxamt = subtot * splitvatAmt / 100;
	}
	if (splitservicetaxText.length != 0) {
		staxamt = subtot * splitstaxAmt / 100;
	}
	// taxamt=subtot*6/100;
	grandtot = subtot + taxamt + staxamt;
	generatedHtml = createdrowline;
	// alert(generatedHtml);
	$("#tbodycontid_" + splitbillid).append(generatedHtml);
	document.getElementById('subtotdiv_' + splitbillid).innerHTML = parseFloat(subtot).toFixed(2);
	if (splitvattaxText.length != 0) {
		document.getElementById('taxdiv_' + splitbillid).innerHTML = parseFloat(taxamt).toFixed(2);
	}
	if (splitservicetaxText.length != 0) {
		document.getElementById('staxdiv_' + splitbillid).innerHTML = parseFloat(staxamt).toFixed(2);
	}
	if (storeroundoffflag == 'Y') {
		grandtot = Math.round(grandtot);
	}
	document.getElementById('grandtotdiv_' + splitbillid).innerHTML = parseFloat(grandtot).toFixed(2);
	
	// document.getElementById('tbodycontid_'+splitbillid).innerHTML=generatedHtml;
}
function preparesplitbillitemListHtmltoBillDelete(	billid,
													deleteitemid) {
	// alert('in delete:'+billid+':'+deleteitemid);
	// alert($("#tbodycontid_"+billid +"
	// tr#"+deleteitemid).find('td:eq(3)').html());
	var deleteditemcost = 0.0;
	var deleteditemqty = $("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(1)').html();
	var deleteditemrate = $("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(2)').html();
	// deleteditemcost=$("#tbodycontid_"+billid +"
	// tr#"+deleteitemid).find('td:eq(3)').html();

	if (deleteditemqty > 1) {
		//qq--;
		deleteditemqty = deleteditemqty - 1;
		$("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(1)').html(deleteditemqty);
		$("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(3)').html(parseFloat(deleteditemqty * deleteditemrate).toFixed(2));
	} else {
		//qq=1;
		$("#tbodycontid_" + billid + " tr#" + deleteitemid).remove();
	}

	// alert('gg:'+deleteditemcost);
	var subtot = 0.0;
	var taxamt = 0.0;
	var staxamt = 0.0;
	var grandtot = 0.0;
	subtot = document.getElementById('subtotdiv_' + billid).innerHTML;
	subtot = parseFloat(subtot);
	subtot = subtot - parseInt(deleteditemrate);
	if (splitvattaxText.length != 0) {
		taxamt = subtot * splitvatAmt / 100;
	}
	if (splitservicetaxText.length != 0) {
		staxamt = subtot * splitstaxAmt / 100;
	}
	// taxamt=subtot*6/100;
	grandtot = subtot + taxamt + staxamt;
	document.getElementById('subtotdiv_' + billid).innerHTML = parseFloat(subtot).toFixed(2);
	if (splitvattaxText.length != 0) {
		document.getElementById('taxdiv_' + billid).innerHTML = parseFloat(taxamt).toFixed(2);
	}
	if (splitservicetaxText.length != 0) {
		document.getElementById('staxdiv_' + billid).innerHTML = parseFloat(staxamt).toFixed(2);
	}
	// document.getElementById('taxdiv_'+billid).innerHTML=parseFloat(taxamt).toFixed(2);
	document.getElementById('grandtotdiv_' + billid).innerHTML = parseFloat(grandtot).toFixed(2);
}

function submitSpliBill(noofbill,
						storeid) {
	var SpliBill = [];
	// var noofPax=document.getElementById('noofPaxId').innerHTML;
	var billsplittype = $('input:radio[name=radioGroup]:checked').val();
	if (billsplittype == 1) {
		// itemwise

		var rowlen = 0;
		var orderid = document.getElementById('splitbillmodOrderCont').innerHTML;
		for ( var i = 1; i <= noofbill; i++) {
			// rowlen=$("#tbodycontid_"+i+" tr").length;
			if ($("#tbodycontid_" + i + " tr").length == 0) {
				rowlen = i;
			}
			$("#tbodycontid_" + i + " > tr").each(function() {

				var biilamt = 0.0;
				var SpliBillObj = {};
				SpliBillObj.billId = document.getElementById('splitbillId').value;
				SpliBillObj.orderId = document.getElementById('splitbillmodOrderCont').innerHTML;
				SpliBillObj.billNo = i;
				SpliBillObj.itemId = $(this).find('input[type="hidden"]').val();
				SpliBillObj.itemName = $(this).find('td:eq(0)').html();
				SpliBillObj.totalBillNo = noofbill;
				SpliBillObj.itemQuantity = $(this).find('td:eq(1)').html();
				SpliBillObj.itemRate = $(this).find('td:eq(2)').html();
				SpliBillObj.billAmount = $(this).find('td:eq(3)').html();
				var d = new Date();
				SpliBillObj.creationDate = ("0" + d.getDate()).slice(-2) + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + d.getFullYear();
				// biilamt=Number($(this).find('td:eq(3)').html());
				// biilamt=Number(biilamt)+Number(biilamt*6/100);

				// SpliBillObj.billAmount=Number(parseFloat(biilamt).toFixed(2));

				SpliBillObj.mode = "M";
				// alert($(this).find('input[type="hidden"]').val());
				// alert($(this).find('td:eq(0)').html());
				SpliBill.push(SpliBillObj);

			});
		}
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/validatesplitbill.htm", function(response) {
			try {
				if (response > 0) {
					$('#splitbillalertMsg').html('<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>' + response + getBaseLang.itemRmbrToAdd);
				}
				// else if(parseInt(noofbill)>parseInt(noofPax))
				// {
				// $('#splitbillalertMsg').html('<div
				// class="alert alert-danger"> <a href="#"
				// class="close" data-dismiss="alert"
				// aria-label="close">&times;</a> <strong> No of
				// bill is greater than no of pax!</strong>
				// </div>');
				// }
				else {

					if (rowlen == 0) {
						$.ajax({
							url : BASE_URL + "/order/submitsplitbillfors01.htm",
							type : 'POST',
							contentType : 'application/json;charset=utf-8',
							data : JSON.stringify(SpliBill),
							success : function(response) {
								// called when
								// successful
								if (response == 'success') {

									SpliBillcatwise = [];
									hidesplitBillModal();
									var ajaxCallObject = new CustomBrowserXMLObject();
									ajaxCallObject.callAjax(BASE_URL + "/order/printsplitbill/" + orderid + ".htm", function(response) {
										try {
											if (response == 'Success')
												showBillPrintSuccessModal();
										} catch (e) {
											alert(e);
										}
									}, null);
								}
							},
							error : function(e) {
								// called when there is
								// an error
								// console.log(e.message);
							}
						});
						/*
						 * var ajaxCallObject = new
						 * CustomBrowserXMLObject();
						 * ajaxCallObject.callAjax(BASE_URL +
						 * "/order/submitsplitbill/"+JSON.stringify(SpliBill)+".htm",
						 * function(response) { alert(response);
						 * if(response=='success') {
						 * SpliBill=[]; hidesplitBillModal();
						 * var ajaxCallObject = new
						 * CustomBrowserXMLObject();
						 * ajaxCallObject.callAjax(BASE_URL +
						 * "/order/printsplitbill/"+orderid +
						 * ".htm", function(response) { try{
						 * if(response=='Success')
						 * showBillPrintSuccessModal();
						 * }catch(e) {alert(e);} }, null); } },
						 * null);
						 */
					} else {
						$('#splitbillalertMsg').html('<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>' + getBaseLang.plsAddItems + ' ' + rowlen + '!</strong> </div>');
					}
				}
			} catch (e) {
				alert(e);
			}
		}, null);

	} else {
		// categorywise
		var rowlen = 0;
		var orderid = document.getElementById('splitbillmodOrderCont').innerHTML;
		for ( var i = 1; i <= noofbill; i++) {
			// rowlen=$("#tbodycontid_"+i+" tr").length;
			if ($("#tbodycontid_" + i + " tr").length == 0) {
				rowlen = i;
			}
			$("#tbodycontid_" + i + " > tr").each(function() {
				var biilamt = 0.0;
				var SpliBillObj = {};
				SpliBillObj.billId = document.getElementById('splitbillId').value;
				SpliBillObj.orderId = document.getElementById('splitbillmodOrderCont').innerHTML;
				SpliBillObj.billNo = i;
				SpliBillObj.categoryId = $(this).find('input[type="hidden"]').val();
				console.log("SpliBillObj.categoryId=" + SpliBillObj.categoryId);
				SpliBillObj.itemId = this.id;
				SpliBillObj.itemName = $(this).find('td:eq(0)').html().split("##")[0];
				SpliBillObj.totalBillNo = noofbill;
				SpliBillObj.itemQuantity = $(this).find('td:eq(1)').html();
				SpliBillObj.itemRate = $(this).find('td:eq(2)').html();
				SpliBillObj.billAmount = $(this).find('td:eq(3)').html();
				var d = new Date();
				SpliBillObj.creationDate = ("0" + d.getDate()).slice(-2) + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + d.getFullYear();
				// biilamt=Number($(this).find('td:eq(3)').html());
				// biilamt=Number(biilamt)+Number(biilamt*6/100);

				// SpliBillObj.billAmount=Number(parseFloat(biilamt).toFixed(2));

				SpliBillObj.mode = "M";
				// alert($(this).find('input[type="hidden"]').val());
				// alert($(this).find('td:eq(0)').html());
				SpliBill.push(SpliBillObj);

			});
		}
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/validatesplitbillcatwise.htm", function(response) {
			try {
				if (response > 0) {
					$('#splitbillalertMsg').html('<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>' + response + ' ' + getBaseLang.catRemToAdd + '</strong> </div>');
				}
				// else if(parseInt(noofbill)>parseInt(noofPax))
				// {
				// $('#splitbillalertMsg').html('<div
				// class="alert alert-danger"> <a href="#"
				// class="close" data-dismiss="alert"
				// aria-label="close">&times;</a> <strong> No of
				// bill is greater than no of pax!</strong>
				// </div>');
				// }
				else {
					if (rowlen == 0) {
						$.ajax({
							url : BASE_URL + "/order/submitsplitbillfors01.htm",
							type : 'POST',
							contentType : 'application/json;charset=utf-8',
							data : JSON.stringify(SpliBill),
							success : function(response) {
								// called when
								// successful
								if (response == 'success') {

									SpliBillcatwise = [];
									hidesplitBillModal();
									var ajaxCallObject = new CustomBrowserXMLObject();
									ajaxCallObject.callAjax(BASE_URL + "/order/printsplitbill/" + orderid + ".htm", function(response) {
										try {
											if (response == 'Success')
												showBillPrintSuccessModal();
										} catch (e) {
											alert(e);
										}
									}, null);
								}
							},
							error : function(e) {
								// called when there is
								// an error
								// console.log(e.message);
							}
						});

						/*
						 * var ajaxCallObject1 = new
						 * CustomBrowserXMLObject();
						 * ajaxCallObject1.callAjax(BASE_URL +
						 * "/order/submitsplitbill/"+JSON.stringify(SpliBill)+".htm",
						 * function(response) {
						 * if(response=='success') {
						 * 
						 * SpliBillcatwise=[];
						 * hidesplitBillModal(); var
						 * ajaxCallObject = new
						 * CustomBrowserXMLObject();
						 * ajaxCallObject.callAjax(BASE_URL +
						 * "/order/printsplitbill/"+orderid +
						 * ".htm", function(response) { try{
						 * if(response=='Success')
						 * showBillPrintSuccessModal();
						 * }catch(e) {alert(e);} }, null); } },
						 * null);
						 */
					} else {
						$('#splitbillalertMsg').html('<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>' + getBaseLang.plsAddItems + rowlen + '!</strong> </div>');
					}
				}
			} catch (e) {
				alert(e);
			}
		}, null);
	}
	// alert('bill:'+noofbill+':pax:'+noofPax);

}
/* end split bill */
/* start split payment */
function openSplitPaymentCashModal() {
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
	document.getElementById('cashmodSplitPaymentOrderCont').innerHTML = orderno;
	document.getElementById('cashmodSplitPaymentTabCont').innerHTML = tableno;
	var totalbillamt = round($("#amttopaycontId").text(), 1);
	$('#cashmodSplitPaymentBody').html('');
	$('#cashmodSplitPaymentBodyAmountDetails').html('');

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getbillwiseitemlist/" + orderno + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			console.log(responseObj);
			if (responseObj.length > 0) {
				var lastbillamttopay = 0.00;
				for ( var i = 0; i < responseObj.length; i++) {
					console.log(responseObj[i].billNo);
					console.log(responseObj[i].billSplitManuals.length);

					var amttopay = 0.00;

					for ( var j = 0; j < responseObj[i].billSplitManuals.length; j++) {
						var billSplitManual = responseObj[i].billSplitManuals[j];
						var itemamt = billSplitManual.itemQuantity * billSplitManual.itemRate;
						var taxamt = itemamt * 6 / 100;
						amttopay = amttopay + itemamt + taxamt;

					}
					lastbillamttopay = lastbillamttopay + amttopay;
					if (i == responseObj.length - 1) {
						lastbillamttopay = totalbillamt - lastbillamttopay;
						amttopay = round(amttopay, 2) + lastbillamttopay;
					}
					var radioBtn = $('<label class="radio-inline"><input type="radio" name="cashmodSplitPayment" value="' + responseObj[i].billNo + "&" + round(amttopay, 1) + '" style="transform: scale(2.0);-webkit-transform: scale(2.0);">Bill No. ' + responseObj[i].billNo + '</label>');
					radioBtn.appendTo('#cashmodSplitPaymentBody');

				}
				$("input:radio[name=cashmodSplitPayment]").click(
						function() {
							$("#splitPaymentBtn").removeClass("active").addClass("disabled");
							$('#cashmodSplitPaymentBodyAmountDetails').html('');
							$('#splitpaycashalertMsg').text('');
							var value = $(this).val();
							var newval = value.split("&");
							var dynamictext = '<br/>PAY FOR BILL NO. ' + newval[0] + '<div style="padding: 5px;">' + getBaseLang.amountToPay + '&nbsp;&nbsp;&nbsp;<span id="splitpaymentamttopaycontId">' + newval[1] + '</span> </div>' + '<div style="padding: 3px;">' + getBaseLang.tndrAmount + '&nbsp;&nbsp;&nbsp; :&nbsp;<input type="text" onkeyup="javascript:getChangeAmtForSplit(this.value)" id="splitpaymenttenderAmt" style="text-align:center; color: #222222" size="4"/> </div>' + '<div style="padding: 5px;">' + getBaseLang.changeAmount + ' :&nbsp;<span id="cashchangeamtsplitpaymentcontId">0.00</span> </div>' + ' <div align="center" style=";font-size: 20px;">'

							+ '<table class="ui-bar-a" id="n_keypad_sppay" style="display: none; -khtml-user-select: none;">' + '<tr>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero100_sppay"><img src="' + BASE_URL + '/assets/images/base/payment/rm100.png" /></a></td>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero7_sppay">7</a></td>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero8_sppay">8</a></td>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero9_sppay">9</a></td>' + '<td><a data-role="button" data-theme="e" style="border: 2px solid #404040;" class="btn btn-danger btn-lg" id="del_sppay">x</a></td>' + '</tr>' + '<tr>'
									+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero50_sppay"><img src="' + BASE_URL + '/assets/images/base/payment/rm50.png" /></a></td>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero4_sppay">4</a></td>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero5_sppay">5</a></td>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero6_sppay">6</a></td>' + '<td><a data-role="button" data-theme="e" style="border: 2px solid #404040;" class="btn btn-warning btn-lg" id="clear_sppay">c</a></td>' + '</tr>' + '<tr>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero20_sppay"><img src="'
									+ BASE_URL + '/assets/images/base/payment/rm20.png" /></a></td>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero1_sppay">1</a></td>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero2_sppay">2</a></td>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero3_sppay">3</a></td>' + '<td><a data-role="button" data-theme="e" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numerodot_sppay">&nbsp;.</a></td>' + '</tr>' + '<tr>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero10_sppay"><img src="' + BASE_URL + '/assets/images/base/payment/rm10.png" /></a></td>'
									+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numerorm5_sppay"><img src="' + BASE_URL + '/assets/images/base/payment/rm5.png" /></a></td>' + '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="zero_sppay">0</a></td>' + '<td colspan="4"><a data-role="button" style="border: 2px solid #404040;width: 184px;" data-theme="done" class="btn btn-success btn-lg" id="done_sppay">' + getBaseLang.done + '</a></td>' + '</tr>' + '</table>' + '</div>';

							$('#cashmodSplitPaymentBodyAmountDetails').html(dynamictext);
						});

			} else {
				$('#cashmodSplitPaymentBodyAmountDetails').html(getBaseLang.orderSplited);
			}

		} catch (e) {
			alert(e);
		}
	}, null);
	showSplitPaymentCashModal();
}
var originalamount = 0.00;
function paySplitAmtByCash() {

	var orderno = document.getElementById('orderNo').value;
	var amttopay = $('#splitpaymentamttopaycontId').text();
	var tenderAmt = $('#splitpaymenttenderAmt').val();
	var changeamt = Number(tenderAmt) - Number(amttopay);
	var billno = $('input:radio[name=cashmodSplitPayment]:checked').val();
	var totalbillamt = round($("#amttopaycontId").text(), 1);
	var remainingamt = 0.00;
	if (originalamount == 0.00) {
		remainingamt = Number(totalbillamt) - Number(amttopay);
	} else {
		// remainingamt=Number(originalamount)-Number(amttopay);
		remainingamt = Number(totalbillamt) - (Number(originalamount) + Number(amttopay));
	}

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/" + orderno + "/" + totalbillamt + "/" + Number(amttopay) + "/" + remainingamt + "/" + tenderAmt + "/" + "cash" + "/" + "000" + ".htm", function(response) {
		try {
			if (response == 'success') {
				$('#splitpaycashalertMsg').text(getBaseLang.pamtDone + billno.split("&")[0]);
				originalamount = originalamount + Number(amttopay);
				if (originalamount >= Number(totalbillamt)) {
					if (storeID == '37' || storeID == '38') {
						hideSplitPaymentCashModal();
						document.getElementById('cashamttopaymodcontId').innerHTML = parseFloat(amttopay).toFixed(2);
						document.getElementById('cashtenderAmtmodcontId').innerHTML = parseFloat(tenderAmt).toFixed(2);
						document.getElementById('cashchangeamtmodcontId').innerHTML = parseFloat(changeamt).toFixed(2);
						showCashChangeAmtModal();
					}
					// location.href=BASE_URL+'/table/viewtable.htm';
				}
			}
		} catch (e) {
			alert(e);
		}
	}, null);
	// $("input:radio[name=cashmodSplitPayment][value=" + billno +
	// "]").attr("disabled",true);
	$("input:radio[name=cashmodSplitPayment]:checked").attr("disabled", true);
	$("#splitPaymentBtn").removeClass("active").addClass("disabled");
}
function getChangeAmtForSplit(billno) {

	var amttopay = $('#splitpaymentamttopaycontId').text();
	var tenderAmt = $('#splitpaymenttenderAmt').val();
	if (Number(tenderAmt) >= Number(amttopay)) {
		var changeamt = Number(tenderAmt) - Number(amttopay);
		$('#cashchangeamtsplitpaymentcontId').text(round(changeamt, 1));
		$("#splitPaymentBtn").removeClass("disabled").addClass("active");
		// for vfd
		if (vfdPort.length > 3) {
			// var changeAmt=tenderAmt-netTotal;
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/showvfdpay/" + "TOT IN RM : " + parseFloat(amttopay).toFixed(2) + "/" + "BAL IN RM : " + parseFloat(changeamt).toFixed(2) + ".htm", function() {
			}, null);
		}
	} else {
		$('#cashchangeamtsplitpaymentcontId').text('0.00');
		$("#splitPaymentBtn").removeClass("active").addClass("disabled");

	}

}

function searchCustomer() {
	var customerContact = document.getElementById("modparcelcustPhone").value;
	$("#modparceldeliveryPersonName").val("");
	$("#modparcelcustAddress").val("");
	$("#modparcelcustName").val("");
	$("#modparcelcustvatorcst").val("");
	$("#modparcelcustlocation").val("");
	$("#modparcelcusthouseno").val("");
	$("#modparcelcuststreet").val("");
	if (isNaN(customerContact) || customerContact == '') {
		// alert('Please eneter a valid number!');
		document.getElementById('parcelCustModalalertMsg').innerHTML = getBaseLang.plsEntrVdNo;
		document.getElementById('modparcelcustPhone').focus();
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/getcustomerdetails/" + customerContact + ".htm", function(response) {
			try {
				console.log("response=" + response);
				var custDetail = JSON.parse(response);
				if ($.isEmptyObject(custDetail)) {
					$("#parcelCustModalalertMsg").html("<strong>" + getBaseLang.custNotFound + "</strong> " + getBaseLang.plsAddCustDetails + " ");
					$("#modparcelcustName").val("");
					$("#modparcelcustAddress").val("");
					$("#modparceldeliveryPersonName").val("");
					$("#modparcelcustvatorcst").val("");
					$("#modparcelcustlocation").val("");
					$("#modparcelcusthouseno").val("");
					$("#modparcelcuststreet").val("");
				} else {

								         
					$("#modparcelcustName").val(custDetail.custName);
					$("#modparcelcustAddress").val(custDetail.delivAddr);
					$("#modparceldeliveryPersonName").val(custDetail.delivPersonName);
					$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
					$("#modparcelcustlocation").val(custDetail.location);
					$("#modparcelcusthouseno").val(custDetail.houseNo);
					$("#modparcelcuststreet").val(custDetail.street);
				}

			} catch (e) {
				console.log(e);
			}
		}, null);

	}
}



/* end split payment */
function addBarcodeItem(code) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/menu/getmenuitembybarcode/" + code + ".htm", function(response) {
		var item = JSON.parse(response);
		if (jQuery.isEmptyObject(item)) {
			$("#itemnotfoundModal").modal("show");
		} else {
			var disc = 0.0;
			if (item.promotionFlag == 'Y')
				disc = item.promotionValue;
			additemtoOrder(item.id, item.name, item.price, disc, item.vat, item.serviceTax, item.promotionFlag, item.promotionValue);

		}

	}, null);
}
function round(	value,
				places) {
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

function setQty() {
	var qty = document.getElementById('kepadmanQty').value;

	if (isNaN(qty) || qty === '') {
		document.getElementById('enterQtyAlert').innerHTML = getBaseLang.enterQty;
	}

}

function closeCancel() {
	document.getElementById('enterQtyAlert').innerHTML = '';
}

function paidOrder58() {

	var divToPrint = document.getElementById('paidOrder58');
	document.getElementById('removePrintPaidOrder58').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('removePrintPaidOrder58').style.display = 'block';

	newWin.close();

}

function paidOrder80() {

	var divToPrint = document.getElementById('paidOrder80');
	document.getElementById('cashRemovePrintPaidOrder80').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('cashRemovePrintPaidOrder80').style.display = 'block';

	newWin.close();

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
//	location.href = BASE_URL + '/table/viewtable.htm';
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
//	location.href = BASE_URL + '/table/viewtable.htm';
}

function printCashOrCardLocal2100() {
//	 $('#printDiv2100').modal('show');
	var divToPrint = document.getElementById('printDiv2100_GST');
	document.getElementById('cashRemovePrint2100').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('cashRemovePrint2100').style.display = 'block';
	
	newWin.close();
//	location.href = BASE_URL + '/table/viewtable.htm';
	
}

function localPrint_2100px() {

	var divToPrint = document.getElementById('localPrint_2100px');
	document.getElementById('removePrint_2100px').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('removePrint_2100px').style.display = 'block';
	newWin.close();

}


function cashOrcardPrintBill() {

	var caseValue = $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();

	var order = {};
	var orderId = document.getElementById('orderNo').value;
	order.id = orderId;
	order.storeId = storeID;
	//  alert(order.id+ " >> "+order.storeId+ ">> "+BASE_URL);
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
				var orderNo = jsonObj.id;
				var tabNo = jsonObj.table_no;
				var customerName = jsonObj.customers.name;
				var customerAddr = jsonObj.customers.address;
				var customerPhNo = jsonObj.customers.contactNo;
				var customerEmail = jsonObj.customers.emailId;
				var orderDateWithTime = jsonObj.customers.orderTime;
				var orderTime = jsonObj.customers.time;

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

						var paidAmt = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						var tenderAmt = jsonObj.payments[0].tenderAmount + jsonObj.payments[1].tenderAmount;
						var returnAmt = tenderAmt - paidAmt;
						var type1 = jsonObj.payments[0].paymentMode;
						var type2 = jsonObj.payments[1].paymentMode;
						
						$('#paidAmount58').text(paidAmt);
						$('#tenderAmount58').text(tenderAmt);
						$('#refundAmount58').text("0.00");
						$('#payType58').text(type1+" + "+type2);
					}

					//	$('#helloPrintModal58').modal('show');	

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

				} else if(printbillpapersize == '80.00'){
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

					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;

						//alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

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

					/* ********** END ITEM DETAILS PRINT ********** */

					/* ********** START AMOUNT INFO PRINT ********** */
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
						$('#refundAmount80').text(returnAmt);
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
						$('#payType80').text(type1+" + "+type2);
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
						var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
						;
						if (amt2 == paidAmt2) {
							printCashOrCardLocal80();
						}
					}

				}else if (printbillpapersize == '2100.00'){

					
						//	alert("customerAddr >>  "+customerAddr);
							
							$('#storeName2100').text(customerName);
							$('#storeAddr2100').text(storeAddr);
							$('#storeEmail2100').text("Email :"+customerEmail);
							$('#storePhNo2100').text("Ph :"+customerPhNo);
							$('#cashOrdervalue2100').text(orderNo);
							$('#cashtableNoValue2100').text(tabNo);

							/* ********** END STORE INFO PRINT ********** */

							/* ********** START ITEM DETAILS PRINT ********** */

							for ( var k = 0; k < jsonObj.orderitem.length; k++) {
								var item1 = jsonObj.orderitem[k];

								var itemName = item1.item.name;
								var itemQty = item1.quantityOfItem;
								var itemRate = item1.rate;
								var itemTotalPrice = item1.totalPriceByItem;

						//		alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

								var createdrowline = "";
								var startTrline = "<tr style='padding: 2px;'>";
								var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 14px;font-family: sans-serif;'>" + itemName + "</td>";
								var secondTdline = "<td style='float:right;font-size: 14px;font-family: sans-serif;padding-right:170px;text-align:center'>" + itemQty + "</td>";
								var thirdTdline = "<td style='font-size: 14px;font-family: sans-serif;padding-right:110px;text-align:center'>" + itemRate + "</td>";
								var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: center; font-size: 14px'>" + itemTotalPrice + "</td>";
								var endTrline = "</tr>";

								createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

								$("#itemDetailsPrint2100").append(createdrowline);

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
								$("#cashdiscountValue2100").text(customerDiscount);
							} else {
								$("#cashshowDiscount2100px").hide();
							}

							$("#cashgrossAmount2100").text(billAmt);
							$("#cashamoutToPay2100").text(grossAmt);

							var paymentsObj = jsonObj.payments.length;
							if (paymentsObj == 1) {

								var paidAmt = jsonObj.payments[0].paidAmount;
								var tenderAmt = jsonObj.payments[0].tenderAmount;
								var returnAmt = tenderAmt - paidAmt;
								var type = jsonObj.payments[0].paymentMode;
								
						//	alert("<< paidAmt >> "+paidAmt+ "<< tenderAmt >> "+tenderAmt+ "<< returnAmt >> "+returnAmt);	

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
								$('#payType2100').text(type1+" + "+type2);
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
								var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
								
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
			ajaxCallObject.callAjax(BASE_URL + "/order/printbill/" + orderid + ".htm", function(response) {
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