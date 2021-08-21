/**
 * 
 */
var eventsdata = [];
var event = {};
var itemObjValue = new Array(); // for add items
var ordItemVal;

function tableprebooking_advpayment(id) {
    document.getElementById('orderidforpayadv').value = id;
    $('#prebookadvancepaymentmodal').modal('show');


}


function openadvtblbooklistsearchmodal() {
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/advancebooking/fetchprebookdata.htm", function(response) {
        try {
           // console.log(">>>>>> " + response);
            var responseObj = JSON.parse(response);

            //prepareAllPreBookTableDataHtml(responseObj);
            prepareAllPreBookEventsDataHtml(responseObj)
        } catch (e) {
            alert(e);
        }

    }, null);



}


function prepareAllPreBookTableDataHtml(data) {
    var detailsdatapart = document.getElementById('tableprebookingdetaildata');
    var begintrline = "";
    var endtrline = "";
    var firstcolumn = "";
    var secondcolumn = "";
    var thirdcolumn = "";
    var fourthcolumn = "";
    var fifthcolumn = "";
    var sixthcolumn = "";
    var seventhcolumn = "";
    var eightcolumn = "";
    var tdpart = "";
    var table = "";
    var tableheadline = "<table class='table  table-bordered' style='color:#FFF; border:1px solid #222222;'><thead>" +
        "<th style='text-align:center;'>" + "ID" + "</th><th style='text-align:center;'>" + "TABLE" +
        "</th><th style='text-align:center;'>" + "CUSTOMER" + "</th><th style='text-align:center;'>" + "CONTACT" + "</th><th style='text-align:center;'>" + "PAX" + "</th><th style='text-align:center;'>" + "ORDER DATE" + "</th><th style='text-align:center;'>" + "BOOKING DATE" + "</th><th style='text-align:center;'>" + "PAID AMMT" + "</th></thead><tbody>";

    var tableend = "</tbody></table>";
    var mail = "";
    if (data.length == 0) {
        tableheadline = "";
        tdpart = "<span style='font-size: large;align:center;'>No Data Found</span>";
        tableend = "";
    } else {
        for (var i = 0; i < data.length; i++) {

            begintrline = "<tr>";
            firstcolumn = "<td style='text-align: center;'>" + data[i].id + "</td>";
            secondcolumn = "<td style='text-align: center;'>" + data[i].table_no + "</td>";
            thirdcolumn = "<td style='text-align: center;'>" + data[i].customerName + "</td>";
            fourthcolumn = "<td style='text-align: center;'>" + data[i].customerContact + "</td>";
            fifthcolumn = "<td style='text-align: center;'>" + data[i].noOfPersons + "</td>";
            sixthcolumn = "<td style='text-align: center;'>" + data[i].orderDate + " " + data[i].time + "</td>";
            seventhcolumn = "<td style='text-align: center;'>" + data[i].orderTime + "</td>";
            eightcolumn = "<td style='text-align: center;'>" + data[i].paidAmt + "</td>";
            endtrline = "</tr>";
            tdpart += begintrline + firstcolumn + secondcolumn + thirdcolumn + fourthcolumn + fifthcolumn + sixthcolumn + seventhcolumn + eightcolumn + endtrline;
        }
    }
    table += tableheadline + tdpart + tableend;
    detailsdatapart.innerHTML = table;
    $('#advtblbooklistsearchModal').modal('show');


}



function openaddnewprebookcustomerdata() {
    document.getElementById('PreBookCustDetailsModalalertMsg').innerHTML = '';
    $('#PreBookCustDetailsModal').modal('show');
}


function addNewPreBookCustomer() {

    var phone = document.getElementById('PreBookCustDetailsPhone').value;
    var name = document.getElementById('PreBookCustDetailsName').value;
    var address = document.getElementById('PreBookCustDetailsAddress').value;
    var state = document.getElementById('PreBookCustDetailsState').value;
    //alert("phone:"+phone+"name:"+name+"address:"+address);
    if (phone == '') {
        //alert("phone");
        document.getElementById('PreBookCustDetailsModalalertMsg').innerHTML = getLang.contactmsg;
    } else if (name == '') {
        //alert("name");
        document.getElementById('PreBookCustDetailsModalalertMsg').innerHTML = getLang.namemsg;
    } else {
        //alert("success");

        document.getElementById('advbookingcustcontact').value = phone;
        document.getElementById('advbookingcustname').value = name;
        document.getElementById('advbookingcustaddress').value = address;
        document.getElementById('advbookingcuststate').value = state;
        document.getElementById('PreBookCustDetailsPhone').value = '';
        document.getElementById('PreBookCustDetailsName').value = '';
        document.getElementById('PreBookCustDetailsAddress').value = '';
        $('#PreBookCustDetailsModal').modal('hide');
    }


}




function prebookadvancepay() {
    var bookingid = document.getElementById('orderidforpayadv').value;
    var advpayammt = document.getElementById('prebookingadvpayammt').value;
    //alert("bookingid:"+bookingid+"advpayammt:"+advpayammt);
    if (advpayammt == '') {
        document.getElementById('advtblbookingadvpayalertMsg').innerHTML = getLang.fieldmsg;
    } else {
        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjax(BASE_URL +
            "/advancebooking/advpayment/" + bookingid + "/ammt/" + advpayammt + ".htm",
            function() {
                location.href = BASE_URL +
                    '/advancebooking/loadadvancebooking.htm';
            }, null);

    }


}



/*function addadvtblbookindata() {
		
		var bookdate = decodeURIComponent(document.getElementById('advbookingdate').value);
		var booktime = decodeURIComponent(document.getElementById('advbookingtime').value);
		var noofpersons = document.getElementById('advbookingcustnoofperson').value;
		var custaddress = document.getElementById('advbookingcustaddress').value;
		var custid = document.getElementById('advbookingcustid').value;
		var custlocation = document.getElementById('advbookingcustlocation').value;
	    var customerContact = document.getElementById("advbookingcustcontact").value;
		var customerName = document.getElementById("advbookingcustname").value;
		var tableno = document.getElementById('TableId').value;
        var selOption=document.getElementById("addOrderType").value;		
		var noofpersons = document.getElementById('advbookingcustnoofperson').value;

        var orderTypeName=document.getElementById('modOrderType').innerHTML;
		var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
		var storedoubleroundoffflag = document.getElementById('hidstoredoubleroundoffFlag').value;
		var netamt = 0.0;
		
		var addBookingDetails = {};
		addBookingDetails.customerName = customerName;
		addBookingDetails.customerContact = customerContact;
		addBookingDetails.orderDate = bookdate;
		addBookingDetails.time = booktime;
		addBookingDetails.table_no = tableno;
		addBookingDetails.deliveryAddress = custaddress;
		addBookingDetails.noOfPersons = noofpersons;
		addBookingDetails.storeCustomerId = custid;
		addBookingDetails.location = custlocation;
		addBookingDetails.ordertype.id=selOption;
		  
		$
				.ajax({

					url : BASE_URL + "/advancebooking/addtablebookingdata.htm",
					type : 'POST',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(addBookingDetails),
					success : function(response, JSON_UNESCAPED_UNICODE) {

						 console.log(">>>>>> "+response);
						alert(response);
						if (response == '002') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotAdd;
						} else if(response == '001') {
							document.getElementById('catdataopmassagecont').innerHTML = getLang.tblbookedmsg;
							showalertcatdataopModal();
						
						}else{							
							//document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
							document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
							showalertcatdataopModal();
							closeadvanceTableBookingModal();

							
						}
					}

				});
		
	}
*/



