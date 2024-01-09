<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<!-- header css -->
<link rel="stylesheet" href="resources/css/header.css">
<!-- aside css -->
<link rel="stylesheet" href="resources/css/aside.css">
<!-- header script -->
<script src="resources/js/header.js"></script>
<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
<script>
	$(function(){
		
		setSkills()
		
		$("#search").click(function(){
			getUserProjectList(1)
		})
		
		$("#checkAll").change(function(){
			if($(this).is(":checked") == true){
				$(".prjSeq").each(function(){
					$(this).prop('checked',true)
				})
			} else {
				$(".prjSeq").each(function(){
					$(this).prop('checked',false)
				})
			}
		})
	})
	
	function getUserProjectList(pageNum){
		var usrSeq = $("#usrSeq").val()
		var countPerPage = $("#countPerPage").val()
		
		if(usrSeq == ""){
			usrSeq = 0
		}
		
		var param = "usrSeq="+usrSeq
		param += "&countPerPage="+countPerPage
		param += "&pageNum="+pageNum
		
		$.ajax({
	        url: "getUserProjectList", 
	        type:"post",
	        data: param,
	        success: function(data) {
	        	var str = ""
	        	var page = ""
	        	var save = "<button id='save' onclick='save()'>����</button>"
	        	var add = "<button id='add' onclick='add()'>�߰�</button>"
	        	var del = "<button id='del' onclick='del()'>����</button>"
	        	var cancel = "<button id='cancel' onclick='cancel()'>���</button>"
	        	
	        	
	        	/* model ���� toString() ���� �޾ƿ� ���ڿ��� �迭�� �Ľ� */
	        	var codeList = '${codeList}'
	        	
	        	codeList = codeList.substring(1, codeList.length-1)
	        	codeList = codeList.split("CodeDTO")
	        	codeList.shift()
	        	
	        	for(var i = 0; i<codeList.length; i++){
	        		var str = codeList[i]
	        		
	        		codeList[i] = str.substring(2, str.length-3)
	        	}
	        	
		        $("#tbody").empty()
		        $(".resultPage").empty()
		        $(".resultButton").empty()
		        
		        if(data.userProjectList.length >= 1){
		        	$.each(data.userProjectList, function(i){
		        		var customer
		        		var role
		        		var skills = ""
		        		
		        		var skillArr = data.userProjectList[i].skills.split(",")
		        		
		        		for(var j = 0; j<codeList.length; j++){
		        			if(codeList[j].indexOf("mstCD=CU01") != -1 && codeList[j].indexOf("dtCD=" + data.userProjectList[i].cusCD + ",") != -1){
		        				customer = codeList[j].substring(codeList[j].indexOf("dtCDNM=")+7)
		        			}
		        			if(codeList[j].indexOf("mstCD=RL01") != -1 && codeList[j].indexOf("dtCD=" + data.userProjectList[i].rlCD + ",") != -1){
		        				role = codeList[j].substring(codeList[j].indexOf("dtCDNM=")+7)
		        			}
		        			
		        			for(var k = 0; k<skillArr.length; k++){
		        				if(codeList[j].indexOf("mstCD=SK01") != -1 && codeList[j].indexOf("dtCD=" + skillArr[k] + ",") != -1){
		        					if(k != 0){
			        					skills += ", "
			        				}
		        					skills += codeList[j].substring(codeList[j].indexOf("dtCDNM=")+7)
			        			}
		        			}
		        		}
		        		
	                	str += "<tr>"
	                	str += "<td class='checkRow'><input type='checkbox' class='prjSeq' value=" + data.userProjectList[i].prjSeq + " onclick='checkOne()'></td>"
	               		str += "<td class='numberRow'><button id='numberButton' onclick='edit(this)' name='" + data.userProjectList[i].prjSeq + "'>" + data.userProjectList[i].prjSeq + "</button></td>"
	               		str += "<td class='nameRow'>" + data.userProjectList[i].prjNm + "</td>"
	               		str += "<td class='customerRow'>" + customer + "</td>"
	               		str += "<td class='skillsRow'>" + skills + "</td>"
	               		str += "<td class='prjSTDTRow'>" + data.userProjectList[i].prjSTDT + "</td>"
	               		if(data.userProjectList[i].prjEDDT == null){
	               			str += "<td class='prjEDDTRow'>-</td>"
	               		} else {
	               			str += "<td class='prjEDDTRow'>" + data.userProjectList[i].prjEDDT + "</td>"
	               		}
	               		str += "<td class='usrPrjINDTRow'><input type='date' id='usrPrjINDT' value='" + data.userProjectList[i].usrPrjINDT + "'></td>"
	               		str += "<td class='usrPrjOTDTRow'><input type='date' id='usrPrjOTDT' value='" + data.userProjectList[i].usrPrjOTDT + "'></td>"
	               		str += "<td class='roleRow'>"
	               		str += "<select name='rlCD' id='rlCD'>"
	               		str += "<option value='0'>����</option>"
	               		
	               			console.log(codeList[0])
	               		
	               		for(var j = 0; j<codeList.length; j++){
	               			if(codeList[j].indexOf("mstCD=RL01") != -1){
	               				if(codeList[j].indexOf("dtCD=" + data.userProjectList[i].rlCD + ",") != -1){
	    		        			str += "<option value='" + codeList[j].substring(codeList[j].indexOf("dtCD=")+5, codeList[j].indexOf(", dtCDNM"))+"' selected>" + codeList[j].substring(codeList[j].indexOf("dtCDNM=")+7) + "</option>"
	    		        		} else {
	    		        			str += "<option value='" + codeList[j].substring(codeList[j].indexOf("dtCD=")+5, codeList[j].indexOf(", dtCDNM"))+"' >" + codeList[j].substring(codeList[j].indexOf("dtCDNM=")+7) + "</option>"
	    		        		}
			        			role = codeList[j].substring(codeList[j].indexOf("dtCDNM=")+7)
			        		}
	               		}
	               		str += "</select>"
	               		str += "</td>"
	               		str += "<td class='editRow'><button id='edit' onclick='edit(this)' name='" + data.userProjectList[i].prjSeq + "'>��/����</button></td>"
	              		str += "</tr>"
	                })
	                
	                if(data.beginPaging != 1){
		        		page += "<a href=getUserProjectList?pageNum=" + (data.beginPaging - 1) + ">����</a>"
		        	}
		        	
		        	for(var i = data.beginPaging; i <= data.endPaging; i++){
		        		if(i == data.pageNum){
		        			page += "<button style='font-size:2em' id='currentPage' class='page' value=" + i +">" + i + "</button>"
		        		} else {
		        			page += "<button class='page' value=" + i +" onclick='getUserProjectList(" + i + ")'>" + i + "</button>"
		        		}
		        	}
		        	
		        	if(data.endPaging != data.totalPaging){
		        		page += "<a href=getUserProjectList?pageNum=" + (data.endPaging + 1) + ">����</a>"
		        	}
		        	
		        } else {
		        	str += "<tr>"
		        	str += '<td colspan="11"><h3>�˻������ �����ϴ�.</h3></td>'
		        	str += "</tr>"
		        }
	        	
		        $("#checkAll").prop('checked',false)
	        	$("#tbody").append(str)
	        	$(".resultPage").append(page)
	        	$(".resultButton").append(save)
	        	$(".resultButton").append(add)
	        	$(".resultButton").append(del)
	        	$(".resultButton").append(cancel)
	        },
	        error: function() {
	            alert("��Ž���")
	        }
	    })
	}
	
	function goAddUserPage(){
		
		var usrSeq = $("#usrSeq").val()
		var usrNm = $("#usrNm").val()
		var grCD = $("#grCD").val()
		var stCD = $("#stCD").val()
		var minDT = $("#minDT").val()
		var maxDT = $("#maxDT").val()
		var currentPage = $("#currentPage").val()
		var skillArr = new Array()
		
		if(usrSeq == ""){
			usrSeq = 0
		}
		
		$(".skill").each(function(){
			if($(this).is(":checked")==true){
				skillArr.push($(this).val())
		    }
		})
		
		var skills
		
		for(var i = 0; i<skillArr.length; i++){
			skills += skillArr[i]
			if(i != skillArr.length - 1){
				skills += ","
			}
		}
		
		var newForm = $('<form></form>');
		
		newForm.attr("name","newForm");
		newForm.attr("method","post");
		newForm.attr("action","goAddUserPage");
		newForm.attr("target","_blank");

		newForm.append($('<input/>', {type: 'hidden', name: 'usrSeq', value:usrSeq }));
		newForm.append($('<input/>', {type: 'hidden', name: 'usrNm', value:usrNm }));
		newForm.append($('<input/>', {type: 'hidden', name: 'grCD', value:grCD }));
		newForm.append($('<input/>', {type: 'hidden', name: 'stCD', value:stCD }));
		newForm.append($('<input/>', {type: 'hidden', name: 'minDT', value:minDT }));
		newForm.append($('<input/>', {type: 'hidden', name: 'maxDT', value:maxDT }));
		newForm.append($('<input/>', {type: 'hidden', name: 'currentPage', value:currentPage }));
		newForm.append($('<input/>', {type: 'hidden', name: 'skills', value:maxDT }));

		newForm.appendTo('body');

		newForm.submit();
	}
	
	function save(){
		var usrSeq = $("#usrSeq").val()
		var prjSeqs = ""
		var usrPrjINDTs = ""
		var usrPrjOTDTs = ""
		var rlCDs = ""
		var index = 0
		
		if($(".prjSeq:checked").length > 0){
			$(".prjSeq").each(function(){
				if($(this).is(":checked")==true){
					var usrPrjINDT = $(this).parent().parent().find("#usrPrjINDT").val()
					var usrPrjOTDT = $(this).parent().parent().find("#usrPrjOTDT").val()
					var rlCD = $(this).parent().parent().find("#rlCD").val()
					
					if(usrPrjINDT == ""){
						usrPrjINDT = "none"
					}
					
					if(usrPrjOTDT == ""){
						usrPrjOTDT = "none"
					}
					
					if(index != 0){
						prjSeqs += ","
						usrPrjINDTs += ","
						usrPrjOTDTs += ","
						rlCDs += ","
					}
					
					prjSeqs += $(this).val()
					
					usrPrjINDTs += usrPrjINDT
					
					usrPrjOTDTs += usrPrjOTDT

					rlCDs += rlCD
					
					index += 1
				}
			})
				
			var param = "&prjSeqList=" + prjSeqs
			
			param += "&usrPrjINDTList=" + usrPrjINDTs
			
			param += "&usrPrjOTDTList=" + usrPrjOTDTs
			
			param += "&rlCDList=" + rlCDs
			
			param += "&usrSeq=" + usrSeq
			
			console.log("param : " + param)
			
			$.ajax({
		        url: "saveUserProject", 
		        type:"post",
		        data: param,
		        success: function(data) {
		        	if(data == 0){
		        		alert("���� �Ǿ����ϴ�.")
		        		getUserProjectList(1)
		        	} else {
		        		alert("������ �� �����ϴ�.")
		        	}
		        },
		        error: function() {
		            alert("��Ž���")
		        }
		    })
		} else {
			alert("�Ѱ� �̻��� �׸��� �������ּ���")
		}
		
	}
	
	function edit(e){
    	var url = "getProjectDetail"
    	var prjSeq = e.name
    	
        window.open("", "openForm", "width=1000px height=480px");
       
        let $form = $('<form></form>'); // �� �±� ����
        $form.attr('action', url); 		// �� �Ӽ� ����
        $form.attr("target", "openForm");
        $form.attr('method', 'post');
        
    	$form.append('<input type="hidden" name="prjSeq" value="' + prjSeq + '"/>')
        
        $form.appendTo('body'); // body�±׿� �߰�
        $form.submit(); // ����
	}
	
	function add(){
		
		var usrSeq = $("#usrSeq").val()
		var skills = '${userDTO.skills}'
		
    	var url = "goAddUserProject";
    	
        window.open("", "openForm", "width=1000px height=600px");
        
        let $form = $('<form></form>'); // �� �±� ����
        $form.attr('action', url); 		// �� �Ӽ� ����
        $form.attr("target", "openForm");
        $form.attr('method', 'post');
        
       	$form.append('<input type="hidden" name="usrSeq" value="' + usrSeq + '"/>')
       	$form.append('<input type="hidden" name="skills" value="' + skills + '"/>')
        
        $form.appendTo('body'); // body�±׿� �߰�
        $form.submit(); // ����
    }
	
	function del(){
		var usrSeq = $("#usrSeq").val()
	
		var prjSeqList = new Array()
		
		if($(".prjSeq:checked").length > 0){
			$(".prjSeq").each(function(){
				if($(this).is(":checked")==true){
					prjSeqList.push($(this).val())
				}
			})
				
			var param = "&prjSeqList="
				
			for(var i = 0; i<prjSeqList.length; i++){
				if(i != 0){
					param += ","
				}
				param += prjSeqList[i]
			}
			
			param += "&usrSeq=" + usrSeq
			
			$.ajax({
		        url: "delUserProject", 
		        type:"post",
		        data: param,
		        success: function(data) {
		        	if(data == 0){
		        		alert("���� �Ǿ����ϴ�.")
		        		getUserProjectList(1)
		        	} else {
		        		alert("����� �Ҽӵ� ������Ʈ�� ������ �� �����ϴ�.")
		        	}
		        },
		        error: function() {
		            alert("��Ž���")
		        }
		    })
		} else {
			alert("�Ѱ� �̻��� �׸��� �������ּ���")
		}
		
	}
	
	function checkOne(){
		var count = 0
		
		$(".prjSeq").each(function(){
			 if( $(this).is(":checked") == true ){
				 count += 1
			 }
		})
		
		if(count == $(".prjSeq").length){
			$("#checkAll").prop('checked',true)
		} else {
			$("#checkAll").prop('checked',false)
		}
	}
	
	function setSkills() {
		var skills = '${userDTO.skills}'
		
		var skillArr = skills.split(",")
		
		for(var i = 0; i<skillArr.length; i++){
			$("input[id=" + skillArr[i] + "]").prop('checked',true);
		}
		
	}
	
	function cancel() {
		window.history.back();
	}
	
	
