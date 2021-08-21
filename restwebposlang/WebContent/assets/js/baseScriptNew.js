var itemObjValue = new Array();
var itemUnique;
var ordVal;
var ordItemVal;
var tableNoValue;
var hidendiscountpercentage = 0.0;
var waitername_forkot;
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
	ajaxCallObject.callAjax(BASE_URL + "/table/updatetableStatus/" + tableData
			+ "/" + operation + ".htm", function() {
		location.href = BASE_URL + '/table/viewtable.htm';
	}, null);
}
function showtablebookingData() {
	// alert('tablebookingdata');
	document.getElementById('tablebookingheaderdata').style.display = 'block';
	document.getElementById('changetableheaderdata').style.display = 'block';
	document.getElementById('changetableheaderdataordersearch').style.display = 'block';
	$('#posliId').removeClass('hide');
	// document.getElementById('posliId').removeClass('hide');
	document.getElementById('orderType').value=SelectedOption;
	
}
function directOrderCheck(val) {
	if (val == 'xx') {
		showdirectOrderModal();
	}
}

/*search order by id*/
function searchbyorderno(orderno) { 
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/searchorderbyid/" + orderno
			+ ".htm", function(res) {
		console.log(res);
		var resoderdet = JSON.parse(res);
		var orderNo = resoderdet.id;
		if (orderNo == 0) {
			$("#noOrderRecordsFoundModal").modal("show");
		} else {
			// var orderNo=orderNo_withordertype.split("_")[0];
			var orderType = resoderdet.ordertype.id;
			var tabno = resoderdet.table_no;
			var seatno = (resoderdet.seatNo == null) ? 0 : resoderdet.seatNo;
			SelectedOption = orderType;
			// alert(orderType);
			// alert('select:'+orderNo+':'+tabno+':'+seatno);
			// if (orderType == 1) {
			// location.href = BASE_URL + '/order/vieworderHD.htm?ono=' +
			// orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=h';
			// } else if (orderType == 5) {
			// location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' +
			// orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=s';
			// } else if (orderType == 6) {
			// location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' +
			// orderNo + '&tno=' + tabno + '&sno=' + 0 + '&ot=z';
			// } else {
			// location.href = BASE_URL + '/order/vieworder.htm?ono=' + orderNo
			// + '&tno=' + tabno + '&sno=' + seatno;
			location.href = BASE_URL + '/order/vieworderwithordertype.htm?ono='
					+ orderNo + '&tno=' + tabno + '&sno=' + seatno
					+ '&otypeno=' + SelectedOption;
			// }
		}

	}, null);
}

/*search order by order No*/
function searchOrderByOrderNo(orderno) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/searchorderbyOrderNo/" + orderno
			+ ".htm", function(res) {
		console.log(res);
		var resoderdet = JSON.parse(res);
		var orderNo = resoderdet.id;
		if (orderNo == 0) {
			$("#noOrderRecordsFoundModal").modal("show");
		} else {
			var orderType = resoderdet.ordertype.id;
			var tabno = resoderdet.table_no;
			var seatno = (resoderdet.seatNo == null) ? 0 : resoderdet.seatNo;
			SelectedOption = orderType;
			location.href = BASE_URL + '/order/vieworderwithordertype.htm?ono='
					+ orderNo + '&tno=' + tabno + '&sno=' + seatno
					+ '&otypeno=' + SelectedOption;
			
		}

	}, null);
}
















function clickonSubmenu(subMenuId, cssIndex) {
	loadMenuItems(BASE_URL + "/menu/menuitems.htm?menuid=" + subMenuId
			+ "&index=" + cssIndex + "", document
			.getElementById('menu_items_container'));
}

function loadMenuItems(url, containerId) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(url, function(response) {
		containerId.innerHTML = response;
	}, null);
}

var tableID=null;
var tableNum=null;
var orderNum=null;
var seatNum=null;
var waiterName=null;
function clickOnTable(tableId, tableNo, orderNo, seatNo) {
	// alert(tableId+":"+tableNo+":"+orderNo);
	
	tableID=tableId;
	tableNum=tableNo;
	orderNum=orderNo;
	seatNum=seatNo;
	
	if(waiterNameFlag=='Y' && orderNo==0){
		
		
		$('#waiterNameModal').modal('show');
	}
	else{
		
		location.href = BASE_URL + '/order/vieworder.htm?ono=' + orderNum + '&tno='
		+ tableNum + '&sno=' + seatNum;
	}
	
}
function saveWaiterName() {
	
	waiterName= $("#waiterName").val();
	//waitername_forkot = waiterName;
	if(waiterName=='') {
		
		$("#waiternamereq").removeClass("hide");
	} else {
		
		$("#waiternamereq").addClass("hide");
		$("#waiterNameModal").modal("hide");
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		 ajaxCallObject.callAjax(BASE_URL+'/table/setwaitername.htm?waiterName='+waiterName,
		           function(response) {
		           try {
		         
		           } catch (e) {
		                  alert(e);
		              }
		             }, null);

		location.href = BASE_URL + '/order/vieworder.htm?ono=' + orderNum + '&tno='
		+ tableNum + '&sno=' + seatNum;
	}
}
function cancelWaiterName() {

	$("#waiternamereq").addClass("hide");
	$('#waiterNameModal').modal('hide');
}

var orderitemdata = null;
/*function additemtoOrder(itId, itName, itPrice, disc, vat, serviceTax,
		promoFlag, promoValue,isKotPrint) {
	var menuitempost = {};
	menuitempost.id = itId;
	menuitempost.name = itName;
	menuitempost.price = itPrice;
	menuitempost.vat = vat;
	menuitempost.serviceTax = serviceTax;
	menuitempost.promotionFlag = promoFlag;
	menuitempost.promotionValue = promoValue;
	menuitempost.isKotPrint = isKotPrint;
	
	$
			.ajax({
				url : BASE_URL + "/order/addorderitempost.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(menuitempost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					// called when
					// successful
					try {
						var responseObj = JSON.parse(response);
						prepareOrderHtml(responseObj);
						var qty = null;
						for (var i = 0; i < responseObj.length; i++) {
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
							ajaxCallObject.callAjax(BASE_URL
									+ "/order/showvfd/" + qty + "x" + itName
									+ ":" + parseFloat(itPrice).toFixed(2)
									+ "/" + "TOT IN RM : "
									+ parseFloat(tot).toFixed(2) + ".htm",
									function() {
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
			}); // end

	/*
	 * var ajaxCallObject = new CustomBrowserXMLObject();
	 * ajaxCallObject.callAjax(BASE_URL + "/order/addorderitem/" + itId + "/" +
	 * decodeURIComponent(itName) + "/" + itPrice + "/" + disc + "/" + vat + "/" +
	 * serviceTax + "/" + promoFlag + "/" + promoValue + ".htm",
	 * function(response) {
	 * 
	 *  }, null);
	 */
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
/*}*/

var itemRecord=[];
function additemtoOrder(itId, itName, itPrice, disc, vat, serviceTax,
		promoFlag, promoValue,isKotPrint) {
	//alert(JSON.stringify(itemRecord));
	if(displayCurrentStockMenu == 'Y'){
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/itemstockin/getfgcurrentstock/" + itId + ".htm",function(response) {
			            var responseObj = JSON.parse(response);
			            var flag= false;
			            for(var k=0;k<itemRecord.length;k++){
			            	if(itemRecord[k].itemId == itId){
			            		flag=true;
			            		
			            	}
			            }
			            if(flag == false){
			            	itemRecord.push(responseObj[0]);
			            }
			           
			           $("#itmName").text(responseObj[0].name);
			           $("#itmcurstck").text(responseObj[0].curStock);
			           
			             $("#itIdData").val(itId);
		        		 $("#itNameData").val(itName);
		        		 $("#itPriceData").val(itPrice);
		        		 $("#discData").val(disc);
		        		 $("#vatData").val(vat);
		        		 $("#serviceTaxData").val(serviceTax);
		        		 $("#promoFlagData").val(promoFlag);
		        		 $("#promoValueData").val(promoValue);
		        		 $("#isKotPrintData").val(isKotPrint);
		        		 
			             if(responseObj[0].curStock<1){
			            	 if(negativeStockBilling == 'Y'){
			            		 $("#itmSaleBtn").removeClass('disabled');
			            	 }else{
			            		 $("#itmSaleBtn").addClass('disabled');
			            	 }
			        	  }else{
			        		  
			        		  if(negativeStockBilling == 'N'){
				        		   if(flag == true){
				        			   var currentQtyInBill = $("#qty"+itId).val();
				        			   if((Number(currentQtyInBill)+1) > responseObj[0].curStock){
				        				   $("#itmSaleBtn").addClass('disabled');
				        			   }else{
				        				   $("#itmSaleBtn").removeClass('disabled');
				        			   }
				        			   
				        		   }else{
				        			   $("#itmSaleBtn").removeClass('disabled');
				        		   }
				        		 
				        		  }else{
				        			  $("#itmSaleBtn").removeClass('disabled');
				        		  }
			        		  
			        		  
			        	  
			        	  }
			           $("#itemCurrentStockModal").modal('show');
						
		              }, null);
	}else{
		addOrUpdateOrderItems(itId, itName, itPrice, disc, vat, serviceTax,promoFlag, promoValue,isKotPrint);
	}	
	
}

function clearItemCodeSearch(){
	  $("#itemCodeSearch").val("");
}

function addOrUpdateOrderItems(itId, itName, itPrice, disc, vat, serviceTax,
		promoFlag, promoValue,isKotPrint){
	$("#itemCurrentStockModal").modal('hide');
	var menuitempost = {};
	menuitempost.id = itId;
	menuitempost.name = itName;
	menuitempost.price = itPrice;
	menuitempost.vat = vat;
	menuitempost.serviceTax = serviceTax;
	menuitempost.promotionFlag = promoFlag;
	menuitempost.promotionValue = promoValue;
	menuitempost.isKotPrint = isKotPrint;
	
	$
			.ajax({
				url : BASE_URL + "/order/addorderitempost.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(menuitempost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
				   try {
						var responseObj = JSON.parse(response);
						prepareOrderHtml(responseObj);
						var qty = null;
						for (var i = 0; i < responseObj.length; i++) {
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
							ajaxCallObject.callAjax(BASE_URL
									+ "/order/showvfd/" + qty + "x" + itName
									+ ":" + parseFloat(itPrice).toFixed(2)
									+ "/" + "TOT IN RM : "
									+ parseFloat(tot).toFixed(2) + ".htm",
									function() {
									}, null);
						}
					} catch (e) {
						alert(e);
					}

				},
				error : function(e) {
					
				}
			}); 
	
  }




var total = 0.0;
var totDisc = 0.0;
var forspNoteData = [];
function prepareOrderHtml(responseData) {
	forspNoteData = [];
	var itemObj = {};
	//alert(responseData.length);
	//console.log(JSON.stringify(responseData));
	orderitemdata = responseData;
	var staticVat = 14.5;
	var staticST = 5.6;
	
	var orderVat=0.0;
	var orderSTax=0.0;
	
	var subtotal = 0.0;
	var disc = 0.0;
	var staxAmt = 0.0;
	var vatAmt = 0.0;
	var grandTotal = 0.0;
	var netPrice = 0.0;
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var storedoubleroundoffflag = document
			.getElementById('hidstoredoubleroundoffFlag').value;
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
	var schargetext = $('#hidserviceChargeTextNew').val();
	var directordertaking = $("#directordertakingContId").val();
	// alert(schargetext);

	var createdrowline = "";
	var generatedHtml = "";
	// for saravana
	// var tableline = "<table class='table table-striped table-bordered'
	// style='color:#FFF; border:1px solid
	// #222222;'><thead><th></th><th>NAME</th><th
	// style='text-align:center;'>QUANTITY</th><th>TOTAL</th><th>RATE</th>";
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th></th><th>"
			+ getBaseLang.name
			+ "</th><th style='text-align:center;'>"
			+ getBaseLang.qty
			+ "</th><th>"
			+ getBaseLang.rate
			+ "</th><th>"
			+getBaseLang.tot + "</th>";
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
	for (var i = 0; i < responseData.length; i++) {

		var orderitem = responseData[i];
		//alert(responseData[i].vat + " : " + responseData[i].serviceTax);
		// alert("flag:"+decode_utf8(orderitem.item.isKotPrint));
		// alert("flag:"+orderitem.item.isKotPrint);
		//alert( responseData[i].name);
		ordItemVal = responseData[i];
		var disc1 = 0.0;
		var begintrline = "";
		var firsttdline = "";
		var secondtdline = "";
		var thirdtdline = "";
		var kotflagline = "";
		if (orderitem.isinOrder == 'Y') {
			//alert(orderitem.itemName + "EXIST");
			var trbgColor = "#2E2E2E";
			if (orderitem.itemName.indexOf("CONTAINER") == 0) {
				trbgColor = "#1c91bc";
			}
			begintrline = "<tr style='background:" + trbgColor
					+ "; padding:2px;'>";
			firsttdline = "<td style='padding:1px;text-align:center;'>"
					+ (i + 1) + "</td>";
			/*if (orderitem.ordertype == 2) {
				secondtdline = "<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>"
						+ orderitem.itemName + "(P)</td>";
			} else {*/
				secondtdline = "<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>"
						+ orderitem.itemName + "</td>";
			/*}*/
			thirdtdline = "<td valign='middle' align='center' style='padding:3px;'> "
					+ orderitem.quantityOfItem +
					// "<input type='text' size='1' disabled='disabled'
					// value='"+orderitem.quantityOfItem+"'
					// style='text-align:center;color:#fff;
					// background-color:#333;height:22px;width:30px;'>" +
					"</td>";

			kotflagline="<td valign='middle' align='center' style='padding:3px;display:none;'>"
				+ orderitem.item.isKotPrint +				
				"</td>";
		
		
		} else {
			//alert(orderitem.itemName + "NEW");
			// forspNoteData=[];
			forspNoteData.push(orderitem);
			var trbgColor = "#222222";
			if (orderitem.itemName.indexOf("CONTAINER") == 0) {
				trbgColor = "#1c91bc";
			}
			begintrline = "<tr id='row_" + orderitem.itemId
					+ "' style='background:" + trbgColor + "; padding:2px;'>";
			firsttdline = "<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRow("
					+ orderitem.itemId
					+ ",this)' id='chk_"
					+ orderitem.itemId
					+ "'></td>";
			secondtdline = "<td width='50%'  onclick='javascript:selectRow("
					+ orderitem.itemId
					+ ")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"
					+ orderitem.itemName + "</td>";
			thirdtdline = "<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:decreaseItemQuantity("
					+ orderitem.itemId
					+ ",&quot;"
					+ orderitem.itemName
					+ "&quot;,"
					+ orderitem.rate
					+ ")'><img border='0' alt='' src='"
					+ BASE_URL
					+ "/assets/images/base/d/d_delete.png' height='22' width='18'></a> "
					+ "<input type='text' onClick='this.select();' id='qty"
					+ orderitem.itemId
					+ "' size='1' onkeyup='javascript:enterManualQuantity(this.value,"
					+ orderitem.itemId
					+ ")' value='"
					+ orderitem.quantityOfItem
					+ "' style='text-align:center;color:#fff; background-color:#333;height:22px;width:30px;' class='ordermanualQty'>"
					+ " <a href='javascript:increaseItemQuantity("
					+ orderitem.itemId
					+ ",&quot;"
					+ orderitem.itemName
					+ "&quot;,"
					+ orderitem.rate
					+ ")'><img border='0'  alt='' src='"
					+ BASE_URL
					+ "/assets/images/base/d/d_add.png' height='22' width='18'></a></td>";
		
			kotflagline="<td valign='middle' align='center' style='padding:3px;display:none;'>"
				+ orderitem.item.isKotPrint +				
				"</td>";
		
		
		}
		if (orderitem.item.promotionFlag == 'Y') {
			disc1 = (orderitem.rate * orderitem.quantityOfItem)
					* orderitem.discount / 100;
		}
		// staxAmt+=(orderitem.rate*orderitem.quantityOfItem-disc1)*orderitem.serviceTax/100;
		// vatAmt+=(orderitem.rate*orderitem.quantityOfItem-disc1)*orderitem.vat/100;
		//alert(orderitem.serviceTax);
		
		
		
		
//		if (storeID == '35' && tableno != '0' && orderitem.serviceTax == '0') {
//			staxAmt += (orderitem.rate * orderitem.quantityOfItem - disc1)
//					* staticST / 100;
//		} else {
//			staxAmt += (orderitem.rate * orderitem.quantityOfItem - disc1)
//					* orderitem.serviceTax / 100;
//		}
//		if (storeID == '35' && tableno != '0' && orderitem.vat == '0') {
//			vatAmt += ((orderitem.rate * orderitem.quantityOfItem - disc1)
//					* staticVat / 100);
//		} else {
//			vatAmt +=((orderitem.rate * orderitem.quantityOfItem - disc1)
//					* orderitem.vat / 100);
//		}
				
		
		disc += disc1;
		subtotal += (orderitem.rate * orderitem.quantityOfItem) - disc1;
		var fourthtdline = "<td  style='padding:1px;text-align: center;'>"
				+ parseFloat(orderitem.rate * orderitem.quantityOfItem - disc1)
						.toFixed(2) + "</td>";
		var fifthtdline = "<td style='padding:1px;text-align: center;'>"
				+ parseFloat(disc1).toFixed(2) + "</td>";
		var sixthtdline = "<td style='padding:1px;text-align: center;'>"
				+ parseFloat(orderitem.rate).toFixed(2) + "</td>";
		var seventhhtdline = "";
		var eighthtdline = "";
		if (vattaxText.length != 0) {
			seventhhtdline = "<td style='padding:1px;text-align: center;'>"
					+ parseFloat(orderitem.vat).toFixed(2) + "</td>";
		}
		if (servicetaxText.length != 0) {
			eighthtdline = "<td style='padding:1px;text-align: center;'>"
					+ parseFloat(orderitem.serviceTax).toFixed(2) + "</td>";
		}

		var endtrline = "</tr>";

		// disc+=(orderitem.rate*orderitem.discount/100)*orderitem.quantityOfItem;

		// createdrowline+=begintrline+firsttdline+secondtdline+orderitem.itemName+thirdtdline+fourthtdline+parseFloat(orderitem.rate*orderitem.quantityOfItem).toFixed(2)+endtrline;
		// for saravana
		createdrowline += begintrline + firsttdline + secondtdline
				+ thirdtdline + sixthtdline + fourthtdline  + kotflagline+ endtrline;
		// for other
		// createdrowline+=begintrline+firsttdline+secondtdline+thirdtdline+fourthtdline+fifthtdline+sixthtdline+seventhhtdline+eighthtdline+endtrline;

		// createdrowline+=begintrline+firsttdline+secondtdline+orderitem.itemName+thirdtdline+fourthtdline+parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2)+fifthtdline+parseFloat(disc1).toFixed(2)+sixthtdline+parseFloat(orderitem.rate).toFixed(2)+seventhhtdline+orderitem.vat+eighthtdline+orderitem.serviceTax+endtrline;
		// createdrowline+=begintrline+firsttdline+secondtdline+orderitem.itemName+thirdtdline+fourthtdline+parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2)+fifthtdline+parseFloat(disc1).toFixed(2)+sixthtdline+parseFloat(orderitem.rate).toFixed(2)+seventhhtdline+parseFloat(orderitem.vat).toFixed(2)+eighthtdline+endtrline;

	}
	/*
	 * itemObj.id = orderValue.itemId; for(var j = 0; i < itemObjValue;j++){
	 * if(itemObjValue[j].id == orderValue.itemId){ if(itemObj.quantity ==
	 * orderValue.quantityOfItem){
	 * 
	 * }else{
	 *  } }else{ itemObj.quantity = orderValue.quantityOfItem; } }
	 * 
	 * 
	 * itemObj.name = orderValue.itemName; itemObj.quantity = $("#qty"+
	 * itemObj.id).val();
	 */
	var subtotalWithOutTax=0;
	var subtotalWithTax=0;
	//alert(responseData.length);
	for (var j = 0; j < responseData.length; j++) {

		var orderitemDesc = responseData[j];

			var discRate = 0;
			if (orderitemDesc.item.promotionFlag == 'Y') {
				disc1 = (orderitemDesc.rate * orderitemDesc.quantityOfItem)
						* orderitemDesc.discount / 100;
			}
			if(orderitemDesc.serviceTax == '0' && orderitemDesc.vat == '0')
				subtotalWithOutTax += (orderitemDesc.rate * orderitemDesc.quantityOfItem) - discRate; 
			else
				{
				orderVat=orderitemDesc.vat;
				orderSTax=orderitemDesc.serviceTax;
			    subtotalWithTax += (orderitemDesc.rate * orderitemDesc.quantityOfItem) - discRate;
			   
			    // new added strt 28.3.2019 for item wise tax calculation
			    staxAmt += (((orderitemDesc.rate * orderitemDesc.quantityOfItem)-discRate) * orderSTax) / 100;
			    vatAmt +=  (((orderitemDesc.rate * orderitemDesc.quantityOfItem)-discRate) * orderVat) / 100;
			    //new added end
				}

	}
	
	if(subtotalWithOutTax>custdiscAmtVal)
	{
		subtotalWithTax=subtotal - subtotalWithOutTax;	
	}
	else
	{	
		 subtotalWithTax=subtotal - custdiscAmtVal;
	}
	
	
	//alert("subtotalWithOutTax-> " + subtotalWithOutTax + " subtotalWithTax-> " + subtotalWithTax + " custdiscAmtVal-> " + custdiscAmtVal);
	//alert(" subtotalWithTax-> " + subtotalWithTax + " custdiscAmtVal-> " + custdiscAmtVal);
	
	if (storeID == '35' && tableno != '0' && orderSTax == '0') {
		staxAmt = (subtotalWithTax * staticST / 100);
	} else {
		//staxAmt = (subtotalWithTax * orderSTax / 100); // off new 28.3.2019
	}
	if (storeID == '35' && tableno != '0' && orderVat == '0') {
		vatAmt = (subtotalWithTax * staticVat / 100);
	} else {
		//vatAmt =(subtotalWithTax * orderVat / 100);  // off new 28.3.2019
	}
	
	console.log(staxAmt + " " + vatAmt);
	
	/*Changed in 18.7.2018 strt*/
	  var flag = false;
	    for(var t=0;t<itemObjValue.length;t++){
	    	if(itemObjValue[t]==ordItemVal.itemId){
	    		flag = true;
	    	}
	    }
	    if(flag == false){
	    	//alert("add:"+ordItemVal.itemName);
	    	itemObjValue.push(ordItemVal.itemId);//18.7.2018
	    	}
	
	    /*Changed in 18.7.2018 end*/
	
	//itemObjValue.push(ordItemVal.itemId);
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

	// alert(orderType);
	if (schargetext == 'Y' && scharge != 0.00) {
//		if (currentTable == 0 && orderType == '') {
//			scharge = 0;
//		} else {
			staxAmt = staxAmt + staxAmt * scharge / 100;
			vatAmt = vatAmt + vatAmt * scharge / 100;
			scharge = subtotal * scharge / 100;
			//alert("scharge:"+scharge);
	//	}
    //  alert(scharge);
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
	if (schargetext == 'Y' ) {
//		if (currentTable == 0 && orderType == '') {
//			$("#schrgId").html(parseFloat(0).toFixed(2));
//		} else {
			$("#schrgId").html(parseFloat(scharge).toFixed(2));
	//	}

	}
	if (servicetaxText.length != 0) {
		document.getElementById('servicetaxcontId').innerHTML = parseFloat(staxAmt).toFixed(2);
	}
	if (vattaxText.length != 0) {
		document.getElementById('vatcontId').innerHTML = parseFloat(vatAmt).toFixed(2);
	}
//alert(vatAmt);
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


/* Item increase by clicking + start*/

function increaseItemQuantity(itemId,itemName,itemRate){
	var salepageqty = $("#qty"+itemId).val();
	if(salepageqty == ""){
		 $("#hiddmanualeditItmId").val(itemId);
		 $("#alerteditOrderquantityModal1").modal('show');
	}else{
    if(displayCurrentStockMenu == 'Y'){
    	    for(var i=0;i<itemRecord.length;i++){
    	    	if(itemRecord[i].itemId==itemId){// Item Found Start
    	    		if(negativeStockBilling=='N'){ //negativeStockBilling is N
    	    			   if(itemRecord[i].curStock<=(Number(salepageqty))){ // out of stock
    	    		    	   document.getElementById('msgspace').innerHTML = "Item Can't Add.Out Of Stock";
    	    				   $("#msgmodal").modal('show');
    	    			    }else{ // In stock
    	    			    	orderItemQtyIncrease(itemId,itemName,itemRate);
    	    			    }
    	    	         }else{//negativeStockBilling is Y
    	    	        	 if(itemRecord[i].curStock<=(Number(salepageqty))){ // out of stock
    	    	        		/*$("#itIdOfOutStckItm").val(itemId);
 	    	    	    	    $("#itNameOfOutStckItm").val(itemName);
 	    	    	    	    $("#itPriceOfOutStckItm").val(itemRate);
 	    	    	    	    document.getElementById('msgspace1').innerHTML = "Item Is Out Of Stock";
 	    	    	    	    $("#itmOutOfStockmodal").modal('show');*/
    	    	        		 orderItemQtyIncrease(itemId,itemName,itemRate);
    	    	        		 
    	    	        	 }else{ // In stock
    	    	        		 orderItemQtyIncrease(itemId,itemName,itemRate);
    	    	        	 }
    	    	       }
    	    	  }// Item Found end
    	    }//loop end
    }else{
		orderItemQtyIncrease(itemId,itemName,itemRate);
	}
	}
 }



function orderItemQtyIncrease(itemId, itemName, itemRate) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/increaseitemquantity/" + itemId
			+ ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			prepareOrderHtml(responseObj);
			var qty = null;
			for (var i = 0; i < responseObj.length; i++) {
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
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" + qty
						+ "x" + itemName + ":"
						+ parseFloat(itemRate).toFixed(2) + "/"
						+ "TOT IN RM : " + parseFloat(tot).toFixed(2) + ".htm",
						function() {
						}, null);
			}
		} catch (e) {
			alert(e);
		}
	}, null);
}

/* Item increase by clicking + start*/

/* Item decrease by clicking - start*/

function decreaseItemQuantity(itemId, itemName, itemRate) {
	// alert(itemId);
	var salepageqty = $("#qty"+itemId).val();
	if(salepageqty == ""){
		 $("#hiddmanualeditItmId").val(itemId);
		 $("#alerteditOrderquantityModal1").modal('show');
	}else{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/decreaseitemquantity/" + itemId
			+ ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			
			var itemUpdateRecord = [];
			  for(var i=0;i<itemRecord.length;i++){
				  for(var k=0;k<responseObj.length;k++){
					 if(responseObj[k].itemId == itemRecord[i].itemId){
						 itemUpdateRecord.push(itemRecord[i]);
					 } 
				  }
			    }
			  itemRecord = itemUpdateRecord;
			
			
			prepareOrderHtml(responseObj);

			// for vfd
			if (vfdPort.length > 3) {
				if (itemName.length > 13)
					itemName = itemName.substring(0, 13);
				var tot = document.getElementById('amttopaycontId').innerHTML;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" + itemName
						+ ":-" + parseFloat(itemRate).toFixed(2) + "/"
						+ "TOT IN RM : " + parseFloat(tot).toFixed(2) + ".htm",
						function() {
						}, null);
			}
		} catch (e) {
			alert(e);
		}
	}, null);
  }
}

/* Item decrease by clicking - end*/



function enterManualQuantity(qty,itemId){
	var salepageqty = qty;
    if(displayCurrentStockMenu == 'Y'){
    	    for(var i=0;i<itemRecord.length;i++){
    	    	if(itemRecord[i].itemId==itemId){// Item Found Start
    	    		if(negativeStockBilling=='N'){ //negativeStockBilling is N
    	    			   if(itemRecord[i].curStock<(Number(salepageqty))){ // out of stock
    	    		    	   document.getElementById('msgspace').innerHTML = "Item Can't Add.Out Of Stock";
    	    		    	   document.getElementById('qty'+itemId).value="";
    	    		    	   document.getElementById('qty'+itemId).focus();
    	    				   $("#msgmodal").modal('show');
    	    			    }else{ // In stock
    	    			    	enterItemManualQuantity(qty,itemId);
    	    			    }
    	    	         }else{//negativeStockBilling is Y
    	    	        	 if(itemRecord[i].curStock<(Number(salepageqty))){ // out of stock
    	    	        		/*$("#itIdOfOutStckItmForManualEntry").val(itemId);
 	    	    	    	    $("#itNameOfOutStckItmForManualEntry").val(itemRecord[i].name);
 	    	    	    	    $("#itQtyOfOutStckItmForManualEntry").val(qty);
 	    	    	    	    document.getElementById('msgspace2').innerHTML = "Current Qty Of "+itemRecord[i].name+" is "+itemRecord[i].curStock;
 	    	    	    	    $("#itmOutOfStockmodalForManualEntry").modal('show');*/
    	    	        		 enterItemManualQuantity(qty,itemId);
    	    	        		 
    	    	        	 }else{ // In stock
    	    	        		 enterItemManualQuantity(qty,itemId);
    	    	        	 }
    	    	       }
    	    	  }// Item Found end
    	    }//loop end
    }else{
    	enterItemManualQuantity(qty,itemId);
	}
	
}


function enterItemManualQuantity(qty, itemId) {
	// alert(qty+":"+itemId);
	// var newqty=qty.trim();
	 $("#itmOutOfStockmodalForManualEntry").modal('hide');
	if (parseInt(qty) > 0) {

		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/manualitemquantity/" + qty
				+ "/" + itemId + ".htm", function(response) {
			try {
				var responseObj = JSON.parse(response);
				prepareOrderHtml(responseObj);
				document.getElementById('qty' + itemId).focus();
				var len = document.getElementById('qty' + itemId).value.length;
				document.getElementById('qty' + itemId).setSelectionRange(len,
						len);
			} catch (e) {
				alert(e);
			}
		}, null);
		// document.getElementById('qty'+itemId).focus();
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

function selectOrderType() {

	SelectedOption = $("#orderType").val();
	var orderNo = '0';
	var tableNo = '0';
	var seatNo = '0';
	location.href = BASE_URL + '/order/vieworderwithordertype.htm?ono='
			+ orderNo + '&tno=' + tableNo + '&sno=' + seatNo + '&otypeno='
			+ SelectedOption;
}

function createOrder() {
//alert("create order"+custId);
	// var option =document.getElementsByName("deliveryOption");
	var remark = document.getElementById("orderRmks").value;
	var option;
	var selOption = null;
	/*
	 * for(var i = 0; i < option.length; i++) { if(option[i].checked == true) {
	 * selOption = option[i].value; } }
	 */
	var customerContact = document.getElementById("modparcelcustPhone").value;
	//var customerID = document.getElementById("modparcelcustIdhidden").value;
	var customerName = document.getElementById("modparcelcustName").value;
	
	var tableno = document.getElementById('tablenoCont').innerHTML;
	
	//alert(customerID + " + " customerContact + " + " + customerName);
	//if (customerContact == '' &&  customerName == '' && tableno == '0')
	
	if (customerContact == '' &&  customerName == '')
	{
			//custId='0';
			//alert("null customer");
			 customerContact = document.getElementById("itemContactSearch").value;
			 customerName = document.getElementById("itemNameSearch").value;
	}
	
	/*if(customerContact == '' && customerName != ''){
		customerContact = document.getElementById("itemContactSearch").value;
		
		
	}
	else if(customerName == '' && customerContact != ''){
		customerName = document.getElementById("itemNameSearch").value;
		
		
	}*/
	
	else {
		  //alert("else in customer");
		 customerContact = '';
		 customerName = '';
	}
	//alert(custId + ":" + tableno);
	if(custId=='' || custId==null)
		{
			custId='0';
		}

	var custName = null;
	var custPhone = null;
	var custAddress = null;
	var deliveryPerson = null;
	var custvatregno = null;
	var location = null;
	var houseno = null;
	var streetno = null;
	var dob = null;
	var anniversary = null;
	var state = null;
	var waiterNameForTable=null;
	var orderno = document.getElementById('orderNo').value;
	
	var seatno = document.getElementById('hidcurrentSeat').value;
	var pax = document.getElementById('hidnoofPax').value;
	// SelectedOption=$("#orderTypeid" + orderNo).val();


	//if (tableno == '0') {
		///if (parcelAdd == 'Y' && itcatId == '') {
               //alert("parcel order");
			option = SelectedOption;
			custName = decodeURIComponent(document
					.getElementById('itemNameSearch').value);

			custPhone = document.getElementById('itemContactSearch').value;
			custAddress = decodeURIComponent(document
					.getElementById('modparcelcustAddress').value);
			deliveryPerson = decodeURIComponent(document
					.getElementById('modparceldeliveryPersonName').value);
			custvatregno = decodeURIComponent(document
					.getElementById('modparcelcustvatorcst').value);

//			if (orderno != 0) {
//				houseno = '';
//				streetno = '';
//				location = '';
//				state='';
//			} else {
				houseno = decodeURIComponent(document
						.getElementById('modparcelcusthouseno').value);
				streetno = decodeURIComponent(document
						.getElementById('modparcelcuststreet').value);
				location = decodeURIComponent(document
						.getElementById('modparcelcustlocation').value);
				state=decodeURIComponent(document.getElementById('modparcelcuststate').value);
		//	}

			dob = decodeURIComponent(document
					.getElementById('modparcelcustdob').value);
			anniversary = decodeURIComponent(document
					.getElementById('modparcelcustanniversary').value);
		/*} else {
			option = SelectedOption;
		}*/
		selOption = option;
	/*} else {
		custName = '';		
		selOption = SelectedOption;
	}*/
	//alert(SelectedOption);
	// option = document.getElementsByName("deliveryOption");
	// // document.getElementById("modparcelcustPhone").value = "";
	// /*
	// * if(tableno=='0') {
	// */
	// if (parcelAdd == 'Y' && itcatId == '') {
	// // option =document.getElementsByName("deliveryOptionParcel");
	// custName =
	// decodeURIComponent(document.getElementById('modparcelcustName').value);
	// custPhone = document.getElementById('modparcelcustPhone').value;
	// custAddress =
	// decodeURIComponent(document.getElementById('modparcelcustAddress').value);
	// deliveryPerson =
	// decodeURIComponent(document.getElementById('modparceldeliveryPersonName').value);
	// custvatregno=
	// decodeURIComponent(document.getElementById('modparcelcustvatorcst').value);
	// location=
	// decodeURIComponent(document.getElementById('modparcelcustlocation').value);
	// houseno=
	// decodeURIComponent(document.getElementById('modparcelcusthouseno').value);
	// streetno=
	// decodeURIComponent(document.getElementById('modparcelcuststreet').value);
	// } else {
	// option = document.getElementsByName("deliveryOption");
	// }
	//
	// /*
	// * } else { option =document.getElementsByName("deliveryOption"); }
	// */
	// for ( var i = 0; i < option.length; i++) {
	// if (option[i].checked == true) {
	// selOption = option[i].value;
	// }
	// }
	// alert(selOption);
	// alert('custname:'+custName+':custphone:'+custPhone+':custaddress:'+custAddress+':deliveryperson:'+deliveryPerson);
	
	//alert(waiterName + selOption);
	var orderTypeName=document.getElementById('modOrderType').innerHTML;
	if(orderTypeName=='Dine In' && waiterNameFlag=='Y')
		{
		waiterNameForTable=waiterName;
		}
	//alert(custId + " : " + custName + " : " + custPhone + " : " + custAddress + " : " + deliveryPerson + " : " + custvatregno + " : " + location + " : " + houseno + " : " + streetno + " : " + dob + " : " + anniversary + " : " + state + " : ");
	//alert(customerContact + " : " + customerName);
	
	if(custPhone==null)
		{
		custPhone='';
		}
	if(custPhone == '')
	{
	custPhone='';
	}
	if(custName==null)
	{
		custName='';
	}
	if (custPhone == '' &&  custName == '')
	{
		//alert('blank');
		 custId='0';
		 custName = '';
		 custPhone = '';
		 custAddress = '';
		 deliveryPerson = '';
		 custvatregno = '';
		 location = '';
		 houseno = '';
		 streetno = '';
		 dob = '';
		 anniversary = '';
		 state = '';
		}

	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var storedoubleroundoffflag = document
			.getElementById('hidstoredoubleroundoffFlag').value;
	var netamt = 0.0;
	
	//alert(custId + " : " + custName + " : " + custPhone + " : " + custAddress + " : " + deliveryPerson + " : " + custvatregno + " : " + location + " : " + houseno + " : " + streetno + " : " + dob + " : " + anniversary + " : " + state + " : ");

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/order/createorder.htm?delOption=" + selOption
							+ "&orderno=" + orderno + "&tableno=" + tableno
							+ "&custId=" + custId + "&custname=" + custName + "&custphone="
							+ custPhone + "&custaddress=" + custAddress
							+ "&deliveryperson=" + deliveryPerson + "&seatno="
							+ seatno + "&pax=" + pax + "&custvatregno="
							+ custvatregno + "&location=" + location
							+ "&houseno=" + houseno + "&streetno=" + streetno
							+ "&dob=" + dob + "&anniversary=" + anniversary + "&state=" + state + "&waiterNameForTable=" + waiterNameForTable +"&remark=" + remark,
					function(response) {
						try {
							 //alert(response);
							var responseObj = JSON.parse(response);
							 //alert(responseObj);
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
								ordVal = responseObj.id;
								document.getElementById('modOrderCont').innerHTML = responseObj.id;
								 document.getElementById('modOrderSuccessStoreBasedOrderCont').innerHTML = responseObj.orderNo;
								document.getElementById('modAmtCont').innerHTML = parseFloat(
										total).toFixed(2);
								document.getElementById('modDiscCont').innerHTML = parseFloat(
										totDisc).toFixed(2);
								document.getElementById('modtotAmtCont').innerHTML = parseFloat(
										netamt).toFixed(2);
								/*
								 * if(tableno=='0') { var instantPrintBill="<button
								 * type='button'
								 * onclick='javascript:printinstantBill("+responseObj+");()'
								 * style='background: #72BB4F;font-weight:
								 * bold;' data-dismiss='modal' class='btn
								 * btn-success'>PRINT BILL</button>";
								 * document.getElementById('parcelInstantPrintBillContId').innerHTML=instantPrintBill; }
								 */
								if(ordSucc == 'Y'){
								showOrderModal();
								}
								else{
									orderSuccessOK();
								}
							}

						} catch (e) {
							alert(e);
						}
					}, null);
}

