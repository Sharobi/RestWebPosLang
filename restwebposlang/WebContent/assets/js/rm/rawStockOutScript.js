var storeid = $("#hidstoreid").val();
function rowClicked(edpid,
					rawstockoutid,
					rawstockoutstatus) {
	$("#itemdetails").html("");
	$("#clickededpid").val(edpid);
	$("#rawstockoutid").val(rawstockoutid);
	$("#approvediv").removeClass("hide");
	$("#waitimage").removeClass('hide');

	if (rawstockoutid == 0) {
		$("#rawstockoutSave").removeClass('disabled');
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/rawstockout/getrawstockoutitemswithstockoutidzero.htm?edpid=" + edpid + "&rawstockoutid=" + rawstockoutid, function(response) {
			try {
//				console.log(response);
//				$("#itemdetails").html("");
				$("#waitimage").addClass('hide');
				var itemdetails = JSON.parse(response);
				for ( var i = 0; i < itemdetails.length; i++) {
					var itemdetail = itemdetails[i];
					var edpqtytoout = 0;
					if (itemdetail.edpQuantity > itemdetail.currentStockOutQuantityEdpWise) {
						edpqtytoout = itemdetail.edpQuantity - itemdetail.currentStockOutQuantityEdpWise;
					}
					var createdrowline = "";
					var generatedHtml = "";
					var starttrline = "<tr id=" + itemdetail.inventoryItem.id + ">";
					var firsttdline = "<td><input type='hidden'  id='itemcode_" + itemdetail.inventoryItem.id + "' value='" + itemdetail.inventoryItem.code + "' />" + itemdetail.inventoryItem.code + "</td>";
					var secondtdline = "<td><input type='hidden'  id='rawstockoutid_" + itemdetail.inventoryItem.id + "' value='" + rawstockoutid + "' /><input type='hidden'  id='edpid_" + itemdetail.inventoryItem.id + "' value='" + edpid + "' />" + itemdetail.inventoryItem.name + "</td>";
					var thirdtdline = "<td>" + parseFloat(itemdetail.currentQuantity).toFixed(2) + "</td>";
					var fourthtdline = "<td>" + parseFloat(itemdetail.edpQuantity).toFixed(2) + "</td>";
					var fifthtdline = "<td>" + parseFloat(itemdetail.currentStockOutQuantityEdpWise).toFixed(2) + "</td>";
					var sixthtdline = "<td><input type='text' size='4'   id='qtytoout_" + itemdetail.inventoryItem.id + "' value='" + parseFloat(edpqtytoout).toFixed(2) + "' /> </td>";
					var seventhtdline = "<td><input type='hidden'  id='unitid_" + itemdetail.inventoryItem.id + "' value='" + itemdetail.metricUnit.id + "' />" + itemdetail.metricUnit.unit + "</td>";
					var eighttdline = "<td><input type='text' size='4'   id='towhom_" + itemdetail.inventoryItem.id + "' value='--' /> </td>";
					var ninetdline = "<td></td>";
					var endtrline = "</tr>";
					createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventhtdline + eighttdline + ninetdline + endtrline;
					$("#itemdetails").append(createdrowline);
					$("#createTime").val('00:00:00');
				}

			} catch (e) {
				//alert(e);
			}

		}, null);
	} else {
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/rawstockout/getrawstockoutitems.htm?edpid=" + edpid + "&rawstockoutid=" + rawstockoutid, function(response) {
			try {
				$("#rawstockoutSave").addClass('disabled');
//				console.log(response);
				$("#waitimage").addClass('hide');
				var itemdetails = JSON.parse(response);
				for ( var i = 0; i < itemdetails.length; i++) {
					var itemdetail = itemdetails[i];
					var edpqtytoout = 0;
					if (itemdetail.edpQuantity > itemdetail.currentStockOutQuantityEdpWise) {
						edpqtytoout = itemdetail.edpQuantity - itemdetail.currentStockOutQuantityEdpWise;
					}
					var createdrowline = "";
					var generatedHtml = "";
					var starttrline = "<tr id=" + itemdetail.inventoryItems.id + ">";
					var firsttdline = "<td><input type='hidden'  id='itemcode_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.inventoryItems.code + "' />" + itemdetail.inventoryItems.code + "</td>";
					var secondtdline = "<td><input type='hidden'  id='rawstockoutid_" + itemdetail.inventoryItems.id + "' value='" + rawstockoutid + "' /><input type='hidden'  id='edpid_" + itemdetail.inventoryItems.id + "' value='" + edpid + "' />" + itemdetail.inventoryItems.name + "</td>";
					var thirdtdline = "<td>" + parseFloat(itemdetail.currentStock).toFixed(2) + "</td>";
					var fourthtdline = "<td>" + parseFloat(itemdetail.edpQuantity).toFixed(2) + "</td>";
					var fifthtdline = "<td>" + parseFloat(itemdetail.currentStockOutQuantityEdpWise).toFixed(2) + "</td>";
//					var sixthtdline = "<td><input type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + rawstockoutid + ")   id='qtytoout_" + itemdetail.inventoryItems.id + "' value='" + parseFloat(edpqtytoout).toFixed(2) + "' /> </td>";
					var seventhtdline = "<td><input type='hidden'  id='unitid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.unit.id + "' />" + itemdetail.unit.unit + "</td>";
//					var eighttdline = "<td><input type='text' size='4'   id='towhom_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.toWhom + "' /> </td>";
					var ninetdline = "";
					if (rawstockoutstatus == 'Y') {
						ninetdline="<td></td>";
						sixthtdline = "<td><input type='text' disabled='disabled' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + rawstockoutid + ")   id='qtytoout_" + itemdetail.inventoryItems.id + "' value='" + parseFloat(edpqtytoout).toFixed(2) + "' /> </td>";
					    eighttdline = "<td><input type='text' size='4' disabled='disabled' id='towhom_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.toWhom + "' /> </td>";
					}else{
						ninetdline = "<td style='width: 16%;'><a class='btn btn-success' style='background: #78B626' id='itmupdate_" + itemdetail.inventoryItems.id + "' href='javascript:editExistingPOItem(" + itemdetail.inventoryItems.id + "," + edpid + "," + rawstockoutid + "," + itemdetail.id + ")'>Update</a>&nbsp;&nbsp; <a href='javascript:deleteRowForExistingStockOut(" + rawstockoutid + "," + itemdetail.id + "," + itemdetail.inventoryItems.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18' alt='delete item' style='margin-top: 3px;'></td></a>";
						 sixthtdline = "<td><input type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + rawstockoutid + ")   id='qtytoout_" + itemdetail.inventoryItems.id + "' value='" + parseFloat(edpqtytoout).toFixed(2) + "' /> </td>";
						 eighttdline = "<td><input type='text' size='4'   id='towhom_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.toWhom + "' /> </td>";
					}
					var endtrline = "</tr>";
					createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventhtdline + eighttdline + ninetdline + endtrline;
					$("#itemdetails").append(createdrowline);
					$("#createTime").val(itemdetail.time);
				}

			} catch (e) {
				//alert(e);
			}

		}, null);
	}

	if (rawstockoutstatus == 'Y') {
		$("#select1").val('Y');
		$("#appvId").val($("#hidCrtBy").val());
		$('#select1').prop('disabled', true);
		$("#fgstockinapprovedbuttion").addClass('disabled');
		//		$("#rawstockoutSave").addClass('disabled');
	} else {
		$("#select1").val('');
		$("#appvId").val('');
		$('#select1').removeAttr('disabled');
		$("#fgstockinapprovedbuttion").removeClass('disabled');
		//		$("#rawstockoutSave").removeClass('disabled');
	}
}

