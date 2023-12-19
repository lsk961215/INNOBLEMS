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
		$("#search").click(function(){
			getUserList()
		})
		
		$("#minDT").change(function(){
			console.log("min Hi")
		})
	})
	
	var getUserList = function(){
		
		var usrSeq = $("#usrSeq").val()
		var usrNm = $("#usrNm").val()
		var grCD = $("#grCD").val()
		var stCD = $("#stCD").val()
		
		if(usrSeq == ""){
			usrSeq = 0
		}
		
		var param = "usrSeq="+usrSeq
		param += "&usrNm="+usrNm
		param += "&grCD="+grCD
		param += "&stCD="+stCD
		
		$.ajax({
	        url: "getUserList", 
	        type:"post",
	        data: param,
	        success: function(data) {
	        	var str = ""
		        $("#tbody").empty()
		        if(data.length >= 1){
		        	$.each(data, function(i){
	                	str += "<tr>"
	                	str += "<td><input type='checkbox' name=" + data[i].usrSeq + "></td>"
	               		str += "<td>" + data[i].usrSeq + "</td>"
	               		str += "<td>" + data[i].usrINDT + "</td>"
	               		str += "<td>" + data[i].raCD + "</td>"
	               		str += "<td>" + data[i].usrNm + "</td>"
	               		str += "<td>" + data[i].grCD + "</td>"
	               		str += "<td></td>"
	               		str += "<td>" + data[i].stCD + "</td>"
	               		str += '<td><input id="edit" type="button" value="��/����"></td>'
	              		str += '<td><input id="project" type="button" value="������Ʈ ����"></td>'
	              		str += "</tr>"
	                });
		        } else {
		        	str += "<tr>"
		        	str += '<td colspan="10"><h3>�˻������ �����ϴ�.</h3></td>'
		        	str += "</tr>"
		        }
	        	$("#tbody").append(str)
	        },
	        error: function() {
	            alert("��Ž���")
	        }
	    })
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
	width: 80%;
			
	display: flex;
	flex-direction: column;
	
	margin-top: 50px;
	margin-bottom: 50px;
	margin-right: 50px;
}

input[type=text], select {
	width: 100px;
}
	
.middle {
	display: flex;
	margin: 50px;
	border: 2px solid lightgrey;
}
	
.pageTitle {
	display: flex;
	align-items: center;
	background-color: white;
	
	padding-left: 10px;
	padding-right: 10px;
		
	height: 60px;
		
	position: absolute;
	top: 130px;
	left: 90px;
	
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
	margin-right: 16px;
}

.skill {
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

#edit {
	border: none;
	background-color: #0C70F2;
	color: white;
	
	font-weight: bold;
	font-size: 80%;
	
	width: 80px;
	height: 20px;
	
	cursor: pointer;
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
	
	width: 100%;
		
	border-collapse : collapse;
}
  	
table td, table th{
  	padding-left: 5px;
	padding-right: 5px;
		
	border: 2px solid lightgrey;
}
	
table th {
	background-color: #E4E4E4;
	color: black;
}
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
	<div class="middle">
		<div class="pageTitle"><h1>��� ����</h1></div>
		<jsp:include page="aside.jsp"/>
		<section>
			<div class="filter"> 
				<div class="filterTitle"><h1>�˻� ����</h1></div>
				<div class="filterDetail">
					<div class="filterSection_1">
						<small>�����ȣ</small>
						<input name="usrSeq" id="usrSeq" type="text">
						<small>�����</small>
						<input name="usrNm" id="usrNm" type="text">
						<small>������</small>
						<select name="grCD" id="grCD">
							<option value="0">����</option>
							<option value="1">�ʱ�</option>
							<option value="2">�߱�</option>
							<option value="3">���</option>
						</select>
						<small>��������</small>
						<select name="stCD" id="stCD">
							<option value="0">����</option>
							<option value="1">����</option>
							<option value="2">�ް�</option>
							<option value="3">����</option>
						</select>
					</div>
					<div class="filterSection_2">
						<small class="inDT">�Ի���</small> <input id="minDT" type="date"> ~ <input id="maxDT" type="date">
					</div>
					<div class="filterSection_3">
						<small class="skill">�������</small> 
						<input type="checkbox" name="Java"> <small>Java</small> <input type="checkbox" name="JavaScript"> <small>JavaScript</small>
						<input type="checkbox" name="Spring"> <small>Spring</small> <input type="checkbox" name="HTML/CSS"> <small>HTML/CSS</small>
						<input type="checkbox" name="jQuery"> <small>jQuery</small> <input type="checkbox" name="JSP"> <small>JSP</small>
						<input type="checkbox" name="SQL"> <small>SQL</small> <input type="checkbox" name="React"> <small>React</small>
						<input type="checkbox" name="Kotlin"> <small>Kotlin</small> <input type="checkbox" name="C#"> <small>C#</small>
					</div>
					<div class="filterSection_4">
						<input id="search" type="button" value="��ȸ">
					</div>
				</div>
			</div>
			<div class="result">
				<div class="resultTitle"><h1>��� ����Ʈ</h1></div>
				<div class="resultDetail">
					<table>
						<thead>
							<tr>
								<th><input type="checkbox"></th>
								<th>�����ȣ</th>
								<th>�Ի���</th>
								<th>����</th>
								<th>�����</th>
								<th>������</th>
								<th>�������</th>
								<th>��������</th>
								<th>��/����</th>
								<th>������Ʈ����</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<tr>
								<td colspan="10"><h3>�����Ͱ� �����ϴ�.</h3></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</section>
	</div>
	
</main>
</body>
</html>