<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>:. POS :: Voucher Entry  :.</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME ICONS  -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet" />
   <link rel="icon" id="favicon" href="${pageContext.request.contextPath}/assets/images/title/fb.png">
   <link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/datepicker.css"
	rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css"
	rel="stylesheet" />

     <!-- HTML5 Shiv and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style type="text/css">
    .ui-autocomplete {
    overflow-y: scroll; max-height: 250px; width: 300px; word-break: break-all; z-index: 2150000000 !important;
}
.modal:nth-of-type(even) {
    z-index: 1042 !important;
}
.modal-backdrop.in:nth-of-type(even) {
    z-index: 1041 !important;
}
.modal_body{
background: #404040;
 border-top: 1px solid #404040;
  color: #fff;
}
</style>
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"></jsp:include>
    <c:set var="today" value="<%=new java.util.Date()%>" />
    <div class="content-wrapper">
        <div class="container-fluid">
        <div class="row">
             <jsp:include page="/pages/accounts/accountleftpanel.jsp"></jsp:include>
	        <div class="col-md-10 col-sm-10">
            <%--  <div class="row" style="color:white; margin-left: 0%;">
<center><h4>Voucher Entry </h4></center>
             </div> --%>

             <div class="row" style="color:white; margin-left: 0%;">
				<div class="col-lg-5">
           		  <form  action="loadaccntjrl.htm" method="post" id="entry" >
						<div class="form-group">

                              			<label class="col-sm-3 control-label"><spring:message code="accgroup.jsp.journaltype" text="Journal Type" /><span class="required_star">*</span></label>
                              			<div class="col-sm-5">

                              			<select class="form-control" name="qs"  id="qs"  onchange="entry.submit()">
										<option value="0">Select</option>

									 <c:forEach items="${entypelist}" var="el">

									 <c:if test="${qs==el.journal_type}">
									  <option value="${el.journal_type}" selected >${el.description}</option>

									 </c:if>
								 	 <c:if test="${qs!=el.journal_type}">
									  <option value="${el.journal_type}"  >${el.description}</option>

									 </c:if>


									 </c:forEach>




									</select>

                              			</div>
                          			</div>
						</form>
						</div>
						<div class="col-lg-7">

						<div class="pull-right" style="margin-right: 5%;">

								<button class="btn btn-primary" type="button" onclick="javascript:openAddEditModal(0,'','','',0)"><i class="fa fa-plus"></i>&nbsp;<spring:message code="cmn.jsp.btn.add" text="Add" /></button>

						</div>
						</div>

            		 </div>
            		 <br>
            		<div class="row" style="color:white;margin-left: 0%;">
 				<div class="table-responsive" style="    overflow-y: scroll;height: 446px; width: 1116px;">
            		<table id="example" class="table table-bordered  table-condensed  display" cellspacing="0" width="100%">
				<thead>
					<tr>
						<th><spring:message code="accgroup.jsp.date" text="Date" /></th>

						<th><spring:message code="accgroup.jsp.voucherno" text="Voucher No." /></th>
						<th><spring:message code="accgroup.jsp.narration" text="Narration" /></th>
						<th><spring:message code="accgroup.jsp.debitamount" text="Debit Amount" />&nbsp;(${cur})</th>
						<th><spring:message code="accgroup.jsp.creditamount" text="Credit Amount" />&nbsp;(${cur})</th>
						<th><spring:message code="cmn.jsp.tblhdr.action" text="Action" /></th>
					</tr>
				</thead>

				<tbody>
					<c:if test="${!empty journallist }">
					<c:forEach items="${journallist}" var="jl" varStatus="index">
						<tr>
						<td>${jl.inv_date}</td>
						<td>${jl.inv_no}</td>
						<td>${jl.narration}</td>
						<td>
						<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${jl.dr_amount}" />

						</td>
						<td>
						<fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${jl.cr_amount}" />

						</td>
						<td>

								<button class="btn btn-info btn-xs" style="background: #72BB4F;     color: white;font-weight: bold;" type="button" onclick="javascript:openAddEditModal(${jl.id})"><i class="fa fa-pencil"></i>&nbsp;<spring:message code="cmn.jsp.btn.edit" text="Edit" /></button>


								<button class="btn btn-theme04 btn-xs"  style="background-color: #ff0000b8;" type="button" onclick="showJournalDelModal(${jl.id})"><i class="fa fa-trash-o "></i>&nbsp;<spring:message code="cmn.jsp.btn.dlt" text="Delete" /></button>

							 <c:if test="${qs=='PAY'||qs=='REC'}">
								<button class="btn btn-success  btn-xs" type="button"  onclick="window.location.href='${pageContext.request.contextPath}/accntenty/paymentcashprintjv/${jl.id}/type/${qs}.htm'"><i class="fa fa-print" ></i>&nbsp;<spring:message code="cmn.jsp.btn.print" text="Print" /></button>
							 </c:if>
						</td>
					</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
			</div>

           </div>

	      </div>
      <!--./ end col -10  -->
  </div>
  <!--./ end row of first   -->
