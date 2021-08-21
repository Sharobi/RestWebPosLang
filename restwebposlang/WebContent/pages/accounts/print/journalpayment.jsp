<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<html lang="en">
<head>
  <title>Journal Voucher Payment</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

  <style type="text/css">
  	body {
  		font-family: Times New Roman;
  	}
  	.bordereddiv {
  		border:1px solid #000;
  	}
  	.bordertopdiv {
  		border-top:1px solid #000;
  	}

  	tr,td,th {
  		border-color: #000 !important;
  		border-width: 1px !important;
  	}

  </style>
</head>
<body id="prdiv">
	<div class="container bordereddiv"  >
		<div class="row">
			<h4 class="text-center" style="font-weight:bold;">${store.storeName}</h4>
			<h5 class="text-center">${store.address}</h5>
			<h5 class="text-center">PHONE: ${store.phoneNo}</h5>


<!-- JournalList [entrydate=null, naration=tststs, journallist=[Journal [account_id=195, dr_amount=100.0,
cr_amount=0.0, id=734, inv_no=PAV/18-19/00001, inv_date=2018-04-18, narration=tststs,
 account_name=KOLKATA_TEST11253 - Sundry Creditor], Journal [account_id=137,
  dr_amount=0.0, cr_amount=100.0, id=734, inv_no=PAV/18-19/00001,
  inv_date=2018-04-18, narration=tststs, account_name=CASH IN HAND - Cash in Hand]],
   drtotal=0.0, crtotal=0.0, id=734, inv_no=PAV/18-19/00001, inv_date=2018-04-18,
    companyId=0, storeId=0, createdBy=0, lang=null, finyrId=0, qs=null,
     journal_type_id=9, finyrCode=null, entry_type=PAY] -->
		</div>
		<div class="row text-center bordertopdiv">
			<table style="margin-bottom: 0px; width: 100%; ">
				<tr>
					<td class="text-left"  style=" width:  35%;padding-left: 2%;"><b>Vou. No. :</b> ${ journal.journallist[0].inv_no}</td>
					<td><b>  ${fn:substringBefore(journal.journallist[1].account_name, ' ')} &nbsp; Payment</b></td>
					<td class="text-right"  style=" width:  35%;">Date :  ${ journal.journallist[0].inv_date}

					</td>
				</tr>
			</table>

		</div>

			<div class="row bordertopdiv">
			<div class="col-sm-12" style="padding-left: 2%;">

				<p   >Paid on account of  <b>  &nbsp;  ${fn:substringBefore(journal.journallist[0].account_name, '-')}

				</b> </p>

			</div>
		</div>
		<div class="row ">


				 <table  style="width:100%; margin-bottom: 0;" class="table">
				 <tr>
				    <th width="80%;"  style=" padding-left: 2%; border-right:1px solid #000;"> Particular</th> <th width="20%;"  style="text-align: right;     padding-right: 2%;" > Amount</th>
				 </tr>
				  <tr>
				    <td width="80%;" style=" padding-left: 2%; border-right:1px solid #000;"> ${ journal.journallist[0].narration} <br> <br><br></td> <td width="20%;" style="text-align: right;  padding-right: 2%;" > ${cur} :<fmt:formatNumber type = "number"  maxFractionDigits = "3" value = "${ journal.journallist[0].dr_amount}" />  <br> <br><br></td>
				 </tr>
				  <tr>
				    <td width="80%;"  style=" padding-left: 2%; border-right:1px solid #000;"><b>${cur} . (in words) :</b>  <span id="priceword"></span> only</td> <td width="20%;"  style="text-align: right;  padding-right: 2%;" >${cur} : <fmt:formatNumber type = "number"  maxFractionDigits = "3" value = "${ journal.journallist[0].dr_amount}" /></td>
				 </tr>
				 </table>


		</div>

		<div class="row bordertopdiv">
			<div class="col-sm-6">
				<b>Receiver's Signature</b>
				<br/>
				<br/>
				<br/>
				<br/>
				----------------------
			</div>
			<div class="col-sm-6 text-right">
				For <b>${store.storeName}</b>
				<br/>
				<br/>
				<br/>
				<br/>
				<p>(Authorised Signatory)</p>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	var BASE_URL = "${pageContext.request.contextPath}";

	var price=${journal.journallist[0].dr_amount};


	function convertNumberToWords(amount) {
 	    var words = new Array();
 	    words[0] = '';
 	    words[1] = 'One';
 	    words[2] = 'Two';
 	    words[3] = 'Three';
 	    words[4] = 'Four';
 	    words[5] = 'Five';
 	    words[6] = 'Six';
 	    words[7] = 'Seven';
 	    words[8] = 'Eight';
 	    words[9] = 'Nine';
 	    words[10] = 'Ten';
 	    words[11] = 'Eleven';
 	    words[12] = 'Twelve';
 	    words[13] = 'Thirteen';
 	    words[14] = 'Fourteen';
 	    words[15] = 'Fifteen';
 	    words[16] = 'Sixteen';
 	    words[17] = 'Seventeen';
 	    words[18] = 'Eighteen';
 	    words[19] = 'Nineteen';
 	    words[20] = 'Twenty';
 	    words[30] = 'Thirty';
 	    words[40] = 'Forty';
 	    words[50] = 'Fifty';
 	    words[60] = 'Sixty';
 	    words[70] = 'Seventy';
 	    words[80] = 'Eighty';
 	    words[90] = 'Ninety';
 	    amount = amount.toString();
 	    var atemp = amount.split(".");
 	    var number = atemp[0].split(",").join("");
 	    var n_length = number.length;
 	    var words_string = "";
 	    if (n_length <= 9) {
 	        var n_array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0);
 	        var received_n_array = new Array();
 	        for (var i = 0; i < n_length; i++) {
 	            received_n_array[i] = number.substr(i, 1);
 	        }
 	        for (var i = 9 - n_length, j = 0; i < 9; i++, j++) {
 	            n_array[i] = received_n_array[j];
 	        }
 	        for (var i = 0, j = 1; i < 9; i++, j++) {
 	            if (i == 0 || i == 2 || i == 4 || i == 7) {
 	                if (n_array[i] == 1) {
 	                    n_array[j] = 10 + parseInt(n_array[j]);
 	                    n_array[i] = 0;
 	                }
 	            }
 	        }
 	        value = "";
 	        for (var i = 0; i < 9; i++) {
 	            if (i == 0 || i == 2 || i == 4 || i == 7) {
 	                value = n_array[i] * 10;
 	            } else {
 	                value = n_array[i];
 	            }
 	            if (value != 0) {
 	                words_string += words[value] + " ";
 	            }
 	            if ((i == 1 && value != 0) || (i == 0 && value != 0 && n_array[i + 1] == 0)) {
 	                words_string += "Crores ";
 	            }
 	            if ((i == 3 && value != 0) || (i == 2 && value != 0 && n_array[i + 1] == 0)) {
 	                words_string += "Lakhs ";
 	            }
 	            if ((i == 5 && value != 0) || (i == 4 && value != 0 && n_array[i + 1] == 0)) {
 	                words_string += "Thousand ";
 	            }
 	            if (i == 6 && value != 0 && (n_array[i + 1] != 0 && n_array[i + 2] != 0)) {
 	                words_string += "Hundred and ";
 	            } else if (i == 6 && value != 0) {
 	                words_string += "Hundred ";
 	            }
 	        }
 	        words_string = words_string.split("  ").join(" ");
 	    }
 	    return words_string;
 	}

	document.getElementById("priceword").innerHTML =convertNumberToWords(price);
	function printdiv()
	{

         var divElements = document.getElementById("prdiv").innerHTML;
         var oldPage = document.body.innerHTML;
         //Reset the page's HTML with div's HTML only
         document.body.innerHTML =
           "<html><head><title></title></head><body>" +
           divElements + "</body>";


		   window.print();


	location.href = BASE_URL + '/accntenty/loadaccntjrl.htm';

	}

	printdiv();
	</script>
</body>


</html>