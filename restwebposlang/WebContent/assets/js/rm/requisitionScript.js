function rowClicked(edpid,
					poid,
					postatus) {
	//alert("clicked"+postatus);
	$("#itemdetails").html("");
	$("#selectedpoid").val(poid);
	$("#clickededpid").val(edpid);
	$("#clickedpoid").val(poid);
	$("#waitimage").removeClass('hide');
	$('.selectedvendor').removeAttr('disabled');
	$("#misChargeId").val("0.00"); //////////
	setActiveButton();//new
	if (poid == 0) {  // data for save part
		//alert("po 0");
		$("#poOrderSave").removeClass('disabled');
		$("#misChargeId").removeAttr("disabled");
		if (postatus == 'Y') {
			$("#select1").val(postatus);
			$("#appvId").val($("#invCrtBy").val());
			$('#select1').prop('disabled', true);
			$("#poapprovedbuttion").addClass('disabled');
			$("#misChargeId").attr("disabled", "disabled");
			$("#printreq").removeAttr("disabled");
		} else {
			$("#select1").val('');
			$("#appvId").val('');
			$('#select1').removeAttr('disabled');
			$("#poapprovedbuttion").removeClass('disabled');
			$("#misChargeId").removeAttr("disabled");
			$("#printreq").attr("disabled", "disabled");
		}
		var ajaxCallObject1 = new CustomBrowserXMLObject();
		ajaxCallObject1.callAjax(BASE_URL + "/requisition/getrequisitionbyidsandpoidzero/" + edpid + "/" + poid + ".htm", function(response) {
			try {
				$("#itemdetails").html("");
				$("#waitimage").addClass('hide');
				console.log("response1111=" + response);
				var itemdetails = JSON.parse(response);
				for ( var i = 0; i < itemdetails.length; i++) {
					var itemdetail = itemdetails[i];
					//alert("id:"+itemdetail.inventoryItem.id);
					var qtytobuy = 0.00;
					if (itemdetail.currentQuantity >= itemdetail.edpQuantity) {
						qtytobuy = 0.00;
					} else {
						qtytobuy = parseFloat(itemdetail.edpQuantity - itemdetail.currentQuantity).toFixed(2);
					}
					var createdrowline = "";
					var action_tdline = "";
					var starttrline = "<tr id=" + itemdetail.inventoryItem.id + ">";					
					var item_code_tdline = "<td id='itmcodetd_" + itemdetail.inventoryItem.id + "'><input type='hidden'  id='edpid_" + itemdetail.inventoryItem.id + "' value='" + edpid + "' />" + itemdetail.inventoryItem.code + "</td>";					
					var item_name_tdline = "<td id='itmnametd_" + itemdetail.inventoryItem.id + "'><input type='hidden'  id='poid_" + itemdetail.inventoryItem.id + "' value='" + poid + "' />" + itemdetail.inventoryItem.name + "</td>";					
					var item_current_qty_tdline = "<td id='itmcurrentqtytd_" + itemdetail.inventoryItem.id + "'>" + parseFloat(itemdetail.currentQuantity).toFixed(2) + "</td>";
					var item_edp_required_qty_tdline = "<td id='itmedprequeredqtytd_"+ itemdetail.inventoryItem.id + "'>" + parseFloat(itemdetail.edpQuantity).toFixed(2) + "</td>";
					var item_qty_to_buy_tdline = "<td id='itmqtytobuytd_"+ itemdetail.inventoryItem.id + "'><input type='text' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItem.id + "," + itemdetail.inventoryItem.shippingCharge + ","+ itemdetail.inventoryItem.taxRate +") onkeydown=numcheck(event) id='itmqty_" + itemdetail.inventoryItem.id + "' value='" + parseFloat(qtytobuy).toFixed(2) + "' /></td>";
					var item_unit_tdline = "<td id='itmunittd_"+ itemdetail.inventoryItem.id + "'><input type='hidden'  id='itmunitid_" + itemdetail.inventoryItem.id + "' value='" + itemdetail.metricUnit.id + "' />" + itemdetail.metricUnit.unit + "</td>";
					var item_rate_tdline = "<td id='itmrate_" + itemdetail.inventoryItem.id + "'>" + itemdetail.inventoryItem.rate + "</td>";
					var item_shipping_chrg_tdline = "<td style='display:none'><input type='text' size='4' onkeyup=javascript:changeShippingCharge(this.value," + itemdetail.inventoryItem.id + "," + qtytobuy + ") id='itmshchrg_" + itemdetail.inventoryItem.id + "' value='" + itemdetail.inventoryItem.shippingCharge + "' /></td>";
					var item_tax_rate_tdline = "<td id='itmtaxtd_" + itemdetail.inventoryItem.id + "'><input type='hidden' size='4'  id='itmtaxchrg_" + itemdetail.inventoryItem.id + "' value='" + itemdetail.inventoryItem.taxRate + "' />" +parseFloat(itemdetail.inventoryItem.taxRate).toFixed(2) +"</td>"; // new added
					var grossamt =Number(qtytobuy) * Number(itemdetail.inventoryItem.rate); //new added
					var taxamt = ((Number(grossamt)  * Number(itemdetail.inventoryItem.taxRate)) /100);
					var item_tax_amt_tdline = "<td id='itmtaxamttd_" + itemdetail.inventoryItem.id + "' style='display:none' >"+parseFloat(taxamt).toFixed(2) +"</td>"; // new added
					var item_gross_amt_tdline = "<td id='itmgrossamttd_" + itemdetail.inventoryItem.id + "' style='display:none'><input type='hidden' size='4'  id='itmgrossamt_" + itemdetail.inventoryItem.id + "' value='" + grossamt + "' />" +parseFloat(grossamt).toFixed(2) +"</td>"; // new added
					var tax_exclusive_tdline = "<td id='itmistaxexlusivetd_" + itemdetail.inventoryItem.id + "' style='display:none;'><input type='text' size='4'  id='itmistaxexclusive_" + itemdetail.inventoryItem.id + "' value='" + itemdetail.inventoryItem.isTaxExclusive + "' /></td>"; // new added
					var td_id_tdline = "<td id='tdidtd_" + itemdetail.inventoryItem.id + "' style='display:none;'>"+itemdetail.inventoryItem.id+"</td>"; // new added
					
					var itemtotal = 0.0;
					if(itemdetail.inventoryItem.isTaxExclusive == 'Y'){
						itemtotal = parseFloat(Number(qtytobuy) * (Number(itemdetail.inventoryItem.rate) + (Number(itemdetail.inventoryItem.rate) * Number(itemdetail.inventoryItem.taxRate)/100))).toFixed(2) + "</td>"; //modified
					}
					else{
						itemtotal = grossamt;
					}
					var item_net_total_tdline = "<td id='itmtot_" + itemdetail.inventoryItem.id + "'>" + parseFloat(itemtotal).toFixed(2) + "</td>"; //modified
					var item_vendor_tdline = "<td id='itmvendorid_" + itemdetail.inventoryItem.id + "' style='display:none'>" + $("#vendorsList").html() + "</td>";
					//var eleventdline = "<td><a href='javascript:deleteRowIdExistingEDP(" + itemdetail.id + "," + itemdetail.menuItem.id + "," + edpid + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
					if (poid == 0) {
						action_tdline = "<td><a href='javascript:deleteRowForExistingPO(" + itemdetail.inventoryItem.id + "," + edpid + "," + itemdetail.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18' alt='delete item'></a></td>";
					} /*else {
						action_tdline = "<td><a class='btn btn-success' style='background: #78B626' id='itmupdate_" + itemdetail.inventoryItem.id + "' href='javascript:editExistingPOItem(" + itemdetail.inventoryItem.id + "," + itemdetail.id + ")'>Update</a>&nbsp;&nbsp;&nbsp; <a href='javascript:deleteRowForExistingPO(" + itemdetail.inventoryItem.id + "," + edpid + "," + itemdetail.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18' alt='delete item'></a></td>";
					}*/
					var endtrline = "</tr>";
					createdrowline = starttrline + item_code_tdline + item_name_tdline + item_current_qty_tdline + item_edp_required_qty_tdline + item_qty_to_buy_tdline + item_unit_tdline + item_rate_tdline + item_shipping_chrg_tdline + item_tax_rate_tdline + item_tax_amt_tdline + item_gross_amt_tdline + tax_exclusive_tdline + td_id_tdline + item_net_total_tdline + item_vendor_tdline + action_tdline + endtrline;
					$("#itemdetails").append(createdrowline);
					$("#itemdetails tr#" + itemdetail.inventoryItem.id + " .selectedvendor > [value=" + itemdetail.inventoryItem.vendorId + "]").attr("selected", "true");
					
				}
				calculateGrandTotal();
			} catch (e) {
				//alert(e);
			}

		}, null);
	} else {   // data for update part
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/requisition/getrequisitionbyidsnew/" + edpid + "/" + poid + ".htm", function(response) {
			try {
				$("#itemdetails").html("");
				$("#waitimage").addClass('hide');
			    console.log("response=" + response);
				var itemdetails = JSON.parse(response);
				for ( var i = 0; i < itemdetails.length; i++) {
					var itemdetailheader = itemdetails[i];
					$("#selectedPovendorId").val(itemdetailheader.vendorId);
					$("#selectedPovendorId").prop("disabled", true);
					for ( var j = 0; j < itemdetailheader.inventoryPurchaseOrderItems.length; j++) {
						var itemdetail = itemdetailheader.inventoryPurchaseOrderItems[j];
						var createdrowline = "";
					    var action_tdline = "";
					    var starttrline = "<tr id=" + itemdetail.inventoryItems.id + ">";					
					    var item_code_tdline = "<td id='itmcodetd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='edpid_" + itemdetail.inventoryItems.id + "' value='" + edpid + "' />" + itemdetail.inventoryItems.code + "</td>";					
					    var item_name_tdline = "<td id='itmnametd_" + itemdetail.inventoryItems.id + "'><input type='hidden'  id='poid_" + itemdetail.inventoryItems.id + "' value='" + poid + "' />" + itemdetail.inventoryItems.name + "</td>";					
					    var item_current_qty_tdline = "<td id='itmcurrentqtytd_" + itemdetail.inventoryItems.id + "'>" + parseFloat(itemdetail.oldStock).toFixed(2) + "</td>";
					    var item_edp_required_qty_tdline = "<td id='itmedprequeredqtytd_"+ itemdetail.inventoryItems.id + "'>" + parseFloat(itemdetail.requiredQuantity).toFixed(2) + "</td>";
					    var item_qty_to_buy_tdline = "";
					    var item_unit_tdline = "<td id='itmunittd_"+ itemdetail.inventoryItems.id + "'><input type='hidden'  id='itmunitid_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.unitId + "' />" + itemdetail.metricUnit.unit + "</td>";
					    var item_rate_tdline = "<td id='itmrate_" + itemdetail.inventoryItems.id + "'>" + itemdetail.rate + "</td>";
					    var item_shipping_chrg_tdline = "";
					    var item_tax_rate_tdline = "<td id='itmtaxtd_" + itemdetail.inventoryItems.id + "'><input type='hidden' size='4'  id='itmtaxchrg_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.taxRate + "' />" +parseFloat(itemdetail.taxRate).toFixed(2) +"</td>"; // new added
					    var item_tax_amt_tdline = "<td id='itmtaxamttd_" + itemdetail.inventoryItems.id + "' style='display:none' >"+parseFloat(itemdetail.taxAmt).toFixed(2) +"</td>"; // new added
					    var item_gross_amt_tdline = "<td id='itmgrossamttd_" + itemdetail.inventoryItems.id + "' style='display:none'><input type='hidden' size='4'  id='itmgrossamt_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.itemTotalPrice + "' />" +parseFloat(itemdetail.itemTotalPrice).toFixed(2) +"</td>"; // new added
					    var tax_exclusive_tdline = "<td id='itmistaxexlusivetd_" + itemdetail.inventoryItems.id + "' style='display:none;'><input type='text' size='4'  id='itmistaxexclusive_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.isTaxExclusive + "' /></td>"; // new added
					    var td_id_tdline = "<td id='tdidtd_" + itemdetail.inventoryItems.id + "' style='display:none;'>"+itemdetail.inventoryItems.id+"</td>"; // new added
					    var item_net_total_tdline = "<td id='itmtot_" + itemdetail.inventoryItems.id + "'>" + parseFloat(itemdetail.totalAmt).toFixed(2) + "</td>"; //modified
					    var item_vendor_tdline = "<td id='itmvendorid_" + itemdetail.inventoryItems.id + "' style='display:none'>" + $("#vendorsList").html() + "</td>";
					
					    if (postatus == 'Y') {
						    action_tdline = "<td></td>";
						    item_qty_to_buy_tdline = "<td id='itmqtytobuytd_"+ itemdetail.inventoryItems.id + "'><input type='text' disabled='disabled' size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.shippingCharge + ","+ itemdetail.taxRate +") onkeydown=numcheck(event) id='itmqty_" + itemdetail.inventoryItems.id + "' value='" + parseFloat(itemdetail.itemQuantity).toFixed(2) + "' /></td>";
						    item_shipping_chrg_tdline = "<td style='display:none'><input type='text' disabled='disabled' size='4' onkeyup=javascript:changeShippingCharge(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.itemQuantity + ") id='itmshchrg_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.shippingCharge + "' /></td>";
						
					    	} else {
					 		 item_qty_to_buy_tdline = "<td id='itmqtytobuytd_"+ itemdetail.inventoryItems.id + "'><input type='text'  size='4' onkeyup=javascript:changeQty(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.shippingCharge + ","+ itemdetail.taxRate +") onkeydown=numcheck(event) id='itmqty_" + itemdetail.inventoryItems.id + "' value='" + parseFloat(itemdetail.itemQuantity).toFixed(2) + "' /></td>";
							 item_shipping_chrg_tdline = "<td style='display:none'><input type='text'  size='4' onkeyup=javascript:changeShippingCharge(this.value," + itemdetail.inventoryItems.id + "," + itemdetail.itemQuantity + ") id='itmshchrg_" + itemdetail.inventoryItems.id + "' value='" + itemdetail.shippingCharge + "' /></td>";
							 action_tdline = "<td><a href='javascript:deleteRowForExistingPO(" + itemdetail.inventoryItems.id + "," + edpid + "," + itemdetail.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18' alt='delete item'></a></td>";						
						}

					
					var endtrline = "</tr>";
					createdrowline = starttrline + item_code_tdline + item_name_tdline + item_current_qty_tdline + item_edp_required_qty_tdline + item_qty_to_buy_tdline + item_unit_tdline + item_rate_tdline + item_shipping_chrg_tdline + item_tax_rate_tdline + item_tax_amt_tdline + item_gross_amt_tdline + tax_exclusive_tdline + td_id_tdline + item_net_total_tdline + item_vendor_tdline + action_tdline + endtrline;
					$("#itemdetails").append(createdrowline);
					$("#itemdetails tr#" + itemdetail.inventoryItems.id + " .selectedvendor > [value=" + itemdetail.vendorId + "]").attr("selected", "true");
					$("#itemdetails tr#" + itemdetail.inventoryItems.id + " .selectedunit > [value=" + itemdetail.unitId + "]").attr("selected", "true");
					
				 }
					
					
					if (postatus == 'Y') {
						$("#select1").val(postatus);
						$("#appvId").val($("#invCrtBy").val());
						$('#select1').prop('disabled', true);
						$("#poapprovedbuttion").addClass('disabled');
						//$("#misChargeId").attr("disabled", "disabled");
						$("#printreq").removeAttr("disabled");
						$('.selectedvendor').prop('disabled', true);
						$("#poOrderSave").addClass('disabled');
					} else {
						$("#select1").val('');
						$("#appvId").val('');
						$('#select1').removeAttr('disabled');
						$("#poapprovedbuttion").removeClass('disabled');
						//$("#misChargeId").removeAttr("disabled");
						$("#printreq").attr("disabled", "disabled");
						$('.selectedvendor').removeAttr('disabled');
					}
					
					
				}
				
				$("#misChargeId").val(itemdetailheader.shippingCharge);
				$("#misChargeId").prop('disabled', true);
				calculateGrandTotal();
			} catch (e) {
				//alert(e);
			}

		}, null);
	}

}

