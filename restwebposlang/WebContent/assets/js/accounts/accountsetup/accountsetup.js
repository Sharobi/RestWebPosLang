function isEmpty(val) {

    return (val === undefined || val == null || val.length <= 0) ? true : false;
}

function numcheck(e) {
    // Allow: backspace, delete, tab, escape, enter and .
    if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
        // Allow: Ctrl+A, Command+A
        (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
        // Allow: home, end, left, right, down, up
        (e.keyCode >= 35 && e.keyCode <= 40)) {
        // let it happen, don't do anything
        return;
    }
    // Ensure that it is a number and stop the keypress
    if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
        e.preventDefault();
    }
}

function closeaccount()
{
    document.getElementById('alertMsg').innerHTML = ' ';
    document.getElementById('alertMsgAccountSetup').innerHTML = ' ';
}

function openAddEditModal(id, name, code, group, opbal, cr_dr,tran_lint,cashdis,phone,email,pan,address,gstreg,dlno) {

    document.getElementById('alertMsg').innerHTML = ' ';
    document.getElementById('alertMsgAccountSetup').innerHTML = ' ';


    if (id == 0) { // add
        $("#accountheadertext").text(getAccountSetupText.headerTextAdd);
        $('#accountId').val('');
        $('#accountNameId').val('');
        $('#aliasNameId').val(''); // alias
        //  $('#accountGroupNameId').val();
        $('#openingBalanceId').val('');


        $('#crditlimitId').val('');
		 $('#cashDiscountPersentageId').val('');
        $('#phoneno').val('');
        $('#emailid').val('');
        $('#panNoId').val('');

       // $('#countryId').val(0);
      //  $('#stateId').val(0);

       // $('#cityId').val(0);
       // $('#ZonalNameID').val(0);
       // $('#AreaId').val(0);
        $('#addressid').val('');

		//$('#pinno').val('');

      $('#accountGroupNameId').val(0);

       $('#GSTRegistrationNumberId').val('');
       $('#DLnoId').val('');
       $("#acc_country_id").val(0);
      // $('#dueDays').val(0);
     //  $('#duePer').val(0);
     //   $('#dueDays_label').addClass('hide');
      //   $('#duePer_label').addClass('hide');

        $("#accountsave").show();
        $("#accountupdate").hide();


    } else { // update


        $("#accountheadertext").text(getAccountSetupText.headerTextUpdate);
        $('#accountId').val(id);
        $('#accountNameId').val(name);
        $('#aliasNameId').val(code); // alias
        $('#accountGroupNameId').val(group);
        $('#openingBalanceId').val(opbal);
        $("#cr_dr").val(cr_dr);
        $('#crditlimitId').val(tran_lint);
		 $('#cashDiscountPersentageId').val(cashdis);
        $('#phoneno').val(phone);
        $('#emailid').val(email);
        $('#panNoId').val(pan);
        //$('#cityId').val(city_id);
        //$('#ZonalNameID').val(zone_id);
       // $('#AreaId').val(area_id);
        $('#addressid').val(address);
       /* if (pin==0) {
        	 $('#pinno').val('');
		}else {
		    $('#pinno').val(pin);
		}
*/

       $('#GSTRegistrationNumberId').val(gstreg);
       $('#DLnoId').val(dlno);
    /*   if (group=='SCR')
       {

         $('#dueDays_label').removeClass('hide');
         $('#duePer_label').removeClass('hide');

       }else
       {
         $('#dueDays_label').addClass('hide');
         $('#duePer_label').addClass('hide');

       }*/
        //$('#dueDays').val(due_days);
       // $('#duePer').val(due_per);
      /* $("#aboveSchemeId").val(abosche);*/
       /*
        * load all country
        */

    /*   if (country_id==0) {
    	   $("#countryId").val(country_id);
       }
    	   if (country_id>0) {
		 $("#countryId").val(country_id.toString()+".0");
		 var commonResultObj1 = {};

		 // for state
			commonResultObj1.countryId = country_id;

			var ajaxCallObject = new CustomBrowserXMLObject();
			ajaxCallObject.callAjaxPost(BASE_URL+ "/invsetup/getStateByCountry.htm", commonResultObj1,
					function(response) {
						$('#pleasewaitModal').modal('hide');
						// console.log(response);
						var res = JSON.parse(response);
						var str = "<option value='0'>Select....</option>";
						$.each(res, function(i) {
							str = str + "<option value='" + res[i].id + "'>"
									+ res[i].name + "</option>";
						});
						$("#stateId").html(str);
						$('#stateId').val(state_id);


						// for city
						commonResultObj1.stateId = state_id;

						var ajaxCallObject = new CustomBrowserXMLObject();
						ajaxCallObject.callAjaxPost(BASE_URL+ "/invsetup/getCityByState.htm", commonResultObj1,
								function(response) {
									$('#pleasewaitModal').modal('hide');
									// console.log(response);
									var res = JSON.parse(response);
									var str = "<option value='0'>Select....</option>";
									$.each(res, function(i) {
										str = str + "<option value='" + res[i].id + "'>"
												+ res[i].name + "</option>";
									});
									$("#cityId").html(str);
									$('#cityId').val(city_id);
									/// for zone
								   	commonResultObj1.cityId = city_id;

									var ajaxCallObject = new CustomBrowserXMLObject();
									ajaxCallObject.callAjaxPost(BASE_URL+ "/invsetup/getzonebycity.htm", commonResultObj1,
											function(response) {
												$('#pleasewaitModal').modal('hide');
												// console.log(response);
												var res = JSON.parse(response);
												var str = "<option value='0'>Select....</option>";
												$.each(res, function(i) {
													str = str + "<option value='" + res[i].id + "'>"
															+ res[i].name + "</option>";
												});
												$("#ZonalNameID").html(str);
												$('#ZonalNameID').val(zone_id);
												// for area
												  commonResultObj1.zoneId = zone_id;

												    var ajaxCallObject = new CustomBrowserXMLObject();
												    ajaxCallObject.callAjaxPost(BASE_URL + "/accntsetup/getareabyzone.htm",
												    		commonResultObj1,
												        function(response) {
												            $('#pleasewaitModal').modal('hide');
												            // console.log(response);
												            var res = JSON.parse(response);
												            var str = "<option value='0'>Select....</option>";
												            $.each(res, function(i) {
												                str = str + "<option value=" + res[i].id + ">" +
												                    res[i].name + "</option>";
												            });
												            $("#AreaId").html(str);
												    		$('#AreaId').val(area_id);
												        });
											});

								});
					});





	}else {

		$('#stateId').val(0);
		  $('#cityId').val(0);
	        $('#ZonalNameID').val(0);
	        $('#AreaId').val(0);
	}*/









     $("#accountupdate").show();
     $("#accountsave").hide();

    }
    $('#accSetupAddEditModal').modal('show');

}

