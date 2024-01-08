<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
<script>
	$(function(){

		$("#checkAll").change(function(){
			if($(this).is(":checked") == true){
				$(".usrSeq").each(function(){
					$(this).prop('checked',true)
				})
			} else {
				$(".usrSeq").each(function(){
					$(this).prop('checked',false)
				})
			}
		})
	})
	
	function search(){
		getAddProjectUserList(1)
	}
	
	function add(){
		var prjSeq = '${userProjectDTO.prjSeq}'
		
		var usrSeqList = new Array()
		
		
		if($(".usrSeq:checked").length > 0){
			$(".usrSeq").each(function(){
				if($(this).is(":checked")==true){
					usrSeqList.push($(this).val())
				}
			})
				
			var param = "&usrSeqList="
				
			for(var i = 0; i<usrSeqList.length; i++){
				if(i != 0){
					param += ","
				}
				param += usrSeqList[i]
			}
			
			param += "&prjSeq=" + prjSeq
			
			$.ajax({
		        url: "addProjectUser", 
		        type:"post",
		        data: param,
		        success: function(data) {
		        	if(data == 0){
			        	alert("�߰� �Ǿ����ϴ�.")
			        	getAddProjectUserList(1)
			        	opener.getProjectUserList(1)
		        	} else {
		        		alert("������ �߻��Ͽ����ϴ�.")
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
	
	function cancel(){
		window.close()
	}
	
	function getAddProjectUserList(pageNum){
		
		var usrSeq = '${userProjectDTO.usrSeq}'
		var skills = '${userProjectDTO.skills}'
		
		
		var usrSeq = $("#usrSeq").val()
		var usrNm = $("#usrNm").val()
		var grCD = $("#grCD").val()
		var stCD = $("#stCD").val()
		var skills = new Array()
		
		if(usrSeq == ""){
			usrSeq = 0
		}
		
		var param = "usrSeq="+usrSeq
		param += "&usrNm="+usrNm
		param += "&grCD="+grCD
		param += "&stCD="+stCD
		param += "&skills="+'${userProjectDTO.skills}'
		param += "&prjSeq="+'${userProjectDTO.prjSeq}'
		
		
		param += "&pageNum="+pageNum
		
		console.log("param = " + param)
		
		$.ajax({
	        url: "getAddProjectUserList", 
	        type:"post",
	        data: param,
	        success: function(data) {
	        	var str = ""
	        	var page = ""
	        	var add = "<button id='add' onclick='add()'>�߰�</button>"
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
	        	
	        	console.log("codeList = " + codeList)
	        	
		        $("#tbody").empty()
		        $(".resultPage").empty()
		        $(".resultButton").empty()
		        
		        if(data.projectUserList.length >= 1){
		        	$.each(data.projectUserList, function(i){
		        		var rank
		        		var grade
		        		var status
		        		var skills = ""
		        		
		        		var skillArr = data.projectUserList[i].skills.split(",")
		        		
		        		for(var j = 0; j<codeList.length; j++){
		        			if(codeList[j].indexOf("mstCD=RA01") != -1 && codeList[j].indexOf("dtCD=" + data.projectUserList[i].raCD + ",") != -1){
		        				rank = codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
		        			}
		        			
		        			if(codeList[j].indexOf("mstCD=GR01") != -1 && codeList[j].indexOf("dtCD=" + data.projectUserList[i].grCD + ",") != -1){
		        				grade = codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
		        			}
		        			
		        			if(codeList[j].indexOf("mstCD=ST01") != -1 && codeList[j].indexOf("dtCD=" + data.projectUserList[i].stCD + ",") != -1){
		        				status = codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
		        			}
		        			
		        			for(var k = 0; k<skillArr.length; k++){
		        				if(codeList[j].indexOf("mstCD=SK01") != -1 && codeList[j].indexOf("dtCD=" + skillArr[k] + ",") != -1){
		        					if(k != 0){
			        					skills += ", "
			        				}
		        					skills += codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
			        			}
		        			}
		        		}
		        		
	                	str += "<tr>"
	                	str += "<td class='checkRow'><input type='checkbox' class='usrSeq' value=" + data.projectUserList[i].usrSeq + " onclick='checkOne()'></td>"
	               		str += "<td class='numberRow'><a href='getUserDetail?usrSeq=" + data.projectUserList[i].usrSeq +"'>" + data.projectUserList[i].usrSeq + "</a></td>"
	               		str += "<td class='nameRow'>" + data.projectUserList[i].usrNm + "</td>"
	               		if(rank == undefined){
	               			str += "<td class='rankRow'>-</td>"
	               		} else {
	               			str += "<td class='rankRow'>" + rank + "</td>"
	               		}
	               		if(grade == undefined){
	               			str += "<td class='gradeRow'>-</td>"
	               		} else {
	               			str += "<td class='gradeRow'>" + grade + "</td>"
	               		}
	               		if(status == undefined){
	               			str += "<td class='statusRow'>-</td>"
	               		} else {
	               			str += "<td class='statusRow'>" + status + "</td>"
	               		}
	               		str += "<td class='skillsRow'>" + skills + "</td>"
	              		str += "</tr>"
	                })
	                
		        	if(data.beginPaging != 1){
		        		page += "<a href=getAddProjectUserList?pageNum=" + (data.beginPaging - 1) + ">����</a>"
		        	}
		        	
		        	for(var i = data.beginPaging; i <= data.endPaging; i++){
		        		if(i == data.pageNum){
		        			page += "<button style='font-size:2em' class='page' value=" + i +">" + i + "</button>"
		        		} else {
		        			page += "<button class='page' value=" + i +" onclick='getAddProjectUserList(" + i + ")'>" + i + "</button>"
		        		}
		        	}
		        	
		        	if(data.endPaging != data.totalPaging){
		        		page += "<a href=getAddProjectUserList?pageNum=" + (data.endPaging + 1) + ">����</a>"
		        	}
		        	
		        } else {
		        	str += "<tr>"
		        	str += '<td colspan="9"><h3>�˻������ �����ϴ�.</h3></td>'
		        	str += "</tr>"
		        }
	        	
	        	$("#checkAll").prop('checked',false)
	        	$("#tbody").append(str)
	        	$(".resultPage").append(page)
	        	$(".resultButton").append(add)
	        	$(".resultButton").append(cancel)
	        },
	        error: function() {
	            alert("��Ž���")
	        }
	    })
	}
	
	function delProject(){
		var prjSeqList = new Array()
		$(".prjSeq").each(function(){
			if($(this).is(":checked")==true){
				prjSeqList.push($(this).val())
		    }
		})
		
		var param = "&prjSeqList="
		
		for(var i = 0; i<prjSeqList.length; i++){
			param += prjSeqList[i]
			if(i != prjSeqList.length - 1){
				param += ","
			}
		}
		
		console.log("param : " + param)
		
		$.ajax({
	        url: "delProject", 
	        type:"post",
	        data: param,
	        success: function(data) {
	        	if(data == 0){
	        		alert("���� �Ǿ����ϴ�.")
	        		getUserList(1)
	        	} else {
	        		alert("�ش� ������Ʈ�� ���� �ҼӵǾ��ִ� �ο��� �ֽ��ϴ�.")
	        	}
	        },
	        error: function() {
	            alert("��Ž���")
	        }
	    })
	}
	
	function checkOne(){
		var count = 0
		
		$(".usrSeq").each(function(){
			 if( $(this).is(":checked") == true ){
				 count += 1
			 }
		})
		
		if(count == $(".usrSeq").length){
			$("#checkAll").prop('checked',true)
		} else {
			$("#checkAll").prop('checked',false)
		}
	}
</script>
<style>
main {
	display: flex;
	width: 100%;
}
	
section {
	background-color: white;
	width: 100%;
			
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

.filterSection_2 {
	display: flex;
	justify-content: space-between;
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
	
	margin-top: 30px;
	
	cursor: pointer;
}

#add {
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
	
	margin-right: 50px;
	
	cursor: pointer;
	
	text-decoration: none;
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

#del {
	border: none;
	background-color: red;
	color: white;
	
	font-weight: bold;
	font-size: 105%;
	
	width: 80px;
	height: 30px;
	
	cursor: pointer;
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
	
	width: 80px;
	height: 18px;
	
	cursor: pointer;
	
	text-decoration: none;
}

#user {
	border: none;
	background-color: #0C70F2;
	color: white;
	
	font-weight: bold;
	font-size: 80%;
	
	width: 80px;
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

table .statusRow, table .rankRow, table .gradeRow{
	min-width: 100px;
	text-align: center;
}

table .statusHead, table .rankHead, table .gradeHead {
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

table .editHead {
	min-width: 100px;
	text-align: center;
}

table .userHead {
	min-width: 120px;
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
	justify-content: center;
	
	margin-top: 30px;
}

.filterWrap {
	display: flex;
	justify-content: space-between;
	width: 200px;
}

.dateWrap {
	display: flex;
	justify-content: space-between;
	width: 400px;
}
</style>
</head>
<body>
<main>
<section>
	<div class="filter"> 
		<div class="filterTitle"><h1>�˻� ����</h1></div>
		<div class="filterDetail">
			<div class="filterSection_1">
				<div class="filterWrap">
					<small>�����ȣ</small>
					<input name="usrSeq" id="usrSeq" type="text">
				</div>
				<div class="filterWrap">
					<small>�����</small>
					<input name="usrNm" id="usrNm" type="text">
				</div>
				<div class="filterWrap">
					<small>������</small>
					<select name="grCD" id="grCD">
						<option value="0">����</option>
						<c:forEach var="item" items="${codeList}" varStatus="i">
							<c:if test = "${item.mstCD == 'GR01'}">
								<option value="${item.dtCD}">${item.dtCDNM}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="filterWrap">
					<small>��������</small>
					<select name="stCD" id="stCD">
						<option value="0">����</option>
						<c:forEach var="item" items="${codeList}" varStatus="i">
							<c:if test = "${item.mstCD == 'ST01'}">
								<option value="${item.dtCD}">${item.dtCDNM}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="filterSection_4">
				<button id="search" onclick="search()">��ȸ</button>
			</div>
		</div>
	</div>
	<div class="result">
		<div class="resultTitle"><h1>�˻� ���</h1></div>
		<div class="resultDetail">
			<table>
				<thead>
					<tr>
						<th class="checkHead"><input type="checkbox" id="checkAll"></th>
						<th class="numberHead">�����ȣ</th>
						<th class="nameHead">�����</th>
						<th class="rankHead">����</th>
						<th class="gradeHead">������</th>
						<th class="statusHead">��������</th>
						<th class="skillsHead">�������</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<tr>
						<td colspan="9"><h3>��ȸ�� �ʿ��մϴ�.</h3></td>
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
</main>
</body>
</html>