function calculateGrandTotal() {
	var grandtotal = 0.00;
	var totaltax = 0.00;
	var mischarge = $("#misChargeId").val();
	$('#itemdetails tr').each(function() {
		var itmtotal = $(this).find("td:eq(13)").html();
		var trid = $(this).find("td:eq(12)").html();
		//alert("trid:"+trid);
		var taxamt =$("#itmtaxamttd_"+trid).html();
		//alert("taxamt:"+taxamt);
		grandtotal = Number(grandtotal) + Number(itmtotal);
		totaltax = Number(totaltax) +Number(taxamt);
	});
	//alert("totaltax:"+totaltax);
	grandtotal = grandtotal + Number(mischarge);
	$("#grandtotalId").val(parseFloat(grandtotal).toFixed(2));
	$("#totTaxAmt").val(parseFloat(totaltax).toFixed(2));
}

function changeQty(	qty,
					itemid,
					shcharge,
					taxrate
					) { // modified
	$("#itmupdate_" + itemid).css('background-color', 'orange');
//	shcharge=0;
	var isno = isNaN(qty);
	if (isno) {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (qty < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} else {
			if(shcharge==""){
				shcharge=0;	
			}
			/*var rate = $("#itmrate_" + itemid).text();
			var tot = parseFloat((qty * rate) + shcharge).toFixed(2);
			$("#itmtot_" + itemid).text(tot);
			calculateGrandTotal();
			*/
			var rate = $("#itmrate_" + itemid).html();
			var istaxexclusive = $("#itmistaxexclusive_" + itemid).val();
			var ratewithtax = Number(rate) + ((Number(rate) * Number(taxrate))/100); //new added
			var taxamt = Number(qty)*((Number(rate) * Number(taxrate))/100);//new added
			document.getElementById("itmtaxamttd_"+itemid).innerHTML=parseFloat(taxamt).toFixed(2); //new added
			
		
			if(istaxexclusive == 'Y'){// new added
			var trate = (Number(qty) * Number(ratewithtax)); // new added
			}
			else{// new added
			var trate = (Number(qty) * Number(rate)); // new added
			}
			
			var tot = 0;
		    tot=parseFloat(trate).toFixed(2);
			$("#itmtot_" + itemid).text(tot);
			calculateGrandTotal()
				
		}
	}
}

