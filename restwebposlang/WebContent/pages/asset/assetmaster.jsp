<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<meta name="description" content="" />
<meta name="author" content="" />
<!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
<title>:. POS :: Asset Management :.</title>
<!-- BOOTSTRAP CORE STYLE  -->
<link
	href="${pageContext.request.contextPath}/assets/css/bootstrap/bootstrap.css"
	rel="stylesheet" />
<!-- FONT AWESOME ICONS  -->
<link
	href="${pageContext.request.contextPath}/assets/css/font-awesome.css"
	rel="stylesheet" />
<!-- CUSTOM STYLE  -->
<link href="${pageContext.request.contextPath}/assets/css/style.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/customstyle.css"
	rel="stylesheet" />
<link rel="icon" id="favicon"
	href="${pageContext.request.contextPath}/assets/images/title/fb.png">

</head>
<body>

	<jsp:include page="/pages/common/header.jsp"></jsp:include>
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row">
				<jsp:include page="/pages/admin/admleftpanel.jsp"></jsp:include>
<div class="col-md-2 col-sm-2">
						<a id="addAsset" class="btn btn-success addbutton" data-toggle="modal" data-target="#assetmasteraddmodal">ADD</a>
							
					</div>

			 <div class="customtext">
						
								ITEM MASTER
							
						</div> 
						
				<div id="content" class="col-md-10 col-sm-10">
					
					
					<table class="table table-striped table-bordered table-hover"
						id="assetmastertable">
						<thead class="allemployeestablerow" id="assetmastertablethead">

							<tr id="theadrow" class="text-nowrap">
								<th>NAME</th>
								<th>CODE</th>
								<th>UNIT</th>
								<th>SIZE</th>
								<th>COLOR</th>
								<th>RATE</th>
								<th>TAXRATE</th>
								<th>IS TAX EXCLUSIVE</th>
								<th>CATEGORY</th>
								<th>DISC PERCENTAGE</th>
								<th>IS RESUSABLE</th>
								<th>IS PERMANENT</th>
						</thead>
						<tbody id="assetmastertabletbody">
							<tr class="customtablerow">
								<td>DENTASSURE TOOTHPASTE</td>
								<td>D001</td>
								<td>1PACKET</td>
								<td>PACKETS</td>
								<td>WHITE</td>
								<td>75</td>
								<td>0</td>
								<td>NO</td>
								<td>OTHERS</td> 
								<td>0</td> 
								<td>NO</td>
								<td>NO</td>

							</tr>

						</tbody>
					</table>
					<!--  <div id="exportbuttondiv" class="">
                                <a id="employeeattendanceexcelexport" class="btn btn-success customexportbutton">EXPORT</a>
                                </div> -->
				</div>

			<div class="modal fade"  id="assetmasteraddmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
   <div id="modaldialog" class="modal-dialog">
      <!-- Modal content-->    
      <div id="modalcontent" class="modal-content">
         <div id="modalheader" class="modal-header custommodalheaderforemployeemodal">
            <button type="button" class="close" data-dismiss="modal">&times;</button>        
            <h4 id="modalheading" class="modal-title">Add Asset</h4>
         </div>
         <div id="assetmodalbody" class="modal-body custommodalbodyforemployeemodal">
                  <table id="assettable">
                     <tbody id="tbody">
                        <tr id="tr1">
                           <td>Name : </td>
                           <td>	<input type="text"  id="name" class="form-control custominput"/>	 </td>					  
                        </tr>
                        <tr id="tr2">
                           <td>Code: </td>                           
                           <td><input type="text"  id="code" class="form-control custominput"/> </td>
                        </tr>
                        <tr id="tr3">
                           <td>Unit: </td>                       
                           <td> <input type="text"  id="unit" class="form-control custominput"/> </td>
                        </tr>
                        <tr id="tr4">
                           <td>Size: </td>
                           <td><input type="text"  id="size" class="form-control custominput"/></td>
                        </tr>
                        <tr id="tr5">
                           <td>Color: </td>
                           <td><input type="text"  id="color" class="form-control custominput"/> </td>
                        </tr>
                        <tr id="tr6">
                           <td>Rate: </td>
                           <td > <input type="text"  class="form-control custominput" id="rate"/></td>		
                        </tr>
                       
                        <tr id="tr7">
                           <td>TaxRate: </td>
						   <td><input type="text" class="form-control custominput" id="taxrate"/></td>
                        </tr>
                        <tr id="tr8">
                           
                           <td>Is Tax Exclusive: </td>
						   <td><input type="text" id="taxexclusive"  class="form-control custominput"/></td>
						   
                        </tr>
                        <tr id="tr9">
                           
                           <td>Category: </td>
                           <td id="tdselectcategory">
                           <select id="category"  class="form-control custominput">
                           <option value="0">Others</option>
                           <option value="2">Furniture</option>
                           <option value="3">Kitchenware</option>
                           <option value="4">Cloths</option>
                           <option value="5">Sanitary</option>
                           <option value="6">Miscellaneous</option>
                           </select>
                           
                           </td>
                           
						  <!--  <td><input type="text" id="taxexclusive"  class="form-control custominput"/></td> -->
						   
                        </tr>
                        <tr id="tr10">
                           <td>DiscountPercentage:</td>
						  <td><input type="text"id="discountpercentage"  class="form-control custominput" /></td>
                        </tr>
						
                        <tr id="tr11">
                           <td>Is Reusable: </td>                        
						  <td><input type="text"   id="reusable" class="form-control custominput"></td>
						   
						   
                        </tr>
                        <tr id="tr12">
                           <td>Is Permanent: </td>
                           
                           <td style="margin-bottom: 3px;">
						   <input type="text"id="permanent" class="form-control custominput"></td>
                        </tr>
         				
                     </tbody>
                  </table>
              
            </div>
              <div class="modal-footer custommodalfooterforemployeemodal">
                                            <button type="button" id="closeassetmodal"  class="btn btn-warning modalclose" data-dismiss="modal">CLOSE</button>
                                            <button type="button" id="createasset"   class="btn btn-success modalsave">SAVE</button>   
                                        </div>
         </div>
         
      </div>
   </div>

			</div>
		</div>


	</div>



	<!-- CONTENT-WRAPPER SECTION END-->

	<!-- FOOTER SECTION END-->
	<!-- JAVASCRIPT AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/adminScript.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/assets/ajax/ajax.js"></script>
	<!-- CORE JQUERY SCRIPTS -->
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.11.1.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/jquery-1.9.1.min.js"></script>
	<!-- BOOTSTRAP SCRIPTS  -->
	<script
		src="${pageContext.request.contextPath}/assets/js/bootstrap/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>

	<script type="text/javascript">
   var BASE_URL="${pageContext.request.contextPath}";

   var language = '<%=session.getAttribute("language")%>';
		

		var storeID = "${sessionScope.loggedinStore.id}";
	</script>





	<c:choose>
		<c:when test="${pageContext.response.locale == 'ar'}">
			<script
				src="${pageContext.request.contextPath}/assets/js/lang/adminScript_AR.js"></script>
		</c:when>

		<c:otherwise>
			<script
				src="${pageContext.request.contextPath}/assets/js/lang/adminScript_EN.js"></script>
			<script
				src="${pageContext.request.contextPath}/assets/js/assetmaster.js"></script>
		</c:otherwise>
	</c:choose>


</body>
</html>