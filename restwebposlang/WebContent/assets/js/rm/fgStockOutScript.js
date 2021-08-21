var storeid = $("#hidstoreid").val();
function getSelectedCat() {
	var selectedcat = $("#selectedmenucategoryName").val();
//	console.log("selectedcat=" + selectedcat);
	$("#filterbycat").val(selectedcat).trigger('change');
	;
}

function fgstockoutSave() {
	var selecteddate = $("#selecteddate").val();
	var invCrtBy = $("#invCrtBy").val();
	var fgStockOut = {};
	var fgSaleOutItemsChild = [];
	$("#saverecipe tbody tr").each(function(index) {
		var trid = this.id;
		$row = $(this);
			var fgSaleOutItemChild = {};
			var menuitem = {};
			fgSaleOutItemChild.storeId = storeid;
			fgSaleOutItemChild.itemId = trid;
			fgSaleOutItemChild.stockInQuantity = $row.find("td").eq(5).text();
			fgSaleOutItemChild.saleOutQuantity = $row.find("td").eq(6).text();
			fgSaleOutItemChild.edpQuantity=$row.find("td").eq(4).text();
			fgSaleOutItemChild.currentStock=$row.find("td").eq(7).text();
			fgSaleOutItemChild.createdDate = selecteddate;
			fgSaleOutItemChild.createdBy = invCrtBy;
			fgSaleOutItemChild.deleteFlag = 'N';
			fgSaleOutItemsChild.push(fgSaleOutItemChild);
		
	});
	fgStockOut.fgSaleOutItemsChilds = fgSaleOutItemsChild;
	fgStockOut.createdBy = invCrtBy;
	fgStockOut.createdDate = selecteddate;
	fgStockOut.dateText= selecteddate;
	fgStockOut.deleteFlag = 'N';
	fgStockOut.date = selecteddate;
	fgStockOut.storeId = storeid;
	$.ajax({
		url : BASE_URL + "/fgstockout/createnewfgstockout.htm",
		type : 'POST',
		contentType : 'application/json;charset=utf-8',
		data : JSON.stringify(fgStockOut),
		success : function(response) {
			//called when successful
		//	console.log("response=" + response);
			$("#fgsuccessdmodal").modal('show');
		},
		error : function(e) {
		}
	});
}