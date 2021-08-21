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
    <title>:. POS :: Account Group  :.</title>
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



                   <div class="row"  style="margin-left: 0%;margin-right: 1%;margin-top: -1%; color:#FFF;">
          		<div class="col-lg-12">
   				<p><%-- <spring:message code="subcat.jsp.title" text="SubCategory..." /> --%></p>
   				<div class="panel panel-default">
					<div class="panel-body">

						<div class="col-lg-8 col-md-8 col-sm-12">
							<form modelAttribute="commonResultSetMapper" class="form-inline" role="form" action="${pageContext.request.contextPath }/accntgrp/searchaccntgrp.htm" method="post">
								<div class="form-group">

										<input type="text" class="form-control" placeholder="Group Name" name="accntGrpName" value="${accntGrpName}">

								</div>
								<div class="form-group">
									<select class="form-control" name="qryCondition" >
										<option value="like">LIKE</option>
										<option value="equals">=</option>
									</select>
								</div>
								<button type="submit" class="btn btn-theme"  style="background: #72BB4F; font-weight: bold;" ><spring:message code="cmn.jsp.search" text="Search" /></button>
							</form>
						</div>

						<div class="pull-right">

								<button class="btn btn-primary"  style="background: #72BB4F; font-weight: bold;" type="button" onclick="javascript:openAddEditModal(0,'','','',0)"><i class="fa fa-plus"></i>&nbsp;<spring:message code="cmn.jsp.btn.add" text="Add" /></button>

						</div>
					</div>
				</div>

           		<%-- <input type="hidden" id="cmpny_id" value="${sessionScope.sesloggedinUser.companyId}" ></input>
           		<input type="hidden" id="user_id" value="${sessionScope.sesloggedinUser.id}" ></input> --%>

				<!-- Add/Edit accGroupAddEditModal Modal Starts -->

					<div class="modal fade" id="accGroupAddEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="    margin-top: 3%;">
						  <div class="modal-dialog"  style=" width: 41%;">
						    <div class="modal-content"  style="border: 3px solid #ffffff; border-radius: 0px;">
						      <div class="modal-header"  style="background: #939393; color: #fff; border-bottom: 1px solid #939393;">
						        <!-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
						        <h4 class="modal-title" id="myModalLabel">
						        	<span id="headertext"></span>
						        </h4>
						      </div>
						      <div class="modal-body" style="background: #404040; border-top: 1px solid #404040; color: #fff;">
						        <div class="form-horizontal" style="    margin-right: 19%;">
						        	<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label"><spring:message code="accgroup.jsp.acctype.name" text="Account Type" /> <span class="required_star">*</span></label>
                              			<div class="col-sm-8">
                              				<select id="accTypeList" class="form-control">
                              					<option value="0">Select</option>
                              					<c:if test="${!empty allAccTypes}">
                              						<c:forEach items="${allAccTypes}" var="allAccType">
                              							<option value="${allAccType.id}">${allAccType.typeName}</option>
                              						</c:forEach>
                              					</c:if>
                              				</select>
                              			</div>
                          			</div>
						        	<div class="form-group">
                              			<label class="col-sm-4 col-sm-4 control-label" id="name_label"><spring:message code="accgroup.jsp.name" text="Name" /> <span class="required_star">*</span></label>
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
						        <button type="button"   style="background: #F60; font-weight: bold;" class="btn btn-default" data-dismiss="modal" ><spring:message code="cmn.jsp.btn.close" text="Close" /></button>


						        <button id="acc_group" type="button"   style="background: #72BB4F; font-weight: bold;"  onclick="javascript:addEditaccGroup()" class="btn btn-theme"><spring:message code="cmn.jsp.btn.save" text="SAVE" /></button>





						      </div>
						    </div>
						  </div>
				</div>

				<!-- Add/Edit accGroupAddEditModal Modal Ends -->

			  <span id="is_sys"></span>
                     <div class="table-responsive" style="    overflow-y: scroll;height: 446px;">
				<table id="example" class="table table-bordered table-condensed  " cellspacing="0" width="100%" style="color: white;" >
				<thead>
					<tr>
						<th><spring:message code="accgroup.jsp.type" text="Account Type" /></th>
						<th> Group &nbsp;<spring:message code="accgroup.jsp.name" text="Name" /></th>
						<th> Group &nbsp; <spring:message code="accgroup.jsp.code" text="Code" /></th>
						<th><spring:message code="cmn.jsp.tblhdr.action" text="Action" /></th>
					</tr>
				</thead>

				<tbody>
				<c:if test="${!empty allAccGroups }">
					<c:forEach items="${allAccGroups}" var="allAccGroup" varStatus="index">
						<tr>
						<td>${allAccGroup.accountTypeName}</td>
						<td>${allAccGroup.name}</td>
						<td>${allAccGroup.code}</td>

						<td>
							<%-- <c:if test="${menuByUserDTO.isAll==1 }"> --%>

							   <c:if test="${allAccGroup.is_system==1}">
							   <button class="btn btn-primary btn-xs" type="button" onclick="javascript:openAddEditModal(${allAccGroup.id},&quot;${allAccGroup.name}&quot;,&quot;${allAccGroup.description}&quot;,&quot;${allAccGroup.code}&quot;,${allAccGroup.accountTypeId},${allAccGroup.is_system})"><i class="fa fa-eye" aria-hidden="true"></i>
							   &nbsp;<spring:message code="cmn.jsp.btn.view" text="View" /></button>
							   </c:if>
							   <c:if test="${allAccGroup.is_system==0}">
							   <button class="btn btn-theme04 btn-xs" type="button"  style="background: #72BB4F; font-weight: bold;"  onclick="javascript:openAddEditModal(${allAccGroup.id},&quot;${allAccGroup.name}&quot;,&quot;${allAccGroup.description}&quot;,&quot;${allAccGroup.code}&quot;,${allAccGroup.accountTypeId},${allAccGroup.is_system})"> <i class="fa fa-pencil-square-o" aria-hidden="true"></i> &nbsp;<spring:message code="cmn.jsp.btn.edit" text="Edit" /></button>
							   </c:if>

						<%-- 	</c:if> menuByUserDTO.isView==1 && --%>
							<c:if test="${ allAccGroup.is_system==0}">
								<button class="btn btn-theme04 btn-xs" type="button" style="background-color: #ff0000b8;" onclick="showAccGroupDelModal(${allAccGroup.id})"><i class="fa fa-trash-o "></i>&nbsp;<spring:message code="cmn.jsp.btn.dlt" text="Delete" /></button>
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
      </div>

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
				<button type="button" style="background: #72BB4F; font-weight: bold; width: 81px;"  onclick="targetURL()" data-dismiss="modal" class="btn btn-theme">
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
				<button type="button"  style="background: #F60; font-weight: bold;"  class="btn btn-default" data-dismiss="modal" id="cnfrm_cancel_btn">
					<spring:message code="footer.jsp.btn.cancel" text="Cancel" />
				</button>
				<button type="button"  style="background: #72BB4F; font-weight: bold; width: 81px;"  onclick="DoConfirm()" data-dismiss="modal" class="btn btn-default">
					<spring:message code="footer.jsp.btn.ok" text="OK" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- Confirm Modal end -->
            </div>
  		</div>
    </div>
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

 <script src="${pageContext.request.contextPath}/assets/js/accounts/accgroup/accgroup.js"></script>
   <script type="text/javascript">

   var BASE_URL="${pageContext.request.contextPath}";

   </script>

   <c:choose>
    <c:when test="${pageContext.response.locale == 'ar'}">
    <%--    <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script> --%>
    </c:when>

    <c:otherwise>
    <%--  <script src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script> --%>
         <script src="${pageContext.request.contextPath}/assets/js/accounts/accgroup/accgroup_en.js"></script>
         <script src="${pageContext.request.contextPath}/assets/common/common_en.js"></script>


    </c:otherwise>
    </c:choose>

</body>
</html>
