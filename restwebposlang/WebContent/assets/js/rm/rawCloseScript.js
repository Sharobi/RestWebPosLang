var storeid = $("#hidstoreid").val();
function getSelectedCat() {
	var selectedcat = $("#selectedmenucategoryName").val();
	//	console.log("selectedcat=" + selectedcat);
	$("#filterbycat").val(selectedcat).trigger('change');
	;
}

function rawCloseSave() {
	$("#rawcloseSave").addClass("disabled");
	var selecteddate = $("#selecteddate").val();
	var invCrtBy = $("#invCrtBy").val();
	var rawClose = {};
	var rawCloseChilds = [];
	$("#saverecipe tbody tr").each(function(index) {
		var trid = this.id;
		$row = $(this);
		var unitid = $("#itmunitid_" + trid).val();
		var rawCloseChild = {};
		rawCloseChild.storeId = storeid;
		rawCloseChild.itemId = trid;
		rawCloseChild.stockInQuantity = parseFloat($row.find("td").eq(2).text());
		rawCloseChild.unitId = unitid;
		rawCloseChild.stockOutQuantity = parseFloat($row.find("td").eq(4).text());
		rawCloseChild.calculatedStock = parseFloat($row.find("td").eq(5).text());
		rawCloseChild.physicalStock = parseFloat($row.find("td").eq(6).text());
		rawCloseChild.waste = $("#waste_" + trid).val();
		rawCloseChild.consume = $("#consume_" + trid).val();
		rawCloseChild.varience = $row.find("td").eq(9).text();
		rawCloseChild.createdDate = selecteddate;
		rawCloseChild.createdBy = invCrtBy;
		rawCloseChild.deleteFlag = 'N';
		rawCloseChilds.push(rawCloseChild);

	});
	rawClose.rawCloseChilds = rawCloseChilds;
	rawClose.createdBy = invCrtBy;
	rawClose.createdDate = selecteddate;
	rawClose.dateText = selecteddate;
	rawClose.deleteFlag = 'N';
	//	rawClose.date = selecteddate;
	rawClose.storeId = storeid;
//	console.log("rawClose=" + JSON.stringify(rawClose));
	$.ajax({
		url : BASE_URL + "/rawclose/createrawclose.htm",
		type : 'POST',
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(rawClose),
		success : function(response) {
			//called when successful
			$("#rawsuccessdmodal").modal('show');
			$("#rawcloseSave").removeClass("disabled");
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
	var rawcloseid = $("#rawCloseId").val();
	if (rawcloseid == 0) {
		$("#saverawclose").modal('show');
	} else {
		var rawcloseDate = $("#selecteddate").val();
		var rawcloseCreatedBy = $("#invCrtBy").val();
		var appvSelect = document.getElementById('select1').value;
		if (appvSelect == 'Y') {
			/*console.log("rawcloseid="+rawcloseid);
			console.log("rawcloseDate="+rawcloseDate);
			console.log("rawcloseCreatedBy="+rawcloseCreatedBy);
			console.log("storeid="+storeid);*/
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + '/rawclose/approvedrawclose.htm?rawcloseid=' + rawcloseid + '&storeId=' + storeid + '&approveBy=' + rawcloseCreatedBy + '&updatedBy=' + rawcloseCreatedBy + '&updatedDate=' + rawcloseDate, function(response) {
				console.log("response=" + response);
				if (response == 'success') {
					$('#select1').prop('disabled', true);
					$("#rawcloseapprovedmodal").modal('show');
					$("#fgstockinapprovedbuttion").addClass('disabled');
				}
			}, null);
		}
	}
}

function loadRawClose() {
	location.reload();
}