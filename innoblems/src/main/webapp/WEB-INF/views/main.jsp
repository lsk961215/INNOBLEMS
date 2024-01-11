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
		getBoardList(1)
		
		$("#search").click(function(){
			if($("#maxDT").val() >= $("#minDT").val()){
				getUserList(1)
			} else {
				alert("날짜값이 올바르지 않습니다.")
			}
			
		})
		
		$("#minDT").change(function(){
			if($("#maxDT").val() == ""){
				
			} else {
				if($(this).val() <= $("#maxDT").val()){
					
				} else {
					alert("날짜값이 올바르지 않습니다.")
					$(this).val("")
				}
			}
		})
		
		$("#maxDT").change(function(){
			if($("#minDT").val() == ""){
				
			} else {
				if($(this).val() >= $("#minDT").val()){
					
				} else {
					alert("날짜값이 올바르지 않습니다.")
					$(this).val("")
				}
			}
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
	
	function getBoardList(pageNum){
		var boTi = $("#boTi").val()
		var usrNm = $("#usrNm").val()
		var tpCD = $("#tpCD").val()
		var minDT = $("#minDT").val()
		var maxDT = $("#maxDT").val()
		
		var param = "boTi="+boTi
		param += "&usrNm="+usrNm
		param += "&tpCD="+tpCD
		param += "&minDT="+minDT
		param += "&maxDT="+maxDT
		param += "&pageNum="+pageNum
		
		console.log("param = " + param)
		
		$.ajax({
	        url: "getBoardList",
	        type:"post",
	        data: param,
	        success: function(data) {
	        	var str = ""
	        	var page = ""
	        	var add = "<button id='add' onclick='add()'>글쓰기</button>"
	        	
		        $("#tbody").empty()
		        $(".resultPage").empty()
		        $(".resultButton").empty()
		        
		        if(data.boardList.length >= 1){
		        	$.each(data.boardList, function(i){
	                	str += "<tr>"
	               		str += "<td class='numberRow'>"+ data.boardList[i].boSeq + "</td>"
	               		str += "<td class='titleRow'><a href='getBoardDetail?boSeq=" + data.boardList[i].boSeq + "'>" + data.boardList[i].boTi + "</a></td>"
	               		str += "<td class='nameRow'>" + data.boardList[i].usrNm + "</td>"
	               		str += "<td class='dateRow'>" + data.boardList[i].boDT + "</td>"
	              		str += "</tr>"
	                })
	                
		        	if(data.beginPaging != 1){
		        		page += "<a href=getBoardList?pageNum=" + (data.beginPaging - 1) + ">이전</a>"
		        	}
		        	
		        	for(var i = data.beginPaging; i <= data.endPaging; i++){
		        		if(i == data.pageNum){
		        			page += "<button style='font-size:2em' id='currentPage' class='page' value=" + i +">" + i + "</button>"
		        		} else {
		        			page += "<button class='page' value=" + i +" onclick='getBoardList(" + i + ")'>" + i + "</button>"
		        		}
		        	}
		        	
		        	if(data.endPaging != data.totalPaging){
		        		page += "<a href=getBoardList?pageNum=" + (data.endPaging + 1) + ">다음</a>"
		        	}
		        	
		        } else {
		        	str += "<tr>"
		        	str += '<td colspan="4"><h3>검색결과가 없습니다.</h3></td>'
		        	str += "</tr>"
		        }
	        	
	        	$("#tbody").append(str)
	        	$(".resultPage").append(page)
	        	$(".resultButton").append(add)
	        },
	        error: function() {
	            alert("통신실패")
	        }
	    })
	}
	
	function edit(e){
    	var url = "getUserDetail"
    	var usrSeq = e.name
    	
        window.open("", "openForm", "width=1000px height=620px");
       
        let $form = $('<form></form>'); // 폼 태그 생성
        $form.attr('action', url); 		// 폼 속성 설정
        $form.attr("target", "openForm");
        $form.attr('method', 'post');
        
    	$form.append('<input type="hidden" name="usrSeq" value="' + usrSeq + '"/>')
        
        $form.appendTo('body'); // body태그에 추가
        $form.submit(); // 전송
	}
	
	function add(){
    	var url = "goAddBoard";
        
        let $form = $('<form></form>'); // 폼 태그 생성
        $form.attr('action', url); 		// 폼 속성 설정
        $form.attr('method', 'post');
        
        $form.appendTo('body'); // body태그에 추가
        $form.submit(); // 전송
	}
	
	function del(){
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
		} else {
			alert("한개 이상의 항목을 선택해주세요")
		}
		
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

#more {
	border: none;
	background-color: grey;
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

#project {
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
	width: 100%;
		
	border-collapse : collapse;
}
  	
table td, table th{
  	padding-left: 5px;
	padding-right: 5px;
	
	text-align: center;
		
	border: 2px solid lightgrey;
}
	
table th {
	background-color: #E4E4E4;
	color: black;
}

table .dateRow {
	max-width: 100px;
	text-align: center;
}
table .dateHead {
	max-width: 100px;
	text-align: center;
}

table .numberRow {
	max-width: 100px;
	text-align: right;
}

table .numberHead {
	max-width: 100px;
	text-align: center;
}

table .inDateRow, table .rankRow, table .gradeRow, table .statusRow {
	min-width: 100px;
	text-align: center;
}

table .inDateHead, table .rankHead, table .gradeHead, table .statusHead {
	min-width: 100px;
	text-align: center;
}

table .nameRow {
	max-width: 100px;
	text-align: left;
}

table .nameHead {
	max-width: 100px;
	text-align: center;
}

table .titleRow {
	min-width: 350px;
	text-align: left;
}

table .titleHead {
	min-width: 350px;
	text-align: center;
}

table .editRow {
	min-width: 100px;
	text-align: center;
}

table .editHead {
	min-width: 100px;
	text-align: center;
}

table .projectRow {
	min-width: 100px;
	text-align: center;
}

table .projectHead {
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
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
	<div class="wrap">
		<div class="pageTitle"><h1>메인페이지</h1></div>
		<div class="middle">
			<jsp:include page="aside.jsp"/>
			<section>
				<div class="result">
					<div class="resultTitle"><h1>사내게시판</h1></div>
					<div class="resultDetail">
						<table>
							<thead>
								<tr>
									<th class="numberHead">글번호</th>
									<th class="titleHead">제목</th>
									<th class="nameHead">작성자</th>
									<th class="dateHead">작성일</th>
								</tr>
							</thead>
							<tbody id="tbody">
								<tr>
									<td colspan="4"><h3>글이 없습니다.</h3></td>
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