$(document)
		.ready(
				function() {
					
					$("#forAdmin").hide();
					$("#forAdmin2").hide();
					$("#forAdmin3").hide();
					$("#i1").show();
					$("#i2").show();
					$("#i3").show();
					$("#selectdutyshiftlistinmodal").on("change", function() {
						var jsonresponse = getDutyShiftById();
						console.log("JSON RESPONSE  FOR DUTYSHIFT IS:");
						console.log(jsonresponse);
						var fromtime = jsonresponse.fromTime;
						var totime = jsonresponse.toTime;
						$("#empshiftfromtime").val(fromtime);
						$("#empshifttotime").val(totime);

					});

					$("#closeshiftshedule").click(function() {
						$("#employeeshiftmodal").modal("hide");

					});

					$("#addshiftshedule")
							.click(
									function() {
										$("#employeeshiftmodalfooter").find(
												"span").remove();
										$("#empshiftfromtime").removeClass(
												"customdanger");
										$("#empshifttotime").removeClass(
												"customdanger");
										$("#fromdateinmodal").removeClass(
												"customdanger");
										$("#todateinmodal").removeClass(
												"customdanger");
										$("#selectdutyshiftlistinmodal")
												.removeClass("customdanger");
										var shiftno = $(
												"#selectdutyshiftlistinmodal")
												.val();
										var fromtime = $("#empshiftfromtime")
												.val();
										var totime = $("#empshifttotime").val();
										var fromdate = $("#fromdateinmodal")
												.val();
										var todate = $("#todateinmodal").val();
										// alert("FROMDATE=="+fromdate);
										// alert("TODATE=="+todate);
										var empid = $("#empid").val();
										var shiftscheduleid = $(
												"#shiftscheduleidinmodal")
												.val();
										var url = "";
										var msg = "";
										/*
										 * alert("EMPLOYEE ID IS:"+empid);
										 * alert("fromtime IS:"+fromtime);
										 * alert("totime IS:"+totime);
										 * alert("fromdate:"+fromdate);
										 * alert("todate ID IS:"+todate);
										 * alert("DUTY SHIFT NUMBER
										 * IS:"+shiftno); alert("SHIFT SCHEDULE
										 * ID IS:"+shiftscheduleid);
										 */
										if (shiftscheduleid > 0) {
											url = BASE_URL
													+ "/hrmgnt/updateEmpShiftSchedule.htm";
										} else {
											url = BASE_URL
													+ "/hrmgnt/addEmpShiftSchedule.htm";
										}
										var empshiftschedulefinallist = getemployeeschedulelistarrayforpostorupdate();
										console
												.log("DATA BEFORE SAVING SCHEDULE OR UPDATING SCHEDULE IS:");
										console.log(empshiftschedulefinallist);
										if (url != null
												&& url != ""
												&& Object
														.keys(empshiftschedulefinallist).length != 0) {
											$
													.ajax({
														url : url,
														type : 'POST',
														async : false,
														contentType : 'application/json;charset=utf-8',
														data : JSON
																.stringify(empshiftschedulefinallist),
														success : function(
																response) {
															obj = JSON
																	.parse(response);

															if (obj.is_success) {
																if (shiftscheduleid > 0) {
																	msg = "Succesfully updated the record";
																} else {
																	msg = "Succesfully saved the record";
																}
																$(
																		"#alertmodalbody")
																		.html(
																				msg);
																$(
																		"#alertmessagemodal")
																		.modal(
																				"show");
															}
														},
														error : function(error) {
															console
																	.log("ERROR IN shiftSchedule.js FILE FOR ADDING OR UPDATING SHIFT SCHEDULE IS:");
															console.log(error);
														}
													});

										} else {
											// alert("TRIGGERED ELSE");
											var fromtime = $(
													"#empshiftfromtime").val();
											var totime = $("#empshifttotime")
													.val();
											/*
											 * if(fromtime==null ||
											 * fromtime==""){
											 * $("#empshiftfromtime").addClass("customdanger");
											 * $("#employeeshiftmodalfooter").append("<span
											 * class='error'>From time Cannot Be
											 * empty</span>"); }else
											 * if(totime==null || totime==""){
											 * $("#empshifttotime").addClass("customdanger");
											 * $("#employeeshiftmodalfooter").append("<span
											 * class='error'>To Time Cannot Be
											 * empty</span>");
											 * 
											 * }else if(totime<fromtime){
											 * 
											 * $("#empshiftfromtime").addClass("customdanger");
											 * $("#empshifttotime").addClass("customdanger");
											 * $("#employeeshiftmodalfooter").append("<span
											 * class='error'>To time should be
											 * greater than from time</span>");
											 * }else if(totime<fromtime &&
											 * !fromtime.startsWith("0") &&
											 * totime.startsWith("0")){
											 * 
											 * 
											 * }else if(todate<fromdate){
											 * $("#fromdateinmodal").addClass("customdanger");
											 * $("#todateinmodal").addClass("customdanger");
											 * $("#employeeshiftmodalfooter").append("<span
											 * class='error'>To Date should be
											 * greater than or equal to the From
											 * Date</span>");
											 *  }
											 */

											if (todate < fromdate) {
												$("#fromdateinmodal").addClass(
														"customdanger");
												$("#todateinmodal").addClass(
														"customdanger");
												$("#employeeshiftmodalfooter")
														.append(
																"<span class='error'>To Date should be greater than or equal to the From Date</span>");

											} else if (fromtime == null
													|| fromtime == "") {
												$("#empshiftfromtime")
														.addClass(
																"customdanger");
												$("#employeeshiftmodalfooter")
														.append(
																"<span class='error'>From time Cannot Be empty</span>");
											} else if (totime == null
													|| totime == "") {
												$("#empshifttotime").addClass(
														"customdanger");
												$("#employeeshiftmodalfooter")
														.append(
																"<span class='error'>To Time Cannot Be empty</span>");

											} else if (totime < fromtime) {
												$("#empshiftfromtime")
														.addClass(
																"customdanger");
												$("#empshifttotime").addClass(
														"customdanger");
												$("#employeeshiftmodalfooter")
														.append(
																"<span class='error'>To time should be greater than from time</span>");
											} else if (shiftno <= 0) {
												$("#selectdutyshiftlistinmodal")
														.addClass(
																"customdanger");
												$("#employeeshiftmodalfooter")
														.append(
																"<span class='error'>Please select a shift.It Cant Be Empty.</span>");
											}

										}

									});

				});