</script>
<style>
main {
	display: flex;
	max-width: 1240px;
    margin: 0 auto;
}
	
section {
	background-color: white;
	width: 75%;
			
	display: flex;
	flex-direction: column;
	
	margin-top: 50px;
	margin-bottom: 50px;
	margin-right: 50px;
}

button {
	border: none;
	background-color: white;
	cursor: pointer;
}

input[type=text], select {
	width: 100px;
}
	
.middle {
	display: flex;
	
	margin-bottom: 50px;
	
	border: 2px solid lightgrey;
	
	width: 1240px;
}
	
.pageTitle {
	display: flex;
	align-items: center;
	background-color: white;
	
	padding-left: 10px;
	padding-right: 10px;
		
	height: 50px;
		
	position: relative;
	top: 25px;
	left: 20px;
	
	width: max-content;
	
	font-size: 150%;
}

.filterTitle {
	display: flex;
	align-items: center;
	background-color: white;
	
	padding-left: 10px;
	padding-right: 10px;
		
	height: 30px;
		
	position: relative;
	top: -15px;
	left: -10px;
	
	width: max-content;
	
	font-size: 150%;
}

.resultTitle {
	display: flex;
	align-items: center;
	background-color: white;
	
	padding-left: 10px;
	padding-right: 10px;
		
	position: relative;
	top: -15px;
	left: -10px;
	
	width: max-content;
	height: 30px;
	
	font-size: 150%;
}

