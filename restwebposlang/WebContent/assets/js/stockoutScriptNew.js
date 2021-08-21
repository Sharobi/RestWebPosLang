function newStockOut() {
	$("#itemdetails").html("");
	$("#searchDiv").show();
	var d = new Date();
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	$("#createDate").val(creationDate);
	$("#stockoutDate").val(creationDate);
	$("#createTime").val("00:00:00");
	$("#stockoutId").val(0);
}

function addNewStockOut() {
	var itemcode = $("#searchCode").val();
	console.log("itemcode=" + itemcode);
	$("#stockInSave").removeClass('disabled');
	var itempresent = 0;
	$('#stockoutItemTable > tbody  > tr').each(function() {
		var itcode = $(this).find("td:eq(0)").html().split(">")[1];
		if (itcode == itemcode) {
			itempresent = 1;
		}
		//	    $(this).find("td:gt(0)").each(function(){
		//	       console.log("hi="+$(this).html());
		//	       });
	});
	if (itempresent == 1) {
		$('#alreadyexistitem').modal('show');
	} else {
		var list = $("#menucatlst").html();
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/inventorynew/getinventoryitemdetails/" + itemcode + ".htm", function(response) {
			console.log("response=" + response);
			var itemdetail = JSON.parse(response);
			var createdrowline = "";
			var starttrline = "<tr id=" + itemdetail.id + ">";
			var firsttdline = "<td><input type='hidden'  id='stockinitmcode_" + itemdetail.id + "' value='" + itemdetail.code + "' />" + itemdetail.code + "</td>";
			var secondtdline = "<td><input type='hidden'  id='stockinid_" + itemdetail.id + "' value='0' />" + itemdetail.name + "</td>";
			var thirdtdline = "<td><input type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.id + "," + itemdetail.shippingCharge + ") id='itmqty_" + itemdetail.id + "' value='" + itemdetail.quantity + "' /></td>";
			var fourthtdline = "<td><input type='hidden'  id='itmunitid_" + itemdetail.id + "' value='" + itemdetail.metricUnitId + "' />" + itemdetail.unit + "</td>";
			var fifthtdline = "<td>" + parseFloat(itemdetail.stockAvailable).toFixed(2) + "</td>";
			var sixthtdline = "<td>" + list + "</td>";
			var seventdline = "<td><a href='javascript:deleteRowId(" + itemdetail.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></td></a>";
			var endtrline = "</tr>";
			createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventdline + endtrline;
			$("#itemdetails").append(createdrowline);
			$("#searchCode").val("");
			$("#search").val("");
			$("#stockOutSave").removeClass('disabled');
			//			calculateGrandTotal();
		}, null);
	}
}

function deleteRowId(deleterowid) {
	$("#hdnItemStockoutId").val(deleterowid);
	$('#stockoutitemdeletemodal').modal('show');
}
function deleteStockoutItem() {
	var delitemid = $("#hdnItemStockoutId").val();
	$("tr#" + delitemid + "").remove();
}

function changeQty(	qty,
					itemid,
					shcharge) {
	var isno = isNaN(qty);
	if (isno) {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (qty < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} 
	}
}

