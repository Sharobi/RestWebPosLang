function isEmpty(val) {
    return (val === undefined || val == null || val.length <= 0) ? true : false;
}

var excess = 0;

function getlistofentry() {


}

function openAddEditModal(id) {
    $('#journaldes').attr("disabled", true);
    document.getElementById('alertMsg').innerHTML = '';
    delete_flag = false;
    delete_row_id = 0;
    $('#journalerro').html("");

    if (id == 0) { // add
        $("#headertext").text(getjournalText.headerTextAdd);

        $('#voucherno').attr("disabled", true);
        $('#voucherno').val('');
        $("#entry_type").attr("disabled", false);
        $("#entry_type").val(0);

        var cr_amountlist = document.getElementsByName("cr_amount");
        var table_len = (cr_amountlist.length);

        for (var i = 1; i <= table_len; i++) {

            if (i <= 2) {

                $("#dr_amount_" + i).attr("disabled", false);
                $("#cr_amount_" + i).attr("disabled", false);

                $('#cr_amount_' + i).val('');
                $('#dr_amount_' + i).val('');
                $('#acc_leger_id_' + i).val(0);
                $('#ledger_id_' + i).val('');

            } else {

                document.getElementById("row" + i + "").outerHTML = "";
            }


        }

        $('#final_dr_amt').val('');
        $('#final_cr_amt').val('');
        $('#dr_total').html('');
        $('#cr_total').html('');
        $('#dif_dr').html('');
        $('#dif_cr').html('');
        $('#narration').val('');




    } else { // update
        $("#headertext").text(getjournalText.headerTextUpdate);

        $('#dif_dr').html('');
        $('#dif_cr').html('');

        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjax(BASE_URL + "/accntenty/editjournal/" + id + ".htm", function(response) {
            $('#pleasewaitModal').modal('hide');
            var res = JSON.parse(response);



            /*
             * for common
             */
            $('#journal_type_id').val(res.journal_type_id);
            $('#entrydate').val(moment(res.inv_date).format("YYYY-MM-DD"));
            $('#voucherno').val(res.inv_no);
            $('#voucherno').attr("disabled", true);
            $('#journal_id').val(res.id);

            $('#entry_type').val(res.entry_type);
            $("#entry_type").attr("disabled", true);
            /*
             * for table  for row 1
             */

            // when two or more row here

            var tr_head = document.getElementById("tr_head").innerHTML;




            document.getElementById("dyna_table").innerHTML = "";


            // for counting the total dr and total cr
            var len = res.journallist.length;

            console.log(len);
            var content = "";
            var hidden_id = "";
            var ledger = "";
            var dr_amount = "";
            var cr_amount = "";
            excess = len;
            var delete_row = "";

            var i = 0;
            /*
             * for table row creation
             */

            content = "<tr id='tr_head'>" + tr_head + "</tr>";
            for (var l = 1; l <= len; l++) {

                i = (l - 1);

                hidden_id = "<input type='hidden' name='acc_leger_ids' id='acc_leger_id_" + l + "'  value='" + res.journallist[i].account_id + "'>";


                /*var cr_dr="<select class='form-control-trx' name='cr_dr' id='cr_dr'"+table_len+"><option value='2'>Dr</option><option value='1'>Cr</option></select>";*/
                // var ledger="<input type='text' placeholder='type 2 character' id='ledger_id_"+table_len+"' onkeyup='searchledger("+table_len+")' name='ledgername' class='form-control'>";

                ledger = "<div class='input-group'> <input type='text' id='ledger_id_" + l + "' placeholder='type 2 character'  onkeyup='searchledger(" + l + ")' name='ledgername' class='form-control' value='" + res.journallist[i].account_name + "'>" +
                    "<div class='input-group-btn'> <button class='btn btn-primary form-control' type='button' style='padding: 7px;' onclick='addledgeraccount(" + l + ")'>" +
                    "<i class='fa fa-plus'></i> </button></div></div>";

                if (res.journallist[i].dr_amount == 0) {
                    dr_amount = "<input type='text' disabled value='" + res.journallist[i].dr_amount + "' placeholder='Debit amount' onkeyup='dramount(" + l + ")' onkeydown='numcheck(event)' id='dr_amount_" + l + "' name='dr_amount' class='form-control'>";

                } else {
                    dr_amount = "<input type='text'  value='" + res.journallist[i].dr_amount + "' placeholder='Debit amount' onkeyup='dramount(" + l + ")' onkeydown='numcheck(event)' id='dr_amount_" + l + "' name='dr_amount' class='form-control'>";
                }

                if (res.journallist[i].cr_amount == 0) {
                    cr_amount = "<input type='text' disabled  value='" + res.journallist[i].cr_amount + "'   placeholder='Credit amount'  onkeyup='cramount(" + l + ")' onkeydown='numcheck(event)' id='cr_amount_" + l + "' name='cr_amount' class='form-control'>";
                } else {
                    cr_amount = "<input type='text'  value='" + res.journallist[i].cr_amount + "'   placeholder='Credit amount'  onkeyup='cramount(" + l + ")' onkeydown='numcheck(event)' id='cr_amount_" + l + "' name='cr_amount' class='form-control'>";
                }

                if (l == 1) {
                    delete_row = "<td><input type='button' class='btn btn-primary' onclick='add_row();' value='Add Row'> </td>";
                } else {
                    delete_row = "<td><input type='button' class='btn btn-primary' onclick='add_row();' value='Add Row'> <input type='button' value='Delete' class='btn btn-danger' onclick='delete_row(" + l + ")'></td>"
                }


                /*  var cur_bal="<span id='cur_balance_'"+table_len+"'></span>";*/

                content = content + "<tr id='row" + l + "'><td>" + hidden_id + ledger + "</td> <td>" + dr_amount + "</td><td>" + cr_amount + "</td>" + delete_row + "  </tr>";


            }

            /*
             * for table row insart
             */
            document.getElementById("dyna_table").innerHTML = content;
            var to_dr_amount = 0;
            var to_cr_amount = 0;
            for (var j = 0; j < len; j++) {

                to_dr_amount = parseFloat(to_dr_amount) + parseFloat(res.journallist[j].dr_amount);
                to_cr_amount = parseFloat(to_cr_amount) + parseFloat(res.journallist[j].cr_amount);
            }

            $('#dr_total').html("Total Dr=" + to_dr_amount.toFixed(4));
            $('#final_dr_amt').val(to_dr_amount.toFixed(4));

            $('#cr_total').html("Total Cr=" + to_cr_amount.toFixed(4));
            $('#final_cr_amt').val(to_cr_amount.toFixed(4));


            $('#narration').val(res.naration);

            $('#last_indx').val(++len);


        }, null);




    }




    $('#journalAddEditModal').modal('show');
}