.resultDetail {
	width:100%;
	overflow: auto;
}

.filter {
	heigth: 500px;
	
	margin-bottom: 50px;
	
	padding-left: 30px;
	padding-right: 30px;
	padding-bottom: 30px;
	
	border: 2px solid lightgrey;
}

.result {
	heigth: 500px;
	
	padding-left: 30px;
	padding-right: 30px;
	padding-bottom: 30px;
	
	border: 2px solid lightgrey;
}

.filterSection_1 {
	display: flex;
	justify-content: space-between;
	
	margin-bottom: 10px;
}

.filterSection_3 {
	display: flex;
	justify-content: space-between;
	
	margin-top: 10px;
	margin-bottom: 20px;
}

.filterSection_4 {
	display: flex;
	justify-content: center;
}

.inDT {
	margin-left: 6px;
	margin-right: 37px;
}

.skillText {
	margin-right: 5px;
}

#search {
	border: none;
	background-color: #0C70F2;
	color: white;
	
	font-weight: bold;
	font-size: 105%;
	
	width: 80px;
	height: 30px;
	
	cursor: pointer;
}

#save {
	display: flex;
	justify-content: center;
	align-items: center;

	border: none;
	background-color: #0C70F2;
	color: white;
	
	font-weight: bold;
	font-size: 105%;
	
	width: 80px;
	height: 30px;
	
	cursor: pointer;
	
	margin-right: 50px;
	
	text-decoration: none;
}