function rawstockOutSave() {
	var invStockOut1 = {};
	var invStockOut = [];
	var totQty = 0;
	var qtycheck = 0;
	var currstockcheck = 0;
	var nocheck = 0;
	var edpid = 0;
	var creationDate = $("#selecteddate").val();
	var d = new Date();
	var creationDateTime = d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
//	console.log("creationDate=" + creationDate);
//	console.log("creationDateTime=" + creationDateTime);
	$('#saverawstockout > tbody  > tr').each(function() {
//		console.log("tr id=" + this.id);
		var that = this;
		var trid = this.id;
		var qty = $("#qtytoout_" + trid).val();
		var isno = isNaN(qty);
		if (isno) {
			nocheck = 1;
		}
		if (qty <= 0) {
			qtycheck = 1;
		}
		var currentstock = $(that).find("td:eq(4)").html();
		if (qty > Number(currentstock)) {
			currstockcheck = 1;
		}
		totQty = totQty + parseFloat(qty);
		//		var rate = $("#itmrate_" + trid).val();
		var unitid = $("#unitid_" + trid).val();
		var poid = $("#itmpoid_" + trid).val();
		var itmcode = $("#itemcode_" + trid).val();
		var towhom = $("#towhom_" + trid).val();
		edpid = $("#edpid_" + trid).val();
		if ($("#rawstockoutid_" + trid).val() != 0) {
			stockinid = $("#rawstockoutid_" + trid).val();
		}
		//	    $(this).find("td:gt(0)").each(function(){
		//	       });
		if ($("#rawstockoutid_" + trid).val() == 0) {
			var invStockOutItems = {};
			var inventoryItemsarr = {};
			var metricUnit = {};
			invStockOutItems.itemQuantity = qty;
			//			invStockOutItems.itemRate = rate;
			invStockOutItems.currentStockOutQuantityEdpWise = parseFloat($(that).find("td:eq(4)").html());
			invStockOutItems.edpQuantity = parseFloat($(that).find("td:eq(3)").html());
			invStockOutItems.currentStock = parseFloat($(that).find("td:eq(2)").html());
			invStockOutItems.itemQty = parseInt(qty);
			invStockOutItems.toWhom = towhom;
			invStockOutItems.unitId = unitid;
			invStockOutItems.createdDate = creationDate;
			invStockOutItems.time = creationDateTime;
			inventoryItemsarr.id = trid;
			inventoryItemsarr.code = itmcode;
			invStockOutItems.inventoryItems = inventoryItemsarr;
			metricUnit.id = unitid;
			invStockOutItems.unit = metricUnit;
			invStockOutItems.storeId = storeid;
			invStockOut.push(invStockOutItems);
		}
	});
	invStockOut1.inventoryStockOutItems = invStockOut;
	invStockOut1.totalQuantity = totQty;
	invStockOut1.date = creationDate;
	invStockOut1.time = creationDateTime;
	invStockOut1.createdDate = creationDate;
	invStockOut1.edpId = edpid;
	invStockOut1.storeId = storeid;
//	console.log("invStockin1=" + JSON.stringify(invStockOut1));
	//	if (qtycheck == 1) {
	//		$('#positiveitemquantityorrate').modal('show');
	//	} else if (currstockcheck == 1) {
	//		$('#inSufficientStockInAlert').modal('show');
	//	}else if(nocheck==1){
	//		$('#validitemquantityorrate').modal('show');
	//	} else {
	$.ajax({
		url : BASE_URL + "/rawstockout/createstockout.htm",
		type : 'POST',
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(invStockOut1),
		success : function(response) {
			//called when successful
			if (response == 'success') {
				location.href = BASE_URL + '/rawstockout/loadrawstockout.htm';
			}
		},
		error : function(e) {
		}
	});
	//	}
}