/*
 * for remove table durning new
 */


function removetable() {


    if (excess > 2) {
        for (var s = 3; s <= excess; s++) {

            document.getElementById("row" + s + "").outerHTML = "";
        }

    }



}

function addEditjournal() {
    document.getElementById('alertMsg').innerHTML = '';


    var id = $('#journal_id').val();
    var entry_data = $('#entrydate').val();
    var voucher_no = $('#voucherno').val();
    var ledgers = document.getElementsByName("acc_leger_ids");
    var dr_amounts = document.getElementsByName("dr_amount");
    var cr_amounts = document.getElementsByName("cr_amount");
    var naration = $('#narration').val();

    var entry_type = $('#entry_type').val();


    var final_obj = {};
    final_obj.journallist = [];


    for (var i = 0; i < ledgers.length; i++) {


        var dr_amt = 0;
        var cr_amt = 0;

        if (isEmpty(dr_amounts[i].value)) {
            dr_amt = 0;
        } else {
            dr_amt = dr_amounts[i].value;
        }
        if (isEmpty(cr_amounts[i].value)) {
            cr_amt = 0;
        } else {
            cr_amt = cr_amounts[i].value;
        }



        final_obj.journallist.push({
            account_id: ledgers[i].value,
            dr_amount: dr_amt,
            cr_amount: cr_amt
        });


    }
    final_obj.entrydate = entry_data;
    final_obj.naration = naration;
    final_obj.drtotal = $('#final_dr_amt').val();
    final_obj.crtotal = $('#final_cr_amt').val();
    final_obj.inv_no = $('#voucherno').val();
    final_obj.entry_type = entry_type;

    console.log(JSON.stringify(final_obj));

    /* final_obj.drtotal=entry_data;
     final_obj.crtotal=naration;*/



    $('#journalerro').html("");


    var error = 0;


    if (isEmpty(entry_data)) {
        error = 1;
        $('#journalerro').html("please select date !");

    }

    if (isEmpty(naration)) {

        error = 1;
        $('#journalerro').html("Naration should be  10 charachter !");

    }

    if ($('#final_dr_amt').val() == 0 && $('#final_cr_amt').val() == 0) {
        error = 1;
        $('#journalerro').html("please enter ledger ,dr  amount cr amount!");
    }



    if (entry_type == 0) {
        $('#journalerro').html("please select entry type first");
        error = 1;
    }


    if (final_obj.drtotal == final_obj.crtotal) {

        var ajaxCallObject = new CustomBrowserXMLObject();
        if (id == 0) {


            if (error == 0) {

                ajaxCallObject.callAjaxPost(BASE_URL + "/accntenty/addjournal.htm", final_obj, function(response) {
                    $('#pleasewaitModal').modal('hide');
                    var status = JSON.parse(response);
                    chngeResultStat(status);

                    $('#journalAddEditModal').modal('hide');
                });
            }

        } else // for update
        {
            if (error == 0) {
                final_obj.id = id;




                ajaxCallObject.callAjaxPost(BASE_URL + "/accntenty/updatejournal.htm", final_obj, function(response) {
                    $('#pleasewaitModal').modal('hide');
                    var status = JSON.parse(response);
                    chngeResultStat(status);

                    $('#journalAddEditModal').modal('hide');
                });
            }
        }

    } else {


        $('#journalerro').html("Total debit amount should be equal to credit amount");
        error = 1;
    }




}




