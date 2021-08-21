var storeid = $("#hidstoreid").val();
function rowClicked(edpid,edpstatus,edpTypeId) {
	$("#itemdetails").html("");
	$("#edpId").val(edpid);
	$('#edpTypeId>option:eq("'+edpTypeId+'")').prop('selected', true);
	$("#edpTypeId").attr("disabled", "disabled"); 
	$("body").css("cursor", "wait");
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/edp/getedpbystoreidandid.htm?edpid=" + edpid, function(response) {
		try {
			//console.log(response);
			$("body").css("cursor", "default");
			$("#itemdetails").html("");
			var itemdetails = JSON.parse(response);
			for ( var i = 0; i < itemdetails.length; i++) {
				var itemdetail = itemdetails[i];
				var createdrowline = "";
				var generatedHtml = "";
				var starttrline ="";
				if(itemdetail.edpStatus=='N'){
					starttrline = "<tr id=" + itemdetail.menuItem.id + " bgcolor='#ff9999'>";
				}else{
					starttrline = "<tr id=" + itemdetail.menuItem.id + ">";
				}
				var firsttdline = "<td>" + itemdetail.menuItem.id + "</td>";
				var secondtdline = "<td><input type='hidden'  id='poid_" + itemdetail.id + "' value='0' />" + itemdetail.menuItem.categoryName + "</td>";
				var thirdtdline = "<td>" + itemdetail.menuItem.subCategoryName + "</td>";
				var fourthtdline = "<td>" + itemdetail.menuItem.name + "</td>";
				var fifthtdline = "<td>" + itemdetail.oldStock + "</td>";
				var sixthtdline = "<td>" + itemdetail.minDuantity + "</td>";
				//var seventhtdline = "<td><input type='text' size='4' onkeyup=javascript:changeedpQty(this.value," + itemdetail.menuItem.id + "," + itemdetail.shippingCharge + ") id='edpqty_" + itemdetail.id + "' value='" + itemdetail.edProdAmount + "' /> </td>";
				var eighttdline = "<td id='itmtot_" + itemdetail.id + "'>" + itemdetail.menuItem.unit + "</td>";
				var ninetdline = "<td id='itmrqrdqty_"+itemdetail.menuItem.id+"'>" + itemdetail.requiredQuantity + "</td>";
				var tentdline = "<td><a class='btn btn-success' style='background: #78B626' id='itmupdate_" + itemdetail.menuItem.id + "' href='javascript:getRawItemsDetails(" + itemdetail.menuItem.id + "," + edpid + ","+itemdetail.requiredQuantity+")'>"+getEDPLang.rawItems+"</a></td>";
				var seventhtdline="";
				var eleventdline="";
				//var eleventdline = "<td><a href='javascript:deleteRowIdExistingEDP(" + itemdetail.id + "," + itemdetail.menuItem.id + "," + edpid + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
				var endtrline = "</tr>";
				//createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventhtdline + eighttdline + ninetdline + tentdline + eleventdline + endtrline;
				//$("#itemdetails").append(createdrowline);
				if (edpstatus == 'Y') {
					seventhtdline = "<td><input type='text' size='4' onkeyup=javascript:changeedpQty(this.value," + itemdetail.menuItem.id + "," + itemdetail.shippingCharge + ") id='edpqty_" + itemdetail.id + "' value='" + itemdetail.edProdAmount + "' disabled='disabled'/> </td>";
					eleventdline = "<td></td>";
					$("#edpisApproved").val(edpstatus);
					$("#edpApprovedBy").val($("#hidedpCrtBy").val());
					$('#edpisApproved').prop('disabled', true);
					$("#edpapprovedbuttion").addClass('disabled');
					$("#saveEdpBut").addClass('disabled');
					$("#itemsearchdivId").addClass('hide');
					$("#printEdpBut").removeClass('disabled');
					
				} else {
					if(itemdetail.edpStatus=='Y'){
					seventhtdline = "<td><input type='text' size='4' onkeyup=javascript:changeedpQty(this.value," + itemdetail.menuItem.id + "," + itemdetail.shippingCharge + ") id='edpqty_" + itemdetail.id + "' value='" + itemdetail.edProdAmount + "' /> </td>";
					eleventdline = "<td style='width: 14%;'><a class='btn btn-success' style='background: #78B626' id='edpitmupdate_" + itemdetail.menuItem.id + "' href='javascript:editExistingEDPItem(" + itemdetail.menuItem.id + "," + edpid + "," + itemdetail.id + ")'>"+getEDPLang.update+"</a>&nbsp;&nbsp;<a href='javascript:deleteRowIdExistingEDP(" + itemdetail.id + "," + itemdetail.menuItem.id + "," + edpid + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18' style='margin-top: 3px;'></a></td>";
					}else{
						seventhtdline = "<td><input type='text' disabled size='4' onkeyup=javascript:changeedpQty(this.value," + itemdetail.menuItem.id + "," + itemdetail.shippingCharge + ") id='edpqty_" + itemdetail.id + "' value='" + itemdetail.edProdAmount + "' /> </td>";
						eleventdline = "<td style='width: 14%;'></td>";
					}
					$("#edpisApproved").val('');
					$("#edpApprovedBy").val('');
					$('#edpisApproved').removeAttr('disabled');
					$("#edpapprovedbuttion").removeClass('disabled');
					$("#saveEdpBut").addClass('disabled');
					$("#deleteEdpBut").removeClass('disabled');
					$("#printEdpBut").addClass('disabled');
					if(edpTypeId!=1)
						{
						$("#itemsearchdivId").removeClass('hide');
						}
					else
						{
						$("#itemsearchdivId").addClass('hide');
						}
				}
				createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventhtdline + eighttdline + ninetdline + tentdline + eleventdline + endtrline;
				$("#itemdetails").append(createdrowline);
			}

		} catch (e) {
			//alert(e);
		}

	}, null);

}