function editExistingPOItem(itemid,
							edpid,
							rawstockoutid,
							rowid) {
	//	console.log("itemid=" + itemid);
	//	console.log("stockinid=" + stockinid);
	//	console.log("stockininvid=" + stockininvid);
	//	var vendorid = $("#itmvendorid_" + itemid).val();
	var qty = $("#qtytoout_" + itemid).val();
	var unitid = $("#unitid_" + itemid).val();
	//	var poid = $("#itmpoid_" + itemid).val();
	var itmcode = $("#itemcode_" + itemid).val();
	var towhom = $("#towhom_" + itemid).val();
	var edpid = $("#edpid_" + itemid).val();
	//	console.log("rate=" + rate);
	//	console.log("unitid=" + unitid);
	var d = new Date();
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	//	var isnoqty = isNaN(qty);
	//	var isnorate = isNaN(rate);
	//	if (isnoqty || isnorate || qty == '' || rate == '') {
	//		$("#validitemquantityorrate").modal('show');
	//	} else {
	//		if (qty < 0 || rate < 0) {
	//			$("#positiveitemquantityorrate").modal('show');
	//		} else {

	$('#saverawstockout > tbody  > tr').each(function() {
		var that = this;
		if (this.id == itemid) {
			var invStockOutItems = {};
			var inventoryItemsarr = {};
			var metricUnit = {};
			var inventoryStockOut = {};
			invStockOutItems.id = rowid;
			invStockOutItems.itemQuantity = qty;
			//					invStockOutItems.itemRate = rate;
			invStockOutItems.currentStockOutQuantityEdpWise = parseFloat($(that).find("td:eq(4)").html());
			invStockOutItems.edpQuantity = parseFloat($(that).find("td:eq(3)").html());
			invStockOutItems.currentStock = parseFloat($(that).find("td:eq(2)").html());
			invStockOutItems.itemQty = qty;
			invStockOutItems.toWhom = towhom;
			invStockOutItems.unitId = unitid;
			invStockOutItems.createdDate = creationDate;
			//					invStockOutItems.time=creationDateTime;
			inventoryItemsarr.id = itemid;
			inventoryItemsarr.code = itmcode;
			invStockOutItems.inventoryItems = inventoryItemsarr;
			metricUnit.id = unitid;
			invStockOutItems.unit = metricUnit;
			invStockOutItems.storeId = storeid;
			invStockOutItems.deleteFlag='N';
			invStockOutItems.createdBy=$("#hidCrtBy").val();
			invStockOutItems.updatedBy=$("#hidCrtBy").val();
			invStockOutItems.updatedDate=creationDate;
			inventoryStockOut.id = rawstockoutid;
			inventoryStockOut.edpId = edpid;
			invStockOutItems.inventoryStockOut = inventoryStockOut;
//			console.log("invStockOutItems=" + JSON.stringify(invStockOutItems));
			if(qty === ''){
				document.getElementById('rawstockoutapprovedmodal_alert').innerHTML = getRowStockOutLang.qtyCantBeBlank;
				$("#rawstockoutapprovedmodal_ok").modal('show');
			}else {
				$.ajax({
					url : BASE_URL + "/rawstockout/updaterawstockout.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(invStockOutItems),
					success : function(response) {
						if (response == 'success') {
							$("#itemupdatedmodal").modal('show');
							$("#itmupdate_" + itemid).css('background-color', '#78B626');
						}
					},
					error : function(e) {
					}
				});
			}
			
			
		}
	});
	//		}
	//	}
}