function changeShippingCharge(	shcharge,
								itemid,
								qty) {  // not used
//	shcharge=0;
	var isno = isNaN(shcharge);
//	console.log("isno="+isno);
//	console.log("shcharge="+shcharge);
	if(shcharge==''){
		shcharge=0;	
	}
	if (isno) {
		
	} else {
		
		var rate = $("#itmrate_" + itemid).text();
		var tot = parseFloat((qty * rate) + parseFloat(shcharge)).toFixed(2);
		$("#itmtot_" + itemid).text(tot);
		//		calculateGrandTotal();
	}
}

function requisitionSave() {
	var invPOOrder1 = {};
	var invPOOrder = [];
	var d = new Date();
	var totQty = 0.00;
	var totitemprice = 0.00;
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	var poid = 0;
	var edpid = 0;
	var shouldpositive = 0;
	var selectedvendorid=$("#selectedPovendorId").val();
	var totaltax = $("#totTaxAmt").val();
	var grandtotal = $("#grandtotalId").val();
	var mischarge = $("#misChargeId").val();
	var tableDatalen = $('#saverecipe > tbody  > tr').length;
	
	$('#saverecipe > tbody  > tr').each(function() {
		var trid = this.id;
		var qty = $("#itmqty_" + trid).val();
		var rate = $("#itmrate_" + trid).text();
		if (qty < 0 || rate < 0 || qty == '' || rate == '') {
			shouldpositive = 1;
		}
	});
	if (shouldpositive == 1) {
		$("#positiveitemquantityorrate").modal('show');
	} 
	if (tableDatalen == 0) {
		$("#itemquantityzero").modal('show');
	}
	
	else {
		$('#saverecipe > tbody  > tr').each(function() {
//			console.log("tr id=" + this.id);
			var that = this;
			var trid = this.id;
			var qty = $("#itmqty_" + trid).val();
			totQty = totQty + parseFloat(qty);
			var rate = $("#itmrate_" + trid).text();
			var unitid = $("#itmunitid_" + trid).val();
			var itemtotprice = Number(qty) * Number(rate);
			totitemprice = Number(totitemprice) + Number(itemtotprice);
			var taxRate = $("#itmtaxchrg_" + trid).val();
			var taxAmt = $("#itmtaxamttd_" + trid).html();
			var totalAmt = $("#itmtot_" + trid).html();			
			var itmshchrg = $("#itmshchrg_" + trid).val();
			if ($("#poid_" + trid).val() != 0) {
				poid = $("#poid_" + trid).val();
			}
			if ($("#edpid_" + trid).val() != 0) {
				edpid = $("#edpid_" + trid).val();
			}
			//	    $(this).find("td:gt(0)").each(function(){
			//	       });
			//if ($("#poid_" + trid).val() == 0) {
				var invPOOrderItems = {};
				var inventoryItemsarr = {};
				invPOOrderItems.oldStock = $(that).find("td:eq(2)").html();
				invPOOrderItems.requiredQuantity = $(that).find("td:eq(3)").html();
				invPOOrderItems.itemQuantity = qty;
				invPOOrderItems.rate = rate;
				invPOOrderItems.shippingCharge = itmshchrg ;
				invPOOrderItems.itemTotalPrice = itemtotprice;
				invPOOrderItems.vendorId = selectedvendorid;
				invPOOrderItems.unitId = unitid;
				invPOOrderItems.createdDate = creationDate;
				inventoryItemsarr.id = trid;
				
				
				invPOOrderItems.taxRate = parseFloat(taxRate); // new added 
				invPOOrderItems.taxAmt = parseFloat(taxAmt); // new added 
				invPOOrderItems.totalAmt = parseFloat(totalAmt); // new added 				
				invPOOrderItems.isTaxExclusive =$("#itmistaxexclusive_"+trid).val(); // new added 
				
				
				
				invPOOrderItems.inventoryItems = inventoryItemsarr;
				invPOOrder.push(invPOOrderItems);
			//}
			
			
			
		});
		invPOOrder1.inventoryPurchaseOrderItems = invPOOrder;
		invPOOrder1.id = poid;
		invPOOrder1.estimateDailyProdId = edpid;
		
		var othercharges1 = $("#misChargeId").val();
		if(othercharges1 == ''){othercharges1 = 0.0;}
		invPOOrder1.shippingCharge = parseFloat(othercharges1);
		
		invPOOrder1.totalPrice = 0;
		invPOOrder1.totalQuantity = totQty;
		invPOOrder1.createdDate = creationDate;
		invPOOrder1.vendorId = selectedvendorid;// new added 
		invPOOrder1.totalPrice = $("#grandtotalId").val();
		invPOOrder1.itemTotal = parseFloat(totitemprice);// new added 
		invPOOrder1.taxAmt = parseFloat(totaltax);// new added 
		//		console.log("invPOOrder1=" + JSON.stringify(invPOOrder1));
		$.ajax({
			url : BASE_URL + "/inventorynew/createnewpurchaseorder.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(invPOOrder1),
			success : function(response) {
				//called when successful
				invPOOrder1 == {};
				if (response == 'success') {
					location.reload();
				}
			},
			error : function(e) {
				//called when there is an error
				//console.log(e.message);
			}
		});
	}

}

