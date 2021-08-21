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
    <title>:. POS :: Account Setup :.</title>
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
			<%-- 	<h3><spring:message code="accgroup.jsp.listofaccount" text="List of Accounts " /></h3> --%>
				<div class="row" style="margin-left: 0%;margin-right: 1%;margin-top: 0%; color:#555;">
					<div class="col-lg-12 " >
					<div class="pull-right">

					<button class="btn btn-primary"  style="background: #72BB4F; font-weight: bold;" type="button" onclick="javascript:openAddEditModal(0,'','',0,0,0,0,0,'','','','','')"><i class="fa fa-plus"></i>&nbsp;<spring:message code="cmn.jsp.btn.add" text="Add" /></button></div>


					</div>

				</div>
	     <div class="row" style="margin-left: 0%;margin-right: 1%;margin-top: 0%; color:#555;">

			 <div class="col-sm-12">

         <div class="table-responsive" style="    overflow-y: scroll;height: 446px;">
			 <table id="example" class="table table-bordered table-condensed  " cellspacing="0" width="100%" style="color: white;">
					<thead>
						<tr>
						 <th><spring:message code="accgroup.jsp.type" text="Account Type" /></th>
							<th><spring:message code="accgroup.jsp.groupname" text="Group Name" /></th>
							<th><spring:message code="accsetup.jsp.partyaccountname" text="Account Name " /></th>
							<th><spring:message code="accsetup.jsp.Alias" text="Alias Name" /></th>
						    <th><spring:message code="accsetup.jsp.openingbalance" text="Opening Balance" /> &nbsp;(${cur})</th>
							<th><spring:message code="accsetup.jsp.crdr" text="DR/CR" /></th>

							<th><spring:message code="cmn.jsp.tblhdr.action" text="Action" /></th>
						</tr>
					</thead>

					<tbody>

					<c:if test="${!empty accountlist }">
						<c:forEach items="${accountlist}" var="ac" varStatus="index">
							<tr>
							<td>

						  	${ac.type_name}

							</td>
						   <td>${ac.group_name}</td>
					       <td>${ac.name}</td>
							<td>${ac.code}</td>

						    <td> <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${ac.opBalance}" /> </td>
						    <td>

						    <c:if test="${ac.opBalance>0}">   ${ac.pst_type_code}</c:if>


						    </td>

							<td>

	<button class="btn btn-info btn-xs" type="button" style="background: #72BB4F; font-weight: bold; color: white;"  onclick="javascript:openAddEditModal(${ac.id},'${ac.name}','${ac.code}','${ac.group_code}',${ac.opBalance},${ac.pst_type_id},${ac.transLimit},${ac.cashDiscountPercentage},
	'${ac.phone}','${ac.email}','${ac.panNo}','${ac.address}','${ac.gstRegistrationNo}','${ac.dlNo}')"><i class="fa fa-pencil"></i>&nbsp;<spring:message code="cmn.jsp.btn.edit" text="Edit" /></button>


									<button class="btn btn-theme04 btn-xs" type="button" style="background-color: #ff0000b8;" onclick="showAccGroupDelModal(${ac.id})"><i class="fa fa-trash-o "></i>&nbsp;<spring:message code="cmn.jsp.btn.dlt" text="Delete" /></button>

							</td>
						</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
				</div>
			 </div>

		 </div>
	      </div>
      <!--./ end col -10  -->
  </div>
  <!--./ end row of first   -->
  <!-- Add/Edit accGroupAddEditModal Modal Starts -->

					<div class="modal fade" id="accGroupAddEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="margin-top: 3%;">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header" style="background: #939393; color: #fff; border-bottom: 1px solid #939393;" >
						        <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
						        <h4 class="modal-title" id="myModalLabel">
						        	<span id="headertextaccountgroup"></span>
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
                              			<label class="col-sm-4 col-sm-4 control-label" id="name_label2"><spring:message code="accgroup.jsp.code" text="Code" /> <span class="required_star">*</span></label>
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
						        <div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="alertMsg"></div>
						      </div>
						      <div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						        <button type="button" class="btn btn-default" data-dismiss="modal"  style="background: #F60; font-weight: bold;"><spring:message code="cmn.jsp.btn.close" text="Close" /></button>
						        <button type="button" onclick="javascript:addEditaccGroup()"  style="background: #72BB4F; font-weight: bold;" class="btn btn-theme"><spring:message code="cmn.jsp.btn.save" text="SAVE" /></button>
						      </div>
						    </div>
						  </div>
				</div>

				<!-- Add/Edit accGroupAddEditModal Modal Ends -->

			<!-- Add/Edit accSetupAddEditModal Modal Starts -->

	<div class="modal fade" id="accSetupAddEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="margin-top: 3%;">
	<div class="modal-dialog" style="width: 1043px;">
		<div class="modal-content">
			<div class="modal-header"  style="background: #939393; color: #fff; border-bottom: 1px solid #939393;" >
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel"><span id="accountheadertext"></span></h4>
			</div>
			<div class="modal-body modal_body"   id="AccountSetupModalBody">
		<div class="row"  style="  margin-left: 1%;margin-right: 1%;">
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
									<select class="form-control"  onchange="selectaccgroup()" name="accountGroupName" id="accountGroupNameId">

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
				<button type="button" style="background: #F60; font-weight: bold;" onclick="closeaccount();" class="btn btn-default" data-dismiss="modal">
					<spring:message code="cmn.jsp.btn.close" text="Close" />
				</button>
				<button class="btn btn-primary"  style="background: #72BB4F; font-weight: bold;" type="button" id="accountsave" onclick="javascript:addnewAccountSetup()">

		        <spring:message code="cmn.jsp.btn.save" text="SAVE" />
				</button>
				<button class="btn btn-info "   style="background: #72BB4F; font-weight: bold;color:white;" type="button" id="accountupdate" onclick="javascript:addnewAccountSetup()">
					<i class="fa fa-pencil"></i>
					<spring:message code="cmn.jsp.btn.update" text="Update" />
				</button>

			</div>
		</div>
	</div>