function addadvtblbookindata() {

    //$("#billtbl").hide();
    var tableno = decodeURIComponent(document.getElementById('TableId').value);
    var bookdate = decodeURIComponent(document.getElementById('advbookingdate').value);
    var booktime = decodeURIComponent(document.getElementById('advbookingtime').value);
    var custname = decodeURIComponent(document.getElementById('advbookingcustname').value);
    var custcontact = document.getElementById('advbookingcustcontact').value;
    var noofpersons = document.getElementById('advbookingcustnoofperson').value;
    var custaddress = document.getElementById('advbookingcustaddress').value;
    var custid = document.getElementById('advbookingcustid').value;
    var custlocation = document.getElementById('advbookingcustlocation').value;
    var ordertype = document.getElementById('addOrderType').value;
    var ordertypevalues = ordertype.split("_");
    var ordertypename = $("#addOrderType").find("option:selected").text();
    var custstate = document.getElementById('advbookingcuststate').value;

    if (custid == null) {
        custid = '0';
    }

    if (custid == '') {
        custid = '0';
    }

    if (custaddress == null) {
        custaddress = '';
    }
    if (custlocation == null) {
        custlocation = '';
    }
    if (custaddress == '') {
        custaddress = '';
    }
    if (custlocation == '') {
        custlocation = '';
    }
    if(custstate == null ||  custstate == ''){
    	custstate = '';
    }
   
    
    
    if (ordertypename != "Dine In" && ordertypename != "DINE IN" && ordertypename != "dine in") {
        noofpersons = 1;
    }



    if (tableno == 0 && (ordertypename == "Dine In" || ordertypename == "DINE IN" || ordertypename == "dine in")) {
        document.getElementById('addadvtblbookingalertMsg').innerHTML = getLang.tblselectmsg;

    } else if (booktime == '' || custname == '' || custcontact == '' || noofpersons == '' || ordertype == 0) {
        document.getElementById('addadvtblbookingalertMsg').innerHTML = getLang.fieldmsg;
    } else if ((/[#%?\/\\]/gi).test(custname)) {
        document.getElementById('addadvtblbookingalertMsg').innerHTML = getLang.charNotAlowd;
    } else if (isNaN(custcontact)) {
        document.getElementById('addadvtblbookingalertMsg').innerHTML = getLang.entrValidCntctNo;
    } else {
        custaddress = custaddress == "" ? null : custaddress;
        //custemail = custemail == "" ? null : custemail;

        var addBookingDetails = {};
        var ordertype = {};
        ordertype.id = ordertypevalues[0];

        addBookingDetails.customerName = custname;
        addBookingDetails.customerContact = custcontact;
        addBookingDetails.orderDate = bookdate;
        addBookingDetails.time = booktime;
        addBookingDetails.table_no = tableno;
        addBookingDetails.deliveryAddress = custaddress;
        addBookingDetails.noOfPersons = noofpersons;
        addBookingDetails.storeCustomerId = custid;
        addBookingDetails.location = custlocation;
        addBookingDetails.ordertype = ordertype;
        addBookingDetails.state = custstate;

        $.ajax({
            url: BASE_URL + "/advancebooking/addtablebookingdata.htm",
            type: 'POST',
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(addBookingDetails),
            success: function(response, JSON_UNESCAPED_UNICODE) {

               // console.log(">>>>>> " + response);

                if (response == '002') {
                    document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotAdd;
                    showalertcatdataopModal();
                } else if (response == '001') {
                    document.getElementById('catdataopmassagecont').innerHTML = getLang.tblbookedmsg;
                    showalertcatdataopModal();

                } else {
                    //document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
                    document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucAdd;
                    showalertcatdataopModal();
                    closeadvanceTableBookingModal();


                }
            }

        });

    }
}

/*function editadvtblbookindata() {
    var bookingid = document.getElementById('editadvbookingid').value;
    var tableno = decodeURIComponent(document.getElementById('editTableId').value);
    var custid = decodeURIComponent(document.getElementById('editadvbookingcustid').value);
    var custname = decodeURIComponent(document.getElementById('editadvbookingcustname').value);
    var custcontact = decodeURIComponent(document.getElementById('editadvbookingcustcontact').value);
    var custaddress = decodeURIComponent(document.getElementById('editadvbookingcustaddress').value);
    var orderdate = decodeURIComponent(document.getElementById('editadvbookingdate').value);
    var ordertime = decodeURIComponent(document.getElementById('editadvbookingtime').value);
    var noofperson = document.getElementById('editadvbookingcustnoofperson').value;
    var custlocation = document.getElementById('editadvbookingcustlocation').value;

    if (custaddress == null) {
        custaddress = '';
    }
    if (custlocation == null) {
        custlocation = '';
    }
    if (custaddress == '') {
        custaddress = '';
    }
    if (custlocation == '') {
        custlocation = '';
    }

    if (custname == '' || custcontact == '' || orderdate == '' || ordertime == '' || noofperson == '') {
        document.getElementById('editadvtblbookingalertMsg').innerHTML = getLang.fieldmsg;
    } else if ((/[#%?\/\\]/gi).test(custname)) {
        document.getElementById('editadvtblbookingalertMsg').innerHTML = getLang.plsEnterCorctCtNo;
    } else if (isNaN(custcontact)) {
        document.getElementById('editadvtblbookingalertMsg').innerHTML = getLang.charNotAlowd;
    } else {
        // custaddress = custaddress == "" ? null : custaddress;

        var editAdvOrder = {};
        editAdvOrder.id = bookingid;
        editAdvOrder.storeCustomerId = custid;
        editAdvOrder.customerName = custname;
        editAdvOrder.customerContact = custcontact;
        editAdvOrder.orderDate = orderdate;
        editAdvOrder.time = ordertime;
        editAdvOrder.table_no = tableno;
        editAdvOrder.deliveryAddress = custaddress;
        editAdvOrder.noOfPersons = noofperson;
        editAdvOrder.location = custlocation;

        $.ajax({
            url: BASE_URL + "/advancebooking/edittablebookingdata.htm",
            type: 'POST',
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(editAdvOrder),
            success: function(response, JSON_UNESCAPED_UNICODE) {

                console.log(">>>>>> " + response);
                if (response == bookingid) {
                    document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucUpdate;
                    showalertcatdataopModal();
                } else if (response == '001') {
                    document.getElementById('catdataopmassagecont').innerHTML = getLang.tblalrdybookedmsg;
                    showalertcatdataopModal();
                } else {
                    document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
                    showalertcatdataopModal();
                }
            }

        })
    }
}
*/

function editadvtblbookindata() {

    //$("#editbilltbl").hide();editadvbookingid
	var orderid=document.getElementById('editadvbookingid').value;
    var tableno = decodeURIComponent(document.getElementById('editTableId').value);
    var bookdate = decodeURIComponent(document.getElementById('editadvbookingdate').value);
    var booktime = decodeURIComponent(document.getElementById('editadvbookingtime').value);
    var custname = decodeURIComponent(document.getElementById('editadvbookingcustname').value);
    var custcontact = document.getElementById('editadvbookingcustcontact').value;
    var noofpersons = document.getElementById('editadvbookingcustnoofperson').value;
    var custaddress = document.getElementById('editadvbookingcustaddress').value;
    var custid = document.getElementById('editadvbookingcustid').value;
    var custlocation = document.getElementById('editadvbookingcustlocation').value;
    var ordertype = document.getElementById('editOrderType').value;
    var ordertypevalues = ordertype.split("_");
    var ordertypename = $("#editOrderType").find("option:selected").text();
    var cusstate = document.getElementById('editadvbookingcuststate').value;
   
    if (custid == null) {
        custid = '0';
    }

    if (custid == '') {
        custid = '0';
    }

   if (custaddress == null || custaddress == 'undefined') {
        custaddress = '';
    }
    if (custlocation == null) {
        custlocation = '';
    }
    if (custaddress == '') {
        custaddress = '';
    }
    if (custlocation == '') {
        custlocation = '';
    }
    
    if(cusstate == '' || cusstate == null){cusstate='';}
  
   /* if (ordertypename != "Dine In" || ordertypename != "DINE IN" || ordertypename != "dine in") {
        noofpersons = 1;
    }
   */


    if (tableno == 0 && (ordertypename == "Dine In" || ordertypename == "DINE IN" || ordertypename == "dine in")) {
        document.getElementById('editadvtblbookingalertMsg').innerHTML = getLang.tblselectmsg;

    } else if (booktime == '' || custname == '' || custcontact == '' || noofpersons == '') {
        document.getElementById('editadvtblbookingalertMsg').innerHTML = getLang.fieldmsg;
    } else if ((/[#%?\/\\]/gi).test(custname)) {
        document.getElementById('editadvtblbookingalertMsg').innerHTML = getLang.charNotAlowd;
    } else if (isNaN(custcontact)) {
        document.getElementById('editadvtblbookingalertMsg').innerHTML = getLang.entrValidCntctNo;
    } else {
         custaddress = custaddress == '' ? null : custaddress;
        //custemail = custemail == "" ? null : custemail;

        var addBookingDetails = {};
        var addBookingDetails = {};
        var ordertype = {};
        ordertype.id = ordertypevalues[0];
        addBookingDetails.id=orderid;
        addBookingDetails.customerName = custname;
        addBookingDetails.customerContact = custcontact;
        addBookingDetails.orderDate = bookdate;
        addBookingDetails.time = booktime;
        addBookingDetails.table_no = tableno;
        addBookingDetails.deliveryAddress = custaddress;
        addBookingDetails.noOfPersons = noofpersons;
        addBookingDetails.storeCustomerId = custid;
        addBookingDetails.location = custlocation;
        addBookingDetails.ordertype = ordertype;
        addBookingDetails.state=cusstate;
        $.ajax({
            url: BASE_URL + "/advancebooking/edittablebookingdata.htm",
            type: 'POST',
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(addBookingDetails),
            success: function(response, JSON_UNESCAPED_UNICODE) {

               // console.log(">>>>>> " + response);

                if (response == '002') {
                    document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucNotUpdate;
					 showalertcatdataopModal();
                } else if (response == '001') {
                    document.getElementById('catdataopmassagecont').innerHTML = getLang.tblalrdybookedmsg;
                    showalertcatdataopModal();

                } else {
                    document.getElementById('catdataopmassagecont').innerHTML = getLang.datasucUpdate
                    showalertcatdataopModal();
                    //closeadvanceTableBookingModal();


                }
            }

        });

    }
}














/*function showdetailsofadvtablebooking(from,to){
	//alert("from:"+from+"to:"+to);
	var ajaxCallObject = new CustomBrowserXMLObject();
	//ajaxCallObject.callAjax(BASE_URL + "/advancebooking/listfrom/"+from +"/to/"+to+".htm", function(response) {
	ajaxCallObject.callAjax(BASE_URL + "/advancebooking/listfrom/"+from+"/"+to+".htm", function(response) {
	   try{
			var responseObj=[];
			console.log(response);
			responseObj=JSON.parse(response);
        	}catch(e)
		{
			alert(e);
		}
		}, null);
}*/




function showadvtblbookingcancellationModal(bookingid) {
    //alert("id:"+bookingid);
    document.getElementById('bookingOrderId').value = bookingid;
    $('#prebookcancellationmodal').modal('show');

}

function preOrderCancellation() {
    orderNo = document.getElementById('bookingOrderId').value;
    //alert("orderNo:"+orderNo);
    var changeNote = $('#changenoteContId').val();
    if ($.trim(changeNote) == "" && (printReason == 'Y' || printReason == 'y')) {
        document.getElementById('advtblbookingcancellationalertMsg').innerHTML = getLang.reasonmsg;

    } else {
        //location.href=BASE_URL+'/unpaidorder/cancelunpaidorder.htm?orderId='+orderNo;
        var cancelOrdered = {};
        cancelOrdered.id = orderNo;
        cancelOrdered.cancelRemark = changeNote;
        $.ajax({
            url: BASE_URL + "/unpaidorder/cancelunpaidorderPost.htm",
            type: 'POST',
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(cancelOrdered),
            success: function(response,
                JSON_UNESCAPED_UNICODE) {
               // console.log(">>>>>> " + response);

                if (response == 'success') {
                    $("#prebookcancellationmodal").modal('hide');
                    $("#successCancelModal").modal('show');
                } else {
                    $("#prebookcancellationmodal").modal('hide');
                    $("#failureModal").modal('show');
                }
            }

        });
    }


}



//////////////////////for event calendar////////////////////

function prepareAllPreBookEventsDataHtml(data) {
  
    if (data.length == 0) {

    } else {
        for (var i = 0; i < data.length; i++) {
             var s=data[i].orderNo+" "+data[i].customerName;
             var date=new Date(data[i].orderDate);
             var odate = date.getDate();
             var oyear = date.getFullYear();
             var omonth = date.getMonth()+1;
              if(omonth<10){
             	 omonth='0'+omonth;
              }
              if(odate<10){
            	  odate='0'+odate;
               }
             var ordaerdate=oyear+'-'+omonth+'-'+odate;
             
             
             
            var event = {};
            event.title = s;
            /*event.start = data[i].orderDate;*/
            event.start = ordaerdate;
            event.data = data[i];
            eventsdata.push(event);

        }

        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,basicWeek,basicDay'            
            },
            aspectRatio: 2,
            defaultDate: formatDate(),
            navLinks: false, // can click day/week names to navigate views
            editable: false, // can edit by drag and drop the events from one date to another date
            eventLimit: true, // allow "more" link when too many events
            displayEventTime : false,
            events: eventsdata,
            eventClick: function(calEvent, jsEvent, view) {
              // console.log(JSON.stringify(calEvent.data));
               prepareOrderDetailHTMLModal(calEvent.data);
            }

        });

    }

    $('#advtblbooklistsearchModal').modal('show');


}



function prepareOrderDetailHTMLModal(data){
	/*console.log("fffff"+JSON.stringify(data));*/
    var jsonObj=data;
	var orderNo = jsonObj.id;
    var storeBasedOrderNo = jsonObj.orderNo;
	var tabNo = jsonObj.table_no;
	var customerName = jsonObj.customers.name;
	var orderCustomerName = jsonObj.customerName;
	var customerAddr = "";
	var orderCustomerAddr = jsonObj.deliveryAddress;
	var customerPhNo = "";
	var customerEmail = "";
	var state="";
	//var orderDateWithTime = jsonObj.orderDate;
	var orderTime = jsonObj.time;
    var cuslocation = "";
    var cusstreet = "";
    var cushouseno = "";
    var delivaryboy = "";
	var ordercustomerphone= jsonObj.customerContact;
	
	/* ***** Bill Amount Details ***** */
	var storeId = jsonObj.storeId;
	var billAmt = jsonObj.orderBill.billAmount;
	var serviceTaxAmt = "";
	var vatAmt = "";
	var grossAmt = jsonObj.orderBill.grossAmt;
	var totalDiscount = "";
	var customerDiscount = "";
	var roundOffAmt = jsonObj.orderBill.roundOffAmt;
	var discPercentage = "";
	var serviceChargeAmt = jsonObj.orderBill.serviceChargeAmt;
	var subToatlAmt = "";
	var serviceChargeDisc = "";
	var orderTypeOfOrder = jsonObj.ordertype.orderTypeName;
	var bookingDate=jsonObj.orderTime;
	var afterdiscount = ""; 
    
	var date=new Date(jsonObj.orderDate);
    var odate = date.getDate();
    var oyear = date.getFullYear();
    var omonth = date.getMonth()+1;
     if(omonth<10){
    	 omonth='0'+omonth;
     }
     if(odate<10){
      	  odate='0'+odate;
         }
     var orderDateWithTime=oyear+'-'+omonth+'-'+odate;
	
	
	
	    $("#itemDetailsPrint80").text("");
		$('#cashOrdervalue80').text(storeBasedOrderNo);
		$('#cashOrderdate80').text(orderDateWithTime);
		$('#cashBookingdate80').text(bookingDate);
		
		if(tabNo!='0'){
			$('#cashtableNoValue80').text('Table No:'+tabNo);
		}
		else{
			$('#cashtableNoValue80').text(orderTypeOfOrder);
		}
		$('#cashOrdertime80').text(orderTime);
	if(jsonObj.orderitem.length>0){
		for ( var k = 0; k < jsonObj.orderitem.length; k++) {
			var item1 = jsonObj.orderitem[k];
            var itemName = item1.item.name;
			var itemQty = item1.quantityOfItem;
			var itemRate = item1.rate;
			var itemTotalPrice = item1.totalPriceByItem;
            var createdrowline = "";
			/*var startTrline = "<tr style='padding: 2px;'>";
			var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>" + itemName + "</td>";
			var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>" + itemQty + "</td>";
			var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
			var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemTotalPrice).toFixed(2) + "</td>";
			var endTrline = "</tr>";*/
            var startTrline = "<tr style='background:#2E2E2E; padding:2px;'>";
			var firstTdline = "<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>" + itemName + "</td>";
			var secondTdline = "<td style='padding:1px;text-align:center;'>" + itemQty + "</td>";
			var thirdTdline = "<td valign='middle' align='center' style='padding:3px;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
			var fourthTdline = "<td style='padding:1px;text-align: center;'>" + parseFloat(itemTotalPrice).toFixed(2) + "</td>";
			var endTrline = "</tr>";

			createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;

			$("#itemDetailsPrint80").append(createdrowline);
			$("#ordrDetailDiv").show();

		  }
		}else{
			$("#ordrDetailDiv").hide();
		}
        //$('#cashtotalamt80').text(parseFloat(subToatlAmt).toFixed(2));
        $("#cashgrossAmount80").text(parseFloat(grossAmt).toFixed(2));
		var paidamt = jsonObj.payments[0].paidAmount;	
		
		var amttopay=parseFloat(grossAmt).toFixed(2);
		if(paidamt>0 && paidamt!=""){
		    amttopay=grossAmt-paidamt;
		}
		else{
			paidamt=0.0;	
		}
		$("#cashamoutPaid80").text(parseFloat(paidamt).toFixed(2));
		$("#cashamoutToPay80").text(parseFloat(amttopay).toFixed(2));
	
	       if(orderCustomerName != '' && orderCustomerName != null  && orderCustomerName.length >0){
	    	    document.getElementById("custrshow").style.display = "block";
	    	    document.getElementById('cusname80').innerHTML =orderCustomerName;				
				document.getElementById("cusnametr80").style.display = "block";
				
			}
			
			
			if(ordercustomerphone != '' && ordercustomerphone != null && ordercustomerphone.length >0){
				document.getElementById("custrshow").style.display = "block";
				document.getElementById('cusphno80').innerHTML =ordercustomerphone;
				document.getElementById("cusphnotr80").style.display = "block";
				
			}
		
     

	  $('#advtblbooklistsearchModal').modal('hide');
	  $('#orderDetailDataModal').modal('show');
}




function closeOrderDetailsModal(){
	 $('#orderDetailDataModal').modal('hide');
	 $('#advtblbooklistsearchModal').modal('show');
	}


function formatDate() {
    var d = new Date(),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}




///// Add items in advance booking////////////////



/*var orderitemdata = null;*/
function additemtoOrder(itId, itName, itPrice, disc, vat, serviceTax,
    promoFlag, promoValue, isKotPrint, operationid) {
    var menuitempost = {};
    menuitempost.id = itId;
    menuitempost.name = itName;
    menuitempost.price = itPrice;
    menuitempost.vat = vat;
    menuitempost.serviceTax = serviceTax;
    menuitempost.promotionFlag = promoFlag;
    menuitempost.promotionValue = promoValue;
    menuitempost.isKotPrint = isKotPrint;

    $
        .ajax({
            url: BASE_URL + "/advancebooking/addadvorderitempost.htm",
            type: 'POST',
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(menuitempost),
            success: function(response, JSON_UNESCAPED_UNICODE) {
                //console.log(response);
                // called when
                // successful
                try {
                    var responseObj = JSON.parse(response);
                    if (operationid == 1) {
                        prepareOrderHtml(responseObj);
                    } else {
                        prepareOrderEditHtml(responseObj);
                    }

                    /*var qty = null;
                    for (var i = 0; i < responseObj.length; i++) {
                    	var orderitem = responseObj[i];
                    	if (itId == orderitem.itemId) {
                    		qty = orderitem.quantityOfItem;
                    	}
                    }*/
                    // for vfd
                    /*if (vfdPort.length > 3) {
                    	if (itName.length > 12)
                    		itName = itName.substring(0, 12);
                    	var tot = document.getElementById('amttopaycontId').innerHTML;
                    	var ajaxCallObject = new CustomBrowserXMLObject();
                    	ajaxCallObject.callAjax(BASE_URL
                    			+ "/order/showvfd/" + qty + "x" + itName
                    			+ ":" + parseFloat(itPrice).toFixed(2)
                    			+ "/" + "TOT IN RM : "
                    			+ parseFloat(tot).toFixed(2) + ".htm",
                    			function() {
                    			}, null);
                    }*/
                } catch (e) {
                    alert(e);
                }

            },
            error: function(e) {
                // called when there is
                // an error
                // console.log(e.message);
            }
        });
}


function increaseItemQuantity(itemId, itemName, itemRate,operationid) {
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/advancebooking/increaseitemqty/" + itemId +
        ".htm",
        function(response) {
            try {
                var responseObj = JSON.parse(response);
                if(operationid==1){
                	prepareOrderHtml(responseObj);
                }
                else{
                	 prepareOrderEditHtml(responseObj);
                }
                
               
                /*var qty = null;
                for (var i = 0; i < responseObj.length; i++) {
                	var orderitem = responseObj[i];
                	if (itemId == orderitem.itemId) {
                		qty = orderitem.quantityOfItem;
                	}
                }*/
                // for vfd
                /*if (vfdPort.length > 3) {
                	if (itemName.length > 12)
                		itemName = itemName.substring(0, 12);
                	var tot = document.getElementById('amttopaycontId').innerHTML;
                	var ajaxCallObject = new CustomBrowserXMLObject();
                	ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" + qty
                			+ "x" + itemName + ":"
                			+ parseFloat(itemRate).toFixed(2) + "/"
                			+ "TOT IN RM : " + parseFloat(tot).toFixed(2) + ".htm",
                			function() {
                			}, null);
                }*/
            } catch (e) {
                alert(e);
            }
        }, null);
}