function checkSameItem() {

    var acc_name = $("#accountNameId").val();
    var id = $("#accountId").val();
    var AccSetupMasterObj = {};
    AccSetupMasterObj.name = acc_name;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/accntsetup/searchaccount.htm",
        AccSetupMasterObj,
        function(response) {


            var obj = jQuery.parseJSON(response);

            if (obj.id > 0) {

                $("#accountname").addClass("show");
            } else {
                $("#accountname").removeClass("show");
            }


        });


}

function addnewAccountSetup() {
    document.getElementById('alertMsg').innerHTML = ' ';
    document.getElementById('alertMsgAccountSetup').innerHTML = ' ';




    var id = $('#accountId').val();
    var name = $('#accountNameId').val();
    var code = $('#aliasNameId').val(); // alias
    var group_code = $('#accountGroupNameId').val();
  //  var city_id = $('#cityId').val();
  //  var zone_id = $('#ZonalNameID').val();
   // var area_id = $('#AreaId').val();
    var address = $('#addressid').val();
    //var pin = $('#pinno').val();

   /* if (isEmpty(pin)) {
    	pin = "";
    }*/
    var phone = $('#phoneno').val();
    var email = $('#emailid').val();
    var pan_no = $('#panNoId').val();
    var gst_registration_no = $('#GSTRegistrationNumberId').val();
  /*  var bcda_registration_no = $('#BCDAregistrationNumberId').val();*/
    //var dl_no = $('#DLnoId').val();
  var cash_discount_percentage = $('#cashDiscountPersentageId').val();
  /*    var dueDays=$('#dueDays').val();
        if (isEmpty(dueDays)) {
            dueDays=0;
        }

         var duePer=$('#duePer').val();
    if (isEmpty(duePer)) {
        duePer=0;
    }*/
  /*
    var aboveSchemeId= $("#aboveSchemeId").val();


    if (isEmpty(aboveSchemeId)) {
    	aboveSchemeId = 0;
    }
*/

    var cr_dr = $("#cr_dr").val();
    if (isEmpty(cash_discount_percentage)) {
        cash_discount_percentage = 0;
    }

    var trans_limit = $('#crditlimitId').val();
    if (isEmpty(trans_limit)) {
        trans_limit = 0;
    }
    var openingbalance = $('#openingBalanceId').val();


    var error = 0;
    if (isEmpty(openingbalance)) {
        openingbalance = 0;
    }





    /*
     * if fresh account
     */
    if (id == '') {


        var name_label = $("#accountName_label").text();
        var name_field = name_label.substring(0, name_label.lastIndexOf(" "));

        var name_label_group = $("#accountGroup_label").text();
        var name_field1 = name_label_group.substring(0, name_label_group
            .lastIndexOf(" "));

        var field_names = [
            ["accountNameId", name_field],
            ["accountGroupNameId", name_field1]
        ];

        if (fieldValidationWithAlertDivId(field_names, "alertMsgAccountSetup") > 0) {

        } else {
            // new account add here
            var AccSetupMasterObj = {};
            AccSetupMasterObj.name = name;
            AccSetupMasterObj.code = code;
            AccSetupMasterObj.group_code = group_code;
           // AccSetupMasterObj.cityId = city_id;
           // AccSetupMasterObj.zoneId = zone_id;
           // AccSetupMasterObj.areaId = area_id;
            AccSetupMasterObj.address = address;
           // AccSetupMasterObj.pin = pin;
            AccSetupMasterObj.phone = phone;
            AccSetupMasterObj.email = email;
            AccSetupMasterObj.panNo = pan_no;
            AccSetupMasterObj.gstRegistrationNo = gst_registration_no;
          /*  AccSetupMasterObj.bcdaRegistrationNo = bcda_registration_no;*/
            //AccSetupMasterObj.dlNo = dl_no;

            AccSetupMasterObj.opBalance = openingbalance;
            AccSetupMasterObj.cashDiscountPercentage = cash_discount_percentage;
            AccSetupMasterObj.transLimit = trans_limit;
            AccSetupMasterObj.asOnDate = moment(new Date()).format('YYYY-MM-DD');
            AccSetupMasterObj.opBalance = openingbalance;
            //AccSetupMasterObj.dueDays=dueDays;
           // AccSetupMasterObj.duePer=duePer;

          /*  AccSetupMasterObj.aboveScheme = aboveSchemeId;*/
          /*  AccSetupMasterObj.isActive=isactive; */

            AccSetupMasterObj.pst_type_id = cr_dr;

            console.log(JSON.stringify(AccSetupMasterObj));

            //alert(JSON.stringify(AccSetupMasterObj));

            if (error == 0) {
                var ajaxCallObject = new CustomBrowserXMLObject();
                ajaxCallObject.callAjaxPost(BASE_URL + "/accntsetup/addaccountsetup.htm",
                    AccSetupMasterObj,
                    function(response) {
                     //   $('#pleasewaitModal').modal('hide');
                        var status = JSON.parse(response);
                        chngeResultStat(status);

                   $('#accGroupAddEditModal').modal('hide');

                    });
            }




        }

    } else { // for edit

    	 var name_label = $("#accountName_label").text();
         var name_field = name_label.substring(0, name_label.lastIndexOf(" "));

         var name_label_group = $("#accountGroup_label").text();
         var name_field1 = name_label_group.substring(0, name_label_group
             .lastIndexOf(" "));

         var field_names = [
             ["accountNameId", name_field],
             ["accountGroupNameId", name_field1]
         ];

         if (fieldValidationWithAlertDivId(field_names, "alertMsgAccountSetup") > 0) {

         }else{

    	  var AccSetupMasterObj = {};
    	     AccSetupMasterObj.id=id
          AccSetupMasterObj.name = name;
          AccSetupMasterObj.code = code;
          AccSetupMasterObj.group_code = group_code;
         // AccSetupMasterObj.cityId = city_id;
          //AccSetupMasterObj.zoneId = zone_id;
        //  AccSetupMasterObj.areaId = area_id;
          AccSetupMasterObj.address = address;
       //   AccSetupMasterObj.pin = pin;
          AccSetupMasterObj.phone = phone;
          AccSetupMasterObj.email = email;
          AccSetupMasterObj.panNo = pan_no;
          AccSetupMasterObj.gstRegistrationNo = gst_registration_no;
        /*  AccSetupMasterObj.bcdaRegistrationNo = bcda_registration_no;*/
        //  AccSetupMasterObj.dlNo = dl_no;

          AccSetupMasterObj.opBalance = openingbalance;
          AccSetupMasterObj.cashDiscountPercentage = cash_discount_percentage;
          AccSetupMasterObj.transLimit = trans_limit;
          AccSetupMasterObj.asOnDate = moment(new Date()).format('YYYY-MM-DD');
          AccSetupMasterObj.opBalance = openingbalance;
           // AccSetupMasterObj.dueDays=dueDays;
           // AccSetupMasterObj.duePer=duePer;

        /*  AccSetupMasterObj.aboveScheme = aboveSchemeId;*/
        /*  AccSetupMasterObj.isActive=isactive; */

          AccSetupMasterObj.pst_type_id = cr_dr;

          console.log(JSON.stringify(AccSetupMasterObj));
         console.log(JSON.stringify(AccSetupMasterObj));
        if (error == 0) {
            var ajaxCallObject = new CustomBrowserXMLObject();
            ajaxCallObject.callAjaxPost(BASE_URL + "/accntsetup/updateaccountsetup.htm",
                AccSetupMasterObj,
                function(response) {
                    $('#pleasewaitModal').modal('hide');
                    var status = JSON.parse(response);
                    chngeResultStat(status);

                 $('#accGroupAddEditModal').modal('hide');

                });
        }

    }
    }

}

