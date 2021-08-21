/**
 * 
 */


function formatDate(date) {
	var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
			+ d.getDate(), year = d.getFullYear();

	if (month.length < 2)
		month = '0' + month;
	if (day.length < 2)
		day = '0' + day;

	return [ year, month, day ].join('-');
}

/* Hotel Tax Start */

function addHotelTax() {
	
	document.getElementById('addalertMsg').innerHTML = '';
	
	var taxName = decodeURIComponent(document
			.getElementById('modaddhoteltaxname').value);
	var taxPercentage = decodeURIComponent(document
			.getElementById('modaddhoteltaxpercentage').value);

	if (taxName == '' || taxPercentage == '') {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else {
		var taxForFoomBook = {};
		taxForFoomBook.name = taxName;
		taxForFoomBook.percentage = taxPercentage;
		taxForFoomBook.isActive = 'Y';
			
		var date = new Date();
		taxForFoomBook.effective_Date = formatDate(date);
		$.ajax({
					url : BASE_URL + "/hoteltaxmgnt/addhoteltax.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(taxForFoomBook),
					success : function(response) {
						console.log(response);

						if (response==='success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
							$('#hoteltaxAddModal').modal('hide');
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							$('#hoteltaxAddModal').modal('hide');
							showalertcatdataopModal();
						}	
					}
				});
	}
}

function editHotelTax() {

	document.getElementById('addalertMsg').innerHTML = '';
	
	var taxId = decodeURIComponent(document
			.getElementById('modedithoteltaxid').value);
	var taxName = decodeURIComponent(document
			.getElementById('modedithoteltaxname').value);
	var taxPercentage = decodeURIComponent(document
			.getElementById('modedithoteltaxpercentage').value);
	var taxStatus = document
	   .getElementById('modedithoteltaxstatus').value;
	
	if (taxName == '' || taxPercentage == '') {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else {
		var taxForFoomBook = {};
		taxForFoomBook.id = taxId;
		taxForFoomBook.name = taxName;
		taxForFoomBook.percentage = taxPercentage;
		taxForFoomBook.isActive = taxStatus;
		
		var date = new Date();
		taxForFoomBook.effective_Date = formatDate(date);
		$
				.ajax({
					url : BASE_URL + "/hoteltaxmgnt/edithoteltax.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(taxForFoomBook),
					success : function(response) {
						console.log(response);
					
						if (response === 'success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucUpdate;
							$('#hoteltaxEditModal').modal('hide');
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							$('#hoteltaxEditModal').modal('hide');
							showalertcatdataopModal();
						}
					}
				});
	}
}

function deleteHotelTax() {

	document.getElementById('addalertMsg').innerHTML = '';
	
	var taxId = decodeURIComponent(document
			.getElementById('moddeletehoteltaxid').value);
	var taxName = decodeURIComponent(document
			.getElementById('moddeletehoteltaxname').value);
	var taxPercentage = decodeURIComponent(document
			.getElementById('moddeletehoteltaxpercentage').value);
	var taxStatus = document
	   .getElementById('modedithoteltaxstatus').value;
	
	if (taxName == '' || taxPercentage == '') {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else {
		var taxForFoomBook = {};
		taxForFoomBook.id = taxId;
		taxForFoomBook.name = taxName;
		taxForFoomBook.percentage = taxPercentage;
		taxForFoomBook.isActive = taxStatus;
		
		var date = new Date();
		taxForFoomBook.effective_Date = formatDate(date);
		$
				.ajax({
					url : BASE_URL + "/hoteltaxmgnt/deletehoteltax.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(taxForFoomBook),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						
						if (response === 'success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucDelete;
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotDelete;
							showalertcatdataopModal();
						}
					}
				});
	}
}

/* Hotel Tax End */

/* Country Start */

function addCountry() {
	
	document.getElementById('addalertMsg').innerHTML = '';
	
	var countryName = decodeURIComponent(document
			.getElementById('modaddcountryname').value);
	var countryCurrency = decodeURIComponent(document
			.getElementById('modaddcountrycurrency').value);
	
	if (countryName == '' || countryCurrency == '') {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else {
		var country = {};
		country.countryname = countryName;
		country.courency = countryCurrency;
	
		$
				.ajax({
					url : BASE_URL + "/countrymgnt/addcountry.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(country),
					success : function(response) {
						console.log(response);
					
						if (response === 'success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
							$('#countryAddModal').modal('hide');
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							$('#countryAddModal').modal('hide');
							showalertcatdataopModal();
						}
					}
				});
	}
}

function editCountry() {
	
	document.getElementById('addalertMsg').innerHTML = '';
	
	var countryId = decodeURIComponent(document
			.getElementById('modeditcountryid').value);
	var countryName = decodeURIComponent(document
			.getElementById('modeditcountryname').value);
	var countryCurrency = decodeURIComponent(document
			.getElementById('modeditcountrycurrency').value);
	
	if (countryName == '' || countryCurrency == '') {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else {
		var country = {};
		country.id = countryId;
		country.countryname = countryName;
		country.courency = countryCurrency;

		$
				.ajax({
					url : BASE_URL + "/countrymgnt/editcountry.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(country),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						
						if (response === 'success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucUpdate;
							$('#countryEditModal').modal('hide');
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							$('#countryEditModal').modal('hide');
							showalertcatdataopModal();
						}
					}
				});
	}
}

function deleteCountry() {
	
	document.getElementById('addalertMsg').innerHTML = '';
	
	var countryId = decodeURIComponent(document
			.getElementById('moddeletecountryid').value);
	var countryName = decodeURIComponent(document
			.getElementById('moddeletecountryname').value);
	var countryCurrency = decodeURIComponent(document
			.getElementById('moddeletecountrycurrency').value);
	
	if (countryName == '' || countryCurrency == '') {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else {
		var country = {};
		country.id = countryId;
		country.countryname = countryName;
		country.courency = countryCurrency;
		
		$
				.ajax({
					url : BASE_URL + "/countrymgnt/deletecountry.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(country),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						
						if (response === 'success') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucDelete;
							showalertcatdataopModal();
						} else {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotDelete;
							showalertcatdataopModal();
						}
					}
				});
	}
}

/* Country End */

/* Country - Hotel Link Start */

function updatecountrylink() {
	
	var countryLinkId = document
	   .getElementById('countryLinkup').value;
	if(countryID!=countryLinkId)
	{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject.callAjax(BASE_URL + "/countrymgnt/updatecountrylink/" + countryLinkId
				+ ".htm", function(response) {
			if (response === 'success') {
				showcountrylinkupdatesuccessModal();
			} else {
				document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
				showalertcatdataopModal();
			}
			showcountrylinkupdatesuccessModal();
		}, null);
	}
	else if(countryID==countryLinkId && countryID!='0'){
		document.getElementById('catdataopmassagecont').innerHTML = "Selected Country is already linked with Hotel !!";
		showalertcatdataopModal();
	}
	else if(countryID==countryLinkId){
		document.getElementById('catdataopmassagecont').innerHTML = "Sorry! Please select a Country to update !!";
		showalertcatdataopModal();
	}
	
}

function jLogout() {
	location.href = BASE_URL + '/authentication/logout.htm';
}

/* Country - Hotel Link End */

/* RoomType - Amenities Link Start */

function selectRoomType() {

	var roomType = document.getElementById('roomTypeLinkup').value;
		
	if(roomType!=0)
	{
		var ajaxCallObject = new CustomBrowserXMLObject();	
		var responseObj;
		
		ajaxCallObject.callAjax(BASE_URL + "/roomtypeamenitiesmgnt/getAllAmenities.htm", function(response) {
		
		$("#amenitiesMapTBody").empty();	
			
		var createdrowline=null;
		responseObj = JSON.parse(response);
	
		if(responseObj!=null)
		{
			for(var i=0;i<responseObj.length;i++)
			{
				var begintrline = "<tr style='background:#404040; color:#FFF;'>";
				var firstTd ="<td align='center'>"+responseObj[i].id+"</td>";
				var secondTd="<td align='center'>"+responseObj[i].amenities+"</td>";
				var thirdTd="<td align='center'><input type='checkbox' id='amenitieschk' name='amenitiesChk' value="+responseObj[i].id+" style='margin-bottom: 2px;width:15px;height:15px;'>&nbsp;&nbsp;&nbsp;</td>";				
				var endtrline="</tr>";
				createdrowline += begintrline + firstTd + secondTd + thirdTd + endtrline;
			}			
		}
		else 
		{
			var begintrline = "<tr style='background:#404040; color:#FFF;'>";s
			var emptyTd="<td colspan='3'><spring:message code='admin.menumgnt.jsp.nodatafound' text='No Data found!' /></td>";
			var endtrline="</tr>";
			createdrowline += begintrline + emptyTd + endtrline;
		}
		$("#amenitiesMapTBody").append(createdrowline);	
	
		ajaxCallObject.callAjax(BASE_URL+"/roomtypeamenitiesmgnt/getAllAmenitiesMapToRoomType.htm?roomType=" +roomType, function(response) {
			
			var responseStatus = JSON.parse(response);	
			var amenitiesMapDetails=[];
			if(responseStatus!=null)
			{
				amenitiesMapDetails = responseStatus.roomAmenitiesMap;
			}			
			var amenitiesCheckedRows = [];
			
			
			if(responseObj!=null && amenitiesMapDetails!=null)
			{
				for(var i=0;i<amenitiesMapDetails.length;i++)
				{
					for(var j=0;j<responseObj.length;j++)
					{
						
						if(parseInt(amenitiesMapDetails[i].isEnable)== 1 && parseInt(amenitiesMapDetails[i].amenitiesId)==parseInt(responseObj[j].id))
						{
							var checkboxes = document.getElementsByName('amenitiesChk');
							for ( var m = 0; m < checkboxes.length; m++) {
								if (checkboxes[m].value==amenitiesMapDetails[i].amenitiesId) 
								{
									checkboxes[m].checked = true;
									amenitiesCheckedRows.push(checkboxes[m].id);
								}
							}
						}
					}	
				}
			}
			console.log(amenitiesCheckedRows);
			if(amenitiesCheckedRows.length>0)
			{
				$("#submitAmenitiesMapDiv").hide();
				$("#updateAmenitiesMapDiv").show();
			}
			else
			{
				$("#updateAmenitiesMapDiv").hide();
				$("#submitAmenitiesMapDiv").show();
			}
		}, null);	
	}, null);	
	}
	else 
	{
		$("#amenitiesMapTBody").empty();
		$("#submitAmenitiesMapDiv").hide();
	}
}

function submitAmenitieslink() {
	
	
	var roomType = document.getElementById('roomTypeLinkup').value;
	
	var amenitiesRows = [];
	var enabledRows = [];

	var checkboxes = document.getElementsByName('amenitiesChk');
	for ( var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			amenitiesRows.push(checkboxes[i].value);
			enabledRows.push(1);
		}
		else {
			amenitiesRows.push(checkboxes[i].value);
			enabledRows.push(0);
		}
	}
	var amenities=JSON.stringify(amenitiesRows);
	var enabled=JSON.stringify(enabledRows);
		
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/roomtypeamenitiesmgnt/assignRoomTypeAmenitiesLinkPost/" + roomType + "/" + amenities + "/" + enabled
			+ ".htm", function(response) {
		if (response === 'success') {
			document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucUpdate;
			showalertcatdataopModal();				
		} else {
			document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
			showalertcatdataopModal();
		}
	}, null);
}