function orderSuccessOK() {
	var printbillpapersize = $("#printbillpapersize").val();
	var kotPrintValue = $("#kotPrintVal").val();
	var remark = $("#orderRmks").val();
	//alert("print:"+kotPrintValue+":size:"+printbillpapersize);
	var table_no = document.getElementById('modTabCont').innerHTML;
	order_no = document.getElementById('modOrderCont').innerHTML;
	var ordernumber1 = document.getElementById('modOrderSuccessStoreBasedOrderCont').innerHTML;
	// alert(table_no+':'+order_no+':'+itcatId);

	enblSaveOrder();
	enblPayByCashButton();
	enblPayByCardButton();
	enblPayByOnlineButton();
	if (kotPrintValue == "Y") {
		//alert("kot y");
		
		if (printbillpapersize == '58.00') {

			for (var j = 0; j < itemUnique.length; j++) {
				var name = $("#row_" + itemUnique[j]).find('td:eq(1)').text();
				var quantity = $("#qty" + itemUnique[j]).val();
				var itembasedkotflag=$("#row_" + itemUnique[j]).find('td:eq(5)').text();
				//alert("itembasedkotflag"+itembasedkotflag);
				/*
				 * var total = $("#row_" +itemUnique[j]
				 * ).find('td:eq(3)').text(); var rate = $("#row_"
				 * +itemUnique[j] ).find('td:eq(4)').text();
				 */
				if (quantity != undefined && (itembasedkotflag== 'Y'|| itembasedkotflag== 'y')) {
					var rowline = "";
					var starttrline = "<tr>";
					var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 13px; word-wrap: break-word;'>"
							+ name + "</td>";
					var secondtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 13px;'>"
							+ quantity + "</td>";
					// var thirdtdline = "<td valign='middle' align='center'
					// style='padding: 3px; font-size: 11px;'>"+total+"</td>";
					// var fourthtdline = "<td valign='middle' align='center'
					// style='padding: 3px; font-size: 11px;'>"+rate+"</td>";
					var endtrline = "</tr>";
					rowline = starttrline + firsttdline + secondtdline /*
																		 * +
																		 * thirdtdline +
																		 * fourthtdline
																		 */
							+ endtrline;
					// alert(rowline);
					var splnoterowline = "";
					// alert(forspNoteData.length);
					for (var i = 0; i < forspNoteData.length; i++) {
						var item = forspNoteData[i];
						var id = item.itemId;
						if (id == itemUnique[j]) {
							var note = decodeURIComponent($(
									'#spnoteinput_' + id).val());
							if (undefined != note && note != "undefined"
									&& note != "") {
								splnoterowline = "";
								var splnotestarttrline = "<tr>";
								var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 12px; word-wrap: break-word;'>#"
										+ note + "</td>";
								var splnoteendtrline = "</tr>";
								splnoterowline = splnotestarttrline
										+ firsttdline + splnoteendtrline;
							}
						}

						// alert(id+':'+note);
					}
					$("#kotitems58").append(rowline + splnoterowline);
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

			// alert(todayDate);
			document.getElementById('dateTimeValue58').innerHTML = todayDate
					+ " " + strTime;
			//document.getElementById('ordValue58').innerHTML = ordVal;
			document.getElementById('ordValue58').innerHTML = ordernumber1;
			if (currentTable == 0) {
				
				var selectedordervalue = document.getElementById('orderType');// new
				var selectedordertype = selectedordervalue.options[selectedordervalue.selectedIndex].innerHTML;// new
				document.getElementById('hdorpercelValue58').innerHTML = selectedordertype; // new				
								
				$("#kottable58").hide();
				$("#kothdorpercel58").show();
				if (orderType == 'h') {
					$("#hdorpercelValue58").text("Home Delivery");
				} else if (orderType == 's') {
					$("#hdorpercelValue58").text("Swiggy");
				} else if (orderType == 'z') {
					$("#hdorpercelValue58").text("Zomato");
				} else {

				}
			} else {
				$("#kothdorpercel58").hide();
				document.getElementById('tblValue58').innerHTML = tableNoValue;
			}

			itemUnique = "";
			$("#hdorRemarksValue58").text(remark);
			kotPrint58();

		} else {
			//alert("kot80 y");
			var countSpclNote = 0;
			for (var j = 0; j < itemUnique.length; j++) {
				//alert(itemUnique[j]);
				var name = $("#row_" + itemUnique[j]).find('td:eq(1)').text();
				var quantity = $("#qty" + itemUnique[j]).val();
				var itembasedkotflag=$("#row_" + itemUnique[j]).find('td:eq(5)').text();
				//alert("itembasedkotflag:"+itembasedkotflag+":qq:"+quantity);
				/*
				 * var total = $("#row_" +itemUnique[j]
				 * ).find('td:eq(3)').text(); var rate = $("#row_"
				 * +itemUnique[j] ).find('td:eq(4)').text();
				 */
				if (quantity != undefined && (itembasedkotflag== 'Y'|| itembasedkotflag== 'y')) {
					var rowline = "";
					var starttrline = "<tr>";
					var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 13px; word-wrap: break-word;'>"
							+ name + "</td>";
					var secondtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 13px;'>"
							+ quantity + "</td>";
					// var thirdtdline = "<td valign='middle' align='center'
					// style='padding: 3px; font-size: 11px;'>"+total+"</td>";
					// var fourthtdline = "<td valign='middle' align='center'
					// style='padding: 3px; font-size: 11px;'>"+rate+"</td>";
					var endtrline = "</tr>";
					rowline = starttrline + firsttdline + secondtdline /*
																		 * +
																		 * thirdtdline +
																		 * fourthtdline
																		 */
							+ endtrline;
					// alert(rowline);
					var splnoterowline = "";
					// alert(forspNoteData.length);
					for (var i = 0; i < forspNoteData.length; i++) {
						var item = forspNoteData[i];
						var id = item.itemId;
						if (id == itemUnique[j]) {
							var note = decodeURIComponent($(
									'#spnoteinput_' + id).val());
							if (undefined != note && note != "undefined"
									&& note != "") {
								countSpclNote = countSpclNote + 1;
								splnoterowline = "";
								var splnotestarttrline = "<tr>";
								var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 12px; word-wrap: break-word;'>"+countSpclNote+"##"
										+ note + "</td>";
								var splnoteendtrline = "</tr>";
								splnoterowline = splnotestarttrline
										+ firsttdline + splnoteendtrline;
							}
						}
					}
					$("#kotitems").append(rowline + splnoterowline);
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

			// alert(todayDate);
			document.getElementById('dateTimeValue').innerHTML = todayDate
					+ " " + strTime;
			//document.getElementById('ordValue').innerHTML = ordVal;
			document.getElementById('ordValue').innerHTML = ordernumber1;
			if (currentTable == 0) {
				var selectedordervalue = document.getElementById('orderType');// new
				var selectedordertype = selectedordervalue.options[selectedordervalue.selectedIndex].innerHTML;// new
				document.getElementById('hdorpercelValue').innerHTML = selectedordertype; // new				
				$("#kottable").hide();
				$("#kothdorpercel").show();
				if (orderType == 'h') {
					$("#hdorpercelValue").text("Home Delivery");
				} else if (orderType == 's') {
					$("#hdorpercelValue").text("Swiggy");
				} else if (orderType == 'z') {
					$("#hdorpercelValue").text("Zomato");
				} else {

				}
			} else {
				$("#kothdorpercel").hide();
				document.getElementById('tblValue').innerHTML = tableNoValue;
			}

			itemUnique = "";
			$("#hdorRemarksValue").text(remark);
			
			kotPrint();
			// printKotForPos();
		}

	} else {
		if (table_no == '0' && itcatId != '') {
			var option = document.getElementsByName("instantpayOption");
			var setOption = null;
			for (var i = 0; i < option.length; i++) {
				if (option[i].checked == true) {
					selOption = option[i].value;
				}
			}
			// document.getElementById('hidinstantPaymentType').value=selOption;
			// document.getElementById('hidinstantPaymentFlag').value="Y";
			location.href = BASE_URL + '/order/vieworders.htm?ono=' + order_no
					+ '&tno=' + table_no + '&sno=0' + '&itcno=' + itcatId
					+ '&flg=Y&ptype=' + SelectedOption;
		} else if (table_no == '0') {
			// if (orderType == 'h') {
			// location.href = BASE_URL + '/order/vieworderHD.htm?ono=' +
			// order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=h';
			// } else if (orderType == 's') {
			// location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' +
			// order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=s';
			// } else if (orderType == 'z') {
			// location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' +
			// order_no + '&tno=' + table_no + '&sno=' + 0 + '&ot=z';
			// } else {
			// location.href = BASE_URL + '/order/vieworder.htm?ono=' + order_no
			// + '&tno=' + table_no + '&sno=0';
			location.href = BASE_URL + '/order/vieworderwithordertype.htm?ono='
					+ order_no + '&tno=' + table_no + '&sno=0' + '&otypeno='
					+ SelectedOption;
			// }

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

function selectOderNo() {

	var orderNo = document.getElementById('orderNo').value;
	// var orderNo=orderNo_withordertype.split("_")[0];
	var orderType = $("#orderTypeid" + orderNo).val();

	var tabno = document.getElementById('tno' + orderNo).value;
	var seatno = document.getElementById('sno' + orderNo).value;

	SelectedOption = orderType;
	// alert(orderType);
	// alert('select:'+orderNo+':'+tabno+':'+seatno);
	// if (orderType == 1) {
	// location.href = BASE_URL + '/order/vieworderHD.htm?ono=' + orderNo +
	// '&tno=' + tabno + '&sno=' + 0 + '&ot=h';
	// } else if (orderType == 5) {
	// location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' + orderNo +
	// '&tno=' + tabno + '&sno=' + 0 + '&ot=s';
	// } else if (orderType == 6) {
	// location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' + orderNo +
	// '&tno=' + tabno + '&sno=' + 0 + '&ot=z';
	// } else {
	// location.href = BASE_URL + '/order/vieworder.htm?ono=' + orderNo +
	// '&tno=' + tabno + '&sno=' + seatno;
	location.href = BASE_URL + '/order/vieworderwithordertype.htm?ono='
			+ orderNo + '&tno=' + tabno + '&sno=' + seatno + '&otypeno='
			+ SelectedOption;
	// }

}

function validateCreateOrder() {
	//alert("savedOrderItemCount:"+savedOrderItemCount);
	//alert("orderitemdata:"+orderitemdata+"length:"+orderitemdata.length);
	
	if(parseInt(savedOrderItemCount)!=0 && savedOrderItemCount != '')
		{
		//alert("savedOrderItemCount != 0");
		if (orderitemdata != null && orderitemdata.length>parseInt(savedOrderItemCount)) {
			return true;
		}
		}
	else if(savedOrderItemCount == ''){
		//alert("savedOrderItemCount == '' ");
		if (orderitemdata != null) {
			return true;
		}
	}
	
	else{
		//alert("savedOrderItemCount == 0");
		if (orderitemdata != null && orderitemdata.length>savedOrderItemCount) {
			return true;
		}
	}
	return false;
}

function printBillWithReason() {
	// alert(printpaidBill);
	// var printbillcount=$("#printbillcount").val();
	$("#printbillresonreq").addClass("hide");
	var orderid = document.getElementById('orderNo').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getprintcount/" + orderid
			+ ".htm", function(response) {
		// alert(response);
		if (response == 0) {
			$("#printbillcount").val(0);
			// alert($("#printbillcount").val());
			printBill();
		} else if(printReason=='Y'|| printReason=='y'){			
			$("#printbillcount").val(response);
			document.getElementById('printbillreasonId').value='';
			showprintBillReasonModal();
		      }
		else{
			printBill();
		}
	}, null);

}
function printBillCountt(printbillcount) {
	// var printbillcount = $("#printbillcount").val();
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
//function printBill() {
//	var commBean = {};
//	commBean.orderId = document.getElementById('orderNo').value;
//	commBean.billPrintReason = $("#printbillreasonId").val();
//	$.ajax({
//		url : BASE_URL + "/order/updateprintcount.htm",
//		type : 'POST',
//		contentType : 'application/json;charset=utf-8',
//		data : JSON.stringify(commBean),
//		success : function(response, JSON_UNESCAPED_UNICODE) {
//
//			console.log(">>>>>> " + response);
//		}
//	});
//	var caseValue = $("#mobPrintVal").val();
//	var printbillpapersize = $("#printbillpapersize").val();
//	/*
//	 * for (var i = 0; i < forspNoteData.length; i++) { alert(forspNoteData[i]);
//	 * //Do something }
//	 */
//	// alert(forspNoteData.toString());
//	if (caseValue == "Y") {
//		var orderid = document.getElementById('orderNo').value;
//		var tableno = document.getElementById('tablenoCont').innerHTML;
//		var totalAmt = document.getElementById('subtotalcontId').innerHTML;
//		var servicechrg = $("#schrgId").html();
//		var serviceTax = document.getElementById('servicetaxcontId').innerHTML;
//		var vatTax = document.getElementById('vatcontId').innerHTML;
//		var grossAmt = document.getElementById('grandtotalcontId').innerHTML;
//		var amountPay = document.getElementById('amttopaycontId').innerHTML;
//		var discountValue = document.getElementById('discBtnContId').innerHTML;
//		var discountTxt = document.getElementById('discPerContId').innerHTML;
//		// helloBillPrint();
//		if (printbillpapersize == '58.00') {
//			document.getElementById('ordervalue').innerHTML = orderid;
//			document.getElementById('tableNoValue').innerHTML = tableno;
//			document.getElementById('totalamt').innerHTML = totalAmt;
//			document.getElementById('servTax').innerHTML = serviceTax;
//			document.getElementById('vatTax').innerHTML = vatTax;
//			document.getElementById('grossAmount').innerHTML = grossAmt;
//			document.getElementById('amoutToPay').innerHTML = amountPay;
//			document.getElementById('discountValue').innerHTML = discountValue;
//			document.getElementById('discountTxt').innerHTML = discountTxt;
//			document.getElementById('servChrg').innerHTML = servicechrg;
//
//			/*
//			 * if (currentTable == 0 && orderType == '') {
//			 * $("#totalServiceChrg").hide(); } else {
//			 * $("#totalServiceChrg").show(); }
//			 */
//			$("#totalServiceChrg").hide();
//
//			if (serviceTax > 0.00) {
//				$("#totalServiceTax").show();
//			} else {
//				// $("#totalServiceTax").addClass('hide');
//				$("#totalServiceTax").hide();
//			}
//			if (vatTax > 0) {
//				$("#totalVatTax").show();
//			} else {
//				$("#totalVatTax").hide();
//			}
//
//			if (discountValue > 0) {
//				$("#showDiscount").show();
//			} else {
//				$("#showDiscount").hide();
//			}
//			// $("#showtableno").hide();
//			localPrint();
//		} else if (printbillpapersize == '80.00') {
//			document.getElementById('ordervalue80px').innerHTML = orderid;
//			document.getElementById('tableNoValue80px').innerHTML = tableno;
//			document.getElementById('totalamt80px').innerHTML = totalAmt;
//			document.getElementById('servTax80px').innerHTML = serviceTax;
//			document.getElementById('vatTax80px').innerHTML = vatTax;
//			document.getElementById('grossAmount80px').innerHTML = grossAmt;
//			document.getElementById('amoutToPay80px').innerHTML = amountPay;
//			document.getElementById('discountValue80px').innerHTML = discountValue;
//			document.getElementById('discountTxt80px').innerHTML = discountTxt;
//			document.getElementById('servChrg80px').innerHTML = servicechrg;
//
//			/*
//			 * if (currentTable == 0 && orderType == '') {
//			 * $("#totalServiceCharge80px").hide(); } else {
//			 * $("#totalServiceCharge80px").show(); }
//			 */
//			$("#totalServiceCharge80px").hide();
//			if (serviceTax > 0.00) {
//				$("#totalServiceTax80px").show();
//			} else {
//				// $("#totalServiceTax").addClass('hide');
//				$("#totalServiceTax80px").hide();
//			}
//			if (vatTax > 0) {
//				$("#totalVatTax80px").show();
//			} else {
//				$("#totalVatTax80px").hide();
//			}
//
//			if (discountValue > 0) {
//				$("#showDiscount80px").show();
//			} else {
//				$("#showDiscount80px").hide();
//			}
//			// $("#showtableno80px").hide();
//			localPrint80px();
//		} else if (printbillpapersize == '2100.00') {
//			//
//			//			
//			// document.getElementById('ordervalue_2100px').innerHTML = orderid;
//			// document.getElementById('tableNoValue_2100px').innerHTML =
//			// tableno;
//			// // document.getElementById('orderType_2100px').innerHTML =
//			// tableno;
//			// document.getElementById('totalamt_2100px').innerHTML = totalAmt;
//			// document.getElementById('servTax_2100px').innerHTML= serviceTax;
//			// document.getElementById('vatTax_2100px').innerHTML = vatTax;
//			// document.getElementById('grossAmount_2100px').innerHTML =
//			// grossAmt;
//			// document.getElementById('amoutToPay_2100px').innerHTML =
//			// amountPay;
//			// document.getElementById('discountValue_2100px').innerHTML =
//			// discountValue;
//			// document.getElementById('discountTxt_2100px').innerHTML =
//			// discountTxt;
//			//			
//			//			
//			// if(serviceTax > 0.00){
//			// $("#totalServiceTax_2100px").show();
//			// }else{
//			// //$("#totalServiceTax").addClass('hide');
//			// $("#totalServiceTax_2100px").hide();
//			// }
//			// if(vatTax > 0){
//			// $("#totalVatTax_2100px").show();
//			// }else{
//			// $("#totalVatTax_2100px").hide();
//			// }
//			//			
//			// if(discountValue > 0){
//			// $("#showDiscount_2100px").show();
//			// }else{
//			// $("#showDiscount_2100px").hide();
//			// }
//			// $("#showtableno_2100px").hide();
//			// localPrint_2100px();
//			//		
//			//			
//
//			document.getElementById('ordervalue_2100px_gst').innerHTML = orderid;
//			document.getElementById('tableNoValue_2100px').innerHTML = tableno;
//			document.getElementById('totalamt_2100px_gst').innerHTML = totalAmt;
//			document.getElementById('taxableAmount_2100px_gst').innerHTML = totalAmt;
//			document.getElementById('servTax_2100px_gst').innerHTML = serviceTax;
//			document.getElementById('vatTax_2100px_gst').innerHTML = vatTax;
//			document.getElementById('totservTax_2100px_gst').innerHTML = serviceTax;
//			document.getElementById('totvatTax_2100px_gst').innerHTML = vatTax;
//			document.getElementById('grossAmount_2100px').innerHTML = grossAmt;
//			document.getElementById('totgrossAmount_2100px_gst').innerHTML = grossAmt;
//			document.getElementById('amoutToPay_2100px').innerHTML = amountPay;
//			document.getElementById('discountValue_2100px').innerHTML = discountValue;
//			document.getElementById('discountTxt_2100px').innerHTML = discountTxt;
//			document.getElementById('igst_2100px_gst').innerHTML = Number(serviceTax)
//					+ Number(vatTax);
//			document.getElementById('totigst_2100px_gst').innerHTML = Number(serviceTax)
//					+ Number(vatTax);
//			var totalDisc = 0.00;
//			var totalTaxableAmt = 0.00;
//			$('#orderItemTbl tbody tr').each(function() {
//				var itmdisc = $(this).find("#tbl_orderItemDisc").html();
//				var itmtaxamt = $(this).find("#tbl_orderItemTaxAmt").html();
//				totalDisc = totalDisc + Number(itmdisc);
//				totalTaxableAmt = totalTaxableAmt + Number(itmtaxamt);
//			});
//			$("#discountValue_2100px_gst")
//					.val(parseFloat(totalDisc).toFixed(4));
//			// $("#taxableAmount_2100px_gst").val(parseFloat(totalAmt).toFixed(4));
//
//			var word = number2text(grossAmt);
//
//			$("#grossAmount_2100px_word_gst").text(word);
//			if (serviceTax > 0.00) {
//				$("#totalServiceTax_2100px").show();
//			} else {
//				// $("#totalServiceTax").addClass('hide');
//				$("#totalServiceTax_2100px").hide();
//			}
//			if (vatTax > 0) {
//				$("#totalVatTax_2100px").show();
//			} else {
//				$("#totalVatTax_2100px").hide();
//			}
//
//			if (discountValue > 0) {
//				$("#showDiscount_2100px").show();
//			} else {
//				$("#showDiscount_2100px").hide();
//			}
//			$("#showtableno_2100px").hide();
//			localPrint_2100px();
//		}
//
//	} else {
//		var orderid = document.getElementById('orderNo').value;
//
//		// alert(orderid);
//		// var tableno=document.getElementById('tablenoCont').innerHTML;
//		if (orderid == 0 || forspNoteData.length > 0) {
//			// alert('Please save the order first!');
//			showalertsaveorderModal();
//		} else {
////			var ajaxCallObject = new CustomBrowserXMLObject();
////			ajaxCallObject.callAjax(BASE_URL + "/order/printbill/" + orderid
////					+ ".htm", function(response) {
////				try {
////					if (response == 'Success')
////						showBillPrintSuccessModal();
////
////				} catch (e) {
////					alert(e);
////				}
////			}, null);
//		}
//	}
//
//}
/*var cusaddress="";
var cuslocation="";
var cusstreet="";
var cushouseno="";
var dvlboy="";

function callCustomer(orderno){
	//alert("hhh");
	var ajaxCallObject = new CustomBrowserXMLObject();
	 ajaxCallObject
	 .callAjax(
			 BASE_URL + "/order/searchorderbyid/"
			 						+ orderno + ".htm",
			 function(response) {
				try {
					//alert('hello');
					var responseObj=JSON.parse(response);
	    			 console.log("responseObj12313" + response);
				     dvlboy=responseObj.deliveryPersonName;
				     cuslocation=responseObj.location;
				     cusstreet=responseObj.street;
				     cushouseno=responseObj.houseNo;
				     cusaddress=responseObj.deliveryAddress;
				     //alert("add1:"+cusaddress);
				     
				} catch (e) {
					console.log(e);
				}
			}, null);
	
	
}
*/


function printBill() // for unpaid order
{
	//alert("Print unpaid bill");
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
	for (var i = 0; i < forspNoteData.length; i++) {
	 //   alert(forspNoteData[i]);
	    //Do something
	}
	 //alert(forspNoteData.toString());
	
	
	
	
	
	if (caseValue == "Y") {
		//var orderNo=$('#orderNo').find("option:selected").val();	
		//callCustomer(orderNo); 
		//setTimeout(function(){
		//alert("case value y");
		
					
		var cusname=document.getElementById("modparcelcustName").value;
		var cusphno=document.getElementById("modparcelcustPhone").value;
		var orderid = document.getElementById('orderNo').value;
		//var orderid = document.getElementById('orderNo').value;
		var tableno = document.getElementById('tablenoCont').innerHTML;
		var orderTypeName=document.getElementById('hidnOrderTypeData').value;
		//alert("tableno"+tableno+"order type:"+orderTypeName);
		var totalAmt = document.getElementById('subtotalcontId').innerHTML;
		var totalRateAmount = document.getElementById('totalratecontId').innerHTML; // new 28.9.2018
		
		var serviceTax =  0.0;
		var vatTax = 0.0;
		if(document.getElementById('hidvatTaxVal').value!=0.0)
			{
			vatTax = document.getElementById('vatcontId').innerHTML;
			}
		if(document.getElementById('hidserviceTaxVal').value!=0.0)
			{
			serviceTax =  document.getElementById('servicetaxcontId').innerHTML;
			}
		//var serviceTax =  document.getElementById('servicetaxcontId').innerHTML;
		//var vatTax = document.getElementById('vatcontId').innerHTML;
		var grossAmt = document.getElementById('grandtotalcontId').innerHTML;
		var amountPay1 = document.getElementById('amttopaycontId').innerHTML;
		var amountPay =0.00;
		if(amountPay1 < 0){amountPay=0.00;}
		else{amountPay = amountPay1;}
		
		
		var discountValue = document.getElementById('discBtnContId').innerHTML;	
		if(isNaN(discountValue)){discountValue = "0.00";}
		var discountTxt = document.getElementById('discPerContId').innerHTML;
		var serviceCharge=0;
		//alert("discountValue::"+discountValue);
		if(document.getElementById('hiddenschrgFlag').innerHTML=='Y')
			{
			if(document.getElementById('hiddenschrgId').innerHTML!=0.0 )
				serviceCharge = document.getElementById('servicechrgId').innerHTML;
			
			else
				 serviceCharge=0.00;
			}
		else
			 serviceCharge=0.00;
		
//		helloBillPrint();
		//alert(printbillpapersize);
		if(printbillpapersize=='58.00'){
			//document.getElementById('ordervalue').innerHTML = orderid;
			document.getElementById('ordervalue').innerHTML = storeBasedOrderNumber;
			document.getElementById('tableNoValue').innerHTML = tableno;
			document.getElementById('totalamt').innerHTML = totalAmt;
			document.getElementById('servTax').innerHTML= serviceTax;
			document.getElementById('vatTax').innerHTML = vatTax;
			document.getElementById('grossAmount').innerHTML = grossAmt;
			document.getElementById('amoutToPay').innerHTML = amountPay;
			document.getElementById('discountValue').innerHTML = discountValue;
			document.getElementById('discountTxt').innerHTML =  discountTxt;
			
			if(tableno!='0'){
				$('#unpaidtableNoValue').text('Table No:'+tableno);
			}
			else{
				$('#unpaidtableNoValue').text(orderTypeName);
			}
			
			
			
			if(serviceTax > 0.00){
				    $("#totalServiceTax").show();
			}else{
				    //$("#totalServiceTax").addClass('hide');
				    $("#totalServiceTax").hide();
			}
			if(vatTax > 0){
				$("#totalVatTax").show();
			}else{
				$("#totalVatTax").hide();
			}
			
			if(discountValue > 0){
				$("#showDiscount").show();
			}else{
				$("#showDiscount").hide();
			}
			$("#showtableno").hide();
			localPrint();
		}else if(printbillpapersize=='80.00'){
			//alert("alert 80");
			if( gsttext != '' && gsttext.length>0){
				if(gstno != '' && gstno.length>0){
					   var gstText = gsttext+":"+gstno;
					   document.getElementById('gstdata').innerHTML = gstText;
					   $("gstdata").show();
					   
				   }
			}
			else{
				 $("gstdata").hide();
			}
			
			
			
			//document.getElementById('ordervalue80px').innerHTML = orderid;
			document.getElementById('ordervalue80px').innerHTML = storeBasedOrderNumber;
			document.getElementById('tableNoValue80px').innerHTML = tableno;
			
			//document.getElementById('totalamt80px').innerHTML = totalAmt; //changed in 28.9.2018 
			document.getElementById('totalamt80px').innerHTML = totalRateAmount;// add new 28.9.2018
			
			if(document.getElementById('hiddenschrgFlag').innerHTML=='Y')
			{
			if(document.getElementById('hiddenschrgId').innerHTML!=0.0 )
				document.getElementById('servChrg80px').innerHTML = serviceCharge;
			}
			document.getElementById('servTax80px').innerHTML= parseFloat(serviceTax).toFixed(2);
			document.getElementById('vatTax80px').innerHTML = parseFloat(vatTax).toFixed(2);
			document.getElementById('grossAmount80px').innerHTML = grossAmt;
			document.getElementById('amoutToPay80px').innerHTML = amountPay;
			document.getElementById('discountValue80px').innerHTML = discountValue;
			document.getElementById('discountTxt80px').innerHTML =  discountTxt;
			
			if(tableno!='0'){
				$('#unpaidtableNoValue80').text('Table No:'+tableno);
			}
			else{
				$('#unpaidtableNoValue80').text(orderTypeName);
			}		
			
			
			
			
			if(serviceTax > 0.00){
				    $("#totalServiceTax80px").show();
			}else{
				    //$("#totalServiceTax").addClass('hide');
				    $("#totalServiceTax80px").hide();
			}
			if(vatTax > 0){
				$("#totalVatTax80px").show();
			}else{
				$("#totalVatTax80px").hide();
			}
			
			if(discountValue > 0){
				$("#showDiscount80px").show();
			}else{
				$("#showDiscount80px").hide();
			}
			$("#showtableno80px").hide();
			
			
			/* if(tableno == '0' && parcelAdd == 'Y'){*/
			   if(parcelAdd == 'Y'){
        	      
				 document.getElementById('unpaidcustomerdetailstab').style.visibility = "visible";
				  /*if(cusname != '' && cusname != null && cusname.length >0){
						//alert(orderCustomerName);
						document.getElementById('cusnameup80').innerHTML =cusname;				
						document.getElementById("cusnametrup80").style.display = "block";
						
					}
					if(cusaddress != '' && cusaddress != null && cusaddress.length >0){
						document.getElementById('cusaddressup80').innerHTML =cusaddress;											
						 document.getElementById("cusaddresstrup80").style.display = "block";
					}
					if(cusphno != '' && cusphno != null && cusphno.length >0){
						document.getElementById('cusphnoup80').innerHTML =cusphno;
						document.getElementById("cusphnotrup80").style.display = "block";
						
					}
					if(cuslocation != '' && cuslocation != null && cuslocation.length >0){
						document.getElementById('cuslocationup80').innerHTML =cuslocation;
						document.getElementById("cuslocationtrup80").style.display = "block";
						
					}
					if(cusstreet != '' && cusstreet != null && cusstreet.length >0){
						document.getElementById('cusstreetup80').innerHTML =cusstreet;
						document.getElementById("cusstreettrup80").style.display = "block";
						 
					}
					if(cushouseno != '' && cushouseno != null && cushouseno.length >0){
						document.getElementById('cushousenoup80').innerHTML =cushouseno;
						document.getElementById("cushousenotrup80").style.display = "block";
						 
					}
					if(dvlboy != '' && dvlboy != null && dvlboy.length >0){
						document.getElementById('deliveryboyup80').innerHTML =dvlboy;	
						document.getElementById("deliveryboytrup80").style.display = "block";
						
					}*/
					
				}
			  else{
				  document.getElementById('unpaidcustomerdetailstab').innerHTML= "";  
				  document.getElementById('unpaidcustomerdetailstab').style.visibility = "hidden";  
			  }
			
			localPrint80px();
			
		} else if(printbillpapersize=='2100.00'){
			//alert("2100");
			//document.getElementById('ordervalue_2100px_gst').innerHTML = orderid;
			document.getElementById('ordervalue_2100px_gst').innerHTML = storeBasedOrderNumber;
			//alert(document.getElementById('ordervalue_2100px_gst').innerHTML);
			//document.getElementById('tableNoValue_2100px').innerHTML = tableno;
			//document.getElementById('totalamt_2100px_gst').innerHTML = totalAmt;
			document.getElementById('totalamt_2100px_gst').innerHTML = parseFloat(Number(totalAmt)+Number(discountValue)).toFixed(2);
			document.getElementById('taxableAmount_2100px_gst').innerHTML = Number(Number(totalAmt) + Number(serviceCharge)).toFixed(2);
			document.getElementById('servTax_2100px_gst').innerHTML= serviceTax;
			document.getElementById('vatTax_2100px_gst').innerHTML = vatTax;
			document.getElementById('totservTax_2100px_gst').innerHTML= serviceTax;
			document.getElementById('totvatTax_2100px_gst').innerHTML = vatTax;
			document.getElementById('totalTaxAmount_2100px_gst').innerHTML = Number(Number(vatTax)+Number(serviceTax)).toFixed(2);
			document.getElementById('grossAmount_2100px').innerHTML = grossAmt;
			
			
			document.getElementById('totgrossAmount_2100px_gst').innerHTML = grossAmt;
			document.getElementById('amoutToPay_2100px').innerHTML = amountPay;
			document.getElementById('discountValue_2100px').innerHTML = discountValue;
			document.getElementById('discountTxt_2100px').innerHTML =  discountTxt;
			document.getElementById('paidAmount_2100px').innerHTML =  parseFloat(Number(grossAmt) - Number(amountPay)).toFixed(2); //new added 10.5.2018
			
			//document.getElementById('igst_2100px_gst').innerHTML= Number(serviceTax) + Number(vatTax);
			//document.getElementById('totigst_2100px_gst').innerHTML= Number(serviceTax) + Number(vatTax);
			
			if(discountValue>0){ // added new 2nd Apr 2018
			document.getElementById('discountValue_2100px_gst').innerHTML = discountValue; // added new 2nd Apr 2018
		    }else{ // added new 2nd Apr 2018
			document.getElementById('discountValue_2100px_gst').innerHTML = '00'; // added new 2nd Apr 2018
		     }// added new 2nd Apr 2018
			
			if(document.getElementById('hiddenschrgFlag').innerHTML=='Y')
			{
			 document.getElementById('schargeValue_2100px_gst').innerHTML = serviceCharge;
			}
			
			
			
			
			
			if(tableno!='0'){
				$('#unpaidtableNoValue2100').text('Table No:'+tableno);
			}
			else{
				$('#unpaidtableNoValue2100').text(orderTypeName);
			}
			
			var totalDisc = 0.00;
			var totalTaxableAmt = 0.00;
			$('#orderItemTbl tbody tr').each(function() {
				var itmdisc = $(this).find("#tbl_orderItemDisc").html();
				var itmtaxamt = $(this).find("#tbl_orderItemTaxAmt").html();
				totalDisc = totalDisc + Number(itmdisc);
				totalTaxableAmt = totalTaxableAmt + Number(itmtaxamt);
			});
			$("#discountValue_2100px_gst").val(parseFloat(totalDisc).toFixed(4));
			//$("#taxableAmount_2100px_gst").val(parseFloat(totalAmt).toFixed(4));
			
			
			var word = number2text(grossAmt);
			
			$("#grossAmount_2100px_word_gst").text(word);
			if(serviceTax > 0.00){
				    $("#totalServiceTax_2100px").show();
			}else{
				    
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
		
	//}, 1000);	
	} else{
		//alert("case value not Y");
	var orderid=document.getElementById('orderNo').value;
	//var tableno=document.getElementById('tablenoCont').innerHTML;
	if(orderid==0 || forspNoteData.length>0)
	{
		//alert('Please save the order first!');
		showalertsaveorderModal();
	}
	else
		{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderid  + ".htm", function(response) {
			try{
				if(response=='Success')
					showBillPrintSuccessModal();
				
			}catch(e)
			{alert(e);}
			}, null);
		}
	}
}



function printPaidBill(orderid) //paid bill printing
{
	//alert("paid bill print"+orderid+""+storeID);
	var caseValue =  $("#mobPrintVal").val();
	var printbillpapersize = $("#printbillpapersize").val();
	
//	alert("<< storeID >> "+storeID+"<< caseValue >> "+caseValue+"<< printbillpapersize >> "+printbillpapersize+"<< orderid >> "+orderid);
	var order = {};
//	var orderId = document.getElementById('orderNo').value;
	order.id = orderid;
	order.storeId = storeID;
//	alert(order.id+ " >> "+order.storeId+ ">> "+BASE_URL);
	var ajaxCallObject = new CustomBrowserXMLObject();

	if (caseValue == "Y") {
		//alert("paid bill print case val Y");
		$.ajax({
			type : "POST",
			url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(order),
			success : function(response) {
				var jsonObj = JSON.parse(response);
				/* ***** Store Details ***** */
				
				console.log(response);
				//alert("fghfh"+response);
				var orderNo = jsonObj.id;
				//alert("orderNo"+orderNo);
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
				
				//console.log(jsonObj);
				//alert("serviceTaxAmt begin"+serviceTaxAmt);
				//alert("serviceChargeAmt begin"+serviceChargeAmt);
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

						//alert(" << NAME ????? "+item1.item.name + " << QTY ?? "+itemQty+" << itemRate ??? "+itemRate+" << itemTotalPrice ??? "+itemTotalPrice);

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
					//alert(" << subToatlAmt >> "+subToatlAmt+ " << serviceChargeAmt >>"+serviceChargeAmt+"<< serviceTaxAmt >>"+serviceTaxAmt+" << vatAmt >>"+vatAmt+"<< customerDiscount >>"+customerDiscount+"<< billAmt >> "+billAmt+"<< grossAmt >> "+grossAmt);						
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

				
					 
            /*if(tabNo == '0' && parcelAdd == 'Y'){*/
			  if(parcelAdd == 'Y'){
            	      //alert("jj");
            	     // alert(tabNo+""+parcelAdd);
            	    
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
            //alert("paymentsObj:"+paymentsObj);
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
				 //alert("paymentsObj == 1");
				var amt1 = jsonObj.payments[0].amount;
				var paidAmt1 = jsonObj.payments[0].paidAmount;
				if (amt1 == paidAmt1) {
					//alert("paymentammt == 1");					
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
					
			//		alert("printbillpapersize 2 >> "+printbillpapersize);
					
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
							/*itemTaxableAmt = ((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt;
							cgstAmt = ((((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt) * item1.vat)/100;
							sgstAmt = ((((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt) * item1.serviceTax)/100;*/
						    
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
							
							/*itemTaxableAmt = (item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt;
							cgstAmt = (((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt) * item1.vat)/100;
							sgstAmt = (((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt) * item1.serviceTax)/100;*/
							itemTaxableAmt = (((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt) - itemDisc) + itemschrgeamt;
							cgstAmt = ((((((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt))- itemDisc) + itemschrgeamt) * item1.vat)/100;
							sgstAmt = ((((((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt))- itemDisc) + itemschrgeamt) * item1.serviceTax)/100;
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

//function printPaidBill(orderid) {
//
//	var caseValue = $("#mobPrintVal").val();
//	var printbillpapersize = $("#printbillpapersize").val();
//	var order = {};
//	order.id = orderid;
//	order.storeId = storeID;
//	// alert(order.id+ " >> "+order.storeId+ ">> "+BASE_URL);
//	console.log("printbillpapersize 2 >>"+printbillpapersize);
//	var ajaxCallObject = new CustomBrowserXMLObject();
//	if (caseValue == "Y") {
//		$
//				.ajax({
//					type : "POST",
//					url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
//					contentType : 'application/json;charset=utf-8',
//					data : JSON.stringify(order),
//					success : function(response) {
//						var jsonObj = JSON.parse(response);
//						/* ***** Store Details ***** */
//						// alert("+jsonObj >> "+jsonObj);
//						var orderNo = jsonObj.id;
//						var tabNo = jsonObj.table_no;
//						var customerName = jsonObj.customers.name;
//						var customerAddr = jsonObj.customers.address;
//						var customerPhNo = jsonObj.customers.contactNo;
//						var customerEmail = jsonObj.customers.emailId;
//						var orderDateWithTime = jsonObj.customers.orderTime;
//						var orderTime = jsonObj.customers.time;
//
//						/* ***** Bill Amount Details ***** */
//						var storeId = jsonObj.orderBill.storeid;
//						var billAmt = jsonObj.orderBill.billAmount;
//						var serviceTaxAmt = jsonObj.orderBill.serviceTaxAmt;
//						var vatAmt = jsonObj.orderBill.vatAmt;
//						var grossAmt = jsonObj.orderBill.grossAmt;
//						var totalDiscount = jsonObj.orderBill.totalDiscount;
//						var customerDiscount = jsonObj.orderBill.customerDiscount;
//						var roundOffAmt = jsonObj.orderBill.roundOffAmt;
//						var discPercentage = jsonObj.orderBill.discountPercentage;
//						var serviceChargeAmt = jsonObj.orderBill.serviceChargeAmt;
//						var subToatlAmt = jsonObj.orderBill.subTotalAmt;
//						var totalTenderAmount = 0;
//						var paymentsObj = jsonObj.payments;
//
//						if (printbillpapersize == '58.00') {
//
//							/* ****** Print in 58 paper size ***** */
//
//							/* ********** START STORE INFO PRINT ********** */
//							$('#storeNamePaidOrder58').text(customerName);
//							$('#storeAddrPaidOrder58').text(storeAddr);
//							$('#storeEmailPaidOrder58').text(customerEmail);
//							$('#storePhNoPaidOrder58').text(customerPhNo);
//							$('#ordervaluePaidOrder58').text(orderNo);
//							$('#tableNoValuePaidOrder58').text(tabNo);
//
//							for (var k = 0; k < jsonObj.orderitem.length; k++) {
//								var item1 = jsonObj.orderitem[k];
//
//								var itemName = item1.item.name;
//								var itemQty = item1.quantityOfItem;
//								var itemRate = item1.rate;
//								var itemTotalPrice = item1.totalPriceByItem;
//
//								// alert(" << NAME ????? "+item1.item.name + "
//								// << QTY ?? "+itemQty+" << itemRate ???
//								// "+itemRate+" << itemTotalPrice ???
//								// "+itemTotalPrice);
//
//								var createdrowline = "";
//								var startTrline = "<tr style='padding: 1px;'>";
//								var firstTdline = "<td style='padding: 1px; max-width: 50px !important; word-wrap: break-word; font-size: 10px;font-family: sans-serif;'>"
//										+ itemName + "</td>";
//								var secondTdline = "<td style='padding: 1px; font-size: 10px;font-family: sans-serif;'>"
//										+ itemQty + "</td>";
//								var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>"
//										+ itemRate + "</td>";
//								var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>"
//										+ itemTotalPrice + "</td>";
//								var endTrline = "</tr>";
//
//								createdrowline = startTrline + firstTdline
//										+ secondTdline + thirdTdline
//										+ fourthTdline + endTrline;
//
//								$("#itemDetailsPrintPaidOrder58").append(
//										createdrowline);
//
//							}
//
//							$('#totalamtPaidOrder58').text(subToatlAmt);
//
//							if (serviceChargeAmt > 0) {
//								$("#totalServiceChrg_58").show();
//								$('#servChrgPaidOrder58')
//										.text(serviceChargeAmt);
//							} else {
//								$("#totalServiceChrg_58").hide();
//							}
//
//							if (serviceTaxAmt > 0.00) {
//								$("#totalServiceTax_58").show();
//								$('#servTaxPaidOrder58').text(serviceTaxAmt);
//							} else {
//								$("#totalServiceTax_58").hide();
//							}
//
//							if (vatAmt > 0) {
//								$("#totalVatTax_58").show();
//								$("#vatTaxPaidOrder58").text(vatAmt);
//							} else {
//								$("#totalVatTax_58").hide();
//							}
//
//							if (customerDiscount > 0) {
//								$("#showDiscount_58").show();
//								$("#discountValuePaidOrder58").text(
//										customerDiscount);
//							} else {
//								$("#showDiscount_58").hide();
//							}
//
//							$("#grossAmountPaidOrder58").text(billAmt);
//							$("#amoutToPayPaidOrder58").text(grossAmt);
//
//							var paidOrderPayObj = jsonObj.payments.length;
//							if (paidOrderPayObj == 1) {
//
//								var paidAmt = jsonObj.payments[0].paidAmount;
//								var tenderAmt = jsonObj.payments[0].tenderAmount;
//								var returnAmt = tenderAmt - paidAmt;
//								var type = jsonObj.payments[0].paymentMode;
//
//								$('#paidAmountPaidOrder58').text(paidAmt);
//								$('#tenderAmountPaidOrder58').text(tenderAmt);
//								$('#refundAmountPaidOrder58').text(returnAmt);
//								$('#payOrderTypePaidOrder58').text(type);
//
//							}
//							if (paidOrderPayObj == 2) {
//
//								var paidAmt = jsonObj.payments[0].paidAmount
//										+ jsonObj.payments[1].paidAmount;
//								var tenderAmt = jsonObj.payments[0].tenderAmount
//										+ jsonObj.payments[1].tenderAmount;
//								var returnAmt = tenderAmt - paidAmt;
//								var type1 = jsonObj.payments[0].paymentMode;
//								var type2 = jsonObj.payments[1].paymentMode;
//
//								$('#paidAmountPaidOrder58').text(paidAmt);
//								$('#tenderAmountPaidOrder58').text(tenderAmt);
//								$('#refundAmountPaidOrder58').text("0.00");
//								$('#payOrderTypePaidOrder58').text(
//										type1 + " + " + type2);
//							}
//
//							paidOrder58();
//
//						} else if (printbillpapersize == '80.00') {
//							/* ****** Print in 80 paper size ***** */
//
//							/* ********** START STORE INFO PRINT ********** */
//							$('#storeNamePaidOrder80').text(customerName);
//							$('#storeAddrPaidOrder80').text(storeAddr);
//							$('#storeEmailPaidOrder80').text(customerEmail);
//							$('#storePhNoPaidOrder80').text(customerPhNo);
//							$('#cashOrdervaluePaidOrder80').text(orderNo);
//							$('#cashtableNoValuePaidOrder80').text(tabNo);
//
//							/* ********** END STORE INFO PRINT ********** */
//
//							/* ********** START ITEM DETAILS PRINT ********** */
//
//							for (var k = 0; k < jsonObj.orderitem.length; k++) {
//								var item1 = jsonObj.orderitem[k];
//
//								var itemName = item1.item.name;
//								var itemQty = item1.quantityOfItem;
//								var itemRate = item1.rate;
//								var itemTotalPrice = item1.totalPriceByItem;
//
//								// alert(" << NAME ????? "+item1.item.name + "
//								// << QTY ?? "+itemQty+" << itemRate ???
//								// "+itemRate+" << itemTotalPrice ???
//								// "+itemTotalPrice);
//
//								var createdrowline = "";
//								var startTrline = "<tr style='padding: 2px;'>";
//								var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>"
//										+ itemName + "</td>";
//								var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>"
//										+ itemQty + "</td>";
//								var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>"
//										+ itemRate + "</td>";
//								var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>"
//										+ itemTotalPrice + "</td>";
//								var endTrline = "</tr>";
//
//								createdrowline = startTrline + firstTdline
//										+ secondTdline + thirdTdline
//										+ fourthTdline + endTrline;
//
//								$("#itemDetailsPrintPaidOrder80").append(
//										createdrowline);
//
//							}
//
//							/* ********** END ITEM DETAILS PRINT ********** */
//
//							/* ********** START AMOUNT INFO PRINT ********** */
//							// alert(" << subToatlAmt >> "+subToatlAmt+ " <<
//							// serviceChargeAmt >>"+serviceChargeAmt+"<<
//							// serviceTaxAmt >>"+serviceTaxAmt+" << vatAmt
//							// >>"+vatAmt+"<< customerDiscount
//							// >>"+customerDiscount+"<< billAmt >> "+billAmt+"<<
//							// grossAmt >> "+grossAmt);
//							$('#cashtotalamtPaidOrder80').text(subToatlAmt);
//
//							if (serviceChargeAmt > 0) {
//								$("#cashtotalServiceCharge80px").show();
//								$('#cashservChrgPaidOrder80').text(
//										serviceChargeAmt);
//							} else {
//								$("#cashtotalServiceCharge80px").hide();
//							}
//
//							if (serviceTaxAmt > 0.00) {
//								$("#cashtotalServiceTax80px").show();
//								$('#cashservTaxPaidOrder80')
//										.text(serviceTaxAmt);
//							} else {
//								$("#cashtotalServiceTax80px").hide();
//							}
//
//							if (vatAmt > 0) {
//								$("#cashtotalVatTax80px").show();
//								$("#cashvatTaxPaidOrder80").text(vatAmt);
//							} else {
//								$("#cashtotalVatTax80px").hide();
//							}
//
//							if (customerDiscount > 0) {
//								$("#cashshowDiscount80px").show();
//								$("#cashdiscountValuePaidOrder80").text(
//										customerDiscount);
//							} else {
//								$("#cashshowDiscount80px").hide();
//							}
//
//							$("#cashgrossAmountPaidOrder80").text(billAmt);
//							$("#cashamoutToPayPaidOrder80").text(grossAmt);
//
//							var paidOrderPayObj = jsonObj.payments.length;
//							if (paidOrderPayObj == 1) {
//
//								var paidAmt = jsonObj.payments[0].paidAmount;
//								var tenderAmt = jsonObj.payments[0].tenderAmount;
//								var returnAmt = tenderAmt - paidAmt;
//								var type = jsonObj.payments[0].paymentMode;
//
//								$('#paidAmountPaidOrder80').text(paidAmt);
//								$('#tenderAmountPaidOrder80').text(tenderAmt);
//								$('#refundAmountPaidOrder80').text(returnAmt);
//								$('#payOrderTypePaidOrder80').text(type);
//
//							}
//							if (paidOrderPayObj == 2) {
//
//								var paidAmt = jsonObj.payments[0].paidAmount
//										+ jsonObj.payments[1].paidAmount;
//								var tenderAmt = jsonObj.payments[0].tenderAmount
//										+ jsonObj.payments[1].tenderAmount;
//								var returnAmt = tenderAmt - paidAmt;
//								var type1 = jsonObj.payments[0].paymentMode;
//								var type2 = jsonObj.payments[1].paymentMode;
//
//								$('#paidAmountPaidOrder80').text(paidAmt);
//								$('#tenderAmountPaidOrder80').text(tenderAmt);
//								$('#refundAmountPaidOrder80').text("0.00");
//								$('#payOrderTypePaidOrder80').text(
//										type1 + " + " + type2);
//							}
//
//							paidOrder80(); // Print For 80
//						} else if (printbillpapersize == '2100.00') {
//
//							 console.log("printbillpapersize 2 >>"+printbillpapersize);
//
//							$('#storeName2100').text(customerName);
//							$('#storeAddr2100').text(storeAddr);
//							$('#storeEmail2100')
//									.text("Email :" + customerEmail);
//							$('#storePhNo2100').text("Ph :" + customerPhNo);
//							$('#cashOrdervalue2100').text(orderNo);
//							$('#cashtableNoValue2100').text(tabNo);
//
//							/* ********** END STORE INFO PRINT ********** */
//
//							/* ********** START ITEM DETAILS PRINT ********** */
//
//							for (var k = 0; k < jsonObj.orderitem.length; k++) {
//								var item1 = jsonObj.orderitem[k];
//
//								var itemName = item1.item.name;
//								var itemQty = item1.quantityOfItem;
//								var itemRate = item1.rate;
//								var itemTotalPrice = item1.totalPriceByItem;
//
//								// alert(" << NAME ????? "+item1.item.name + "
//								// << QTY ?? "+itemQty+" << itemRate ???
//								// "+itemRate+" << itemTotalPrice ???
//								// "+itemTotalPrice);
//
//								var createdrowline = "";
//								var startTrline = "<tr style='padding: 2px;'>";
//								var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 14px;font-family: sans-serif;'>"
//										+ itemName + "</td>";
//								var secondTdline = "<td style='float:right;font-size: 14px;font-family: sans-serif;padding-right:170px;text-align:center'>"
//										+ itemQty + "</td>";
//								var thirdTdline = "<td style='font-size: 14px;font-family: sans-serif;padding-right:110px;text-align:center'>"
//										+ itemRate + "</td>";
//								var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: center; font-size: 14px'>"
//										+ itemTotalPrice + "</td>";
//								var endTrline = "</tr>";
//
//								createdrowline = startTrline + firstTdline
//										+ secondTdline + thirdTdline
//										+ fourthTdline + endTrline;
//
//								$("#itemDetailsPrint2100").append(
//										createdrowline);
//
//							}
//
//							/* ********** END ITEM DETAILS PRINT ********** */
//
//							/* ********** START AMOUNT INFO PRINT ********** */
//
//							$('#cashtotalamt2100').text(subToatlAmt);
//
//							if (serviceChargeAmt > 0) {
//								$("#cashtotalServiceCharge2100px").show();
//								$('#cashservChrg2100').text(serviceChargeAmt);
//							} else {
//								$("#cashtotalServiceCharge2100px").hide();
//							}
//
//							if (serviceTaxAmt > 0.00) {
//								$("#cashtotalServiceTax2100px").show();
//								$('#cashservTax2100').text(serviceTaxAmt);
//							} else {
//								$("#cashtotalServiceTax2100px").hide();
//							}
//
//							if (vatAmt > 0) {
//								$("#cashtotalVatTax2100px").show();
//								$("#cashvatTax2100px").text(vatAmt);
//							} else {
//								$("#cashtotalVatTax2100px").hide();
//							}
//
//							if (customerDiscount > 0) {
//								$("#cashshowDiscount2100px").show();
//								$("#cashdiscountValue2100").text(
//										customerDiscount);
//							} else {
//								$("#cashshowDiscount2100px").hide();
//							}
//
//							$("#cashgrossAmount2100").text(billAmt);
//							$("#cashamoutToPay2100").text(grossAmt);
//
//							var paymentsObj = jsonObj.payments.length;
//							if (paymentsObj == 1) {
//
//								var paidAmt = jsonObj.payments[0].paidAmount;
//								var tenderAmt = jsonObj.payments[0].tenderAmount;
//								var returnAmt = tenderAmt - paidAmt;
//								var type = jsonObj.payments[0].paymentMode;
//
//								$('#paidAmount2100').text(paidAmt);
//								$('#tenderAmount2100').text(tenderAmt);
//								$('#refundAmount2100').text(
//										Math.floor(returnAmt * 100) / 100);
//								$('#payType2100').text(type);
//
//							}
//							if (paymentsObj == 2) {
//
//								var paidAmt = jsonObj.payments[0].paidAmount
//										+ jsonObj.payments[1].paidAmount;
//								var tenderAmt = jsonObj.payments[0].tenderAmount
//										+ jsonObj.payments[1].tenderAmount;
//								var returnAmt = tenderAmt - paidAmt;
//								var type1 = jsonObj.payments[0].paymentMode;
//								var type2 = jsonObj.payments[1].paymentMode;
//
//								$('#paidAmount2100').text(paidAmt);
//								$('#tenderAmount2100').text(tenderAmt);
//								$('#refundAmount2100').text("0.00");
//								$('#payType2100').text(type1 + " + " + type2);
//							}
//
//							/* ********** END AMOUNT INFO PRINT ********** */
//
//							if (paymentsObj == 1) {
//								var amt1 = jsonObj.payments[0].amount;
//								var paidAmt1 = jsonObj.payments[0].paidAmount;
//								if (amt1 == paidAmt1) {
//									printCashOrCardLocal2100();
//								}
//							}
//
//							if (paymentsObj == 2) {
//
//								var amt2 = jsonObj.payments[0].amount;
//								var paidAmt2 = jsonObj.payments[0].paidAmount
//										+ jsonObj.payments[1].paidAmount;
//
//								if (amt2 == paidAmt2) {
//									printCashOrCardLocal2100();
//								}
//							}
//
//						}
//
//					}
//				});
//
//	} else {
//		var ajaxCallObject = new CustomBrowserXMLObject();
//		ajaxCallObject.callAjax(BASE_URL + "/order/printbill/" + orderid
//				+ ".htm", function(response) {
//			try {
//				if (response == 'Success')
//					showPaidBillPrintSuccessModal();
//
//			} catch (e) {
//				alert(e);
//			}
//		}, null);
//	}
//
//}
//
//function number2text(value) {
//    var fraction = Math.round(frac(value)*100);
//    var f_text  = "";
//
//    if(fraction > 0) {
//        f_text = "AND "+convert_number(fraction)+" PAISE";
//    }
//
//    return convert_number(value)+" RUPEE "+f_text+" ONLY";
//}
//
//function frac(f) {
//    return f % 1;
//}
//
//function convert_number(number)
//{
//    if ((number < 0) || (number > 999999999)) 
//    { 
//        return "NUMBER OUT OF RANGE!";
//    }
//    var Gn = Math.floor(number / 10000000);  /* Crore */ 
//    number -= Gn * 10000000; 
//    var kn = Math.floor(number / 100000);     /* lakhs */ 
//    number -= kn * 100000; 
//    var Hn = Math.floor(number / 1000);      /* thousand */ 
//    number -= Hn * 1000; 
//    var Dn = Math.floor(number / 100);       /* Tens (deca) */ 
//    number = number % 100;               /* Ones */ 
//    var tn= Math.floor(number / 10); 
//    var one=Math.floor(number % 10); 
//    var res = ""; 
//
//    if (Gn>0) 
//    { 
//        res += (convert_number(Gn) + " CRORE"); 
//    } 
//    if (kn>0) 
//    { 
//            res += (((res=="") ? "" : " ") + 
//            convert_number(kn) + " LAKH"); 
//    } 
//    if (Hn>0) 
//    { 
//        res += (((res=="") ? "" : " ") +
//            convert_number(Hn) + " THOUSAND"); 
//    } 
//
//    if (Dn) 
//    { 
//        res += (((res=="") ? "" : " ") + 
//            convert_number(Dn) + " HUNDRED"); 
//    } 
//
//
//    var ones = Array("", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX","SEVEN", "EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE", "THIRTEEN","FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN","NINETEEN"); 
//var tens = Array("", "", "TWENTY", "THIRTY", "FOURTY", "FIFTY", "SIXTY","SEVENTY", "EIGHTY", "NINETY"); 
//
//    if (tn>0 || one>0) 
//    { 
//        if (!(res=="")) 
//        { 
//            res += " AND "; 
//        } 
//        if (tn < 2) 
//        { 
//            res += ones[tn * 10 + one]; 
//        } 
//        else 
//        { 
//
//            res += tens[tn];
//            if (one>0) 
//            { 
//                res += (ones[one]); 
//            } 
//        } 
//    }
//
//    if (res=="")
//    { 
//        res = "zero"; 
//    } 
//    return res;
//}


function printKotCheckList() {
	//alert("printKotCheckList");
	var orderid = document.getElementById('orderNo').value;
	var printbillpapersize = $("#printbillpapersize").val();
	var kotPrintValue = $("#kotPrintVal").val();
	// var tableno=document.getElementById('tablenoCont').innerHTML;
	if (orderid == 0 || forspNoteData.length > 0) {
		// alert('Please save the order first!');
		showalertsaveorderModal();
	} else {
		if(kotPrintValue == "Y")
		{
			
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/searchorderbyid/" + orderid
					+ ".htm", function(res) {
				console.log(res);
				var resoderdet = JSON.parse(res);
				var orderNo = resoderdet.id;
				var ordertype=resoderdet.ordertype.orderTypeName;
				var tableno=resoderdet.table_no;
				var orderitem = [];
				var orderitems = resoderdet.orderitem;
				var spclnote=null;
				if (printbillpapersize == '58.00') {

					for (var j = 0; j < orderitems.length; j++) {
						orderitem = orderitems[j];
						var name = orderitem.item.name;
						var quantity = orderitem.quantityOfItem;
						spclnote=orderitem.specialNote;
						/*
						 * var total = $("#row_" +itemUnique[j]
						 * ).find('td:eq(3)').text(); var rate = $("#row_"
						 * +itemUnique[j] ).find('td:eq(4)').text();
						 */
						if (quantity != undefined) {
							var rowline = "";
							var starttrline = "<tr>";
							var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 13px; word-wrap: break-word;'>"
									+ name + "</td>";
							var secondtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 13px;'>"
									+ quantity + "</td>";
							var endtrline = "</tr>";
							rowline = starttrline + firsttdline + secondtdline 
									+ endtrline;
							// alert(rowline);
							var splnoterowline = "";
							// alert(forspNoteData.length);
									if ( spclnote != null) {
										splnoterowline = "";
										var splnotestarttrline = "<tr>";
										var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 12px; word-wrap: break-word;'>#"
												+ spclnote + "</td>";
										var splnoteendtrline = "</tr>";
										splnoterowline = splnotestarttrline
												+ firsttdline + splnoteendtrline;
									}
							
							$("#kotitems58").append(rowline + splnoterowline);
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

					// alert(todayDate);
					document.getElementById('dateTimeValue58').innerHTML = todayDate
							+ " " + strTime;
					document.getElementById('ordValue58').innerHTML = orderNo;
					if (tableno == 0) {
						$("#kottable58").hide();
						$("#kothdorpercel58").show();
						$("#hdorpercelValue58").text(ordertype);
						
					} else {
						$("#kothdorpercel58").hide();
						document.getElementById('tblValue58').innerHTML = tableno;
					}

					
					kotPrint58();

				} else {
					for (var j = 0; j < orderitems.length; j++) {
						orderitem = orderitems[j];
						var name = orderitem.item.name;
						var quantity = orderitem.quantityOfItem;
						spclnote=orderitem.specialNote;
						/*
						 * var total = $("#row_" +itemUnique[j]
						 * ).find('td:eq(3)').text(); var rate = $("#row_"
						 * +itemUnique[j] ).find('td:eq(4)').text();
						 */
						if (quantity != undefined) {
							var rowline = "";
							var starttrline = "<tr>";
							var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 13px; word-wrap: break-word;'>"
									+ name + "</td>";
							var secondtdline = "<td valign='middle' align='center' style='padding: 3px; font-size: 13px;'>"
									+ quantity + "</td>";
							// var thirdtdline = "<td valign='middle' align='center'
							// style='padding: 3px; font-size: 11px;'>"+total+"</td>";
							// var fourthtdline = "<td valign='middle' align='center'
							// style='padding: 3px; font-size: 11px;'>"+rate+"</td>";
							var endtrline = "</tr>";
							rowline = starttrline + firsttdline + secondtdline /*
																				 * +
																				 * thirdtdline +
																				 * fourthtdline
																				 */
									+ endtrline;
							// alert(rowline);
							var splnoterowline = "";
							// alert(forspNoteData.length);
							if ( spclnote != null) {
								splnoterowline = "";
								var splnotestarttrline = "<tr>";
								var firsttdline = "<td style='padding: 1px; width: 300px !important;  font-size: 12px; word-wrap: break-word;'>#"
										+ spclnote + "</td>";
								var splnoteendtrline = "</tr>";
								splnoterowline = splnotestarttrline
										+ firsttdline + splnoteendtrline;
							}
							$("#kotitems").append(rowline + splnoterowline);
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

					// alert(todayDate);
					document.getElementById('dateTimeValue').innerHTML = todayDate
							+ " " + strTime;
					document.getElementById('ordValue').innerHTML = orderNo;
					if (tableno == 0) {
						$("#kottable").hide();
						$("#kothdorpercel").show();
						$("#hdorpercelValue").text(ordertype);
						
					} else {
						$("#kothdorpercel").hide();
						document.getElementById('tblValue').innerHTML = tableno;
					}

					kotPrint();
					// printKotForPos();
				}
				
				
			}, null);
			
			
		}
		else{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/printkotchecklist/"
				+ orderid + ".htm", function(response) {
			try {
				if (response == 'Success')
					showKotCheckListPrintSuccessModal();
			} catch (e) {
				alert(e);
			}
		}, null);
		}
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
    //alert("Print 80");
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
		for (var i = 0; i < option.length; i++) {
			if (option[i].checked == true) {
				selOption = option[i].value;
			}
		}
		// document.getElementById('hidinstantPaymentType').value=selOption;
		// document.getElementById('hidinstantPaymentFlag').value="Y";
		location.href = BASE_URL + '/order/vieworders.htm?ono=' + order_no
				+ '&tno=' + table_no + '&sno=0' + '&itcno=' + itcatId
				+ '&flg=Y&ptype=' + SelectedOption;
	} else if (table_no == '0') {
		// if (orderType == 'h') {
		// location.href = BASE_URL + '/order/vieworderHD.htm?ono=' + order_no +
		// '&tno=' + table_no + '&sno=' + 0 + '&ot=h';
		// } else if (orderType == 's') {
		// location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' + order_no
		// + '&tno=' + table_no + '&sno=' + 0 + '&ot=s';
		// } else if (orderType == 'z') {
		// location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' + order_no
		// + '&tno=' + table_no + '&sno=' + 0 + '&ot=z';
		// } else {
		// location.href = BASE_URL + '/order/vieworder.htm?ono=' + order_no +
		// '&tno=' + table_no + '&sno=0';
		location.href = BASE_URL + '/order/vieworderwithordertype.htm?ono='
				+ order_no + '&tno=' + table_no + '&sno=0' + '&otypeno='
				+ SelectedOption;
		// }

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
		for (var i = 0; i < option.length; i++) {
			if (option[i].checked == true) {
				selOption = option[i].value;
			}
		}
		// document.getElementById('hidinstantPaymentType').value=selOption;
		// document.getElementById('hidinstantPaymentFlag').value="Y";
		location.href = BASE_URL + '/order/vieworders.htm?ono=' + order_no
				+ '&tno=' + table_no + '&sno=0' + '&itcno=' + itcatId
				+ '&flg=Y&ptype=' + SelectedOption;
	} else if (table_no == '0') {
		// if (orderType == 'h') {
		// location.href = BASE_URL + '/order/vieworderHD.htm?ono=' + order_no +
		// '&tno=' + table_no + '&sno=' + 0 + '&ot=h';
		// } else if (orderType == 's') {
		// location.href = BASE_URL + '/order/vieworderSWIG.htm?ono=' + order_no
		// + '&tno=' + table_no + '&sno=' + 0 + '&ot=s';
		// } else if (orderType == 'z') {
		// location.href = BASE_URL + '/order/vieworderZOM.htm?ono=' + order_no
		// + '&tno=' + table_no + '&sno=' + 0 + '&ot=z';
		// } else {
		// location.href = BASE_URL + '/order/vieworder.htm?ono=' + order_no +
		// '&tno=' + table_no + '&sno=0';
		location.href = BASE_URL + '/order/vieworderwithordertype.htm?ono='
				+ order_no + '&tno=' + table_no + '&sno=0' + '&otypeno='
				+ SelectedOption;
		// }

	} else {
		location.href = BASE_URL + '/table/viewtable.htm';
	}

}
function parcelPayment() {
	var option = document.getElementsByName("parcelpayOption");
	var payOption = null;
	for (var i = 0; i < option.length; i++) {
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
var storedoubleroundoffflag = document
		.getElementById('hidstoredoubleroundoffFlag').value;
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
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/getpaymentinfo/" + orderno + ".htm",
						function(response) {
							try {
								var responseObj = [];
								responseObj = JSON.parse(response);
								for (var i = 0; i < responseObj.length; i++) {
									temppaidAmt += responseObj[i].paidAmount;
								}
								paidAmnt = temppaidAmt;
								if (hidstoreroundoffflag == 'Y') {
									netTotal = Math.round(netTotal);
								}
								if (storedoubleroundoffflag == 'Y') {
									netTotal = round(netTotal, 1);
								}
								amntToPay = parseFloat(netTotal)
										- parseFloat(temppaidAmt);
								document.getElementById('cashmodOrderCont').innerHTML = orderno;
								document.getElementById('cashmodStoreBasedOrderCont').innerHTML = storeBasedOrderNumber;
								document.getElementById('cashmodTabCont').innerHTML = tableno;
								document.getElementById('cashtotamtcontId').innerHTML = parseFloat(
										pmntTotAmt).toFixed(2);
								document.getElementById('cashpaidamtcontId').innerHTML = parseFloat(
										temppaidAmt).toFixed(2);
								if (temppaidAmt > 0) {
									$('#cashpaidamtdivId').removeClass('hide');
								}
								document.getElementById('cashamttopaycontId').innerHTML = parseFloat(
										amntToPay).toFixed(2);
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
			document.getElementById('cashchangeamtcontId').innerHTML = parseFloat(
					parseFloat(tenderAmt) - parseFloat(amntToPay)).toFixed(2);
			// for vfd
			if (vfdPort.length > 3) {
				var changeAmt = tenderAmt - netTotal;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfdpay/"
						+ "TOT IN RM : " + parseFloat(amntToPay).toFixed(2)
						+ "/" + "BAL IN RM : "
						+ parseFloat(changeAmt).toFixed(2) + ".htm",
						function() {
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
	//document.getElementById('cardlastfourDigit').value = '';
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
	var temppaidAmt = 0.0;
	if (orderno == 0 || forspNoteData.length > 0) {
		// alert('Please save the order first!');
		showalertsaveorderModal();
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/getpaymentinfo/" + orderno + ".htm",
						function(response) {
							try {
								var responseObj = [];
								responseObj = JSON.parse(response);
								for (var i = 0; i < responseObj.length; i++) {
									temppaidAmt += responseObj[i].paidAmount;
								}
								paidAmnt = temppaidAmt;
								if (hidstoreroundoffflag == 'Y') {
									netTotal = Math.round(netTotal);
								}
								if (storedoubleroundoffflag == 'Y') {
									netTotal = round(netTotal, 1);
								}
								amntToPay = parseFloat(netTotal)
										- parseFloat(temppaidAmt);
								amntToPay=parseFloat(amntToPay).toFixed(2);
								document.getElementById('cardmodOrderCont').innerHTML = orderno;
								document.getElementById('cardmodStoreBasedOrderCont').innerHTML = storeBasedOrderNumber;
								document.getElementById('cardmodTabCont').innerHTML = tableno;
								document.getElementById('cardtotamtcontId').innerHTML = parseFloat(
										pmntTotAmt).toFixed(2);
								document.getElementById('cardpaidamtcontId').innerHTML = parseFloat(
										temppaidAmt).toFixed(2);
								if (temppaidAmt > 0) {
									$('#cardpaidamtdivId').removeClass('hide');
								}
								document.getElementById('cardamttopaycontId').innerHTML = parseFloat(
										amntToPay).toFixed(2);
								document.getElementById('cardtenderAmt').value = parseFloat(
										amntToPay).toFixed(2);
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
	//alert("cash");
	var payableamount  = document.getElementById('cashamttopaycontId').innerHTML;
	//alert(payableamount);
	var caseValue = $("#mobPrintVal").val();
	netTotal = document.getElementById('hidnetTotal').value;
	var orderno = document.getElementById('orderNo').value;

	var vattax= $("#hidtotvattax").val();
	var stax= $("#hidtotstax").val();
	var scharge= $("#hidtotscharge").val();
	var discountpercentage = document.getElementById('hidendiscountpercentage').value;
	var itemtotal=document.getElementById('subtotalcontId').innerHTML;
	var grossamount = (100 * Number(itemtotal))/(100-Number(discountpercentage));

	var disAmt=parseFloat(grossamount)-parseFloat(itemtotal);
	var total_tax_amt=parseFloat(vattax)+parseFloat(stax);
	//alert(grossamount+""+total_tax_amt+""+scharge+""+disAmt+""+netTotal);
   
	
	if(itemtotal<=0){
		disAmt = grossamount = Number(document.getElementById('discBtnContId').innerHTML);
	}
		
	if (isNaN(tenderAmt) || tenderAmt == '') {
		document.getElementById('paycashalertMsg').innerHTML = getBaseLang.plsEntrVdNo;
		document.getElementById('cashtenderAmt').focus();
	} else {
		dsblPayByCashButton();
		
		if (parseFloat(tenderAmt) >= parseFloat(amntToPay)) {
			paidAmnt = parseFloat(amntToPay);
			amntToPay = 0.0;
		} else {
			paidAmnt = parseFloat(tenderAmt);
			amntToPay = (parseFloat(amntToPay) - parseFloat(tenderAmt))
					.toFixed(2);
		}
		if (storedoubleroundoffflag == 'Y') {
			netTotal = round(netTotal, 1);
		}
      
		
		var payment1={};
		var order={};
        var orderBill={};

		order.id=orderno;
        orderBill.grossAmt=grossamount.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
		order.orderBill=orderBill;
      //alert(netTotal+ "------" +payableamount );
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
		payment1.orderPayment=order;
		payment1.paymentMode="cash";
		payment1.cardLastFourDigits="0000";
		payment1.source="web";
		payment1.remarks="nil";
		payment1.tipsAmount="0.00";     
		if(is_Acc=="Y")
		{
		    var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
			var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
			var round_ledger_id = parseInt($('#round_ledger_idf').val());
			var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
			var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
		    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
		    var card_ledger_id=parseInt($('#card_ledger_idf').val());


		  if(sale_ledger_id<=0 || duties_ledger_id<= 0 || round_ledger_id<=0 || discount_ledger_id<=0 || debitor_cash_ledger_id<=0 || service_charge_ledger_id<=0 || card_ledger_id<=0) {
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
				  payment1.discAmt=disAmt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.taxVatAmt=total_tax_amt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.serviceChargeAmt=scharge.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;


			}
		}
		
		/*$.ajax({
			//url : BASE_URL + "/order/orderpayment/" + orderno + "/"+ netTotal + "/" + paidAmnt + "/" + amntToPay + "/" + tenderAmt + "/" + "cash" + "/" + "000" + "/" + "nil" + "/" + "0.00" + ".htm",
			url : BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(payment1),
			async : false,	
			beforeSend: function() {
				dsblPayByCashButton();
				console.log("disable");
			},
			success :*/ 
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjaxPost(BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
						 payment1,
			   function(response) {
				try {
					if (response == 'success') {
						console.log("enable");
						enblPayByCashButton();
						
						if(smsintegration == 'Y'){

							var subtot=document.getElementById('subtotalcontId').innerHTML;
							//alert("::sms:::"+orderno+"ammt:::"+subtot);
							var ajaxCallObject = new CustomBrowserXMLObject();
							ajaxCallObject.callAjax(BASE_URL+ "/smsintegration/sendsms/"+ orderno+"/subtot/"+subtot + ".htm", function(response) {
									  //alert("response:"+response);
									}, null);

						}

						if (printpaidBill == 'N') {

							 if
							 (document.getElementById('chkprintBillCash').checked
							 == true) {
							 //alert('print cash');
							// printPaidBill(orderno);
							if (caseValue == 'Y') {
								//cashOrcardPrintBill();								
								printPaidBill(orderno);								
							} else {
								var ajaxCallObject = new CustomBrowserXMLObject();
								ajaxCallObject.callAjax(BASE_URL
										+ "/order/printbill/"
										+ orderno + ".htm",
										function(response) {
										}, null);
							}

							// alert(orderno);
							// }

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


						if (amntToPay > 0) {
							document
									.getElementById('amttopaycontId').innerHTML = parseFloat(
									amntToPay).toFixed(2);
							hideCashModal();
						} else {
							if (document
									.getElementById('cashmodTabCont').innerHTML == '0'
									&& itcatId != '') {
								location.href = BASE_URL
										+ '/order/vieworders.htm?ono=0&tno=0&sno=0'
										+ '&itcno=' + itcatId
										+ '&flg=N&ptype=';
							} else {
								if (cdrawerCode.length > 0) {
									hideCashModal();
									var toPay = document
											.getElementById('cashamttopaycontId').innerHTML;
									var changeAmt = parseFloat(
											parseFloat(tenderAmt)
													- parseFloat(toPay))
											.toFixed(2);
									// document.getElementById('cashchangeamtmodcontId').innerHTML=document.getElementById('cashchangeamtcontId').innerHTML;
									document
											.getElementById('cashamttopaymodcontId').innerHTML = parseFloat(
											toPay).toFixed(2);
									document
											.getElementById('cashtenderAmtmodcontId').innerHTML = parseFloat(
											tenderAmt).toFixed(2);
									document
											.getElementById('cashchangeamtmodcontId').innerHTML = parseFloat(
											changeAmt).toFixed(2);
									showCashChangeAmtModal();
								} else {
									if(storeID == 156){
										if (document.getElementById('cashmodTabCont').innerHTML == '0') {
											
											var selectedoption = document.getElementById('orderType').value;
											location.href = BASE_URL + '/order/vieworderwithordertype.htm?ono='
											+ 0 + '&tno=' + 0 + '&sno=' + 0
											+ '&otypeno=' + selectedoption;
										}
										else{
											location.href = BASE_URL+ '/table/viewtable.htm';
											
										}
									}
									else{
									location.href = BASE_URL
											+ '/table/viewtable.htm';
									}
								}
							}
						}
					}
					if(response == 'alreadypaid'){
						enblPayByCashButton();
						$('#cashModal').modal('hide');
						document.getElementById('alreadypaidmsg').innerHTML = getBaseLang.paid;
						$('#alertalreadypaidModal').modal('show');

					}
			} catch (e) {
					alert(e);
				}
			/*},
			error : function(e) {
			}
			
		})*/
		
		}, null);
		
	}
	
	/*
	 * var tenderAmountField = $('#cashtenderAmt').val();
	 *
	 * if(tenderAmountField >= 0){
	 *
	 * cashOrcardPrintBill(); location.href = BASE_URL + '/table/viewtable.htm';
	 *  }
	 */
}


function payByCard(tenderAmt) {
	var payableamount  = document.getElementById('cardamttopaycontId').innerHTML;
	var caseValue = $("#mobPrintVal").val();
	netTotal = document.getElementById('hidnetTotal').value;
	var orderno = document.getElementById('orderNo').value;
    var vattax= $("#hidtotvattax").val();
	var stax= $("#hidtotstax").val();
	var scharge= $("#hidtotscharge").val();
	var discountpercentage = document.getElementById('hidendiscountpercentage').value;
	var itemtotal=document.getElementById('subtotalcontId').innerHTML;
	var grossamount = (100 * Number(itemtotal))/(100-Number(discountpercentage));

	var disAmt=parseFloat(grossamount)-parseFloat(itemtotal);
	var total_tax_amt=parseFloat(vattax)+parseFloat(stax);
	//alert(grossamount+""+total_tax_amt+""+scharge+""+disAmt+""+netTotal);
    //var lastfourdigit = document.getElementById('cardlastfourDigit').value;
	if(itemtotal<=0){
		disAmt = grossamount = Number(document.getElementById('discBtnContId').innerHTML);
	}
	
	
	
	
	var lastfourdigit='xxxx';
	var tipsamount = '0.00';
	if(storeID == 157 || storeID == 161 || storeID == 128 || storeID == 29){
		lastfourdigit = document.getElementById('cardlastfourDigit').value;
		

	}
	if(storeID == 157){
		tipsamount = document.getElementById('tipsamt').value;
		

	}
	/*if(lastfourdigit == ''){
	 lastfourdigit = 'xxxx';
	}*/



	var cardType = document.getElementById('cardTypeName').value;

	if (isNaN(tenderAmt) || tenderAmt == '') {
		document.getElementById('paycardalertMsg').innerHTML = getBaseLang.plsEntrVdNo;
		document.getElementById('cardtenderAmt').focus();
	} else if (cardType == '') {
		document.getElementById('paycardalertMsg').innerHTML = getBaseLang.plsEntrCardType;
	}else if (storeID == 161 && (isNaN(lastfourdigit) || lastfourdigit.length != 4)) {
		document.getElementById('paycardalertMsg').innerHTML = getBaseLang.plsEntr4DgtNo;
		
	}
	
	
	/*else if (!parseFloat(lastfourdigit)) {
		document.getElementById('paycardalertMsg').innerHTML = getBaseLang.plsEntrVldCardNo;
		//document.getElementById('cardlastfourDigit').focus();
	} *//*else if (isNaN(lastfourdigit) || lastfourdigit.length != 4) {
		// alert('Please enter 4 digit valid card number!');
		document.getElementById('paycardalertMsg').innerHTML = getBaseLang.plsEntr4DgtNo;
		//document.getElementById('cardlastfourDigit').focus();
	}*/

	else {
		dsblPayByCardButton();		
		if (lastfourdigit == '') {
			lastfourdigit = 'xxxx';
		}
		if (tipsamount == '') {
			tipsamount = '0.00';
		}
		amntToPay=parseFloat(amntToPay);
		if (amntToPay<=tenderAmt) {
			//alert('if' + parseFloat(tenderAmt).toFixed(2) + parseFloat(amntToPay).toFixed(2));
			paidAmnt = parseFloat(amntToPay).toFixed(2);
			amntToPay = 0.0;
		}  else {
			paidAmnt = parseFloat(tenderAmt).toFixed(2);
			amntToPay = parseFloat(amntToPay).toFixed(2)
					- parseFloat(tenderAmt).toFixed(2);
		}
		if (storedoubleroundoffflag == 'Y') {
			netTotal = round(netTotal, 1);
		}
		var payment1={};
		var order={};

		var orderBill={};

		order.id=orderno;

		orderBill.grossAmt=grossamount.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
		order.orderBill=orderBill;

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
		payment1.paymentMode=cardType;
		payment1.cardLastFourDigits=lastfourdigit;
		payment1.source="web";
		payment1.remarks="nil";
		payment1.tipsAmount=tipsamount;

		if(is_Acc=="Y")
		{

		    var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
			var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
			var round_ledger_id = parseInt($('#round_ledger_idf').val());
			var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
			var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
		    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
		    var card_ledger_id=parseInt($('#card_ledger_idf').val());


		  if(sale_ledger_id<=0 || duties_ledger_id<= 0 || round_ledger_id<=0 || discount_ledger_id<=0 || debitor_cash_ledger_id<=0 || service_charge_ledger_id<=0 || card_ledger_id<=0) {
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
				  payment1.discAmt=disAmt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.taxVatAmt=total_tax_amt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.serviceChargeAmt=scharge.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;


			}
		}

		var ajaxCallObject = new CustomBrowserXMLObject();
		/*ajaxCallObject.callAjax(
						BASE_URL + "/order/orderpayment/" + orderno + "/"
								+ netTotal + "/" + paidAmnt + "/" + amntToPay
								+ "/" + tenderAmt + "/" + cardType + "/"
								+ lastfourdigit + "/" + "nil" +"/" + tipsamount + ".htm",*/
		 ajaxCallObject.callAjaxPost(BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
				 payment1,
						function(response) {
							try {
								if(storeID == 157 || storeID == 161 ){
									 document.getElementById('cardlastfourDigit').value ='';
									 
								}
								if(storeID == 157){
									document.getElementById('tipsamt').value ='';
									 
								}
								if (response == 'success') {
									    enblPayByCardButton();
                                         if(smsintegration == 'Y'){
										     var subtot=document.getElementById('subtotalcontId').innerHTML;
										      //alert("::sms:::"+orderno+"ammt:::"+subtot);
										         var ajaxCallObject = new CustomBrowserXMLObject();
										         ajaxCallObject.callAjax(BASE_URL+ "/smsintegration/sendsms/"+ orderno+"/subtot/"+subtot + ".htm", function(response) {
												  //alert("response:"+response);
												}, null);

									}

									if (printpaidBill == 'N') {
										 if
										 (document.getElementById('chkprintBillCard').checked
										 == true) {
										// alert('print card');
										// printPaidBill(orderno);
										if (caseValue == 'Y') {
											//cashOrcardPrintBill();
											printPaidBill(orderno);
										} else {
											var ajaxCallObject = new CustomBrowserXMLObject();
											ajaxCallObject.callAjax(BASE_URL
													+ "/order/printbill/"
													+ orderno + ".htm",
													function(response) {
													}, null);
										}
										// alert(orderno);
										// }

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
									if (amntToPay > 0) {
										document
												.getElementById('amttopaycontId').innerHTML = parseFloat(
												amntToPay).toFixed(2);
										hideCardModal();
									} else {
										hideCardModal();
										if (document
												.getElementById('cardmodTabCont').innerHTML == '0'
												&& itcatId != '') {
											location.href = BASE_URL
													+ '/order/vieworders.htm?ono=0&tno=0&sno=0'
													+ '&itcno=' + itcatId
													+ '&flg=N&ptype=';
										} else {
											if(storeID == 156){
												
												if (document.getElementById('cardmodTabCont').innerHTML == '0') {
													
													var selectedoption = document.getElementById('orderType').value;
													location.href = BASE_URL + '/order/vieworderwithordertype.htm?ono='
													+ 0 + '&tno=' + 0 + '&sno=' + 0
													+ '&otypeno=' + selectedoption;
												}
												else{
													location.href = BASE_URL+ '/table/viewtable.htm';
													
												}
											}
											else{
											location.href = BASE_URL
													+ '/table/viewtable.htm';
											}
										}
									}
								}
								if(response == 'alreadypaid'){
									enblPayByCardButton();
									$('#cardModal').modal('hide');
									document.getElementById('alreadypaidmsg').innerHTML = getBaseLang.paid;
									$('#alertalreadypaidModal').modal('show');

								}
							} catch (e) {
								alert(e);
							}
						}, null);
	}

	/*
	 * if (isNaN(lastfourdigit) || lastfourdigit.length == 4){
	 *
	 * cashOrcardPrintBill();
	 *
	 * location.href = BASE_URL + '/table/viewtable.htm';
	 *  }
	 */
}
function openOnlineModal() {
	getvendorledger_sale($('#card_codef').val(),0,0,6);// for card
	netTotal = document.getElementById('hidnetTotal').value;
	document.getElementById('paycardalertMsg').innerHTML = '';
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
	var temppaidAmt = 0.0;
	if (orderno == 0 || forspNoteData.length > 0) {
		showalertsaveorderModal();
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/getpaymenttypebystore.htm",
						function(response) {
							var parseresponse = JSON.parse(response);
							try {
								// console.log("getpaymenttypebystore="+response);
								if ('null' == response) {
									$("#notavailableonlinepaymentModal").modal(
											"show");
								} else if(0 == parseresponse.size){
									$("#notavailableonlinepaymentModal").modal(
									"show");
								}
								else{
									var responseObjpaymenttype = JSON
											.parse(response);
									console.log("responseObjpaymenttype="
											+ response);
									console
											.log(responseObjpaymenttype.paymentTypes[0].paymentTypeName);
									if (responseObjpaymenttype.size == 1) {
										ajaxCallObject
												.callAjax(
														BASE_URL
																+ "/order/getpaymentinfo/"
																+ orderno
																+ ".htm",
														function(response) {
															try {
																var responseObj = [];
																responseObj = JSON
																		.parse(response);
																for (var i = 0; i < responseObj.length; i++) {
																	temppaidAmt += responseObj[i].paidAmount;
																}
																paidAmnt = temppaidAmt;
																if (hidstoreroundoffflag == 'Y') {
																	netTotal = Math
																			.round(netTotal);
																}
																if (storedoubleroundoffflag == 'Y') {
																	netTotal = round(
																			netTotal,
																			1);
																}
																amntToPay = parseFloat(netTotal)
																		- parseFloat(temppaidAmt);
																document
																		.getElementById('onlinemodOrderCont').innerHTML = orderno;
																document
																        .getElementById('onlinemodStoreBasedOrderCont').innerHTML = storeBasedOrderNumber;
																
														        document
																		.getElementById('onlinemodTabCont').innerHTML = tableno;
																document
																		.getElementById('onlinetotamtcontId').innerHTML = parseFloat(
																		pmntTotAmt)
																		.toFixed(
																				2);
																document
																		.getElementById('onlinepaidamtcontId').innerHTML = parseFloat(
																		temppaidAmt)
																		.toFixed(
																				2);
																document
																		.getElementById('onlineamttopaycontId').innerHTML = parseFloat(
																		amntToPay)
																		.toFixed(
																				2);
																document
																		.getElementById('onlinetenderAmt').value = parseFloat(
																		amntToPay)
																		.toFixed(
																				2);
																document
																		.getElementById('onlineselpaymenttype').innerHTML = responseObjpaymenttype.paymentTypes[0].paymentTypeName;
																$(
																		"#selpaymentmode")
																		.val(
																				responseObjpaymenttype.paymentTypes[0].paymentTypeName
																						+ "_"
																						+ responseObjpaymenttype.paymentTypes[0].id);
																if (printpaidBill == 'N') {
																	document
																			.getElementById('chkprintBillonline').checked = false;
																}
																$(
																		"#onlineModal")
																		.modal(
																				"show");
															} catch (e) {
																alert(e);
															}
														}, null);
									} else {
										// alert("size="+responseObj.size);
										var createdrowline = "";
										var begintable = "<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222;'>";
										var endtable = "</table>";

										for (var j = 0; j < responseObjpaymenttype.paymentTypes.length; j++) {
											var begintr = "<tr style='background:#404040; color:#FFF;'>";
											// var firsttd="<td><input
											// type='radio'
											// name='paymenttypeopt'
											// onchange='getSelectedPaymentTypeval()'
											// value='"+responseObjpaymenttype.paymentTypes[j].id+"'/></td>";
											var firsttd = "<td><input type='radio' name='paymenttypeopt' onchange='getSelectedPaymentTypeval()' value='"
													+ responseObjpaymenttype.paymentTypes[j].paymentTypeName
													+ "_"
													+ responseObjpaymenttype.paymentTypes[j].id
													+ "'/></td>";
											var secondtd = "<td>"
													+ responseObjpaymenttype.paymentTypes[j].paymentTypeName
													+ "</td>";
											var endtr = "</tr>";
											createdrowline += begintr + firsttd
													+ secondtd + endtr;
										}

										$("#paymodeselectiondiv").html(
												begintable + createdrowline
														+ endtable);
										$("#paymodeselectionModal").modal(
												"show");
									}
								}
							} catch (e) {
								alert(e);
							}
						}, null);
	}
}
function getSelectedPaymentTypeval() {
	var selectedPaymentType = $('input[name=paymenttypeopt]:checked').val();
	console.log("selectedPaymentType=" + selectedPaymentType);
}
function getpaymod() {
	var selectedPaymentType = $('input[name=paymenttypeopt]:checked').val();
	if (selectedPaymentType == undefined) {
		$("#paymodeselectiontext").text(getBaseLang.selctPaymentMode);
	} else {
		$("#paymodeselectiontext").text("");
		$("#paymodeselectionModal").modal("hide");
		netTotal = document.getElementById('hidnetTotal').value;
		document.getElementById('paycardalertMsg').innerHTML = '';
		var orderno = document.getElementById('orderNo').value;
		var tableno = document.getElementById('tablenoCont').innerHTML;
		var temppaidAmt = 0.0;
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/getpaymentinfo/" + orderno + ".htm",
						function(response) {
							try {
								var responseObj = [];
								responseObj = JSON.parse(response);
								for (var i = 0; i < responseObj.length; i++) {
									temppaidAmt += responseObj[i].paidAmount;
								}
								paidAmnt = temppaidAmt;
								if (hidstoreroundoffflag == 'Y') {
									netTotal = Math.round(netTotal);
								}
								if (storedoubleroundoffflag == 'Y') {
									netTotal = round(netTotal, 1);
								}
								amntToPay = parseFloat(netTotal)
										- parseFloat(temppaidAmt);
								document.getElementById('onlinemodOrderCont').innerHTML = orderno;
								document.getElementById('onlinemodStoreBasedOrderCont').innerHTML = storeBasedOrderNumber;
								document.getElementById('onlinemodTabCont').innerHTML = tableno;
								document.getElementById('onlinetotamtcontId').innerHTML = parseFloat(
										pmntTotAmt).toFixed(2);
								document.getElementById('onlinepaidamtcontId').innerHTML = parseFloat(
										temppaidAmt).toFixed(2);
								document.getElementById('onlineamttopaycontId').innerHTML = parseFloat(
										amntToPay).toFixed(2);
								document.getElementById('onlinetenderAmt').value = parseFloat(
										amntToPay).toFixed(2);
								document.getElementById('onlineselpaymenttype').innerHTML = selectedPaymentType
										.split("_")[0];
								$("#selpaymentmode").val(selectedPaymentType);
								if (printpaidBill == 'N') {
									document
											.getElementById('chkprintBillonline').checked = false;
								}
								$("#onlineModal").modal("show");
							} catch (e) {
								alert(e);
							}
						}, null);
	}
}

function payByOnline(tenderAmt) {
	var payableamount  = document.getElementById('onlineamttopaycontId').innerHTML;
	//$("#onlineModal").modal("hide");
	var caseValue = $("#mobPrintVal").val();
	netTotal = document.getElementById('hidnetTotal').value;
	var orderno = document.getElementById('orderNo').value;
	var paymentType = $('#selpaymentmode').val();
	
	var remark="";
	if(storeID == 161){
		remark = $('#onlinepayremark').val();
	}
	
	
	
	
	var discountpercentage = document.getElementById('hidendiscountpercentage').value;
	var itemtotal=document.getElementById('subtotalcontId').innerHTML;
	var grossamount = (100 * Number(itemtotal))/(100-Number(discountpercentage));
	
	var vattax= $("#hidtotvattax").val();
	var stax= $("#hidtotstax").val();
	var scharge= $("#hidtotscharge").val();
	var discountamt= Number(grossamount) - Number(itemtotal);;
	var total_tax_amt=parseFloat(vattax)+parseFloat(stax);
	//alert("gross::"+grossamount+"vattax::"+vattax+"stax::"+stax+"scharge::"+scharge + "discountamt" + discountamt);
	if(itemtotal<=0){
		discountamt = grossamount = Number(document.getElementById('discBtnContId').innerHTML);
	}
	
	
	if (isNaN(tenderAmt) || tenderAmt == '') {
		document.getElementById('payonlinealertMsg').innerHTML = 'Please enter a valid number!';
		document.getElementById('onlinetenderAmt').focus();
	}
	else{
		 
		dsblPayByOnlineButton();
		
		if (parseFloat(tenderAmt).toFixed(2) >= parseFloat(amntToPay).toFixed(2)) {
			paidAmnt = parseFloat(amntToPay).toFixed(2);
			amntToPay = 0.0;
		} else {
			paidAmnt = parseFloat(tenderAmt).toFixed(2);
			amntToPay = parseFloat(amntToPay).toFixed(2)
					- parseFloat(tenderAmt).toFixed(2);
		}
		if (storedoubleroundoffflag == 'Y') {
			netTotal = round(netTotal, 1);
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
		payment1.paymentMode=paymentType.split("_")[0];
		payment1.cardLastFourDigits=paymentType.split("_")[1];
		payment1.source="web";
		payment1.remarks="nil";
		payment1.tipsAmount="0.00";
		payment1.remarks = remark;
		
		
		if(is_Acc=="Y")
		{
			 var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
				var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
				var round_ledger_id = parseInt($('#round_ledger_idf').val());
				var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
				var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
				var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
				 var card_ledger_id=parseInt($('#card_ledger_idf').val());


		  if(sale_ledger_id<=0 || duties_ledger_id<= 0 || round_ledger_id<=0 || discount_ledger_id<=0 || debitor_cash_ledger_id<=0 || service_charge_ledger_id<=0 || card_ledger_id<=0) {
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
				  payment1.taxVatAmt=total_tax_amt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.serviceChargeAmt=scharge.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;


			}
		}					
		
		/*$.ajax({		
			url : BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(payment1),
			async: false,
			success :*/ 
		
		     var ajaxCallObject = new CustomBrowserXMLObject();
		     ajaxCallObject.callAjaxPost(BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
						 payment1,
		            function(response) {
		
		                 try {
								if (response == 'success') {
									enblPayByOnlineButton();
									if(storeID == 161){
										document.getElementById('onlinepayremark').value ='';
										
									}
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
										} 
											var ajaxCallObject = new CustomBrowserXMLObject();
											ajaxCallObject.callAjax(BASE_URL
													+ "/order/printbill/" + orderno
													+ ".htm", function(response) {
											}, null);
										}
										 //}
									}
									else
								      {
								      
								      if (caseValue == 'Y') {
								       // cashOrcardPrintBill();
								        
								        //location.href=BASE_URL+'/order/vieworder.htm?ono='+0+'&tno='+0+'&sno=0';
								        printPaidBill(orderno);
								       }
								      }
									
									
									
									if (amntToPay > 0) {
										document.getElementById('amttopaycontId').innerHTML = parseFloat(
												amntToPay).toFixed(2);
										$("#onlineModal").modal("hide");
									} else {
										
										$("#onlineModal").modal("hide");
										
										if (document
												.getElementById('cardmodTabCont').innerHTML == '0'
												&& itcatId != '') {
											location.href = BASE_URL
													+ '/order/vieworders.htm?ono=0&tno=0&sno=0'
													+ '&itcno=' + itcatId
													+ '&flg=N&ptype=';
										} else {
//											if (caseValue == 'Y') {
//												cashOrcardPrintBill();
//											}
											if(storeID == 156){
												if (document.getElementById('onlinemodTabCont').innerHTML == '0') {
													
													var selectedoption = document.getElementById('orderType').value;
													location.href = BASE_URL + '/order/vieworderwithordertype.htm?ono='
													+ 0 + '&tno=' + 0 + '&sno=' + 0
													+ '&otypeno=' + selectedoption;
												}
												else{
													location.href = BASE_URL+ '/table/viewtable.htm';
													
												}
											}
											else{
											location.href = BASE_URL
													+ '/table/viewtable.htm';
											}

										}
									}
								}
								if(response == 'alreadypaid'){
									enblPayByOnlineButton();
									$('#onlineModal').modal('hide');
									document.getElementById('alreadypaidmsg').innerHTML = getBaseLang.paid;
									$('#alertalreadypaidModal').modal('show');
									
								}
								
							} catch (e) {
								alert(e);
							}
						
			             /*},
			            error : function(e) {
			          }
		          });*/
							
				}, null);
		
 	}
	

}

function openAddDiscount() {
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
//	var totAmt = document.getElementById('grandtotalcontId').innerHTML;

	var totAmt = document.getElementById('subtotalcontId').innerHTML;
	var totnonspotDiscAmt = document.getElementById('hidtotnonspotDiscAmt').value;
	
	//alert(totnonspotDiscAmt);
	if (orderno == 0 || forspNoteData.length > 0) {
		// alert('Please save the order first!');
		showalertsaveorderModal();
	} else {
		document.getElementById('discmodOrderCont').innerHTML = orderno;
		document.getElementById('discmodStoreBaseOrderCont').innerHTML = storeBasedOrderNumber;
		document.getElementById('discmodTabCont').innerHTML = tableno;
		document.getElementById('discmodtotamtcontId').innerHTML = totAmt;
		document.getElementById('discmoddiscountableamtcontId').innerHTML = parseFloat(
				totAmt - totnonspotDiscAmt).toFixed(2);
		if (totnonspotDiscAmt > 0) {
			$('#totdiscountableAmtrowId').removeClass('hide');
		}
		showaddDiscountModal();
	}

}



function calculateDiscAmt(per) {
	var totAmount = document.getElementById('discmodtotamtcontId').innerHTML;
	var totdiscountableAmount = document
			.getElementById('discmoddiscountableamtcontId').innerHTML;
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var discAmt = 0.0;
	if (per == '') {
		document.getElementById('discModdiscAmt').value = '0.00';
	} else if (!isNaN(per)) {
		discAmt = parseFloat(parseFloat(totdiscountableAmount).toFixed(2)
				* parseFloat(per).toFixed(2) / 100).toFixed(2);
		/*if (storeroundoffflag == 'Y') {
			discAmt = Math.round(discAmt);
		}*/
		document.getElementById('discModdiscAmt').value = parseFloat(discAmt)
				.toFixed(2);
	}
}

function calculateDiscPercentage(amt) {
	var totAmount = document.getElementById('discmodtotamtcontId').innerHTML;
	var totdiscountableAmount = document.getElementById('discmoddiscountableamtcontId').innerHTML;
	var discPercentage = 0.0;
	if (amt == '') {
		document.getElementById('discModdiscPer').value = '0.00';
	} else if (!isNaN(amt)) {
		   discPercentage = (parseFloat(amt).toFixed(2)*100)/ parseFloat(totdiscountableAmount).toFixed(2);
		  document.getElementById('discModdiscPer').value = parseFloat(discPercentage).toFixed(2);
          }
	
    }

/*function refreshtext(){
	document.getElementById('discModdiscPer').value='';
}*/


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
	//alert("net:"+netAmt + "discamt:"+discamt);
	var isnoncharge = 'N';
	if ($('#ncbill').is(':checked')) {
		discper = 100;
		discamt = document.getElementById('subtotalcontId').innerHTML;// parseFloat(netAmt).toFixed(2);
		isnoncharge = 'Y';
	}
	var nettot = 0.0;
   //alert(discper + " + " + discamt);
     /*if(storediscflag == 'Y' || storediscflag != 'M'){
	   
     }*/
	if ((storediscflag != 'M') && (isNaN(discper) || isNaN(discamt) || discper == '' || discamt == '')) {
		document.getElementById('discAddalertMsg').innerHTML = getBaseLang.plsEntrVdNo;
	} else if (discper > 100) {
		document.getElementById('discAddalertMsg').innerHTML = getBaseLang.discNotmrthn;
	} else if(discper == 100 && isnoncharge == 'N'){
		document.getElementById('discAddalertMsg').innerHTML = getBaseLang.discNotmrthn;
	}
	else if ($.trim(discreason) == '' && printReason == 'Y') {
		document.getElementById('discAddalertMsg').innerHTML = getBaseLang.discreason;
		
	}else {
		
		if(storediscflag == 'M' && discper == '' && discamt != ''){
			//alert("valid");
			discper="0.0";
			
		}
		// alert(discper + " + " + discamt);
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/adddiscount/" + orderid + "/"
								+ discper + "/" + discamt + "/" + discreason
								+ "/" + isnoncharge + ".htm",
						function(response) {
							try {
								console.log('adddiscount>>>'+response);
								if (response == 'success') {
									nettot = Number(netAmt) - Number(discamt);
									if (storediscflag == 'Y') {
										document
												.getElementById('discBtnContId').style.width = '';
										document
												.getElementById('discPerContId').innerHTML = getBaseLang.discount
												+ discper + '%:';
										document
												.getElementById('discBtnContId').innerHTML = discamt;																				
										
										if (storeroundoffflag == 'Y') {
											nettot = Math.round(nettot);
										}
										document
												.getElementById('amttopaycontId').innerHTML = parseFloat(
												nettot).toFixed(2);
									} else{
										//alert("N"+discamt);										
										
										document
												.getElementById('discPerContId').innerHTML = getBaseLang.discIn
												+ storecurrency + ':';
										document
												.getElementById('discBtnContId').innerHTML = discamt;
										if (storeroundoffflag == 'Y') {
											nettot = Math.round(nettot);
										}
										document
												.getElementById('amttopaycontId').innerHTML = parseFloat(
												nettot).toFixed(2);
									}
									document.getElementById('hidnetTotal').value = nettot;
									location.reload();
									closeaddDiscountModal();
								} else {
									document.getElementById('discAddalertMsg').innerHTML = ''
											+ response + '';
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
	ajaxCallObject.callAjax(BASE_URL + "/order/getpaymentinfo/" + orderno
			+ ".htm", function(response) {
		try {
			var responseObj = [];
			responseObj = JSON.parse(response);
			for (var i = 0; i < responseObj.length; i++) {
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
	for (var i = 0; i < checkboxes.length; i++) {
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
function checkRow(trId, chk) {
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
	
	
	for(var i=0;i<selectedRows.length;i++){
		for(var k=0;k<itemRecord.length;k++){
			if(itemRecord[k].itemId == selectedRows[i]){
				itemRecord.splice( itemRecord.indexOf(itemRecord[k]), 1 );
			}
		}
	}
	
	
	var noofremoveItem = selectedRows.length;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/deleteitems/" + selectedRows
			+ ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			selectedRows = [];
			prepareOrderHtml(responseObj);
			if (vfdPort.length > 3) {
				var tot = document.getElementById('amttopaycontId').innerHTML;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/"
						+ noofremoveItem + " ITEM(S) REMOVED" + "/"
						+ "TOT IN RM : " + parseFloat(tot).toFixed(2) + ".htm",
						function() {
						}, null);
			}
		} catch (e) {
			alert(e);
		}
	}, null);
	/*selectedRows = [];*/
}
function openpecialNoteModal() {

	var spnoteitemlistContId = document.getElementById('spnoteitemlistContId');
	var createdtd = "";
	if (storeID == 37 || storeID == 38) {
		if (forspNoteData.length > 0) {
			for (var i = 0; i < forspNoteData.length; i++) {
				var item = forspNoteData[i];
				var spnote = item.specialNote == undefined ? ""
						: item.specialNote;
				var namediv = "<div style='text-align: left;'>" + item.itemName
						+ "</div>";
				var inputdiv = "<div style='color: #000'><input type='text' style='width:60%;' value='"
						+ spnote
						+ "' id='spnoteinput_"
						+ item.itemId
						+ "'>&nbsp;&nbsp;<button type='button' onclick='javascript:getspecialNotebyitemIdOnly("
						+ item.itemId
						+ ",&quot;"
						+  encodeURI(item.itemName).replace(/'/g, "%27")
						+ "&quot;);' style='background: #72BB4F;font-weight: bold;height:30px;'  class='btn btn-success'>"
						+ getBaseLang.getNote + "</button></div>";
				createdtd += namediv + inputdiv;
			}
			spnoteitemlistContId.innerHTML = createdtd;
			showspecialnoteModal();
		} else {
			// alert('Please select any item!');
			showselectitemalertModal();
		}
	} else {
		/*
		 * var spnoteitemlistContId = document
		 * .getElementById('spnoteitemlistContId'); var createdtd = "";
		 */
		if (forspNoteData.length > 0) {
			for (var i = 0; i < forspNoteData.length; i++) {
				var item = forspNoteData[i];
				var spnote = item.specialNote == undefined ? ""
						: item.specialNote;
				var namediv = "<div style='text-align: left;'>" + item.itemName
						+ "</div>";
				var inputdiv = "<div style='color: #000'><input type='text' style='width:60%;' value='"
						+ spnote
						+ "' id='spnoteinput_"
						+ item.itemId
						+ "'>&nbsp;&nbsp;<button type='button' onclick='javascript:getspecialNotebyitemId("
						+ item.itemId
						+ ",&quot;"
						+ encodeURI(item.itemName).replace(/'/g, "%27")
						+ "&quot;);' style='background: #72BB4F;font-weight: bold;height:30px;'  class='btn btn-success'>"
						+ getBaseLang.getNote + "</button></div>";
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

function getspecialNotebyitemIdOnly(itemid, itemname) {
	var spnotecontId = document
			.getElementById("specialnoteforOrderContainerId");
	var headeritemname = document.getElementById("headerforitemnamespnote");
	document.getElementById("itemidforsetsplnote").value = itemid;
	var spnoteHtml = "";
	var createdrowline = "";
	var begintable = "<table class='table table-striped table-bordered' style='color:#FFF;  border:1px solid #222222;'>";
	var endtable = "</table>";
	headeritemname.innerHTML = itemname;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/order/getspecialnotesbyitemid/" + itemid
							+ ".htm",
					function(response) {
						try {
							var responseObj = JSON.parse(response);
							if (responseObj.length > 0) {
								for (var i = 0; i < responseObj.length; i++) {
									var spnote = responseObj[i];
									var begintr = "<tr style='background:#404040; color:#FFF;'>";
									var firsttd = "<td>" + spnote.menuItem.name
											+ "</td>";
									var secondtd = "<td><input type='checkbox' name='specialnote' value='"
											+ spnote.menuItem.name + "'/></td>";
									var endtr = "</tr>";
									createdrowline += begintr + firsttd
											+ secondtd + endtr;
								}
								spnotecontId.innerHTML = begintable
										+ createdrowline + endtable;
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

function getspecialNotebyitemId(itemid, itemname) {
	// alert(itemid);
	var count;
	var storewisesplnote = document.getElementById("hidstorespltype").value;
	var spnotecontId = document
			.getElementById("specialnoteforOrderContainerId");
	var headeritemname = document.getElementById("headerforitemnamespnote");
	document.getElementById("itemidforsetsplnote").value = itemid;
	var spnoteHtml = "";
	var createdrowline = "";
	/*
	 * var createdcoloumnline=""; var begintable="<table class='table
	 * table-striped table-bordered' style='color:#FFF; border:1px solid
	 * #222222;'>"; var endtable="</table>";
	 */
	headeritemname.innerHTML = decodeURI(itemname).replace("%27",/'/g);
	var ajaxCallObject = new CustomBrowserXMLObject();
	if (storewisesplnote == "item_wise") {
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/getspecialnotesbyitemid/" + itemid
								+ ".htm",
						function(response) {
							try {
								var responseObj = JSON.parse(response);
								if (responseObj.length > 0) {
									count = 0;
									for (var i = 0; i < responseObj.length; i++) {
										var spnote = responseObj[count];
										count++;
										createdrowline += "<label class='check-label'<div class='btn-order-taking' style='background:"
												+ spnote.menuItem.bgColor
												+ ";text-align:center;height:80px;width:30%;margin:6px;border-radius: 30px 3px;'><div>"
												+ spnote.menuItem.name
												+ "</div><div style='font-size:11px;white-space:normal;'> <td><input type='checkbox' name='specialnote' value='"
												+ spnote.menuItem.name
												+ "'/></td></div></div></label>";
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
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/getspecialnotesforstore.htm",
						function(response) {
							try {
								var responseObj = JSON.parse(response);
								// count = 0;
								for (var i = 0; i < responseObj.menucategory.length; i++) {
									var jsonmenucategory = responseObj.menucategory[i];

									for (var j = 0; j < jsonmenucategory.menucategory.length; j++) {
										var jsonmenucategory2 = jsonmenucategory.menucategory[j];
										for (var k = 0; k < jsonmenucategory2.items.length; k++) {
											var jsonmenucategoryitem = jsonmenucategory2.items[k];
											// count++
											// alert(jsonmenucategoryitem.name);;
											createdrowline += "<label class='check-label'<div class='btn-order-taking' style='background:"
													+ jsonmenucategoryitem.bgColor
													+ ";text-align:center;height:80px;width:30%;margin:6px;border-radius: 30px 3px;'><div>"
													+ jsonmenucategoryitem.name
													+ "</div><div style='font-size:11px;white-space:normal;'> <td><input type='checkbox' name='specialnote' value='"
													+ jsonmenucategoryitem.name
													+ "'/></td></div></div></label>";
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
	for (var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			selectedspnotefororderRows.push(checkboxes[i].value);
		}
	}
	if (selectedspnotefororderRows.length > 0) {
		for (var i = 0; i < selectedspnotefororderRows.length; i++) {
			spclvalue += selectedspnotefororderRows[i] + ",";
		}

	}
	// closespecialNoteforOrderModal();
	var prevnote = document.getElementById("spnoteinput_" + itemid).value;
	document.getElementById("spnoteinput_" + itemid).value = prevnote
			+ spclvalue;
}
function cancelSpecialNote() {

}
function savespecialNote() {
//alert("forspNoteData.length::"+forspNoteData.length);
	for (var i = 0; i < forspNoteData.length; i++) {
		var item = forspNoteData[i];
		var id = item.itemId;
		var note = decodeURIComponent(document.getElementById('spnoteinput_'
				+ item.itemId).value);
		 //alert(id+':'+note);

		// document.getElementById('specialAlert').innerHTML =
		// getBaseLang.plsEnterSpecialNote;
		/*var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/addspecialnote/" + note + "/"
				+ id + ".htm", function() {
		}, null);*/
		
		var menuitems = {};
		menuitems.id=id;
		menuitems.specialNote=note;
		$
		.ajax({
			url : BASE_URL + "/order/addspecialnote.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(menuitems),
			success : function(response, JSON_UNESCAPED_UNICODE) {
				console.log(response);
				
			      }
		     });
		}

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/showspecialnote.htm", function(
			response) {
		try {
			// alert(response);
			forspNoteData = [];
			var responseObj = JSON.parse(response);
			if (responseObj.length > 0) {
				for (var i = 0; i < responseObj.length; i++) {
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
	document.getElementById("creditsalemodStoreBaseOrderCont").innerHTML = storeBasedOrderNumber;
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
	//alert("netPrice:"+netPrice);
	var line1 = "<div style='padding: 5px;'>Total Amount :&nbsp;&nbsp;&nbsp;"
			+ parseFloat(pmntTotAmt).toFixed(2) + "</div>";
	var line2 = "<div style='padding: 5px;'>Amount to Pay :&nbsp;&nbsp;&nbsp;"
			+ parseFloat(netPrice).toFixed(2) + "</div>" ;
	var lineammt = "<div id='amttopaybycustomer' style='display:none;'>"+parseFloat(netPrice).toFixed(2)+"</div>";
	var line3 = "<div style='padding: 3px;'>"
			+ getBaseLang.tndrAmount
			+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input type='text' id='creditsaletenderAmount' style='text-align:center; color: #222222' size='4'/> </div>";
	// var line4="<div style='padding: 5px;'>Card Last 4 Digit :&nbsp;<input
	// type='text' id='creditsalecardlastfourDigit' style='text-align:center;
	// color: #222222' size='4'/> </div>";
	if (val == 'cash') {
		createdline = line1 + line2 + lineammt + line3;
		document.getElementById('creditsalecardlastfourDigit').value = "0000";
		document.getElementById("hidcreditsalelastfourdigitcontid").style.display = "none";
		document.getElementById('paycreditsalealertMsg').innerHTML = "";
	} else if (val == 'card') {
		createdline = line1 + line2 + lineammt + line3;
		document.getElementById('paycreditsalealertMsg').innerHTML = "";
	}else {
		createdline = lineammt;
	}
	document.getElementById("creditsalepaymentdetailcontId").innerHTML = createdline;
	if (val == 'card') {
		document.getElementById('creditsalecardlastfourDigit').value = "";
		document.getElementById("hidcreditsalelastfourdigitcontid").style.display = "block";
	}
	if (val == 'nopay') {
		document.getElementById('paycreditsalealertMsg').innerHTML = "";
		document.getElementById("hidcreditsalelastfourdigitcontid").style.display = "none";
	}
	
	
	document.getElementById("creditsalepayButton").disabled = false;
	
}
function payCreditSale() {

	var netAmt = document.getElementById('hidnetTotal').value;
	var orderno = document.getElementById('orderNo').value;
	var custid = document.getElementById('hidcredisalecustid').value;
	var option = document.getElementsByName("creditsalepayOption");
	var lastdigit = document.getElementById('creditsalecardlastfourDigit').value;
	var remark = document.getElementById('creditpayremark').value;
	//var temp_cash=document.getElementById('dr_legder_id_cash').value;
	//var temp_card=document.getElementById('dr_legder_id_card').value;
	//var temp_cr=document.getElementById('cr_legder_id').value;
   
	
	var amttoPay=document.getElementById('amttopaybycustomer').innerHTML;
	var paidAmnt=0.0;
	
	var vattax= $("#hidtotvattax").val();
	var stax= $("#hidtotstax").val();
	var scharge= $("#hidtotscharge").val();
	var discountpercentage = document.getElementById('hidendiscountpercentage').value;
	var itemtotal=document.getElementById('subtotalcontId').innerHTML;
	var grossamount = (100 * Number(itemtotal))/(100-Number(discountpercentage));

	var disAmt=parseFloat(grossamount)-parseFloat(itemtotal);
	var total_tax_amt=parseFloat(vattax)+parseFloat(stax);
	//alert(grossamount+""+total_tax_amt+""+scharge+""+disAmt+""+netTotal);

	if(itemtotal<=0){
		disAmt = grossamount = Number(document.getElementById('discBtnContId').innerHTML);
	}


	var selOption = null;
	for (var i = 0; i < option.length; i++) {
		if (option[i].checked == true) {
			selOption = option[i].value;
		}
	}
	var tenderAmt = 0;
	if(lastdigit == '') {
		lastdigit = 'xxxx';
	}


	if(remark == ''){ remark="nil";}
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

	/*else if (isNaN(lastdigit)) {
		// alert('Please enter a valid card number!');
		//document.getElementById('paycreditsalealertMsg').innerHTML = getBaseLang.plsEntrVldCardNo;
		//document.getElementById('creditsalecardlastfourDigit').focus();
	} else if (lastdigit.length != 4) {
		// alert('Please enter 4 digit valid card number!');
		//document.getElementById('paycreditsalealertMsg').innerHTML = getBaseLang.plsEntr4DgtNo;
		//document.getElementById('creditsalecardlastfourDigit').focus();
	} */

	else {
         if (parseFloat(tenderAmt) >= parseFloat(netAmt)) {
			  paidAmnt = parseFloat(netAmt);
			  amttoPay = 0.0;
	    } else {
		      paidAmnt = parseFloat(tenderAmt);
		      amttoPay = (parseFloat(amttoPay) - parseFloat(tenderAmt)).toFixed(2);
	           }
	    
		if (storedoubleroundoffflag == 'Y') {
	    	tenderAmt = round(tenderAmt, 1);
	      }
	
		//var amttoPay = parseFloat(netAmt).toFixed(2) - tenderAmt;

		var payment1={};
		var order={};

		var orderBill={};

		order.id=orderno;

		orderBill.grossAmt=grossamount.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
		order.orderBill=orderBill;

		payment1.orderPayment=order;
		payment1.amount=netAmt;
		payment1.paidAmount=paidAmnt;
		payment1.amountToPay=amttoPay;
		payment1.tenderAmount=tenderAmt;
		payment1.paymentMode=selOption;
		payment1.cardLastFourDigits=lastdigit;
		payment1.source="web";
		payment1.remarks=remark;
		payment1.tipsAmount="0.00";
		if(is_Acc=="Y")
		{
			    var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
				var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
				var round_ledger_id = parseInt($('#round_ledger_idf').val());
				var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
				var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
			    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
			    var card_ledger_id=parseInt($('#card_ledger_idf').val());
			    var debitor_ledger_id=parseInt($('#debitor_ledger_idf').val());


		  if(sale_ledger_id<=0 || duties_ledger_id<= 0 || round_ledger_id<=0 || discount_ledger_id<=0 || debitor_cash_ledger_id<=0 || service_charge_ledger_id<=0 || card_ledger_id<=0 || debitor_ledger_id<=0) {
		   document.getElementById('paycreditsalealertMsg').innerHTML = "ledger missing";
				return;
			 }else {
				  document.getElementById('paycreditsalealertMsg').innerHTML = "";

				  payment1.duties_ledger_id=duties_ledger_id;
				  payment1.round_ledger_id=round_ledger_id;
				  payment1.sale_ledger_id=sale_ledger_id;
				  payment1.discount_ledger_id=discount_ledger_id;
				  payment1.debitor_cash_ledger_id=debitor_cash_ledger_id;
				  payment1.service_charge_ledger_id=service_charge_ledger_id;
				  payment1.card_ledger_id=card_ledger_id;
				  payment1.debitor_ledger_id= debitor_ledger_id;
				  payment1.grossAmt=grossamount.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.discAmt=disAmt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.taxVatAmt=total_tax_amt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.serviceChargeAmt=scharge.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;


			}
		}


		// alert('success:'+amttoPay);
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/order/updatecreditsalestatus/"
				+ orderno + "/" + custid + ".htm", function(response) {
			try {
				// alert(response);
				if (response == 'success') {
					var ajaxCallObject = new CustomBrowserXMLObject();
					/*ajaxCallObject.callAjax(BASE_URL + "/order/orderpayment/"
							+ orderno + "/" + netAmt + "/"
							+ parseFloat(tenderAmt).toFixed(2) + "/" + amttoPay
							+ "/" + tenderAmt + "/" + selOption + "/"
							+ lastdigit + "/" + remark + "/" + "0.00"+".htm",*/
				 ajaxCallObject.callAjaxPost(BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
						 payment1,
					function(response) {
						try {
							// alert(response);
							if (response == 'success') {
								hideCreditSaleModal();
								location.href = BASE_URL
										+ '/table/viewtable.htm';

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
			ajaxCallObject
					.callAjax(
							BASE_URL + "/order/updatepax/" + orderno + "/"
									+ noofPax + ".htm",
							function(response) {
								try {
									// alert(response);
									if (response == 'success') {
										document.getElementById('noofPaxId').innerHTML = noofPax;
										document.getElementById('hidnoofPax').value = noofPax;
										$("#paxbtn").css("width","85%");
										closePaxModal();
									} else {
										document.getElementById('paxalertMsg').innerHTML = ''
												+ response + '';
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
	
	   // tblno = tblno.replace(/%20/g, " ");
	if (tabstat == 'Y') {
		document.getElementById('changetablealertMsg').innerHTML = getBaseLang.tableNo
				+ tabno + getBaseLang.isBooked;
	} else {
		if (orderno == '0') {
			document.getElementById('tablenoCont').innerHTML = tabno;
			closeChangeTableModal();
		} else {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject
					.callAjax(
							BASE_URL + "/order/updatetable/" + orderno + "/"
									+ tabno + ".htm",
							function(response) {
								try {
									// alert(response);
									if (response == 'success') {
										document.getElementById('tablenoCont').innerHTML = tabno;
										closeChangeTableModal();
									} else {
										document
												.getElementById('changetablealertMsg').innerHTML = ''
												+ response + '';
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
	//alert("Store id:"+storeid);
	$("#submitSplitBillBut").hide();
	document.getElementById('splitBillContainerId').innerHTML = "";
	document.getElementById('splitbillalertMsg').innerHTML = "";
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
	if (orderno != 0 && tableno != '0') {
		// alert('Please save the order first!');
		if (storeid == 37 || storeid == 38 || storeid == 111 || storeid == 126) {
			var noofPax = document.getElementById('noofPaxId').innerHTML;
			var NOPAX = parseInt(noofPax);
			document.getElementById('noofsplitBill').value = NOPAX;
		} else {
			document.getElementById('noofsplitBill').value = 2;
		}

		document.getElementById('splitbillmodOrderCont').innerHTML = orderno;
		document.getElementById('splitbillmodStoreBaseOrderCont').innerHTML = storeBasedOrderNumber;
		document.getElementById('splitbillmodTabCont').innerHTML = tableno;

		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL
				+ "/order/getsplitbillitemlistbyoderid/" + orderno + ".htm",
				function(response) {
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
var splitsChargRate =document.getElementById('serviceChargeRate').value;
var splitsChargFlag =document.getElementById('hidserviceChargeTextNew').value;
var splitsChargText =document.getElementById('hidserviceChargeText').value;

function showSplitBillContent(pax, storeid) {
	$("#submitSplitBillBut").show();
	if (storeid == 37 || storeid == 38 || storeid == 111 || storeid == 126) {
		
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
					ajaxCallObject
							.callAjax(
									BASE_URL
											+ "/order/getsplitbillitemlistcategorywisebyoderid/"
											+ orderno + ".htm", function(
											response) {
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
				ajaxCallObject.callAjax(BASE_URL
						+ "/order/getsplitbillitemlistcategorywisebyoderid/"
						+ orderno + ".htm", function(response) {
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
	var discpercentage=document.getElementById('hidendiscountpercentage').value;
	for (var i = 1; i <= pax; i++) {
		var createddiv = "";
		var headerDiv = "<div align='left'>"
				+ getBaseLang.billNo
				+ " "
				+ i
				+ " <button type='button' onclick='javascript:opensplitBillItemListModal("
				+ i
				+ ")' style='background: #72BB4F;font-weight: bold;margin-left:65%' class='btn btn-success'>"
				+ getBaseLang.selectItem + "</button></div>";
		var tableline = "<div id='sbillcontid_"
				+ i
				+ "'><table id='tbl_" + i + "' class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>"
				+ getBaseLang.name + "</th><th style='text-align:center;'>"
				+ getBaseLang.qty + "</th><th style='text-align:center;'>"
				+ getBaseLang.rate + "</th><th style='text-align:center;'>"
				+ getBaseLang.tot + "</th>";
		var headerline = "<tbody style='color:#fff; padding:1px;' id='tbodycontid_"
				+ i + "'>";
		var endtbody = "</tbody></table>";
		var subtotdiv = "<div align='left' style='width:77%'>"
				+ getBaseLang.subTot
				+ "<span style='float:right' id='subtotdiv_" + i
				+ "'>0.00</span></div>";
		var taxdiv = "";
		var staxdiv = "";
		var schargdiv = "";
		
	    //console.log('hello' + getBaseLang.vat);
		if (splitsChargFlag == 'Y') {
			schargdiv = "<div align='left' style='width:77%'>" + splitsChargText
					+ "(" + splitsChargRate
					+ "%)<span style='float:right' id='schargdiv_" + i
					+ "'>0.00</span></div>";
		}
		if (splitvattaxText.length != 0) {
			taxdiv = "<div align='left' style='width:77%'>" + splitvattaxText
					+ "(" + splitvatAmt
					+ "%)<span style='float:right' id='taxdiv_" + i
					+ "'>0.00</span></div>";
		}
		if (splitservicetaxText.length != 0) {
			staxdiv = "<div align='left' style='width:77%'>"
					+ splitservicetaxText + "(" + splitstaxAmt
					+ "%)<span style='float:right' id='staxdiv_" + i
					+ "'>0.00</span></div>";
		}
		// var taxdiv="<div align='left' style='width:77%'>GST(6%)<span
		// style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
		var grandtotdiv = "<div align='left' style='width:77%'>"
				+ getBaseLang.grndTot
				+ "<span style='float:right' id='grandtotdiv_" + i
				+ "'>0.00</span></div>";
		
		
		var discountdiv = "<div align='left' style='width:77%'>"
			+ "Discount" + "("+ discpercentage
			+ "%)<span style='float:right' id='discountdiv_" + i
			+ "'>0.00</span></div>";
		
		
		// new added 7.6.2018 strt
		var vatTaxableamtdiv = "<div align='left' style='display:none;'>"
			+ "VatTaxableamt" + "<span style='float:right' id='vattaxableamtdiv_" + i
			+ "'>0.00</span></div>";
		var serviceTaxableamtdiv = "<div align='left' style='display:none;'>"
			+ "ServiceTaxableamt" + "<span style='float:right' id='servicetaxableamtdiv_" + i
			+ "'>0.00</span></div>";
		
		// new added 7.6.2018 end
		
		
		
		
		
		var footerline = "</div>";
		createddiv = headerDiv + tableline + headerline + endtbody + subtotdiv + schargdiv
				+ taxdiv + staxdiv +discountdiv+ grandtotdiv + vatTaxableamtdiv + serviceTaxableamtdiv + footerline;
		generatedHtml += createddiv;
	}
	// alert(generatedHtml);
	document.getElementById('splitBillContainerId').innerHTML = generatedHtml;
}

function generateHTMLForCategoryWiseSplitting(pax) {
	var generatedHtml = "";
	var discpercentage=document.getElementById('hidendiscountpercentage').value;
	for (var i = 1; i <= pax; i++) {
		var createddiv = "";
		var headerDiv = "<div align='left'>"
				+ getBaseLang.billNo
				+ " "
				+ i
				+ " <button type='button' onclick='javascript:opensplitBillItemListModalCategoryWise("
				+ i
				+ ")' style='background: #72BB4F;font-weight: bold;margin-left:65%' class='btn btn-success'>"
				+ getBaseLang.selctCat + "</button></div>";
		var tableline = "<div id='sbillcontid_"
				+ i
				+ "'><table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>"
				+ getBaseLang.name + "</th><th style='text-align:center;'>"
				+ getBaseLang.qty + "</th><th style='text-align:center;'>"
				+ getBaseLang.rate + "</th><th style='text-align:center;'>"
				+ getBaseLang.tot + "</th>";
		var headerline = "<tbody style='color:#fff; padding:1px;' id='tbodycontid_"
				+ i + "'>";
		var endtbody = "</tbody></table>";
		var subtotdiv = "<div id='subtotdivcont_" + i
				+ "' align='left' style='width:77%'>" + getBaseLang.subTot
				+ "<span style='float:right' id='subtotdiv_" + i
				+ "'>0.00</span></div>";
		var taxdiv = "";
		var staxdiv = "";
		var schargdiv = "";
		
		if (splitsChargFlag == 'Y' && splitsChargRate !=0.00) {
			schargdiv = "<div id='schargdivcont_" + i+"' align='left' style='width:77%'>" + splitsChargText
					+ "(" + splitsChargRate
					+ "%)<span style='float:right' id='schargdiv_" + i
					+ "'>0.00</span></div>";
		}
		if (splitvattaxText.length != 0) {
			// taxdiv="<div id='taxdivcont_"+i+"' align='left'
			// style='width:77%'>"+splitvattaxText+"("+splitvatAmt+"%)<span
			// style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
			taxdiv = "<div id='taxdivcont_" + i
					+ "' align='left' style='width:77%'>" + splitvattaxText
					+ "<span style='float:right' id='taxdiv_" + i
					+ "'>0.00</span></div>";
		}
		if (splitservicetaxText.length != 0) {
			// staxdiv="<div id='staxdivcont_"+i+"' align='left'
			// style='width:77%'>"+splitservicetaxText+"("+splitstaxAmt+"%)<span
			// style='float:right' id='staxdiv_"+i+"'>0.00</span></div>";
			staxdiv = "<div id='staxdivcont_" + i
					+ "' align='left' style='width:77%'>" + splitservicetaxText
					+ "<span style='float:right' id='staxdiv_" + i
					+ "'>0.00</span></div>";
		}
		// var taxdiv="<div align='left' style='width:77%'>GST(6%)<span
		// style='float:right' id='taxdiv_"+i+"'>0.00</span></div>";
		var discountdiv = "<div id='discountdivcont_" + i+"' align='left' style='width:77%'>"
			+ "Discount" + "("+ discpercentage
			+ "%)<span style='float:right' id='discountdiv_" + i
			+ "'>0.00</span></div>";
		
		var grandtotdiv = "<div id='grandtotdivcont_"
				+ i
				+ "' align='left' style='width:77%'>GrandTotal<span style='float:right' id='grandtotdiv_"
				+ i + "'>0.00</span></div>";
		var footerline = "</div>";
		createddiv = headerDiv + tableline + headerline + endtbody + subtotdiv + schargdiv
				+ taxdiv + staxdiv + discountdiv + grandtotdiv + footerline;
		generatedHtml += createddiv;
	}
	// alert(generatedHtml);
	document.getElementById('splitBillContainerId').innerHTML = generatedHtml;
}

var splitbillid = 0;
function opensplitBillItemListModal(id) {
	splitbillid = id;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/getsplitbillitemlist.htm",
			function(response) {
				try {
					var responseObj = JSON.parse(response);
				//	alert(response);
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
	ajaxCallObject.callAjax(BASE_URL
			+ "/order/getsplitbillitemlistcategorywise.htm",
			function(response) {
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
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th style='width:5%'></th><th style='text-align:center'>"
			+ getBaseLang.catName + "</th>";
	var headerline = "<tbody style='color:#fff; padding:1px;' >";
	var footerline = "</tbody></table>";
	for (var i = 0; i < responseData.length; i++) {
		var itemcatgory = responseData[i];
		var disc1 = 0.0;
		var begintrline = "";
		var firsttdline = "";
		var secondtdline = "";
		var trbgColor = "#222222";
		// alert(orderitem.id);
		begintrline = "<tr id='rowsplitcatwise_" + itemcatgory.id
				+ "' style='background:" + trbgColor + "; padding:2px;'>";
		firsttdline = "<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRowSplitcatwise("
				+ itemcatgory.id
				+ ",this)' id='chksplitcatwise_"
				+ itemcatgory.id + "'></td>";
		secondtdline = "<td width='50%'  onclick='javascript:selectRowSplitcatwise("
				+ itemcatgory.id
				+ ")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"
				+ itemcatgory.menuCategoryName + "</td>";
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
		selectedsplitRowscatwise.splice(selectedsplitRowscatwise.indexOf(trId),
				1);
	}
}
function checkRowSplitcatwise(trId, chk) {
	if (chk.checked) {
		document.getElementById('rowsplitcatwise_' + trId).style.background = '#373737';
		selectedsplitRowscatwise.push(trId);
	} else {
		document.getElementById('rowsplitcatwise_' + trId).style.background = '#222222';
		selectedsplitRowscatwise.splice(selectedsplitRowscatwise.indexOf(trId),
				1);
	}
}
function addItemToSplitBillcatwise() {
	// alert(selectedsplitRows);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/additemlisttosplitbillcatwise/"
			+ selectedsplitRowscatwise + ".htm", function(response) {
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
	var discpercentage=document.getElementById('hidendiscountpercentage').value;
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var subtot = 0.0;
	var subtotalafterdiscount = 0.0;
	subtot = document.getElementById('subtotdiv_' + splitbillid).innerHTML;
	subtot = parseFloat(subtot);
	
	// new added dated 6.6.2018 strt 
	var pastvat = 0.0;
	if (splitvattaxText.length != 0) {
	    pastvat = document.getElementById('taxdiv_' + splitbillid).innerHTML;
	}
	var paststax = 0.0;
	if (splitservicetaxText.length != 0) {
	    paststax = document.getElementById('staxdiv_' + splitbillid).innerHTML;
	    }
	var pastdiscountamt = 0.0;
	    pastdiscountamt = document.getElementById('discountdiv_' + splitbillid).innerHTML;
	var pastschargeamt = 0.0;
	    if (splitsChargFlag == 'Y' && splitsChargRate !=0.00) { 
	      pastschargeamt = document.getElementById('schargdiv_' + splitbillid).innerHTML;
	    }
	pastvat = parseFloat(pastvat);
	paststax = parseFloat(paststax);
	pastdiscountamt = parseFloat(pastdiscountamt);
	pastschargeamt= parseFloat(pastschargeamt);
	
	
	
	var currenttotal = 0.0;
	var currentvtax = 0.0;
	var currenttotvtax = 0.0;
	var currentstax = 0.0;
	var currenttotstax = 0.0;
	var currentgrossammt = 0.0;
	var currentnetamt = 0.0;
	var currenttotnetamt = 0.0;
	var currentsubtotal = 0.0;
	var currentdiscountammt = 0.0;
	var currentschargeamt = 0.0;
	var currenttotdiscountammt = 0.0;
	var currenttotschargeamt = 0.0;
	// new added dated 6.6.2018 strt end
	
	var catidbeverage = 0.0;
	var taxamt = 0.0;
	var staxamt = 0.0;
	var schargeamt = 0.0;
	var discountammt = 0.0; //new
	var grossammt = 0.0;   //new
	var subtotafterdiscount = 0.0;  //new
	var grandtot = 0.0;
	var generatedHtml = "";
	var createddiv = "";
	var createdrowline = "";
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>"
			+ getBaseLang.sl
			+ "</th><th>"
			+ getBaseLang.name
			+ "</th><th style='text-align:center;'>"
			+ getBaseLang.qty
			+ "</th><th>"
			+ getBaseLang.rate
			+ "</th><th>"
			+ getBaseLang.tot
			+ "</th><th>" + getBaseLang.action + "</th>";
	var headerline = "<tbody style='color:#fff; padding:1px;' >";
	var endtbody = "</tbody>";
	var footerline = "</tbody><tfoot><tr><td>" + getBaseLang.subTot
			+ "</td><td></td><td></td><td></td><td>" + getBaseLang.no1
			+ "</td></tr><tr><td>" + getBaseLang.gst
			+ "</td><td></td><td></td><td></td><td>" + getBaseLang.no2
			+ "</td></tr><tr><td>" + getBaseLang.subTot
			+ "</td><td></td><td></td><td></td><td>" + getBaseLang.no3
			+ "</td></tr></tfoot></table>";

	
	for (var i = 0; i < responseData.length; i++) {
		var Menu = responseData[i];
		for (var j = 0; j < Menu.items.length; j++) {
			var item = Menu.items[j];
			var disc1 = 0.0;
			var begintrline = "";
			var firsttdline = "";
			var secondtdline = "";
			var thirdtdline = "";
			var trbgColor = "#222222";

			begintrline = "<tr id='" + item.id
					+ "' style='padding:2px;background:#404040'>";
			var hidcatid = "<input type='hidden'  value='" + item.categoryId
					+ "'>";
			secondtdline = "<td width='50%' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"
					+ item.name + " ## " + item.categoryName + "</td>";
			thirdtdline = "<td valign='middle' align='center' style='padding:3px;'>"
					+ item.quantityOfItem + "</td>";
			var fourthtdline = "<td  style='padding:1px;text-align: center;'>"
					+ parseFloat(item.price).toFixed(2) + "</td>";
			var fifthtdline = "<td style='padding:1px;text-align: center;'>"
					+ parseFloat(disc1).toFixed(2) + "</td>";
			var sixthtdline = "<td style='padding:1px;text-align: center;'>"
					+ parseFloat((item.price * item.quantityOfItem - disc1)-(item.promotionDiscountAmt))
							.toFixed(2) + "</td>";
			//subtot += (item.price * item.quantityOfItem - disc1) - (item.promotionDiscountAmt); // off 6.6.18
			
			currenttotal = (item.price * item.quantityOfItem - disc1) - (item.promotionDiscountAmt); // new added
			currentsubtotal = currentsubtotal + currenttotal;
			
			
			/*if (splitsChargFlag == 'Y' && splitsChargRate !=0.00) {

				schargeamt += subtot * splitsChargRate / 100;
			}*/
			/*taxamt += ((item.price * item.quantityOfItem - disc1) + schargeamt) * item.vat
					/ 100;
			staxamt += ((item.price * item.quantityOfItem - disc1) + schargeamt)
					* item.serviceTax / 100;*/
			var endtrline = "</tr>";
			createdrowline += begintrline + hidcatid + secondtdline
					+ thirdtdline + fourthtdline + sixthtdline + endtrline;
			if (item.categoryId == 1025) {
				catidbeverage = item.categoryId;

			}
		
      ////////added in 6th June 2018 start  (this is item based calculation with taxes and scharge and discount)////
			if(discpercentage != '0' || discpercentage != '0.0'){ // new added
				currentdiscountammt = (currenttotal * discpercentage)/100;
				currenttotdiscountammt =  currenttotdiscountammt + currentdiscountammt;
				currenttotal = currenttotal - currentdiscountammt;	
			 }
			if (splitsChargFlag == 'Y' && splitsChargRate !=0.00) { 
		          currentschargeamt = currenttotal * splitsChargRate / 100;
		          currenttotschargeamt = currenttotschargeamt + currentschargeamt;
		     } 
			currentgrossammt = currenttotal + currentschargeamt; // new added
			if(item.vat>0){
				if (splitvattaxText.length != 0) {	 
					currentvtax = currentgrossammt * splitvatAmt / 100;
					currenttotvtax = currenttotvtax + currentvtax;
					 
				}
				
			}
			if(item.serviceTax>0){
				if (splitservicetaxText.length != 0) {	 
					currentstax = currentgrossammt * splitstaxAmt / 100;
					currenttotstax = currenttotstax + currentstax;
				}	
				
			}
			
			currentnetamt = currentgrossammt + currentstax + currentvtax;
			currenttotnetamt = currenttotnetamt + currentnetamt;
		////////added in 6th June 2018 end////
		}

	}
	
	//new added 6.6.18 strt
	subtot = subtot + currentsubtotal;
	taxamt = pastvat + currenttotvtax;
	staxamt = paststax + currenttotstax;
	schargeamt = pastschargeamt + currenttotschargeamt;
	discountammt = pastdiscountamt + currenttotdiscountammt;
	grandtot = ((subtot - discountammt) + schargeamt) + taxamt + staxamt;
	//new added 6.6.18 end
	
	
	
	
	/*if(discpercentage != '0' || discpercentage != '0.0'){ // new added(off 6.6.18)
		discountammt = (subtot * discpercentage)/100;
		subtotalafterdiscount = subtot - discountammt;	
	 }
	
	if (splitsChargFlag == 'Y' && splitsChargRate !=0.00) { (off 6.6.18)
          schargeamt = subtotalafterdiscount * splitsChargRate / 100;
     } 
	
	//////
   grossammt = subtotalafterdiscount + schargeamt; // new added (off 6.6.18)
 	*/
	
	/**/
	
	/*(off 6.6.18)
	 * 
	 * if (splitvattaxText.length != 0) {	 // new	
		 taxamt = grossammt * splitvatAmt / 100;
		 
	}
	if (splitservicetaxText.length != 0) {	 // new	
		staxamt = grossammt * splitstaxAmt / 100;
		 
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
	}*/
   /**/ 
	
	
	// taxamt=subtot*6/100;
	
	//grandtot = subtot + schargeamt + taxamt + staxamt; //old code
	/*grandtot = grossammt + taxamt + staxamt; // new(off 6.6.18)*/
	
	
	
	
	generatedHtml = createdrowline;
	// alert(generatedHtml);
	$("#tbodycontid_" + splitbillid).append(generatedHtml);
	document.getElementById('subtotdivcont_' + splitbillid).style.width = "86%";
	document.getElementById('subtotdiv_' + splitbillid).innerHTML = parseFloat(subtot).toFixed(2); //new

	if (splitsChargFlag == 'Y' && splitsChargRate !=0.00) {
		document.getElementById('schargdivcont_' + splitbillid).style.width = "86%";
		document.getElementById('schargdiv_' + splitbillid).innerHTML = parseFloat(schargeamt).toFixed(2);
	     }
	
	if (storeID == 53 && catidbeverage == 1025) {
		document.getElementById('taxdivcont_' + splitbillid).innerHTML = " "
				+ getBaseLang.salesTax
				+ " <span style='float:right' id='taxdiv_" + splitbillid + "'>"
				+ getBaseLang.no4 + "</span>";
		document.getElementById('taxdivcont_' + splitbillid).style.width = "86%";
		document.getElementById('taxdiv_' + splitbillid).innerHTML = parseFloat(
				taxamt).toFixed(2);

	} else {

		if (splitvattaxText.length != 0) {
			document.getElementById('taxdivcont_' + splitbillid).style.width = "86%";
			document.getElementById('taxdiv_' + splitbillid).innerHTML = parseFloat(
					taxamt).toFixed(2);
		}
	}

	if (splitservicetaxText.length != 0) {
		document.getElementById('staxdivcont_' + splitbillid).style.width = "86%";
		document.getElementById('staxdiv_' + splitbillid).innerHTML = parseFloat(
				staxamt).toFixed(2);
	}

	if(discpercentage != '0' || discpercentage != '0.0'){ //new
	document.getElementById('discountdivcont_' + splitbillid).style.width = "86%";
	document.getElementById('discountdiv_' + splitbillid).innerHTML = parseFloat(
			discountammt).toFixed(2);//new
	
	}
	
	document.getElementById('grandtotdivcont_' + splitbillid).style.width = "86%";
	if (storeroundoffflag == 'Y') {
		grandtot = Math.round(grandtot);
	}	
	document.getElementById('grandtotdiv_' + splitbillid).innerHTML = parseFloat(
			grandtot).toFixed(2);
	// document.getElementById('tbodycontid_'+splitbillid).innerHTML=generatedHtml;
}

function preparesplitbillitemListHtml(responseData) {
	//alert("item");
	selectedsplitRows = [];
	var createdrowline = "";
	var generatedHtml = "";
	// for saravana
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th></th><th>"
			+ getBaseLang.name
			+ "</th><th style='text-align:center;'>"
			+ getBaseLang.qty
			+ "</th><th>"
			+ getBaseLang.rate
			+ "</th><th>"
			+ getBaseLang.tot + "</th>";
	var headerline = "<tbody style='color:#fff; padding:1px;' >";
	var footerline = "</tbody></table>";
	for (var i = 0; i < responseData.length; i++) {
		var orderitem = responseData[i];
		//alert("orderitem.quantityOfItem:"+orderitem.quantityOfItem);
		//alert("orderitem.promotionDiscountAmt:"+orderitem.promotionDiscountAmt);
		var disc1 = 0.0;
		var begintrline = "";
		var firsttdline = "";
		var secondtdline = "";
		var thirdtdline = "";
		var trbgColor = "#222222";
		// alert(orderitem.id);
		begintrline = "<tr id='rowsplit_" + orderitem.id
				+ "' style='background:" + trbgColor + "; padding:2px;'>";
		var hiditemid = "<input type='hidden' id='" + splitbillid + "_"
				+ orderitem.id + "' value='" + orderitem.id + "'>";
		firsttdline = "<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRowSplit("
				+ orderitem.id
				+ ",this)' id='chksplit_"
				+ orderitem.id
				+ "'></td>";
		secondtdline = "<td width='50%'  onclick='javascript:selectRowSplit("
				+ orderitem.id
				+ ")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"
				+ orderitem.item.name + "</td>";
		thirdtdline = "<td valign='middle' align='center' style='padding:3px;'>"
				+ orderitem.quantityOfItem + "</td>";
		var fourthtdline = "<td  style='padding:1px;text-align: center;'>"
				+ parseFloat(orderitem.rate).toFixed(2) + "</td>";
		var fifthtdline = "<td style='padding:1px;text-align: center;'>"
				+ parseFloat(disc1).toFixed(2) + "</td>";
		var sixthtdline = "<td style='padding:1px;text-align: center;'>"
				+ parseFloat((orderitem.rate * orderitem.quantityOfItem - disc1)-(orderitem.promotionDiscountAmt)).toFixed(2) + "</td>";
		var seventhhtdline = "";
		var eighthtdline = "";
		/*
		 * if(vattaxText.length!=0) { seventhhtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.vat).toFixed(2)+"</td>"; }
		 * if(servicetaxText.length!=0) { eighthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.serviceTax).toFixed(2)+"</td>"; }
		 */

		var endtrline = "</tr>";
		createdrowline += begintrline + firsttdline + secondtdline
				+ thirdtdline + fourthtdline + sixthtdline + endtrline;

	}
	generatedHtml = tableline + headerline + createdrowline + footerline;
	document.getElementById('splitBillItemListContId').innerHTML = generatedHtml;
}
var selectedsplitRows = [];
function selectRowSplit(trId) {
	//alert(trId);
	if (document.getElementById('chksplit_' + trId).checked == false) {
		document.getElementById('rowsplit_' + trId).style.background = '#373737';
		document.getElementById('chksplit_' + trId).checked = true;
		selectedsplitRows.push(trId);
	} else {
		document.getElementById('rowsplit_' + trId).style.background = '#222222';
		document.getElementById('chksplit_' + trId).checked = false;
		selectedsplitRows.splice(selectedsplitRows.indexOf(trId), 1);
	}
	//alert(selectedsplitRows);
}
function checkRowSplit(trId, chk) {
	//alert(trId);
	if (chk.checked) {
		document.getElementById('rowsplit_' + trId).style.background = '#373737';
		selectedsplitRows.push(trId);
	} else {
		document.getElementById('rowsplit_' + trId).style.background = '#222222';
		selectedsplitRows.splice(selectedsplitRows.indexOf(trId), 1);
	}
	//alert(selectedsplitRows);
}
function addItemToSplitBill() {
//	 alert(selectedsplitRows);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/additemlisttosplitbill/"
			+ selectedsplitRows + ".htm", function(response) {
		try {
			var responseObj = JSON.parse(response);
			console.log(response);
			preparesplitbillitemListHtmltoBill(responseObj);

		} catch (e) {
			alert(e);
		}

	}, null);
	hidesplitBillItemListModal();
}
function deleteItemFromSplitBill(billid, deleteitemid , rate , vat , servicetax) { // changed in 7.6.2018
	// alert(deleteitemid);
	var orderid = document.getElementById('splitbillmodOrderCont').innerHTML;
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/order/deleteitemlisttosplitbill/"
			+ deleteitemid + "/" + orderid + ".htm", function(response) {
		preparesplitbillitemListHtmltoBillDelete(billid, deleteitemid, rate , vat , servicetax);// changed in 7.6.2018
	}, null);

	hidesplitBillItemListModal();
}

var itemSplitList = [];
var valueToPush = {};

/*function preparesplitbillitemListHtmltoBill(responseData) {
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var splitbillids = [];
	var subtot = 0.0;
	subtot = document.getElementById('subtotdiv_' + splitbillid).innerHTML;
	subtot = parseFloat(subtot);
	var taxamt = 0.0;
	var staxamt = 0.0;
	var schargeamt = 0.0;
	var grandtot = 0.0;
	var generatedHtml = "";
	var createddiv = "";
	var createdrowline = "";
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>"
			+ getBaseLang.sl
			+ "</th><th>"
			+ getBaseLang.name
			+ "</th><th style='text-align:center;'>"
			+ getBaseLang.qty
			+ "</th><th>"
			+ getBaseLang.rate
			+ "</th><th>"
			+ getBaseLang.tot
			+ "</th><th>" + getBaseLang.action + "</th>";
	var headerline = "<tbody style='color:#fff; padding:1px;' >";
	var endtbody = "</tbody>";
	var footerline = "</tbody><tfoot><tr><td>" + getBaseLang.subTot
			+ "</td><td></td><td></td><td></td><td>" + getBaseLang.no1
			+ "</td></tr><tr><td>" + getBaseLang.gst
			+ "</td><td></td><td></td><td></td><td>" + getBaseLang.no2
			+ "</td></tr><tr><td>" + getBaseLang.tototAmount
			+ "</td><td></td><td></td><td></td><td>" + getBaseLang.no3
			+ "</td></tr></tfoot></table>";
	$("#tbodycontid_" + splitbillid + " > tr").each(function() {
		// alert(this.id);
		splitbillids.push(this.id);
	});

	var arrSize=itemSplitList.length;
	alert("item list siez:"+arrSize);
	if(splitbillid>arrSize)
	{
		alert("if");
		for(var i=parseInt(arrSize);i<splitbillid;i++)
		{			
					if(i==splitbillid-1)
					{
						if(itemSplitList[i]!=null && itemSplitList[i]!='A' && Array.isArray(itemSplitList[i].responseData))
						{
							valueToPush = itemSplitList[i];
							if( itemSplitList[i].responseData.length>0)
								{
									for(var j = 0; j<responseData.length; j++)
									{
										for(var k = 0; k< itemSplitList[i].responseData.length; k++)
										{
												if(itemSplitList[i].responseData[k].id==responseData[j].id)
												{
													itemSplitList[i].responseData.splice(k,1);
												}
										}
										itemSplitList[i].responseData.push(responseData[j]);
									}	
								}							
							}
						else{
							valueToPush = {};
							valueToPush.responseData = responseData;
							itemSplitList.splice(i, 1, valueToPush);
						}	
						console.dir(itemSplitList);
					}
					else{
						itemSplitList.splice(i, 0, 'A');
					}
			}
	}
	else
	{
		alert("else");
		for(var i=0;i<splitbillid;i++)
		{
			if(i==splitbillid-1)
			{
				if(itemSplitList[i]!=null && itemSplitList[i]!='A' && Array.isArray(itemSplitList[i].responseData))
				{
					valueToPush = itemSplitList[i];					
					if(itemSplitList[i].responseData.length>0)
					{
						for(var j = 0; j<responseData.length; j++)
						{
							for(var k = 0; k< itemSplitList[i].responseData.length; k++)
							{
								//alert(itemSplitList[i].responseData[k].item.id + " == " + responseData[j].item.id);
									if(itemSplitList[i].responseData[k].id==responseData[j].id)
									{
										itemSplitList[i].responseData.splice(k,1);
									}
							}
							itemSplitList[i].responseData.push(responseData[j]);
						}	
					}
				}
				else{
					valueToPush = {};
					valueToPush.responseData = responseData;
					itemSplitList.splice(i, 1, valueToPush);
				}
				console.dir(itemSplitList);
			}		
		}
	}
		
	//alert(responseData);
	for (var i = 0; i < responseData.length; i++) {
		
		 * $.each( splitbillids, function( index,value ) { alert("value: " +
		 * value ); });
		 
		//var prevTax = parseFloat(document.getElementById('taxdiv_' + splitbillid).innerHTML);
		//var prevSTax = parseFloat(document.getElementById('staxdiv_' + splitbillid).innerHTML);
    //alert(prevTax + " : " + prevSTax);
		var orderitem = responseData[i];
		var disc1 = 0.0;
		var begintrline = "";
		var firsttdline = "";
		var secondtdline = "";
		var thirdtdline = "";
		var trbgColor = "#222222";
		if (splitbillids.length > 0) {
		//alert(splitbillids);
			for (var j = 0; j < splitbillids.length; j++) {
				if (splitbillids[j] == orderitem.id) {
					orderitem.quantityOfItem = parseInt(orderitem.quantityOfItem) + 1;
					subtot = subtot - orderitem.rate * 1;
					$("#tbodycontid_" + splitbillid + " tr#" + orderitem.id)
							.remove();
				}
			}
		}
		// alert(orderitem.id);
		begintrline = "<tr id='" + orderitem.id
				+ "' style='padding:2px;background:#404040'>";
		var hiditemid = "<input type='hidden' id='" + splitbillid + "_"
				+ orderitem.id + "' value='" + orderitem.item.id + "'>";
		// firsttdline="<td style='padding:1px;'>"+(i+1)+"</td>";
		secondtdline = "<td width='50%' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>"
				+ orderitem.item.name + "</td>";
		thirdtdline = "<td valign='middle' align='center' style='padding:3px;'>"
				+ orderitem.quantityOfItem + "</td>";
		var fourthtdline = "<td  style='padding:1px;text-align: center;'>"
				+ parseFloat(orderitem.rate).toFixed(2) + "</td>";
		var fifthtdline = "<td style='padding:1px;text-align: center;'>"
				+ parseFloat(disc1).toFixed(2) + "</td>";
		var sixthtdline = "<td style='padding:1px;text-align: center;'>"
				+ parseFloat(orderitem.rate * orderitem.quantityOfItem - disc1)
						.toFixed(2) + "</td>";
		var seventhhtdline = "<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:deleteItemFromSplitBill("
				+ splitbillid
				+ ","
				+ orderitem.id
				+ ")'><img border='0' alt='' src='"
				+ BASE_URL
				+ "/assets/images/base/d/d_delete.png' height='22' width='18'></a></td>";
		var eighthtdline = "";
		
		 * if(vattaxText.length!=0) { seventhhtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.vat).toFixed(2)+"</td>"; }
		 * if(servicetaxText.length!=0) { eighthtdline="<td style='padding:1px;text-align: center;'>"+parseFloat(orderitem.serviceTax).toFixed(2)+"</td>"; }
		 
		// alert(parseFloat(orderitem.rate*orderitem.quantityOfItem-disc1).toFixed(2));
		subtot += orderitem.rate * orderitem.quantityOfItem - disc1;
		// alert(subtot);
		var endtrline = "</tr>";
		createdrowline += begintrline + hiditemid + secondtdline + thirdtdline
				+ fourthtdline + sixthtdline + seventhhtdline + endtrline;
		//alert(orderitem.vat);
	
	// alert(orderitem.id);
	}	
	
	if (splitsChargFlag == 'Y' && splitsChargRate !=0.00) {

		schargeamt = subtot * splitsChargRate / 100;
	}
	
	if (splitvattaxText.length != 0) 
	{
		for(var i=0; i<itemSplitList.length; i++)
		{
			if(i==splitbillid-1)
			{
				for(var j=0; j<itemSplitList[i].responseData.length; j++)
				{
					//alert(itemSplitList[i].responseData[j].vat + " : " + itemSplitList[i].responseData[j].serviceTax);
					taxamt += ((itemSplitList[i].responseData[j].rate * itemSplitList[i].responseData[j].quantityOfItem - disc1) +((itemSplitList[i].responseData[j].rate * itemSplitList[i].responseData[j].quantityOfItem - disc1) * splitsChargRate / 100))* itemSplitList[i].responseData[j].vat / 100;
				//	taxamt += ((orderitem.rate * orderitem.quantityOfItem - disc1) +((orderitem.rate * orderitem.quantityOfItem - disc1) * splitsChargRate / 100))* orderitem.vat / 100;
				}	
			}
		}
	}

	//alert(subtot + " : " + orderitem.rate);
	if (splitservicetaxText.length != 0) {
		for(var i=0; i<itemSplitList.length; i++)
		{
			if(i==splitbillid-1)
			{
				for(var j=0; j<itemSplitList[i].responseData.length; j++)
				{
					staxamt += ((itemSplitList[i].responseData[j].rate * itemSplitList[i].responseData[j].quantityOfItem - disc1) + ((itemSplitList[i].responseData[j].rate * itemSplitList[i].responseData[j].quantityOfItem - disc1) * splitsChargRate / 100)) * itemSplitList[i].responseData[j].serviceTax / 100;
				//	staxamt += ((orderitem.rate * orderitem.quantityOfItem - disc1) + ((orderitem.rate * orderitem.quantityOfItem - disc1) * splitsChargRate / 100)) * orderitem.serviceTax / 100;
				}	
			}
		}
	}

	// taxamt=subtot*6/100;
	//alert(taxamt + " : " + staxamt);
	grandtot = subtot + schargeamt +  taxamt + staxamt;
	generatedHtml = createdrowline;
	// alert(generatedHtml);
	$("#tbodycontid_" + splitbillid).append(generatedHtml);
	document.getElementById('subtotdiv_' + splitbillid).innerHTML = parseFloat(
			subtot).toFixed(2);
	if (splitsChargFlag == 'Y' && splitsChargRate !=0.00) {
		document.getElementById('schargdiv_' + splitbillid).innerHTML = parseFloat(
				schargeamt).toFixed(2);
	}
	if (splitvattaxText.length != 0) {
		document.getElementById('taxdiv_' + splitbillid).innerHTML = parseFloat(
				taxamt).toFixed(2);
	}
	if (splitservicetaxText.length != 0) {
		document.getElementById('staxdiv_' + splitbillid).innerHTML = parseFloat(
				staxamt).toFixed(2);
	}
	
	if (storeroundoffflag == 'Y') {
		grandtot = Math.round(grandtot);
	}
	//alert("subtot " + subtot + "schargeamt " + schargeamt + "taxamt " + taxamt + "staxamt " + staxamt);
	document.getElementById('grandtotdiv_' + splitbillid).innerHTML = parseFloat(
			grandtot).toFixed(2);
	// document.getElementById('tbodycontid_'+splitbillid).innerHTML=generatedHtml;
}

*/

function preparesplitbillitemListHtmltoBill(responseData) {
	//alert("hfh:"+responseData.length);
	//var totnonspotDiscAmt = document.getElementById('hidtotnonspotDiscAmt').value;
	var discpercentage=document.getElementById('hidendiscountpercentage').value;
	var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
	var splitbillids = [];
	var subtot = 0.0;
	var discountamount = 0.0;
	var totaldiscount = 0.0;
	var netammt = 0.0;
	var subtotalafterdiscount = 0.0;
	var servicechargeammt = 0.0;
	subtot = document.getElementById('subtotdiv_' + splitbillid).innerHTML;
	subtot = parseFloat(subtot);
	//alert("subtot 1:"+subtot);
	var table=document.getElementById("tbl_"+splitbillid); 
	var quantity=1;
	var taxamt = 0.0;
	var staxamt = 0.0;
	var grandtot = 0.0;
	var vattaxableamount = document.getElementById('vattaxableamtdiv_' + splitbillid).innerHTML; //add of the price of items which has vat>0 (new added 7.6.2018)
	var servicetaxableamount = document.getElementById('servicetaxableamtdiv_' + splitbillid).innerHTML; //add of the price of items which has serviceTax>0 (new added 7.6.2018)
	//alert("vattaxableamount:"+vattaxableamount);
	//alert("servicetaxableamount:"+servicetaxableamount);
	var generatedHtml = "";
	var createddiv = "";
	var createdrowline = "";
	var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;'><thead><th>" + getBaseLang.sl + "</th><th>" + getBaseLang.name + "</th><th style='text-align:center;'>" + getBaseLang.qty + "</th><th>" + getBaseLang.rate + "</th><th>" + getBaseLang.tot + "</th><th>" + getBaseLang.action + "</th>";
	var headerline = "<tbody style='color:#fff; padding:1px;' >";
	var endtbody = "</tbody>";
	var footerline = "</tbody><tfoot><tr><td>" + getBaseLang.subTot + "</td><td></td><td></td><td></td><td>" + getBaseLang.no1 + "</td></tr><tr><td>" + getBaseLang.gst + "</td><td></td><td></td><td></td><td>" + getBaseLang.no2 + "</td></tr><tr><td>" + getBaseLang.tototAmount + "</td><td></td><td></td><td></td><td>" + getBaseLang.no3 + "</td></tr></tfoot></table>";
	$("#tbodycontid_" + splitbillid + " > tr").each(function() {		
		splitbillids.push(this.id);
	});

	for ( var i = 0; i < responseData.length; i++) {
		  
		var orderitem = responseData[i];	
		//alert(orderitem.item.vat+"  & "+orderitem.item.serviceTax);
		
		var disc1 = 0.0;
		var begintrline = "";
		var firsttdline = "";
		var secondtdline = "";
		var thirdtdline = "";
		var trbgColor = "#222222";	
		
		
		if (splitbillids.length > 0) {			
			for ( var j = 0; j < splitbillids.length; j++) {				
					
					if (splitbillids[j] == orderitem.id) {	
						
						orderitem.quantityOfItem =parseInt(orderitem.quantityOfItem) + 1;											
						subtot = subtot - ((orderitem.rate * 1)-orderitem.promotionDiscountAmt);
						//alert("subtot in mid:"+subtot);
						for ( var k = 1; k < table.rows.length; k++) {
							var row=table.rows[k];
							//alert("rowid:::"+row.id+"::orderitem.id::"+orderitem.id);
							if(row.id==orderitem.id){
								  quantity= parseInt(table.rows[k].cells[1].innerHTML)+1;
								 
								  //alert("newquantity:"+quantity); //new
							}
						}
                       $("#tbodycontid_" + splitbillid + " tr#" + orderitem.id).remove();
					}
			}
		}
		
		
		 
		 
		    subtot += (orderitem.rate * orderitem.quantityOfItem) - (orderitem.quantityOfItem * orderitem.promotionDiscountAmt);
		    //alert("subtot:"+subtot);
		   
		    //new added strt 7.6.2018
		    if(orderitem.item.vat > 0){
		    	vattaxableamount = Number(vattaxableamount) + Number(((orderitem.rate * orderitem.quantityOfItem) - (orderitem.quantityOfItem * orderitem.promotionDiscountAmt))/orderitem.quantityOfItem); // (vattaxableamt + price of single item)
		    	
		    	//var aa=((orderitem.rate * orderitem.quantityOfItem) - (orderitem.quantityOfItem * orderitem.promotionDiscountAmt))/orderitem.quantityOfItem;
		    	//alert("new item price inside vattax block:"+aa);
		    	//alert("new vattaxableamount:"+vattaxableamount);
		    }
		    else{
		    	vattaxableamount = vattaxableamount;
		    	//alert(" not  vat tax in current item and existing vattaxableamount:"+vattaxableamount);
		       }
		    if(orderitem.item.serviceTax > 0){
		    	servicetaxableamount = Number(servicetaxableamount) + Number(((orderitem.rate * orderitem.quantityOfItem) - (orderitem.quantityOfItem * orderitem.promotionDiscountAmt))/orderitem.quantityOfItem);
		    	//var aa1=((orderitem.rate * orderitem.quantityOfItem) - (orderitem.quantityOfItem * orderitem.promotionDiscountAmt))/orderitem.quantityOfItem;
		    	//alert("new item price inside servicetax block:"+aa1);
		    	//alert("new servicetaxableamount:"+servicetaxableamount);
		    }
		    else{
		    	servicetaxableamount = servicetaxableamount;
		    	//alert("not service tax tax in current item and existing servicetaxableamount:"+servicetaxableamount);
		    }
		  //new added end 7.6.2018
		    
		    
		  	begintrline = "<tr id='" + orderitem.id + "' style='padding:2px;background:#404040'>";
			var hiditemid = "<input type='hidden' id='" + splitbillid + "_" + orderitem.item.id + "' value='" + orderitem.item.id + "'>";
			secondtdline = "<td width='50%' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>" + orderitem.item.name + "</td>";
			thirdtdline = "<td valign='middle' align='center' style='padding:3px;'>" + quantity + "</td>";
			var fourthtdline = "<td  style='padding:1px;text-align: center;'>" + parseFloat(orderitem.rate).toFixed(2) + "</td>";
			var fifthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(disc1).toFixed(2) + "</td>";
			var sixthtdline = "<td style='padding:1px;text-align: center;'>" + parseFloat((orderitem.rate * quantity - disc1)-(orderitem.promotionDiscountAmt*quantity)).toFixed(2) + "</td>";
			// seventhhtdline = "<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:deleteItemFromSplitBill(" + splitbillid + "," + orderitem.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/base/d/d_delete.png' height='22' width='18'></a></td>"; //off 7.6.2018
			var seventhhtdline = "<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:deleteItemFromSplitBill(" + splitbillid + "," + orderitem.id +   ","+ orderitem.rate+ ","+orderitem.item.vat+","+ orderitem.item.serviceTax + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/base/d/d_delete.png' height='22' width='18'></a></td>";
			var promotionvalue = "<td valign='middle' align='center' style='padding:3px;display:none;'>" + orderitem.promotionDiscountAmt + "</td>";
			
			var eighthtdline = "";
			var endtrline = "</tr>";
			createdrowline += begintrline + hiditemid + secondtdline + thirdtdline + fourthtdline + sixthtdline + promotionvalue + seventhhtdline + endtrline;					

	}
	
	//alert("Subtot:"+subtot);
	if(discpercentage != '0' || discpercentage != '0.0'){
	discountamount=(subtot*discpercentage)/100;
	
	//vattaxableamount = Number(vattaxableamount) - Number(discountamount); // new added 7.6.2018
	//servicetaxableamount = Number(servicetaxableamount) - Number(discountamount) //new added 7.6.2018
	
	//subtot=subtot-discountamount; // new added
	//alert("discountamount:"+discountamount);
	}

	subtotalafterdiscount=subtot-discountamount; 
	//alert("subtot2:"+subtot);
	
	if(splitsChargFlag == 'Y'){
		//servicechargeammt =(subtot*splitsChargRate)/100;
		servicechargeammt =(subtotalafterdiscount*splitsChargRate)/100; // new added
		//alert("servicechargeammt:"+servicechargeammt);
		
		//vattaxableamount = Number(vattaxableamount) + Number(servicechargeammt); // new added 7.6.2018
		//servicetaxableamount = Number(servicetaxableamount) + Number(servicechargeammt) //new added 7.6.2018
		
	}
	
	//netammt = (subtot-discountamount+servicechargeammt);
	netammt = (subtotalafterdiscount+servicechargeammt);//new added
	
	//alert("netammt:"+netammt);
	if (splitvattaxText.length != 0) {
		//taxamt = subtot * splitvatAmt / 100; //unused
		//////////// taxamt = netammt * splitvatAmt / 100; //(stop in 7thJune.2018)
		
		//new tax calculation except the item which are without vat  datet 7thJune 2018 strt
		 var servicecgargableamt1 = (vattaxableamount - discountamount);
		 var service_charge_amt1 = 0.0;
		 if(splitsChargFlag == 'Y'){
		  service_charge_amt1 = (servicecgargableamt1*splitsChargRate)/100;
		 }
		 var net_amt1 = servicecgargableamt1 + service_charge_amt1;
		 taxamt = net_amt1 * splitvatAmt / 100;
		 if(taxamt<0){taxamt = 0.0;}
	   
		 //new tax calculation except the item which are without vat  datet 7thJune 2018 end
		
		 // alert("taxamt:"+taxamt);
	}
	if (splitservicetaxText.length != 0) {
		//staxamt = subtot * splitstaxAmt / 100;
		////////////staxamt = netammt * splitstaxAmt / 100;//(stop in 7thJune.2018)
		
		//new tax calculation except the item which are without  servicetax datet 7thJune 2018 strt
		 var servicecgargableamt2 = (servicetaxableamount - discountamount);
		 var service_charge_amt2 = 0.0;
		 if(splitsChargFlag == 'Y'){
		  service_charge_amt2 = (servicecgargableamt2*splitsChargRate)/100;
		 }		 
		 var net_amt2 = servicecgargableamt2 + service_charge_amt2;
		 staxamt = net_amt2 * splitstaxAmt / 100;
		 if(staxamt<0){staxamt = 0.0;}
	 
		//new tax calculation except the item which are without  servicetax datet 7thJune 2018 end
		
		
		//alert("staxamt:"+staxamt);
		
	}	
	grandtot = (netammt + taxamt + staxamt);
	//alert("grandtot:"+grandtot);
	generatedHtml = createdrowline;
	$("#tbodycontid_" + splitbillid).append(generatedHtml);
	document.getElementById('subtotdiv_' + splitbillid).innerHTML = parseFloat(subtot).toFixed(2);
	if (splitvattaxText.length != 0) {
		document.getElementById('taxdiv_' + splitbillid).innerHTML = parseFloat(taxamt).toFixed(2);
	}
	if (splitservicetaxText.length != 0) {
		document.getElementById('staxdiv_' + splitbillid).innerHTML = parseFloat(staxamt).toFixed(2);
	}
	
	if (splitsChargFlag == 'Y') {
		document.getElementById('schargdiv_' + splitbillid).innerHTML = parseFloat(servicechargeammt).toFixed(2);
	}
	
	
	document.getElementById('discountdiv_' + splitbillid).innerHTML = parseFloat(discountamount).toFixed(2);
	if (storeroundoffflag == 'Y') {
		grandtot = Math.round(grandtot);
	}
	document.getElementById('grandtotdiv_' + splitbillid).innerHTML = parseFloat(grandtot).toFixed(2);
	
	// new added strt 7.6.2018
	document.getElementById('vattaxableamtdiv_' + splitbillid).innerHTML = parseFloat(vattaxableamount).toFixed(2);
	document.getElementById('servicetaxableamtdiv_' + splitbillid).innerHTML = parseFloat(servicetaxableamount).toFixed(2);
	// new added end 7.6.2018
	
	
}



/*function preparesplitbillitemListHtmltoBillDelete(billid, deleteitemid) {
	// alert('in delete:'+billid+':'+deleteitemid);
	// alert($("#tbodycontid_"+billid +"
	// tr#"+deleteitemid).find('td:eq(3)').html());
	//var prevTax = parseFloat(document.getElementById('taxdiv_' + billid).innerHTML);
	//var prevSTax = parseFloat(document.getElementById('staxdiv_' + billid).innerHTML);
	
	var deleteditemcost = 0.0;
	var deleteditemqty = $("#tbodycontid_" + billid + " tr#" + deleteitemid)
			.find('td:eq(1)').html();
	var deleteditemrate = $("#tbodycontid_" + billid + " tr#" + deleteitemid)
			.find('td:eq(2)').html();
	// deleteditemcost=$("#tbodycontid_"+billid +"
	// tr#"+deleteitemid).find('td:eq(3)').html();

	if (deleteditemqty > 1) {
		deleteditemqty = deleteditemqty - 1;
		$("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(1)')
				.html(deleteditemqty);
		$("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(3)')
				.html(parseFloat(deleteditemqty * deleteditemrate).toFixed(2));
	} else {
		$("#tbodycontid_" + billid + " tr#" + deleteitemid).remove();
	}
	
    //console.dir(itemSplitList);
    
	var arrSize=itemSplitList.length;
		for(var i=billid-1;i<arrSize;i++)
		{			
					if(i==billid-1)
					{
						if(itemSplitList[i]!=null && itemSplitList[i]!='A' && Array.isArray(itemSplitList[i].responseData))
						{
						//	alert('count + ' + itemSplitList[i].responseData.length);
							if( itemSplitList[i].responseData.length>0)
								{
									for(var j = 0; j<itemSplitList[i].responseData.length; j++)
									{
										if(itemSplitList[i].responseData[j].id==deleteitemid)
										{
											
											if(itemSplitList[i].responseData[j].quantityOfItem=="1")
												{
												itemSplitList[i].responseData.splice(j, 1);
												}
											else
												{
												--itemSplitList[i].responseData[j].quantityOfItem;
												itemSplitList[i].responseData[j].totalPriceByItem=parseFloat(itemSplitList[i].responseData[j].rate*itemSplitList[i].responseData[j].quantityOfItem);
												}
										}										
									}	
								}							
							}
						if(itemSplitList[i].responseData.length==0)
							{
							itemSplitList.splice(i, 1, 'A');
							}
						console.dir(itemSplitList);
					}
			}
	
	
	var subtot = 0.0;
	var taxamt = 0.0;
	var staxamt = 0.0;
	var grandtot = 0.0;
	var schargeamt = 0.0;
	var disc1 = 0.0;
	subtot = document.getElementById('subtotdiv_' + billid).innerHTML;
	subtot = parseFloat(subtot);
	subtot = subtot - parseInt(deleteditemrate);
	
//	   var ajaxCallObject = new CustomBrowserXMLObject();
//		ajaxCallObject.callAjax(BASE_URL + "/menumgnt/getItemDetailsById/" + deleteitemid +"/"+ storeID  + ".htm", function(response) {
//			var  orderitem=JSON.parse(response);
		//	console.log(orderitem);
			
			//alert(subtot);
				if (splitsChargFlag == 'Y' && splitsChargRate !=0.00) {

					schargeamt += subtot * splitsChargRate / 100;
				}
			//	alert(schargeamt);
			//	alert('gg1:'+ prevTax + " : " + orderitem.price + " : " + splitsChargRate + " : " + orderitem.vat);
//				if (splitvattaxText.length != 0) {
//					taxamt += prevTax - (((orderitem.price * 1 - disc1) +((orderitem.price * 1 - disc1) * splitsChargRate / 100))* orderitem.vat / 100);		
//				//	alert(taxamt);
//				}
//				
//				if (splitservicetaxText.length != 0) {
//					staxamt += prevSTax - (((orderitem.price * 1 - disc1) + ((orderitem.price * 1 - disc1) * splitsChargRate / 100)) * orderitem.serviceTax / 100);
//					//   alert('gg2:'+ taxamt + staxamt);
//				}
		
				if (splitvattaxText.length != 0) 
				{
					for(var i=0; i<itemSplitList.length; i++)
					{
						if(i==billid-1)
						{
							if(itemSplitList[i]!=null && itemSplitList[i]!='A' && Array.isArray(itemSplitList[i].responseData))
							{
							for(var j=0; j<itemSplitList[i].responseData.length; j++)
							{
							//	alert(itemSplitList[i].responseData.length);
								//alert(itemSplitList[i].responseData[j].vat + " : " + itemSplitList[i].responseData[j].serviceTax);
								taxamt += ((itemSplitList[i].responseData[j].rate * itemSplitList[i].responseData[j].quantityOfItem - disc1) +((itemSplitList[i].responseData[j].rate * itemSplitList[i].responseData[j].quantityOfItem - disc1) * splitsChargRate / 100))* itemSplitList[i].responseData[j].vat / 100;
							//	taxamt += ((orderitem.rate * orderitem.quantityOfItem - disc1) +((orderitem.rate * orderitem.quantityOfItem - disc1) * splitsChargRate / 100))* orderitem.vat / 100;
							}
							}
						}
					}
				}
			//	alert(itemSplitList[1].responseData.length);
				//alert(subtot + " : " + orderitem.rate);
				if (splitservicetaxText.length != 0) {
					for(var i=0; i<itemSplitList.length; i++)
					{
						if(i==billid-1)
						{
							if(itemSplitList[i]!=null && itemSplitList[i]!='A' && Array.isArray(itemSplitList[i].responseData))
							{
							for(var j=0; j<itemSplitList[i].responseData.length; j++)
							{
								staxamt += ((itemSplitList[i].responseData[j].rate * itemSplitList[i].responseData[j].quantityOfItem - disc1) + ((itemSplitList[i].responseData[j].rate * itemSplitList[i].responseData[j].quantityOfItem - disc1) * splitsChargRate / 100)) * itemSplitList[i].responseData[j].serviceTax / 100;
							//	staxamt += ((orderitem.rate * orderitem.quantityOfItem - disc1) + ((orderitem.rate * orderitem.quantityOfItem - disc1) * splitsChargRate / 100)) * orderitem.serviceTax / 100;
							}
							}
						}
					}
				}
				
				
     //alert('gg3:'+ subtot);

//	if (splitvattaxText.length != 0) {
//		taxamt = subtot * splitvatAmt / 100;
//	}
//	if (splitservicetaxText.length != 0) {
//		staxamt = subtot * splitstaxAmt / 100;
//	}
	// taxamt=subtot*6/100;
				if(subtot==0)
					{
					schargeamt='0.00';
					taxamt='0.00';
					staxamt='0.00';
					grandtot='0.00';
					}
				else{
					grandtot = subtot + schargeamt + taxamt + staxamt;
				}
				
				
				var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
				if (storeroundoffflag == 'Y') {
					grandtot = Math.round(grandtot);
				}
				//alert("subtot " + subtot + "schargeamt " + schargeamt + "taxamt " + taxamt + "staxamt " + staxamt);
	if (splitsChargFlag == 'Y' && splitsChargRate !=0.00) {
		document.getElementById('schargdiv_' + billid).innerHTML = parseFloat(
				schargeamt).toFixed(2);
	}
	document.getElementById('subtotdiv_' + billid).innerHTML = parseFloat(
			subtot).toFixed(2);
	if (splitvattaxText.length != 0) {
		document.getElementById('taxdiv_' + billid).innerHTML = parseFloat(
				taxamt).toFixed(2);
	}
	if (splitservicetaxText.length != 0) {
		document.getElementById('staxdiv_' + billid).innerHTML = parseFloat(
				staxamt).toFixed(2);
	}
	// document.getElementById('taxdiv_'+billid).innerHTML=parseFloat(taxamt).toFixed(2);
	document.getElementById('grandtotdiv_' + billid).innerHTML = parseFloat(
			grandtot).toFixed(2);
	
	//	}, null);
}

*/

function preparesplitbillitemListHtmltoBillDelete(	billid,
		deleteitemid , rate , vat , servicetax) {  // changed 7.6.2018
 //alert('in delete:'+billid+':'+deleteitemid);
// alert($("#tbodycontid_"+billid +"
// tr#"+deleteitemid).find('td:eq(3)').html());
var discpercentage=document.getElementById('hidendiscountpercentage').value;
var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').valu
var deleteditemcost = 0.0;
var deleteditemqty = $("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(1)').html();
var deleteditemrate = $("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(2)').html();
var promotionalvalue = $("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(4)').html();
//alert("promotionalvalue::"+promotionalvalue);
// deleteditemcost=$("#tbodycontid_"+billid +"
// tr#"+deleteitemid).find('td:eq(3)').html();

if (deleteditemqty > 1) {
deleteditemqty = deleteditemqty - 1;
$("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(1)').html(deleteditemqty);
$("#tbodycontid_" + billid + " tr#" + deleteitemid).find('td:eq(3)').html(parseFloat((deleteditemqty * deleteditemrate)-(deleteditemqty * promotionalvalue)).toFixed(2));
} else {
$("#tbodycontid_" + billid + " tr#" + deleteitemid).remove();
}

// alert('gg:'+deleteditemcost);
var subtot = 0.0;
var taxamt = 0.0;
var staxamt = 0.0;
var grandtot = 0.0;
var scharge = 0.0;
var discount = 0.0;
var taxableamt = 0.0;
var afterdiscountamt = 0.0;

subtot = document.getElementById('subtotdiv_' + billid).innerHTML;
subtot = parseFloat(subtot);

//new added 7.6.2018 strt
   var pastvat= 0.0;
   if(splitvattaxText.length != 0){
     pastvat= document.getElementById('taxdiv_' + billid).innerHTML;
     pastvat = parseFloat(pastvat);
     //alert("pastvat::"+pastvat);
     }
   
   var paststax = 0.0;
   if(splitservicetaxText.length != 0){
    paststax = document.getElementById('staxdiv_' + billid).innerHTML;
    paststax = parseFloat(paststax);
    //alert("paststax:"+paststax);
    }
    
    var pastdiscountamt = 0.0;
    pastdiscountamt= document.getElementById('discountdiv_' + billid).innerHTML;
    pastdiscountamt = parseFloat(pastdiscountamt);
   // alert("pastdiscountamt:"+pastdiscountamt);
  
    var pastschargeamt = 0.0;
    if(splitsChargFlag == 'Y'){
    pastschargeamt = document.getElementById('schargdiv_' + billid).innerHTML;
    pastschargeamt = parseFloat(pastschargeamt);
    //alert("pastschargeamt="+pastschargeamt);
     }
   
    var pastgrandtotal = 0.0;
    pastgrandtotal = document.getElementById('grandtotdiv_' + billid).innerHTML;
    pastgrandtotal = parseFloat(pastgrandtotal);
    //alert("pastgrandtotal="+pastgrandtotal);
    
    var pastvattaxableamt = 0.0;
    pastvattaxableamt = document.getElementById('vattaxableamtdiv_' + billid).innerHTML;
    pastvattaxableamt =parseFloat(pastvattaxableamt);
    
    var pastservicetaxableamt = 0.0;
    pastservicetaxableamt = document.getElementById('servicetaxableamtdiv_' + billid).innerHTML;
    pastservicetaxableamt = parseFloat(pastservicetaxableamt);
    
    
    
    
   subtot = Number(subtot) - Number(deleteditemrate);
   if(subtot<0){subtot=0.00;}
   
   // Discount Calculation deleted item start
   if(discpercentage != '0' || discpercentage !='0.0'){
		   discount = (Number(deleteditemrate) * Number(discpercentage))/100;
		   //alert("Discount on rate:"+discount);
		   if(discount < 0){
			  discount = 0.00;
		   }	
		  
		  pastdiscountamt = parseFloat(Number(pastdiscountamt) - Number(discount)).toFixed(2);
		  //alert("Current  pastdiscountamt:"+ pastdiscountamt);
		  if(pastdiscountamt < 0 || subtot == 0.00 ){
			  pastdiscountamt = 0.00;
			 // alert("Current  pastdiscountamt set 0:"+ pastdiscountamt);
			  }
		  
	}
   afterdiscountamt = Number(deleteditemrate) - Number(discount);
  // Discount Calculation deleted item end
    
   
 // Service Charge Calculation on deleted item start
   if(splitsChargFlag == 'Y'){
		scharge=(Number(afterdiscountamt) * Number(splitsChargRate)) / 100;
		//alert("scharge on rate:"+ scharge);
		    if(scharge < 0){
		    	scharge = 0.00;
		    }
		    pastschargeamt = parseFloat(Number(pastschargeamt) - Number(scharge)).toFixed(2);
		    //alert("Current  pastschargeamt:"+ pastschargeamt);
		    if(pastschargeamt < 0 || subtot == 0.00){
		    	pastschargeamt = 0.00;
		    	 //alert("Current  pastschargeamt set 0:"+ pastschargeamt);
		    	
		    	}
	}

// Service Charge Calculation on deleted item end
   taxableamt = Number(afterdiscountamt) + Number(scharge);
   //alert("taxableamt on rate:::"+taxableamt);
 //Vat tax calculation on deleted item start
   
   if(vat > 0){
		if (splitvattaxText.length != 0) {
			taxamt = parseFloat(Number(taxableamt) * Number(splitvatAmt) / 100).toFixed(2);
			//alert("VTAX on Rate:"+taxamt);
			pastvat = parseFloat(Number(pastvat) - Number(taxamt)).toFixed(2);
			//alert("Current pastvat:"+pastvat);
			//taxamt = pastvat;
			if(pastvat <0){
				 pastvat=0.00;
				 //alert("Current  pastvat set 0:"+ pastvat);
				
				
			}
			}
		pastvattaxableamt = parseFloat(Number(pastvattaxableamt) - Number(deleteditemrate)).toFixed(2);
		//alert("updated past vat taxable amt:"+pastvattaxableamt);
		
		if(pastvattaxableamt < 0){pastvattaxableamt = 0.0;}
		}
 //Vat tax calculation on deleted item end 
   
  //Service Tax clculation on deleted item start
   if(servicetax > 0){
		if (splitservicetaxText.length != 0) {
			staxamt = parseFloat(Number(taxableamt) * Number(splitstaxAmt) / 100).toFixed(2);
			//alert("Service Tax on Rate:"+staxamt);
			paststax = parseFloat(Number(paststax) - Number(staxamt)).toFixed(2);
			//alert("Updated Past s tax amt:"+paststax);
			//staxamt = paststax;
			if(paststax <0){paststax=0.00;}
			}
		pastservicetaxableamt =parseFloat(Number(pastservicetaxableamt) - Number(deleteditemrate)).toFixed(2);
		//alert("updated past s taxable amt:"+pastservicetaxableamt);
		if(pastservicetaxableamt<0){pastservicetaxableamt = 0.0;}
	}
   
 //Service Tax clculation on deleted item end   
   grandtot = parseFloat(Number(taxableamt) + Number(taxamt) + Number(staxamt)).toFixed(2);
   //alert("Grand Total on Rate:"+grandtot);
   
   pastgrandtotal = parseFloat(Number(pastgrandtotal) - Number(grandtot)).toFixed(2);
  // alert("Updated Past Grand Total:"+pastgrandtotal);
   
   if(pastgrandtotal < 0){pastgrandtotal = 0.00;}
   
   if(subtot == 0.00){
		pastvat = 0.00;
		paststax = 0.00;
		pastgrandtotal = 0.00;
		pastschargeamt = 0.00;
		pastdiscountamt = 0.00;
		pastservicetaxableamt = 0.00;
		pastvattaxableamt = 0.00;
		//alert("Sub tot 0 and set all 0");
	}
   
   
   if (storeroundoffflag == 'Y') {
	   pastgrandtotal = Math.round(pastgrandtotal);
	}
   
    document.getElementById('subtotdiv_' + billid).innerHTML = parseFloat(subtot).toFixed(2);
	
    if (splitvattaxText.length != 0) {
		document.getElementById('taxdiv_' + billid).innerHTML = parseFloat(pastvat).toFixed(2);
	}
	
    if (splitservicetaxText.length != 0) {
		document.getElementById('staxdiv_' + billid).innerHTML = parseFloat(paststax).toFixed(2);
	}
	 
    if(splitsChargFlag == 'Y'){
	document.getElementById('schargdiv_' + billid).innerHTML = parseFloat( pastschargeamt).toFixed(2);
	 }
	 
    document.getElementById('discountdiv_' + billid).innerHTML = parseFloat(pastdiscountamt).toFixed(2);
	 
	
	document.getElementById('grandtotdiv_' + billid).innerHTML = parseFloat(pastgrandtotal).toFixed(2);

	document.getElementById('vattaxableamtdiv_' + billid).innerHTML = pastvattaxableamt;
	document.getElementById('servicetaxableamtdiv_' + billid).innerHTML = pastservicetaxableamt;
	



/*
 * 
 * past code off in 7.6.2018
if(splitsChargFlag == 'Y'){
	scharge=(subtot*splitsChargRate)/100;
	    if(scharge < 0){
	    	scharge = 0.00;
	    }
	document.getElementById('schargdiv_' + billid).innerHTML = parseFloat(scharge).toFixed(2);
	
}

if(discpercentage != '0' || discpercentage !='0.0'){
	discount = (subtot*discpercentage)/100;
	
	  if(discount < 0){
		  discount = 0.00;
	  }	
}
document.getElementById('discountdiv_' + billid).innerHTML = parseFloat(discount).toFixed(2);
netammt = subtot - discount + scharge;
//alert("netammt:"+netammt);

if (splitvattaxText.length != 0) {
taxamt = netammt * splitvatAmt / 100;
//alert("taxamt:"+taxamt);
}
if (splitservicetaxText.length != 0) {
staxamt = netammt * splitstaxAmt / 100;
//alert("staxamt:"+staxamt);
}
// taxamt=subtot*6/100;
grandtot = netammt + taxamt + staxamt;
//alert("grandtot:"+grandtot);
*/


}










function submitSpliBill(noofbill, storeid) {
	var SpliBill = [];
	// var noofPax=document.getElementById('noofPaxId').innerHTML;
	var billsplittype = $('input:radio[name=radioGroup]:checked').val();
	if (billsplittype == 1) {
		// itemwise

		var rowlen = 0;
		var orderid = document.getElementById('splitbillmodOrderCont').innerHTML;
		for (var i = 1; i <= noofbill; i++) {
			// rowlen=$("#tbodycontid_"+i+" tr").length;
			if ($("#tbodycontid_" + i + " tr").length == 0) {
				rowlen = i;
			}
			$("#tbodycontid_" + i + " > tr")
					.each(
							function() {

								var biilamt = 0.0;
								var SpliBillObj = {};
								SpliBillObj.billId = document
										.getElementById('splitbillId').value;
								SpliBillObj.orderId = document
										.getElementById('splitbillmodOrderCont').innerHTML;
								SpliBillObj.billNo = i;
								SpliBillObj.itemId = $(this).find(
										'input[type="hidden"]').val();
								SpliBillObj.itemName = $(this).find('td:eq(0)')
										.html();
								SpliBillObj.totalBillNo = noofbill;
								SpliBillObj.itemQuantity = $(this).find(
										'td:eq(1)').html();
								SpliBillObj.itemRate = $(this).find('td:eq(2)')
										.html();
								SpliBillObj.billAmount = $(this).find(
										'td:eq(3)').html();
								var d = new Date();
								SpliBillObj.creationDate = ("0" + d.getDate())
										.slice(-2)
										+ "-"
										+ ("0" + (d.getMonth() + 1)).slice(-2)
										+ "-" + d.getFullYear();
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
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/validatesplitbill.htm",
						function(response) {
							try {
								if (response > 0) {
									$('#splitbillalertMsg')
											.html(
													'<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>'
															+ response
															+ getBaseLang.itemRmbrToAdd);
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
										$
												.ajax({
													url : BASE_URL
															+ "/order/submitsplitbillfors01.htm",
													type : 'POST',
													contentType : 'application/json;charset=utf-8',
													data : JSON
															.stringify(SpliBill),
													success : function(response) {
														// called when
														// successful
														if (response == 'success') {

															SpliBillcatwise = [];
															hidesplitBillModal();
															var ajaxCallObject = new CustomBrowserXMLObject();
															ajaxCallObject
																	.callAjax(
																			BASE_URL
																					+ "/order/printsplitbill/"
																					+ orderid
																					+ ".htm",
																			function(
																					response) {
																				try {
																					if (response == 'Success')
																						showBillPrintSuccessModal();
																				} catch (e) {
																					alert(e);
																				}
																			},
																			null);
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
										$('#splitbillalertMsg')
												.html(
														'<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>'
																+ getBaseLang.plsAddItems
																+ ' '
																+ rowlen
																+ '!</strong> </div>');
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
		for (var i = 1; i <= noofbill; i++) {
			// rowlen=$("#tbodycontid_"+i+" tr").length;
			if ($("#tbodycontid_" + i + " tr").length == 0) {
				rowlen = i;
			}
			$("#tbodycontid_" + i + " > tr")
					.each(
							function() {
								var biilamt = 0.0;
								var SpliBillObj = {};
								SpliBillObj.billId = document
										.getElementById('splitbillId').value;
								SpliBillObj.orderId = document
										.getElementById('splitbillmodOrderCont').innerHTML;
								SpliBillObj.billNo = i;
								SpliBillObj.categoryId = $(this).find(
										'input[type="hidden"]').val();
								console.log("SpliBillObj.categoryId="
										+ SpliBillObj.categoryId);
								SpliBillObj.itemId = this.id;
								SpliBillObj.itemName = $(this).find('td:eq(0)')
										.html().split("##")[0];
								SpliBillObj.totalBillNo = noofbill;
								SpliBillObj.itemQuantity = $(this).find(
										'td:eq(1)').html();
								SpliBillObj.itemRate = $(this).find('td:eq(2)')
										.html();
								SpliBillObj.billAmount = $(this).find(
										'td:eq(3)').html();
								var d = new Date();
								SpliBillObj.creationDate = ("0" + d.getDate())
										.slice(-2)
										+ "-"
										+ ("0" + (d.getMonth() + 1)).slice(-2)
										+ "-" + d.getFullYear();
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
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/validatesplitbillcatwise.htm",
						function(response) {
							try {
								if (response > 0) {
									$('#splitbillalertMsg')
											.html(
													'<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>'
															+ response
															+ ' '
															+ getBaseLang.catRemToAdd
															+ '</strong> </div>');
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
										$
												.ajax({
													url : BASE_URL
															+ "/order/submitsplitbillfors01.htm",
													type : 'POST',
													contentType : 'application/json;charset=utf-8',
													data : JSON
															.stringify(SpliBill),
													success : function(response) {
														// called when
														// successful
														if (response == 'success') {

															SpliBillcatwise = [];
															hidesplitBillModal();
															var ajaxCallObject = new CustomBrowserXMLObject();
															ajaxCallObject
																	.callAjax(
																			BASE_URL
																					+ "/order/printsplitbill/"
																					+ orderid
																					+ ".htm",
																			function(
																					response) {
																				try {
																					if (response == 'Success')
																						showBillPrintSuccessModal();
																				} catch (e) {
																					alert(e);
																				}
																			},
																			null);
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
										$('#splitbillalertMsg')
												.html(
														'<div class="alert alert-danger"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a> <strong>'
																+ getBaseLang.plsAddItems
																+ rowlen
																+ '!</strong> </div>');
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
	ajaxCallObject
			.callAjax(
					BASE_URL + "/order/getbillwiseitemlist/" + orderno + ".htm",
					function(response) {
						try {
							var responseObj = JSON.parse(response);
							console.log(responseObj);
							if (responseObj.length > 0) {
								var lastbillamttopay = 0.00;
								for (var i = 0; i < responseObj.length; i++) {
									console.log(responseObj[i].billNo);
									console
											.log(responseObj[i].billSplitManuals.length);

									var amttopay = 0.00;

									for (var j = 0; j < responseObj[i].billSplitManuals.length; j++) {
										var billSplitManual = responseObj[i].billSplitManuals[j];
										var itemamt = billSplitManual.itemQuantity
												* billSplitManual.itemRate;
										var taxamt = itemamt * 6 / 100;
										amttopay = amttopay + itemamt + taxamt;

									}
									lastbillamttopay = lastbillamttopay
											+ amttopay;
									if (i == responseObj.length - 1) {
										lastbillamttopay = totalbillamt
												- lastbillamttopay;
										amttopay = round(amttopay, 2)
												+ lastbillamttopay;
									}
									var radioBtn = $('<label class="radio-inline"><input type="radio" name="cashmodSplitPayment" value="'
											+ responseObj[i].billNo
											+ "&"
											+ round(amttopay, 1)
											+ '" style="transform: scale(2.0);-webkit-transform: scale(2.0);">Bill No. '
											+ responseObj[i].billNo
											+ '</label>');
									radioBtn
											.appendTo('#cashmodSplitPaymentBody');

								}
								$("input:radio[name=cashmodSplitPayment]")
										.click(
												function() {
													$("#splitPaymentBtn")
															.removeClass(
																	"active")
															.addClass(
																	"disabled");
													$(
															'#cashmodSplitPaymentBodyAmountDetails')
															.html('');
													$('#splitpaycashalertMsg')
															.text('');
													var value = $(this).val();
													var newval = value
															.split("&");
													var dynamictext = '<br/>PAY FOR BILL NO. '
															+ newval[0]
															+ '<div style="padding: 5px;">'
															+ getBaseLang.amountToPay
															+ '&nbsp;&nbsp;&nbsp;<span id="splitpaymentamttopaycontId">'
															+ newval[1]
															+ '</span> </div>'
															+ '<div style="padding: 3px;">'
															+ getBaseLang.tndrAmount
															+ '&nbsp;&nbsp;&nbsp; :&nbsp;<input type="text" onkeyup="javascript:getChangeAmtForSplit(this.value)" id="splitpaymenttenderAmt" style="text-align:center; color: #222222" size="4"/> </div>'
															+ '<div style="padding: 5px;">'
															+ getBaseLang.changeAmount
															+ ' :&nbsp;<span id="cashchangeamtsplitpaymentcontId">0.00</span> </div>'
															+ ' <div align="center" style=";font-size: 20px;">'

															+ '<table class="ui-bar-a" id="n_keypad_sppay" style="display: none; -khtml-user-select: none;">'
															+ '<tr>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero100_sppay"><img src="'
															+ BASE_URL
															+ '/assets/images/base/payment/rm100.png" /></a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero7_sppay">7</a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero8_sppay">8</a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero9_sppay">9</a></td>'
															+ '<td><a data-role="button" data-theme="e" style="border: 2px solid #404040;" class="btn btn-danger btn-lg" id="del_sppay">x</a></td>'
															+ '</tr>'
															+ '<tr>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero50_sppay"><img src="'
															+ BASE_URL
															+ '/assets/images/base/payment/rm50.png" /></a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero4_sppay">4</a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero5_sppay">5</a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero6_sppay">6</a></td>'
															+ '<td><a data-role="button" data-theme="e" style="border: 2px solid #404040;" class="btn btn-warning btn-lg" id="clear_sppay">c</a></td>'
															+ '</tr>'
															+ '<tr>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero20_sppay"><img src="'
															+ BASE_URL
															+ '/assets/images/base/payment/rm20.png" /></a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero1_sppay">1</a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero2_sppay">2</a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numero3_sppay">3</a></td>'
															+ '<td><a data-role="button" data-theme="e" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="numerodot_sppay">&nbsp;.</a></td>'
															+ '</tr>'
															+ '<tr>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numero10_sppay"><img src="'
															+ BASE_URL
															+ '/assets/images/base/payment/rm10.png" /></a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;padding: 0 0;" class="btn btn-primary btn-lg" id="numerorm5_sppay"><img src="'
															+ BASE_URL
															+ '/assets/images/base/payment/rm5.png" /></a></td>'
															+ '<td><a data-role="button" data-theme="b" style="border: 2px solid #404040;" class="btn btn-primary btn-lg" id="zero_sppay">0</a></td>'
															+ '<td colspan="4"><a data-role="button" style="border: 2px solid #404040;width: 184px;" data-theme="done" class="btn btn-success btn-lg" id="done_sppay">'
															+ getBaseLang.done
															+ '</a></td>'
															+ '</tr>'
															+ '</table>'
															+ '</div>';

													$(
															'#cashmodSplitPaymentBodyAmountDetails')
															.html(dynamictext);
												});

							} else {
								$('#cashmodSplitPaymentBodyAmountDetails')
										.html(getBaseLang.orderSplited);
							}

						} catch (e) {
							alert(e);
						}
					}, null);
	showSplitPaymentCashModal();
}
var originalamount = 0.00;
/*function paySplitAmtByCash() {

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
		remainingamt = Number(totalbillamt)
				- (Number(originalamount) + Number(amttopay));
	}
     alert("orderno:"+orderno+"amttopay:: "+amttopay+"tenderamt::"+tenderAmt+"totalbillamt::"+totalbillamt+"remaining::"+remainingamt);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/order/orderpayment/" + orderno + "/"
							+ totalbillamt + "/" + Number(amttopay) + "/"
							+ remainingamt + "/" + tenderAmt + "/" + "cash"
							+ "/" + "000" + ".htm",
					function(response) {
						try {
							if (response == 'success') {
								$('#splitpaycashalertMsg').text(
										getBaseLang.pamtDone
												+ billno.split("&")[0]);
								originalamount = originalamount
										+ Number(amttopay);
								if (originalamount >= Number(totalbillamt)) {
									if (storeID == '37' || storeID == '38') {
										hideSplitPaymentCashModal();
										document
												.getElementById('cashamttopaymodcontId').innerHTML = parseFloat(
												amttopay).toFixed(2);
										document
												.getElementById('cashtenderAmtmodcontId').innerHTML = parseFloat(
												tenderAmt).toFixed(2);
										document
												.getElementById('cashchangeamtmodcontId').innerHTML = parseFloat(
												changeamt).toFixed(2);
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
*/
function paySplitAmtByCash() {

	var orderno = document.getElementById('orderNo').value;
	var amttopay = $('#splitpaymentamttopaycontId').text();
	var tenderAmt = $('#splitpaymenttenderAmt').val();
	var changeamt = Number(tenderAmt) - Number(amttopay);
	var billno = $('input:radio[name=cashmodSplitPayment]:checked').val();
	var totalbillamt = round($("#amttopaycontId").text(), 1);
	var remainingamt = 0.00;
	
	var discountpercentage = document.getElementById('hidendiscountpercentage').value;
	var itemtotal=document.getElementById('subtotalcontId').innerHTML;
	var grossamount = (100 * Number(itemtotal))/(100-Number(discountpercentage));
     // alert(totalbillamt);
	//alert("discountpercentage:"+discountpercentage+"itemtotal:"+itemtotal);
	
	
	if (originalamount == 0.00) {
		remainingamt = Number(totalbillamt) - Number(amttopay);
	} else {
		// remainingamt=Number(originalamount)-Number(amttopay);
		remainingamt = Number(totalbillamt)
				- (Number(originalamount) + Number(amttopay));
	}
    // alert("orderno:"+orderno+"amttopay:: "+amttopay+"tenderamt::"+tenderAmt+"totalbillamt::"+totalbillamt+"remaining::"+remainingamt);
	
     var payment1={};
	 var order={};
     var orderBill={};

	order.id=orderno;
    orderBill.grossAmt=grossamount.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];
	order.orderBill=orderBill;
   //alert(netTotal+ "------" +payableamount );
	
			payment1.amount=totalbillamt;
			payment1.paidAmount=amttopay;
			payment1.amountToPay=remainingamt;
			payment1.tenderAmount=tenderAmt;
		
		payment1.orderPayment=order;
		payment1.paymentMode="cash";
		payment1.cardLastFourDigits="0000";
		payment1.source="web";
		payment1.remarks="nil";
		payment1.tipsAmount="0.00";     
		/*if(is_Acc=="Y")
		{
		    var sale_ledger_id = parseInt($('#sales_ledger_idf').val());
			var duties_ledger_id = parseInt($('#duties_ledger_idf').val());
			var round_ledger_id = parseInt($('#round_ledger_idf').val());
			var discount_ledger_id = parseInt($('#discount_ledger_idf').val());
			var debitor_cash_ledger_id= parseInt($('#debitor_cahs_ledger_idf').val());
		    var service_charge_ledger_id=parseInt($('#service_charge_ledger_idf').val());
		    var card_ledger_id=parseInt($('#card_ledger_idf').val());


		  if(sale_ledger_id<=0 || duties_ledger_id<= 0 || round_ledger_id<=0 || discount_ledger_id<=0 || debitor_cash_ledger_id<=0 || service_charge_ledger_id<=0 || card_ledger_id<=0) {
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
				  payment1.discAmt=disAmt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.taxVatAmt=total_tax_amt.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;
				  payment1.serviceChargeAmt=scharge.toString().match(/^-?\d+(?:\.\d{0,2})?/)[0];;


			}
		}
		
*/		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjaxPost(BASE_URL + "/order/orderpayment.htm?orderno=" + orderno,
						 payment1,
			   function(response) {
				try {
					if (response == 'success') {
						$('#splitpaycashalertMsg').text(
								getBaseLang.pamtDone
										+ billno.split("&")[0]);
						originalamount = originalamount
								+ Number(amttopay);
						if (originalamount >= Number(totalbillamt)) {
							if (storeID == '37' || storeID == '38') {
								hideSplitPaymentCashModal();
								document
										.getElementById('cashamttopaymodcontId').innerHTML = parseFloat(
										amttopay).toFixed(2);
								document
										.getElementById('cashtenderAmtmodcontId').innerHTML = parseFloat(
										tenderAmt).toFixed(2);
								document
										.getElementById('cashchangeamtmodcontId').innerHTML = parseFloat(
										changeamt).toFixed(2);
								showCashChangeAmtModal();
							}
							// location.href=BASE_URL+'/table/viewtable.htm';
						}
					
					
					
					}
					/*if(response == 'alreadypaid'){
						enblPayByCashButton();
						$('#cashModal').modal('hide');
						document.getElementById('alreadypaidmsg').innerHTML = getBaseLang.paid;
						$('#alertalreadypaidModal').modal('show');

					}
*/			} catch (e) {
					alert(e);
				}
			/*},
			error : function(e) {
			}
			
		})*/
		
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
			ajaxCallObject.callAjax(BASE_URL + "/order/showvfdpay/"
					+ "TOT IN RM : " + parseFloat(amttopay).toFixed(2) + "/"
					+ "BAL IN RM : " + parseFloat(changeamt).toFixed(2)
					+ ".htm", function() {
			}, null);
		}
	} else {
		$('#cashchangeamtsplitpaymentcontId').text('0.00');
		$("#splitPaymentBtn").removeClass("active").addClass("disabled");

	}

}

function cancelCustomer() {

	if (orderVal == null || orderVal == '') {
		document.getElementById("modparcelcustPhone").value = "";
		document.getElementById("modparcelcustName").value = "";
		document.getElementById("modparcelcustAddress").value = "";
		document.getElementById("modparceldeliveryPersonName").value = "";
		document.getElementById("modparcelcustlocation").value = "";
		document.getElementById("modparcelcustvatorcst").value = "";
		document.getElementById("modparcelcusthouseno").value = "";
		document.getElementById("modparcelcuststreet").value = "";
		document.getElementById("modparcelcuststate").value = "";
		document.getElementById("itemNameSearch").value = "";
		document.getElementById("itemContactSearch").value = "";
		
		document.getElementById('parcelCustModalalertMsg').innerHTML = "";

	       dsblDetailEnblAddCustomer();

		//var date = new Date();
		$("#modparcelcustdob").val("");
		$("#modparcelcustanniversary").val("");

		// $(".tab-content").hide().first().show();
		$("st-nav-tabs li:first").addClass("active");
		$('#customerdetails a[href="#home"]').tab('show');
		var myArray = $(".nav-justified li a").map(function() {
			return $(this).text();
		}).get();
		for (var i = 0; i < myArray.length; i++) {
			if (myArray[i] != 'Home') {
				$tabs.addClass('disabled');
			}
		}
	} else {
		$("st-nav-tabs li:first").addClass("active");
		$('#customerdetails a[href="#home"]').tab('show');
	}
}
function setCustomer() {
	
	var customerName=document.getElementById('modparcelcustName').value;
	var customerContact=document.getElementById('modparcelcustPhone').value;
	
	document.getElementById('itemNameSearch').value=customerName;
	document.getElementById('itemContactSearch').value=customerContact;
}

function searchCustomer() {
	
	
	var orderNo=$('#orderNo').find("option:selected").val();
	
	//alert("orderDetails" + calledFromSavedOrder);
	
	var customerContact = document.getElementById("modparcelcustPhone").value;
	var customerID = document.getElementById("modparcelcustIdhidden").value;
	var customerName = document.getElementById("modparcelcustName").value;
	
	//alert(customerID + " + " + customerContact + " + " + customerName);
	
	if (customerContact == '' &&  customerName == '')
	{
			//custId='0';
			//alert(custId);
			 customerContact = document.getElementById("itemContactSearch").value;
			 customerName = document.getElementById("itemNameSearch").value;
	}
	
	if (customerContact == '' &&  customerName == '')
			{
		       customerID='0';
			}
	else{
		if(customerID!=null || customerID!='')
			{
			custId=customerID;
			}
	}
	//alert(customerID);
      if (customerContact == '' && customerID == '' && calledFromSavedOrder=='no') {
		// alert('Please enter a valid number!');
		
		$("#modparceldeliveryPersonName").val("");
		$("#modparcelcustAddress").val("");
		$("#modparcelcustName").val("");
		$("#modparcelcustvatorcst").val("");
		$("#modparcelcustlocation").val("");
		 $("#modparcelcusthouseno").val("");
		 $("#modparcelcuststreet").val("");
		 $("#modparcelcuststate").val("");

		//var date = new Date();
		 $("#modparcelcustdob").val("");
		 $("#modparcelcustanniversary").val("");
		 
		document.getElementById('parcelCustModalalertMsg').innerHTML = getBaseLang.plsEntrVdNo;
		document.getElementById('modparcelcustPhone').focus();
		$tabs = $('.nav-justified li');
	     var myArray = $(".nav-justified li a").map(function() {
	                   return $(this).text();
	                }).get();
	     for(var i = 0; i<myArray.length; i++)
	     {
	      if(myArray[i]!='Home')
	      {
	       $tabs.addClass('disabled');
	      }
	     }
	} else {
		
		//alert(customerID + ":" + custId);
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		 var deliveryPersonName=null;
		 
		if(customerID == '' && orderNo!='0')
			{
        
		 ajaxCallObject
		 .callAjax(
				 BASE_URL + "/order/searchorderbyid/"
				 						+ orderNo + ".htm",
				 function(response) {
					try {
						//alert('hello');
						 var responseObj=JSON.parse(response);
		    											
					     console.log("responseObj" + responseObj);
					     custId= responseObj.storeCustomerId;
					     deliveryPersonName=responseObj.deliveryPersonName;
					     //console.log("custId>>>" + deliveryPersonName);
					     customerDetailSearch( customerContact, customerID, custId, deliveryPersonName) ;
					} catch (e) {
						console.log(e);
					}
				}, null); 
		
			}
		else{
			custId=customerID;
			customerDetailSearch( customerContact, customerID, custId, deliveryPersonName) ;
		}						
	}
}

function customerDetailSearch( customerContact, customerID, custId, deliveryPersonName) {
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	if(customerContact == '' && customerID =='')
	{
				     
					 ajaxCallObject
						.callAjax(
								BASE_URL + "/order/getcustomerdetailsbyid/"
										+ custId + ".htm",
								function(response) {
									try {
										console.log("responsebycustID=" + response);
										var custDetail = JSON.parse(response);
										if ($.isEmptyObject(custDetail)) {
											$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
											$("#modparcelcustName")
											.val("");
									$("#modparcelcustAddress").val(
											"");
									$("#modparceldeliveryPersonName").val(
											"");
									$("#modparcelcustvatorcst").val("");
									$("#modparcelcustlocation").val("");
								     $("#modparcelcusthouseno").val("");
								     $("#modparcelcuststreet").val("");
								     $("#modparcelcuststate").val("");

								
								     $("#modparcelcustdob").val("");
								     $("#modparcelcustanniversary").val("");
									$tabs = $('.nav-justified li');
								     var myArray = $(".nav-justified li a").map(function() {
								                   return $(this).text();
								                }).get();
								     for(var i = 0; i<myArray.length; i++)
								     {
								      if(myArray[i]!='Home')
								      {
								       $tabs.addClass('disabled');
								      }
								     }
										}else{
											document.getElementById('parcelCustModalalertMsg').innerHTML = "";
											console.log("id   " + custDetail.creditCust.id);
											custId=custDetail.creditCust.id;
											$tabs = $('.nav-justified li');
											$tabs.removeClass('disabled');

											$("#modparcelcustName")
													.val(custDetail.custName);
											$("#modparcelcustAddress").val(
													custDetail.delivAddr);
											$("#modparceldeliveryPersonName").val(
													deliveryPersonName);
											$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
											
											$("#modparcelcustlocation").val(custDetail.location);
											$("#modparcelcusthouseno").val(custDetail.houseNo);
											$("#modparcelcuststreet").val(custDetail.street);
											$("#modparcelcuststate").val(custDetail.creditCust.state);

											if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
										     {
										      
										      $("#modparcelcustdob").val(formatDate(custDetail.dob));
										     }
										     else {
										      $("#modparcelcustdob").val("");
										     }
										   //  console.log('><><><'+custDetail.anniversary);
										     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
										     {
										      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
										     }
										     else {
										      $("#modparcelcustanniversary").val("");
										     }
											
										}
										

									} catch (e) {
										console.log(e);
									}
								}, null);
				     
	}
else  if(customerContact != '')
	{
	
	ajaxCallObject
	.callAjax(
			BASE_URL + "/order/getcustomerdetails/"
					+ customerContact + ".htm",
			function(response) {
				try {
					console.log("responseByCustContact=" + response);
					var custDetail = JSON.parse(response);
					if ($.isEmptyObject(custDetail)) {
						$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
						$("#modparcelcustName")
						.val("");
				$("#modparcelcustAddress").val(
						"");
				$("#modparceldeliveryPersonName").val(
						"");
				$("#modparcelcustvatorcst").val("");
				$("#modparcelcustlocation").val("");
			     $("#modparcelcusthouseno").val("");
			     $("#modparcelcuststreet").val("");
			     $("#modparcelcuststate").val("");

			     $("#modparcelcustdob").val("");
			     $("#modparcelcustanniversary").val("");
				$tabs = $('.nav-justified li');
			     var myArray = $(".nav-justified li a").map(function() {
			                   return $(this).text();
			                }).get();
			     for(var i = 0; i<myArray.length; i++)
			     {
			      if(myArray[i]!='Home')
			      {
			       $tabs.addClass('disabled');
			      }
			     }
					}else{
						document.getElementById('parcelCustModalalertMsg').innerHTML = "";
						console.log("id   " + custDetail.creditCust.id);
						custId=custDetail.creditCust.id;
						$tabs = $('.nav-justified li');
						$tabs.removeClass('disabled');

						$("#modparcelcustName")
								.val(custDetail.custName);
						$("#modparcelcustAddress").val(
								custDetail.delivAddr);
						$("#modparceldeliveryPersonName").val(
								deliveryPersonName);
						$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
						
						$("#modparcelcustlocation").val(custDetail.location);
						$("#modparcelcusthouseno").val(custDetail.houseNo);
						$("#modparcelcuststreet").val(custDetail.street);
						$("#modparcelcuststate").val(custDetail.creditCust.state);

						if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
					     {
					      
					      $("#modparcelcustdob").val(formatDate(custDetail.dob));
					     }
					     else {
					      $("#modparcelcustdob").val("");
					     }
					   //  console.log('><><><'+custDetail.anniversary);
					     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
					     {
					      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
					     }
					     else {
					      $("#modparcelcustanniversary").val("");
					     }
						
					}
					

				} catch (e) {
					console.log(e);
				}
			}, null);

	}
else if(customerID !='')
	{
     
	 ajaxCallObject
		.callAjax(
				BASE_URL + "/order/getcustomerdetailsbyid/"
						+ customerID + ".htm",
				function(response) {
					try {
						console.log("responsebycustID=" + response);
						var custDetail = JSON.parse(response);
						if ($.isEmptyObject(custDetail)) {
							$("#parcelCustModalalertMsg").html("<strong>Customer info not found.</strong> Please add customer details.");
							$("#modparcelcustName")
							.val("");
					$("#modparcelcustAddress").val(
							"");
					$("#modparceldeliveryPersonName").val(
							"");
					$("#modparcelcustvatorcst").val("");
					$("#modparcelcustlocation").val("");
				     $("#modparcelcusthouseno").val("");
				     $("#modparcelcuststreet").val("");
				     $("#modparcelcuststate").val("");

				     $("#modparcelcustdob").val("");
				     $("#modparcelcustanniversary").val("");
					$tabs = $('.nav-justified li');
				     var myArray = $(".nav-justified li a").map(function() {
				                   return $(this).text();
				                }).get();
				     for(var i = 0; i<myArray.length; i++)
				     {
				      if(myArray[i]!='Home')
				      {
				       $tabs.addClass('disabled');
				      }
				     }
						}else{
							document.getElementById('parcelCustModalalertMsg').innerHTML = "";
							console.log("id   " + custDetail.creditCust.id);
							custId=custDetail.creditCust.id;
							$tabs = $('.nav-justified li');
							$tabs.removeClass('disabled');

							$("#modparcelcustName")
									.val(custDetail.custName);
							$("#modparcelcustAddress").val(
									custDetail.delivAddr);
							$("#modparceldeliveryPersonName").val(
									deliveryPersonName);
							$("#modparcelcustvatorcst").val(custDetail.custVatRegNo);
							
							$("#modparcelcustlocation").val(custDetail.location);
							$("#modparcelcusthouseno").val(custDetail.houseNo);
							$("#modparcelcuststreet").val(custDetail.street);
							$("#modparcelcuststate").val(custDetail.creditCust.state);

							if(custDetail.dob!='' && typeof custDetail.dob !== "undefined")
						     {
						      
						      $("#modparcelcustdob").val(formatDate(custDetail.dob));
						     }
						     else {
						      $("#modparcelcustdob").val("");
						     }
						   //  console.log('><><><'+custDetail.anniversary);
						     if(custDetail.anniversary_date!='' && typeof custDetail.anniversary_date !== "undefined")
						     {
						      $("#modparcelcustanniversary").val(formatDate(custDetail.anniversary_date));
						     }
						     else {
						      $("#modparcelcustanniversary").val("");
						     }
							
						}
						

					} catch (e) {
						console.log(e);
					}
				}, null);
	}
}

//function searchCustomer() {
//
//	var customerContact = document.getElementById("modparcelcustPhone").value;
//	
//	var orderNo=$('#orderNo').find("option:selected").val();
//	 console.log("orderDetails" + orderNo);
//	
////	$("#modparceldeliveryPersonName").val("");
////	$("#modparcelcustAddress").val("");
////	$("#modparcelcustName").val("");
////	$("#modparcelcustvatorcst").val("");
////	$("#modparcelcustlocation").val("");
////	$("#modparcelcusthouseno").val("");
////	$("#modparcelcuststreet").val("");
////	var date = new Date();
////	$("#modparcelcustdob").val(formatDate(date));
////	$("#modparcelcustanniversary").val(formatDate(date));
//
////	$tabs = $('.nav-justified li');
////	var myArray = $(".nav-justified li a").map(function() {
////		return $(this).text();
////	}).get();
////	for (var i = 0; i < myArray.length; i++) {
////		if (myArray[i] != 'Home') {
////			$tabs.addClass('disabled');
////		}
////	}
//	
//	if ((isNaN(customerContact) || customerContact == '') && calledFromSavedOrder=='no') {
//		// alert('Please eneter a valid number!');
//		document.getElementById('parcelCustModalalertMsg').innerHTML = getBaseLang.plsEntrVdNo;
//		document.getElementById('modparcelcustPhone').focus();
//
//		
//		$("#modparceldeliveryPersonName").val("");
//		$("#modparcelcustAddress").val("");
//		$("#modparcelcustName").val("");
//		$("#modparcelcustvatorcst").val("");
//		$("#modparcelcustlocation").val("");
//		$("#modparcelcusthouseno").val("");
//		$("#modparcelcuststreet").val("");
//		var date = new Date();
//		$("#modparcelcustdob").val(formatDate(date));
//		$("#modparcelcustanniversary").val(formatDate(date));
//		
//		$tabs = $('.nav-justified li');
//		var myArray = $(".nav-justified li a").map(function() {
//			return $(this).text();
//		}).get();
//		for (var i = 0; i < myArray.length; i++) {
//			if (myArray[i] != 'Home') {
//				$tabs.addClass('disabled');
//			}
//		}
//	} 
//	else {
//		calledFromSavedOrder='no';
//	//	alert('hello');
//	if(customerContact != ''){
//		var ajaxCallObject = new CustomBrowserXMLObject();
//		ajaxCallObject
//				.callAjax(
//						BASE_URL + "/order/getcustomerdetails/"
//								+ customerContact + ".htm",
//						function(response) {
//							try {
//								console.log("response=" + response);
//								var custDetail = JSON.parse(response);
//								if ($.isEmptyObject(custDetail)) {
//									$("#parcelCustModalalertMsg")
//											.html(
//													"<strong>"
//															+ getBaseLang.custNotFound
//															+ "</strong> "
//															+ getBaseLang.plsAddCustDetails
//															+ " ");
//									$("#modparcelcustName").val("");
//									$("#modparcelcustAddress").val("");
//									$("#modparceldeliveryPersonName").val("");
//									$("#modparcelcustvatorcst").val("");
//									$("#modparcelcustlocation").val("");
//									$("#modparcelcusthouseno").val("");
//									$("#modparcelcuststreet").val("");
//									var date = new Date();
//									$("#modparcelcustdob")
//											.val(formatDate(date));
//									$("#modparcelcustanniversary").val(
//											formatDate(date));
//
//									$tabs = $('.nav-justified li');
//									var myArray = $(".nav-justified li a").map(
//											function() {
//												return $(this).text();
//											}).get();
//									for (var i = 0; i < myArray.length; i++) {
//										if (myArray[i] != 'Home') {
//											$tabs.addClass('disabled');
//										}
//									}
//								} else {
//
//									// alert(custDetail.creditCust.id);
//									custId = custDetail.creditCust.id;
//
//									$tabs = $('.nav-justified li');
//									$tabs.removeClass('disabled');
//
//									$("#modparcelcustName").val(
//											custDetail.custName);
//									$("#modparcelcustAddress").val(
//											custDetail.delivAddr);
//									$("#modparceldeliveryPersonName").val(
//											custDetail.delivPersonName);
//									$("#modparcelcustvatorcst").val(
//											custDetail.custVatRegNo);
//									$("#modparcelcustlocation").val(
//											custDetail.location);
//									$("#modparcelcusthouseno").val(
//											custDetail.houseNo);
//									$("#modparcelcuststreet").val(
//											custDetail.street);
//									if (custDetail.dob != ''
//											&& typeof custDetail.dob !== "undefined") {
//
//										$("#modparcelcustdob").val(
//												formatDate(custDetail.dob));
//									} else {
//										$("#modparcelcustdob").val("");
//									}
//									console.log('><><><'
//											+ custDetail.anniversary_date);
//									if (custDetail.anniversary_date != ''
//											&& typeof custDetail.anniversary_date !== "undefined") {
//										$("#modparcelcustanniversary")
//												.val(
//														formatDate(custDetail.anniversary_date));
//									} else {
//										$("#modparcelcustanniversary").val("");
//									}
//								}
//
//							} catch (e) {
//								console.log(e);
//							}
//						}, null);
//	}
//	else {
//		
//	}
//	}
//}

function formatDate(date) {
	var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
			+ d.getDate(), year = d.getFullYear();

	if (month.length < 2)
		month = '0' + month;
	if (day.length < 2)
		day = '0' + day;

	return [ year, month, day ].join('-');
}

function gotransactionsummary() {
	// var searchedCustId=custId;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/order/getTotaltransactionPerCustomer/"
							+ custId + ".htm",
					function(response) {
						try {
							var responseObj = JSON.parse(response);

							// console.log("responseObj " + responseObj);
							document.getElementById('modtotaltransaction').innerHTML = parseFloat(
									responseObj).toFixed(2);
							// document.getElementById('transactionsummary').style.display
							// = 'block';
							// document.getElementById("transactionsummary").href="#transactionsummarydiv";
							// var a =
							// document.getElementById("transactionsummary");
							// a.setAttribute('href', "#transactionsummarydiv");

						} catch (e) {
							alert(e);
						}
					}, null);

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/order/getLastVisitDate/" + custId + ".htm",
					function(response) {
						try {
							var responseObj = JSON.parse(response);

							// console.log("responseObj " +
							// customer.last_Visit_Date);
							var lastvisit = responseObj[1];
							var fields = lastvisit.split(':');

							var dayDiff = responseObj[2];
							var fields1 = dayDiff.split(':');

							// var name = fields[0];
							var lastdate = fields[1];
							var dayDiffTotal = fields1[1];

							// qty = lastvisit.last_Visit_Date;
							// console.log("lastvisit " + lastdate);
							if (parseInt(dayDiffTotal) == 0) {

								document.getElementById('modlastvisitdate').innerHTML = lastdate
										+ " ( Today )";
							} else if (parseInt(dayDiffTotal) == 1) {

								document.getElementById('modlastvisitdate').innerHTML = lastdate
										+ " ( " + dayDiffTotal + " day ago )";
							} else {

								document.getElementById('modlastvisitdate').innerHTML = lastdate
										+ " ( " + dayDiffTotal + " days ago )";
							}

						} catch (e) {
							//alert(e);
						}
					}, null);

	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/order/getcustmostpurchaseItem/" + custId
							+ ".htm",
					function(response) {
						try {
							var responseObj = JSON.parse(response);

							mostPurchasedItemsCount = parseInt(responseObj.length);
							console.log("responseObj " + responseObj);
							var createdrowline = "";
							for (var i = 0; i < responseObj.length; i++) {
								var item = responseObj[i];
								var itemname = item[3];
								var itemqty = item[4];
								var fieldsforname = itemname.split(':');
								var fieldsforqty = itemqty.split(':');
								// console.log("itemname " + fieldsforname[1] +
								// "itemqty " + fieldsforqty[1]);

								var startTrline = "<tr style=''>";
								var firstTdline = "<td style=' max-width: 50px !important; color:#fff; word-wrap: break-word; font-size: 18px;font-family: sans-serif;'>"
										+ (i + 1) + "</td>";
								var secondTdline = "<td style=' max-width: 50px !important; color:#fff; word-wrap: break-word; font-size: 18px;font-family: sans-serif;'>"
										+ fieldsforname[1] + "</td>";
								var thirdTdline = "<td style=' color:#fff; font-size: 18px;font-family: sans-serif;'>"
										+ fieldsforqty[1] + "</td>";
								var endTrline = "</tr>";
								createdrowline += startTrline + firstTdline
										+ secondTdline + thirdTdline
										+ endTrline;

								// ("#modmostpurchaseitems").append(createdrowline);
							}
							document.getElementById('modmostpurchaseitems').innerHTML = createdrowline;
						} catch (e) {
							alert(e);
						}
					}, null);

}

function gotransactionhistory() {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/order/getcustomertransactionsummery/" + custId
							+ ".htm",
					function(response) {
						try {
							var responseObj = JSON.parse(response);

							console.log("responseObj " + responseObj);
							var createdrowline = "";
							for (var i = 0; i < responseObj.length; i++) {
								var item = responseObj[i];
								var orderid = item[0];
								var amount = item[1];
								var paidamt = item[2];
								var amounttopay = item[3];
								var orderdate = item[4];
								var fieldsfororderid = orderid.split(':');
								var fieldsforamount = amount.split(':');
								var fieldsforpaidamt = paidamt.split(':');
								var fieldsforamounttopay = amounttopay
										.split(':');
								var fieldsfororderdate = orderdate.split(':');
								console.log("fieldsforamount "
										+ fieldsforamount[1]
										+ "fieldsforpaidamt "
										+ fieldsforpaidamt[1]
										+ "fieldsforamounttopay "
										+ fieldsforamounttopay[1]
										+ "fieldsfororderdate"
										+ fieldsfororderdate);

								var startTrline = "<tr style='padding: 1px;'>";
								var fourTdline = "<td style='padding-left: 20px;padding-right: 20px;color:#fff; font-size: 18px;font-family: sans-serif;'>"
										+ fieldsforpaidamt[1] + "</td>";
								var firstTdline = "<td style='padding-left: 20px;padding-right: 20px;color:#fff; max-width: 50px !important; word-wrap: break-word; font-size: 18px;font-family: sans-serif;'>"
										+ fieldsfororderid[1] + "</td>";
								var secondTdline = "<td style='padding-left: 20px;padding-right: 20px;color:#fff; font-size: 18px;font-family: sans-serif;'>"
										+ fieldsfororderdate[1] + "</td>";
								var thirdTdline = "<td style='padding-left: 20px;padding-right: 20px;color:#fff; font-size: 18px;font-family: sans-serif;'>"
										+ fieldsforamount[1] + "</td>";
								var fifthTdline = "<td style='padding-left: 20px;padding-right: 20px;color:#fff; font-size: 18px;font-family: sans-serif;'>"
										+ fieldsforamounttopay[1] + "</td>";

								var endTrline = "</tr>";

								createdrowline += startTrline + firstTdline
										+ secondTdline + thirdTdline
										+ fourTdline + fifthTdline + endTrline;

								// ("#modmostpurchaseitems").append(createdrowline);
							}
							document
									.getElementById('modcusttransactionsummary').innerHTML = createdrowline;
						} catch (e) {
							alert(e);
						}
					}, null);
}

function gopaymentsummary() {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/order/getTotalPaidAmt/" + custId + ".htm",
					function(response) {
						try {
							var responseObj = JSON.parse(response);

							console.log("responseObj getTotalPaidAmt"
									+ responseObj);

//							if (responseObj == '') {
//
//								document
//										.getElementById('previouspaymenthistorydiv').style.display = 'none';
//								document
//										.getElementById('nopreviouspaymenthistorydiv').style.display = 'block';
//
//							} else {

								var qty = responseObj[0];

								var totalpaidamt = qty[3];
								var orderdate = qty[1];
								var paidamt = qty[2];

								var dayDiff = qty[4];

								var fields1 = dayDiff.split(':');
								var dayDiffTotal = fields1[1];

								console.log("qty " + qty + "dayDiff "
										+ dayDiffTotal);
								var fieldsforpaidamt = totalpaidamt.split(':');
								var fieldsforlastorderdate = orderdate
										.split(':');
								var fieldsforlastorderpaidamt = paidamt
										.split(':');
								// var name = fields[0];
								var paidamount = fieldsforpaidamt[1];
								var lastorderdate = fieldsforlastorderdate[1];
								var lastorderpaidamt = fieldsforlastorderpaidamt[1];
								document.getElementById('modtotalpaidamt').innerHTML = paidamount;

								if (parseInt(dayDiffTotal) == 0) {

									document.getElementById('modlastorderdate').innerHTML = lastorderdate
											+ " ( Today )";
								} else if (parseInt(dayDiffTotal) == 1) {

									document.getElementById('modlastorderdate').innerHTML = lastorderdate
											+ " ( "
											+ dayDiffTotal
											+ " day ago )";
								} else {

									document.getElementById('modlastorderdate').innerHTML = lastorderdate
											+ " ( "
											+ dayDiffTotal
											+ " days ago )";
								}
								// document.getElementById('modlastorderdate').innerHTML=lastorderdate;
								document.getElementById('modlastorderpaidamt').innerHTML = lastorderpaidamt;

								// $("#nopreviouspaymenthistorydiv").hide();
								// $("#previouspaymenthistorydiv").show();
								
								if (parseFloat(paidamount).toFixed(2) == "0.00") {

									document
											.getElementById('previouspaymenthistorydiv').style.display = 'none';
									document
											.getElementById('nopreviouspaymenthistorydiv').style.display = 'block';

								}
								else
									{
									document
									.getElementById('nopreviouspaymenthistorydiv').style.display = 'none';
									document
									.getElementById('previouspaymenthistorydiv').style.display = 'block';
									}
								
					//		}
						} catch (e) {
							//alert(e);
						}
					}, null);
}

/* end split payment */
function addBarcodeItem(code) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/menu/getmenuitembybarcode/" + code
			+ ".htm", function(response) {
		var item = JSON.parse(response);
		if (jQuery.isEmptyObject(item)) {
			$("#itemnotfoundModal").modal("show");
		} else {
			var disc = 0.0;
			if (item.promotionFlag == 'Y')
				disc = item.promotionValue;
			additemtoOrder(item.id, item.name, item.price, disc, item.vat,
					item.serviceTax, item.promotionFlag, item.promotionValue,item.isKotPrint);

		}

	}, null);
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

function localPrint_2100px() {

	// var divToPrint = document.getElementById('localPrint_2100px');
	// document.getElementById('removePrint_2100px').style.display = 'none';
	// newWin = window.open("");
	// newWin.document.write(divToPrint.outerHTML);
	// newWin.document.close();
	// newWin.focus();
	// newWin.print();
	// document.getElementById('removePrint_2100px').style.display = 'block';
	// newWin.close();

	var divToPrint = document.getElementById('localPrint_2100px_GST');
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
						var orderDate=jsonObj.orderDate;
						//console.log(orderDate);
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
							//alert("80");
							/* ****** Print in 80 paper size ***** */

							/* ********** START STORE INFO PRINT ********** */
							$('#storeName80').text(customerName);
							$('#storeAddr80').text(customerAddr);
							$('#storeEmail80').text(customerEmail);
							$('#storePhNo80').text(customerPhNo);
							$('#cashOrdervalue80').text(orderNo);
							console.log('orderDate'+orderDate);
							$('#cashOrderdate80').text(orderDate);
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
								//alert("serviceChargeAmt"+serviceChargeAmt);
								$("#cashtotalServiceCharge80px").show();
								$('#cashservChrg80').text(serviceChargeAmt);
							} else {
								$("#cashtotalServiceCharge80px").hide();
							}

							if (serviceTaxAmt > 0.00) {
								//alert("serviceTaxAmt"+serviceTaxAmt);
								$("#cashtotalServiceTax80px").show();
								$('#cashservTax80').text(serviceTaxAmt);
							} else {
								$("#cashtotalServiceTax80px").hide();
							}

							if (vatAmt > 0) {
								//alert("vatAmt"+vatAmt);
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

							//	alert("customerAddr >>  "+customerAddr);

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
function cancelCreditCustomer() {
	
	document.getElementById('addstorecustnameContId').value='';
	document.getElementById('addstorecustcontactContId').value='';
	document.getElementById('addstorecustaddressContId').value='';
	document.getElementById('addstorecustemailContId').value='';
	document.getElementById('addstorecuststreet').value='';
	document.getElementById('addstorecusthouseno').value='';
	document.getElementById('addstorelcustlocation').value='';
	document.getElementById('addstorecustcrlimitContId').value='';
	
	var date= new Date();
	document.getElementById('addstorecustdob').value=formatDate(date);
	document.getElementById('addstorecustanniversarydate').value=formatDate(date);
}

function addCreditCustomer() {

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

	// alert(storecustname+':'+storecustcontact+':'+storecustaddress+':'+storecustemail+':'+storecustcrlimit);
	if (storecustname == '' || storecustcontact == '') {
		document.getElementById('addstorecustalertMsg').innerHTML = "Both fields are required!";
	} else if ((/[#%?\/\\]/gi).test(storecustname)
			|| (/[#%?\/\\]/gi).test(storecustaddress)) {
		document.getElementById('addstorecustalertMsg').innerHTML = "#,%,?,/,\  characters are not allowed!";
	} else if (isNaN(storecustcontact)) {
		document.getElementById('addstorecustalertMsg').innerHTML = "Enter a valid contact no!";
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
		  addStoreCustomer.anniversary=storecustanniversary;

		$.ajax({

					url : BASE_URL + "/storecustomermgnt/addcreditcustomer.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(addStoreCustomer),
					success : function(response) {
						console.log(">>>>>> "+response);
						 var customer=JSON.parse(response);
						// closenmenucateditModal();
						if ($.trim(response)) {
							document.getElementById('catdataopmassagecont').innerHTML = "Data is sucessfully added!";

							document.getElementById('hidcredisalecustid').value=customer.id;
							document.getElementById('creditsalecustname').value=customer.name;
							document.getElementById('creditsalecustcontact').value=customer.contactNo;

							showalertcatdataopModal();
							closecreditcustaddModal();
							document.getElementById('addstorecustnameContId').value='';
							document.getElementById('addstorecustcontactContId').value='';
							document.getElementById('addstorecustaddressContId').value='';
							document.getElementById('addstorecustemailContId').value='';
							document.getElementById('addstorecuststreet').value='';
							document.getElementById('addstorecusthouseno').value='';
							document.getElementById('addstorelcustlocation').value='';
							document.getElementById('addstorecustcrlimitContId').value='';

							getvendorledger_sale($('#debitor_group_codef').val(),0,customer.id,3);// for sunndry debitor
							var date= new Date();
							document.getElementById('addstorecustdob').value=formatDate(date);
							document.getElementById('addstorecustanniversarydate').value=formatDate(date);
						//	$("#modparcelcustdob").val(formatDate(custDetail.dob));

							var htm="<input type='radio' id='creditsalepayOptionCash' name='creditsalepayOption' value='cash' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.cash+"&nbsp;&nbsp;"+
                   			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='card' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.card+"&nbsp;&nbsp;"+
                   			"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='nopay' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.noPay+"";
            	             $("#creditsalecustdetailcontId").html("Payment Type : "+htm);




						} else {
							document.getElementById('catdataopmassagecont').innerHTML = "Data is not added.Please try again!";

						}
					}

				});

	}
}



function showcreditcustDetailsDataModal(){
	//alert("hi");
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/storecustomermgnt/getallcreditcustomerdata.htm", function(response) {
		try {
			console.log(">>>>>> "+response);	
			var responseObj = JSON.parse(response);
			prepareAllCreditCustomerDataHtml(responseObj);
		} catch (e) {
			alert(e);
		}

	}, null);
}

function prepareAllCreditCustomerDataHtml(data) {
	//alert("details");
	var detailsdatapart = document.getElementById('creditcustomerdetailsdata');
	var creditcustomerdata = data;
	var begintrline="";
	var endtrline="";
	var firstcolumn="";
	var secondcolumn="";
	var thirdcolumn="";
	var fourthcolumn="";
	var tdpart="";
	var table="";
	var tableheadline = "<table class='table  table-bordered' style='color:#FFF; border:1px solid #222222;'><thead>" +
			"<th style='text-align:center;'>"+getBaseLang.thname+ "</th><th style='text-align:center;'>"+ getBaseLang.thcontact
	      + "</th><th style='text-align:center;'>"+ getBaseLang.themail+ "</th><th style='text-align:center;'>"+ getBaseLang.thcreditlimit + "</th></thead><tbody>";
	
	var tableend="</tbody></table>";
	var mail="";
	if(data.length == 0){
		tableheadline="";
		tdpart="<span style='font-size: large;align:center;'>"+getBaseLang.custNotFound+"</span>";
		tableend="";
	}
	else{
	for (var i = 0; i < data.length; i++) {
		mail="";
		var customerdata = data[i];
		//alert("email:"+customerdata.emailId);
		if(customerdata.emailId == undefined){
			mail=getBaseLang.msgna;
		}
		else{
			mail=customerdata.emailId;
		}
		begintrline = "<tr>";
		firstcolumn="<td style='text-align: center;' onclick='javascript:selectCreditCustomer("+customerdata.id+",&quot;"+customerdata.name+"&quot;,&quot;"+customerdata.contactNo+"&quot;)'>"+customerdata.name+"</td>";
		secondcolumn="<td style='text-align: center;' onclick='javascript:selectCreditCustomer("+customerdata.id+",&quot;"+customerdata.name+"&quot;,&quot;"+customerdata.contactNo+"&quot;)'>"+customerdata.contactNo+"</td>";
		thirdcolumn="<td style='text-align: center;' onclick='javascript:selectCreditCustomer("+customerdata.id+",&quot;"+customerdata.name+"&quot;,&quot;"+customerdata.contactNo+"&quot;)'>"+mail+"</td>";
		fourthcolumn="<td style='text-align: center;' onclick='javascript:selectCreditCustomer("+customerdata.id+",&quot;"+customerdata.name+"&quot;,&quot;"+customerdata.contactNo+"&quot;)'>"+customerdata.creditLimit+"</td>";
		endtrline="</tr>";
		tdpart+=begintrline+firstcolumn+secondcolumn+thirdcolumn+fourthcolumn+endtrline;
	}
}
	table+=tableheadline+tdpart+tableend;
	detailsdatapart.innerHTML = table;
	$('#creditCustomerListModal').modal('show');
	
}


function selectCreditCustomer(id,name,phone){
	//alert("id:"+id+"name:"+name+"phone:"+phone);
	document.getElementById('hidcredisalecustid').value=id;
	document.getElementById('creditsalecustname').value=name;
	document.getElementById('creditsalecustcontact').value=phone;
	getvendorledger_sale($('#debitor_group_codef').val(),0,id,3);// for sunndry debitor
	var htm="<input type='radio' id='creditsalepayOptionCash' name='creditsalepayOption' value='cash' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.cash+"&nbsp;&nbsp;"+
		"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='card' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.card+"&nbsp;&nbsp;"+
		"<input type='radio' id='creditsalepayOptionCard' name='creditsalepayOption' value='nopay' onclick='showcreditsalePaydetail(this.value)'>&nbsp;&nbsp;"+getBaseLang.noPay+"";
     $("#creditsalecustdetailcontId").html("Payment Type : "+htm);
     $('#creditCustomerListModal').modal('hide');
	
}













function openAssignDelBoyModal() {
	var orderno = document.getElementById('orderNo').value;
	document.getElementById('assigndelboyalertMsg').innerHTML = "";
	if (orderno == 0) {
		showalertsaveorderModal();
	} else {
		showAssignDeliveryBoyModal();
	}
}


var delBoyDetail = [];
function showAssignDeliveryBoyModal()
{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject
			.callAjax(
					BASE_URL + "/deliveryboy/getdeliveryboy.htm",
					function(response) {
						var responseObj = [];
						responseObj = JSON.parse(response);
						delBoyDetail=responseObj;
						var optionline = "";
						optionline += "<option value='0'> Select Del. Boy </option>";
						for ( var i = 0; i < responseObj.length; i++) {
							var id = responseObj[i].id;
							var name = responseObj[i].name;
							//console.log(orderDeliveryPerson);
							if(orderDeliveryPerson!="")
								{
								 if(orderDeliveryPerson==responseObj[i].name)
									 {
									 optionline += "<option value='" + id + "'style='text-indent:10px;' selected='selected'>" + name
										+ "</option>";
									 }
								 else {
									 optionline += "<option value='" + id + "'style='text-indent:10px;'>" + name
										+ "</option>";
								 	}
								}
							else {
								optionline += "<option value='" + id + "'style='text-indent:10px;'>" + name
								+ "</option>";
							}							
						}
						document.getElementById('deliveryboyName').innerHTML = optionline;
						
						   $('#AssignDelBoyModal').modal('show');
					}, null);
}

var orderdeliveryBoy = {};
function selectDelBoy() {

	var id = document
	   .getElementById('deliveryboyName').value;
	if(id!=0)
	{
		for( var i = 0; i < delBoyDetail.length; i++)
		{
			orderdeliveryBoy = {};
			if(delBoyDetail[i].id == id) {

				var orderno = document.getElementById('orderNo').value;
				orderdeliveryBoy.orderId=orderno;
				orderdeliveryBoy.deliveryPersonName=delBoyDetail[i].name;
				orderdeliveryBoy.store_id=delBoyDetail[i].store_id;
				break;
			}
		}
	}
	
}

function assignDeliveryBoy() {
	
	var id = document
	   .getElementById('deliveryboyName').value;
	
	if(id!=0)
	{
		console.log(JSON.stringify(orderdeliveryBoy));
		$.ajax({
			url : BASE_URL + "/deliveryboy/assigndelboy.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(orderdeliveryBoy),
			success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						if (response === 'success') {
							closedeliveryboyassignModal();
							document.getElementById('deliveryboydataopmassagecont').innerHTML = getBaseLang.datasucAdd;
							showalertdeliveryboydataopModal();
						} else {
							closedeliveryboyassignModal();
							document.getElementById('deliveryboydataopmassagecont').innerHTML = getBaseLang.datafailAdd;
							showalertdeliveryboydataopModal();
						}
					}
				});
	}
	else {
		document.getElementById('assigndelboyalertMsg').innerHTML = getBaseLang.deliveryboyadd;		
	}
}

function closedeliveryboyassignModal()
{
	$('#AssignDelBoyModal').modal('hide');
}


function showalertdeliveryboydataopModal()
	{
		$('#alertdeliveryboydataopModal').modal('show');
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

/*function sleep(delay) {
    var start = new Date().getTime();
    while (new Date().getTime() < start + delay);
  }*/

function dsblPayByCashButton(){	
	//alert("gh");
	 document.getElementById('paybycashbtn').style.backgroundColor="#F00";
	 document.getElementById('paybycashbtn').disabled = true;
	}

function enblPayByCashButton(){	
	 document.getElementById('paybycashbtn').disabled = false; 	 
	 document.getElementById('paybycashbtn').style.backgroundColor="#72BB4F"; 
	}

function dsblPayByCardButton(){
	 document.getElementById('paybycardbtn').style.backgroundColor="#F00";
	 document.getElementById('paybycardbtn').disabled = true; 
	}

function enblPayByCardButton(){
	 document.getElementById('paybycardbtn').style.backgroundColor="#72BB4F";
	 document.getElementById('paybycardbtn').disabled = false; 
	 
	}
function dsblPayByOnlineButton(){
	 document.getElementById('paybyonlinebtn').style.backgroundColor="#F00";
	 document.getElementById('paybyonlinebtn').disabled = true; 
	}

function enblPayByOnlineButton(){
	 document.getElementById('paybyonlinebtn').style.backgroundColor="#72BB4F";
	 document.getElementById('paybyonlinebtn').disabled = false; 
	}


//Add Service charge operations start

function openAddServiceCharge(){
	var orderno = document.getElementById('orderNo').value;
	var tableno = document.getElementById('tablenoCont').innerHTML;
    var totAmt = document.getElementById('subtotalcontId').innerHTML;
	var discpercentage = document.getElementById('hidendiscountpercentage').value;
	var servicechargepers=0.0;
	var servicechargeamt=0.0;
	document.getElementById('servicechargeAddalertMsg').innerHTML ='';
	if (orderno == 0 || forspNoteData.length > 0) {
		showalertsaveorderModal();
	} else if(discpercentage>0) {
		$('#alertupdateServiceChargeModal').modal('show');
		}
	else{
		document.getElementById('servicechargemodOrderCont').innerHTML = orderno;
		document.getElementById('servicechargemodStoreBaseOrderCont').innerHTML = storeBasedOrderNumber;
		document.getElementById('servicechargemodTabCont').innerHTML = tableno;
		document.getElementById('servicechargemodtotamtcontId').innerHTML = totAmt;
		
	    servicechargepers=document.getElementById('serviceChargeRate').value;
	    document.getElementById('servicechargeModPer').value=servicechargepers;
	    servicechargeamt = Number(totAmt) * Number(servicechargepers) / 100;
	    document.getElementById('servicechargeModAmt').value = parseFloat(servicechargeamt).toFixed(2);
	    
	    
		showaddServiceChargeModal();
	}

}

function calculateservicechargeAmt(per){
	var servicechrgpers = document.getElementById('servicechargeModPer').value; 
	var totalamt = document.getElementById('subtotalcontId').innerHTML;
	var schrgamt = 0.0;
	if(per==''){
		document.getElementById('servicechargeModAmt').value ='';
	}
	else{
		schrgamt = Number(totalamt) * Number(per) / 100;
		document.getElementById('servicechargeModAmt').value = parseFloat(schrgamt).toFixed(2);
	}	
		
	
}

function AddServiceCharge(){
	var orderid = document.getElementById('servicechargemodOrderCont').innerHTML;
	var scgargerate = document.getElementById('servicechargeModPer').value;
	
	if (isNaN(scgargerate) || scgargerate == '') {
		document.getElementById('servicechargeAddalertMsg').innerHTML = getBaseLang.plsEntrVdNo;
	} else if (scgargerate > 100) {
		document.getElementById('servicechargeAddalertMsg').innerHTML = "Can not enter value greater than 100.";
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
				.callAjax(
						BASE_URL + "/order/addschargerate/" + orderid + "/"
								+ scgargerate + ".htm",
						function(response) {
							try {
								console.log('addservicecharge>>>'+response);
								if (response == 'success') {
									
									location.reload();
									closeaddServiceChargeModal();
								} else if(response == 'failure'){
									document.getElementById('servicechargeAddalertMsg').innerHTML = ''
										+ "Error Occurred" + '';
								} else{
									document.getElementById('servicechargeAddalertMsg').innerHTML = ''
											+ response + '';
								}
							} catch (e) {
								alert(e);
							}
						}, null);
	}
	
	
}

function getvendorledger_sale(group_code,acc_id,ref_id,para)
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


function isNumberKey(evt)
{
   var charCode = (evt.which) ? evt.which : event.keyCode
   if (charCode > 31 && (charCode < 48 || charCode > 57))
      return false;

   return true;
}





//Operation for Add Item from Table Page start (5th Oct 2018)

function shownmenuitemsaddModal()
{
	$('#menuitemAddModal').modal('show');
}
function showalertmenuitemdataopModal()
	{
		$('#alertmenuitemdataopModal').modal('show');
	}
function selectCatValue(catid) {
	var res = catid.split('~');
	var id = res[0];
	var catname = res[1];
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
	if (catname == getBaseLang.splNote) {
		document.getElementById('modaddmenuitemsPrice').value = 0.0;
		document.getElementById('modaddmenuitemsVat').value = 0.0;
		document.getElementById('modaddmenuitemsStax').value = 0.0;
	} else {
		document.getElementById('modaddmenuitemsPrice').value = '';
		document.getElementById('modaddmenuitemsVat').value = vatses;
		document.getElementById('modaddmenuitemsStax').value = staxses;
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


function addMenuItems() {
	document.getElementById('addmenuitemsalertMsg').innerHTML = '';
	var catId = document.getElementById('menusubcategoryId').value;
	var name = decodeURIComponent(document.getElementById('modaddmenuitemsName').value);
	var desc = decodeURIComponent(document.getElementById('modaddmenuitemsDesc').value);
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
		 if (name == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getBaseLang.plsEnterName;
			} else if (desc == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getBaseLang.plsEnterDesc;
			} else if ((/[#%?\/\\]/gi).test(name) || (/[#%?\/\\]/gi).test(desc)) {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getBaseLang.charNotAlowd;
			} else if (isNaN(price) || price == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getBaseLang.plsEnterPrice;
			} else if (isNaN(vat) || vat == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getBaseLang.plsEnterVat;
			} else if (isNaN(stax) || stax == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getBaseLang.plsEnterstax;
			} else if (isNaN(cookingtime) || cookingtime == '') {
				document.getElementById('addmenuitemsalertMsg').innerHTML = getBaseLang.plsEntersCookTime;
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

				$
						.ajax({
							url : BASE_URL + "/menumgnt/addmenuitems.htm",
							type : 'POST',
							contentType : 'application/json;charset=utf-8',
							data : JSON.stringify(maneItemaddPost),
							success : function(response, JSON_UNESCAPED_UNICODE) {
								console.log(response);								
								if (response == 'success') {
									document
											.getElementById('menuitemdataopmassagecont').innerHTML = getBaseLang.datasucAdd;
									showalertmenuitemdataopModal();
								} else {
									document
											.getElementById('menuitemdataopmassagecont').innerHTML = getBaseLang.datasucNotAdd;
									showalertmenuitemdataopModal();
								}
							}
						});
				
			}
	
	
	
}
//Operation for Add Item from Table Page end


// add for view paid bill

function showPaidBill(orderid) //paid bill printing
{   
    var order = {};
	order.id = orderid;
	order.storeId = storeID;
	var ajaxCallObject = new CustomBrowserXMLObject();
		$.ajax({
			type : "POST",
			url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(order),
			success : function(response) {
				var jsonObj = JSON.parse(response);
				/* ***** Store Details ***** */
				
				console.log(response);
				//alert("fghfh"+response);
				var orderNo = jsonObj.id;
				//alert("orderNo"+orderNo);
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

			/* if(tabNo == '0' && parcelAdd == 'Y'){*/
			 if( parcelAdd == 'Y'){
            	      if(orderCustomerName != '' && orderCustomerName != null  && orderCustomerName.length >0){
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
			 
			 $("#printBtn_80").addClass('hidden');
			 $('#cashhelloPrintModal80').modal("show");	
           /* if (paymentsObj == 0) {
				var amt1 = jsonObj.orderBill.billAmount;
				var paidAmt1 = jsonObj.orderBill.billAmount;
				if (amt1 == paidAmt1) {	
					    $("#printBtn_80").addClass('disabled');
						$('#cashhelloPrintModal80').modal("show");		
				}
			}
                                                         
        	if (paymentsObj == 1) {
				var amt1 = jsonObj.payments[0].amount;
				var paidAmt1 = jsonObj.payments[0].paidAmount;
				if (amt1 == paidAmt1) {	
					    $("#printBtn_80").addClass('disabled');
						$('#cashhelloPrintModal80').modal("show");		
				}
			}

			if (paymentsObj == 2) {
				var amt2 = jsonObj.payments[0].amount;
				var paidAmt2 = jsonObj.payments[0].paidAmount + jsonObj.payments[1].paidAmount;
				if (amt2 == paidAmt2) {	
					    $("#printBtn_80").addClass('disabled');
						$('#cashhelloPrintModal80').modal("show");	
				}
			}
		*/

			}
		});	
}


function setOrderItemQtyManually(){
	var itId=document.getElementById('hiddmanualeditItmId').value;
	//document.getElementById('qty'+itId).value=1;
}

function setRemarks(){
	var remarks= document.getElementById('orderRemarksData').value;
	if(remarks == ""){
		document.getElementById('rmkalert').innerHTML ="Please enter remarks.";
		
	}else{
		document.getElementById('rmkalert').innerHTML ="";
		document.getElementById('orderRmks').value = remarks;
		$('#remarksModal').modal('hide');
		
	}
}