/*
 * for gst number enable
 */
function gstcheck()
{


    if ($('#isactive').val().checked == true) {

    	$("#gstnum").addClass("show");
    }
    if ($('#isactive').val().checked == false) {
    	$("#gstnum").removeClass("show");
    }

}



function DoConfirm() {
    $('#pleasewaitModal').modal('show');
    var id = document.getElementById('confirmId').value;
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/accntsetup/deleteaccount/" + id +
        ".htm",
        function(response) {
            $('#pleasewaitModal').modal('hide');
            var status = JSON.parse(response);
            chngeResultStat(status);
        }, null);
}

function targetURL() {
    location.href = BASE_URL + '/accntsetup/loadaccntsetup.htm';
}

function targetAction() {

	 var result=$("#confirmvalfrsaveupdate").val();
	 	console.log("vendorpayment statu="+result);

    // getAccountGroup();
    // getStateByCountry();
    // getCityByState();
    // getZoneByCity()
    // getAreaByZoneid();
}

/*
 * for dropdown list
 */



/*
 * for account group list
 */

function getAccountGroup() {
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/accntsetup/getaccontgroupname.htm",
        function(resp) {

            var obj = jQuery.parseJSON(resp);

            $('#pleasewaitModal').modal('hide');
            // console.log(response);

            var str = "<option value='0'>Select....</option>";
            $.each(obj, function(i) {
                str = str + "<option value='" + obj[i].code + "'>" +
                    obj[i].name + "</option>";
            });
            $("#accountGroupNameId").html(str);
        });

}