function editExistingPOItem(itemid,
							poinvid) {
	var qty = $("#itmqty_" + itemid).val();
	var rate = $("#itmrate_" + itemid).text();
	var unitid = $("#saverecipe tr#" + itemid).find(".selectedunit").val();
	//			var vendorid = $("#itmvendorid_" + trid).text();
	var vendorid = $("#saverecipe tr#" + itemid).find(".selectedvendor").val();
	var itmshchrg = $("#itmshchrg_" + itemid).val();
	var poid = $("#poid_" + itemid).val();
	var edpid = $("#edpid_" + itemid).val();
	var d = new Date();
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	var isnoqty = isNaN(qty);
	var isnoitmshchrg = isNaN(itmshchrg);
	if (isnoqty || isnoitmshchrg || qty == '' || itmshchrg == '') {
		$("#validitemquantityorrate").modal('show');
	} else {
		if (qty < 0 || itmshchrg < 0) {
			$("#positiveitemquantityorrate").modal('show');
		} else {
			$('#saverecipe > tbody  > tr').each(function() {
				var that = this;
				if (this.id == itemid) {
					var invPOOrderItems = {};
					var inventoryItemsarr = {};
					var inventorypoorder = {};
					invPOOrderItems.id = poinvid;
					invPOOrderItems.oldStock = $(that).find("td:eq(2)").html();
					invPOOrderItems.requiredQuantity = $(that).find("td:eq(3)").html();
					invPOOrderItems.itemQuantity = qty;
					invPOOrderItems.rate = rate;
					invPOOrderItems.shippingCharge = itmshchrg;
					invPOOrderItems.itemTotalPrice = $(that).find("td:eq(8)").html();
					invPOOrderItems.vendorId = vendorid;
					invPOOrderItems.unitId = unitid;
					invPOOrderItems.createdDate = creationDate;
					inventoryItemsarr.id = itemid;
					inventorypoorder.id = poid;
					invPOOrderItems.inventoryItems = inventoryItemsarr;
					invPOOrderItems.inventoryPurchaseOrder = inventorypoorder;
					//			console.log("invPOOrderItems=" + JSON.stringify(invPOOrderItems));
					$.ajax({
						url : BASE_URL + "/inventorynew/updatepoitem.htm",
						type : 'POST',
						contentType : 'application/json;charset=utf-8',
						data : JSON.stringify(invPOOrderItems),
						success : function(response) {
							if (response == 'success') {
								$("#itemupdatedmodal").modal('show');
								$("#itmupdate_" + itemid).css('background-color', '#78B626');
							}
						},
						error : function(e) {
							//called when there is an error
							//console.log(e.message);
						}
					});
				}
			});
		}
	}
}

