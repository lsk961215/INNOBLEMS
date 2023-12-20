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
			$("#maxDT").attr("min", $(this).val())
		})
		
		$("#maxDT").change(function(){
			$("#minDT").attr("max", $(this).val())
		})
	})
	
	var getUserList = function(){
		
		var usrSeq = $("#usrSeq").val()
		var usrNm = $("#usrNm").val()
		var grCD = $("#grCD").val()
		var stCD = $("#stCD").val()
		var minDT = $("#minDT").val()
		var maxDT = $("#maxDT").val()
		var skills = new Array();
		
		if(usrSeq == ""){
			usrSeq = 0
		}
		
		$(".skill").each(function(){
			if($(this).is(":checked")==true){
				skills.push($(this).val())
		    }
		})
		
		var param = "usrSeq="+usrSeq
		param += "&usrNm="+usrNm
		param += "&grCD="+grCD
		param += "&stCD="+stCD
		param += "&minDT="+minDT
		param += "&maxDT="+maxDT
		param += "&skills="
		
		for(var i = 0; i<skills.length; i++){
			param += skills[i]
			if(i != skills.length - 1){
				param += ","
			}
		}
		
		console.log("param : " + param)
		
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
	               		str += "<td>" + data[i].skills + "</td>"
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
	
	margin-bottom: 50px;
	margin-left: 100px;
	margin-right: 50px;
	
	border: 2px solid lightgrey;
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
	left: 130px;
	
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
	margin-right: 4px;
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
	<div class="wrap">
		<div class="pageTitle"><h1>��� ����</h1></div>
		<div class="middle">
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
							<small class="skillText">�������</small> 
							<input type="checkbox" class="skill" value="1" name="Java"> <small>Java</small> <input type="checkbox" class="skill" value="2" name="JavaScript"> <small>JavaScript</small>
							<input type="checkbox" class="skill" value="3" name="Spring"> <small>Spring</small> <input type="checkbox" class="skill" value="4" name="HTML/CSS"> <small>HTML/CSS</small>
							<input type="checkbox" class="skill" value="5" name="jQuery"> <small>jQuery</small> <input type="checkbox" class="skill" value="6" name="JSP"> <small>JSP</small>
							<input type="checkbox" class="skill" value="7" name="SQL"> <small>SQL</small> <input type="checkbox" class="skill" value="8" name="React"> <small>React</small>
							<input type="checkbox" class="skill" value="9" name="Kotlin"> <small>Kotlin</small> <input type="checkbox" class="skill" value="10" name="C#"> <small>C#</small>
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
		
	</div>
	
</main>
</body>
</html>