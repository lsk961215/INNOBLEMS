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
<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
	$(function(){
		setBirth()
		
		pwCheck()
		
		$("#usrNm").keyup(function (event) {
	    	regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	        v = $(this).val();
	        if (regexp.test(v)) {
	            alert("한글만 입력가능 합니다.");
	            $(this).val(v.replace(regexp, ''));
	        }
	    });
		
		$("#usrEm").focusout(function (event) {
			let check = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    		
    		if(!check.test($(this).val()) || !$(this).val() == null){
    			alert("이메일이 형식에 맞지 않습니다.")
    		}  else {
    			
    		}
		});
		
		$("#usrId").keyup(function (event) {
	    	regexp = /^[a-zA-Z0-9]*$/;
	        v = $(this).val();
	        if (!regexp.test(v)) {
	            alert("소문자와 숫자만 입력가능 합니다.");
	            $(this).val(v.replace(regexp, ''));
	            $(this).val("");
	        }
	    });
	})
	
	
	
	function setBirth (){
		var today = new Date()
		
		var date = today.getFullYear() +
		'-' + ( (today.getMonth()+1) < 9 ? "0" + (today.getMonth()+1) : (today.getMonth()+1) )+
		'-' + ( (today.getDate()) < 9 ? "0" + (today.getDate()) : (today.getDate()) )
		
		$("#usrBDT").prop("max", date)
	}
	
	function pwView() {
		if($("#usrPw").prop("type") == "password"){
			$("#usrPw").prop("type", "text")
			$("#usrPwCheck").prop("type", "text")
		} else {
			$("#usrPw").prop("type", "password")
			$("#usrPwCheck").prop("type", "password")
		}
		
	}
	
	function pwCheck() {
		$("#usrPw").keyup(function (){
			if($(this).val() == $("#usrPwCheck").val()){
				$("#checkText").text("비밀번호가 일치합니다.")
				$("#checkText").css("color", "green")
				$("#checkText").css("display", "block")
			} else {
				$("#checkText").text("비밀번호가 일치하지 않습니다.")
				$("#checkText").css("color", "red")
				$("#checkText").css("display", "block")
			}
		})
		
		$("#usrPwCheck").keyup(function (){
			if($(this).val() == $("#usrPw").val()){
				$("#checkText").text("비밀번호가 일치합니다.")
				$("#checkText").css("color", "green")
				$("#checkText").css("display", "block")
			} else {
				$("#checkText").text("비밀번호가 일치하지 않습니다.")
				$("#checkText").css("color", "red")
				$("#checkText").css("display", "block")
			}
		})
	}
	
	function add2() {
		var usrSeq = '${sessionScope.userDTO.usrSeq}'
		var usrNm = '${sessionScope.userDTO.usrNm}'
		var tpCD = $("#tpCD").val()
		var boTi = $("#boTi").val()
		var boLob = editor.getHTML()
		
		var param = "usrSeq="+usrSeq
        param += "&usrNm="+usrNm
        param += "&tpCD="+tpCD
        param += "&boTi="+boTi
        param += "&boLob="+boLob
                           
        console.log("param" + param)
                           
        $.ajax({
        	url: "addBoard2", 
            type:"post",
            data: param,
            success: function(data) {
            	alert("등록되었습니다.")
            	opener.getBoardList(1)
            },
            error: function() {
            	alert("통신실패")
            }
       	})
	}
	
	function add(){
        var usrSeq = '${sessionScope.userDTO.usrSeq}'
		var usrNm = '${sessionScope.userDTO.usrNm}'
		var tpCD = $("#tpCD").val()
		var boImg = ""
		var boTi = $("#boTi").val()
		var boTXT = $("#boTXT").val()
		
		var form = new FormData();
        form.append( "file1", $("#file1")[0].files[0] );
        
        var pwCheck = false
        var skillsCheck = false
        
        if($("#usrPw").val() != "" && $("#usrPw").val() == $("#usrPwCheck").val()){
        	pwCheck = true
        }
        
        
        if($(".skill:checked").length > 0){
        	skillsCheck = true
        }
        
        if(tpCD == 0){
        	alert("타입을 선택해주세요.")
        } else {
        	if(boTi == ""){
        		alert("제목을 입력해주세요.")
        	} else {
        		if(boTXT == ""){
        			alert("내용을 입력해주세요.")
        		} else {
        			if($("#file1").val() != ""){
                		jQuery.ajax({
                            url : "boardImage"
                          , type : "POST"
                          , processData : false
                          , contentType : false
                          , data : form
                          , success:function(response) {
                             console.log("이미지파일 이름 = "+ response)
                       	   if(response != -1){
                        	boImg = response;
                           	   
                              } else {
                           	   alert("이미지는 5MB 이하의 파일만 가능합니다.")
                              }
                              
                          }
                          ,error: function (jqXHR) 
                          { 
                              alert(jqXHR.responseText); 
                          }, complete : function(){
                        	  var param = "usrSeq="+usrSeq
              	       		param += "&usrNm="+usrNm
              	       		param += "&tpCD="+tpCD
              	       		param += "&boImg="+boImg
              	       		param += "&boTi="+boTi
              	       		param += "&boTXT="+boTXT
                           
                           console.log("param" + param)
                           
                           $.ajax({
              			        url: "addBoard", 
              			        type:"post",
              			        data: param,
              			        success: function(data) {
              			        	alert("등록되었습니다.")
              			        	opener.getBoardList(1)
              			        },
              			        error: function() {
              			            alert("통신실패")
              			        }
              			 })
                          }
                      	})
                	}
        		}
        	}
        	
        }
	}
	
	function cancel(){
		location.href="/innoblems"
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                
            }
        }).open();
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

