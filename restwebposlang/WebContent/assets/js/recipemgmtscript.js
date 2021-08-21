/**
 * 
 */

var storeid = $("#hidstoreid").val();
function clickonSubmenu(itemid,
						itemname,
						unit) {
	$("#searchdiv").removeClass('hide');
	$("#saveRecipeIngredients").removeClass('hide');
	$("#selectedmenuid").val(itemid);
	$('#selectedmenuItemName').html(itemname + " Unit:" + unit);
	rowClicked(itemid);
}

function rowClicked(itemid) {
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/recipe/getIngredientDetailsOfMenuItem.htm?itemid=" + itemid, function(response) {
		try {
			$("#ingredientdetails").html("");
			var reponseObj = JSON.parse(response);
//			console.log("reponseObj=" + reponseObj);
			if (reponseObj == '') {
				$('#addingtoitem').modal('show');
			}
			var generatedHtml = prepareHtml(reponseObj);
			$('#ingredientdetails').html(generatedHtml);
			/*$(".selectedmetricUnit").prop("readonly", "readonly");*/
			//			$('#selectedmenuItemName').html(itemname);
		} catch (e) {
			//alert(e);
		}

	}, null);
}

function prepareHtml(reponseObj) {
	console.log(JSON.stringify(reponseObj));
	var generatedHtml = "";
	var createdrowline = "";
	for ( var i = 0; i < reponseObj.length; i++) {
		var orderitem = reponseObj[i];
		$(".selectedmetricUnit > [value=" + orderitem.metricUnit.id + "]").attr("selected", "true");
		$(".selectedcookingUnit > [value=" + orderitem.cookingUnit.id + "]").attr("selected", "true");
		var disc1 = 0.0;
		var begintrline = "";
		var firsttdline = "";
		var secondtdline = "";
		var thirdtdline = "";
		var trbgColor = "";
		var seventhtdline="";
		var eighttdline="";
		begintrline = "<tr id='" + orderitem.inventoryItem.id + "' style='padding:2px;'>";
		//		var chk="<td style='padding:1px;'>"+orderitem.inventoryItem.id+"</td>";
		firsttdline = "<td align='center' style='padding:1px;'><input type='text' size='4' onkeyup=javascript:changeMetricAmt(this.value," + orderitem.inventoryItem.id + "," + orderitem.inventoryItem.id + "," + orderitem.inventoryItem.rate+ ") id='itmmetricAmount_" + orderitem.inventoryItem.id + "' value='" + orderitem.metricAmount + "' /></td>";
		secondtdline = "<td align='center'  onclick='javascript:changeMetricunit(" + orderitem.inventoryItem.id + ")' style='padding:1px;cursor:pointer;'>" + $("#metricUnitListt").html() + "</td>";
		thirdtdline = "<td valign='middle' align='center' style='padding:3px;'><input type='hidden' id='itmid_" + orderitem.inventoryItem.id + "' value='" + orderitem.id + "' />" + orderitem.inventoryItem.name + "</td>";
		var fourthtdline = "<td  style='padding:1px;text-align: center;'><input type='text' size='4' onkeyup=javascript:changeCookingAmt(this.value," + orderitem.inventoryItem.id + "," + orderitem.inventoryItem.id + ") id='itmcookingAmount_" + orderitem.inventoryItem.id + "' value='" + orderitem.cookingAmount + "' /></td>";
		var fifthtdline = "<td onclick='javascript:changeCookingunit(" + orderitem.inventoryItem.id + ")' style='padding:1px;text-align: center;' >" + $("#coockingUnitList").html() + "</td>";
		var sixtdline = "<td style='width: 17%;'><a class='btn btn-success' style='background: #78B626' id='itmupdate_" + orderitem.inventoryItem.id + "' href='javascript:editExistingReceipeItem(" + orderitem.id + "," + orderitem.item.id + "," + orderitem.inventoryItem.id + ")'>"+getReciepeLang.update+"</a>&nbsp;&nbsp; <a href='javascript:deleteRowForExistingReceipe(" + orderitem.inventoryItem.id + "," + orderitem.id + "," + orderitem.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18' alt='delete item' style='margin-top: 3px;'></td></a>";
		
		 seventhtdline = "<td valign='middle' align='center' style='padding:3px;'>" + orderitem.inventoryItem.code + "</td>";
		 eighttdline = "<td valign='middle' align='center' style='padding:3px;' id='cost_"+orderitem.inventoryItem.id+"'>"+parseFloat(Number(orderitem.metricAmount) * Number(orderitem.inventoryItem.rate)).toFixed(2)+"</td>";
		
		var endtrline = "</tr>";
		createdrowline += begintrline + seventhtdline  + thirdtdline + firsttdline + secondtdline  + fourthtdline + fifthtdline + eighttdline+ sixtdline +endtrline;
		
		
		$("#ingredientdetails tr#" +  orderitem.inventoryItem.id + ".selectedmetricUnit >").prop("disabled", true);
		$(".selectedmetricUnit option[value='" + orderitem.metricUnit.id + "']").removeAttr("selected");
		$(".selectedcookingUnit option[value='" + orderitem.cookingUnit.id + "']").removeAttr("selected");
	}

	generatedHtml = createdrowline;
	return generatedHtml;
}