/*
 * for account selection
 */


function selectaccgroup() {


    var code = $("#accountGroupNameId").val();

   /* if (code == 'SCR') {
         $("#dueDays_label").removeClass('hide');
         $("#duePer_label").removeClass('hide');
        // $("#dueDays").removeClass('hide');
        // $("#duePer").removeClass('hide');
    } else {
        $("#dueDays_label").addClass('hide');
         $("#duePer_label").addClass('hide');
       //  $("#dueDays").addClass('hide');
        // $("#duePer").addClass('hide');
    }*/

}

/*
 * for state list
 */

function getStateByCountry() {

    var country = $("#countryId").val();
    var commonResultObj = {};
    commonResultObj.countryId = country;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getStateByCountry.htm",
        commonResultObj,
        function(response) {
            $('#pleasewaitModal').modal('hide');
            // console.log(response);
            var res = JSON.parse(response);
            var str = "<option value='0'>Select....</option>";
            $.each(res, function(i) {
                str = str + "<option value=" + res[i].id + ">" +
                    res[i].name + "</option>";
            });
            $("#stateId").html(str);
        });

}

function getCityByState() {
    var country = $("#countryId").val();
    var state = $("#stateId").val();
    var commonResultObj = {};
    commonResultObj.countryId = country;
    commonResultObj.stateId = state;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getCityByState.htm",
        commonResultObj,
        function(response) {
            $('#pleasewaitModal').modal('hide');
            // console.log(response);
            var res = JSON.parse(response);
            var str = "<option value='0'>Select....</option>";
            $.each(res, function(i) {
                str = str + "<option value=" + res[i].id + ">" +
                    res[i].name + "</option>";
            });
            $("#cityId").html(str);
        });

}