function deleteRowForExistingPO(deleterowid,
								poid,
								poinvitemid) {
	$("#hdnitempoid").val(deleterowid);
	$("#hdnpoid").val(poid);
	$("#hdnpoinvitemid").val(poinvitemid);
	$("#existingpoitemdeletemodal").modal('show');
}

function deleteExistingPoItem() {
	var deleterowid = $("#hdnitempoid").val();
	var poid = $("#hdnpoid").val();
	var poinvitemid = $("#hdnpoinvitemid").val();
	$("tr#" + deleterowid + "").remove();
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/inventorynew/poitemdelete/" + poid + "/" + poinvitemid + ".htm", function(response) {
	}, null);
    calculateGrandTotal();
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
	var selectedpoid = $("#selectedpoid").val();
	if (selectedpoid == 0) {
		$("#savepurchaseorder").modal('show');
	} else {
		var invDate = $("#selecteddate").val();
		var invCreatedBy = $("#invCrtBy").val();
		var appvSelect = document.getElementById('select1').value;
		if (appvSelect == 'Y') {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + '/inventorynew/approvedPO.htm?poId=' + selectedpoid + '&updatedBy=' + invCreatedBy + '&updatedDate=' + invDate, function(response) {
				if (response == 'success') {
					$('#select1').prop('disabled', true);
					$("#poapprovedmodal").modal('show');
					$("#poapprovedbuttion").addClass('disabled');
				}
			}, null);
		}
	}
}