function addNewItem() {
	var itemid = $("#searchitemid").val();
	var metricUnitId = $("#searchitemmetricUnitId").val();
	var itemrate = $("#searchitemrate").val();
	var itemcode = $("#searchCode").val();
	var itempresent = 0;
	if (itemid != '') {
		$('#saverecipe > tbody  > tr').each(function() {
			var itid = this.id;
			if (itid == itemid) {
				itempresent = 1;
			}
		});
		if (itempresent == 1) {
			$('#alreadyexistitem').modal('show');
		} else {
			var itemname = $("#search").val();
			//		var metricUnitListt = $("#metricUnitListt").html();
			var coockingUnitList = $("#coockingUnitList").html();
			//		$(".selectedcookingUnit > [value=" + metricUnitId + "]").attr("selected", "true");
			var disc1 = 0.0;
			var begintrline = "";
			var firsttdline = "";
			var secondtdline = "";
			var thirdtdline = "";
			var trbgColor = "";
			begintrline = "<tr id='" + itemid + "' style='padding:2px;'>";
			//	var chk="<td style='padding:1px;'>"+itemid+"</td>";
			firsttdline = "<td align='center' style='padding:1px;'><input type='text' size='4' onkeyup=javascript:changeMetricAmt(this.value," + itemid + "," + itemid + ","+itemrate+") id='itmmetricAmount_" + itemid + "' value='1.0' /></td>";
			secondtdline = "<td align='center'  onclick='javascript:changeMetricunit(" + itemid + ")'  style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;background:" + trbgColor + ";'>" + $("#newmetricUnitList").html() + "</td>";
			thirdtdline = "<td valign='middle' align='center' style='padding:3px;'><input type='hidden' id='itmid_" + itemid + "' value='0' />" + itemname + "</td>";
			var fourthtdline = "<td  style='padding:1px;text-align: center;'><input type='text' size='4' onkeyup=javascript:changeCookingAmt(this.value," + itemid + "," + itemid + ") id='itmcookingAmount_" + itemid + "' value='0.0' /></td>";
			var fifthtdline = "<td onclick='javascript:changeCookingunit(" + itemid + ")' style='padding:1px;text-align: center;'>" + coockingUnitList + "</td>";
			var sixtdline = "<td><a href='javascript:deleteRowId(" + itemid + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></td></a>";
			
			var seventhtdline = "<td valign='middle' align='center' style='padding:3px;'>" + itemcode + "</td>";
			var eigthtdline = "<td valign='middle' align='center' style='padding:3px;' id='cost_"+itemid+"'>" + parseFloat(1 * Number(itemrate)).toFixed(2) + "</td>";
			
			
			var endtrline = "</tr>";
			
			var createdrowline = begintrline + seventhtdline  + thirdtdline + firsttdline + secondtdline +   fourthtdline + fifthtdline + eigthtdline+sixtdline + endtrline;
			$('#ingredientdetails').append(createdrowline);
			
			$("#ingredientdetails tr#" + itemid + " .newselectedmetricUnit >").prop("readonly", "readonly");
			$("#ingredientdetails tr#" + itemid + " .newselectedmetricUnit > [value=" + metricUnitId + "]").attr("selected", "true");
			$("#search").val("");
			$("#searchCode").val("");
			$("#searchitemid").val("");
		}
	}
}