function getZoneByCity() {
    var country = $("#countryId").val();
    var state = $("#stateId").val();
    var cityid = $("#cityId").val();
    var commonResultObj = {};
    commonResultObj.countryId = country;
    commonResultObj.stateId = state;
    commonResultObj.cityId = cityid;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getzonebycity.htm",
        commonResultObj,
        function(response) {
            $('#pleasewaitModal').modal('hide');
            // console.log(response);
            var res = JSON.parse(response);
            var str = "<option value='0'>Select....</option>";
            $.each(res, function(i) {
                str = str + "<option value=" + res[i].id + ">" +
                    res[i].name + "</option>";
            });
            $("#ZonalNameID").html(str);
        });

}

function getAreaByZoneid() {

    var country = $("#countryId").val();
    var state = $("#stateId").val();
    var cityid = $("#cityId").val();
    var zoneid = $("#ZonalNameID").val();

    var commonResultObj = {};
    commonResultObj.countryId = country;
    commonResultObj.stateId = state;
    commonResultObj.cityId = cityid;
    commonResultObj.zoneId = zoneid;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/accntsetup/getareabyzone.htm",
        commonResultObj,
        function(response) {
            $('#pleasewaitModal').modal('hide');
            // console.log(response);
            var res = JSON.parse(response);
            var str = "<option value='0'>Select....</option>";
            $.each(res, function(i) {
                str = str + "<option value=" + res[i].id + ">" +
                    res[i].name + "</option>";
            });
            $("#AreaId").html(str);
        });

}
/** ***********===================================================================================************ */
/*
 * for accout group section
 */
function openAddAccoutGroupModal() {
    $("#headertextaccountgroup").text(
        getAccountSetupText.headerTextAddAccountGroup);

    $('#accGroupAddEditModal').modal('show');
}

function addEditaccGroup() {
    var id = $('#accGroupId').val();
    var name = $('#accGroupName').val();
    var code = $('#accGroupCode').val();
    var desc = $('#accGroupDesc').val();
    var accTypeId = $('#accTypeList').val();

    var account_type = $("#acctypeid_label").text();
    var account_type_field = account_type.substring(0, account_type
        .lastIndexOf(" "));
    var name_label = $("#accgrpname_label").text();
    var name_field = name_label.substring(0, name_label.lastIndexOf(" "));

    var name_label2= $('#name_label2').text();
	var name_field2= name_label2.substring(0, name_label.lastIndexOf(" "));


    var field_names = [
        ["accTypeList", account_type_field],
        ["accGroupName", name_field],
        ["accGroupCode", name_field2],
    ];





    if (fieldValidation(field_names) > 0) {} else {

        var AccGroupMasterObj = {};
        AccGroupMasterObj.name = name;
        AccGroupMasterObj.code = code;
        AccGroupMasterObj.description = desc;
        AccGroupMasterObj.accountTypeId = accTypeId;

        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjaxPost(BASE_URL + "/accntgrp/addaccgrp.htm",
            AccGroupMasterObj,
            function(response) {
                $('#pleasewaitModal').modal('hide');
                var status = JSON.parse(response);
                chngeResultStatForNewItem(status);

                $('#accGroupAddEditModal').modal('hide');

                var newaccntgrou = "<option value='" + status.code + "'>" +
             //   var newaccntgrou = "<option value='" +code + "'>" +
                    name + "</option>";
                $("#accountGroupNameId").append(newaccntgrou);
                $("#accountGroupNameId").val(status.code);
            });
    }
}
// ===================================================end

/*
 * open city model here
 */
function openCityModel() {

    $("#headertextofcity").text(getAccountSetupText.headerTextAddCity);

    $('#cityAddEditModal').modal('show');



    if ($('#countryId').val()>0) {
    	  $('#countryidincity').val($('#countryId').val());



    		 var commonResultObj1 = {};

    		 // for state
    			commonResultObj1.countryId = $('#countryidincity').val();

    			var ajaxCallObject = new CustomBrowserXMLObject();
    			ajaxCallObject.callAjaxPost(BASE_URL+ "/invsetup/getStateByCountry.htm", commonResultObj1,
    					function(response) {
    						$('#pleasewaitModal').modal('hide');
    						// console.log(response);
    						var res = JSON.parse(response);
    						var str = "<option value='0'>Select....</option>";
    						$.each(res, function(i) {
    							str = str + "<option value='" + res[i].id + "'>"
    									+ res[i].name + "</option>";
    						});
    						$("#stateList").html(str);
    						$('#stateList').val($('#stateId').val());
    			});


	}else {


		 $('#countryidincity').val(0);
		 $('#stateList').val(0);
	}









}

