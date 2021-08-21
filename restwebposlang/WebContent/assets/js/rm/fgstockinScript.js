var storeid = $("#hidstoreid").val();
function rowClicked(edpid,
					fgstockinid,
					fgStockInStatus) {
	$("#itemdetails").html("");
	$("#clickededpid").val(edpid);
	$("#clickedfgid").val(fgstockinid);
	$("#approvediv").removeClass("hide");
	$("#waitimage").removeClass('hide');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/edp/getedpbystoreidandid.htm?edpid=" + edpid, function(response) {
		try {
			// console.log(response);
			$("#itemdetails").html("");
			$("#waitimage").addClass('hide');
			var itemdetails = JSON.parse(response);
			for ( var i = 0; i < itemdetails.length; i++) {
				var itemdetail = itemdetails[i];
				var createdrowline = "";
				var generatedHtml = "";
				var seventhtdline = "";
				var sixthtdline = "";
				var starttrline = "";
				if(itemdetail.edpStatus=='N'){
					starttrline = "<tr id=" + itemdetail.menuItem.id + " bgcolor='#ff9999'>";
				}else{
					starttrline = "<tr id=" + itemdetail.menuItem.id + ">";
				}
				var firsttdline = "<td>" + itemdetail.menuItem.id + "</td>";
				var secondtdline = "<td><input type='hidden'  id='fgstockinid_" + itemdetail.menuItem.id + "' value='" + fgstockinid + "' />" + itemdetail.menuItem.categoryName + "</td>";
				var thirdtdline = "<td>" + itemdetail.menuItem.subCategoryName + "</td>";
				var fourthtdline = "<td>" + itemdetail.menuItem.name + "</td>";
				var fifthtdline = "<td>" + itemdetail.edProdAmount + "</td>";
				if (fgstockinid == 0) {
					$("#savefgstockin").show();
					sixthtdline = "<td>" + itemdetail.oldStock + "</td>";
					var stkinqty = 0;
					if (itemdetail.oldStock > itemdetail.edProdAmount) {
						stkinqty = itemdetail.oldStock - itemdetail.edProdAmount;
					} else {
						stkinqty = itemdetail.edProdAmount;
					}
					if(itemdetail.edpStatus=='N'){
						seventhtdline = "<td><input type='text' size='4' disabled='disabled' onkeyup=javascript:changeQty(this.value," + itemdetail.menuItem.id + "," + itemdetail.minDuantity + ") id='itmoldstock_" + itemdetail.menuItem.id + "' value='" + stkinqty+ "' /> </td>";
					} else {
						seventhtdline = "<td><input type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.menuItem.id + "," + stkinqty + ") id='itmoldstock_" + itemdetail.menuItem.id + "' value='" + stkinqty + "' /> </td>";
					}
				} else {
					$("#savefgstockin").hide();
					sixthtdline = "<td>" + itemdetail.requiredQuantity + "</td>";
					seventhtdline = "<td><input type='text' size='4' disabled='disabled' onkeyup=javascript:changeQty(this.value," + itemdetail.menuItem.id + "," + itemdetail.minDuantity + ") id='itmoldstock_" + itemdetail.menuItem.id + "' value='" + itemdetail.oldStock + "' /> </td>";
				}
//				var eighttdline = "<td><input type='checkbox' class='cs' name='newsletter' disabled='disabled' value='Monthly' checked style='width: 100%;'></td>";
				var endtrline = "</tr>";
				createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventhtdline  + endtrline;
				$("#itemdetails").append(createdrowline);
			}

		} catch (e) {
			//alert(e);
		}

	}, null);
	if (fgStockInStatus == 'Y') {
		$("#select1").val('Y');
		$("#appvId").val($("#invCrtBy").val());
		$('#select1').prop('disabled', true);
		$("#fgstockinapprovedbuttion").addClass('disabled');
	} else {
		$("#select1").val('');
		$("#appvId").val('');
		$('#select1').removeAttr('disabled');
		$("#fgstockinapprovedbuttion").removeClass('disabled');
	}
}