<!-- Confirm Message Modal Starts -->


<div class="modal fade" id="confirmMessageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false"  style="    margin-top: 3%;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"  style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
				<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
				<h4 class="modal-title" id="myModalLabel">
					<spring:message code="footer.jsp.alert" text="Alert!" />
				</h4>
			</div>
			<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;" >
				<div id="confirmmessagecont"></div>
				<input type="hidden" id="confirmval" value="">
				<input type="hidden" id="cnfrmCustName" />
			</div>
			<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; color: #fff;" >
				<button type="button" onclick="targetURL()" data-dismiss="modal" class="btn btn-theme">
					<spring:message code="footer.jsp.btn.ok" text="OK" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- Confirm Message Modal ends -->

<!-- Confirm Modal Start -->

<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="    margin-top: 3%;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
				<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
				<h4 class="modal-title" id="myModalLabel">
					<spring:message code="footer.jsp.confrmation" text="Confirmation!"></spring:message>
				</h4>
			</div>
			<div class="modal-body"  style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<spring:message code="footer.jsp.cnfrmquestion" text="Are you sure?" />
				<input type="hidden" id="confirmId" value="">
			</div>
			<div class="modal-footer"  style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<button type="button" class="btn btn-default" data-dismiss="modal" id="cnfrm_cancel_btn">
					<spring:message code="footer.jsp.btn.cancel" text="Cancel" />
				</button>
				<button type="button" onclick="DoConfirm()" data-dismiss="modal" class="btn btn-theme">
					<spring:message code="footer.jsp.btn.ok" text="OK" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- Confirm Modal end -->