function decreaseItemQuantity(itemId, itemName, itemRate,operationid) {
    // alert(itemId);
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/advancebooking/decreaseitemqty/" + itemId +
        ".htm",
        function(response) {
            try {
                var responseObj = JSON.parse(response);
                if(operationid==1){
                	prepareOrderHtml(responseObj);
                }
                else{
                	 prepareOrderEditHtml(responseObj);
                }

                // for vfd
                /*if (vfdPort.length > 3) {
                	if (itemName.length > 13)
                		itemName = itemName.substring(0, 13);
                	var tot = document.getElementById('amttopaycontId').innerHTML;
                	var ajaxCallObject = new CustomBrowserXMLObject();
                	ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/" + itemName
                			+ ":-" + parseFloat(itemRate).toFixed(2) + "/"
                			+ "TOT IN RM : " + parseFloat(tot).toFixed(2) + ".htm",
                			function() {
                			}, null);
                }*/
            } catch (e) {
                alert(e);
            }
        }, null);
}


function enterManualQuantity(qty, itemId,operationid) {
    if (parseInt(qty) > 0) {
        calculateBill(qty, itemId,operationid);
        // document.getElementById('qty'+itemId).focus();
    } else if (qty == '') {
        showalerteditOrderQuantityModal(itemId);
        document.getElementById('qty' + itemId).focus();
        calculateBill(1, itemId,operationid);
    } else if (parseInt(qty) == 0) {
        showalerteditOrderQuantityModal(itemId);
        document.getElementById('qty' + itemId).value = 1;
        calculateBill(1, itemId,operationid);
    } else {
        showalerteditOrderQuantityModal(itemId);
        document.getElementById('qty' + itemId).value = 1;
        calculateBill(1, itemId,operationid);
    }
}


function calculateBill(qty, itemId,operationid) {
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/advancebooking/manualitemqty/" + qty +
        "/" + itemId + ".htm",
        function(response) {
            try {
                var responseObj = JSON.parse(response);
                if(operationid==1){
                	prepareOrderHtml(responseObj);
                }
                else{
                	 prepareOrderEditHtml(responseObj);
                }
                /*document.getElementById('qty' + itemId).focus();
                var len = document.getElementById('qty' + itemId).value.length;
                document.getElementById('qty' + itemId).setSelectionRange(len,
                		len);*/
            } catch (e) {
                alert(e);
            }
        }, null);
}

function setOrderItemManualQty() {
    var itId = document.getElementById('hiddmanualeditItemId').value;
    document.getElementById('qty' + itId).value = 1;
}

var selectedRows = [];

function checkRow(trId, chk) {
    if (chk.checked) {
        document.getElementById('row_' + trId).style.background = '#373737';
        selectedRows.push(trId);
    } else {
        document.getElementById('row_' + trId).style.background = '#222222';
        selectedRows.splice(selectedRows.indexOf(trId), 1);
    }
}



function deleteRows(operationid) {
    if (selectedRows.length > 0) {
    	document.getElementById('hidddeleteoperationid').value=operationid;
    	 showconfirmdeleteOrderItemModal();

    } else {
        showselectitemalertModal();
    }
}

function deleteorderItemRow() {
	var operationid=document.getElementById('hidddeleteoperationid').value;
    var noofremoveItem = selectedRows.length;
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/advancebooking/deleteitms/" + selectedRows +
        ".htm",
        function(response) {
            try {
                var responseObj = JSON.parse(response);
                if(operationid==1){
                	prepareOrderHtml(responseObj);
                }
                else{
                	 prepareOrderEditHtml(responseObj);
                }
                /*if (vfdPort.length > 3) {
                	var tot = document.getElementById('amttopaycontId').innerHTML;
                	var ajaxCallObject = new CustomBrowserXMLObject();
                	ajaxCallObject.callAjax(BASE_URL + "/order/showvfd/"
                			+ noofremoveItem + " ITEM(S) REMOVED" + "/"
                			+ "TOT IN RM : " + parseFloat(tot).toFixed(2) + ".htm",
                			function() {
                			}, null);
                }*/
            } catch (e) {
                alert(e);
            }
        }, null);
    selectedRows = [];
}

var total = 0.0;
var totDisc = 0.0;
var forspNoteData = [];
var orderitemdata = null;