function DoConfirm() {
    $('#pleasewaitModal').modal('show');
    var id = document.getElementById('confirmId').value;
    var ajaxCallObject = new CustomBrowserXMLObject();
    ajaxCallObject.callAjax(BASE_URL + "/accntenty/deletejournal/" + id + ".htm", function(response) {
        $('#pleasewaitModal').modal('hide');
        var status = JSON.parse(response);
        chngeResultStat(status);
    }, null);
}

function targetURL() {
    location.href = BASE_URL + '/accntenty/loadaccntjrl.htm';
}


/*
 * for add row journal
 *
 */

var delete_flag = false;
var delete_row_id = 0;
var last = 2;

function delete_row(no) {

    document.getElementById("row" + no + "").outerHTML = "";



    delete_flag = true;
    delete_row_id = no;
    calculation();

}



function add_row() {


    var table = document.getElementById("dyna_table");
    var table_len = (table.rows.length);

    var last = table_len;
    console.log("table len" + table_len + "las" + last);
    $('#last_indx').val(last);


    if (delete_flag == true) {

        for (var w = 1; w < $('#last_indx').val(); w++) {


            if (document.getElementById("row" + w) === null) {

                table_len = w;

                // alert("not exist");
            }
        }
    }




    var hidden_id = "<input type='hidden' name='acc_leger_ids' id='acc_leger_id_" + table_len + "'  value='0'>";


    var ledger = "<div class='input-group'> <input type='text' id='ledger_id_" + table_len + "' placeholder='type 2 character'  onkeyup='searchledger(" + table_len + ")' name='ledgername' class='form-control'>" +
        "<div class='input-group-btn'> <button class='btn btn-primary form-control' type='button' style='padding: 7px;' onclick='addledgeraccount(" + table_len + ")'>" +
        "<i class='fa fa-plus'></i> </button></div></div>";


    var dr_amount = "<input type='text' placeholder='Debit amount' onkeyup='dramount(" + table_len + ")' onkeydown='numcheck(event)' id='dr_amount_" + table_len + "' name='dr_amount' class='form-control'>";
    var cr_amount = "<input type='text'  placeholder='Credit amount'  onkeyup='cramount(" + table_len + ")' onkeydown='numcheck(event)' id='cr_amount_" + table_len + "' name='cr_amount' class='form-control'>";
    /*  var cur_bal="<span id='cur_balance_'"+table_len+"'></span>";*/

    var row = table.insertRow(table_len).outerHTML = "<tr id='row" + table_len + "'><td>" + hidden_id + ledger + "</td> <td>" + dr_amount + "</td><td>" + cr_amount + "</td>   <td><input type='button' class='btn btn-primary' onclick='add_row();' value='Add Row'> <input type='button' value='Delete' class='btn btn-danger' onclick='delete_row(" + table_len + ")'></td></tr>";


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


function cramount(id) {

    if ($('#acc_leger_id_' + id).val() == 0) { // if ladger is empty

        $('#cr_amount_' + id).val('');

        $('#journalerro').html("please enter ledger account first !");
    }

    if (isEmpty($('#cr_amount_' + id).val())) { // if dr row amount is empty

        // for input enable
        $('#dr_amount_' + id).attr("disabled", false);

    } else {

        // block the cr amount
        $('#dr_amount_' + id).attr("disabled", true);
    }



    calculation();

}

function dramount(id) {

    if ($('#acc_leger_id_' + id).val() == 0) { // if ladger is empty

        $('#dr_amount_' + id).val('');

        $('#journalerro').html("please enter ledger account first !");
    }

    if (isEmpty($('#dr_amount_' + id).val())) { // if dr row amount is empty

        // for input enable
        $('#cr_amount_' + id).attr("disabled", false);

    } else {

        // block the cr amount
        $('#cr_amount_' + id).attr("disabled", true);
    }



    calculation();

}



function calculation() {

	   $('#journalerro').html("");

    var last = $('#last_indx').val();
    var cr_amountlist = document.getElementsByName("cr_amount");
    var dr_amountlist = document.getElementsByName("dr_amount");
    var cr_total_amont = 0;
    var dr_total_amont = 0;
    for (var i = 1; i <= last; i++) {


        if (document.getElementById("row" + i) === null) {

            continue;
        }
        if (isEmpty($('#cr_amount_' + i).val())) {
            cr_total_amont = parseFloat(cr_total_amont);
        } else {
            cr_total_amont = parseFloat(cr_total_amont) + parseFloat($('#cr_amount_' + i).val());
        }

        if (isEmpty($('#dr_amount_' + i).val())) {
            dr_total_amont = parseFloat(dr_total_amont);
        } else {
            dr_total_amont = parseFloat(dr_total_amont) + parseFloat($('#dr_amount_' + i).val());
        }


    }


    $('#cr_total').html("Total Cr=" + cr_total_amont.toFixed(4));
    $('#final_cr_amt').val(cr_total_amont.toFixed(4));

    $('#dr_total').html("Total Dr=" + dr_total_amont.toFixed(4));
    $('#final_dr_amt').val(dr_total_amont.toFixed(4));

    diff();
}

function diff() {

    var total_cr_amt = parseFloat($('#final_cr_amt').val());
    var total_dr_amt = parseFloat($('#final_dr_amt').val());

    var dif = 0;


    if (total_dr_amt > total_cr_amt) {

        dif = total_dr_amt - total_cr_amt;

        $('#dif_dr').html(dif.toFixed(4));
        $('#dif_cr').html('');
    }

    if (total_dr_amt < total_cr_amt) {

        dif = total_cr_amt - total_dr_amt;
        $('#dif_cr').html(dif.toFixed(4));
        $('#dif_dr').html('');

    }
    if (total_dr_amt == total_cr_amt) {


        dif = total_cr_amt - total_dr_amt;
        $('#dif_cr').html(dif);
        $('#dif_dr').html(dif);
    }




}


function searchledger(id) {
    var ids = "#ledger_id_" + id;


    if (isEmpty($(ids).val())) {



        $('#acc_leger_id_' + id).val(0);

        $('#dr_amount_' + id).attr("disabled", false);
        $('#cr_amount_' + id).attr("disabled", false);

        $('#dr_amount_' + id).val('');
        $('#cr_amount_' + id).val('');

        dramount(id);
        cramount(id);
        console.log("empty");



    }

    $(ids).autocomplete({
        source: function(request,
            response) {


            if (request.term.length >= 2) {
                $.ajax({
                    url: BASE_URL + "/accntenty/searchledger.htm",
                    type: "POST",
                    data: {
                        tagName: request.term
                    },
                    dataType: "json",
                    success: function(data) {
                        /*	console.log("res_len"+data.length);*/

                        response($.map(data, function(v) {



                            return {
                                label: v.name,
                                itemCode: v.id,
                                //code : v.code
                                items: v
                            };

                        }));
                    },
                    error: function(error) {
                        alert('error: ' + error);
                    }
                });
            }
        },
        select: function(e,
            ui) {
            //		console.log(ui.item.itemCode);
            //		console.log(ui.item.label);

            var table = document.getElementsByName("ledgername");
            var table_len = (table.length);

            console.log(id + "===table_len==" + table_len);
            var exist = 0;


            /*
             * for find the all
             */
            for (var i = 1; i <= table_len; i++) {


                console.log(i);
                if (i == 1 && $('#acc_leger_id_' + i).val() == 0) {
                    continue;
                } else {



                    if ($('#acc_leger_id_' + i).val() == ui.item.itemCode) { // check it already exist
                        exist = 1;

                        console.log("existe");
                        break;
                    }
                }
                console.log(ui.item.itemCode);

            }

            if (exist == 1) {




                setTimeout(function() {

                    $('#journalerro').html("already added ledger account !");
                    $('#ledger_id_' + id).val(null);
                    $('#acc_leger_id_' + id).val(0);
                }, 300);
            } else {

                $('#journalerro').html("");
                $("#acc_leger_id_" + id).val(ui.item.itemCode);
            }



        },
        change: function(e, ui) {
            if (!(ui.item))
                e.target.value = "";
        },
    });
}

/*
 * for ledger setup cale
 */
var row_id = 0;

function addledgeraccount(id) {
    row_id = id;
    $('#accountheadertext').html(getjournalText.legderheader);
    getAccountGroup();
    $('#legersetupmodal').modal('show');


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

    $('#countryId').val(0);
    $('#stateId').val(0);

    $('#cityId').val(0);
    $('#ZonalNameID').val(0);
    $('#AreaId').val(0);
    $('#addressid').val('');

    $('#pinno').val('');

    $('#accountGroupNameId').val(0);

    $('#GSTRegistrationNumberId').val('');
    $('#DLnoId').val('');
    $("#acc_country_id").val(0);



}

/*
 * check the ledger dublicate
 */
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

/*
 * for city list by state_id
 */

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

/*
 * for zone list by city id
 */


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

/*
 * for area list by zone
 */

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


/*
 *
 * add new ledger
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
 * open city model here
 */
function openCityModel() {

    $("#headertextofcity").text(getjournalText.cityadd);

    $('#cityAddEditModal').modal('show');



    if ($('#countryId').val() > 0) {
        $('#countryidincity').val($('#countryId').val());



        var commonResultObj1 = {};

        // for state
        commonResultObj1.countryId = $('#countryidincity').val();

        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getStateByCountry.htm", commonResultObj1,
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
                $('#stateList').val($('#stateId').val());
            });


    } else {


        $('#countryidincity').val(0);
        $('#stateList').val(0);
    }




}