function requisitionapprovesuccess() {
	location.reload();
}

function poOrderPrint() {
	window.open(BASE_URL+'/pages/rm/printrequisition.jsp','_blank');
}

// added new 

function poOrderDeleteModalOpen(){//new added
	$("#existingrequisitiondeletemodal").modal('show');
}

function poOrderDelete(){ // new added
	var selectedpoid = $("#clickedpoid").val();
	var tableDatalen = $('#saverecipe > tbody  > tr').length;
	//alert("selectedpoid"+selectedpoid);
	if (selectedpoid == 0) {
		$("#savepurchaseorder").modal('show');
		$("#poOrderDelete").addClass('disabled');
	} else if(tableDatalen == 0){
		$("#itemquantityzero").modal('show');
	}else{
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + '/inventorynew/deleterequisition/' + selectedpoid+'.htm' , function(response) {
		if (response == 'success') {
			
			location.href=BASE_URL+'/requisition/loadrequisition.htm';
			
			
		}
	}, null);
	}
} 

function setActiveButton(){ //add new
	var poid = $("#clickedpoid").val();
	//alert("poid"+poid);
	var activebutton="";
	if(poid == '0'){
		activebutton ="<a href='javascript:requisitionSave()' id='poOrderSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;' align='left'>Save</a>";
	    }
	else{
		activebutton ="<a href='javascript:requisitionSave()' id='poOrderSave' class='btn btn-success' style='background: #78B626; margin-top: 3px;' align='left'>Update</a>";
	    }	
	    document.getElementById("btnspan").innerHTML = activebutton;	
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