function changeQty(	qty,
					itemid,
					rawstockoutid) {
	$("#itmupdate_" + itemid).css('background-color', 'orange');
}

function getApprovedBy(user) {
	var usrId = document.getElementById('hidCrtBy').value;
	var selectAppvId = document.getElementById('appvId');
	if (user == 'Y') {
		selectAppvId.value = usrId;
	} else {
		selectAppvId.value = '';
	}
}

function approveCall() {
	var rawstockoutid = $("#rawstockoutid").val();
	if (rawstockoutid == 0) {
		$("#savepurchaseorder").modal('show');
	} else {
		var rawstockoutDate = $("#selecteddate").val();
		var rawstockoutCreatedBy = $("#hidCrtBy").val();
		var appvSelect = document.getElementById('select1').value;
		if (appvSelect == 'Y') {
//			console.log("rawstockoutid="+rawstockoutid);
////			console.log("invDate="+invDate);
//			console.log("invCreatedBy="+invCreatedBy);
//			console.log("storeid="+storeid);
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + '/rawstockout/approverawstockout.htm?rawstockoutid=' + rawstockoutid + '&storeid=' + storeid + '&approveby=' + rawstockoutCreatedBy+ '&updatedby=' + rawstockoutCreatedBy+ '&updateddate=' + rawstockoutDate, function(response) {
//				console.log("response="+response);
				if (response == 'success') {
					$('#select1').prop('disabled', true);
					$("#rawstockoutapprovedmodal").modal('show');
					$("#fgstockinapprovedbuttion").addClass('disabled');
				}
			}, null);
		}
	}
}

function deleteRowForExistingStockOut(rawstockoutid,
                                      rawstockoutitemid,
								rowid) {
	$("#hdnrawstockoutid").val(rawstockoutid);
	$("#hdnrawstockoutitemid").val(rawstockoutitemid);
	$("#hdnrawstockoutrowid").val(rowid);
	$("#existingrawstockoutitemdeletemodal").modal('show');
}

function deleteRowForExistingStockOutItem() {
	var rawstockoutid = $("#hdnrawstockoutid").val();
	var rawstockoutitemid = $("#hdnrawstockoutitemid").val();
	var deleterowid=$("#hdnrawstockoutrowid").val();
	$("tr#" + deleterowid + "").remove();
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + '/rawstockout/deleterawstockout.htm?rawstockoutid=' + rawstockoutid + '&rawstockoutitemid=' + rawstockoutitemid + '&storeid=' + storeid, function(response) {
	}, null);
//	calculateGrandTotal();
}
function pagereload(){
	location.reload();
}