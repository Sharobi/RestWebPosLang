<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html lang="en">
<head>
  <title>Customer Receipt</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

  <style type="text/css">
  	body {
  		font-family: Times New Roman;
  	}
  	.bordereddiv {
  		border:2px solid #000;
  	}
  	.bordertopdiv {
  		border-top:2px solid #000;
  	}

  </style>
</head>
<body id="prdiv">
	<div class="container bordereddiv"  >
		<div class="row">
			<h4 class="text-center" style="font-weight:bold;">${sesloggedinStore.name}</h4>
			<h5 class="text-center">${sesloggedinStore.address}</h5>
			<h5 class="text-center">PHONE: ${sesloggedinStore.phone}</h5>
		</div>
		<div class="row text-center bordertopdiv">
			<table class="table" style="margin-bottom: 0px">
				<tr>
					<td class="text-left"  style=" width:  35%;"><b>Vou. No. :</b>${custDet.invNo}</td>
					<td><b>  <span id="payMode"></span> Receipt</b></td>
					<td class="text-right"  style=" width:  35%;">Date : 
					<b><fmt:parseDate value="${custDet.invDate}" var="paymentInvDate" pattern="MMM dd, yyyy" /> <fmt:formatDate pattern="yyyy-MM-dd" value="${paymentInvDate}" /></b>
					
					
					</td>
				</tr>
			</table>
			<!-- <div class="col-sm-4">Vou. No. :C/R1</div>
			<div class="col-sm-4">Cash Receipt</div>
			<div class="col-sm-4">Date :31/03/2014</div> -->
		</div>
		<div class="row bordertopdiv">
			<div class="col-sm-12">
				<br/>
				<p>Received with thanks from <b>${custDet.customerName}</b> <span id="chequDetails"></span></p>
				<p>The sum of  ${curdes}  <b> is <span id="priceword"></span></b> only </p>
				<p><b>${cur} : ${custDet.payAmount} /-</b></p>
				<p>By <span id="payMode2"></span>   and <b> as on date closing balance  = ${custDet.remainingAmount} </b>/- </p>
			</div>
		</div>
		<div class="row bordertopdiv">
			<div class="col-sm-6">
				Note :${custDet.remarks }
			</div>
			<div class="col-sm-6 text-right">
				For <b>${sesloggedinStore.name}</b>
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
	
	var price=${custDet.payAmount};
	var mode='${custDet.invModeName}';
	 
	if (mode=='Cash') {
		
		document.getElementById("payMode").innerHTML ='Cash';
		document.getElementById("payMode2").innerHTML ='Cash';
	}
	
	if (mode=='Card') {
			
			document.getElementById("payMode").innerHTML ='Bank';
			document.getElementById("payMode2").innerHTML ='Bank';
		}
	if (mode=='Cheque') {
		//chequDetails
		document.getElementById("payMode").innerHTML ='Bank';
		document.getElementById("payMode2").innerHTML ='Bank';
			var chequ_no=${custDet.chequeNo};
			var chequ_date='${custDet.chequeDate}';
			
			document.getElementById("chequDetails").innerHTML ='with cheque no. <b>'+chequ_no+'</b> and Date <b>'+chequ_date+'</b>';	
		
	}

	
		 
	
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
 
     location.href = BASE_URL + '/customer/loadcustomer.htm';
 
		  
	}
	
	printdiv();
	</script>
</body>


</html>