function stockOutSave() {
	$("#stockOutSave").addClass('disabled');
	var invStockOut1 = {};
	var invStockOut = [];
	var totQty = 0;
	var qtycheck = 0;
	var currstockcheck = 0;
	var nocheck=0;
	var creationDate =$("#stockoutDate").val();
	var d = new Date();
	var mint = d.getMinutes();
	var second =  d.getSeconds();
	
	  if(mint < 10){
		  mint =  "0"+mint;
	  }else {
		  mint = d.getMinutes();
	  }
	  if(second < 10){
		  second = "0"+second;
	  }else{
		  second = d.getSeconds();
	  }
	  
	 var length = 0;
	 $('#stockoutItemTable > tbody  > tr').each(function() {
		 length++; 
	 });
	  
  if(length>0){
	  
	 var creationDateTime = d.getHours() + ":" + mint + ":" + second;	  
	console.log("creationDate="+creationDate);
	console.log("creationDateTime="+creationDateTime);
	$('#stockoutItemTable > tbody  > tr').each(function() {
		var that = this;
		var trid = this.id;
	    var invStockOutItems = {};
		var inventoryItemsarr = {};
		var matricUnit = {};
		
		invStockOutItems.approveFlag="Y";
		invStockOutItems.edpQuantity=0;
		invStockOutItems.itemQuantity = $("#itmqty_"+trid).html();
		invStockOutItems.itemRate = $("#itmrate_"+trid).html();
		invStockOutItems.unitId = $("#itmunitid_"+trid).html();
		invStockOutItems.unitName = $("#itmunit_"+trid).html()
		invStockOutItems.itemTotalPrice=$("#itmgross_"+trid).html();
		invStockOutItems.discPer=0;
		invStockOutItems.discAmt=0;	
		invStockOutItems.isTaxExclusive=$("#itmtaxmode_"+trid).html();	
		invStockOutItems.taxRate=$("#itmtaxrate_"+trid).html();	
		invStockOutItems.taxAmount=$("#itmtaxamt_"+trid).html();	
		invStockOutItems.itemNetAmount=$("#itmnetamt_"+trid).html();	
		invStockOutItems.createdDate=creationDate;
		invStockOutItems.time=creationDateTime;
		invStockOutItems.storeId=storeID;
		matricUnit.id=$("#itmunitid_"+trid).html();
		invStockOutItems.unit=matricUnit;
		inventoryItemsarr.id = trid;
		inventoryItemsarr.code = $("#itmcode_"+trid).html();;
		invStockOutItems.inventoryItems = inventoryItemsarr;
		invStockOut.push(invStockOutItems);
		
	});
	invStockOut1.approved="Y"
	invStockOut1.id=$("#stockoutId").val();	
	invStockOut1.inventoryStockOutItems = invStockOut;
	invStockOut1.totalQuantity = totQty;
	invStockOut1.date=creationDate;
	invStockOut1.time=creationDateTime;
	invStockOut1.createdDate=creationDate;
	invStockOut1.itemTotal=$("#grossAmtId").val();	
	invStockOut1.discPer=0;
	invStockOut1.discAmt=0;
	invStockOut1.taxAmt=$("#totTaxAmtId").val();
	invStockOut1.roundOffAmt=$("#roundOffAmtId").val();
	invStockOut1.totalPrice=$("#grandTotAmtId").val();
	invStockOut1.edpId=0;
	console.log(JSON.stringify(invStockOut1));
	
	if (qtycheck == 1) {
		$('#positiveitemquantityorrate').modal('show');
		$("#stockOutSave").removeClass('disabled');
	} else if (currstockcheck == 1) {
		$('#inSufficientStockInAlert').modal('show');
		$("#stockOutSave").removeClass('disabled');
	}else if(nocheck==1){
		$('#validitemquantityorrate').modal('show');
		$("#stockOutSave").removeClass('disabled');
	} else {
		$.ajax({
			url : BASE_URL + "/stockoutnew/createstockout.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(invStockOut1),
			success : function(response) {
				if (response == 'success') {
					location.href = BASE_URL + '/stockoutnew/loadstockout.htm';
				}else{
						$("#stockOutSave").removeClass('disabled');
					    var operation = "";
						if($("#stockoutId").val() == 0){
							operation = "Saved";
						}else{
							operation = "Updated";
						}
						$("#msgspace").html("Error!! Stockout Not "+operation+" Successfully.");
						$("#msgmodal").modal('show');
				}
			},
			error : function(e) {
			}
		});
	}
  }else{
	   $("#stockOutSave").removeClass('disabled');
	   $("#msgspace").html("Nothing To Save.");
	   $("#msgmodal").modal('show'); 
  }
}

