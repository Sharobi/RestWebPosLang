var storeid = $("#hidstoreid").val();
function getSelectedCat() {
	var selectedcat = $("#selectedmenucategoryName").val();
	//	console.log("selectedcat=" + selectedcat);
	$("#filterbycat").val(selectedcat).trigger('change');
	;
}

function changeWaste(	currentValue,
						consumeValue,
						currentStock,
						itemid) {
		if (currentStock > 0) {
		var calValue = currentStock - consumeValue;
		if (calValue >= currentValue) {
			$("#restockin_" + itemid).text(parseFloat(calValue - currentValue).toFixed(2));
			$("#saverecipe tbody tr").each(function(index) {
				var trid = this.id;
				if (trid == itemid) {
					var stockin = $("#stockin_" + itemid).text();
					var wasteperc = (currentValue / stockin) * 100;
					$("#wasteperc_" + trid).text(parseFloat(wasteperc).toFixed(2));
				}
			});

		} else {
				var tot = consumeValue + currentValue;
				var check = currentStock - tot;
				if (check >= 0) {
					$("#restockin_" + itemid).text(parseFloat(calValue).toFixed(2));
				}
			$("#saverecipe tbody tr").each(function(index) {
				var trid = this.id;
				if (trid == itemid) {
					$("#waste_" + trid).val(0);
					$("#restockin_" + itemid).text(parseFloat(calValue).toFixed(2));
					$("#wasteperc_" + trid).text(0);
				}
			});

			$("#restockinmodal").modal('show');
		}
	}
}

function changeConsume(	currentValue,
						wasteValue,
						currentStock,
						itemid) {
	if (currentStock > 0) {
		var calValue = currentStock - wasteValue;
		if (calValue >= currentValue) {
			$("#restockin_" + itemid).text(parseFloat(calValue - currentValue).toFixed(2));
		} else {
				var tot = wasteValue + currentValue;
				var check = currentStock - tot;
				if (check >= 0) {
					$("#restockin_" + itemid).text(parseFloat(calValue).toFixed(2));
				}
			$("#saverecipe tbody tr").each(function(index) {
				var trid = this.id;
				if (trid == itemid) {
					$("#consume_" + trid).val(0);
					$("#restockin_" + itemid).text(parseFloat(calValue).toFixed(2));
				}
			});

			$("#restockinmodal").modal('show');
		}
	}
}

function fgCloseSave() {
	var selecteddate = $("#selecteddate").val();
	var invCrtBy = $("#invCrtBy").val();
	var fgClose = {};
	var fgCloseChilds = [];
	$("#saverecipe tbody tr").each(function(index) {
		var trid = this.id;
		$row = $(this);
		var fgCloseChild = {};
		fgCloseChild.storeId = storeid;
		fgCloseChild.itemId = trid;
		fgCloseChild.stockInQuantity = parseFloat($row.find("td").eq(4).text());
		fgCloseChild.saleOutQuantity = parseFloat($row.find("td").eq(5).text());
		fgCloseChild.currentStock = parseFloat($row.find("td").eq(6).text());
		fgCloseChild.waste = $("#waste_" + trid).val();
		fgCloseChild.consume = $("#consume_" + trid).val();
		fgCloseChild.reStockIn = parseFloat($row.find("td").eq(9).text());
		fgCloseChild.variance = parseFloat($row.find("td").eq(10).text());
		fgCloseChild.createdDate = selecteddate;
		fgCloseChild.createdBy = invCrtBy;
		fgCloseChild.deleteFlag = 'N';
		fgCloseChilds.push(fgCloseChild);

	});
	fgClose.fgCloseChilds = fgCloseChilds;
	fgClose.createdBy = invCrtBy;
	fgClose.createdDate = selecteddate;
	fgClose.dateText = selecteddate;
	fgClose.deleteFlag = 'N';
	fgClose.date = selecteddate;
	fgClose.storeId = storeid;
//	console.log("fgClose=" + JSON.stringify(fgClose));
	$.ajax({
		url : BASE_URL + "/fgclose/createfgclose.htm",
		type : 'POST',
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(fgClose),
		success : function(response) {
			//called when successful
			$("#fgsuccessdmodal").modal('show');
		},
		error : function(e) {
		}
	});
}

function getApprovedBy(user) {
	var usrId = document.getElementById('invCrtBy').value;
	var selectAppvId = document.getElementById('appvId');
	if (user == 'Y') {
		selectAppvId.value = usrId;
	} else {
		selectAppvId.value = '';
	}
}

function approveCall() {
	var fgCloseId = $("#fgCloseId").val();
	//	alert("fgCloseId="+fgCloseId);
	if (fgCloseId == 0) {
		$("#savefgclose").modal('show');
	} else {
		var invDate = $("#selecteddate").val();
		var invCreatedBy = $("#invCrtBy").val();
		var appvSelect = document.getElementById('select1').value;
		if (appvSelect == 'Y') {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + '/fgclose/approvedfgclose.htm?storeId=' + storeid + '&fgcloseid=' + fgCloseId + '&approveBy=' + invCreatedBy+ '&updatedBy=' + invCreatedBy+ '&updatedDate=' + invDate, function(response) {
				if (response == 'success') {
					$('#select1').prop('disabled', true);
					$("#fgcloseapprovedmodal").modal('show');
					$("#poapprovedbuttion").addClass('disabled');
				}
			}, null);
		}
	}
}

function loadFGClose(){
	location.reload();
}