<!-- Add/Edit accSetupAddEditModal Modal Starts -->

	<div class="modal fade" id="legersetupmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="margin-top: 3%;">
	<div class="modal-dialog" style="width: 1043px;">
		<div class="modal-content">
			<div class="modal-header"  style="background: #939393; color: #fff; border-bottom: 1px solid #939393;" >
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel"><span id="accountheadertext"></span></h4>
			</div>
			<div class="modal-body modal_body"   id="AccountSetupModalBody">
		      <div class="row"  style="margin-left: 1%;margin-right: 1%;">
		           <div class="col-md-6 col-sm-12" style="  margin-left: -1%; margin-right: 1%;">

					<div class="form-horizontal">

					<!-- this for accountName -->
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="accountName_label"><spring:message code="accsetup.jsp.partyaccountname" text="Account Name" /> <span class="required_star">*</span></label>
							<div class="col-sm-8">
								<input type="hidden" value="" id="accountId" name="id">
								<input type="text" value="" id="accountNameId" class="form-control" onblur="checkSameItem()" name="accountName" placeholder="<spring:message code="accsetup.jsp.partyaccountname" text="Item Name" />">
							</div>
						</div>
						<!-- this for accont Name exist -->
						<div class="form-group" id="accountname" style="display: none;">
						<div class="col-sm-4"></div>
						<div class="col-sm-8">
							<div class="alert alert-danger">
								<strong><spring:message code="footer.jsp.alert" text="Alert!" /></strong>
								<spring:message code="accsetup.jsp.accountexist" text="Account Name already exist, please try other." />
							</div>
							</div>
						</div>
						<!-- this for Alias Name -->
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="alias_label"><spring:message code="accsetup.jsp.Alias" text="Alias Name" /></label>
							<div class="col-sm-8">
								<input type="text" value="" id="aliasNameId" class="form-control" name="aliasName" placeholder="<spring:message code="accsetup.jsp.Alias" text="Alias Name" />">
							</div>
						</div>




					<!-- this for account Group Name -->
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="accountGroup_label"><spring:message code="accsetup.jsp.accountgroupname" text="Account Group Name" /> <span class="required_star">*</span></label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control"   name="accountGroupName" id="accountGroupNameId">

									</select>
									<div class="input-group-btn">
										<button class="btn btn-primary btn-sm" type="button" style="padding: 7px;" onclick="openAddAccoutGroupModal()">
											<i class="fa fa-plus"></i>
										</button>
									</div>
								</div>
							</div>
						</div>

							 <!--  Opening Balance   Here    -->
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label"><spring:message code="accsetup.jsp.openingbalance" text="Opening Balance" />(${cur})</label>
							<div class="col-sm-8">
								<input type="text" id="openingBalanceId"  onkeydown="numcheck(event)"  value="" class="form-control" name="openingBalanceName" placeholder="<spring:message code="accsetup.jsp.openingbalance" text="Opening Balance" />(${cur})">
							</div>
						</div>

					 	 <!--  (DR/CR)   Here    -->
					  <div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label"><spring:message code="accsetup.jsp.crdr" text="Dr/Cr" /></label>
							<div class="col-sm-8">
								<select class="form-control" name="cr_dr" id="cr_dr" >

										         <option value="2">Dr</option>
										         <option value="1">Cr</option>

									</select>

									<span  style="color: indianred;"> Assets / Expenses always have Dr balance and Liabilities / Incomes always have Cr balance</span>

							</div>


						</div>
							 <!--  Credit limit or Debit Limit   Here    -->

						  <div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="creditdebitlimit"><spring:message code="accsetup.jsp.creditlimitordebitlimit" text="Credit limit or Debit Limit" /></label>
							<div class="col-sm-8">
								<input type="text" id="crditlimitId" onkeydown="numcheck(event)" class="form-control" name="crditlimitName" placeholder="<spring:message code="accsetup.jsp.creditlimitordebitlimit" text="Credit limit or Debit Limit" />">
							</div>
						</div>



					<!--   first  colum start end   -->

	 				<div class="form-group hide" id="dueDays_label">
								<label class="col-sm-4 col-sm-4 control-label" id="dueDays_label"><spring:message code="vendor.jsp.duedays" text="Due days" /></label>
								<div class="col-sm-8">
									<input type="text" id="dueDays" class="form-control" placeholder="<spring:message code="vendor.jsp.duedays" text="Due days" />" />
								</div>
							</div>
							<div class="form-group hide"   id="duePer_label">
								<label class="col-sm-4 col-sm-4 control-label" id="duePer_label"><spring:message code="vendor.jsp.dueperc" text="Due(%)" /></label>
								<div class="col-sm-8">
									<input type="text" id="duePer" class="form-control" placeholder="Due Percentage" />
								</div>
							</div>



					</div>
				</div>

				<!--  first  colum start end  -->
				<!--   2 nd colum start here  -->
				  <div class="col-md-6 col-sm-12">
					<div class="form-horizontal">
					 <!-- email id  -->
				 	<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="email_label"><spring:message code="manufacturer.jsp.email" text="Email" /></label>
							<div class="col-sm-8">
								<input type="text" id="emailid" value="" class="form-control" name="emailid" placeholder="<spring:message code="manufacturer.jsp.email" text="Email" />">
							</div>
						</div>
						<!--  Cash Discount Persentage Here    -->

						  <div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="cashdiscountpercentage"><spring:message code="accsetup.jsp.cashdiscountpersentage" text="Cash Discount %" />  </label>
							<div class="col-sm-8">
								<input type="text" id="cashDiscountPersentageId" onkeydown="numcheck(event)"     class="form-control" name="cashDiscountPersentageName" placeholder="<spring:message code="accsetup.jsp.cashdiscountpersentage" text="Cash Discount %" />">
							</div>
						</div>

					  	<!-- phone  Number-->
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="phone_label"><spring:message code="dctr.jsp.phn" text="Phone No." /></label>
							<div class="col-sm-8">
								<input type="text" id="phoneno" value=""   maxlength="15" class="form-control" name="phonenumber" placeholder="<spring:message code="dctr.jsp.phn" text="Phone No." />">
							</div>
						</div>
					 		 	<!--  Pan Number here    -->
					 	<div class="form-group ">
							<label class="col-sm-4 col-sm-4 control-label" id="pan_label"><spring:message code="accsetup.jsp.panno" text="PAN No." /> </label>
							<div class="col-sm-8">
								<input type="text" id="panNoId"  maxlength="20" value="" class="form-control" name="panNo" placeholder="<spring:message code="accsetup.jsp.panno" text="PAN No." />">
							</div>
						</div>

						<!-- this for country name  -->
						<%-- <div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="state_label"><spring:message code="dctr.jsp.country" text="Country" /> </label>
							<div class="col-sm-8">
						<!-- 		<div class="input-group"> -->
									<select class="form-control" name="countryName" id="countryId"  onchange="getStateByCountry();">
										<option value="0">Select...</option>
									<!-- 	<option value="101">india...</option> -->
									  <c:if test="${!empty contrylist}">
											<c:forEach items="${contrylist}" var="allcountry">
												<option value="${allcountry.id}">${allcountry.name}</option>
											</c:forEach>
										</c:if>
									</select>
									<!-- <div class="input-group-btn">
										<button class="btn btn-primary btn-sm" type="button" style="padding: 7px;" onclick="openSchMod()">
											<i class="fa fa-plus"></i>
										</button>
									</div> -->
								<!-- </div> -->
							</div>
						</div> --%>
					<!-- this for stateName  -->
						<%-- <div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="state_label"><spring:message code="accsetup.jsp.state" text="State" /> </label>
							<div class="col-sm-8">

									<select class="form-control" name="stateName" id="stateId" onChange="getCityByState()">


									</select>
									<!-- <div class="input-group-btn">
										<button class="btn btn-primary btn-sm" type="button" style="padding: 7px;" onclick="openSchMod()">
											<i class="fa fa-plus"></i>
										</button>
									</div> -->

							</div>
						</div> --%>

							<!-- this for CityName  -->
				<%--  <div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="city_label"><spring:message code="accsetup.jsp.city" text="City" /> </label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" name="cityName" id="cityId" onChange="getZoneByCity()">

									</select>
									<div class="input-group-btn">
										<button class="btn btn-primary btn-sm" type="button" style="padding: 7px;" onclick="openCityModel()">
											<i class="fa fa-plus"></i>
										</button>
									</div>
								</div>
							</div>
						</div> --%>

					 	<!-- this for Association Zonal Name  -->
				<%--  <div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="zonal_label"><spring:message code="accsetup.jsp.associationzonalname" text="Zonal Name" /> </label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" name="ZonalName" id="ZonalNameID" onChange="getAreaByZoneid();">

									</select>
									<div class="input-group-btn">
										<button class="btn btn-primary btn-sm" type="button" style="padding: 7px;" onclick="openZoneModel()">
											<i class="fa fa-plus"></i>
										</button>
									</div>
								</div>
							</div>
						</div> --%>

					 	 	<!-- this for Area    -->
				<%--  <div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="area_label"><spring:message code="accsetup.jsp.area" text="Area" /> </label>
							<div class="col-sm-8">
								<div class="input-group">
									<select class="form-control" name="AreaName" id="AreaId">

									</select>
									<div class="input-group-btn">
										<button class="btn btn-primary btn-sm" type="button" style="padding: 7px;" onclick="openAreaModal()">
											<i class="fa fa-plus"></i>
										</button>
									</div>
								</div>
							</div>
						</div> --%>


					 <!-- pin number -->
						<%-- <div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="email_label"><spring:message code="dctr.jsp.pin" text="Pin" /></label>
							<div class="col-sm-8">
								<input type="text" id="pinno" maxlength="6" value="" class="form-control" name="pinnumer" placeholder="<spring:message code="dctr.jsp.pin" text="Pin" />">
							</div>
						</div> --%>
					 	 <!--address -->
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="addressid_label"><spring:message code="dctr.jsp.address" text="Address" /></label>
							<div class="col-sm-8">
								 <textarea  class="form-control"  id="addressid" name="addressid" placeholder="<spring:message code="dctr.jsp.address" text="Address" />"></textarea>
							</div>
						</div>
					<%--   <!-- is active   -->
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label" id="isactive_label"><spring:message code="accsetup.jsp.isactive" text="GST Reg. Number" /></label>
							<div class="col-sm-8">
							 <input type="checkbox"  onclick="gstcheck()" name="isactive" value="1" id="isactive" checked>

							</div>
						</div> --%>

						<!-- GST Number-->
						<div class="form-group" id="gstnum">
							<label class="col-sm-4 col-sm-4 control-label" id="gstreg_label">${gsttext}&nbsp;<%-- <spring:message code="accsetup.jsp.gstregistrationnumber" text="GST Reg. Number" /> --%></label>
							<div class="col-sm-8">
								<input type="text" id="GSTRegistrationNumberId" value="" class="form-control" name="GSTRegistrationNumberName" placeholder="${gsttext}">
							</div>
						</div>


						<%-- <!--  Pan Number here    -->
						<div class="form-group ">
							<label class="col-sm-4 col-sm-4 control-label" id="dlno_label"><spring:message code="accsetup.jsp.dlNo" text="D.L No." />  </label>
							<div class="col-sm-8">
								<input type="text" id="DLnoId"  value="" class="form-control" name="DLNo" placeholder="<spring:message code="accsetup.jsp.dlNo" text="D.L No." />">
							</div>
						</div> --%>




						<%--  	<!--  Above Scheme  Here    -->
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label"><spring:message code="accsetup.jsp.abovescheme" text="Above Scheme" /></label>
							<div class="col-sm-8">
								<input type="text" id="aboveSchemeId" name="aboveScheme" class="form-control" placeholder="<spring:message code="accsetup.jsp.abovescheme" text="Above Scheme" />" >
							</div>
						</div> --%>

					<%-- 		<!-- extra discount here    -->
						<div class="form-group hide" id="extradiscountfield">
							<label class="col-sm-4 col-sm-4 control-label" id="extra_discount_label"><spring:message code="accsetup.jsp.extradicount" text="Extra Discount" /></label>
							<div class="col-sm-8">
								<input type="text" id="extra_discount" name="extra_discount"" class="form-control" placeholder="<spring:message code="accsetup.jsp.extradicount" text="Extra Discount" />" >
							</div>
						</div>
						 --%>








					 	<%--  <!--  Due Day  Here    -->
						<div class="form-group hide">
							<label class="col-sm-4 col-sm-4 control-label"><spring:message code="accsetup.jsp.dueday" text="Due Day" /></label>
							<div class="col-sm-8">
								<input type="text" id="dueday" value="" class="form-control" name="duedayName" placeholder="<spring:message code="accsetup.jsp.dueday" text="Due Day" />">
							</div>
						</div> --%>
					 	<%--  <!--  BCDA registration Number Here    -->
						<div class="form-group">
							<label class="col-sm-4 col-sm-4 control-label"><spring:message code="accsetup.jsp.bcdaregno" text="BCDA Reg. Number" /></label>
							<div class="col-sm-8">
								<input type="text" id="BCDAregistrationNumberId" value="" class="form-control" name="BCDAregistrationNumber" placeholder="<spring:message code="accsetup.jsp.bcdaregno" text="BCDA Reg. Number" />">
							</div>
						</div> --%>



					</div>
				</div>
				</div>
			</div>
			<div class="modal-footer modal_body" style="border-top: 0px solid #e5e5e5;">
				<div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="alertMsgAccountSetup"></div>
				<button type="button"  style="background: #F60; font-weight: bold;"  class="btn btn-default" data-dismiss="modal">
					<spring:message code="cmn.jsp.btn.close" text="Close" />
				</button>
				<button class="btn btn-primary"  style="background: #72BB4F; font-weight: bold;" type="button" id="accountsave" onclick="javascript:addnewAccountSetup()">

		        <spring:message code="cmn.jsp.btn.save" text="SAVE" />
				</button>
				<%-- <button class="btn btn-info " type="button" id="accountupdate" onclick="javascript:addnewAccountSetup()">
					<i class="fa fa-pencil"></i>
					<spring:message code="cmn.jsp.btn.update" text="Update" />
				</button> --%>

			</div>
		</div>
	</div>