#add {
	display: flex;
	justify-content: center;
	align-items: center;

	border: none;
	background-color: grey;
	color: white;
	
	font-weight: bold;
	font-size: 105%;
	
	width: 80px;
	height: 30px;
	
	cursor: pointer;
	
	margin-right: 50px;
	
	text-decoration: none;
}

#del {
	border: none;
	background-color: red;
	color: white;
	
	font-weight: bold;
	font-size: 105%;
	
	width: 80px;
	height: 30px;
	
	margin-right: 50px;
	
	cursor: pointer;
}

#cancel {
	display: flex;
	justify-content: center;
	align-items: center;

	border: none;
	background-color: lightgrey;
	color: white;
	
	font-weight: bold;
	font-size: 105%;
	
	width: 80px;
	height: 30px;
	
	cursor: pointer;
	
	text-decoration: none;
}

#edit {
	display: flex;
	justify-content: center;
	align-items: center;

	border: none;
	background-color: #0C70F2;
	color: white;
	
	font-weight: bold;
	font-size: 80%;
	
	width: 100%;
	height: 18px;
	
	cursor: pointer;
	
	text-decoration: none;
}

#project {
	border: none;
	background-color: #0C70F2;
	color: white;
	
	font-weight: bold;
	font-size: 80%;
	
	width: 100px;
	height: 20px;
	
	cursor: pointer;
}

