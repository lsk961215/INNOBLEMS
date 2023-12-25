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
		
		$.ajax({
	        url: "getUserList", 
	        type:"post",
	        data: param,
	        success: function(data) {
	        	var str = ""
	        	var page = ""
	        	var add = "<a id='add' href='addUser'>추가</a>"
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
			        				skills += codeList[j].substr(codeList[j].indexOf("dtCDNM=")+7)
			        				if(k != skillArr.length-1){
			        					skills += ","
			        				}
			        			}
		        			}
		        		}
		        		
	                	str += "<tr>"
	                	str += "<td class='checkRow'><input type='checkbox' class='usrSeq' value=" + data.userList[i].usrSeq + " onclick='checkOne()'></td>"
	               		str += "<td>" + data.userList[i].usrSeq + "</td>"
	               		str += "<td>" + data.userList[i].usrINDT + "</td>"
	               		str += "<td>" + rank + "</td>"
	               		str += "<td>" + data.userList[i].usrNm + "</td>"
	               		str += "<td>" + grade + "</td>"
	               		str += "<td class='skillsRow'>" + skills + "</td>"
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
<script type="text/javascript">
    //이미지 미리보기
    var sel_file;
 
    $(document).ready(function() {
        $("#file1").on("change", handleImgFileSelect);
    });
 
    function handleImgFileSelect(e) {
        var files = e.target.files;
        var filesArr = Array.prototype.slice.call(files);
 
        var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
 
        filesArr.forEach(function(f) {
            if (!f.type.match(reg)) {
                alert("확장자는 이미지 확장자만 가능합니다.");
                return;
            }
 
            sel_file = f;
 
            var reader = new FileReader();
            reader.onload = function(e) {
                $("#img").attr("src", e.target.result);
            }
            reader.readAsDataURL(f);
        });
    }
</script>
<script>
//파일 업로드
function fn_submit(){
        
        var form = new FormData();
        form.append( "file1", $("#file1")[0].files[0] );
        
         jQuery.ajax({
             url : "result"
           , type : "POST"
           , processData : false
           , contentType : false
           , data : form
           , success:function(response) {
               alert("성공하였습니다.");
               console.log(response);
           }
           ,error: function (jqXHR) 
           { 
               alert(jqXHR.responseText); 
           }
       });
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
	width: 100%;
			
	display: flex;
	flex-direction: column;
	
	margin-top: 50px;
	margin-bottom: 50px;
	margin-right: 50px;
	
	border: 2px solid lightgrey;
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
	margin-right: 50px;
	
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

.imgSection {
	display:flex;
	flex-direction: column;
}
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
	<div class="wrap">
		<div class="pageTitle"><h1>사원 등록</h1></div>
		<div class="middle">
			<jsp:include page="aside.jsp"/>
			<section>
				<div>
					<div class=imgSection>
					    <label for="file1"><img id="img" /></label> 
					    <input type="file" id="file1" name="file1"> 
					    <button id="btn_submit" onclick="javascript:fn_submit()">전송</button>    
					</div>
					<div class=detailSection>
					       <table>
					       </table>
					</div>
				</div>
				<div class="buttonSection">
					
				</div>
				
			</section>
		</div>
		
	</div>
	
</main>
</body>
</html>