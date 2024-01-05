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
		$("#prjSTDT").change(function(){
			$("#prjEDDT").attr("min", $(this).val())
		})
		
		$("#prjEDDT").change(function(){
			$("#prjSTDT").attr("max", $(this).val())
		})
	})	
	
	function add(){
        
		var prjNm = $("#prjNm").val()
		var prjSTDT = $("#prjSTDT").val()
		var prjEDDT = $("#prjEDDT").val()
		var cusCD = $("#cusCD").val()
		var prjNote = $("#prjNote").val()
		var skills = new Array()
		
		$(".skill").each(function(){
			if($(this).is(":checked")==true){
				skills.push($(this).val())
		    }
		})
               
        var param = "prjNm="+prjNm
	    param += "&prjSTDT="+prjSTDT
	    param += "&prjEDDT="+prjEDDT
	    param += "&cusCD="+cusCD
	    param += "&prjNote="+prjNote
	    param += "&skills="
	       		
	    for(var i = 0; i<skills.length; i++){
	       	param += skills[i]
	       	if(i != skills.length - 1){
	       		param += ","
	       	}
	    }
               
        console.log("param" + param)
               
        $.ajax({
			url: "addProject", 
			type:"post",
			data: param,
			success: function(data) {
				alert("��ϵǾ����ϴ�.")
				opener.getProjectList(1)
			},
			error: function() {
			    alert("��Ž���")
			}
		})
	}
	
	function cancel() {
		window.close();
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
	
	margin-top: 25px;
	
	border: 2px solid lightgrey;
	
	margin-top: 25px;
	
	padding-right: 50px;
	padding-left: 50px;
	padding-bottom: 50px;
}

button {
	border: none;
	background-color: white;
	cursor: pointer;
}

table input[type=text], table input[type=password] {
	width: 95%;
}

select {
	width: 80%;
}

table {
	width: 100%;
	
	margin-top: 10px;
	
	font-size: 80%;
}

table td{
	min-width: 100px;
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
	top: -25px;
	
	width: max-content;
	
	font-size: 150%;
}

#add {
	border: none;
	background-color: #0C70F2;
	color: white;
	
	font-weight: bold;
	font-size: 105%;
	
	width: 80px;
	height: 30px;
	
	cursor: pointer;
	
	margin-right: 50px;
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
	
	margin-right: 50px;
	
	text-decoration: none;
}

#search {
	border: none;
	background-color: #0C70F2;
	color: white;
	
	font-weight: bold;
	
	width: 80px;
	height: 20px;
	
	cursor: pointer;
}

.buttonSection {
	display: flex;
	justify-content: center;
	
	margin-top: 50px;
}

.imgSection {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.sectionMain {
	display: flex;
}

#img {
	max-width: 200px;
	max-heigth: 200px;
	
	border: 2px solid lightgrey;
}

.imgLabel {
 	border: none;
	background-color: #0C70F2;
	color: white;
	
	font-weight: bold;
	font-size: 105%;
	
	width: 100px;
	height: 30px;
    cursor: pointer;
    
    display: flex;
	align-items: center;
	justify-content: center;
	
	margin-top: 30px;
}

#file1, #btn_submit {
	display: none;
}

.detailSection {
	border: 2px solid lightgrey;
	
	width: 100%;
	
	padding: 30px;
}

.skills {
	display: flex;
	flex-wrap: wrap;
}
.star {
	color: red;
}
</style>
</head>
<body>
<main>
			<section>
			<div class="pageTitle"><h1>������Ʈ ���</h1></div>
				<div class="sectionMain">
					<div class="detailSection">
						<small class="essential"><a class="star">*</a>�� �ʼ��׸�</small>
						<table>
					    	<tr>
					    		<td>������Ʈ��<a class="star">*</a></td>
					    		<td><input type="text" id="prjNm" maxlength="33"></td>
					    	</tr> 
					    	<tr>
					    		<td>������<a class="star">*</a></td>
					    		<td><input type="date" id="prjSTDT"></td>
					    	</tr> 
					    	<tr>
					    		<td>������</td>
					    		<td><input type="date" id="prjEDDT"></td>
					    	</tr> 
					    	<tr>
					    		<td>�������<a class="star">*</a></td>
					    		<td>
					    			<select name="cusCD" id="cusCD">
										<option value="0">����</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'CU01'}">
												<option value="${item.dtCD}">${item.dtCDNM}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
					    	</tr> 
					    	<tr>
					    		<td>�ʿ���<a class="star">*</a></td>
					    		<td>
						    		<div class="skills">
						    			<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'SK01'}">
												<div>
													<input type="checkbox" class="skill" id="${item.dtCD}" value="${item.dtCD}">
													<label for="${item.dtCD}">${item.dtCDNM} </label>
												</div>
											</c:if>
										</c:forEach>
						    		</div>
					    		</td>
					    	</tr>
					    	<tr>
					    		<td>���</td>
					    		<td>
						    		<input id="prjNote" type="text">
					    		</td>
					    	</tr>
						</table>
					</div>
				</div>
				<div class="buttonSection">
					<button id="add" onclick="add()">���</button>
					<button id="cancel" onclick="cancel()">���</button>
				</div>
				
			</section>
</main>
</body>
</html>