function prepareOrderHtml(responseData) {
    forspNoteData = [];
    var itemObj = {};
    orderitemdata = responseData;
    var staticVat = 14.5;
    var staticST = 5.6;

    var orderVat = 0.0;
    var orderSTax = 0.0;

    var subtotal = 0.0;
    var disc = 0.0;
    var staxAmt = 0.0;
    var vatAmt = 0.0;
    var grandTotal = 0.0;
    var netPrice = 0.0;
    var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
    var storedoubleroundoffflag = document.getElementById('hidstoredoubleroundoffFlag').value;
    var servicetaxText = document.getElementById('hidserviceTaxTextVal').value;
    var vattaxText = document.getElementById('hidvatTaxTextVal').value;
    var paidAmtVal = document.getElementById('hidpaidAmtVal').value;
    var custdiscAmtVal = document.getElementById('hidcustDiscVal').value;
    /*var orderitemcontainerId = document.getElementById('orderitemContId');*/
    var orderitemcontainerId = document.getElementById('addadvtblbookingitems');

    var subtotalcontainerId = document.getElementById('subtotalcontId');
    var amttopaycontainerId = document.getElementById('amttopaycontId');
    var grandtotalcontainerId = document.getElementById('grandtotalcontId');

    /*var tableno = document.getElementById('tablenoCont').innerHTML;*/
    var tableno = document.getElementById('TableId').value;
    var parcelST = document.getElementById('hidparcelST').value;
    var parcelVat = document.getElementById('hidparcelVat').value;
    /*var scharge = $('#serviceChargeRate').val();*/
    //var scharge = $('#servicechargerate').val();
    var scharge = ordertypebasedscharge; // set this variable in jsp page
    var schargetext = $('#hidserviceChargeTextNew').val();
    //var directordertaking = $("#directordertakingContId").val();
    var createdrowline = "";
    var generatedHtml = "";
    var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;font-size:50%'><thead><th><a href='javascript:deleteRows(1)'><img border='0' alt='' src='" + BASE_URL +
        "/assets/images/base/d/Recycle.png' height='18' width='18'></a></th><th>" +
        getLang.name +
        "</th><th style='text-align:center;'>" +
        getLang.qty +
        "</th><th>" +
        getLang.rate +
        "</th><th>" +
        getLang.tot + "</th>";
    var headerline = "<tbody style='color:#fff; padding:1px;' >";
    var footerline = "</tbody></table>";
    for (var i = 0; i < responseData.length; i++) {

        var orderitem = responseData[i];
        ordItemVal = responseData[i];
        var disc1 = 0.0;
        var begintrline = "";
        var firsttdline = "";
        var secondtdline = "";
        var thirdtdline = "";
        var kotflagline = "";
        if (orderitem.isinOrder == 'Y') {
            var trbgColor = "#2E2E2E";
            if (orderitem.itemName.indexOf("CONTAINER") == 0) {
                trbgColor = "#1c91bc";
            }
            begintrline = "<tr style='background:" + trbgColor +
                "; padding:2px;'>";
            firsttdline = "<td style='padding:1px;text-align:center;'>" +
                (i + 1) + "</td>";

            secondtdline = "<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>" +
                orderitem.itemName + "</td>";

            thirdtdline = "<td valign='middle' align='center' style='padding:3px;'> " +
                orderitem.quantityOfItem +
                "</td>";

            kotflagline = "<td valign='middle' align='center' style='padding:3px;display:none;'>" +
                orderitem.item.isKotPrint +
                "</td>";


        } else {
            // forspNoteData=[];
            forspNoteData.push(orderitem);
            var trbgColor = "#222222";
            if (orderitem.itemName.indexOf("CONTAINER") == 0) {
                trbgColor = "#1c91bc";
            }
            begintrline = "<tr id='row_" + orderitem.itemId +
                "' style='background:" + trbgColor + "; padding:2px;'>";
            firsttdline = "<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRow(" +
                orderitem.itemId +
                ",this)' id='chk_" +
                orderitem.itemId +
                "'></td>";
            secondtdline = "<td width='50%'  onclick='javascript:selectRow(" +
                orderitem.itemId +
                ")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>" +
                orderitem.itemName + "</td>";
            thirdtdline = "<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:decreaseItemQuantity(" +
                orderitem.itemId +
                ",&quot;" +
                orderitem.itemName +
                "&quot;," +
                orderitem.rate +","+
                1+")'><img border='0' alt='' src='" +
                BASE_URL +
                "/assets/images/base/d/d_delete.png' height='22' width='18'></a> " +
                "<input type='text' onClick='this.select();' id='qty" +
                orderitem.itemId +
                "' size='1' onkeyup='javascript:enterManualQuantity(this.value," +
                orderitem.itemId +","+1+
                ")' value='" +
                orderitem.quantityOfItem +
                "' style='text-align:center;color:#fff; background-color:#333;height:22px;width:30px;' class='ordermanualQty'>" +
                " <a href='javascript:increaseItemQuantity(" +
                orderitem.itemId +
                ",&quot;" +
                orderitem.itemName +
                "&quot;," +
                orderitem.rate +
                ","+
                1+")'><img border='0'  alt='' src='" +
                BASE_URL +
                "/assets/images/base/d/d_add.png' height='22' width='18'></a></td>";

            kotflagline = "<td valign='middle' align='center' style='padding:3px;display:none;'>" +
                orderitem.item.isKotPrint +
                "</td>";


        }
        if (orderitem.item.promotionFlag == 'Y') {
            disc1 = (orderitem.rate * orderitem.quantityOfItem) *
                orderitem.discount / 100;
        }



        disc += disc1;
        subtotal += (orderitem.rate * orderitem.quantityOfItem) - disc1;
        var fourthtdline = "<td  style='padding:1px;text-align: center;'>" +
            parseFloat(orderitem.rate * orderitem.quantityOfItem - disc1)
            .toFixed(2) + "</td>";
        var fifthtdline = "<td style='padding:1px;text-align: center;'>" +
            parseFloat(disc1).toFixed(2) + "</td>";
        var sixthtdline = "<td style='padding:1px;text-align: center;'>" +
            parseFloat(orderitem.rate).toFixed(2) + "</td>";
        var seventhhtdline = "";
        var eighthtdline = "";
        if (vattaxText.length != 0) {
            seventhhtdline = "<td style='padding:1px;text-align: center;'>" +
                parseFloat(orderitem.vat).toFixed(2) + "</td>";
        }
        if (servicetaxText.length != 0) {
            eighthtdline = "<td style='padding:1px;text-align: center;'>" +
                parseFloat(orderitem.serviceTax).toFixed(2) + "</td>";
        }

        var endtrline = "</tr>";

        createdrowline += begintrline + firsttdline + secondtdline +
            thirdtdline + sixthtdline + fourthtdline + kotflagline + endtrline;

    }

    var subtotalWithOutTax = 0;
    var subtotalWithTax = 0;

    for (var j = 0; j < responseData.length; j++) {

        var orderitemDesc = responseData[j];

        var discRate = 0;
        if (orderitemDesc.item.promotionFlag == 'Y') {
            disc1 = (orderitemDesc.rate * orderitemDesc.quantityOfItem) *
                orderitemDesc.discount / 100;
        }
        if (orderitemDesc.serviceTax == '0' && orderitemDesc.vat == '0')
            subtotalWithOutTax += (orderitemDesc.rate * orderitemDesc.quantityOfItem) - discRate;
        else {
            orderVat = orderitemDesc.vat;
            orderSTax = orderitemDesc.serviceTax;
            subtotalWithTax += (orderitemDesc.rate * orderitemDesc.quantityOfItem) - discRate;
            
         // new added strt 28.3.2019 for item wise tax calculation
		    staxAmt += (((orderitemDesc.rate * orderitemDesc.quantityOfItem)-discRate) * orderSTax) / 100;
		    vatAmt +=  (((orderitemDesc.rate * orderitemDesc.quantityOfItem)-discRate) * orderVat) / 100;
		    //new added end
        }

    }

    if (subtotalWithOutTax > custdiscAmtVal) {
        subtotalWithTax = subtotal - subtotalWithOutTax;
    } else {
        subtotalWithTax = subtotal - custdiscAmtVal;
    }

    if (storeID == '35' && tableno != '0' && orderSTax == '0') {
        staxAmt = (subtotalWithTax * staticST / 100);
    } else {
        //staxAmt = (subtotalWithTax * orderSTax / 100);
    }
    if (storeID == '35' && tableno != '0' && orderVat == '0') {
        vatAmt = (subtotalWithTax * staticVat / 100);
    } else {
        //vatAmt = (subtotalWithTax * orderVat / 100);
    }

   // console.log(staxAmt + " " + vatAmt);
    itemObjValue.push(ordItemVal.itemId);
    itemUnique = $.unique(itemObjValue);

    generatedHtml = tableline + headerline + createdrowline + footerline;
    if (tableno == '0' && parcelST == 'N') {
        staxAmt = 0.0;
    }
    if (tableno == '0' && parcelVat == 'N') {
        vatAmt = 0.0;
    }

    if (schargetext == 'Y' && scharge != 0.00) {
        staxAmt = staxAmt + staxAmt * scharge / 100;
        vatAmt = vatAmt + vatAmt * scharge / 100;
        scharge = subtotal * scharge / 100;

    }

    grandTotal = (subtotal + parseFloat(scharge) + staxAmt + vatAmt);
    netPrice = grandTotal - paidAmtVal - custdiscAmtVal;
    $('#addadvtblbookingitems').css("height", '100px');
    orderitemcontainerId.innerHTML = generatedHtml;
    if (storeroundoffflag == 'Y') {
        grandTotal = Math.round(grandTotal);
        netPrice = Math.round(netPrice);
    }
    if (storedoubleroundoffflag == 'Y') {
        netPrice = round(netPrice, 1);
    }

    subtotalcontainerId.innerHTML = parseFloat(subtotal).toFixed(2);
    if (schargetext == 'Y') {
        $("#schrgId").html(parseFloat(scharge).toFixed(2));
    }
    if (servicetaxText.length != 0) {
        document.getElementById('servicetaxcontId').innerHTML = parseFloat(staxAmt).toFixed(2);
    }
    if (vattaxText.length != 0) {
        document.getElementById('vatcontId').innerHTML = parseFloat(vatAmt).toFixed(2);
    }

    amttopaycontainerId.innerHTML = parseFloat(netPrice).toFixed(2);
    grandtotalcontainerId.innerHTML = parseFloat(grandTotal).toFixed(2);
    total = grandTotal;
    totDisc = disc;
    $("#billtbl").show();
    $("#itemCodeSearch").val("");


}