function getStateByCountryinCity() {
    var country = $("#countryidincity").val();
    var commonResultObj = {};
    commonResultObj.countryId = country;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getStateByCountry.htm",
        commonResultObj,
        function(response) {
            $('#pleasewaitModal').modal('hide');
            // console.log(response);
            var res = JSON.parse(response);
            var str = "<option value='0'>Select....</option>";
            $.each(res, function(i) {
                str = str + "<option value='" + res[i].id + "'>" +
                    res[i].name + "</option>";
            });
            $("#stateList").html(str);
        });

}

function addEditCity() {
    var country = $('#countryidincity').val();
    var state = $('#stateList').val();
    var cityName = $('#cityName').val();

    var name_label = $("#name_label_countryincity").text();
    var name_field = name_label.substring(0, name_label.lastIndexOf(" "));

    var name_label_state = $("#name_label_stateincity").text();
    var name_field1 = name_label_state.substring(0, name_label_state
        .lastIndexOf(" "));

    var name_label_city = $("#name_label_cityincity").text();
    var name_field2 = name_label_city.substring(0, name_label_city
        .lastIndexOf(" "));

    var field_names = [
        ["countryidincity", name_field],
        ["stateList", name_field1],
        ["cityName", name_field2]
    ];

    if (fieldValidationWithAlertDivId(field_names, "alertMsgForcity") > 0) {

    } else {
        var commonresultsetObj = {};
        commonresultsetObj.countryId = country;
        commonresultsetObj.stateId = state;
        commonresultsetObj.name = cityName;

        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/addcity.htm",
            commonresultsetObj,
            function(response) {
                $('#pleasewaitModal').modal('hide');
                var status = JSON.parse(response);
                chngeResultStatForNewItem(status);
                $('#cityAddEditModal').modal('hide');

                var newcity = "<option value='" + status.id + "'>" +
                    cityName + "</option>";
                $("#cityId").append(newcity);
                $("#cityId").val(status.id);
            });
    }

}

// ===================================================end
/*
 *
 * zone portion start here
 */

function openZoneModel() {

    $("#headertextofzone").text(getAccountSetupText.headerTextAddZone);

    $('#zoneAddEditModal').modal('show');



    if ($('#countryId').val()>0) {
    	  $('#countryidinzone').val($('#countryId').val());



    		 var commonResultObj1 = {};

    		 // for state
    			commonResultObj1.countryId = $('#countryidinzone').val();

    			var ajaxCallObject = new CustomBrowserXMLObject();
    			ajaxCallObject.callAjaxPost(BASE_URL+ "/invsetup/getStateByCountry.htm", commonResultObj1,
    					function(response) {
    						$('#pleasewaitModal').modal('hide');
    						// console.log(response);
    						var res = JSON.parse(response);
    						var str = "<option value='0'>Select....</option>";
    						$.each(res, function(i) {
    							str = str + "<option value='" + res[i].id + "'>"
    									+ res[i].name + "</option>";
    						});
    						$("#stateListinzone").html(str);
    						$('#stateListinzone').val($('#stateId').val());

    						if ($('#stateId').val()>0) {

    							// for city
    							commonResultObj1.stateId = $('#stateListinzone').val();

    							var ajaxCallObject = new CustomBrowserXMLObject();
    							ajaxCallObject.callAjaxPost(BASE_URL+ "/invsetup/getCityByState.htm", commonResultObj1,
    									function(response) {
    										$('#pleasewaitModal').modal('hide');
    										// console.log(response);
    										var res = JSON.parse(response);
    										var str = "<option value='0'>Select....</option>";
    										$.each(res, function(i) {
    											str = str + "<option value='" + res[i].id + "'>"
    													+ res[i].name + "</option>";
    										});
    										$("#cityListinzone").html(str);
    										 $('#cityListinzone').val($('#cityId').val());





							   });

    						}else {


    							$('#cityListinzone').val(0);
							}


    			});


	}else {


		 $('#countryidinzone').val(0);
		 $('#stateListinzone').val(0);
		 $('#cityListinzone').val(0);
	}

}

function getStateByCountryinZone() {
    var country = $("#countryidinzone").val();
    var commonResultObj = {};
    commonResultObj.countryId = country;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getStateByCountry.htm",
        commonResultObj,
        function(response) {
            $('#pleasewaitModal').modal('hide');
            // console.log(response);
            var res = JSON.parse(response);
            var str = "<option value='0'>Select....</option>";
            $.each(res, function(i) {
                str = str + "<option value='" + res[i].id + "'>" +
                    res[i].name + "</option>";
            });
            $("#stateListinzone").html(str);
        });

}