$("#cancelshiftshedule")
		.click(
				function() {

					// alert("CLIKED CANCEL");
					var shiftno = $("#selectdutyshiftlistinmodal").val();
					var fromtime = $("#empshiftfromtime").val();
					var totime = $("#empshifttotime").val();
					var fromdate = $("#fromdateinmodal").val();
					var todate = $("#todateinmodal").val();
					var empid = $("#empid").val();
					var shiftscheduleid = $("#shiftscheduleidinmodal").val();
					var url = "";
					var msg = "";
					/*
					 * alert("EMPLOYEE ID IS:"+empid); alert("fromtime
					 * IS:"+fromtime); alert("totime IS:"+totime);
					 * alert("fromdate:"+fromdate); alert("todate ID
					 * IS:"+todate); alert("DUTY SHIFT NUMBER IS:"+shiftno);
					 * alert("SHIFT SCHEDULE ID IS:"+shiftscheduleid);
					 */
					if (shiftscheduleid > 0) {
						url = BASE_URL + "/hrmgnt/cancelEmpShiftSchedule.htm";
					}
					var empshiftschedulefinallist = getemployeeschedulelistarrayforpostorupdate();
					// console.log("DATA BEFORE CANCELLING SCHEDULE OR UPDATING
					// SCHEDULE IS:");
					// console.log(empshiftschedulefinallist);

					if (url != null && url != "") {
						$
								.ajax({
									url : url,
									type : 'POST',
									async : false,
									contentType : 'application/json;charset=utf-8',
									data : JSON
											.stringify(empshiftschedulefinallist),
									success : function(response) {
										obj = JSON.parse(response);

										if (obj.is_success) {

											msg = "Succesfully cancelled the record";
										} else {
											msg = "Failed To Cancel the record";
										}
										$("#alertmodalbody").html(msg);
										$("#alertmessagemodal").modal("show");
									},
									error : function(error) {
										console
												.log("ERROR IN shiftSchedule.js FILE FOR CANCELLING SHIFT SCHEDULE IS:");
										console.log(error);
									}
								});

					}

				});