</div>

				<!-- Add/Edit accSetupAddEditModal Modal Ends -->
 <!-- extra modal start here ==================================================================== -->




				<!-- add city modal start here  -->


			<div class="modal fade" id="cityAddEditModal" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
				data-backdrop="static" data-keyboard="false">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
							<h4 class="modal-title" id="myModalLabel">
								<span id="headertextofcity"></span>
							</h4>
						</div>
						<div class="modal-body">
							<div class="form-horizontal">
								<div class="form-group">
									<label class="col-sm-4 col-sm-4 control-label" id="name_label_countryincity"><spring:message code="city.jsp.countryname" text="Country" />
										<span class="required_star">*</span>
									</label>
									<div class="col-sm-8">
										<select class="form-control-trx" name="countryincity" id="countryidincity" onchange="getStateByCountryinCity()">

											<option value="0">Select...</option>
												<c:if test="${!empty contrylist}">
											<c:forEach items="${contrylist}" var="allcountry">
												<option value="${allcountry.id}">${allcountry.name}</option>
											</c:forEach>
										</c:if>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-4 col-sm-4 control-label" id="name_label_stateincity"><spring:message code="city.jsp.statename" text="State" />
										<span class="required_star">*</span>
									</label>
									<div class="col-sm-8">
										<select class="form-control-trx" name="statelist" id="stateList">

										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-4 col-sm-4 control-label" id="name_label_cityincity"><spring:message code="city.jsp.cityname" text="City" /><span class="required_star"> *</span></label>
									<div class="col-sm-8">
										<input type="text" id="cityName" class="form-control-trx">
									</div>
								</div>
							</div>
							<input type="hidden" id="selcityId" value="">
							<div
								style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;"
								id="alertMsgForcity"></div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">
								<spring:message code="cmn.jsp.btn.close" text="Close" />
							</button>
							<button type="button" id="savebtm" onclick="javascript:addEditCity()"
								class="btn btn-theme">
								<spring:message code="cmn.jsp.btn.save" text="SAVE" />
							</button>
						</div>
					</div>
				</div>
			</div>


				<!--  add city modal end here -->


				<!-- add zone modal start here  -->
				<div class="modal fade" id="zoneAddEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
						        <h4 class="modal-title" id="myModalLabel">
						        	<span id="headertextofzone"></span>
						        </h4>
						      </div>
						      <div class="modal-body">
						        <div class="form-horizontal">
						        	<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="country_labelinzone"><spring:message code="city.jsp.countryname" text="Country Name" /> <span class="required_star">*</span></label>
                              			<div class="col-sm-8">
                              				<select id="countryidinzone" class="form-control" onchange="getStateByCountryinZone()">
                              					<option value="0">Select</option>
	                              				<c:if test="${!empty contrylist}">
													<c:forEach items="${contrylist}" var="countryMaster">
														<option value="${countryMaster.id}">${countryMaster.name}</option>
													</c:forEach>
												</c:if>
                              				</select>
                              			</div>
                          			</div>
                          			<div class="form-group">
										<label class="col-sm-4 col-sm-4 control-label" id="state_labelinzone"><spring:message code="city.jsp.statename" text="State Name" />
											<span class="required_star">*</span>
										</label>
										<div class="col-sm-8">
											<select class="form-control-trx" name="statelist" id="stateListinzone" onchange="getCityByStateinzone()">

											</select>
										</div>
									</div>
						        	<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="city_labelinZone"><spring:message code="city.jsp.cityname" text="City Name" /> <span class="required_star">*</span></label>
                              			<div class="col-sm-8">
                              				<select id="cityListinzone" name="cityList" class="form-control">
                              				</select>
                              			</div>
                          			</div>
						        	<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label"><spring:message code="city.jsp.districtname" text="District Name" /></label>
                              			<div class="col-sm-8">
                                  			<input type="text" id="districtNameinzone" class="form-control">
                              			</div>
                          			</div>
                          			<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="zonename_label"><spring:message code="city.jsp.zonename" text="Zone Name" /></label>
                              			<div class="col-sm-8">
                                  			<input type="text" id="zoneNameinzone" class="form-control">
                              			</div>
                          			</div>
						        </div>
						        <input type="hidden" id="zoneId" value="">
						        <div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="alertMsginzone"></div>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal" ><spring:message code="cmn.jsp.btn.close" text="Close" /></button>
						        <button type="button" onclick="javascript:addEditZone()" class="btn btn-theme"><spring:message code="cmn.jsp.btn.save" text="SAVE" /></button>
						      </div>
						    </div>
						  </div>
				</div>
				<!--add zone modal end here   -->

				<!-- add area modal start here   -->
				<div class="modal fade" id="areaAddEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
						        <h4 class="modal-title" id="myModalLabel">
						        	<span id="headertextinarea"></span>
						        </h4>
						      </div>
						      <div class="modal-body">
						        <div class="form-horizontal">
						        	<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="country_labelinarea"><spring:message code="city.jsp.countryname" text="Country" /> <span class="required_star">*</span></label>
                              			<div class="col-sm-8">
                              				<select id="countryListinarea" class="form-control" onchange="getStateByCountryinArea()">
                              					<option value="0">Select</option>
	                              				<c:if test="${!empty contrylist}">
													<c:forEach items="${contrylist}" var="countryMaster">
														<option value="${countryMaster.id}">${countryMaster.name}</option>
													</c:forEach>
												</c:if>
                              				</select>
                              			</div>
                          			</div>
                          			<div class="form-group">
										<label class="col-sm-4 col-sm-4 control-label" id="state_labelinarea"><spring:message code="city.jsp.statename" text="State" />
											<span class="required_star">*</span>
										</label>
										<div class="col-sm-8">
											<select class="form-control-trx" name="statelist" id="stateListinarea" onchange="getCityByStateinarea()">

											</select>
										</div>
									</div>
						        	<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="city_labelinarea"><spring:message code="city.jsp.cityname" text="City" /> <span class="required_star">*</span></label>
                              			<div class="col-sm-8">
                              				<select id="cityListinarea" name="cityList" class="form-control" onchange="getZoneByCityinArea()">
                              				</select>
                              			</div>
                          			</div>
						        	<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="zone_labelinarea"><spring:message code="city.jsp.zonename" text="Zone" /> <span class="required_star">*</span></label>
                              			<div class="col-sm-8">
                              				<select id="zoneListinarea" name="zoneList" class="form-control">
                              				</select>
                              			</div>
                          			</div>
                          			<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="areaname_labelinarea"><spring:message code="city.jsp.areaname" text="Area Name" /></label>
                              			<div class="col-sm-8">
                                  			<input type="text" id="areaNameinarea" class="form-control">
                              			</div>
                          			</div>
						        </div>
						        <input type="hidden" id="areaId" value="">
						        <div style="text-align: center; color: #F60; font-size: 12px; font-weight: bold;" id="alertMsginarea"></div>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal" ><spring:message code="cmn.jsp.btn.close" text="Close" /></button>
						        <button type="button" onclick="javascript:addEditArea()" class="btn btn-theme"><spring:message code="cmn.jsp.btn.save" text="SAVE" /></button>
						      </div>
						    </div>
						  </div>
				</div>

				<!-- Add/Edit accGroupAddEditModal Modal Ends -->
				<!--  add area model end here -->
          		<div class="modal fade" id="confirmMessageModalNewItem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style=" margin-top: 3%;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"  style="background: #939393; color: #fff; border-bottom: 1px solid #939393;" >
				<!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
				<h4 class="modal-title" id="myModalLabel">
					<spring:message code="footer.jsp.alert" text="Alert!" />
				</h4>
			</div>
			<div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<input type="hidden" id="rqstType" />
				<input type="hidden" id="objctId" />
				<input type="hidden" id="objctName" />
				<input type="hidden" id="objctType" />
				<input type="hidden" id="taxPrcnt" />
				<div id="confirmmessagecontNewItem"></div>
			</div>
			<div class="modal-footer" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
				<button type="button" data-dismiss="modal" style="background: #72BB4F; font-weight: bold; width: 81px;" class="btn btn-theme" onclick="targetAction();">
					<spring:message code="footer.jsp.btn.ok" text="OK" />
				</button>
			</div>
		</div>
	</div>