#boTXT {
	border: none;
	width: 100%;
	height: 500px;
	resize: none;
	outline: none;
}

#boTi {
	border: 2px solid lightgrey;
	width: 99%;
	outline: none;
}

#tpCD {
	width: 100%;
	border: 2px solid lightgrey;
	outline: none;
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

#cancel {
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
	border-collapse : collapse;
	width: 100%;
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

#img {
	max-width: 200px;
	max-heigth: 200px;
	
	border: 2px solid lightgrey;
}

.topSection {
	margin-bottom: 30px;
}

.imgSection {
	display: flex;
	flex-direction: column;
	align-items: center;
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

.buttonSection {
	display: flex;
	justify-content: center;
	
	margin-top: 50px;
}

</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<main>
	<div class="wrap">
		<div class="pageTitle"><h1>게시물 등록</h1></div>
		<div class="middle">
			<jsp:include page="aside.jsp"/>
			<section>
				<div class="sectionMain">
					<div class="topSection">
						<table>
							<tr>
							    <td>타입</td>
							    <td>
							    	<select name="tpCD" id="tpCD">
										<option value="0">선택</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'TP01'}">
												<c:choose>
													<c:when test = "${item.dtCD >= 2 }">
														<c:choose>
													         <c:when test = "${sessionScope.userDTO.raCD <= 6}">
													            <option value="${item.dtCD}">${item.dtCDNM}</option>
													         </c:when>
													         <c:otherwise>
													         
													         </c:otherwise>
												    	</c:choose>
													</c:when>
													<c:otherwise>
												         <option value="${item.dtCD}">${item.dtCDNM}</option>
												    </c:otherwise>
												</c:choose>
											</c:if>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td>제목</td>
							    <td><input type="text" id="boTi" maxlength="50"></td>
							</tr>
						</table>
					</div>
					<div class="bottomSection">
						<table>
							
							<tr>
							    <td colspan="2">
							   		<div class=imgSection>
										<img id="img">
										<label for="file1" class="imgLabel">사진 첨부</label> 
										<input type="file" id="file1" name="file1"> 
										<button id="btn_submit" onclick="javascript:fn_submit()">전송</button>    
									</div>
							   	</td>
							</tr>
							<tr class="boTXTRow">
							    <td>내용</td>
							    <td class="boTXTWrap">
							    	<div id="editor"></div>
							    	<script>
									    const Editor = toastui.Editor;
									
									    const editor = new Editor({
									            el: document.querySelector('#editor'),
									            height: '500px',
									            initialEditType: 'WYSIWYG',
									            previewStyle: 'vertical'
									        });
									</script>
							    </td>
							</tr>
						</table>
					</div>
				</div>
				<div class="buttonSection">
					<button id="add" onclick="add2()">등록</button>
					<button id="cancel" onclick="cancel()">취소</button>
				</div>
			</section>
		</div>
	</div>
</main>
</body>
</html>