table {
	margin-bottom: 1%;
		
	border-collapse : collapse;
}
  	
table td, table th{
  	padding-left: 5px;
	padding-right: 5px;
	
	min-width: max-content;
	
	text-align: center;
		
	border: 2px solid lightgrey;
}
	
table th {
	background-color: #E4E4E4;
	color: black;
}

table .checkRow {
	min-width: 50px;
	text-align: center;
}

table .checkHead {
	min-width: 50px;
	text-align: center;
}

table .inDTRow, table .otDTRow {
	min-width: 100px;
	text-align: center;
}

table .prjSTDTHead, table .prjEDDTHead {
	min-width: 100px;
	text-align: center;
}

table .prjSTDTRow, table .prjEDDTRow {
	min-width: 100px;
	text-align: center;
}

table .usrPrjINDTHead, table .usrPrjOTDTHead {
	min-width: 100px;
	text-align: center;
}

table .skillsRow {
	min-width: 400px;
	text-align: left;
}

table .skillsHead {
	min-width: 400px;
	text-align: center;
}

table .nameRow {
	min-width: 200px;
	text-align: left;
}

table .nameHead {
	min-width: 200px;
	text-align: center;
}

table .numberRow {
	min-width: 120px;
	text-align: right;
}

table .numberHead {
	min-width: 120px;
	text-align: center;
}