function getRawItemsDetails(menuitemid,
							id,reqrdqty) {
	$("#ingdetails").html("");
	
	var reqqty=$("#itmrqrdqty_"+menuitemid).html();
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/recipe/getIngredientDetailsOfMenuItem.htm?itemid=" + menuitemid, function(response) {
		try {
			var itemdetails = JSON.parse(response);
			for ( var i = 0; i < itemdetails.length; i++) {
				var itemdetail = itemdetails[i];
				$("#itmname").html(itemdetail.item.name);
				var createdrowline = "";
				var generatedHtml = "";
				var starttrline = "<tr id=" + itemdetail.inventoryItem.id + ">";
				var firsttdline = "<td>" + itemdetail.inventoryItem.name + "</td>";
				var secondtdline = "<td><input type='hidden'  id='poid_" + itemdetail.id + "' value='0' />" + parseFloat(itemdetail.metricAmount).toFixed(2) + "</td>";
				var thirdtdline = "<td>" + itemdetail.metricUnit.unit + "</td>";
				var fourthtdline = "<td>" + parseFloat(itemdetail.metricAmount*reqqty).toFixed(2) + "</td>";
				var endtrline = "</tr>";
				createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + endtrline;
				$("#ingdetails").append(createdrowline);
			}
			$("#itemdetailsmodal").modal('show');
		} catch (e) {
			//alert(e);
		}

	}, null);
}