function updateAmenitieslink() {
	
	var roomType = document.getElementById('roomTypeLinkup').value;
	
	var amenitiesRows = [];
	var enabledRows = [];

	var checkboxes = document.getElementsByName('amenitiesChk');
	for ( var i = 0; i < checkboxes.length; i++) {
		if (checkboxes[i].checked) {
			amenitiesRows.push(checkboxes[i].value);
			enabledRows.push(1);
		}
		else {
			amenitiesRows.push(checkboxes[i].value);
			enabledRows.push(0);
		}
	}
	var amenities=JSON.stringify(amenitiesRows);
	var enabled=JSON.stringify(enabledRows);
	
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/roomtypeamenitiesmgnt/updateRoomTypeAmenitiesLink/" + roomType + "/" + amenities + "/" + enabled
			+ ".htm", function(response) {
		if (response === 'success') {
			document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucUpdate;
			showalertcatdataopModal();				
		} else {
			document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
			showalertcatdataopModal();
		}
	}, null);
}

/* RoomType - Amenities Link End */


function addAmenities() {
	document.getElementById('addalertMsg').innerHTML = '';
	var amenitiesName = decodeURIComponent(document
			.getElementById('addroomamenitiesContId').value);
	
	// var storeID=storeId;
	if (amenitiesName == '' ) {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(amenitiesName)) {
		document.getElementById('addalertMsg').innerHTML = getLang.charNotAlowd;
	} else {
		var amenitiesPost = {};
		amenitiesPost.amenities = amenitiesName;
	//	maneCategoryPost.bgColor = bgColor;
		amenitiesPost.hotelId = storeID;
		$
				.ajax({
					url : BASE_URL + "/rmmgnt/addamenities.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(amenitiesPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'success') {
							document.getElementById('amenitiesdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertamenitiesdataopModal();
						} else {
							document.getElementById('amenitiesdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertamenitiesdataopModal();
						}
					}
				});
	}
}

