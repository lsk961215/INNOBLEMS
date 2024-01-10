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
		$("#minSTDT").change(function(){
			if($("#maxSTDT").val() == ""){
				
			} else {
				if($(this).val() <= $("#maxSTDT").val()){
					
				} else {
					alert("��¥���� �ùٸ��� �ʽ��ϴ�.")
					$(this).val("")
				}
			}
		})
		
		$("#maxSTDT").change(function(){
			if($("#minSTDT").val() == ""){
				
			} else {
				if($(this).val() >= $("#minSTDT").val()){
					
				} else {
					alert("��¥���� �ùٸ��� �ʽ��ϴ�.")
					$(this).val("")
				}
			}
		})
		
		$("#minEDDT").change(function(){
			if($("#maxEDDT").val() == ""){
				
			} else {
				if($(this).val() <= $("#maxEDDT").val()){
					
				} else {
					alert("��¥���� �ùٸ��� �ʽ��ϴ�.")
					$(this).val("")
				}
			}
		})
		
		$("#maxEDDT").change(function(){
			if($("#minEDDT").val() == ""){
				
			} else {
				if($(this).val() >= $("#minEDDT").val()){
					
				} else {
					alert("��¥���� �ùٸ��� �ʽ��ϴ�.")
					$(this).val("")
				}
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
	
	function search(){
		if($("#maxSTDT").val() >= $("#minSTDT").val() && $("#maxEDDT").val() >= $("#minEDDT").val()){
			getAddUserProjectList(1)
		} else {
			alert("��¥���� �ùٸ��� �ʽ��ϴ�.")
		}
	}
	
	function edit(e){
    	var url = "getProjectDetail"
    	var prjSeq = e.name
    	
        window.open("", "childForm", "width=1000px height=480px");
       
        let $form = $('<form></form>'); // �� �±� ����
        $form.attr('action', url); 		// �� �Ӽ� ����
        $form.attr("target", "childForm");
        $form.attr('method', 'post');
        
    	$form.append('<input type="hidden" name="prjSeq" value="' + prjSeq + '"/>')
        
        $form.appendTo('body'); // body�±׿� �߰�
        $form.submit(); // ����
	}
	
	function add(){
		var usrSeq = '${userProjectDTO.usrSeq}'
		
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
		        url: "addUserProject", 
		        type:"post",
		        data: param,
		        success: function(data) {
		        	if(data == 0){
			        	alert("�߰� �Ǿ����ϴ�.")
			        	getAddUserProjectList(1)
			        	opener.getUserProjectList(1)
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
	
	function getAddUserProjectList(pageNum){
		
		var usrSeq = '${userProjectDTO.usrSeq}'
		var skills = '${userProjectDTO.skills}'
		
		
		var prjSeq = $("#prjSeq").val()
		var prjNm = $("#prjNm").val()
		var cusCD = $("#cusCD").val()
		var minSTDT = $("#minSTDT").val()
		var maxSTDT = $("#maxSTDT").val()
		var minEDDT = $("#minEDDT").val()
		var maxEDDT = $("#maxEDDT").val()
		var countPerPage = $("#countPerPage").val()
		var skills = new Array()
		
		if(prjSeq == ""){
			prjSeq = 0
		}
		
		var param = "prjSeq="+prjSeq
		param += "&prjNm="+prjNm
		param += "&cusCD="+cusCD
		param += "&minSTDT="+minSTDT
		param += "&maxSTDT="+maxSTDT
		param += "&minEDDT="+minEDDT
		param += "&maxEDDT="+maxEDDT
		param += "&countPerPage="+countPerPage
		param += "&skills="+'${userProjectDTO.skills}'
		param += "&usrSeq="+'${userProjectDTO.usrSeq}'
		
		
		param += "&pageNum="+pageNum
		
		console.log("param = " + param)
		
		$.ajax({
	        url: "getAddUserProjectList", 
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
		        		
		        	if(i < codeList.length-1){
		        		codeList[i] = str.substring(1, str.length-3)
		        	} else {
		        		codeList[i] = str.substring(1, str.length-1)
		        	}
		        }
	        	
		        $("#tbody").empty()
		        $(".resultPage").empty()
		        $(".resultButton").empty()
		        
		        if(data.userProjectList.length >= 1){
		        	$.each(data.userProjectList, function(i){
		        		var customer
		        		var skills = ""
		        		
		        		var skillArr = data.userProjectList[i].skills.split(",")
		        		
		        		for(var j = 0; j<codeList.length; j++){
		        			if(codeList[j].indexOf("mstCD=CU01") != -1 && codeList[j].indexOf("dtCD=" + data.userProjectList[i].cusCD + ",") != -1){
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
	                	str += "<td class='checkRow'><input type='checkbox' class='prjSeq' value=" + data.userProjectList[i].prjSeq + " onclick='checkOne()'></td>"
	               		str += "<td class='numberRow'><button id='numberButton' onclick='edit(this)' name='" + data.userProjectList[i].prjSeq + "'>" + data.userProjectList[i].prjSeq + "</button></td>"
	               		str += "<td class='nameRow'>" + data.userProjectList[i].prjNm + "</td>"
	               		str += "<td class='customerRow'>" + customer + "</td>"
	               		str += "<td class='skillsRow'>" + skills + "</td>"
	               		str += "<td class='startRow'>" + data.userProjectList[i].prjSTDT + "</td>"
	               		if(data.userProjectList[i].prjEDDT == null){
	               			str += "<td class='endRow'>-</td>"
	               		} else {
	               			str += "<td class='endRow'>" + data.userProjectList[i].prjEDDT + "</td>"
	               		}
	              		str += "</tr>"
	                })
	                
		        	if(data.beginPaging != 1){
		        		page += "<a href=getAddUserProjectList?pageNum=" + (data.beginPaging - 1) + ">����</a>"
		        	}
		        	
		        	for(var i = data.beginPaging; i <= data.endPaging; i++){
		        		if(i == data.pageNum){
		        			page += "<button style='font-size:2em' class='page' value=" + i +">" + i + "</button>"
		        		} else {
		        			page += "<button class='page' value=" + i +" onclick='getAddUserProjectList(" + i + ")'>" + i + "</button>"
		        		}
		        	}
		        	
		        	if(data.endPaging != data.totalPaging){
		        		page += "<a href=getAddUserProjectList?pageNum=" + (data.endPaging + 1) + ">����</a>"
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

.resultPerPage {
	display: flex;
	flex-direction: row-reverse;
	margin-bottom: 10px;
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
					<small>������Ʈ ��ȣ</small>
					<input name="prjSeq" id="prjSeq" type="text">
				</div>
				<div class="filterWrap">
					<small>������Ʈ��</small>
					<input name="prjNm" id="prjNm" type="text">
				</div>
				<div class="filterWrap">
					<small>�����</small>
					<select name="cusCD" id="cusCD">
						<option value="0">����</option>
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
					<small>������</small> <input id="minSTDT" type="date" max="9999-12-31"> ~ <input id="maxSTDT" type="date" max="9999-12-31">
				</div>
				<div class="dateWrap">
					<small>������</small> <input id="minEDDT" type="date" max="9999-12-31"> ~ <input id="maxEDDT" type="date" max="9999-12-31">
				</div>
			</div>
			<div class="filterSection_4">
				<button id="search" onclick="search()">��ȸ</button>
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
						<th class="numberHead">������Ʈ ��ȣ</th>
						<th class="nameHead">������Ʈ��</th>
						<th class="customerHead">�����</th>
						<th class="skillsHead">�ʿ���</th>
						<th class="startHead">������</th>
						<th class="endHead">������</th>
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