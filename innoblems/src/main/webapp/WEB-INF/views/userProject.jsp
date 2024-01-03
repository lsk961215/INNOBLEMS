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
	
	function getUserProjectList(pageNum){
		var usrSeq = $("#usrSeq").val()
		
		if(usrSeq == ""){
			usrSeq = 0
		}
		
		var param = "usrSeq="+usrSeq
		
		param += "&pageNum="+pageNum
		
		console.log("param = " + param)
		
		$.ajax({
	        url: "getUserProjectList", 
	        type:"post",
	        data: param,
	        success: function(data) {
	        	var str = ""
	        	var page = ""
	        	var save = "<button id='save' onclick='save()'>저장</button>"
	        	var add = "<button id='add' onclick='add()'>추가</button>"
	        	var del = "<button id='del' onclick='delUser()'>삭제</button>"
	        	var cancel = "<button id='cancel' onclick='cancel()'>취소</button>"
	        	
	        	
	        	/* model 에서 toString() 으로 받아온 문자열을 배열로 파싱 */
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
		        				customer = codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
		        			}
		        			if(codeList[j].indexOf("mstCD=RL01") != -1 && codeList[j].indexOf("dtCD=" + data.userProjectList[i].rlCD + ",") != -1){
		        				role = codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
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
	                	str += "<td class='checkRow'><input type='checkbox' class='prjSeq' value=" + data.userProjectList[i].prjSeq + " onclick='checkOne()'></td>"
	               		str += "<td class='numberRow'><a href='getProjectDetail?prjSeq=" + data.userProjectList[i].prjSeq +"'>" + data.userProjectList[i].prjSeq + "</a></td>"
	               		str += "<td class='nameRow'>" + data.userProjectList[i].prjNm + "</td>"
	               		str += "<td class='customerRow'>" + customer + "</td>"
	               		str += "<td class='skillsRow'>" + skills + "</td>"
	               		str += "<td class='prjSTDTRow'>" + data.userProjectList[i].prjSTDT + "</td>"
	               		str += "<td class='prjEDDTRow'>" + data.userProjectList[i].prjEDDT + "</td>"
	               		str += "<td class='usrPrjINDTRow'><input type='date' value='" + data.userProjectList[i].usrPrjINDT + "'></td>"
	               		str += "<td class='usrPrjOTDTRow'><input type='date' value='" + data.userProjectList[i].usrPrjOTDT + "'></td>"
	               		str += "<td class='roleRow'>"
	               		str += "<select name='rlCD' id='rlCD'>"
	               		str += "<option value='0'>선택</option>"
	               		for(var j = 0; j<codeList.length; j++){
	               			if(codeList[j].indexOf("mstCD=RL01") != -1){
	               				if(codeList[j].indexOf("dtCD=" + data.userProjectList[i].rlCD + ",") != -1){
	    		        			str += "<option value='" + codeList[j].substr(codeList[j].indexOf("dtCD=")+7)+"' selected>" + codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7) + "</option>"
	    		        		} else {
	    		        			str += "<option value='" + codeList[j].substr(codeList[j].indexOf("dtCD=")+7)+"' >" + codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7) + "</option>"
	    		        		}
			        			role = codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
			        		}
	               		}
	               		str += "</select>"
	               		str += "</td>"
	               		str += "<td class='editRow'><a id='edit' href='getProjectDetail?prjSeq=" + data.userProjectList[i].prjSeq +"'>상세/수정</a></td>"
	              		str += "</tr>"
	                })
	                
		        	if(data.beginPaging != 1){
		        		page += "<a href=getUserProjectList?pageNum=" + (data.beginPaging - 1) + ">이전</a>"
		        	}
		        	
		        	for(var i = data.beginPaging; i <= data.endPaging; i++){
		        		if(i == data.pageNum){
		        			page += "<button style='font-size:2em' id='currentPage' class='page' value=" + i +">" + i + "</button>"
		        		} else {
		        			page += "<button class='page' value=" + i +" onclick='getUserProjectList(" + i + ")'>" + i + "</button>"
		        		}
		        	}
		        	
		        	if(data.endPaging != data.totalPaging){
		        		page += "<a href=getUserProjectList?pageNum=" + (data.endPaging + 1) + ">다음</a>"
		        	}
		        	
		        } else {
		        	str += "<tr>"
		        	str += '<td colspan="10"><h3>검색결과가 없습니다.</h3></td>'
		        	str += "</tr>"
		        }
	        	
	        	$("#tbody").append(str)
	        	$(".resultPage").append(page)
	        	$(".resultButton").append(save)
	        	$(".resultButton").append(add)
	        	$(".resultButton").append(del)
	        	$(".resultButton").append(cancel)
	        },
	        error: function() {
	            alert("통신실패")
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
	
	function setSkills() {
		var skills = '${userDTO.skills}'
		
		console.log(skills)
		
		var skillArr = skills.split(",")
		
		for(var i = 0; i<skillArr.length; i++){
			$("input[id=" + skillArr[i] + "]").prop('checked',true);
		}
		
	}
	
	function cancel() {
		window.history.back();
	}
	
	function add(){
		
		var usrSeq = $("#usrSeq").val()
		var skills = '${userDTO.skills}'
		
    	var url = "addUserProject";
    	
        window.open("", "openForm", "width=1000px height=600px");
        
        let $form = $('<form></form>'); // 폼 태그 생성
        $form.attr('action', url); 		// 폼 속성 설정
        $form.attr("target", "openForm");
        $form.attr('method', 'post');
        
       	$form.append('<input type="hidden" name="usrSeq" value="' + usrSeq + '"/>')
       	$form.append('<input type="hidden" name="skills" value="' + skills + '"/>')
        
        $form.appendTo('body'); // body태그에 추가
        $form.submit(); // 전송
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
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
	<div class="wrap">
		<div class="pageTitle"><h1>개인 프로젝트 관리</h1></div>
		<div class="middle">
			<jsp:include page="aside.jsp"/>
			<section>
				<div class="filter"> 
					<div class="filterTitle"><h1>사원 정보</h1></div>
					<div class="filterDetail">
						<div class="filterSection_1">
							<small>사원번호</small>
							<input name="usrSeq" id="usrSeq" type="text" value="${userDTO.usrSeq}" readonly>
							<small>사원명</small>
							<input name="usrNm" id="usrNm" type="text" value="${userDTO.usrNm}" readonly>
							<small>직급</small>
							<input type="text" name="raCD" id="raCD" 
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'RA01'}">
										value="${item.dtCDNM}"
									</c:if>
								</c:forEach>
							readonly>
							<small>기술등급</small>
							<input type="text" name="grCD" id="grCD"
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'GR01'}">
										value="${item.dtCDNM}"
									</c:if>
								</c:forEach>
							readonly>
							<small>재직상태</small>
							<input type="text" name="stCD" id="stCD"
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'ST01'}">
										value="${item.dtCDNM}"
									</c:if>
								</c:forEach>
							readonly>
						</div>
						<div class="filterSection_3">
							<small class="skillText">보유기술</small> 
							<c:forEach var="item" items="${codeList}" varStatus="i">
								<c:if test = "${item.mstCD == 'SK01'}">
									<input type="checkbox" class="skill" id="${item.dtCD}" value="${item.dtCD}" onClick="return false;">
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
					<div class="resultTitle"><h1>소속 프로젝트</h1></div>
					<div class="resultDetail">
						<table>
							<thead>
								<tr>
									<th class="checkHead"><input type="checkbox" id="checkAll"></th>
									<th class="numberHead">프로젝트번호</th>
									<th class="nameHead">프로젝트명</th>
									<th class="customerHead">고객사명</th>
									<th class="skillsHead">필요기술</th>
									<th class="prjSTDTHead">시작일</th>
									<th class="prjEDDTHead">종료일</th>
									<th class="usrPrjINDTHead">투입일</th>
									<th class="usrPrjOTDTHead">철수일</th>
									<th class="roleHead">역할</th>
									<th class="editHead">상세/수정</th>
								</tr>
							</thead>
							<tbody id="tbody">
								<tr>
									<td colspan="11"><h3>조회가 필요합니다.</h3></td>
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