function getCityByStateinzone() {
    var country = $("#countryidinzone").val();
    var state = $("#stateListinzone").val();
    var commonResultObj = {};
    commonResultObj.countryId = country;
    commonResultObj.stateId = state;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getCityByState.htm",
        commonResultObj,
        function(response) {
            $('#pleasewaitModal').modal('hide');

            var res = JSON.parse(response);
            var str = "<option value='0'>Select....</option>";
            $.each(res, function(i) {
                str = str + "<option value='" + res[i].id + "'>" +
                    res[i].name + "</option>";
            });
            $("#cityListinzone").html(str);

        });
}

/*
 * add zone
 */

function addEditZone() {

    var country = $('#countryidinzone').val();
    var state = $('#stateListinzone').val();
    var cityName = $('#cityListinzone').val();
    var districtName = $('#districtNameinzone').val();
    var zoneName = $('#zoneNameinzone').val();

    var name_label = $("#country_labelinzone").text();
    var name_field = name_label.substring(0, name_label.lastIndexOf(" "));

    var name_labelstate = $("#state_labelinzone").text();
    var name_fieldState = name_labelstate.substring(0, name_labelstate
        .lastIndexOf(" "));

    var name_labelcity = $("#city_labelinZone").text();
    var name_fieldCity = name_labelcity.substring(0, name_labelcity
        .lastIndexOf(" "));

    var field_names = [
        ["countryidinzone", name_field],
        ["stateListinzone", name_fieldState],
        ["cityListinzone", name_fieldCity]
    ];

    if (fieldValidationWithAlertDivId(field_names, "alertMsginzone") > 0) {

    } else {

        var commonresultsetObj = {};
        commonresultsetObj.countryId = country;
        commonresultsetObj.stateId = state;
        commonresultsetObj.cityId = cityName;
        commonresultsetObj.districtName = districtName;
        commonresultsetObj.name = zoneName;

        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/addzone.htm",
            commonresultsetObj,
            function(response) {
                $('#pleasewaitModal').modal('hide');
                var status = JSON.parse(response);
                chngeResultStatForNewItem(status);
                $('#zoneAddEditModal').modal('hide');

                var newzone = "<option value='" + status.id + "'>" +
                    zoneName + "</option>";
                $("#ZonalNameID").append(newzone);
                $("#ZonalNameID").val(status.id);
            });

    }

}
// ===================================================end

/*
 * open area model here
 *
 *
 */

function openAreaModal() {

    $("#headertextinarea").text(getAccountSetupText.headerTextAddArea);

    $('#areaAddEditModal').modal('show');

    if ($('#countryId').val()>0) {
  	  $('#countryListinarea').val($('#countryId').val());



  		 var commonResultObj1 = {};

  		 // for state
  			commonResultObj1.countryId = $('#countryListinarea').val();

  			var ajaxCallObject = new CustomBrowserXMLObject();
  			ajaxCallObject.callAjaxPost(BASE_URL+ "/invsetup/getStateByCountry.htm", commonResultObj1,
  					function(response) {
  						$('#pleasewaitModal').modal('hide');
  						// console.log(response);
  						var res = JSON.parse(response);
  						var str = "<option value='0'>Select....</option>";
  						$.each(res, function(i) {
  							str = str + "<option value='" + res[i].id + "'>"
  									+ res[i].name + "</option>";
  						});
  						$("#stateListinarea").html(str);
  						$('#stateListinarea').val($('#stateId').val());

  						if ($('#stateId').val()>0) {

  							// for city
  							commonResultObj1.stateId = $('#stateListinarea').val();

  							var ajaxCallObject = new CustomBrowserXMLObject();
  							ajaxCallObject.callAjaxPost(BASE_URL+ "/invsetup/getCityByState.htm", commonResultObj1,
  									function(response) {
  										$('#pleasewaitModal').modal('hide');
  										// console.log(response);
  										var res = JSON.parse(response);
  										var str = "<option value='0'>Select....</option>";
  										$.each(res, function(i) {
  											str = str + "<option value='" + res[i].id + "'>"
  													+ res[i].name + "</option>";
  										});
  										$("#cityListinarea").html(str);
  										 $('#cityListinarea').val($('#cityId').val());




  										 if ($('#cityListinarea').val()>0) {

  										   	commonResultObj1.cityId = $('#cityListinarea').val();

  											var ajaxCallObject = new CustomBrowserXMLObject();
  											ajaxCallObject.callAjaxPost(BASE_URL+ "/invsetup/getzonebycity.htm", commonResultObj1,
  													function(response) {
  														$('#pleasewaitModal').modal('hide');
  														// console.log(response);
  														var res = JSON.parse(response);
  														var str = "<option value='0'>Select....</option>";
  														$.each(res, function(i) {
  															str = str + "<option value='" + res[i].id + "'>"
  																	+ res[i].name + "</option>";
  														});
  														$("#zoneListinarea").html(str);
  														$('#zoneListinarea').val( $('#ZonalNameID').val());
  														// for area

										});
  										 }
  										 else {
  											$('#zoneListinarea').val(0);
										}



							   });

  						}else {


  							$('#cityListinarea').val(0);

  							$('#stateListinarea').val();
							}


  			});


	}else {


		 $('#countryListinarea').val(0);
		 $('#stateListinarea').val(0);
		 $('#cityListinarea').val(0);
		 $('#zoneListinarea').val(0);
	}





}