$("#shiftscheduleexcelexport").click(function() {
	var fromdate = $("#fromdate").val();
	var todate = $("#todate").val();
	var fileName = "EmployeeShift_" + fromdate + "_" + todate + ".xls";
	$("#employeeshifttable").table2excel({
		filename : fileName
	});
});
function getemployeeschedulelistarrayforpostorupdate() {
	var shiftno = $("#selectdutyshiftlistinmodal").val();
	var fromtime = $("#empshiftfromtime").val();
	var totime = $("#empshifttotime").val();
	var fromdate = $("#fromdateinmodal").val();
	var todate = $("#todateinmodal").val();
	var empid = $("#empid").val();
	var workinghours = 0;
	var tominutes = 0;
	var fromminutes = 0;
	// alert("EMPLOYEE ID IS:"+empid);
	var shiftscheduleid = $("#shiftscheduleidinmodal").val();
	var empshiftschedulelistarray = null;
	var empshiftschedulefinallist = {};

	if ((fromtime != null && totime != null && totime > fromtime
			&& todate >= fromdate && shiftno > 0)
			|| (totime < fromtime && !fromtime.startsWith("0")
					&& totime.startsWith("0") && todate >= fromdate && shiftno > 0)) {
		empshiftschedulelistarray = [];

		if (totime < fromtime && !fromtime.startsWith("0")
				&& totime.startsWith("0")) {
			// alert("IF");
			var fromtimehour = +fromtime.split(":")[0];
			var totimehour = +totime.split(":")[0];
			var fromtimeminutes = +fromtime.split(":")[1];
			var totimeminutes = +totime.split(":")[1];

			tominutes = ((totimehour + 24) * 60) + (totimeminutes);
			console.log(tominutes);
			fromminutes = (fromtimehour * 60) + (fromtimeminutes);
			console.log(fromminutes);
			workinghours = tominutes - fromminutes;
			fromdate = new Date(fromdate);
			fromdate = moment(fromdate).format("YYYY-MM-DD");

			todate = new Date(todate);
			todate = moment(todate).format("YYYY-MM-DD");
			// todate=fromdate;
			// todate=moment(fromdate,
			// "YYYY-MM-DD").add('days',1).format("YYYY-MM-DD");
		} else if (totime > fromtime) {
			// alert("ELSE totime>fromtime");
			var fromtimehour = +fromtime.split(":")[0];
			var totimehour = +totime.split(":")[0];
			var fromtimeminutes = +fromtime.split(":")[1];
			var totimeminutes = +totime.split(":")[1];
			tominutes = (totimehour * 60) + (totimeminutes);
			fromminutes = (fromtimehour * 60) + (fromtimeminutes);

			workinghours = tominutes - fromminutes;
			console.log(workinghours);

			if (fromtime.startsWith("00")) {
				fromdate = new Date(fromdate);
				fromdate = moment(fromdate).format("YYYY-MM-DD");
				fromdate = moment(fromdate).add('days', 1).format("YYYY-MM-DD");
				todate = new Date(todate);
				todate = moment(todate).format("YYYY-MM-DD");
				// todate=fromdate;
			}

		}
		console.log("TOTAL FROM MINUTES  IS:" + fromminutes);
		console.log("TOTAL TO MINUTES  IS:" + tominutes);
		console.log("WORKING HOURS IS:" + workinghours);
		if (shiftscheduleid > 0 && workinghours > 0) {
			var employee = {};
			employee.id = empid;
			var empshiftschedule = {};
			empshiftschedule.id = shiftscheduleid;
			empshiftschedule.storeId = storeID;
			empshiftschedule.employee = employee;
			empshiftschedule.dutyShiftId = shiftno;
			empshiftschedule.shiftingNo = shiftno;
			empshiftschedule.fromTime = fromtime;
			empshiftschedule.toTime = totime;
			empshiftschedule.fromDate = fromdate;
			empshiftschedule.toDate = todate;
			empshiftschedule.workingHour = workinghours;
			empshiftschedule.updatedBy = customer.id;
			empshiftschedule.updatedDate = todaydate;
			empshiftschedulelistarray.push(empshiftschedule);
			empshiftschedulefinallist.empshiftscheduleList = empshiftschedulelistarray;
		} else if (workinghours > 0) {
			if (todate >= fromdate) {
				var start = fromdate;
				var end = todate;
				start = new Date(start);
				end = new Date(end);
				var daysarr = generatedaterange(start, end);
				// debugger
				for (var g = 0; g < daysarr.length; g++) {
					var employee = {};
					employee.id = empid;
					var objdate = daysarr[g];
					objdate = new Date(objdate);
					objdate = moment(objdate).format("YYYY-MM-DD");
					var empshiftschedule = {};
					empshiftschedule.storeId = storeID;
					empshiftschedule.employee = employee;
					empshiftschedule.dutyShiftId = shiftno;
					empshiftschedule.shiftingNo = shiftno;
					empshiftschedule.fromTime = fromtime;
					empshiftschedule.toTime = totime;
					empshiftschedule.fromDate = objdate;
					empshiftschedule.toDate = objdate;
					empshiftschedule.workingHour = workinghours;
					empshiftschedule.createdBy = customer.id;
					empshiftschedule.createdDate = todaydate;
					empshiftschedulelistarray.push(empshiftschedule);
				}
				empshiftschedulefinallist.empshiftscheduleList = empshiftschedulelistarray;
			}

		}

	}

	return empshiftschedulefinallist;

}