function editAmenities() {
	var flag = document.getElementById('modeditmenuitemsUnit').value;
	document.getElementById('editalertMsg').innerHTML = '';
	var id = document.getElementById('modeditamenitiesidContId').value;
	var amenities = decodeURIComponent(document
			.getElementById('editamenitiesnameContId').value);
	//var color = decodeURIComponent(document.getElementById('editbgcolorContId').value);
	console.log("id" + id);
	if (amenities == '') {
		document.getElementById('editalertMsg').innerHTML = getLang.failtoReq;
	}  else {
		var AmenitiesEditPost = {};
		AmenitiesEditPost.id = id;
		AmenitiesEditPost.flag = flag;
		AmenitiesEditPost.amenities = amenities;
		AmenitiesEditPost.hotelId = storeID;
		$
				.ajax({
					url : BASE_URL + "/rmmgnt/editamenities.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(AmenitiesEditPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						closermaminitieseditModal();
						if (response == 'success') {
							//alert("in success");
							document.getElementById('amenitiesdataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertamenitiesdataopModal();
						} else {
							//alert("failed");
							document.getElementById('amenitiesdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertamenitiesdataopModal();
						}
					}
				});

		/*
		 * var ajaxCallObject = new CustomBrowserXMLObject();
		 * ajaxCallObject.callAjax(BASE_URL + "/menumgnt/editmenucategory/" + id +
		 * "/" + name + "/" + color + ".htm", function(response) {
		 * closenmenucateditModal(); if(response==success) {
		 * document.getElementById('catdataopmassagecont').innerHTML='Data is
		 * sucessfully edited!'; showalertcatdataopModal(); } else{
		 * document.getElementById('catdataopmassagecont').innerHTML=getLang.datasucNotUpdate;
		 * showalertcatdataopModal(); }
		 * //location.href=BASE_URL+'/menumgnt/viewmenumgnt.htm'; }, null);
		 */
	}
}

function deleteAmenities() {
	var id = document.getElementById('moddeleteconfirmamenitiesidContId').value;
	var amenities = decodeURIComponent(document
			.getElementById('moddeleteconfirmamenitiesnameContId').value);


	var AmenitiesDeletePost = {};
	AmenitiesDeletePost.id = id;
	AmenitiesDeletePost.amenities = amenities;
	//AmenitiesDeletePost.bgColor = color;
	AmenitiesDeletePost.hotelId = storeID;
	$
			.ajax({
				url : BASE_URL + "/rmmgnt/deleteamenities.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(AmenitiesDeletePost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					closeConfirmdeleteAmenitiesModal();
					if (response == 'success') {
						document.getElementById('amenitiesdataopmassagecont').innerHTML = getLang.datasucDelete;
						showalertamenitiesdataopModal();
					} else {
						document.getElementById('amenitiesdataopmassagecont').innerHTML = getLang.datasucNotDelete;
						showalertamenitiesdataopModal();
					}
				}
			});
}