function getStateByCountryinArea() {
    var country = $("#countryListinarea").val();
    var commonResultObj = {};
    commonResultObj.countryId = country;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getStateByCountry.htm",
        commonResultObj,
        function(response) {
            $('#pleasewaitModal').modal('hide');
            // console.log(response);
            var res = JSON.parse(response);
            var str = "<option value='0'>Select....</option>";
            $.each(res, function(i) {
                str = str + "<option value='" + res[i].id + "'>" +
                    res[i].name + "</option>";
            });
            $("#stateListinarea").html(str);
        });

}

function getCityByStateinarea() {
    var country = $("#countryListinarea").val();
    var state = $("#stateListinarea").val();
    var commonResultObj = {};
    commonResultObj.countryId = country;
    commonResultObj.stateId = state;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getCityByState.htm",
        commonResultObj,
        function(response) {
            $('#pleasewaitModal').modal('hide');

            var res = JSON.parse(response);
            var str = "<option value='0'>Select....</option>";
            $.each(res, function(i) {
                str = str + "<option value='" + res[i].id + "'>" +
                    res[i].name + "</option>";
            });
            $("#cityListinarea").html(str);

        });
}

function getZoneByCityinArea() {
    var country = $("#countryListinarea").val();
    var state = $("#stateListinarea").val();
    var cityid = $("#cityListinarea").val();

    var commonResultObj = {};
    commonResultObj.countryId = country;
    commonResultObj.stateId = state;
    commonResultObj.cityId = cityid;

    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getzonebycity.htm",
        commonResultObj,
        function(response) {
            $('#pleasewaitModal').modal('hide');
            // console.log(response);
            var res = JSON.parse(response);
            var str = "<option value='0'>Select....</option>";
            $.each(res, function(i) {
                str = str + "<option value='" + res[i].id + "'>" +
                    res[i].name + "</option>";
            });
            $("#zoneListinarea").html(str);
        });

}

/*
 * for add area in area
 */

function addEditArea() {

    var countryId = $('#countryListinarea').val();
    var stateId = $('#stateListinarea').val();
    var cityId = $('#cityListinarea').val();
    var zoneId = $('#zoneListinarea').val();
    var areaName = $("#areaNameinarea").val();

    /*
     * for validation
     */

    var country_label = $("#country_labelinarea").text();
    var country_field = country_label.substring(0, country_label
        .lastIndexOf(" "));

    var state_label = $("#state_labelinarea").text();
    var state_field = state_label.substring(0, state_label.lastIndexOf(" "));

    var city_label = $("#city_labelinarea").text();
    var city_field = city_label.substring(0, city_label.lastIndexOf(" "));

    var zone_label = $("#zone_labelinarea").text();
    var zone_field = zone_label.substring(0, zone_label.lastIndexOf(" "));

    var name_label = $("#areaname_labelinarea").text();
    var name_field = name_label.substring(0, name_label.lastIndexOf(" "));

    var field_names = [
        ["countryListinarea", country_field],
        ["stateListinarea", state_field],
        ["cityListinarea", city_field],
        ["zoneListinarea", zone_field],
        ["areaNameinarea", name_field]
    ];

    if (fieldValidationWithAlertDivId(field_names, "alertMsginarea") > 0) {

    } else {

        var commonResultObj = {};
        commonResultObj.countryId = countryId;
        commonResultObj.stateId = stateId;
        commonResultObj.cityId = cityId;
        commonResultObj.zoneId = zoneId;
        commonResultObj.name = areaName;

        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/addarea.htm",
            commonResultObj,
            function(response) {
                $('#pleasewaitModal').modal('hide');
                var status = JSON.parse(response);
                chngeResultStatForNewItem(status);
                $('#areaAddEditModal').modal('hide');

                var newarea = "<option value='" + status.id + "'>" +
                    areaName + "</option>";
                $("#AreaId").append(newarea);
                $("#AreaId").val(status.id);
            });

    } // end else

}