function prepareOrderEditHtml(responseData) {
    forspNoteData = [];
    var itemObj = {};
    //alert(responseData.length);
  // console.log("uuu"+JSON.stringify(responseData));
    orderitemdata = responseData;
    var staticVat = 14.5;
    var staticST = 5.6;

    var orderVat = 0.0;
    var orderSTax = 0.0;

    var subtotal = 0.0;
    var disc = 0.0;
    var staxAmt = 0.0;
    var vatAmt = 0.0;
    var grandTotal = 0.0;
    var netPrice = 0.0;
    var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
    var storedoubleroundoffflag = document.getElementById('hidstoredoubleroundoffFlag').value;
    var servicetaxText = document.getElementById('hidserviceTaxTextVal').value;
    var vattaxText = document.getElementById('hidvatTaxTextVal').value;
    var paidAmtVal = document.getElementById('hidpaidAmtVal').value;
    var custdiscAmtVal = document.getElementById('hidcustDiscVal').value;
    /*var orderitemcontainerId = document.getElementById('orderitemContId');*/
    var orderitemcontainerId = document.getElementById('editadvtblbookingitems');

    var subtotalcontainerId = document.getElementById('subtotalcontId1');
    var amttopaycontainerId = document.getElementById('amttopaycontId1');
    var grandtotalcontainerId = document.getElementById('grandtotalcontId1');

    /*var tableno = document.getElementById('tablenoCont').innerHTML;*/
    var tableno = document.getElementById('editTableId').value;
    var parcelST = document.getElementById('hidparcelST').value;
    var parcelVat = document.getElementById('hidparcelVat').value;
    /*var scharge = $('#serviceChargeRate').val();*/
    //var scharge = $('#servicechargerate').val();
    var scharge = ordertypebasedscharge; // set this variable in jsp page
    var schargetext = $('#hidserviceChargeTextNew').val();
    //var directordertaking = $("#directordertakingContId").val();
    var createdrowline = "";
    var generatedHtml = "";
    var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;font-size:50%'><thead><th><a href='javascript:deleteRows(2)'><img border='0' alt='' src='" + BASE_URL +
        "/assets/images/base/d/Recycle.png' height='18' width='18'></a></th><th>" +
        getLang.name +
        "</th><th style='text-align:center;'>" +
        getLang.qty +
        "</th><th>" +
        getLang.rate +
        "</th><th>" +
        getLang.tot + "</th>";
    var headerline = "<tbody style='color:#fff; padding:1px;' >";
    var footerline = "</tbody></table>";
    for (var i = 0; i < responseData.length; i++) {

        var orderitem = responseData[i];
        ordItemVal = responseData[i];
        var disc1 = 0.0;
        var begintrline = "";
        var firsttdline = "";
        var secondtdline = "";
        var thirdtdline = "";
        var kotflagline = "";
        if (orderitem.isinOrder == 'Y') {
            var trbgColor = "#2E2E2E";
            if (orderitem.itemName.indexOf("CONTAINER") == 0) {
                trbgColor = "#1c91bc";
            }
            begintrline = "<tr style='background:" + trbgColor +
                "; padding:2px;'>";
            firsttdline = "<td style='padding:1px;text-align:center;'>" +
                (i + 1) + "</td>";

            secondtdline = "<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>" +
                orderitem.itemName + "</td>";

            thirdtdline = "<td valign='middle' align='center' style='padding:3px;'> " +
                orderitem.quantityOfItem +
                "</td>";

            kotflagline = "<td valign='middle' align='center' style='padding:3px;display:none;'>" +
                orderitem.item.isKotPrint +
                "</td>";


        } else {
            // forspNoteData=[];
            forspNoteData.push(orderitem);
            var trbgColor = "#222222";
            if (orderitem.itemName.indexOf("CONTAINER") == 0) {
                trbgColor = "#1c91bc";
            }
            begintrline = "<tr id='row_" + orderitem.itemId +
                "' style='background:" + trbgColor + "; padding:2px;'>";
            firsttdline = "<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRow(" +
                orderitem.itemId +
                ",this)' id='chk_" +
                orderitem.itemId +
                "'></td>";
            secondtdline = "<td width='50%'  onclick='javascript:selectRow(" +
                orderitem.itemId +
                ")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>" +
                orderitem.itemName + "</td>";
            thirdtdline = "<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:decreaseItemQuantity(" +
                orderitem.itemId +
                ",&quot;" +
                orderitem.itemName +
                "&quot;," +
                orderitem.rate +","+
                2+ ")'><img border='0' alt='' src='" +
                BASE_URL +
                "/assets/images/base/d/d_delete.png' height='22' width='18'></a> " +
                "<input type='text' onClick='this.select();' id='qty" +
                orderitem.itemId +
                "' size='1' onkeyup='javascript:enterManualQuantity(this.value," +
                orderitem.itemId +","+2+
                ")' value='" +
                orderitem.quantityOfItem +
                "' style='text-align:center;color:#fff; background-color:#333;height:22px;width:30px;' class='ordermanualQty'>" +
                " <a href='javascript:increaseItemQuantity(" +
                orderitem.itemId +
                ",&quot;" +
                orderitem.itemName +
                "&quot;," +
                orderitem.rate +
                ","+
                2+")'><img border='0'  alt='' src='" +
                BASE_URL +
                "/assets/images/base/d/d_add.png' height='22' width='18'></a></td>";

            kotflagline = "<td valign='middle' align='center' style='padding:3px;display:none;'>" +
                orderitem.item.isKotPrint +
                "</td>";


        }
        if (orderitem.item.promotionFlag == 'Y') {
            disc1 = (orderitem.rate * orderitem.quantityOfItem) *
                orderitem.discount / 100;
        }



        disc += disc1;
        subtotal += (orderitem.rate * orderitem.quantityOfItem) - disc1;
        var fourthtdline = "<td  style='padding:1px;text-align: center;'>" +
            parseFloat(orderitem.rate * orderitem.quantityOfItem - disc1)
            .toFixed(2) + "</td>";
        var fifthtdline = "<td style='padding:1px;text-align: center;'>" +
            parseFloat(disc1).toFixed(2) + "</td>";
        var sixthtdline = "<td style='padding:1px;text-align: center;'>" +
            parseFloat(orderitem.rate).toFixed(2) + "</td>";
        var seventhhtdline = "";
        var eighthtdline = "";
        if (vattaxText.length != 0) {
            seventhhtdline = "<td style='padding:1px;text-align: center;'>" +
                parseFloat(orderitem.vat).toFixed(2) + "</td>";
        }
        if (servicetaxText.length != 0) {
            eighthtdline = "<td style='padding:1px;text-align: center;'>" +
                parseFloat(orderitem.serviceTax).toFixed(2) + "</td>";
        }

        var endtrline = "</tr>";

        createdrowline += begintrline + firsttdline + secondtdline +
            thirdtdline + sixthtdline + fourthtdline + kotflagline + endtrline;

    }

    var subtotalWithOutTax = 0;
    var subtotalWithTax = 0;

    for (var j = 0; j < responseData.length; j++) {

        var orderitemDesc = responseData[j];

        var discRate = 0;
        if (orderitemDesc.item.promotionFlag == 'Y') {
            disc1 = (orderitemDesc.rate * orderitemDesc.quantityOfItem) *
                orderitemDesc.discount / 100;
        }
        if (orderitemDesc.serviceTax == '0' && orderitemDesc.vat == '0')
            subtotalWithOutTax += (orderitemDesc.rate * orderitemDesc.quantityOfItem) - discRate;
        else {
            orderVat = orderitemDesc.vat;
            orderSTax = orderitemDesc.serviceTax;
            subtotalWithTax += (orderitemDesc.rate * orderitemDesc.quantityOfItem) - discRate;
            
            // new added strt 28.3.2019 for item wise tax calculation
		    staxAmt += (((orderitemDesc.rate * orderitemDesc.quantityOfItem)-discRate) * orderSTax) / 100;
		    vatAmt +=  (((orderitemDesc.rate * orderitemDesc.quantityOfItem)-discRate) * orderVat) / 100;
		    //new added end
        }

    }

    if (subtotalWithOutTax > custdiscAmtVal) {
        subtotalWithTax = subtotal - subtotalWithOutTax;
    } else {
        subtotalWithTax = subtotal - custdiscAmtVal;
    }

    if (storeID == '35' && tableno != '0' && orderSTax == '0') {
        staxAmt = (subtotalWithTax * staticST / 100);
    } else {
        //staxAmt = (subtotalWithTax * orderSTax / 100);
    }
    if (storeID == '35' && tableno != '0' && orderVat == '0') {
        vatAmt = (subtotalWithTax * staticVat / 100);
    } else {
        //vatAmt = (subtotalWithTax * orderVat / 100);
    }

    //console.log(staxAmt + " " + vatAmt);
    itemObjValue.push(ordItemVal.itemId);
    itemUnique = $.unique(itemObjValue);

    generatedHtml = tableline + headerline + createdrowline + footerline;
    if (tableno == '0' && parcelST == 'N') {
        staxAmt = 0.0;
    }
    if (tableno == '0' && parcelVat == 'N') {
        vatAmt = 0.0;
    }

    if (schargetext == 'Y' && scharge != 0.00) {
        staxAmt = staxAmt + staxAmt * scharge / 100;
        vatAmt = vatAmt + vatAmt * scharge / 100;
        scharge = subtotal * scharge / 100;

    }

    grandTotal = (subtotal + parseFloat(scharge) + staxAmt + vatAmt);
    netPrice = grandTotal - paidAmtVal - custdiscAmtVal;
    $('#editadvtblbookingitems').css("height", '100px');
    orderitemcontainerId.innerHTML = generatedHtml;
    if (storeroundoffflag == 'Y') {
        grandTotal = Math.round(grandTotal);
        netPrice = Math.round(netPrice);
    }
    if (storedoubleroundoffflag == 'Y') {
        netPrice = round(netPrice, 1);
    }

    subtotalcontainerId.innerHTML = parseFloat(subtotal).toFixed(2);
    if (schargetext == 'Y') {
        $("#schrgId1").html(parseFloat(scharge).toFixed(2));
    }
    if (servicetaxText.length != 0) {
        document.getElementById('servicetaxcontId1').innerHTML = parseFloat(staxAmt).toFixed(2);
    }
    if (vattaxText.length != 0) {
        document.getElementById('vatcontId1').innerHTML = parseFloat(vatAmt).toFixed(2);
    }

    amttopaycontainerId.innerHTML = parseFloat(netPrice).toFixed(2);
    grandtotalcontainerId.innerHTML = parseFloat(grandTotal).toFixed(2);
    total = grandTotal;
    totDisc = disc;
    $("#editbilltbl").show();
    $("#edititemCodeSearch").val("");


}




function clearOrderListSession(operationid) {
    //alert("hh");
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/advancebooking/clearordersession.htm", function(response) {
        try {

        } catch (e) {
            alert(e);
        }
    }, null);
    if(operationid==1){
    	$('#advtblbookingAddModal').modal('hide');
    }
    else{
    	$('#advtblbookingEditModal').modal('hide');
    	
    }


}



function showadvtblbookingeditModal(orderno) {
    $("#edititemCodeSearch").removeAttr('disabled');
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/advancebooking/getorder/" + orderno +
        ".htm",
        function(res) {
            //console.log(res);
            
            var resoderdet = JSON.parse(res);
            //alert(resoderdet.id);
            
            var date=new Date(resoderdet.orderDate);
            var date1 = date.getDate();
            var year = date.getFullYear();
            var month = date.getMonth()+1;
             if(month<10){
            	 month='0'+month;
             }
             if(date1<10){
            	 date1='0'+date1;
                 }
            
            var ordaerdate=year+'-'+month+'-'+date1;
            document.getElementById('editadvtblbookingalertMsg').innerHTML = '';
            document.getElementById('editadvbookingid').value = resoderdet.id;
            document.getElementById('editadvbookingdate').value = ordaerdate;
            document.getElementById('editadvbookingtime').value = resoderdet.time;
            document.getElementById('editadvbookingcustid').value = resoderdet.storeCustomerId;
            document.getElementById('editadvbookingcustname').value = resoderdet.customerName;
            document.getElementById('editadvbookingcustcontact').value = resoderdet.customerContact;
            document.getElementById('editadvbookingcustnoofperson').value = resoderdet.noOfPersons;
            
            document.getElementById('editadvbookingcuststate').value = resoderdet.state;
            document.getElementById('editadvbookingcustaddress').value = resoderdet.deliveryAddress;
            document.getElementById('editadvbookingcustlocation').value = resoderdet.location;
            
            document.getElementById('editOrderType').value = resoderdet.ordertype.id + '_' + parseFloat(resoderdet.ordertype.serviceChargeValue).toFixed(1);
     


            var orderTypeNameArray = [];
            var orderTypeIdArray = [];
            var orderTypeServiceChargeArray = [];
            var orderTypeData = "";
            var ordrTypData = "";
            var orderTypeList = JSON.parse(orderTypes);
            for (var i = 0; i < orderTypeList.length; i++) {
                orderTypeNameArray.push(orderTypeList[i].orderTypeName);
                orderTypeIdArray.push(orderTypeList[i].id + '_' + parseFloat(orderTypeList[i].serviceChargeValue).toFixed(1));
                orderTypeServiceChargeArray.push(parseFloat(orderTypeList[i].serviceChargeValue).toFixed(1));
            }

            /*ordrTypData="<option value='"+0+"'> Select Order Type</option>";	*/
            for (var i = 0; i < orderTypeNameArray.length; i++) {
                      if (orderTypeNameArray[i] != resoderdet.ordertype.orderTypeName) {
                          orderTypeData += "<option value='" + orderTypeIdArray[i] + "'>" + orderTypeNameArray[i] + "</option>";
                       }
                      if (orderTypeNameArray[i] == resoderdet.ordertype.orderTypeName) {
		                    orderTypeData += "<option value='" + orderTypeIdArray[i] + "' selected='selected'>" + orderTypeNameArray[i] + "</option>";
		                    ordertypebasedscharge = orderTypeServiceChargeArray[i];
                      }
            }
            var OrderTypeDatafinal = orderTypeData;
            document.getElementById('editOrderType').innerHTML = OrderTypeDatafinal;

            var tableNameArray = [];
            var tableIdArray = [];
            var tableData = "";
            var tblData = "";
            var tablelist = JSON.parse(tables);
            for (var i = 0; i < tablelist.length; i++) {
                tableNameArray.push(tablelist[i].tableNo);
                tableIdArray.push(tablelist[i].tableNo);

            }

            tblData = "<option value='" + 0 + "'> Select Table</option>";
            for (var i = 0; i < tableNameArray.length; i++) {
               // console.log(tableNameArray[i]);
                if (tableNameArray[i] != resoderdet.table_no) {
                    tableData += "<option value='" + tableIdArray[i] + "'>" + tableNameArray[i] + "</option>";

                }
                if (tableNameArray[i] == resoderdet.table_no) {
                    tableData += "<option value='" + tableIdArray[i] + "' selected='selected'>" + tableNameArray[i] + "</option>";

                }
            }
            var tableDatafinal = tblData + tableData;
            document.getElementById('editTableId').innerHTML = tableDatafinal;

            if (resoderdet.table_no != 0) {
                $("#editselecttabletr").css("display", "");
                $("#editadvbookingcustnoofpersontr").css("display", "");
            } else {
                $("#editselecttabletr").css("display", "none");
                $("#editadvbookingcustnoofpersontr").css("display", "none");
            }
            $('#advtblbookingEditModal').modal('show');


            prepareEditOrderHtml(resoderdet);

        }, null);


}