/*
 *  get state list using city country
 */
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

/*
 * add city
 */
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

                if (status.id > 0) {
                    $('#cityAddEditModal').modal('hide');

                    var newcity = "<option value='" + status.id + "'>" +
                        cityName + "</option>";
                    $("#cityId").append(newcity);
                    $("#cityId").val(status.id);
                } else {
                    chngeResultStatForNewItem(status);
                }


            });
    }

}

//===================================================end
/*
 *
 * zone portion start here
 */

function openZoneModel() {

    $("#headertextofzone").text(getjournalText.zoneadd);

    $('#zoneAddEditModal').modal('show');



    if ($('#countryId').val() > 0) {
        $('#countryidinzone').val($('#countryId').val());



        var commonResultObj1 = {};

        // for state
        commonResultObj1.countryId = $('#countryidinzone').val();

        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getStateByCountry.htm", commonResultObj1,
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
                $('#stateListinzone').val($('#stateId').val());

                if ($('#stateId').val() > 0) {

                    // for city
                    commonResultObj1.stateId = $('#stateListinzone').val();

                    var ajaxCallObject = new CustomBrowserXMLObject();
                    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getCityByState.htm", commonResultObj1,
                        function(response) {
                            $('#pleasewaitModal').modal('hide');
                            // console.log(response);
                            var res = JSON.parse(response);
                            var str = "<option value='0'>Select....</option>";
                            $.each(res, function(i) {
                                str = str + "<option value='" + res[i].id + "'>" +
                                    res[i].name + "</option>";
                            });
                            $("#cityListinzone").html(str);
                            $('#cityListinzone').val($('#cityId').val());




                        });

                } else {


                    $('#cityListinzone').val(0);
                }


            });


    } else {


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
                if (status.id > 0) {
                    $('#zoneAddEditModal').modal('hide');

                    var newzone = "<option value='" + status.id + "'>" +
                        zoneName + "</option>";
                    $("#ZonalNameID").append(newzone);
                    $("#ZonalNameID").val(status.id);
                } else {
                    chngeResultStatForNewItem(status);
                }


            });

    }

}

