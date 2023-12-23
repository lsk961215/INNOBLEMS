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
			getUserList(1)
		})
		
		$("#minDT").change(function(){
			$("#maxDT").attr("min", $(this).val())
		})
		
		$("#maxDT").change(function(){
			$("#minDT").attr("max", $(this).val())
		})
	})
	
	function getUserList(pageNum){
		var usrSeq = $("#usrSeq").val()
		var usrNm = $("#usrNm").val()
		var grCD = $("#grCD").val()
		var stCD = $("#stCD").val()
		var minDT = $("#minDT").val()
		var maxDT = $("#maxDT").val()
		var skills = new Array()
		
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
		
		param += "&pageNum="+pageNum
		
		console.log("param : " + param)
		
		$.ajax({
	        url: "getUserList", 
	        type:"post",
	        data: param,
	        success: function(data) {
	        	var str = ""
	        	var page = ""
	        	var add = "<button id='add' onclick='addUser()'>추가</button>"
	        	var del = "<button id='del' onclick='delUser()'>삭제</button>"
	        	
	        	
	        	/* model 에서 toString() 으로 받아온 문자열을 배열로 파싱 */
	        	var codeList = '${codeList}'
	        	
	        	codeList = codeList.substring(1, codeList.length-1)
	        	codeList = codeList.split("codeDTO")
	        	codeList.shift()
	        	
	        	for(var i = 0; i<codeList.length; i++){
	        		var str = codeList[i]
	        		
	        		codeList[i] = str.substring(2, str.length-3)
	        	}
	        	
	        	console.log(codeList)
	        	
		        $("#tbody").empty()
		        $(".resultPage").empty()
		        $(".resultButton").empty()
		        
		        if(data.userList.length >= 1){
		        	$.each(data.userList, function(i){
		        		var rank
		        		var grade
		        		var status
		        		var skills = ""
		        		
		        		var skillArr = data.userList[i].skills.split(",")
		        		
		        		console.log(skillArr)
		        		
		        		for(var j = 0; j<codeList.length; j++){
		        			if(codeList[j].indexOf("mstCD=RA01") != -1 && codeList[j].indexOf("dtCD=" + data.userList[i].raCD + ",") != -1){
		        				rank = codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
		        			}
		        			if(codeList[j].indexOf("mstCD=GR01") != -1 && codeList[j].indexOf("dtCD=" + data.userList[i].grCD + ",") != -1){
		        				grade = codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
		        			}
		        			if(codeList[j].indexOf("mstCD=ST01") != -1 && codeList[j].indexOf("dtCD=" + data.userList[i].stCD + ",") != -1){
		        				status = codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
		        			}
		        			
		        			for(var k = 0; k<skillArr.length; k++){
		        				if(codeList[j].indexOf("mstCD=SK01") != -1 && codeList[j].indexOf("dtCD=" + skillArr[k] + ",") != -1){
			        				skills += codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
			        				if(k != skillArr.length-1){
			        					skills += ","
			        				}
			        			}
		        			}
		        		}
		        		
	                	str += "<tr>"
	                	str += "<td><input type='checkbox' class='usrSeq' value=" + data.userList[i].usrSeq + "></td>"
	               		str += "<td>" + data.userList[i].usrSeq + "</td>"
	               		str += "<td>" + data.userList[i].usrINDT + "</td>"
	               		str += "<td>" + rank + "</td>"
	               		str += "<td>" + data.userList[i].usrNm + "</td>"
	               		str += "<td>" + grade + "</td>"
	               		str += "<td>" + skills + "</td>"
	               		str += "<td>" + status + "</td>"
	               		str += '<td><input id="edit" type="button" value="상세/수정"></td>'
	              		str += '<td><input id="project" type="button" value="프로젝트 관리"></td>'
	              		str += "</tr>"
	                })
	                
		        	if(data.beginPaging != 1){
		        		page += "<a href=getUserList?pageNum=" + (data.beginPaging - 1) + ">이전</a>"
		        	}
		        	
		        	for(var i = data.beginPaging; i <= data.endPaging; i++){
		        		if(i == data.pageNum){
		        			page += "<button style='font-size:2em' class='page' value=" + i +">" + i + "</button>"
		        		} else {
		        			page += "<button class='page' value=" + i +" onclick='getUserList(" + i + ")'>" + i + "</button>"
		        		}
		        	}
		        	
		        	if(data.endPaging != data.totalPaging){
		        		page += "<a href=getUserList?pageNum=" + (data.endPaging + 1) + ">다음</a>"
		        	}
		        	
		        } else {
		        	str += "<tr>"
		        	str += '<td colspan="10"><h3>검색결과가 없습니다.</h3></td>'
		        	str += "</tr>"
		        }
	        	
	        	$("#tbody").append(str)
	        	$(".resultPage").append(page)
	        	$(".resultButton").append(add)
	        	$(".resultButton").append(del)
	        },
	        error: function() {
	            alert("통신실패")
	        }
	    })
	}
	
	function delUser(){
		var usrSeqList = new Array()
		
		$(".usrSeq").each(function(){
			if($(this).is(":checked")==true){
				usrSeqList.push($(this).val())
		    }
		})
		
		var param = "&usrSeqList="
		
		for(var i = 0; i<usrSeqList.length; i++){
			param += usrSeqList[i]
			if(i != usrSeqList.length - 1){
				param += ","
			}
		}
		
		console.log("param : " + param)
		
		$.ajax({
	        url: "delUser", 
	        type:"post",
	        data: param,
	        success: function(data) {
	        	if(data == 0){
	        		alert("삭제 되었습니다.")
	        		getUserList(1)
	        	} else {
	        		alert("해당 사원은 현재 소속되어있는 프로젝트가 있습니다.")
	        	}
	        },
	        error: function() {
	            alert("통신실패")
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

.resultPage {
	display: flex;
	justify-content: center;
}

.resultButtonWrap {
	display:flex;
	justify-content: center;
}

.resultButton {
}
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
	<div class="wrap">
		<div class="pageTitle"><h1>사원 관리</h1></div>
		<div class="middle">
			<jsp:include page="aside.jsp"/>
			<section>
				<div class="filter"> 
					<div class="filterTitle"><h1>검색 조건</h1></div>
					<div class="filterDetail">
						<div class="filterSection_1">
							<small>사원번호</small>
							<input name="usrSeq" id="usrSeq" type="text">
							<small>사원명</small>
							<input name="usrNm" id="usrNm" type="text">
							<small>기술등급</small>
							<select name="grCD" id="grCD">
								<option value="0">선택</option>
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'GR01'}">
										<option value="${item.dtCD}">${item.dtCDNM}</option>
									</c:if>
								</c:forEach>
							</select>
							<small>재직상태</small>
							<select name="stCD" id="stCD">
								<option value="0">선택</option>
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'ST01'}">
										<option value="${item.dtCD}">${item.dtCDNM}</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<div class="filterSection_2">
							<small class="inDT">입사일</small> <input id="minDT" type="date"> ~ <input id="maxDT" type="date">
						</div>
						<div class="filterSection_3">
							<small class="skillText">보유기술</small> 
							<c:forEach var="item" items="${codeList}" varStatus="i">
								<c:if test = "${item.mstCD == 'SK01'}">
									<input type="checkbox" class="skill" value="${item.dtCD}"> <small>${item.dtCDNM}</small> 
								</c:if>
							</c:forEach>
						</div>
						<div class="filterSection_4">
							<button id="search">조회</button>
						</div>
					</div>
				</div>
				<div class="result">
					<div class="resultTitle"><h1>사원 리스트</h1></div>
					<div class="resultDetail">
						<table>
							<thead>
								<tr>
									<th><input type="checkbox"></th>
									<th>사원번호</th>
									<th>입사일</th>
									<th>직급</th>
									<th>사원명</th>
									<th>기술등급</th>
									<th>보유기술</th>
									<th>재직상태</th>
									<th>상세/수정</th>
									<th>프로젝트관리</th>
								</tr>
							</thead>
							<tbody id="tbody">
								<tr>
									<td colspan="10"><h3>데이터가 없습니다.</h3></td>
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