function prepareEditOrderHtml(responseData) { // for show already purchased item in edit order
    //console.log(responseData);
    forspNoteData = [];
    var itemObj = {};
    orderitemdata = responseData.orderitem;
    var staticVat = 14.5;
    var staticST = 5.6;

    var orderVat = 0.0;
    var orderSTax = 0.0;

    var subtotal = 0.0;
    var disc = 0.0;
    var staxAmt = 0.0;
    var vatAmt = 0.0;
    var grandTotal = 0.0;
    var netPrice = 0.0;
    var storeroundoffflag = document.getElementById('hidstoreroundoffFlag').value;
    var storedoubleroundoffflag = document.getElementById('hidstoredoubleroundoffFlag').value;
    var servicetaxText = document.getElementById('hidserviceTaxTextVal').value;
    var vattaxText = document.getElementById('hidvatTaxTextVal').value;
    var paidAmtVal = document.getElementById('hidpaidAmtVal').value;
    var custdiscAmtVal = document.getElementById('hidcustDiscVal').value;
    /*var orderitemcontainerId = document.getElementById('orderitemContId');*/
    var orderitemcontainerId = document.getElementById('editadvtblbookingitems');

    var subtotalcontainerId = document.getElementById('subtotalcontId1');
    var amttopaycontainerId = document.getElementById('amttopaycontId1');
    var grandtotalcontainerId = document.getElementById('grandtotalcontId1');

    /*var tableno = document.getElementById('tablenoCont').innerHTML;*/
    var tableno = document.getElementById('editTableId').value;
    var parcelST = document.getElementById('hidparcelST').value;
    var parcelVat = document.getElementById('hidparcelVat').value;
    /*var scharge = $('#serviceChargeRate').val();*/
    //var scharge = $('#servicechargerate').val();

    var scharge = ordertypebasedscharge; // set this variable in jsp page
    /*var scharge=responseData.ordertype.serviceChargeValue;*/
    var schargevalue = 0.0;
    var schargetext = $('#hidserviceChargeTextNew').val();
    //var directordertaking = $("#directordertakingContId").val();
    var createdrowline = "";
    var generatedHtml = "";
    var tableline = "<table class='table table-striped table-bordered' style='color:#FFF; border:1px solid #222222;font-size:50%'><thead><th><a href='javascript:deleteRows()'><img border='0' alt='' src='" + BASE_URL +
        "/assets/images/base/d/Recycle.png' height='18' width='18'></a></th><th>" +
        getLang.name +
        "</th><th style='text-align:center;'>" +
        getLang.qty +
        "</th><th>" +
        getLang.rate +
        "</th><th>" +
        getLang.tot + "</th>";
    var headerline = "<tbody style='color:#fff; padding:1px;' >";
    var footerline = "</tbody></table>";
    for (var i = 0; i < responseData.orderitem.length; i++) {

        var orderitem = responseData.orderitem[i];
        ordItemVal = responseData.orderitem[i];
        var disc1 = 0.0;
        var begintrline = "";
        var firsttdline = "";
        var secondtdline = "";
        var thirdtdline = "";
        var kotflagline = "";

       /* if (orderitem.isinOrder == 'Y') {*/
            var trbgColor = "#2E2E2E";
            if (orderitem.item.name.indexOf("CONTAINER") == 0) {
                trbgColor = "#1c91bc";
            }
            begintrline = "<tr style='background:" + trbgColor +
                "; padding:2px;'>";
            firsttdline = "<td style='padding:1px;text-align:center;'>" +
                (i + 1) + "</td>";

            secondtdline = "<td width='50%' style='padding:1px;max-width: 250px !important;word-wrap:break-word;'>" +
                orderitem.item.name + "</td>";

            thirdtdline = "<td valign='middle' align='center' style='padding:3px;'> " +
                orderitem.quantityOfItem +
                "</td>";

            kotflagline = "<td valign='middle' align='center' style='padding:3px;display:none;'>" +
                orderitem.item.isKotPrint +
                "</td>";


        /*} else {
            // forspNoteData=[];
            forspNoteData.push(orderitem);
            var trbgColor = "#222222";
            if (orderitem.item.name.indexOf("CONTAINER") == 0) {
                trbgColor = "#1c91bc";
            }
            begintrline = "<tr id='row_" + orderitem.item.id +
                "' style='background:" + trbgColor + "; padding:2px;'>";
            firsttdline = "<td style='padding:1px;'><input type='checkbox' onclick='javascript:checkRow(" +
                orderitem.item.id +
                ",this)' id='chk_" +
                orderitem.item.id +
                "'></td>";
            secondtdline = "<td width='50%'  onclick='javascript:selectRow(" +
                orderitem.item.id +
                ")' style='padding:1px;cursor:pointer;max-width: 250px !important;word-wrap:break-word;'>" +
                orderitem.item.name + "</td>";
            thirdtdline = "<td valign='middle' align='center' style='padding:3px;'> <a href='javascript:decreaseItemQuantity(" +
                orderitem.item.id +
                ",&quot;" +
                orderitem.item.name +
                "&quot;," +
                orderitem.rate +
                ")'><img border='0' alt='' src='" +
                BASE_URL +
                "/assets/images/base/d/d_delete.png' height='22' width='18'></a> " +
                "<input type='text' onClick='this.select();' id='qty" +
                orderitem.item.id +
                "' size='1' onkeyup='javascript:enterManualQuantity(this.value," +
                orderitem.item.id +
                ")' value='" +
                orderitem.quantityOfItem +
                "' style='text-align:center;color:#fff; background-color:#333;height:22px;width:30px;' class='ordermanualQty'>" +
                " <a href='javascript:increaseItemQuantity(" +
                orderitem.item.id +
                ",&quot;" +
                orderitem.item.name +
                "&quot;," +
                orderitem.rate +
                ")'><img border='0'  alt='' src='" +
                BASE_URL +
                "/assets/images/base/d/d_add.png' height='22' width='18'></a></td>";

            kotflagline = "<td valign='middle' align='center' style='padding:3px;display:none;'>" +
                orderitem.item.isKotPrint +
                "</td>";


        }*/
        if (orderitem.item.promotionFlag == 'Y') {
            disc1 = (orderitem.rate * orderitem.quantityOfItem) *
                orderitem.discount / 100;
        }



        disc += disc1;
        subtotal += (orderitem.rate * orderitem.quantityOfItem) - disc1;
        var fourthtdline = "<td  style='padding:1px;text-align: center;'>" +
            parseFloat(orderitem.rate * orderitem.quantityOfItem - disc1)
            .toFixed(2) + "</td>";
        var fifthtdline = "<td style='padding:1px;text-align: center;'>" +
            parseFloat(disc1).toFixed(2) + "</td>";
        var sixthtdline = "<td style='padding:1px;text-align: center;'>" +
            parseFloat(orderitem.rate).toFixed(2) + "</td>";
        var seventhhtdline = "";
        var eighthtdline = "";
        if (vattaxText.length != 0) {
            seventhhtdline = "<td style='padding:1px;text-align: center;'>" +
                parseFloat(orderitem.vat).toFixed(2) + "</td>";
        }
        if (servicetaxText.length != 0) {
            eighthtdline = "<td style='padding:1px;text-align: center;'>" +
                parseFloat(orderitem.serviceTax).toFixed(2) + "</td>";
        }

        var endtrline = "</tr>";

        createdrowline += begintrline + firsttdline + secondtdline +
            thirdtdline + sixthtdline + fourthtdline + kotflagline + endtrline;

    }

    var subtotalWithOutTax = 0;
    var subtotalWithTax = 0;

    for (var j = 0; j < responseData.orderitem.length; j++) {

        var orderitemDesc = responseData.orderitem[j];

        var discRate = 0;
        if (orderitemDesc.item.promotionFlag == 'Y') {
            disc1 = (orderitemDesc.rate * orderitemDesc.quantityOfItem) *
                orderitemDesc.discount / 100;
        }
        if (orderitemDesc.serviceTax == '0' && orderitemDesc.vat == '0')
            subtotalWithOutTax += (orderitemDesc.rate * orderitemDesc.quantityOfItem) - discRate;
        else {
            orderVat = orderitemDesc.vat;
            orderSTax = orderitemDesc.serviceTax;
            subtotalWithTax += (orderitemDesc.rate * orderitemDesc.quantityOfItem) - discRate;
            // new added strt 28.3.2019 for item wise tax calculation
		    staxAmt += (((orderitemDesc.rate * orderitemDesc.quantityOfItem)-discRate) * orderSTax) / 100;
		    vatAmt +=  (((orderitemDesc.rate * orderitemDesc.quantityOfItem)-discRate) * orderVat) / 100;
		    //new added end
        }

    }

    if (subtotalWithOutTax > custdiscAmtVal) {
        subtotalWithTax = subtotal - subtotalWithOutTax;
    } else {
        subtotalWithTax = subtotal - custdiscAmtVal;
    }

    if (storeID == '35' && tableno != '0' && orderSTax == '0') {
        staxAmt = (subtotalWithTax * staticST / 100);
    } else {
        //staxAmt = (subtotalWithTax * orderSTax / 100);
    }
    if (storeID == '35' && tableno != '0' && orderVat == '0') {
        vatAmt = (subtotalWithTax * staticVat / 100);
    } else {
        //vatAmt = (subtotalWithTax * orderVat / 100);
    }

    //console.log(staxAmt + " " + vatAmt);

    //itemObjValue.push(ordItemVal.itemId);
    //itemUnique = $.unique(itemObjValue);

    generatedHtml = tableline + headerline + createdrowline + footerline;
    if (tableno == '0' && parcelST == 'N') {
        staxAmt = 0.0;
    }
    if (tableno == '0' && parcelVat == 'N') {
        vatAmt = 0.0;
    }

    if (schargetext == 'Y' && scharge != 0.00) {
        staxAmt = staxAmt + staxAmt * scharge / 100;
        vatAmt = vatAmt + vatAmt * scharge / 100;
        schargevalue = subtotal * scharge / 100;

    }

    grandTotal = (subtotal + parseFloat(schargevalue) + staxAmt + vatAmt);
    netPrice = grandTotal - paidAmtVal - custdiscAmtVal;
    $('#editadvtblbookingitems').css("height", '100px');
    orderitemcontainerId.innerHTML = generatedHtml;
    if (storeroundoffflag == 'Y') {
        grandTotal = Math.round(grandTotal);
        netPrice = Math.round(netPrice);
    }
    if (storedoubleroundoffflag == 'Y') {
        netPrice = round(netPrice, 1);
    }

    subtotalcontainerId.innerHTML = parseFloat(subtotal).toFixed(2);
    if (schargetext == 'Y') {
        $("#schargevalue1").html(parseFloat(scharge).toFixed(2));
        $("#schrgId1").html(parseFloat(schargevalue).toFixed(2));
    }
    if (servicetaxText.length != 0) {
        document.getElementById('servicetaxcontId1').innerHTML = parseFloat(staxAmt).toFixed(2);
    }
    if (vattaxText.length != 0) {
        document.getElementById('vatcontId1').innerHTML = parseFloat(vatAmt).toFixed(2);
    }

    amttopaycontainerId.innerHTML = parseFloat(netPrice).toFixed(2);
    grandtotalcontainerId.innerHTML = parseFloat(grandTotal).toFixed(2);
    total = grandTotal;
    totDisc = disc;
    $("#editbilltbl").show();
    $("#edititemCodeSearch").val("");


}