function rowClicked(id) {
	$("#inventoryStockOutListTbl").css("pointer-events", "none");
	$("#stockoutItemTableDiv").addClass('hide');
	$("#waitimage").removeClass('hide');
	var selectDate = $("#stockoutDate").val();
	$("#selectedstockinid").val(id);
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/stockoutnew/getstockOutdetailsbyid/" + id + "/" + selectDate + ".htm", function(response) {
		console.log("response=" + response);
		var stockoutdetail = JSON.parse(response);
		$("#itemdetails").html("");
		for ( var i = 0; i < stockoutdetail.length; i++) {
			var invstockOutItems = stockoutdetail[i];
			
			for ( var j = 0; j < invstockOutItems.inventoryStockOutItems.length; j++) {
				var itemdetail = invstockOutItems.inventoryStockOutItems[j];
				var createdrowline = "";
				var starttrline = "<tr id=" + itemdetail.inventoryItems.id + ">";
				var firsttdline = "<td id='itmcode_"+itemdetail.inventoryItems.id+"'>" + itemdetail.inventoryItems.code + "</td>";
				var secondtdline = "<td id='itmname_"+itemdetail.inventoryItems.id+"'>" + itemdetail.inventoryItems.name + "</td>";
				var thirdtdline = "<td id='itmqty_"+itemdetail.inventoryItems.id+"'>"+ itemdetail.itemQuantity +"</td>";
				var fourthtdline = "<td id='itmunit_"+itemdetail.inventoryItems.id+"'>" + itemdetail.unit.unit + "</td>";
				var fifthtdline = "<td id='itmrate_"+itemdetail.inventoryItems.id+"'>" + parseFloat(itemdetail.itemRate).toFixed(2) + "</td>";
				var sixtdline = "<td style='display:none;' id='itmistax_"+itemdetail.inventoryItems.id+"'></td>";
				var seventdline="<td style='display:none;' id='itmunitid_"+itemdetail.inventoryItems.id+"'>"+itemdetail.unit.id +"</td>";
				var eighthtdline = "<td style='display:none;' id='itmtaxmode_"+itemdetail.inventoryItems.id+"'>" + itemdetail.isTaxExclusive + "</td>";
				var ninthtdline = "<td id='itmgross_"+itemdetail.inventoryItems.id+"'>" + parseFloat(itemdetail.itemTotalPrice).toFixed(2) + "</td>";
				var eleventhtdline ="<td id='itmtaxrate_"+itemdetail.inventoryItems.id+"'>" + parseFloat(itemdetail.taxRate).toFixed(2) + "</td>";
				var twelvthtdline ="<td id='itmtaxamt_"+itemdetail.inventoryItems.id+"'>" + parseFloat(itemdetail.taxAmount).toFixed(2) + "</td>";
				var thirteenthtdline ="<td id='itmnetamt_"+itemdetail.inventoryItems.id+"'>" + parseFloat(itemdetail.itemNetAmount).toFixed(2) + "</td>";
				var endtrline = "</tr>";
				
				createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixtdline+ seventdline + eighthtdline +ninthtdline  + eleventhtdline + twelvthtdline  + thirteenthtdline + endtrline;
				
				$("#stockoutItemTableDiv").removeClass('hide');
				$("#waitimage").addClass('hide');
				$("#inventoryStockOutListTbl").css("pointer-events", "");
				
				$("#itemdetails").append(createdrowline);
				/*if (itemdetail.approveFlag == 'Y') {
					$("#searchDiv").hide();
					$("#stockOutSave").addClass('disabled');
				} else {
					$("#searchDiv").show();
					$("#stockOutSave").removeClass('disabled');
				}*/
			}
			$("#stockoutDate").val(invstockOutItems.createdDate);
			$("#createDate").val(invstockOutItems.createdDate);
			$("#createTime").val(invstockOutItems.time);
			$("#createdBy").val(invstockOutItems.createdBy);
			$("#stockoutId").val(invstockOutItems.id);
			setButton();
			
			$("#grossAmtId").val(parseFloat(invstockOutItems.itemTotal).toFixed(2));
			$("#totTaxAmtId").val(parseFloat(invstockOutItems.taxAmt).toFixed(2));
			$("#totalAmtId").val(parseFloat(invstockOutItems.itemTotal + invstockOutItems.taxAmt).toFixed(2));
			$("#roundOffAmtId").val(parseFloat(invstockOutItems.roundOffAmt).toFixed(2));
			$("#grandTotAmtId").val(parseFloat(invstockOutItems.totalPrice).toFixed(2));
			
			
		}
	}, null);
}

function setButton(){
	var stockoutid = $("#stockoutId").val();
	var activebutton="";
	if(stockoutid == '0'){
		activebutton ="<a href='javascript:stockOutSave()' id='stockOutSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Save</a>";

	}
	else{
		activebutton ="<a href='javascript:stockOutSave()' id='stockOutSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;'>Update</a>";

	}
	document.getElementById("buttonspace").innerHTML = activebutton;
}
function getStockOutByDate() {
	var selectDate = $("#stockoutDate").val();
	console.log("selectDate=" + selectDate);
	location.href = BASE_URL + "/stockoutnew/getstockOutdetailsbydate/" + selectDate + ".htm";
}

function viewPurchaseOrder() {
//	var selectedpoid = $("#selectedstockinid").val();
//	console.log("selectedstockinid=" + selectedstockinid);
//	console.log("$('#stockinItemTable > tbody  > tr').="+$('#stockinItemTable > tbody  > tr').length);
//	var tableDatalen=$('#stockinItemTable > tbody  > tr').length;
//	if (selectedpoid == 0 && tableDatalen>0) {
//		$("#displayPOPage").modal('show');
//	} else {
			location.href = BASE_URL+'/inventorynew/loadinventory.htm';
//	}
}

function viewPurchaseOrderPage(){
	location.href = BASE_URL+'/inventorynew/loadinventory.htm';
}

function viewStockIn() {
	location.href = BASE_URL + '/stockinnew/loadstockin.htm';
}
function viewPurchaseReturnPage(){
	location.href = BASE_URL + '/purchasereturn/loadpurchasereturn.htm';
	
}

//new added 

function viewItemStockInsertPage(){
	location.href = BASE_URL + '/itemstockin/loaditemstockin.htm';
	
}