function openAddEditModal(id,name,desc,code,accHead_id,is_sys) {
			if (is_sys==0) {
				$("#acc_group").attr("disabled",false);
				$("#accTypeList").attr("disabled",false);


			}

		if (is_sys==1) {

			$("#acc_group").attr("disabled",true);
			$("#accTypeList").attr("disabled",true);
		}
	document.getElementById('alertMsg').innerHTML = '';
	$("#accGroupName").val(name);
	$("#accGroupId").val(id);
	$("#accGroupDesc").val(desc);
	$("#accGroupCode").val(code);
	if (id == 0) { // add
		$("#headertext").text(getLedgerText.headerTextAdd);
		$("#accTypeList").attr("disabled",false);
		$("#accTypeList").val(0);


		$("#acc_group").attr("disabled",false);
	} else { // update
		$("#headertext").text(getLedgerText.headerTextUpdate);
		$("#accTypeList").val(accHead_id);
		/*$("#accTypeList").attr("disabled",true);*/



	}

	$('#accGroupAddEditModal').modal('show');
}

function addEditaccGroup()
{
	document.getElementById('alertMsg').innerHTML='';

	var id=$('#accGroupId').val();
	var name=$('#accGroupName').val();
	var code=$('#accGroupCode').val();
	var desc=$('#accGroupDesc').val();
	var accTypeId=$('#accTypeList').val();

	if(accTypeId==0)
	{
		document.getElementById('alertMsg').innerHTML=getLedgerText.catBlankError;
	}
	else
		{
			var name_label = $("#name_label").text();
			var name_field = name_label.substring(0, name_label.lastIndexOf(" "));

			var name_label2= $('#name_label2').text();
			var name_field2= name_label2.substring(0, name_label.lastIndexOf(" "));


			var field_names = [["accGroupName",name_field],["accGroupCode",name_field2]];
			if(fieldValidation(field_names)>0)
				{
				}
			else
				{
				$('#accGroupAddEditModal').modal('hide');
				$('#pleasewaitModal').modal('show');
				if(id==0)
				{
					var AccGroupMasterObj = {};
					AccGroupMasterObj.name = name;
					AccGroupMasterObj.code = code;
					AccGroupMasterObj.description = desc;
					AccGroupMasterObj.accountTypeId = accTypeId;

					var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjaxPost(BASE_URL + "/accntgrp/addaccgrp.htm", AccGroupMasterObj, function(response) {
						$('#pleasewaitModal').modal('hide');
						var status = JSON.parse(response);
						chngeResultStat(status);
					});
				}
				else
				{
					var AccGroupMasterObj = {};
					AccGroupMasterObj.id = id;
					AccGroupMasterObj.name = name;
					AccGroupMasterObj.code = code;
					AccGroupMasterObj.description = desc;
					AccGroupMasterObj.accountTypeId = accTypeId;
					var s=JSON.stringify(AccGroupMasterObj);

				 	var ajaxCallObject = new CustomBrowserXMLObject();
					ajaxCallObject.callAjaxPost(BASE_URL + "/accntgrp/editaccgrp.htm", AccGroupMasterObj, function(response) {
						$('#pleasewaitModal').modal('hide');
						var status = JSON.parse(response);
						chngeResultStat(status);
					});
				}
			}
		}
}

function DoConfirm() {
	$('#pleasewaitModal').modal('show');
	var id = document.getElementById('confirmId').value;
	var ajaxCallObject = new CustomBrowserXMLObject();
	ajaxCallObject.callAjax(BASE_URL + "/accntgrp/deleteaccgroup/" + id + ".htm", function(response) {
		$('#pleasewaitModal').modal('hide');
		var status = JSON.parse(response);
		chngeResultStat(status);
	}, null);
}

function targetURL() {
	location.href = BASE_URL + '/accntgrp/loadaccntgrp.htm';
}

function showAccGroupDelModal(id)
{
 document.getElementById('confirmId').value=id;
 $('#confirmModal').modal('show');
}