function selectTaxValue(taxname)
{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
		.callAjax(
				BASE_URL + "/rmtypemgnt/gettaxdetails/" + taxname
						+ ".htm",
				function(response) {
					var responseObj = [];
					responseObj = JSON.parse(response);
					console.log("responseObj" + "" +responseObj);
					var optionline = "";
					for ( var i = 0; i < responseObj.length; i++) {
						var id = responseObj[i].id;
						var percentage = responseObj[i].percentage;
						
						//console.log("responseObj.isActive" + "" +responseObj[i].isActive);
						if(responseObj[i].isActive=='Y')
							{
								optionline += "<option value='" + id + "'>" + percentage
								+ "</option>";
							}					
					}
					document.getElementById('modaddPercentage').innerHTML = optionline;
				}, null);
	 
	 

}

function selectTaxValueEdit(taxname, taxPercentage)
{
		var ajaxCallObject = new CustomBrowserXMLObject();
		ajaxCallObject
		.callAjax(
				BASE_URL + "/rmtypemgnt/gettaxdetails/" + taxname
						+ ".htm",
				function(response) {
					var responseObj = [];
					responseObj = JSON.parse(response);
					console.log("responseObj" + "" +responseObj);
					var optionline = "";
					for ( var i = 0; i < responseObj.length; i++) {
						var id = responseObj[i].id;
						var percentage = responseObj[i].percentage;
						
						//console.log("responseObj.isActive" + "" +responseObj[i].isActive);
						if(responseObj[i].isActive=='Y')
						{
							if(percentage==taxPercentage){
								
								optionline += "<option value='" + id + "' selected>" + percentage
								+ "</option>";
							}
							else {
								optionline += "<option value='" + id + "'>" + percentage
								+ "</option>";
							}
						}					
					}
					document.getElementById('modEditPercentage').innerHTML = optionline;
				}, null);
}