function getDutyShiftById() {
	var dutyshiftid = $("#selectdutyshiftlistinmodal").val();

	var url = BASE_URL + "/hrmgnt/getDutyShiftsById.htm?storeId=" + storeID
			+ "&id=" + dutyshiftid;
	var employeetyperes = '';
	$
			.ajax({
				url : url,
				type : 'GET',
				async : false,
				contentType : 'application/json;charset=utf-8',
				success : function(obj) {
					employeetyperes = JSON.parse(obj);
				},
				error : function(error) {
					console
							.log("ERROR INSIDE getEmployeeTypesById FUNCTION IN hrAdminScript.js FILE IS");
					console.log(error);
				}
			});

	return employeetyperes;

	// alert("STORE ID IN shiftSchedule.js FILE IS:"+storeID);

}

function getAllEmployeeShiftSchedule() {
	var url = BASE_URL + "/hrmgnt/getAllEmpShiftSchedule.htm";
	var res = null;
	var startdate = $("#fromdate").val();
	var todate = $("#todate").val();

	startdate = moment(startdate).format('YYYY-MM-DD');
	todate = moment(todate).format('YYYY-MM-DD');
	$
			.ajax({
				url : url,
				type : 'GET',
				headers : {
					"storeId" : storeID,
					"fromDate" : startdate,
					"toDate" : todate
				},
				contentType : 'application/json;charset=utf-8',
				async : false,
				success : function(response) {
					if (response != null && response != "") {
						// console.log("RESPONSE IS:"+response)
						res = JSON.parse(response);
						console
								.log("RES  IN shiftschedule.jsp FILE AFTER CLICKING  getallemployeeshiftinfo BUTTON  IS:");
						console.log(res);
					}

				},
				error : function(error) {
					console
							.log("ERROR IN shiftschedule.jsp FILE AFTER CLICKING  getallemployeeshiftinfo BUTTON  IS:");
					console.log(error);
				}
			});
	return res;

}