function getSelectedCat() {
	var selectedcat = $("#selectedmenucategoryName").val();
//	// console.log("selectedcat=" + selectedcat);
	$("#filterbycat").val(selectedcat).trigger('change');
	;
}

function changeQty(	currvalue,
					itemid,
					chvalue) {
	if (currvalue > chvalue) {
		$("#itemquantity").modal('show');
		$("#itmoldstock_" + itemid).val(chvalue);
	} else {

	}
}

function fgstockinSave() {
	var edpid = $("#clickededpid").val();
	var selecteddate = $("#selecteddate").val();
	var invCrtBy = $("#invCrtBy").val();
	var fgStockIn = {};
	var fgStockInItemsChild = [];
	$("#saverecipe tbody tr").each(function(index) {
		var trid = this.id;
		$row = $(this);
		var itmoldstock = $("#itmoldstock_" + trid).val();
		var fgstockinid = $("#fgstockinid_" + trid).val();
		var id = $row.find("td").eq(3).text().toLowerCase();
//		if ($row.find('input[type="checkbox"]').is(':checked') && fgstockinid == 0) {
			if (fgstockinid == 0) {
			var fgStockInItemChild = {};
			var menuitem = {};
			fgStockInItemChild.storeId = storeid;
			fgStockInItemChild.edProdAmount = $row.find("td").eq(4).text();
			fgStockInItemChild.stockInQuantity = itmoldstock;
			fgStockInItemChild.oldStockInQuantity = $row.find("td").eq(5).text();
			fgStockInItemChild.createdDate = selecteddate;
			fgStockInItemChild.createdBy = invCrtBy;
			fgStockInItemChild.fgStatus = 'Y';
			menuitem.id = trid;
			fgStockInItemChild.menuItem = menuitem;
			fgStockInItemsChild.push(fgStockInItemChild);
		} else {
			// console.log("id=" + id);
			// console.log("false");
		}
	});
	fgStockIn.fgStockInItemsChilds = fgStockInItemsChild;
	fgStockIn.edpId = edpid;
	fgStockIn.createdBy = invCrtBy;
	fgStockIn.createdDate = selecteddate;
	//	fgStockIn.date = selecteddate;
	fgStockIn.currentItems = 1;
	fgStockIn.deleteFlag = "N";
	fgStockIn.estimatedItems = 1;
	fgStockIn.storeId = storeid;
	//	// console.log("fgStockIn=" + JSON.stringify(fgStockIn));
	$.ajax({
		url : BASE_URL + "/fgstockin/createnewfgstockin.htm",
		type : 'POST',
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(fgStockIn),
		success : function(response) {
			//called when successful
//			// console.log("response=" + response);
			rowClicked(edpid,response,'');
			$("#clickedfgid").val(response);
			$("#fgsuccessdmodal").modal('show');
//			location.reload();
			
			$("#savefgstockin").hide();
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
	var clickedfgid = $("#clickedfgid").val();
	var clickededpid = $("#clickededpid").val();
	if (clickedfgid == 0) {
		$("#savepurchaseorder").modal('show');
	} else {
		var invDate = $("#invCrtDate").val();
		var invCreatedBy = $("#invCrtBy").val();
		var appvSelect = document.getElementById('select1').value;
		if (appvSelect == 'Y') {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + '/fgstockin/approvedFGStockin.htm?storeId=' + storeid + '&fgstockinid=' + clickedfgid + '&approveBy=' + invCreatedBy, function(response) {
				if (response == 'success') {
					$('#select1').prop('disabled', true);
					$("#poapprovedmodal").modal('show');
					$("#fgstockinapprovedbuttion").addClass('disabled');
					rowClicked(clickededpid, clickedfgid, 'Y');
				}
			}, null);
		}
	}
}

function approveFGStockin(){
	location.reload();
}

function saveFGStockin() {
	location.reload();
}