function addRoomType(){

	document.getElementById('addalertMsg').innerHTML = '';
	
//	var taxOption=$("#modaddPercentage").val();

	var roomType = document
			.getElementById('addroomtypeContId').value;
	/*var ac = document.getElementsByName('modaddrmAC');
	var amount=document.getElementById('addamountContId').value;
	var roomSize=document.getElementById('addsizeContId').value;
	var roomSizeUnit=document.getElementById('addunitContId').value;
	var roomDesc=document.getElementById('adddescriptionContId').value;*/
		
/*	console.log(taxOption);
	
	var actype=null;
	for ( var i = 0; i < ac.length; i++) {
		if (ac[i].checked == true) {
			actype = ac[i].value;
		}
	}*/
	// var storeID=storeId;
	if (roomType == '' ) {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	}  else {
		var roomtypePost = {};
	//	roomtypePost.taxId=taxOption;
		roomtypePost.roomType = roomType;
		roomtypePost.hotelId = storeID;
		/*roomtypePost.ac=actype;
		roomtypePost.roomPrice=amount;
		roomtypePost.roomSize=roomSize;
		roomtypePost.roomSizeUnit=roomSizeUnit;
	//	roomtypePost.roomSizeUnit=roomSizeUnit;
		roomtypePost.roomDesc=roomDesc;*/
		$
				.ajax({
					url : BASE_URL + "/rmtypemgnt/addroomtype.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(roomtypePost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'success') {
							document.getElementById('roomtypedataopmassagecont').innerHTML = getLang.datasucAdd;
							$('#roomtypeAddModal').modal('hide');
							showalertroomdataopModal();
						} else {
							document.getElementById('roomtypedataopmassagecont').innerHTML = getLang.datasucNotAdd;
							$('#roomtypeAddModal').modal('hide');
							showalertroomdataopModal();
						}
					}
				});
	}
}

function editRoomType(){

	document.getElementById('editalertMsg').innerHTML = '';
	
	//var taxOption=$("#modEditPercentage").val();
	var id = document.getElementById('modeditroomtypeid').innerHTML;
	var roomType = document.getElementById('editroomtypeContId').value;
	/*var ac = document.getElementsByName('modeditrmAC');
	var amount=document.getElementById('editamountContId').value;
	var roomSize=document.getElementById('editsizeContId').value;
	var roomSizeUnit=document.getElementById('editunitContId').value;
	var roomDesc=document.getElementById('editdescriptionContId').value;*/
		
	//console.log(taxOption);
	
	//var actype=null;
/*	for ( var i = 0; i < ac.length; i++) {
		if (ac[i].checked == true) {
			actype = ac[i].value;
		}
	}*/
	// var storeID=storeId;
	if (roomType == '' ) {
		document.getElementById('editalertMsg').innerHTML = getLang.failtoReq;
	}  else {
		var roomtypePost = {};
		roomtypePost.id=id;
		//roomtypePost.taxId=taxOption;
		roomtypePost.roomType = roomType;
		roomtypePost.hotelId = storeID;
		/*roomtypePost.ac=actype;
		roomtypePost.roomPrice=amount;
		roomtypePost.roomSize=roomSize;
		roomtypePost.roomSizeUnit=roomSizeUnit;
		roomtypePost.roomDesc=roomDesc;*/
		$
				.ajax({
					url : BASE_URL + "/rmtypemgnt/editroomtype.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(roomtypePost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						// closenmenucataddModal();
						if (response == 'success') {
							document.getElementById('roomtypedataopmassagecont').innerHTML = getLang.datasucUpdate;
							$('#roomtypeEditModal').modal('hide');
							showalertroomdataopModal();
						} else {
							document.getElementById('roomtypedataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							$('#roomtypeEditModal').modal('hide');
							showalertroomdataopModal();
						}
					}
				});
	}
}

	function deleteRoomType(){

//		document.getElementById('editalertMsg').innerHTML = '';
//		
//		var taxOption=$("#modEditPercentage").val();
//
//		var roomType = document.getElementById('editroomtypeContId').value;
//		var ac = document.getElementsByName('modeditrmAC');
//		var amount=document.getElementById('editamountContId').value;
//		var roomSize=document.getElementById('editsizeContId').value;
//		var roomSizeUnit=document.getElementById('editunitContId').value;
//		var roomDesc=document.getElementById('editdescriptionContId').value;
		
		var roomTypeId = decodeURIComponent(document
				.getElementById('moddeleteroomtypeid').value);
		var roomTypeName = decodeURIComponent(document
				.getElementById('moddeleteroomtypename').value);
		
//		console.log(taxOption);
//		
//		var actype=null;
//		for ( var i = 0; i < ac.length; i++) {
//			if (ac[i].checked == true) {
//				actype = ac[i].value;
//			}
//		}
	
			var roomtypePost = {};
			roomtypePost.id=roomTypeId;
//			roomtypePost.taxId=taxOption;
			roomtypePost.roomType = roomTypeName;
			roomtypePost.hotelId = storeID;
//			roomtypePost.ac=actype;
//			roomtypePost.roomPrice=amount;
//			roomtypePost.roomSize=roomSize;
//			roomtypePost.roomSizeUnit=roomSizeUnit;
//		//	roomtypePost.roomSizeUnit=roomSizeUnit;
//			roomtypePost.roomDesc=roomDesc;
			$
					.ajax({
						url : BASE_URL + "/rmtypemgnt/deleteroomtype.htm",
						type : 'POST',
						contentType : 'application/json;charset=utf-8',
						data : JSON.stringify(roomtypePost),
						success : function(response, JSON_UNESCAPED_UNICODE) {
							console.log(response);
							// closenmenucataddModal();
							if (response == 'success') {
								document.getElementById('roomtypedataopmassagecont').innerHTML = getLang.datasucDelete;
								$('#confirmdeleteRoomTypeModal').modal('hide');
								showalertroomdataopModal();
							} else {
								document.getElementById('roomtypedataopmassagecont').innerHTML = getLang.datasucNotDelete;
								$('#confirmdeleteRoomTypeModal').modal('hide');
								showalertroomdataopModal();
							}
						}
					});
}