</div>

				<!-- Add/Edit accSetupAddEditModal Modal Ends -->



<!-- Add/Edit journalAddEditModal Modal Starts -->

					<div class="modal fade" id="journalAddEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false"  style="margin-top: 3%;">
						  <div class="modal-dialog" style="width: 1000px;">
						    <div class="modal-content">
						      <div class="modal-header"  style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						       <button type="button" class="close" data-dismiss="modal" onclick="removetable()" aria-hidden="true">&times;</button>
						        <h4 class="modal-title" id="myModalLabel">
						        	<span id="headertext"></span>
						        </h4>
						      </div>
						      <div class="modal-body"  style="background: #404040; border-top: 1px solid #404040; color: #fff;">

						      <div class="row" style=" margin-left: 1%; margin-right: 1%;">
						      <div class="col-sm-12">

						         <div class="form-vertical">
						                <!--  for entry date  -->

						                <input type="hidden" id="journal_id" value="0">
						        	<div class="form-group">
                              			<label class="col-sm-2 col-sm-2 control-label"><spring:message code="accgroup.jsp.journaltype" text="Journal Type" /><span class="required_star">*</span></label>
                              			<div class="col-sm-4">

                              			<select class="form-control" name="entry_type"  id="entry_type" >
										<option value="0">Select</option>
									 <c:forEach items="${entypelist}" var="el">

								 	 <option value="${el.journal_type}">${el.description}</option>


									 </c:forEach>




									</select>
                              		    	<%-- <input type="hidden" id="journal_type_id" class="form-control" value="${entypelist.journal_type_id}">
                                  			<input type="text" id="journaldes" class="form-control" value="${entypelist.description}"> --%>
                              			</div>
                          			</div>
						        <!--  for entry date  -->
						        	<div class="form-group">
                              			<label class="col-sm-2 col-sm-2 control-label"><spring:message code="accgroup.jsp.selecdate" text="Entry Date" /></label>
                              			<div class="col-sm-4">
                                  			<input type="text" id="entrydate" class="form-control">
                              			</div>







                          			</div>

                          			<!--  for name  -->
                          			<div class="form-group">
                              			<label class="col-sm-2 col-sm-2 control-label"><spring:message code="accgroup.jsp.voucherno" text="Voucher No." /></label>
                              			<div class="col-sm-4">
                                  			<input type="text" id="voucherno" placeholder="<spring:message code="accgroup.jsp.jurnalname" text="Enter name" /> " class="form-control">
                              			</div>
                          			</div>

						        </div>
						      </div>


						      </div>

						    <div class="clearfix"></div>

					<div class="row" style=" margin-left: 1%; margin-right: 1%;">
						<div class="col-sm-4"></div>
							<div class="col-sm-4"> </div>
								<div class="col-sm-4"></div>
					</div>


						       <div class="row" style=" margin-left: 1%; margin-right: 1%;">

						       <div class="col-sm-12">
						       <div class="table-responsive">
						      <!-- for table start  -->

						   <input type="hidden" id="last_indx" value="2"/>

    				 <table  class="table "  border="1" id="data_table" style="margin-top:10px;" >
    				  <tbody id="dyna_table">
						<tr id="tr_head">
					<%-- <th><spring:message code="accgroup.jsp.dr_cr" text="Dr/Cr" /></th> --%>
						<th><spring:message code="accgroup.jsp.Ledger" text="Ledger" /> </th>
						<th><spring:message code="accgroup.jsp.dr_amount" text="Dr Amount" /> 	(${cur})</th>
						<th><spring:message code="accgroup.jsp.cr_amount" text="Cr Amount" />	(${cur}) </th>


				<%-- 		<th><spring:message code="accgroup.jsp.current_balance" text="Cur Balance" /> </th> --%>
							<th>Action </th>
						</tr>

						<tr id="row1">
					<!-- 	<td >

						<select class="form-control-trx" name="cr_dr" id="cr_dr">
						<option value="2">Dr</option>
						<option value="1">Cr</option>
						</select></td> -->
						<td >

						<input type="hidden" name="acc_leger_ids" id="acc_leger_id_1"  value="0">


						       <div class="input-group ">
						           <input type="text" id="ledger_id_1" placeholder="type 2 character"  onkeyup="searchledger(1)" name="ledgername" class="form-control">
      										<div class="input-group-btn">
										   <button class="btn btn-primary form-control" type="button" style="padding: 7px;" onclick="addledgeraccount(1)"> <i class="fa fa-plus"></i>
										  </button>
									</div>
   								</div>




						</td>
						<td ><input type="text" id="dr_amount_1"  placeholder='Debit amount'  onkeyup="dramount(1)"  onkeydown="numcheck(event)"   name="dr_amount" class="form-control"></td>
						<td ><input type="text" id="cr_amount_1"   placeholder='Credit amount' onkeyup="cramount(1)"  onkeydown="numcheck(event)"   name="cr_amount" class="form-control"></td>

				<!-- 	    <td ><span id="cur_balance_2"></span></td> -->

						<td>

						  <input type="button" class="btn btn-primary" onclick="add_row();" value="Add Row">
				<!-- 		<input type="button" value="Delete" class="delete" onclick="delete_row('1')">
 -->						</td>



						</tr>

						<tr id="row2">
					<!-- 	<td id="name_row2"><select class="form-control-trx" name="cr_dr" id="cr_dr">
						<option value="2">Dr</option>
						<option value="1">Cr</option>
						</select></td> -->
						<td>
									<input type="hidden" name="acc_leger_ids" id="acc_leger_id_2"  value="0">





						    <div class="input-group ">
						       <input type="text" id="ledger_id_2" placeholder="type 2 character" onkeyup="searchledger(2)" name="ledgername" class="form-control">
      										<div class="input-group-btn">
										   <button class="btn btn-primary form-control" type="button" style="padding: 7px;" onclick="addledgeraccount(2)"> <i class="fa fa-plus"></i>
										  </button>
									</div>
   								</div>



						</td>
						<td><input type="text" id="dr_amount_2"  placeholder='Debit amount'  onkeyup="dramount(2)"  onkeydown="numcheck(event)"  name="dr_amount" class="form-control"></td>
						<td><input type="text" id="cr_amount_2"   placeholder='Credit amount' onkeyup="cramount(2)"  onkeydown="numcheck(event)"   name="cr_amount" class="form-control"></td>
						 <!-- <td ><span id="cur_balance_2"></span></td> -->
						<td>

						 <input type="button" class="btn btn-primary" onclick="add_row();" value="Add Row">
			 	      <input type="button"  value="Delete"  class="btn btn-danger" onclick="delete_row('2')">
						</td>
						</tr>
						 </tbody>
						<tfoot>
    					<tr>
  				 	 <td colspan="1"> Total</td>

						<td>

						<input type="hidden" id="final_dr_amt" value="0">
						<span id="dr_total"></span>


						</td>
						<td>
						<input type="hidden" id="final_cr_amt" value="0">
						<span id="cr_total"></span></td>
						<td><span id=""></span></td>
					<!-- 	<td></td> -->

  								 </tr>
  						<tr>
  				 	 <td colspan="1"> Difference</td>

						<td>

						<span id="dif_dr"></span>


						</td>
						<td>

						<span id="dif_cr"></span></td>
						<td> </td>


  								 </tr>

 						 </tfoot>


						</table>
					</div>
						       </div>

						</div>



						<div class="row" style=" margin-left: 1%; margin-right: 1%;">
						  <div class="col-sm-12">

                              			<label ><spring:message code="accgroup.jsp.narration" text="Narration" /> <span class="required_star">*</span></label>

                              			<textarea id="narration" class="form-control" rows="4"  placeholder="example Cash A/c Dr. 50,000   to Capital A/c 50,000"></textarea>
                              	<span id="journalerro" style="color: #00ffd2;"></span>
                          			</div>


					     </div>



						        <input type="hidden" id="accGroupId" value="">
						        <div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="alertMsg"></div>
						      </div>
						      <div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						        <button type="button"  style="background: #F60; font-weight: bold;" class="btn btn-default" data-dismiss="modal"  onclick="removetable()"><spring:message code="cmn.jsp.btn.close" text="Close" /></button>


						        <button id="acc_group"  style="background: #72BB4F; font-weight: bold;" type="button" onclick="javascript:addEditjournal()" class="btn btn-theme"><spring:message code="cmn.jsp.btn.save" text="SAVE" /></button>





						      </div>
						    </div>
						  </div>
				</div>

				<!-- Add/Edit journal modal  Ends -->
					<!-- Add/Edit accgrourpmodal Modal Starts -->

					<div class="modal fade" id="accgrourpmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="margin-top: 3%;">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header"   style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						        <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
						        <h4 class="modal-title" id="myModalLabel">
						        	<span id="accountgroupmodal"></span>
						        </h4>
						      </div>
						      <div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						        <div class="form-horizontal">
						        	<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="acctypeid_label"><spring:message code="accgroup.jsp.acctype.name" text="Account Type" /> <span class="required_star">*</span></label>
                              			<div class="col-sm-8">
                              				<select id="accTypeList" class="form-control">
                              					<option value="0.0">Select</option>
                              					<c:if test="${!empty allAccTypes}">
                              						<c:forEach items="${allAccTypes}" var="allAccType">
                              							<option value="${allAccType.id}">${allAccType.typeName}</option>
                              						</c:forEach>
                              					</c:if>
                              				</select>
                              			</div>
                          			</div>
						        	<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="accgrpname_label"><spring:message code="accgroup.jsp.name" text="Name" /> <span class="required_star">*</span></label>
                              			<div class="col-sm-8">
                                  			<input type="text" id="accGroupName" class="form-control">
                              			</div>
                          			</div>
                          			<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="name_label2"><spring:message code="accgroup.jsp.code" text="Code" /><span class="required_star">*</span></label>
                              			<div class="col-sm-8">
                                  			<input type="text" id="accGroupCode" class="form-control">
                              			</div>
                          			</div>
                          			<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label"><spring:message code="accgroup.jsp.desc" text="Description" /></label>
                              			<div class="col-sm-8">
                                  			<input type="text" id="accGroupDesc" class="form-control">
                              			</div>
                          			</div>
						        </div>
						        <input type="hidden" id="accGroupId" value="">
						        <div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="groupalertMsg"></div>
						      </div>
						      <div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						        <button type="button" class="btn btn-default" data-dismiss="modal"  style="background: #F60; font-weight: bold;" ><spring:message code="cmn.jsp.btn.close" text="Close" /></button>
						        <button type="button" onclick="javascript:addEditaccGroup()"  style="background: #72BB4F; font-weight: bold;" class="btn btn-theme"><spring:message code="cmn.jsp.btn.save" text="SAVE" /></button>
						      </div>
						    </div>
						  </div>
				</div>

				<!-- Add/Edit accgrourpmodal Modal Ends -->




  		</div>
  		<!-- ./ container-fluid -->
    </div>
    <!--./ content-wrapper -->
    <!-- CONTENT-WRAPPER SECTION END-->

    <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <script src="${pageContext.request.contextPath}/assets/js/advancebookingScript.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
    <!-- CORE JQUERY SCRIPTS -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
   <script src="${pageContext.request.contextPath}/assets/common/common.js"></script>
    <script src="${pageContext.request.contextPath}/assets/common/moment-with-locales.js"></script>
   <script src="${pageContext.request.contextPath }/assets/js/accounts/journal/journal.js"></script>
   <script type="text/javascript">

   var BASE_URL="${pageContext.request.contextPath}";
   function showJournalDelModal(id)
   {
   	document.getElementById('confirmId').value=id;
   	$('#confirmModal').modal('show');


   }

   $(document).ready(function() {

      /*  $('#example').DataTable({
       	"lengthChange": false
       });
       $(".dataTables_filter input").attr("placeholder", getjournalText.dataTablePlaceHolder);
 */

       var currentDate = new Date();



   	$('#entrydate').datepicker({
   		format : 'yyyy-mm-dd',
   		endDate : currentDate,
   		autoclose : true,
   	});
   	$('#entrydate').val(moment(new Date()).format("YYYY-MM-DD"));

   });

   </script>

   <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
    <%--    <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script> --%>
    </c:when>

    <c:otherwise>
    <%--  <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script> --%>
       	<script src="${pageContext.request.contextPath}/assets/js/accounts/journal/journal_en.js"></script>
         <script src="${pageContext.request.contextPath}/assets/common/common_en.js"></script>


    </c:otherwise>
    </c:choose>

</body>
</html>