function deleteRowIdExistingEDP(id,
								ingid,
								edpid) {
	$("#hdningid").val(ingid);
	$("#hdnedpid").val(edpid);
	$("#hdnid").val(id);
	$("#existingedpitemdeletemodal").modal('show');
	
}
function deleteExistingEDPItem(){
	var ingid = $("#hdningid").val();
	var edpid = $("#hdnedpid").val();
	var hdnid=$("#hdnid").val();
	$("tr#" + ingid + "").remove();
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + '/edp/deleteedpitem.htm?id=' + hdnid + '&edpid=' + edpid , function(response) {
		if (response == 'success') {
			$("#edpdeletesuccessdmodal").modal('show');
		}
	}, null);
}
function createNewEdp()
{
	$("#itemdetails").html("");
	$("#edpId").val(0);
	$('#edpTypeId').val('');
	$("#edpTypeId").removeAttr("disabled");
	$("#edpcreationDate").val($("#edpDate").val());
	$("#edpisApproved").val('');
	$("#edpApprovedBy").val('');
	$('#edpisApproved').removeAttr('disabled');
	$("#edpapprovedbuttion").removeClass('disabled');
	$("#saveEdpBut").removeClass('disabled');
	$("#categorydivId").addClass('hide');
	$("#itemsearchdivId").addClass('hide');
	$("#deleteEdpBut").addClass('disabled');
	$("#printEdpBut").addClass('disabled');
}
function addNewItemtoEDP(itemid,catname,subcatname,itemname,oldstock,minqty,edpqty,unit,reqrdqty)
{
	var edpid=$("#edpId").val();
	var itempresent = 0;
	$('#saverecipe > tbody  > tr').each(function() {
		var itid = this.id;
		if (itid == itemid) {
			itempresent = 1;
		}
	});
	if (itempresent == 1) {
		$('#alreadyexistitem').modal('show');
	} else {
		edpqty=minqty;
		if(parseInt(oldstock)>=parseInt(edpqty)){
			reqrdqty=0;
		}
		else{
			reqrdqty=edpqty-oldstock;
		}
		if(edpid!=0)
			{
			var edpTypeId=$("#edpTypeId").val();
			var edpUpdBy = $("#hidedpCrtBy").val();
			var d = new Date();
			var updateDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
			var estimateDailyProdItem = {};
			var menuitem = {};
			menuitem.id = itemid;
			estimateDailyProdItem.estimateDailyProdId.id=edpid;
			estimateDailyProdItem.storeId = storeid;
			estimateDailyProdItem.menuItem = menuitem;
			estimateDailyProdItem.oldStock=oldstock;
			estimateDailyProdItem.minDuantity=minqty;
			estimateDailyProdItem.edProdAmount=edpqty;
			estimateDailyProdItem.requiredQuantity=reqrdqty;
			estimateDailyProdItem.costAmount=50;
			estimateDailyProdItem.edpStatus="N";
			estimateDailyProdItem.deleteFlag="N";
			estimateDailyProdItem.createdDate = updateDate;
			estimateDailyProdItem.createdBy = edpUpdBy;
			//estimateDailyProdItem.updatedDate = updateDate;
			//estimateDailyProdItem.updatedBy = edpUpdBy;
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjaxPost(BASE_URL + '/edp/addedpitem.htm',estimateDailyProdItem, function(response) {
				if(response=='success')
				{
					$("#edpitemadddmodal").modal('show');
					rowClicked(edpid,'N',edpTypeId);
				}
			}, null);
			}
		else
			{
			var createdrowline = "";
			var starttrline = "<tr id=" + itemid + ">";
			var chktdline = "<td class='hide'><input type='checkbox' checked='checked' ></td>";
			var firsttdline = "<td>" + itemid + "</td>";
			var secondtdline = "<td><input type='hidden'  id='poid_" + itemid + "' value='0' />" + catname + "</td>";
			var thirdtdline = "<td>" + subcatname + "</td>";
			var fourthtdline = "<td>" + itemname + "</td>";
			var fifthtdline = "<td>" + oldstock + "</td>";
			var sixthtdline = "<td>" + minqty + "</td>";
			var seventhtdline = "<td><input type='text' size='4' onkeyup=javascript:changeedpQtyNEW(this.value," + itemid + "," + 0 + ") id='edpqty_" + itemid + "' value='" + edpqty + "' /> </td>";
			var eighttdline = "<td id='itmtot_" + itemid + "'>" + unit + "</td>";
			var ninetdline = "<td id='itmrqrdqty_"+itemid+"'>" + reqrdqty + "</td>";
			var tentdline = "<td><a class='btn btn-success' style='background: #78B626' id='itmupdate_" + itemid + "' href='javascript:getRawItemsDetails(" + itemid + "," + 0 + ","+reqrdqty+")'>"+getEDPLang.rawItems+"</a></td>";
			var eleventdline = "<td><a href='javascript:deleteRow(" + itemid + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
			var endtrline = "</tr>";
			createdrowline = starttrline +chktdline+ firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventhtdline + eighttdline + ninetdline + tentdline + eleventdline + endtrline;
			$("#itemdetails").append(createdrowline);
			}
	
	}
	
}
function deleteRow(id)
{
	$("#hdnid").val(id);
	$("#edpitemdeletemodal").modal('show');
}
function deleteEDPItem() {
	var hdnid=$("#hdnid").val();
	$("tr#" + hdnid + "").remove();
}
function changeEDpType(val)
{
	if(val==0)
		{
		$("#categorydivId").addClass('hide');
		$("#itemsearchdivId").addClass('hide');
		$("#itemdetails").html("");
		}
	else if(val==1)
		{
		$("#categorydivId").removeClass('hide');
		$("#itemsearchdivId").addClass('hide');
		getDailyEdpItems();
		}
	else if(val==5){
		$("#categorydivId").removeClass('hide');
		$("#itemsearchdivId").addClass('hide');
		getDailyEdpItemsLayoff();
	}
	else
		{
		$("#categorydivId").addClass('hide');
		$("#itemsearchdivId").removeClass('hide');
		$("#itemdetails").html("");
		}
}
/*function getDailyEdpItems()
{
	$("#itemdetails").html("");
	$("#edpchkthid").removeClass('hide');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/edp/getallmenuitems.htm?", function(response) {
		try {
			var itemdetails = JSON.parse(response);
			for ( var i = 0; i < itemdetails.length; i++) {
				var menuItem = itemdetails[i];
				var createdrowline = "";
				var generatedHtml = "";
				var edpQty=menuItem.edpQuantity;
				var oldStock=menuItem.oldStock;
				var reqrdQty=menuItem.requiredQuantity;
				edpQty=menuItem.dailyMinQty;
				if(parseInt(oldStock)>=parseInt(edpQty)){
					reqrdQty=0;
				}
				else{
					reqrdQty=edpQty-oldStock;
				}
				var starttrline = "<tr id=" +menuItem.id + ">";
				var chktdline = "<td><input type='checkbox' checked='checked'></td>";
				var firsttdline = "<td>" + menuItem.id + "</td>";
				var secondtdline = "<td><input type='hidden'  id='poid_" + menuItem.id + "' value='0' />" + menuItem.categoryName + "</td>";
				var thirdtdline = "<td>" + menuItem.subCategoryName + "</td>";
				var fourthtdline = "<td>" + menuItem.name + "</td>";
				var fifthtdline = "<td>" + menuItem.oldStock + "</td>";
				var sixthtdline = "<td>" + menuItem.dailyMinQty + "</td>";
				var seventhtdline = "<td><input type='text' size='4' onkeyup=javascript:changeedpQtyNEW(this.value," + menuItem.id + "," + 0 + ") id='edpqty_" + menuItem.id + "' value='" + edpQty + "' /> </td>";
				var eighttdline = "<td id='itmtot_" + menuItem.id + "'>" + menuItem.unit + "</td>";
				var ninetdline = "<td id='itmrqrdqty_"+menuItem.id+"'>" + reqrdQty + "</td>";
				var tentdline = "<td><a class='btn btn-success' style='background: #78B626' id='itmupdate_" + menuItem.id + "' href='javascript:getRawItemsDetails(" + menuItem.id + "," + 0 + ","+reqrdQty+")'>"+getEDPLang.rawItems+"</a></td>";
//				var eleventdline = "<td><a href='javascript:deleteRow(" + menuItem.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
				var eleventdline = "<td></td>";
				var endtrline = "</tr>";
				
				createdrowline = starttrline + chktdline+firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventhtdline + eighttdline + ninetdline + tentdline + eleventdline + endtrline;
				$("#itemdetails").append(createdrowline);
			}

		} catch (e) {
			//alert(e);
		}

	}, null);
}*/

