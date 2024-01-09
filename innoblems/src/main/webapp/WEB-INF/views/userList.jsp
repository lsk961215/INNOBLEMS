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
			if($("#maxDT").val() >= $("#minDT").val()){
				getUserList(1)
			} else {
				alert("��¥���� �ùٸ��� �ʽ��ϴ�.")
			}
			
		})
		
		$("#minDT").change(function(){
			if($("#maxDT").val() == ""){
				
			} else {
				if($(this).val() <= $("#maxDT").val()){
					
				} else {
					alert("��¥���� �ùٸ��� �ʽ��ϴ�.")
					$(this).val("")
				}
			}
		})
		
		$("#maxDT").change(function(){
			if($("#minDT").val() == ""){
				
			} else {
				if($(this).val() >= $("#minDT").val()){
					
				} else {
					alert("��¥���� �ùٸ��� �ʽ��ϴ�.")
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
	
	function getUserList(pageNum){
		var usrSeq = $("#usrSeq").val()
		var usrNm = $("#usrNm").val()
		var grCD = $("#grCD").val()
		var stCD = $("#stCD").val()
		var minDT = $("#minDT").val()
		var maxDT = $("#maxDT").val()
		var countPerPage = $("#countPerPage").val()
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
		param += "&countPerPage="+countPerPage
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
	        url: "getUserList", 
	        type:"post",
	        data: param,
	        success: function(data) {
	        	var str = ""
	        	var page = ""
	        	var add = "<button id='add' onclick='add()'>�߰�</button>"
	        	var del = "<button id='del' onclick='del()'>����</button>"
	        	
	        	
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
		        
		        if(data.userList.length >= 1){
		        	$.each(data.userList, function(i){
		        		var rank
		        		var grade
		        		var status
		        		var skills = ""
		        		
		        		var skillArr = data.userList[i].skills.split(",")
		        		
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
		        					if(k != 0){
			        					skills += ", "
			        				}
		        					skills += codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
			        			}
		        			}
		        		}
		        		
	                	str += "<tr>"
	                	str += "<td class='checkRow'><input type='checkbox' class='usrSeq' value=" + data.userList[i].usrSeq + " onclick='checkOne()'></td>"
	               		str += "<td class='numberRow'><button id='numberButton' onclick='edit(this)' name='" + data.userList[i].usrSeq + "'>" + data.userList[i].usrSeq + "</button></td>"
	               		str += "<td class='inDateRow'>" + data.userList[i].usrINDT + "</td>"
	               		if(rank == undefined){
	               			str += "<td class='rankRow'>-</td>"
	               		} else {
	               			str += "<td class='rankRow'>" + rank + "</td>"
	               		}
	               		str += "<td class='nameRow'>" + data.userList[i].usrNm + "</td>"
	               		if(grade == undefined){
	               			str += "<td class='gradeRow'>-</td>"
	               		} else {
	               			str += "<td class='gradeRow'>" + grade + "</td>"
	               		}
	               		str += "<td class='skillsRow'>" + skills + "</td>"
	               		if(status == undefined){
	               			str += "<td class='statusRow'>-</td>"
	               		} else {
	               			str += "<td class='statusRow'>" + status + "</td>"
	               		}
	               		str += "<td class='editRow'><button id='edit' onclick='edit(this)' name='" + data.userList[i].usrSeq + "'>��/����</button></td>"
	              		str += "<td class='projectRow'><a id='project' href='getUserProject?usrSeq=" + data.userList[i].usrSeq + "'>������Ʈ ����</a></td>"
	              		str += "</tr>"
	                })
	                
		        	if(data.beginPaging != 1){
		        		page += "<a href=getUserList?pageNum=" + (data.beginPaging - 1) + ">����</a>"
		        	}
		        	
		        	for(var i = data.beginPaging; i <= data.endPaging; i++){
		        		if(i == data.pageNum){
		        			page += "<button style='font-size:2em' id='currentPage' class='page' value=" + i +">" + i + "</button>"
		        		} else {
		        			page += "<button class='page' value=" + i +" onclick='getUserList(" + i + ")'>" + i + "</button>"
		        		}
		        	}
		        	
		        	if(data.endPaging != data.totalPaging){
		        		page += "<a href=getUserList?pageNum=" + (data.endPaging + 1) + ">����</a>"
		        	}
		        	
		        } else {
		        	str += "<tr>"
		        	str += '<td colspan="10"><h3>�˻������ �����ϴ�.</h3></td>'
		        	str += "</tr>"
		        }
	        	
	        	$("#checkAll").prop('checked',false)
	        	$("#tbody").append(str)
	        	$(".resultPage").append(page)
	        	$(".resultButton").append(add)
	        	$(".resultButton").append(del)
	        },
	        error: function() {
	            alert("��Ž���")
	        }
	    })
	}
	
	function edit(e){
    	var url = "getUserDetail"
    	var usrSeq = e.name
    	
        window.open("", "openForm", "width=1000px height=620px");
       
        let $form = $('<form></form>'); // �� �±� ����
        $form.attr('action', url); 		// �� �Ӽ� ����
        $form.attr("target", "openForm");
        $form.attr('method', 'post');
        
    	$form.append('<input type="hidden" name="usrSeq" value="' + usrSeq + '"/>')
        
        $form.appendTo('body'); // body�±׿� �߰�
        $form.submit(); // ����
	}
	
	function add(){
    	var url = "goAddUser";
    	
        window.open("", "openForm", "width=1000px height=600px");
        
        let $form = $('<form></form>'); // �� �±� ����
        $form.attr('action', url); 		// �� �Ӽ� ����
        $form.attr("target", "openForm");
        $form.attr('method', 'post');
        
        $form.appendTo('body'); // body�±׿� �߰�
        $form.submit(); // ����
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
		        		alert("���� �Ǿ����ϴ�.")
		        		getUserList(1)
		        	} else {
		        		alert("�ش� ����� ���� �ҼӵǾ��ִ� ������Ʈ�� �ֽ��ϴ�.")
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

table .checkRow {
	min-width: 50px;
	text-align: center;
}
table .checkHead {
	min-width: 50px;
	text-align: center;
}

table .numberRow {
	min-width: 100px;
	text-align: right;
}

table .numberHead {
	min-width: 100px;
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
	min-width: 150px;
	text-align: left;
}

table .nameHead {
	min-width: 150px;
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
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'GR01'}">
										<option value="${item.dtCD}">${item.dtCDNM}</option>
									</c:if>
								</c:forEach>
							</select>
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
						<div class="filterSection_2">
							<small class="inDT">�Ի���</small> <input id="minDT" type="date" max="9999-12-31"> ~ <input id="maxDT" type="date" max="9999-12-31">
						</div>
						<div class="filterSection_3">
							<small class="skillText">�������</small> 
							<c:forEach var="item" items="${codeList}" varStatus="i">
								<c:if test = "${item.mstCD == 'SK01'}">
									<input type="checkbox" class="skill" id="${item.dtCD}" value="${item.dtCD}">
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
					<div class="resultTitle"><h1>�˻� ���</h1></div>
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
									<th class="numberHead">�����ȣ</th>
									<th class="inDateHead">�Ի���</th>
									<th class="rankHead">����</th>
									<th class="nameHead">�����</th>
									<th class="gradeHead">������</th>
									<th class="skillsHead">�������</th>
									<th class="statusHead">��������</th>
									<th class="editHead">��/����</th>
									<th class="projectHead">������Ʈ����</th>
								</tr>
							</thead>
							<tbody id="tbody">
								<tr>
									<td colspan="10"><h3>��ȸ�� �ʿ��մϴ�.</h3></td>
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