function addRoom()
{
	document.getElementById('addalertMsg').innerHTML = '';
	var roomNo=document.getElementById('addroomContId').value;
	var floor=document.getElementById('addfloornumberContId').value;
	var roomTypeId=document.getElementById('modaddroomType').value;
	
	var roomName=document.getElementById('addroomnameContId').value;
	
	var taxOption=$("#modaddPercentage").val();

	var capacity=document.getElementById('addcapacityContId').value;
	var ac = document.getElementsByName('modaddrmAC');
	var amount=document.getElementById('addamountContId').value;
	var roomSize=document.getElementById('addsizeContId').value;
	var roomSizeUnit=document.getElementById('addunitContId').value;
	var roomDesc=document.getElementById('adddescriptionContId').value;
		
	console.log(taxOption);
	
	var actype=null;
	for ( var i = 0; i < ac.length; i++) {
		if (ac[i].checked == true) {
			actype = ac[i].value;
		}
	}
	
	if(roomNo==''||floor=='')
		{
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;

		}
	else
		{
		var roomPost={};
		roomPost.roomNo=roomNo;
		roomPost.floor=parseInt(floor);
		roomPost.roomName=roomName;
		roomPost.roomTypeId=parseInt(roomTypeId);
		roomPost.id=parseInt(0);
		roomPost.hotelId=storeID;
		
		roomPost.roomTax=taxOption;
		roomPost.roomCategory=actype;
		roomPost.roomPrice=amount;
		roomPost.roomSize=roomSize;
		roomPost.roomSizeUnit=roomSizeUnit;
		roomPost.roomDesc=roomDesc;
		roomPost.roomCapacity=capacity;
		roomPost.status=0;
		$
				.ajax({
					url : BASE_URL + "/roommgnt/addroom.htm",
					type : 'POST',
					contentType : 'application/json',     //;charset=utf-8
					data : JSON.stringify(roomPost),
					
					success : function(response, JSON_UNESCAPED_UNICODE) {     //
						closermaddModal();
						if (response == 'success') {
							document.getElementById('roomdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertroomdataopModal();
							
						}
						else{
							document.getElementById('roomdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertroomdataopModal();
						
						}
					
					}

				});
		
		}
}


function editRoom()
{
	document.getElementById('addalertMsg').innerHTML = '';
	var id = document.getElementById('modeditroomidContId').value;
	var roomNo=document.getElementById('editroomContId').value;
	var floor=document.getElementById('editfloornumberContId').value;
	var roomTypeId=document.getElementById('modeditroomType').value;
	
	var roomName=document.getElementById('editroomnameContId').value;
	
	var taxOption=$("#modEditPercentage").val();
	var ac = document.getElementsByName('modeditrmAC');
	var amount=document.getElementById('editamountContId').value;
	var roomSize=document.getElementById('editsizeContId').value;
	var roomSizeUnit=document.getElementById('editunitContId').value;
	var roomDesc=document.getElementById('editdescriptionContId').value;
	var capacity=document.getElementById('editcapacityContId').value;
	var status=document.getElementById('editroomstatusId').value;
	console.log(roomTypeId);
	
	var actype=null;
	for ( var i = 0; i < ac.length; i++) {
		if (ac[i].checked == true) {
			actype = ac[i].value;
		}
	}
	if(roomNo==''||floor=='')
		{

		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;

		}
	else
		{
		var roomPost={};
		roomPost.roomNo=roomNo;
		roomPost.floor=floor;
		roomPost.roomName=roomName;
		roomPost.roomTypeId=roomTypeId;
		roomPost.id=id;
		roomPost.hotelId=storeID;
			
		roomPost.roomTax=taxOption;
		roomPost.roomCategory=actype;
		roomPost.roomPrice=amount;
		roomPost.roomSize=roomSize;
		roomPost.roomSizeUnit=roomSizeUnit;
		roomPost.roomDesc=roomDesc;
		roomPost.roomCapacity=capacity;
		roomPost.status=status;
		$
				.ajax({
					url : BASE_URL + "/roommgnt/editroom.htm",
					type : 'POST',
					contentType : 'application/json',     //;charset=utf-8
					data : JSON.stringify(roomPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {     //, JSON_UNESCAPED_UNICODE
						closermeditModal();
						if (response == 'success') {
							document.getElementById('roomdataopmassagecont').innerHTML = getLang.datasucUpdate;
							//alert("in success");
							showalertroomdataopModal();
						}
						else{
							document.getElementById('roomdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							//alert("in failure");
							showalertroomdataopModal();
						
						}
					
					}

				});
		
		}
	
	
}



function deleteRoom() {
	var id = document.getElementById('moddeleteconfirmroomidContId').value;
	var roomNo = decodeURIComponent(document
			.getElementById('moddeleteconfirmroomnoContId').value);
	var floor = decodeURIComponent(document
			.getElementById('moddeleteconfirmfloorContId').value);


	var RoomDeletePost = {};
	RoomDeletePost.id = id;
	RoomDeletePost.roomNo = roomNo;
	RoomDeletePost.floor = floor;
	RoomDeletePost.hotelId = storeID;
	$
			.ajax({
				url : BASE_URL + "/roommgnt/deleteroom.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(RoomDeletePost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					closeConfirmdeleteRoomModal();
					if (response == 'success') {
						document.getElementById('roomdataopmassagecont').innerHTML = getLang.datasucDelete;
						showalertroomdataopModal();
					} else {
						document.getElementById('roomdataopmassagecont').innerHTML = getLang.datasucNotDelete;
						showalertroomdataopModal();
					}
				}
			});
}


function addRoomServices(){
	document.getElementById('addalertMsg').innerHTML = '';
	var roomservices = decodeURIComponent(document.getElementById('addroomservicesContId').value);
	var roomservicesdesc = decodeURIComponent(document.getElementById('addroomservicesDescripton').value);
	var serviceRate = document.getElementById('addroomservicesRate').value;
	var isTax = document.getElementById('addroomservicesIsTax').value;
	var taxRate = document.getElementById('addroomservicesTaxRate').value;
	var isServiceCharge = document.getElementById('addroomservicesIsSChrge').value;
	var serviceChargeRate = document.getElementById('addroomservicesSChargeRate').value;
	
	if(serviceChargeRate == ""){serviceChargeRate = "0.0";}
	if(taxRate == ""){taxRate = "0.0";}
	
	// var storeID=storeId;
	if (roomservices == '' ) {
		document.getElementById('addalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(roomservices)) {
		document.getElementById('addalertMsg').innerHTML = getLang.charNotAlowd;
	} else if (serviceRate == '') {
		document.getElementById('addalertMsg').innerHTML = getLang.serviceRateReq;
	} else if (isTax == '1' && taxRate =="0.0") {
		document.getElementById('addalertMsg').innerHTML = getLang.taxRateReq;
	}else if (isServiceCharge == '1' && serviceChargeRate =="0.0") {
		document.getElementById('addalertMsg').innerHTML = getLang.serviceChargeRateReq;
	}  
	
	
	else {
		var roomservicesPost = {};
		roomservicesPost.name = roomservices;
	    roomservicesPost.hotelId = storeID;
	    roomservicesPost.description = roomservicesdesc;
	    roomservicesPost.rate = serviceRate;
	    roomservicesPost.isTaxable = isTax;
	    roomservicesPost.taxRate = taxRate;
	    roomservicesPost.isServiceChargable = isServiceCharge;
	    roomservicesPost.serviceChargeRate = serviceChargeRate;
		$
				.ajax({
					url : BASE_URL + "/rmservicemgnt/addroomservices.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(roomservicesPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						closermservicesaddModal();
						if (response == 'success') {
							document.getElementById('roomservicesdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertrmservicesdataopModal();
						} else {
							document.getElementById('roomservicesdataopmassagecont').innerHTML = getLang.datasucNotAdd;
							showalertrmservicesdataopModal();
						}
					}
				});
	}
}

function editRoomServices() {
	
	document.getElementById('editalertMsg').innerHTML = '';
	var id = document.getElementById('modeditroomservicesidContId').value;
	var roomservices = document.getElementById('editroomservicesContId').value;
	var roomservicesdesc = decodeURIComponent(document.getElementById('editroomservicesDescripton').value);
	var serviceRate = document.getElementById('editroomservicesRate').value;
	var isTax = document.getElementById('editroomservicesIsTax').value;
	var taxRate = document.getElementById('editroomservicesTaxRate').value;
	var isServiceCharge = document.getElementById('editroomservicesIsSChrge').value;
	var serviceChargeRate = document.getElementById('editroomservicesSChargeRate').value;
	if(serviceChargeRate == ""){serviceChargeRate = "0.0";}
	if(taxRate == ""){taxRate = "0.0";}
	if (roomservices == '' ) {
		document.getElementById('editalertMsg').innerHTML = getLang.failtoReq;
	} else if ((/[#%?\/\\]/gi).test(roomservices)) {
		document.getElementById('editalertMsg').innerHTML = getLang.charNotAlowd;
	} else if (serviceRate == '') {
		document.getElementById('editalertMsg').innerHTML = getLang.serviceRateReq;
	} else if (isTax == '1' && taxRate =="0.0") {
		document.getElementById('editalertMsg').innerHTML = getLang.taxRateReq;
	}else if (isServiceCharge == '1' && serviceChargeRate =="0.0") {
		document.getElementById('editalertMsg').innerHTML = getLang.serviceChargeRateReq;
	} else {
		var roomservicesPost = {};
		roomservicesPost.id = id;
		roomservicesPost.name = roomservices;
	    roomservicesPost.hotelId = storeID;
	    roomservicesPost.description = roomservicesdesc;
	    roomservicesPost.rate = serviceRate;
	    roomservicesPost.isTaxable = isTax;
	    roomservicesPost.taxRate = taxRate;
	    roomservicesPost.isServiceChargable = isServiceCharge;
	    roomservicesPost.serviceChargeRate = serviceChargeRate;

		$
				.ajax({
					url : BASE_URL + "/rmservicemgnt/editroomservices.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(roomservicesPost),
					success : function(response, JSON_UNESCAPED_UNICODE) {
						console.log(response);
						closermserviceseditModal();
						if (response == 'success') {
							document.getElementById('roomservicesdataopmassagecont').innerHTML = getLang.datasucUpdate;
							showalertrmservicesdataopModal();
						} else {
							document.getElementById('roomservicesdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
							showalertrmservicesdataopModal();
						}
					}
				});

		
	}
}


function deleteRoomServices() {
	var id = document.getElementById('moddeleteconfirmroomservicesidContId').value;
	var roomService = decodeURIComponent(document
			.getElementById('moddeleteconfirmroomservicesContId').value);


	var roomservicesPost = {};
	roomservicesPost.id = id;
	roomservicesPost.roomService = roomService;
	//AmenitiesDeletePost.bgColor = color;
	roomservicesPost.hotelId = storeID;
	$
			.ajax({
				url : BASE_URL + "/rmservicemgnt/deleteroomservices.htm",
				type : 'POST',
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify(roomservicesPost),
				success : function(response, JSON_UNESCAPED_UNICODE) {
					console.log(response);
					closeConfirmdeleteRoomServicesModal();
					if (response == 'success') {
						document.getElementById('roomservicesdataopmassagecont').innerHTML = getLang.datasucDelete;
						showalertrmservicesdataopModal();
					} else {
						document.getElementById('roomservicesdataopmassagecont').innerHTML = getLang.datasucNotDelete;
						showalertrmservicesdataopModal();
					}
				}
			});
}

/* RoomType - Amenities Link End */