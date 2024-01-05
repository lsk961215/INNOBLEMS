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
			if($("#maxSTDT").val() >= $("#minSTDT").val() && $("#maxEDDT").val() >= $("#minEDDT").val()){
				getProjectList(1)
			} else {
				alert("날짜값이 올바르지 않습니다.")
			}
		})
		
		$("#minSTDT").change(function(){
			$("#maxSTDT").attr("min", $(this).val())
		})
		
		$("#minSTDT").focusout(function(){
			if($(this).val() < $("#maxSTDT").val() || $("#maxSTDT").val() == 0){
				
			} else {
				alert("날짜값이 올바르지 않습니다.")
			}
		})
		
		$("#minEDDT").change(function(){
			$("#maxEDDT").attr("min", $(this).val())
		})
		
		$("#minEDDT").focusout(function(){
			if($(this).val() < $("#maxEDDT").val() || $("#maxEDDT").val() == 0){
				
			} else {
				alert("날짜값이 올바르지 않습니다.")
			}
		})
		
		$("#maxSTDT").change(function(){
			$("#minSTDT").attr("max", $(this).val())
		})
		
		$("#maxSTDT").focusout(function(){
			if($(this).val() < $("#maxSTDT").val() || $("#maxSTDT").val() == 0){
				
			} else {
				alert("날짜값이 올바르지 않습니다.")
			}
		})
		
		$("#maxEDDT").change(function(){
			$("#minEDDT").attr("max", $(this).val())
		})
		
		$("#maxEDDT").focusout(function(){
			if($(this).val() < $("#maxEDDT").val() || $("#maxEDDT").val() == 0){
				
			} else {
				alert("날짜값이 올바르지 않습니다.")
			}
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
	
	function getProjectList(pageNum){
		var prjSeq = $("#prjSeq").val()
		var prjNm = $("#prjNm").val()
		var cusCD = $("#cusCD").val()
		var minSTDT = $("#minSTDT").val()
		var maxSTDT = $("#maxSTDT").val()
		var minEDDT = $("#minEDDT").val()
		var maxEDDT = $("#maxEDDT").val()
		var skills = new Array()
		
		if(prjSeq == ""){
			prjSeq = 0
		}
		
		$(".skill").each(function(){
			if($(this).is(":checked")==true){
				skills.push($(this).val())
		    }
		})
		
		var param = "prjSeq="+prjSeq
		param += "&prjNm="+prjNm
		param += "&cusCD="+cusCD
		param += "&minSTDT="+minSTDT
		param += "&maxSTDT="+maxSTDT
		param += "&minEDDT="+minEDDT
		param += "&maxEDDT="+maxEDDT
		param += "&skills="
		
		for(var i = 0; i<skills.length; i++){
			param += skills[i]
			if(i != skills.length - 1){
				param += ","
			}
		}
		
		param += "&pageNum="+pageNum
		
		console.log("param = " + param)
		
		$.ajax({
	        url: "getProjectList", 
	        type:"post",
	        data: param,
	        success: function(data) {
	        	var str = ""
	        	var page = ""
	        	var add = "<button id='add' onclick='add()'>추가</a>"
	        	var del = "<button id='del' onclick='del()'>삭제</button>"
	        	
	        	
	        	/* model 에서 toString() 으로 받아온 문자열을 배열로 파싱 */
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
		        
		        if(data.projectList.length >= 1){
		        	$.each(data.projectList, function(i){
		        		var customer
		        		var skills = ""
		        		
		        		var skillArr = data.projectList[i].skills.split(",")
		        		
		        		for(var j = 0; j<codeList.length; j++){
		        			if(codeList[j].indexOf("mstCD=CU01") != -1 && codeList[j].indexOf("dtCD=" + data.projectList[i].cusCD + ",") != -1){
		        				customer = codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
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
	                	str += "<td class='checkRow'><input type='checkbox' class='prjSeq' value=" + data.projectList[i].prjSeq + " onclick='checkOne()'></td>"
	               		str += "<td class='numberRow'><a href='getProjectDetail?prjSeq=" + data.projectList[i].prjSeq +"'>" + data.projectList[i].prjSeq + "</a></td>"
	               		str += "<td class='nameRow'>" + data.projectList[i].prjNm + "</td>"
	               		str += "<td class='customerRow'>" + customer + "</td>"
	               		str += "<td class='skillsRow'>" + skills + "</td>"
	               		str += "<td class='startRow'>" + data.projectList[i].prjSTDT + "</td>"
	               		str += "<td class='endRow'>" + data.projectList[i].prjEDDT + "</td>"
	               		str += "<td class='editRow'><button id='edit' onclick='edit(this)' name='" + data.projectList[i].prjSeq + "'>상세/수정</button></td>"
	              		str += "<td class='userRow'><a id='user' href='getProjectUser?prjSeq=" + data.projectList[i].prjSeq + "'>인원 관리</a></td>"
	              		str += "</tr>"
	                })
	                
		        	if(data.beginPaging != 1){
		        		page += "<a href=getProjectList?pageNum=" + (data.beginPaging - 1) + ">이전</a>"
		        	}
		        	
		        	for(var i = data.beginPaging; i <= data.endPaging; i++){
		        		if(i == data.pageNum){
		        			page += "<button style='font-size:2em' class='page' value=" + i +">" + i + "</button>"
		        		} else {
		        			page += "<button class='page' value=" + i +" onclick='getProjectList(" + i + ")'>" + i + "</button>"
		        		}
		        	}
		        	
		        	if(data.endPaging != data.totalPaging){
		        		page += "<a href=getProjectList?pageNum=" + (data.endPaging + 1) + ">다음</a>"
		        	}
		        	
		        } else {
		        	str += "<tr>"
		        	str += '<td colspan="9"><h3>검색결과가 없습니다.</h3></td>'
		        	str += "</tr>"
		        }
	        	
	        	$("#checkAll").prop('checked',false)
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
	
	function edit(e){
    	var url = "getProjectDetail"
    	var prjSeq = e.name
    	
        window.open("", "openForm", "width=1000px height=480px");
       
        let $form = $('<form></form>'); // 폼 태그 생성
        $form.attr('action', url); 		// 폼 속성 설정
        $form.attr("target", "openForm");
        $form.attr('method', 'post');
        
    	$form.append('<input type="hidden" name="prjSeq" value="' + prjSeq + '"/>')
        
        $form.appendTo('body'); // body태그에 추가
        $form.submit(); // 전송
	}
	
	function add(){
    	var url = "goAddProject";
    	
    	window.open("", "openForm", "width=1000px height=455px");
        
        let $form = $('<form></form>'); // 폼 태그 생성
        $form.attr('action', url); 		// 폼 속성 설정
        $form.attr("target", "openForm");
        $form.attr('method', 'post');
        
        $form.appendTo('body'); // body태그에 추가
        $form.submit(); // 전송
	}
	
	function del(){
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
	        		alert("삭제 되었습니다.")
	        		getUserList(1)
	        	} else {
	        		alert("해당 프로젝트는 현재 소속되어있는 인원이 있습니다.")
	        	}
	        },
	        error: function() {
	            alert("통신실패")
	        }
	    })
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
	
	width: 100%;
	height: 18px;
	
	cursor: pointer;
	
	text-decoration: none;
}

#user {
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

table .startRow, table .endRow {
	min-width: 100px;
	text-align: center;
}

table .startHead, table .endHead {
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

table .userHead {
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
	justify-content: center;
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
<jsp:include page="header.jsp"/>
<main>
	<div class="wrap">
		<div class="pageTitle"><h1>프로젝트 관리</h1></div>
		<div class="middle">
			<jsp:include page="aside.jsp"/>
			<section>
				<div class="filter"> 
					<div class="filterTitle"><h1>검색 조건</h1></div>
					<div class="filterDetail">
						<div class="filterSection_1">
							<div class="filterWrap">
								<small>프로젝트 번호</small>
								<input name="prjSeq" id="prjSeq" type="text">
							</div>
							<div class="filterWrap">
								<small>프로젝트명</small>
								<input name="prjNm" id="prjNm" type="text">
							</div>
							<div class="filterWrap">
								<small>고객사명</small>
								<select name="cusCD" id="cusCD">
									<option value="0">선택</option>
									<c:forEach var="item" items="${codeList}" varStatus="i">
										<c:if test = "${item.mstCD == 'CU01'}">
											<option value="${item.dtCD}">${item.dtCDNM}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="filterSection_2">
							<div class="dateWrap">
								<small>시작일</small> <input id="minSTDT" type="date" max="9999-12-31"> ~ <input id="maxSTDT" type="date" max="9999-12-31">
							</div>
							<div class="dateWrap">
								<small>종료일</small> <input id="minEDDT" type="date" max="9999-12-31"> ~ <input id="maxEDDT" type="date" max="9999-12-31">
							</div>
						</div>
						<div class="filterSection_3">
							<small class="skillText">필요기술</small> 
							<c:forEach var="item" items="${codeList}" varStatus="i">
								<c:if test = "${item.mstCD == 'SK01'}">
									<input type="checkbox" class="skill" id="${item.dtCD}" value="${item.dtCD}">
									<label for="${item.dtCD}">${item.dtCDNM} </label>
								</c:if>
							</c:forEach>
						</div>
						<div class="filterSection_4">
							<button id="search">조회</button>
						</div>
					</div>
				</div>
				<div class="result">
					<div class="resultTitle"><h1>검색 결과</h1></div>
					<div class="resultDetail">
						<table>
							<thead>
								<tr>
									<th class="checkHead"><input type="checkbox" id="checkAll"></th>
									<th class="numberHead">프로젝트 번호</th>
									<th class="nameHead">프로젝트명</th>
									<th class="customerHead">고객사명</th>
									<th class="skillsHead">필요기술</th>
									<th class="startHead">시작일</th>
									<th class="endHead">종료일</th>
									<th class="editHead">상세/수정</th>
									<th class="userHead">인원 관리</th>
								</tr>
							</thead>
							<tbody id="tbody">
								<tr>
									<td colspan="9"><h3>조회가 필요합니다.</h3></td>
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