/*
 * open area model here
 *
 *
 */

function openAreaModal() {

    $("#headertextinarea").text(getjournalText.areaadd);

    $('#areaAddEditModal').modal('show');

    if ($('#countryId').val() > 0) {
        $('#countryListinarea').val($('#countryId').val());



        var commonResultObj1 = {};

        // for state
        commonResultObj1.countryId = $('#countryListinarea').val();

        var ajaxCallObject = new CustomBrowserXMLObject();
        ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getStateByCountry.htm", commonResultObj1,
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
                $('#stateListinarea').val($('#stateId').val());

                if ($('#stateId').val() > 0) {

                    // for city
                    commonResultObj1.stateId = $('#stateListinarea').val();

                    var ajaxCallObject = new CustomBrowserXMLObject();
                    ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getCityByState.htm", commonResultObj1,
                        function(response) {
                            $('#pleasewaitModal').modal('hide');
                            // console.log(response);
                            var res = JSON.parse(response);
                            var str = "<option value='0'>Select....</option>";
                            $.each(res, function(i) {
                                str = str + "<option value='" + res[i].id + "'>" +
                                    res[i].name + "</option>";
                            });
                            $("#cityListinarea").html(str);
                            $('#cityListinarea').val($('#cityId').val());




                            if ($('#cityListinarea').val() > 0) {

                                commonResultObj1.cityId = $('#cityListinarea').val();

                                var ajaxCallObject = new CustomBrowserXMLObject();
                                ajaxCallObject.callAjaxPost(BASE_URL + "/invsetup/getzonebycity.htm", commonResultObj1,
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
                                        $('#zoneListinarea').val($('#ZonalNameID').val());
                                        // for area

                                    });
                            } else {
                                $('#zoneListinarea').val(0);
                            }



                        });

                } else {


                    $('#cityListinarea').val(0);

                    $('#stateListinarea').val();
                }


            });


    } else {


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
                if (status.id > 0) {

                    var newarea = "<option value='" + status.id + "'>" +
                        areaName + "</option>";
                    $("#AreaId").append(newarea);
                    $("#AreaId").val(status.id);
                    $('#areaAddEditModal').modal('hide');
                } else {
                    chngeResultStatForNewItem(status);
                }




            });

    } // end else

}
// ===================================================end
/*
 * for openmodal of ledger account setup
 */