table .customerRow {
	min-width: 120px;
	text-align: left;
}

table .customerHead {
	min-width: 120px;
	text-align: center;
}

table .editHead {
	min-width: 100px;
	text-align: center;
}

table .roleHead {
	min-width: 100px;
	text-align: center;
}

.resultPage {
	display: flex;
	justify-content: center;
}

.resultButtonWrap {
	display:flex;
	justify-content: center;
}

.resultButton {
	display:flex;
	
	margin-top: 30px;
	justify-content: center;
}

#usrSeq, #usrNm, #raCD, #grCD, #stCD {
	background-color: lightgrey;
}

.skill {
 	accent-color: lightgrey;
}

.resultPerPage {
	display: flex;
	flex-direction: row-reverse;
	margin-bottom: 10px;
}
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
	<div class="wrap">
		<div class="pageTitle"><h1>���� ������Ʈ ����</h1></div>
		<div class="middle">
			<jsp:include page="aside.jsp"/>
			<section>
				<div class="filter"> 
					<div class="filterTitle"><h1>��� ����</h1></div>
					<div class="filterDetail">
						<div class="filterSection_1">
							<small>�����ȣ</small>
							<input name="usrSeq" id="usrSeq" type="text" value="${userDTO.usrSeq}" readonly>
							<small>�����</small>
							<input name="usrNm" id="usrNm" type="text" value="${userDTO.usrNm}" readonly>
							<small>����</small>
							<input type="text" name="raCD" id="raCD" 
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'RA01' && item.dtCD == userDTO.raCD}">
										value="${item.dtCDNM}"
									</c:if>
								</c:forEach>
							readonly>
							<small>������</small>
							<input type="text" name="grCD" id="grCD"
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'GR01' && item.dtCD == userDTO.grCD}">
										value="${item.dtCDNM}"
									</c:if>
								</c:forEach>
							readonly>
							<small>��������</small>
							<input type="text" name="stCD" id="stCD"
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'ST01' && item.dtCD == userDTO.stCD}">
										value="${item.dtCDNM}"
									</c:if>
								</c:forEach>
							readonly>
						</div>
						<div class="filterSection_3">
							<small class="skillText">�������</small> 
							<c:forEach var="item" items="${codeList}" varStatus="i">
								<c:if test = "${item.mstCD == 'SK01'}">
									<input type="checkbox" class="skill" id="${item.dtCD}" value="${item.dtCD}" onClick="return false;">
									<label for="${item.dtCD}">${item.dtCDNM} </label>
								</c:if>
							</c:forEach>
						</div>
						<div class="filterSection_4">
							<button id="search">��ȸ</button>
						</div>
					</div>
				</div>
				<div class="result">
					<div class="resultTitle"><h1>�Ҽ� ������Ʈ</h1></div>
					<div class="resultPerPage">
						<select name="countPerPage" id="countPerPage">
							<option value="5">5���� ����</option>
							<option value="10">10���� ����</option>
						</select>
					</div>
					<div class="resultDetail">
						<table>
							<thead>
								<tr>
									<th class="checkHead"><input type="checkbox" id="checkAll"></th>
									<th class="numberHead">������Ʈ��ȣ</th>
									<th class="nameHead">������Ʈ��</th>
									<th class="customerHead">�����</th>
									<th class="skillsHead">�ʿ���</th>
									<th class="prjSTDTHead">������</th>
									<th class="prjEDDTHead">������</th>
									<th class="usrPrjINDTHead">������</th>
									<th class="usrPrjOTDTHead">ö����</th>
									<th class="roleHead">����</th>
									<th class="editHead">��/����</th>
								</tr>
							</thead>
							<tbody id="tbody">
								<tr>
									<td colspan="11"><h3>��ȸ�� �ʿ��մϴ�.</h3></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="resultPage">
						
					</div>
					<div class="resultButtonWrap">
						<div class="resultButton">
					
						</div>
					</div>
				</div>
			</section>
		</div>
		
	</div>
	
</main>
</body>
</html>