function printAdvOrderInv(orderid,paidamt){
	var order = {};
	order.id = orderid;
	order.storeId = storeID;
	var ajaxCallObject = new CustomBrowserXMLObject();
    if (mobPrintVal == "Y") {
		$.ajax({
			type : "POST",
			url : BASE_URL + "/order/getOrderWithPaymentInfo.htm",
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(order),
			success : function(response) {
				var jsonObj = JSON.parse(response);
				/* ***** Store Details ***** */
				console.log(response);
				//alert("fghfh"+response);
				var orderNo = jsonObj.id;
				var storeBasedOrderNo = jsonObj.orderNo;
				var tabNo = jsonObj.table_no;
				var customerName = jsonObj.customers.name;
				var orderCustomerName = jsonObj.customerName;
				var customerAddr = jsonObj.customers.address;
				var orderCustomerAddr = jsonObj.deliveryAddress;
				var customerPhNo = jsonObj.customers.contactNo;
				var customerEmail = jsonObj.customers.emailId;
				var state=jsonObj.state;
				var orderDateWithTime = jsonObj.customers.orderTime;
				var orderTime = jsonObj.customers.time;
                var cuslocation = jsonObj.location;
                var cusstreet = jsonObj.street;
                var cushouseno = jsonObj.houseNo;
                var delivaryboy = jsonObj.deliveryPersonName;
				var ordercustomerphone= jsonObj.customerContact;
				
				/* ***** Bill Amount Details ***** */
				var storeId = jsonObj.orderBill.storeid;
				var billAmt = jsonObj.orderBill.billAmount;
				var serviceTaxAmt = jsonObj.orderBill.serviceTaxAmt;
				var vatAmt = jsonObj.orderBill.vatAmt;
				var grossAmt = jsonObj.orderBill.grossAmt;
				var totalDiscount = jsonObj.orderBill.totalDiscount;
				var customerDiscount = jsonObj.orderBill.customerDiscount;
				var roundOffAmt = jsonObj.orderBill.roundOffAmt;
				var discPercentage = jsonObj.orderBill.discountPercentage;
				var serviceChargeAmt = jsonObj.orderBill.serviceChargeAmt;
				var subToatlAmt = jsonObj.orderBill.subTotalAmt;
				//var serviceChargeDisc = jsonObj.ordertype.serviceChargeValue;
				var serviceChargeDisc = jsonObj.orderBill.serviceChargeRate;
				var orderTypeOfOrder = jsonObj.ordertype.orderTypeName;
				var orderDate=jsonObj.orderTime;
				var afterdiscount = subToatlAmt - customerDiscount + serviceChargeAmt; // new added 2nd Apr 2018
				
				
				if (printbillpapersize == '58.00') {
					$("#itemDetailsPrint58").text("");
					/* ****** Print in 58 paper size ***** */
                   /* ********** START STORE INFO PRINT ********** */
				    $('#orderValue58').text(storeBasedOrderNo);
					//$('#tableNoValue58').text(tabNo);
					$('#cashOrderdate58').text(orderDate);
					if(tabNo!='0'){
						$('#tableNoValue58').text('Table No:'+tabNo);
					}
					else{
						$('#tableNoValue58').text(orderTypeOfOrder);
					}
					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
						var createdrowline = "";
						var startTrline = "<tr style='padding: 1px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 50px !important; word-wrap: break-word; font-size: 10px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px; font-size: 10px;font-family: sans-serif;'>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemRate + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 10px;'>" + itemTotalPrice + "</td>";
						var endTrline = "</tr>";
						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;
						$("#itemDetailsPrint58").append(createdrowline);  // it was commented by previous developer

					}

					$('#totalAmt58').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#totalServiceChrg_58").show();
						$('#servChrg58').text(serviceChargeAmt);
					} else {
						$("#totalServiceChrg_58").hide();
					}

					if (serviceTaxAmt >0) {
						$("#totalServiceTax_58").show();
						$('#servTax58').text(serviceTaxAmt);
					} else {
						$("#totalServiceTax_58").hide();
					}

					if (vatAmt > 0) {
						$("#totalVatTax_58").show();
						$("#vatTax58").text(vatAmt);
					} else {
						$("#totalVatTax_58").hide();
					}

					if (customerDiscount > 0) {
						$("#showDiscount_58").show();
						$("#discountValue58").text(customerDiscount);
					} else {
						$("#showDiscount_58").hide();
					}

					$("#grossAmount58").text(billAmt);
					$("#amoutToPay58").text(grossAmt);

					var paymentsObj = jsonObj.payments.length;
					
					$('#paidAmount58').text(paidamt);
					if(paidamt>=grossAmt){
						$('#refundAmount58').text(Number(paidamt) - Number(grossAmt));	
					}
					else{
						$('#refundAmount58').text(Number(grossAmt) - Number(paidamt));
					}
					
					if(jsonObj.orderitem.length>0){
						 printCashOrCardLocal58();
						  }else{
							  $('#alertModal').modal('show');
						  }
					
			} else if(printbillpapersize == '80.00') {
					if( gsttext != '' && gsttext.length>0){
						if(gstno != '' && gstno.length>0){
							   var gstText = gsttext+":"+gstno;
							   document.getElementById('paidgstdata').innerHTML = gstText;
							   $("paidgstdata").show();
							   
						   }
					}
					else{
						 $("paidgstdata").hide();
					}
					$("#itemDetailsPrint80").text("");
					/* ****** Print in 80 paper size ***** */

					/* ********** START STORE INFO PRINT ********** */
				    $('#cashOrdervalue80').text(storeBasedOrderNo);
				    var formattedDate = new Date(jsonObj.orderDate);
					var d = formattedDate.getDate();
					var m =  formattedDate.getMonth();
					m += 1;  // JavaScript months are 0-11
					var y = formattedDate.getFullYear();
					$("#cashOrderdate80").text(y + "-" + m + "-" + d);
					//$('#cashOrderdate80').text(orderDate);
					if(tabNo!='0'){
						$('#cashtableNoValue80').text('Table No:'+tabNo);
					}
					else{
						$('#cashtableNoValue80').text(orderTypeOfOrder);
					}
					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */

					for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
						var createdrowline = "";
						var startTrline = "<tr style='padding: 2px;'>";
						var firstTdline = "<td style='padding: 1px; max-width: 250px !important; word-wrap: break-word; font-size: 11px;font-family: sans-serif;'>" + itemName + "</td>";
						var secondTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px';>" + itemQty + "</td>";
						var thirdTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
						var fourthTdline = "<td style='padding: 1px;font-family: sans-serif; text-align: right; font-size: 11px;'>" + parseFloat(itemTotalPrice).toFixed(2) + "</td>";
						var endTrline = "</tr>";
						createdrowline = startTrline + firstTdline + secondTdline + thirdTdline + fourthTdline + endTrline;
						$("#itemDetailsPrint80").append(createdrowline);

					}

					/* ********** END ITEM DETAILS PRINT ********** */

					/* ********** START AMOUNT INFO PRINT ********** */
					$('#cashtotalamt80').text(parseFloat(subToatlAmt).toFixed(2));
					if (serviceChargeAmt > 0) {
                        $("#orderAmtDetails .serviceCharge80px").show();
						$('#cashservChrg80').text(parseFloat(serviceChargeAmt).toFixed(2));
						$('#cashservChrgDisc80').text("(" + serviceChargeDisc +")%");
					} else {
					    $("#orderAmtDetails .serviceCharge80px").hide();
					}

					if (serviceTaxAmt > 0) {
						$("#cashtotalServiceTax80px").show();
						$('#cashservTax80').text(parseFloat(serviceTaxAmt).toFixed(2));
					} else {
						$("#cashtotalServiceTax80px").hide();
					}

					if (vatAmt > 0) {
						$("#cashtotalVatTax80px").show();
						$("#cashvatTax80px").text(parseFloat(vatAmt).toFixed(2));
					} else {
						$("#cashtotalVatTax80px").hide();
					}

					if (customerDiscount > 0) {
						$("#cashshowDiscount80px").show();
						$("#cashdiscountValue80").text(parseFloat(customerDiscount).toFixed(2));
						$("#paidbilldiscpers").text(parseFloat(discPercentage).toFixed(2));
					} else {
						$("#cashshowDiscount80px").hide();
					}

					$("#cashgrossAmount80").text(parseFloat(billAmt).toFixed(2));
					$("#cashbillAmount80").text(parseFloat(grossAmt).toFixed(2));
					$("#paidAmount80").text(Number(paidamt).toFixed(2));
					var amttopay= Number(Number(grossAmt)-Number(paidamt)).toFixed(2);
					if(amttopay<=0){
					  $("#cashamoutToPay80").text(Number(0).toFixed(2));
					}else{
					  $("#cashamoutToPay80").text(amttopay);
					}
					if(amttopay<=0){
						 $("#refundAmount80").text(Number(Number(paidamt)-Number(grossAmt)).toFixed(2));
					}else{
						 $("#refundAmount80").text(Number(0).toFixed(2));
					}
					
                    var paymentsObj = jsonObj.payments.length;	
		 /*if(tabNo == '0' && parcelAdd == 'Y'){*/
			  if(parcelAdd == 'Y'){
            	      if(orderCustomerName != '' && orderCustomerName != null  && orderCustomerName.length >0){
							document.getElementById('cusname80').innerHTML =orderCustomerName;				
							document.getElementById("cusnametr80").style.display = "block";
							
						}
						if(orderCustomerAddr != '' && orderCustomerAddr != null && orderCustomerAddr.length >0){
							document.getElementById('cusaddress80').innerHTML =orderCustomerAddr;											
							 document.getElementById("cusaddresstr80").style.display = "block";
						}
						
						if(ordercustomerphone != '' && ordercustomerphone != null && ordercustomerphone.length >0){
							document.getElementById('cusphno80').innerHTML =ordercustomerphone;
							document.getElementById("cusphnotr80").style.display = "block";
							
						}
						
						if(cuslocation != '' && cuslocation != null && cuslocation.length >0){
							document.getElementById('cuslocation80').innerHTML =cuslocation;
							document.getElementById("cuslocationtr80").style.display = "block";
							
						}
						
						if(cusstreet != '' && cusstreet != null && cusstreet.length >0){
							document.getElementById('cusstreet80').innerHTML =cusstreet;
							document.getElementById("cusstreettr80").style.display = "block";
							 
						}
						if(cushouseno != '' && cushouseno != null && cushouseno.length >0){
							document.getElementById('cushouseno80').innerHTML =cushouseno;
							document.getElementById("cushousenotr80").style.display = "block";
							 
						}
						if(delivaryboy != '' && delivaryboy != null && delivaryboy.length >0){
							document.getElementById('deliveryboy80').innerHTML =delivaryboy;	
							document.getElementById("deliveryboytr80").style.display = "block";
							
						}
						
					}
			  
            else{
            	 document.getElementById("cusnametr80").style.display = "none";
            	 document.getElementById("cusaddresstr80").style.display = "none";
            	 document.getElementById("cusphnotr80").style.display = "none";
            	 document.getElementById("cuslocationtr80").style.display = "none";
            	 document.getElementById("cusstreettr80").style.display = "none";
            	 document.getElementById("cushousenotr80").style.display = "none";
            	 document.getElementById("deliveryboytr80").style.display = "none";
            }
           
			  if(jsonObj.orderitem.length>0){
				  printCashOrCardLocal80();
				  }else{
					  $('#alertModal').modal('show');
				  }                                             
        	

			
		}else if(printbillpapersize == '2100.00'){
			        $('#cashOrdervalue2100').text(storeBasedOrderNo);
					$('#cashOrderdate2100').text(orderDate);
					if(tabNo!='0'){
						$('#cashtableNoValue2100').text('Table No:'+tabNo);
					}
					else{
						$('#cashtableNoValue2100').text(orderTypeOfOrder);
					}
					//$('#cashtableNoValue2100').text(tabNo);

					/* ********** For GST *********** */
					
					$('#storeName2100_GST').text(customerName);
					$('#storeAddr2100_GST').text(storeAddr);
					$('#storeEmail2100_GST').text(customerEmail);
					$('#storePhNo2100_GST').text(customerPhNo);
					//$('#cashOrdervalue2100_GST').text(orderNo);
					$('#cashOrdervalue2100_GST').text(storeBasedOrderNo);
					$('#cashOrderDate_GST').text(orderDateWithTime);
					
					$('#cashCustName_GST').text(orderCustomerName);
					$('#cashCustAddr_GST').text(orderCustomerAddr);
					$('#cashCustState_GST').text(state);
					$('#cashCustGSTIN_GST').text(jsonObj.custVatRegNo);
					$('#cashCustPhone2100_GST').text(ordercustomerphone);
					
					var formattedDate = new Date(jsonObj.orderDate);
					var d = formattedDate.getDate();
					var m =  formattedDate.getMonth();
					m += 1;  // JavaScript months are 0-11
					var y = formattedDate.getFullYear();
					$("#cashOrderDate_GST").text(y + "-" + m + "-" + d);
					
					/* *********** End ************* */
					
					/* ********** END STORE INFO PRINT ********** */

					/* ********** START ITEM DETAILS PRINT ********** */
					
					$("#itemDetailsPrint2100_GST").html('');

					 var totTaxable = 0.0;
					 for ( var k = 0; k < jsonObj.orderitem.length; k++) {
						var item1 = jsonObj.orderitem[k];

						var itemName = item1.item.name;
						var itemQty = item1.quantityOfItem;
						var itemRate = item1.rate;
						var itemTotalPrice = item1.totalPriceByItem;
						var itemUnit = item1.item.unit;
						var itemDisc = item1.promotionDiscountAmt;
						var itemTotalAmt = 0.0;
						var itemTaxableAmt = 0.0;
						var cgstPrcnt = item1.vat;
						var cgstAmt = 0.0;
						var sgstPrcnt = item1.serviceTax;
						var sgstAmt = 0.0;
						var itemHsn = "";
						var itemschrgeamt = 0.0;
						
						if(item1.item.promotionFlag == "Y")
						{							
							itemTotalAmt = (item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem;
							if(item1.item.spotDiscount == "Y"){
								itemDisc = (itemTotalAmt * discPercentage)/100; 
							}
							else{
								itemDisc = 0.00;
							}
							
							if(serviceChargeAmt >0){
								itemschrgeamt = ((Number(itemTotalAmt) - Number(itemDisc)) * serviceChargeDisc)/100;	
							}
							
							
							itemTaxableAmt = (((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt)- itemDisc + itemschrgeamt;
							cgstAmt = (((((((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt)) - itemDisc) + itemschrgeamt )* item1.vat)/100;
							sgstAmt = (((((((item1.item.price-(item1.item.price*item1.item.promotionValue)/100)*item1.quantityOfItem)-item1.promotionDiscountAmt))- itemDisc) + itemschrgeamt) * item1.serviceTax)/100;
						
						}
						else
						{
							itemTotalAmt = item1.quantityOfItem*item1.item.price;
							if(item1.item.spotDiscount == "Y"){
								itemDisc = (itemTotalAmt * discPercentage)/100; 
							}
							else{
								itemDisc = 0.00;
							}
							if(serviceChargeAmt >0){
								itemschrgeamt = ((Number(itemTotalAmt) - Number(itemDisc)) * serviceChargeDisc)/100;	
							}
							
							itemTaxableAmt = (((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt) - itemDisc) + itemschrgeamt;
							cgstAmt = ((((((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt))- itemDisc) + itemschrgeamt) * item1.vat)/100;
							sgstAmt = ((((((item1.quantityOfItem*item1.item.price) - item1.promotionDiscountAmt))- itemDisc) + itemschrgeamt) * item1.serviceTax)/100;
						}
						
						totTaxable = totTaxable + itemTaxableAmt;
						var createdrowline = "";
						var startTrline1 = "<tr>";
						var firstTdline = "<td width='30%;'>" + itemName + "</td>";
						var secondTdline = "<td width='6%;'>" + itemQty + "</td>";
						var thirdTdline = "<td width='5%;'>" + parseFloat(itemRate).toFixed(2) + "</td>";
						var fourthTdline = "<td width='5%;'>" + parseFloat(itemTotalAmt).toFixed(2) + "</td>";
						var unit_clm = "<td width='6%;'>" + itemUnit + "</td>";
						var disc_clm = "<td width='5%;'>" + parseFloat(itemDisc).toFixed(2) + "</td>";
						
						var scharge_clm = "";
						if(serviceChargeAmt >0){
							scharge_clm ="<td width='5%;'>" + Number(itemschrgeamt).toFixed(2) + "</td>";
						}
						
						var taxable_clm = "<td width='10%;'>" + parseFloat(itemTaxableAmt).toFixed(2) + "</td>";
						var cgstPrcnt_clm = "<td width='5%;'>" + parseFloat(cgstPrcnt).toFixed(2) + "</td>";
						var cgstAmt_clm = "<td width='10%;'>" + parseFloat(cgstAmt).toFixed(2) + "</td>";
						var sgstPrcnt_clm = "<td width='5%;'>" + parseFloat(sgstPrcnt).toFixed(2) + "</td>";
						var sgstAmt_clm = "<td width='10%;'>" + parseFloat(sgstAmt).toFixed(2) + "</td>";
						var igstPrcnt_clm = "<td width='5%;'></td>";
						var igstAmt_clm = "<td width='10%;'></td>";
						var sl_no = "<td width='5%;'>"+(k+1)+"</td>";
						var hsn_clm = "<td></td>";
						var sac_clm = "<td></td>";
						var endTrline1 = "</tr>";

						createdrowline1 = startTrline1 + sl_no + firstTdline + hsn_clm + sac_clm + secondTdline + unit_clm + thirdTdline + fourthTdline + disc_clm + scharge_clm+ taxable_clm + cgstPrcnt_clm + cgstAmt_clm + sgstPrcnt_clm + sgstAmt_clm + igstPrcnt_clm + igstAmt_clm + endTrline1;

						$("#itemDetailsPrint2100_GST").append(createdrowline1);

					}
					var startTrline2 = "<tr style='border-top: 1px dashed;'>";
					var blank_clm1 = "<td></td><td></td><td></td><td></td><td></td><td></td>";
					var total_txt = "<td><b>Total:</b></td>";
					var total_amt_clm = "<td>"+parseFloat(subToatlAmt).toFixed(2)+"</td>";
					
					//var total_disc_clm = "<td>" + parseFloat(totalDiscount).toFixed(2) + "</td>";
					var total_disc_clm = "<td>" + parseFloat(customerDiscount).toFixed(2) + "</td>"; // changed in 2nd Apr 18					
					//var total_taxable_clm = "<td>" + parseFloat(totTaxable).toFixed(2) + "</td>";
					
					var total_schargeamount_clm="";
					if(serviceChargeAmt >0){
						total_schargeamount_clm = "<td>" + parseFloat(serviceChargeAmt).toFixed(2) + "</td>";
					}
					
					
					var total_taxable_clm = "<td>" + parseFloat(afterdiscount).toFixed(2) + "</td>"; // changed in 2nd Apr 18
					
					var blank_clm2 = "<td></td>";
					var total_cgstAmt_clm = "<td>" + parseFloat(vatAmt).toFixed(2) + "</td>";
					var blank_clm3 = "<td></td>";
					var total_sgstAmt_clm = "<td>" + parseFloat(serviceTaxAmt).toFixed(2) + "</td>";
					var blank_clm4 = "<td></td>";
					var total_igstAmt_clm = "<td></td>";
					var endTrline2 = "</tr>";

					createdrowline2 = startTrline2 + blank_clm1 + total_txt + total_amt_clm + total_disc_clm +total_schargeamount_clm+ total_taxable_clm + blank_clm2 + total_cgstAmt_clm + blank_clm3 + total_sgstAmt_clm + blank_clm4 + total_igstAmt_clm + endTrline2;

					$("#itemDetailsPrint2100_GST").append(createdrowline2);

					/* ********** END ITEM DETAILS PRINT ********** */

					/* ********** START AMOUNT INFO PRINT ********** */
					
					$('#cashtotalamt2100').text(subToatlAmt);

					if (serviceChargeAmt > 0) {
						$("#cashtotalServiceCharge2100px").show();
						$('#cashservChrgPercentage2100').text(serviceChargeDisc);
						$('#cashservChrg2100').text(serviceChargeAmt);
					} else {
						$("#cashtotalServiceCharge2100px").hide();
					}

					if (serviceTaxAmt > 0.00) {
						$("#cashtotalServiceTax2100px").show();
						$('#cashservTax2100').text(serviceTaxAmt);
					} else {
						$("#cashtotalServiceTax2100px").hide();
					}

					if (vatAmt > 0) {
						$("#cashtotalVatTax2100px").show();
						$("#cashvatTax2100px").text(vatAmt);
					} else {
						$("#cashtotalVatTax2100px").hide();
					}

					if (customerDiscount > 0) {
						$("#cashshowDiscount2100px").show();
						$("#cashdiscountValue2100").text(customerDiscount);
					} else {
						$("#cashshowDiscount2100px").hide();
					}

					$("#cashgrossAmount2100").text(billAmt);
					$("#cashamoutToPay2100").text(grossAmt);

					$("#cashgrossAmount2100_gst").text(parseFloat(grossAmt).toFixed(2));
					$("#cashvatTax2100px_gst").text(parseFloat(vatAmt).toFixed(2));
					$('#cashservTax2100_gst').text(parseFloat(serviceTaxAmt).toFixed(2));
					$('#cashTotalTaxAmount2100_gst').text(Number(Number(serviceTaxAmt) + Number(vatAmt)).toFixed(2));
					
					
					var cash_gross_word = number2text(parseFloat(grossAmt).toFixed(2));
					
					$("#cashgrossAmount2100_word_gst").text(cash_gross_word);
					$("#paidAmount_paidbill_2100px").text(Number(paidamt).toFixed(2)); 
					if(paidamt>=grossAmt)
					   $("#amoutToPay_paidbill_2100px").text(Number(Number(paidamt)-Number(grossAmt)).toFixed(2));
					else
					  $("#amoutToPay_paidbill_2100px").text(Number(Number(grossAmt)-Number(paidamt)).toFixed(2));
					
					var paymentsObj = jsonObj.payments.length;
					var paymentmode = "";
					var coma = ',';
					if (paymentsObj == 1) {
						paymentmode=jsonObj.payments[0].paymentMode;
					}else{
						for(var i=0;i<paymentsObj;i++){
							if(paymentmode == ""){
								paymentmode=jsonObj.payments[i].paymentMode;
							}else{
								paymentmode = paymentmode + coma + jsonObj.payments[i].paymentMode;
							}
						}
					}
					$("#paymentmode_paidbill_2100px").text(paymentmode);
					
					var paymentsObj = jsonObj.payments.length;
					  if(jsonObj.orderitem.length>0){
						  printCashOrCardLocal2100();
					  }else{
						  $('#alertModal').modal('show');
					  }
				}

			}
		});

	} else {
			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjax(BASE_URL + "/order/printbill/"+orderid+ ".htm", function(response) {
				try{
					if(response=='Success')
						showPaidBillPrintSuccessModal();					
				   }catch(e)
				   		{alert(e);}
				   }, null);					
	}
	
}

function printCashOrCardLocal58() {
    var divToPrint = document.getElementById('printDiv58');
	document.getElementById('removePrint58').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('removePrint58').style.display = 'block';
    newWin.close();
}

function printCashOrCardLocal80() {
    var divToPrint = document.getElementById('printDiv80');
	document.getElementById('cashRemovePrint80').style.display = 'none';
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.document.close();
	newWin.focus();
	newWin.print();
	document.getElementById('cashRemovePrint80').style.display = 'block';
    newWin.close();
}


function printCashOrCardLocal2100() {
	var divToPrint = document.getElementById('printDiv2100GST');
	newWin = window.open("");
	newWin.document.write(divToPrint.outerHTML);
	newWin.focus();
	newWin.print();
	newWin.close();

}


function number2text(value) {
    var fraction = Math.round(frac(value)*100);
    var f_text  = "";

    if(fraction > 0) {
        f_text = "AND "+convert_number(fraction)+" PAISE";
    }

    return convert_number(value)+" RUPEE "+f_text+" ONLY";
}

function frac(f) {
    return f % 1;
}

function convert_number(number)
{
    if ((number < 0) || (number > 999999999)) 
    { 
        return "NUMBER OUT OF RANGE!";
    }
    var Gn = Math.floor(number / 10000000);  /* Crore */ 
    number -= Gn * 10000000; 
    var kn = Math.floor(number / 100000);     /* lakhs */ 
    number -= kn * 100000; 
    var Hn = Math.floor(number / 1000);      /* thousand */ 
    number -= Hn * 1000; 
    var Dn = Math.floor(number / 100);       /* Tens (deca) */ 
    number = number % 100;               /* Ones */ 
    var tn= Math.floor(number / 10); 
    var one=Math.floor(number % 10); 
    var res = ""; 

    if (Gn>0) 
    { 
        res += (convert_number(Gn) + " CRORE"); 
    } 
    if (kn>0) 
    { 
            res += (((res=="") ? "" : " ") + 
            convert_number(kn) + " LAKH"); 
    } 
    if (Hn>0) 
    { 
        res += (((res=="") ? "" : " ") +
            convert_number(Hn) + " THOUSAND"); 
    } 

    if (Dn) 
    { 
        res += (((res=="") ? "" : " ") + 
            convert_number(Dn) + " HUNDRED"); 
    } 


    var ones = Array("", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX","SEVEN", "EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE", "THIRTEEN","FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN","NINETEEN"); 
var tens = Array("", "", "TWENTY", "THIRTY", "FOURTY", "FIFTY", "SIXTY","SEVENTY", "EIGHTY", "NINETY"); 

    if (tn>0 || one>0) 
    { 
        if (!(res=="")) 
        { 
            res += " AND "; 
        } 
        if (tn < 2) 
        { 
            res += ones[tn * 10 + one]; 
        } 
        else 
        { 

            res += tens[tn];
            if (one>0) 
            { 
                res += (ones[one]); 
            } 
        } 
    }

    if (res=="")
    { 
        res = "zero"; 
    } 
    return res;
}