function addnewAccountSetup() {
    var id = $('#accountId').val();
    var name = $('#accountNameId').val();
    var code = $('#aliasNameId').val(); // alias
    var group_code = $('#accountGroupNameId').val();
  //  var city_id = $('#cityId').val();
 //   var zone_id = $('#ZonalNameID').val();
  //  var area_id = $('#AreaId').val();
    var address = $('#addressid').val();
  //  var pin = $('#pinno').val();

   var group_name= $("#accountGroupNameId option:selected").text();

  /*  if (isEmpty(pin)) {
        pin = "";
    }*/
    var phone = $('#phoneno').val();
    var email = $('#emailid').val();
    var pan_no = $('#panNoId').val();
    var gst_registration_no = $('#GSTRegistrationNumberId').val();
    /*  var bcda_registration_no = $('#BCDAregistrationNumberId').val();*/
    var dl_no = $('#DLnoId').val();
    var cash_discount_percentage = $('#cashDiscountPersentageId').val();
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


    var name_label = $("#accountName_label").text();
    var name_field = name_label.substring(0, name_label.lastIndexOf(" "));

    var name_label_group = $("#accountGroup_label").text();
    var name_field1 = name_label_group.substring(0, name_label_group
        .lastIndexOf(" "));

    var field_names = [
        ["accountNameId", name_field],
        ["accountGroupNameId", name_field1]
    ];



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
      //  AccSetupMasterObj.cityId = city_id;
      //  AccSetupMasterObj.zoneId = zone_id;
      //  AccSetupMasterObj.areaId = area_id;
        AccSetupMasterObj.address = address;
        //AccSetupMasterObj.pin = pin;
        AccSetupMasterObj.phone = phone;
        AccSetupMasterObj.email = email;
        AccSetupMasterObj.panNo = pan_no;
        AccSetupMasterObj.gstRegistrationNo = gst_registration_no;
        /*  AccSetupMasterObj.bcdaRegistrationNo = bcda_registration_no;*/
        AccSetupMasterObj.dlNo = dl_no;

        AccSetupMasterObj.opBalance = openingbalance;
        AccSetupMasterObj.cashDiscountPercentage = cash_discount_percentage;
        AccSetupMasterObj.transLimit = trans_limit;
        AccSetupMasterObj.asOnDate = moment(new Date()).format('YYYY-MM-DD');
        AccSetupMasterObj.opBalance = openingbalance;

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

                    if (status.id > 0) {

                        $('#acc_leger_id_' + row_id).val(status.id);
                        $('#ledger_id_' + row_id).val(name+"-"+group_name);

                        $('#legersetupmodal').modal('hide');

                        row_id = 0;
                    } else {
                        chngeResultStat(status);
                    }




                });
        }




    }


}




/*
 * for group modal
 */
function openAddAccoutGroupModal() {
    $('#accGroupName').val('');
    $('#accGroupCode').val('');
    $('#accGroupDesc').val('');
    $('#accTypeList').val(0);

    $('#accountgroupmodal').html(getjournalText.groupheader);
    $('#accgrourpmodal').modal('show');

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

    var name_label2 = $('#name_label2').text();
    var name_field2 = name_label2.substring(0, name_label.lastIndexOf(" "));


    var field_names = [
        ["accTypeList", account_type_field],
        ["accGroupName", name_field],
        ["accGroupCode", name_field2],
    ];


    if (fieldValidationWithAlertDivId(field_names, "groupalertMsg") > 0) {} else {



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


                if (status.id > 0) {
                    $('#accgrourpmodal').modal('hide');

                    var newaccntgrou = "<option value='" + status.code + "'>" +
                        name + "</option>";
                    $("#accountGroupNameId").append(newaccntgrou);
                    $("#accountGroupNameId").val(status.code);


                } else {
                    chngeResultStatForNewItem(status);
                }


            });
    }
}