function saveRecipeIngredients() {
	var selectedmenuid = $("#selectedmenuid").val();
	var ingredients1 = {};
	var ingredients = [];
	var d = new Date();
	var callsave = 0;
	var creationDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	var length = $('#saverecipe > tbody  > tr').length;
	
	
	$('#saverecipe > tbody  > tr').each(function() {
		var that = this;
		var trid = this.id;
		var metricAmount = $("#itmmetricAmount_" + trid).val();
		var cookingAmount = $("#itmcookingAmount_" + trid).val();
		var selectedcookingUnit = $("#ingredientdetails tr#" + trid).find(".selectedcookingUnit").val();
		var selectedmetricUnit = $("#ingredientdetails tr#" + trid).find(".selectedmetricUnit").val();
		
		var itmid = $("#itmid_" + trid).val();
		if (metricAmount == '' || cookingAmount == '') {
			callsave = 1;
			$("#wrongmodal").modal('show');
		} else {

			if (itmid == 0) {
				var ingredient = {};
				var menuItem = {};
				var inventoryItems = {};
				var cookingUnit = {};
				var metricUnit = {};
				ingredient.storeId = storeid;
				menuItem.id = selectedmenuid;
				ingredient.item = menuItem;
				inventoryItems.id = trid;
				ingredient.inventoryItem = inventoryItems;
				ingredient.cookingAmount = cookingAmount;
				cookingUnit.id = selectedcookingUnit;
				ingredient.cookingUnit = cookingUnit;
				ingredient.metricAmount = metricAmount;
				metricUnit.id = selectedmetricUnit;
				ingredient.metricUnit = metricUnit;
				ingredient.createdDate = creationDate;
				ingredient.costAmount = 500;
				ingredients.push(ingredient);
			}
		}

	});
	if (callsave == 0) {
		ingredients1.ingredients = ingredients;
		//		console.log("ingredients1=" + JSON.stringify(ingredients1));
		$.ajax({
			url : BASE_URL + "/recipe/createorupdatereceipe.htm",
			type : 'POST',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(ingredients1),
			success : function(response) {
				//called when successful
				if (response == 'success') {
					ingredients1 = {};
					rowClicked(selectedmenuid);
					if(length > 0){
						$("#itemsavemodal").modal('show');	
					}
					
				}
			},
			error : function(e) {
			}
		});
	}

}
function deleteRowId(deleterowid) {
	$("#hdnreceipeitemid").val(deleterowid);
	$('#receipeitemdeletemodal').modal('show');
}
function deleteReceipeItem() {
	var delitemid = $("#hdnreceipeitemid").val();
	$("tr#" + delitemid + "").remove();
	calculateGrandTotal();
}

function deleteRowForExistingReceipe(	deleterowidexisrcp,
										deleterowid,
										deleterowid) {
//	console.log("deleterowid=" + deleterowid);
	$("#hdnexixtingreceipeitemid").val(deleterowidexisrcp);
	$("#hdnexistingreceipeitemtableid").val(deleterowid);
	$('#existingreceipeitemdeletemodal').modal('show');

	//	calculateGrandTotal();
}
function deleteExistingReceipeItem() {
	var hdnexixtingreceipeitemid = $("#hdnexixtingreceipeitemid").val();
	var hdnexistingreceipeitemtableid = $("#hdnexistingreceipeitemtableid").val();
	$("tr#" + hdnexixtingreceipeitemid + "").remove();
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/recipe/deleteEachReceipeItem/" + storeid + "/" + hdnexistingreceipeitemtableid + ".htm", function(response) {
	}, null);
	//	calculateGrandTotal();
}
function editExistingReceipeItem(	id,
									itemid,
									invitemid) {
	$('#saverecipe > tbody  > tr').each(function() {
		if (this.id == invitemid) {
			var that = this;
			var trid = this.id;
			var metricAmount = $("#itmmetricAmount_" + trid).val();
			var cookingAmount = $("#itmcookingAmount_" + trid).val();
			var selectedcookingUnit = $("#ingredientdetails tr#" + trid).find(".selectedcookingUnit").val();
			var selectedmetricUnit = $("#ingredientdetails tr#" + trid).find(".selectedmetricUnit").val();
			if (metricAmount == '' || cookingAmount == '') {
				callsave = 1;
				$("#wrongmodal").modal('show');
			} else {
				var ingredient = {};
				var menuItem = {};
				var inventoryItems = {};
				var cookingUnit = {};
				var metricUnit = {};
				ingredient.id = id;
				ingredient.storeId = storeid;
				menuItem.id = itemid;
				ingredient.item = menuItem;
				inventoryItems.id = trid;
				ingredient.inventoryItem = inventoryItems;
				ingredient.cookingAmount = cookingAmount;
				cookingUnit.id = selectedcookingUnit;
				ingredient.cookingUnit = cookingUnit;
				ingredient.metricAmount = metricAmount;
				metricUnit.id = selectedmetricUnit;
				ingredient.metricUnit = metricUnit;
				ingredient.costAmount = 500;
				$.ajax({
					url : BASE_URL + "/recipe/updatereceipeitem.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(ingredient),
					success : function(response) {
						if (response == 'success') {
							$("#itemupdatedmodal").modal('show');
							$("#itmupdate_" + trid).css('background-color', '#78B626');
						}
					},
					error : function(e) {
					}
				});
			}
		}

	});
}

function changeMetricAmt(	value,
							itmid,
							invitmid,
							rate) {
	$("#itmupdate_" + invitmid).css('background-color', 'orange');
	$("#cost_" + invitmid).text(parseFloat(Number(value) * Number(rate)).toFixed(2));
	
}
function changeCookingAmt(	value,
							itmid,
							invitmid) {
	$("#itmupdate_" + invitmid).css('background-color', 'orange');
}
function changeMetricunit(invitmid) {
	$('.selectedmetricUnit').on('change', function() {
		$("#itmupdate_" + invitmid).css('background-color', 'orange');
	});
}
function changeCookingunit(invitmid) {
	$('.selectedcookingUnit').on('change', function() {
		$("#itmupdate_" + invitmid).css('background-color', 'orange');
	});
}