function getDailyEdpItems()
{
	$("#itemdetails").html("");
	$("#edpchkthid").removeClass('hide');
	$("#waitimage").removeClass('hide');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/edp/getallmenuitems.htm?", function(response) {
		try {
			$("#waitimage").addClass('hide');
			createEdpItemList(response,1);

		} catch (e) {
			//alert(e);
		}

	}, null);
}

function getDailyEdpItemsLayoff()
{
	$("#itemdetails").html("");
	$("#edpchkthid").removeClass('hide');
	$("#waitimage").removeClass('hide');
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/edp/getallmenuitemslayoff.htm?", function(response) {
		try {
			$("#waitimage").addClass('hide');
			createEdpItemList(response,5);

		} catch (e) {
			//alert(e);
		}

	}, null);
}

function createEdpItemList(response,typeval){
	var itemdetails = JSON.parse(response);
	for ( var i = 0; i < itemdetails.length; i++) {
		var menuItem = itemdetails[i];
		var createdrowline = "";
		var generatedHtml = "";
		var edpQty=menuItem.edpQuantity;
		var reqrdQty=menuItem.requiredQuantity;
		if(typeval==1){
		var oldStock=menuItem.oldStock;
		edpQty=menuItem.dailyMinQty;
		if(parseInt(oldStock)>=parseInt(edpQty)){
			reqrdQty=0;
		}
		else{
			reqrdQty=edpQty-oldStock;
		}
		}
		var starttrline = "<tr id=" +menuItem.id + ">";
		var chktdline = "<td><input type='checkbox' checked='checked'></td>";
		var firsttdline = "<td>" + menuItem.id + "</td>";
		var secondtdline = "<td><input type='hidden'  id='poid_" + menuItem.id + "' value='0' />" + menuItem.categoryName + "</td>";
		var thirdtdline = "<td>" + menuItem.subCategoryName + "</td>";
		var fourthtdline = "<td>" + menuItem.name + "</td>";
		var fifthtdline = "<td>" + menuItem.oldStock + "</td>";
		var sixthtdline = "<td>" + menuItem.dailyMinQty + "</td>";
		var seventhtdline = "<td><input type='text' size='4' onkeyup=javascript:changeedpQtyNEW(this.value," + menuItem.id + "," + 0 + ") id='edpqty_" + menuItem.id + "' value='" + edpQty + "' /> </td>";
		var eighttdline = "<td id='itmtot_" + menuItem.id + "'>" + menuItem.unit + "</td>";
		var ninetdline = "<td id='itmrqrdqty_"+menuItem.id+"'>" + reqrdQty + "</td>";
		var tentdline = "<td><a class='btn btn-success' style='background: #78B626' id='itmupdate_" + menuItem.id + "' href='javascript:getRawItemsDetails(" + menuItem.id + "," + 0 + ","+reqrdQty+")'>"+getEDPLang.rawItems+"</a></td>";
//		var eleventdline = "<td><a href='javascript:deleteRow(" + menuItem.id + ")'><img border='0' alt='' src='" + BASE_URL + "/assets/images/inv/delete_normal.png' height='22' width='18'></a></td>";
		var eleventdline = "<td></td>";
		var endtrline = "</tr>";
		
		createdrowline = starttrline + chktdline+firsttdline + secondtdline + thirdtdline + fourthtdline + fifthtdline + sixthtdline + seventhtdline + eighttdline + ninetdline + tentdline + eleventdline + endtrline;
		$("#itemdetails").append(createdrowline);
	}
}
function getSelectedCat() {
	var selectedcat = $("#selectedmenucategoryName").val();
	$("#filterbycat").val(selectedcat).trigger('change');
}
function saveEDP()
{
	var edpqty;
	var edpid = $("#edpId").val();
	var selecteddate = $("#edpcreationDate").val();
	var edpCrtBy = $("#hidedpCrtBy").val();
	var edpTypeId=$("#edpTypeId").val();
	var estimateDailyProd={};
	var estimateType={};
	var estimateDailyProdItems=[];
	$("#saverecipe tbody tr").each(function(index) {
		var trid = this.id;
		$row = $(this);
		 edpqty = $("#edpqty_" + trid).val();
		
		var estimateDailyProdItem = {};
		var menuitem = {};
		menuitem.id = trid;
		//estimateDailyProdItem.estimateDailyProdId=edpid;
		estimateDailyProdItem.storeId = storeid;
		estimateDailyProdItem.menuItem = menuitem;
		estimateDailyProdItem.oldStock=$row.find("td").eq(5).text();
		estimateDailyProdItem.minDuantity=$row.find("td").eq(6).text();
		estimateDailyProdItem.edProdAmount=edpqty;
		estimateDailyProdItem.requiredQuantity=$row.find("td").eq(9).text();
		estimateDailyProdItem.costAmount=50;
		if ($row.find('input[type="checkbox"]').is(':checked')){
		estimateDailyProdItem.edpStatus="Y";
		}else{
			estimateDailyProdItem.edpStatus="N";
			estimateDailyProdItem.edProdAmount=0;
		}
		estimateDailyProdItem.createdDate = selecteddate;
		estimateDailyProdItem.createdBy = edpCrtBy;
		estimateDailyProdItems.push(estimateDailyProdItem);
	
	});
	estimateType.id=edpTypeId;
	estimateDailyProd.estimateType=estimateType;
	estimateDailyProd.storeId = storeid;
	estimateDailyProd.date=selecteddate;
	estimateDailyProd.dateText=selecteddate;
	estimateDailyProd.total=1;
	estimateDailyProd.createdBy = edpCrtBy;
	estimateDailyProd.createdDate = selecteddate;
	estimateDailyProd.deleteFlag = "N";
	estimateDailyProd.approved="N";
	estimateDailyProd.requisitionPoStatus="N";
	estimateDailyProd.estimateDailyProdItems=estimateDailyProdItems;
	
	if(edpqty === ''){
		document.getElementById('edpcreatesuccesscont_alert').innerHTML = getEDPLang.plsEntrEDPQty;
		$("#edpsuccessdmodal_ok").modal('show');
	}else if(edpqty == 0){
		document.getElementById('edpcreatesuccesscont_alert').innerHTML = getEDPLang.plsEntrEDPQty1;
		$("#edpsuccessdmodal_ok").modal('show');
	}else {
		
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjaxPost(BASE_URL + '/edp/createedp.htm',estimateDailyProd, function(response) {
			if(response==0)
				{
				$("#edpcreatesuccesscontId").html(getEDPLang.edpNotCrtd);
				}
			else if(response== getEDPLang.cont1)
				{
				$("#edpcreatesuccesscontId").html(getEDPLang.cont1);
				}
			else if(response==getEDPLang.cont2)
				{
				$("#edpcreatesuccesscontId").html(response);
				}
			else
				{}
			$("#edpsuccessdmodal").modal('show');
		}, null);
	}
	
	
	
}
function redirectEDP() {
	location.href=BASE_URL+'/edp/loadedp.htm';
}
function getApprovedBy(user) {
	var edpCrtBy = $("#hidedpCrtBy").val();
	var selectAppvId = document.getElementById('edpApprovedBy');
	if (user == 'Y') {
		selectAppvId.value = edpCrtBy;
	} else {
		selectAppvId.value = '';
	}
}
function calledpApprove()
{
	var edpid = $("#edpId").val();
	if (edpid == 0) {
		$("#saveedpalert").modal('show');
	} else {
		var edpapproveBy = $("#edpApprovedBy").val();
		var appvSelect = document.getElementById('edpisApproved').value;
		if (appvSelect == 'Y') {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + '/edp/approveEDP.htm?storeId=' + storeid + '&edpid=' + edpid + '&approveBy=' + edpapproveBy, function(response) {
				if (response == 'success') {
					$("#edpapprovedmodal").modal('show');
				}
			}, null);
		}
	}
}
function approveEDP(){
	location.href=BASE_URL+'/edp/loadedp.htm';
}
function changeedpQty(	qty,itemid,shcharge) {
	shcharge = 0;
	$("#edpitmupdate_" + itemid).css('background-color', 'orange');
	var isno = isNaN(qty);
	if (isno) {
		$("#validedpitemquantity").modal('show');
	} else {
		if (qty < 0) {
			$("#positiveedpitemquantity").modal('show');
			}
		else
			{
			changeedpQtyNEW1(qty,itemid,0);
			}
	}
}
function changeedpQtyNEW(qty,itemid,val)
{
	var reqrdqty;
	var oldstock=$("#"+itemid).find("td:eq(5)").text();
	if(parseInt(oldstock)>=parseInt(qty) || qty==''){
		reqrdqty=0;
	}
	else
	{
		reqrdqty=qty-oldstock;
	}
	$("#"+itemid).find("td:eq(9)").html(reqrdqty);
}
function changeedpQtyNEW1(qty,itemid,val)
{
	var reqrdqty;
	var oldstock=$("#"+itemid).find("td:eq(4)").text();
	if(parseInt(oldstock)>=parseInt(qty) || qty==''){
		reqrdqty=0;
	}
	else
	{
		reqrdqty=qty-oldstock;
	}
	$("#"+itemid).find("td:eq(8)").html(reqrdqty);
}
function editExistingEDPItem(itemid,edpid,edpitemid)
{
	var edpUpdBy = $("#hidedpCrtBy").val();
	var d = new Date();
	var updateDate = d.getFullYear() + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" + ("0" + d.getDate()).slice(-2);
	var edpqty = $("#edpqty_" + edpitemid).val();
	if(isNaN(edpqty) || edpqty=='')
		{
		$("#validedpitemquantity").modal('show');
		}
	else if(edpqty<0)
		{
		$("#positiveedpitemquantity").modal('show');
		}
	else{
	$('#saverecipe > tbody  > tr').each(function() {
		var that = this;
		if (this.id == itemid) {
			var estimateDailyProdItem = {};
			var menuitem = {};
			menuitem.id = itemid;
			estimateDailyProdItem.id=edpitemid;
			estimateDailyProdItem.estimateDailyProdId.id=edpid;
			estimateDailyProdItem.storeId = storeid;
			estimateDailyProdItem.menuItem = menuitem;
			estimateDailyProdItem.oldStock=$(that).find("td:eq(4)").text();
			estimateDailyProdItem.minDuantity=$(that).find("td:eq(5)").text();
			estimateDailyProdItem.edProdAmount=edpqty;
			estimateDailyProdItem.requiredQuantity=$(that).find("td:eq(8)").text();
			estimateDailyProdItem.costAmount=50;
			estimateDailyProdItem.edpStatus="Y";
			estimateDailyProdItem.deleteFlag="N";
			estimateDailyProdItem.createdDate = updateDate;
			estimateDailyProdItem.createdBy = edpUpdBy;
			estimateDailyProdItem.updatedDate = updateDate;
			estimateDailyProdItem.updatedBy = edpUpdBy;
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjaxPost(BASE_URL + '/edp/updateedpitem.htm',estimateDailyProdItem, function(response) {
				if(response=='success')
				{
					$("#edpitemupdatedmodal").modal('show');
					$("#edpitmupdate_" + itemid).css('background-color', '#78B626');
				}
			}, null);
		}
	});
	}
}
function deleteEDP()
{
	$("#edpdeletemodal").modal('show');
}
function deletecreatedEDP()
{
	var edpid = $("#edpId").val();
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + '/edp/deleteedp.htm?storeId=' + storeid + '&edpid=' + edpid, function(response) {
		if (response == 'success') {
			$("#edpdeletesuccessmodal").modal('show');
		}
	}, null);
}
function opennewfromoldEdpModal()
{
	$("#createnewfromoldedpalertMsg").html("");
	$("#createnewfromoldedpmodal").modal('show');
}
function getoldEDP(oldedpdate)
{
	$("#edpdetailsfromold").html("");
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + '/edp/getoldedpbystoreid.htm?oldedpdate=' + oldedpdate , function(response) {
		try{
		var edpdetails = JSON.parse(response);
		for ( var i = 0; i < edpdetails.length; i++) {
			var edpdetail = edpdetails[i];
			var createdrowline = "";
			var generatedHtml = "";
			if(edpdetail.approved=='Y')
				{
				var starttrline = "<tr class='selected-edp-row' style='background-color: #F7FBC5;'>";
				var firsttdline = "<td>" + edpdetail.id + "</td>";
				var secondtdline = "<td>" + edpdetail.estimateType.name + "</td>";
				var thirdtdline = "<td>" + edpdetail.approved + "</td>";
				var fourthtdline = "<td><input type='radio' id='oldedpid' name='oldedpname' value='"+edpdetail.id+"' onclick='javascript:getoldedpItems(this.value,"+edpdetail.estimateType.id+")'></td>";
				var endtrline = "</tr>";
				createdrowline = starttrline + firsttdline + secondtdline + thirdtdline + fourthtdline + endtrline;
				$("#edpdetailsfromold").append(createdrowline);
				}
			}
		}catch(e){}
	}, null);
	
}
function getoldedpItems(edpid,edptypeid)
{
	//alert(edpid+":"+edptypeid);
	$("#hidoldedpid").val(edpid);
	$("#hidoldedptypeid").val(edptypeid);
}
function createnewedpfromOld()
{
	var oldedpid=$("#hidoldedpid").val();
	var oldedptypeid=$("#hidoldedptypeid").val();
	var newedpDate=$("#newedpDate").val();
	var edpCrtBy = $("#hidedpCrtBy").val();
	if(oldedpid==0)
		{
		$("#createnewfromoldedpalertMsg").html(getEDPLang.plsSelctEDP);
		}
	else if(newedpDate=='')
		{
		$("#createnewfromoldedpalertMsg").html(getEDPLang.plsEntrNewEDPDate);
		}
	else
		{
		$("body").css("cursor", "wait");
		var estimateDailyProd={};
		var estimateType={};
		var estimateDailyProdItems=[];
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/edp/getedpbystoreidandid.htm?edpid=" + oldedpid, function(response) {
			try {
				var itemdetails = JSON.parse(response);
				for ( var i = 0; i < itemdetails.length; i++) {
					var itemdetail = itemdetails[i];
					var estimateDailyProdItem = {};
					var menuitem = {};
					menuitem.id = itemdetail.menuItem.id;
					//estimateDailyProdItem.estimateDailyProdId=edpid;
					estimateDailyProdItem.storeId = storeid;
					estimateDailyProdItem.menuItem = menuitem;
					estimateDailyProdItem.oldStock=itemdetail.oldStock;
					estimateDailyProdItem.minDuantity=itemdetail.minDuantity;
					estimateDailyProdItem.edProdAmount=itemdetail.edProdAmount;
					estimateDailyProdItem.requiredQuantity=itemdetail.requiredQuantity;
					estimateDailyProdItem.costAmount=50;
					estimateDailyProdItem.edpStatus="N";
					estimateDailyProdItem.createdDate = newedpDate;
					estimateDailyProdItem.createdBy = edpCrtBy;
					estimateDailyProdItems.push(estimateDailyProdItem);
				}
				estimateType.id=oldedptypeid;
				estimateDailyProd.estimateType=estimateType;
				estimateDailyProd.storeId = storeid;
				estimateDailyProd.date=newedpDate;
				estimateDailyProd.dateText=newedpDate;
				estimateDailyProd.total=1;
				estimateDailyProd.createdBy = edpCrtBy;
				estimateDailyProd.createdDate = newedpDate;
				estimateDailyProd.deleteFlag = "N";
				estimateDailyProd.approved="N";
				estimateDailyProd.requisitionPoStatus="N";
				estimateDailyProd.estimateDailyProdItems=estimateDailyProdItems;
				var ajaxCallObject = new CustomBrowserXMLObject();
				ajaxCallObject.callAjaxPost(BASE_URL + '/edp/createedp.htm',estimateDailyProd, function(response) {
					$("body").css("cursor", "default");
					if(response==0)
						{
						$("#createnewfromoldedpalertMsg").html(getEDPLang.edpNotCrtd);
						}
					else if(response== getEDPLang.cont1)
						{
						$("#createnewfromoldedpalertMsg").html(response);
						}
					else
						{
						$("#createnewfromoldedpmodal").modal('hide');
						$("#edpsuccessdmodal").modal('show');
						}
					
				}, null);
			} catch (e) {
				}	
		}, null);
		
		}
}
function printEDP(){
	window.open(BASE_URL+'/pages/rm/printedp.jsp','_blank');
}