</div>
 <!-- extra modal end here ==================================================================== -->
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
				<button type="button" onclick="targetURL()" style="background: #72BB4F; font-weight: bold; width: 81px;" data-dismiss="modal" class="btn btn-theme">
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
				<button type="button"  style="background: #F60; font-weight: bold;" class="btn btn-default" data-dismiss="modal" id="cnfrm_cancel_btn">
					<spring:message code="footer.jsp.btn.cancel" text="Cancel" />
				</button>
				<button type="button" onclick="DoConfirm()" style="background: #72BB4F; font-weight: bold; width: 81px;" data-dismiss="modal" class="btn btn-theme">
					<spring:message code="footer.jsp.btn.ok" text="OK" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- Confirm Modal end -->

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
 <%--   <script src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap-datepicker.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/datatable/dataTables.bootstrap.js"></script> --%>
<script src="${pageContext.request.contextPath }/assets/js/datatable/jquery.dataTables.js"></script>
 <script src="${pageContext.request.contextPath}/assets/common/common.js"></script>
  <script src="${pageContext.request.contextPath}/assets/common/moment-with-locales.js"></script>

 <script src="${pageContext.request.contextPath}/assets/js/accounts/accountsetup/accountsetup.js"></script>
   <script type="text/javascript">

   var BASE_URL="${pageContext.request.contextPath}";
   $(document).ready(function() {
		getAccountGroup();
	   /*  $('#example').DataTable({
	    	"lengthChange": false,
	    });
	    $('.dataTables_filter input').attr("placeholder", getAccountSetupText.dataTablePlaceHolder);
 */

	    $("#cashDiscountPersentageId").keyup(function(){

	     if (this.value>=100) {
	    	 $("#cashDiscountPersentageId").val('');
	    	 }
	    });
	});
   function showAccGroupDelModal(id)
   {
   	   document.getElementById('confirmId').value=id;
   	   $('#confirmModal').modal('show');
   }

   function showConfirmModalNewItem() {
		$('#confirmMessageModalNewItem').modal('show');
	}
   </script>

   <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
    <%--    <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script> --%>
    </c:when>

    <c:otherwise>
    <%--  <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script> --%>
         <script src="${pageContext.request.contextPath}/assets/js/accounts/accountsetup/accountsetup_en.js"></script>
         <script src="${pageContext.request.contextPath}/assets/common/common_en.js"></script>


    </c:otherwise>
    </c:choose>

</body>
</html>
