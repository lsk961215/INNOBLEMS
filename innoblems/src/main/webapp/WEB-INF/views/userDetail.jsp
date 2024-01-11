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
<script>
	$(function(){
		setBirth()
		setAddress()
		setSkills()
		
		$("#usrNm").keyup(function (event) {
	    	var regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	        v = $(this).val();
	        if (regexp.test(v)) {
	            alert("한글만 입력가능 합니다.");
	            $(this).val(v.replace(regexp, ''));
	        }
	    });
		
		$("#usrEm").focusout(function (event) {
			let check = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    		
    		if(!check.test($(this).val()) || !$(this).val() == null ){
    			alert("이메일이 형식에 맞지 않습니다.")
    		}  else {
    			
    		}
		});
		
		$("#usrBDT").focusout(function(){
			if($(this).val() == ""){
				$(this).val("")
			} else {
				$("#usrINDT").prop("min", $(this).val())
				if($("#usrINDT").val() == ""){
					
				} else {
					if($(this).val() <= $("#usrINDT").val()){
						
					} else {
						alert("날짜값이 올바르지 않습니다.")
						$(this).val("")
					}
				}
			}
		})
		
		$("#usrINDT").focusout(function(){
			if($(this).val() == ""){
				$(this).val("")
			} else {
				$("#usrBDT").prop("max", $(this).val())
				if($("#usrBDT").val() == ""){
					
				} else {
					if($(this).val() >= $("#usrBDT").val()){
						
					} else {
						alert("날짜값이 올바르지 않습니다.")
						$(this).val("")
					}
				}
			}
		})
	})	
	
	function setBirth (){
		var today = new Date()
		
		var date = today.getFullYear() +
		'-' + ( (today.getMonth()+1) < 9 ? "0" + (today.getMonth()+1) : (today.getMonth()+1) )+
		'-' + ( (today.getDate()) < 9 ? "0" + (today.getDate()) : (today.getDate()) )
		
		$("#usrBDT").prop("max", date)
	}
	
	function chagePwButton(){
		var pwRow = "<input type='password' id='usrPw' maxlength='16' placeholder='특수문자, 영문포함 16글자'>"
		var pwCheckRow = "<input type='password' id='usrPwCheck' maxlength='16' placeholder='특수문자, 영문포함 16글자'>"
		
		if($("#usrPw").val() == undefined){
			$(".pwRow").append(pwRow);
			$(".pwCheckRow").append(pwCheckRow);	
		} else {
			$("#usrPw").remove()
			$("#usrPwCheck").remove()
		}
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
	
	function setAddress() {
		var usrAd = '${userDTO.usrAd}'
		
		var usrAdArr = usrAd.split(", ")
		
		$("#postcode").val(usrAdArr[0])
		$("#roadAddress").val(usrAdArr[1])
		$("#detailAddress").val(usrAdArr[2])
		
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
		window.close();
	}
	
	function save(){
        
        var usrSeq = $("#usrSeq").val()
        var usrId = $("#usrId").val()
		var usrPw = $("#usrPw").val()
		var usrNm = $("#usrNm").val()
		var usrImg
		var usrBDT = $("#usrBDT").val()
		var usrINDT = $("#usrINDT").val()
		var usrPn = $("#usrPn").val()
		var usrEm = $("#usrEm").val()
		var usrAd = $("#postcode").val() + ", " + $("#roadAddress").val() + ", " + $("#detailAddress").val()
		var raCD = $("#raCD").val()
		var stCD = $("#stCD").val()
		var gdCD = $("#gdCD").val()
		var grCD = $("#grCD").val()
		var dvCD = $("#dvCD").val()
		var skills = new Array()
		
		$(".skill").each(function(){
			if($(this).is(":checked")==true){
				skills.push($(this).val())
		    }
		})
		
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
        
        if(usrNm != "" && usrId != "" && pwCheck != false && usrINDT != "" && skillsCheck != false && usrPn != ""){
        	if(form.get("file1") == "undefined") {
        		console.log("업로드된 이미지 없음")
        		
        		var param = "usrId="+usrId
	       		param += "&usrSeq="+usrSeq
	       		if(usrPw != undefined){
	       			param += "&usrPw="+usrPw
	       		}
	       		param += "&usrNm="+usrNm
	       		param += "&usrBDT="+usrBDT
	       		param += "&usrINDT="+usrINDT
	       		param += "&usrPn="+usrPn
	       		param += "&usrEm="+usrEm
	       		param += "&usrAd="+usrAd
	       		param += "&stCD="+stCD
	       		param += "&raCD="+raCD
	       		param += "&gdCD="+gdCD
	       		param += "&grCD="+grCD
	       		param += "&dvCD="+dvCD
	       		param += "&skills="
	       		
	       		for(var i = 0; i<skills.length; i++){
	       			param += skills[i]
	       			if(i != skills.length - 1){
	       				param += ","
	       			}
	       		}
               
               console.log("param" + param)
               
               $.ajax({
			        url: "saveUser", 
			        type:"post",
			        data: param,
			        success: function(data) {
			        	alert("저장되었습니다.")
			        },
			        error: function() {
			            alert("통신실패")
			        }
			    })
        	} else {
        		console.log("업로드된 이미지 있음")
        		
        		jQuery.ajax({
		             url : "result"
		           , type : "POST"
		           , processData : false
		           , contentType : false
		           , data : form
		           , success:function(response) {
		               
		        	   if(response != -1){
		        		   usrImg = response;
			               
			               console.log("usrImg = " + usrImg)
			               
			              	var param = "usrId="+usrId
				       		param += "&usrSeq="+usrSeq
				       		param += "&usrPw="+usrPw
				       		param += "&usrNm="+usrNm
				       		param += "&usrImg="+usrImg
				       		param += "&usrBDT="+usrBDT
				       		param += "&usrINDT="+usrINDT
				       		param += "&usrPn="+usrPn
				       		param += "&usrEm="+usrEm
				       		param += "&usrAd="+usrAd
				       		param += "&stCD="+stCD
				       		param += "&raCD="+raCD
				       		param += "&gdCD="+gdCD
				       		param += "&grCD="+grCD
				       		param += "&dvCD="+dvCD
				       		param += "&skills="
				       		
				       		for(var i = 0; i<skills.length; i++){
				       			param += skills[i]
				       			if(i != skills.length - 1){
				       				param += ","
				       			}
				       		}
			               
			               console.log("param" + param)
			               
			               $.ajax({
						        url: "saveUser", 
						        type:"post",
						        data: param,
						        success: function(data) {
						        	alert("저장되었습니다.")
						        	opener.getUserList(1)
						        },
						        error: function() {
						            alert("통신실패")
						        }
						    }) 
		        	   } else {
		        		   alert("이미지는 5MB 이하의 파일만 가능합니다.")
		        	   }
		               
		           }
		           ,error: function (jqXHR) 
		           { 
		               console.log(jqXHR); 
		           }
		       	})
        	}
        } else {
        	alert("필수항목을 입력해주세요")
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
	width: 100%;
}
	
section {
	background-color: white;
	width: 100%;
			
	display: flex;
	flex-direction: column;
	
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
	left: -30px;
	
	width: max-content;
	
	font-size: 150%;
}

#save {
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
	
	margin-left: 50px;
	
	width: 100%;
	
	padding: 30px;
}

.skills {
	display: flex;
	flex-wrap: wrap;
}

#postcode {
	width: 100px;
}

#checkText {
	display: none;
}

#usrSeq {
	background-color: lightgrey;
}

#usrId {
	background-color: lightgrey;
}

#postcode {
	background-color: lightgrey;
}

#roadAddress {
	background-color: lightgrey;
}

.star {
	color: red;
}

.pwChangeButton {
	border: none;
	background-color: #0C70F2;
	color: white;
	
	font-weight: bold;
	
	width: 140px;
	height: 20px;
	
	cursor: pointer;
}
</style>
</head>
<body>
<main>
			<section>
			<div class="pageTitle"><h1>사원 상세/수정</h1></div>
				<div class="sectionMain">
					<div class=imgSection>
						<c:if test = "${userDTO.usrImg == null}">
							<img id="img" src="resources/userImages/default.png">
						</c:if>
						<c:if test = "${userDTO.usrImg != null}">
							<img id="img" src="resources/userImages/${userDTO.usrImg}">
						</c:if>
					    <label for="file1" class="imgLabel">파일 선택</label> 
					    <input type="file" id="file1" name="file1"> 
					    <button id="btn_submit" onclick="javascript:fn_submit()">전송</button>    
					</div>
					<div class="detailSection">
						<small class="essential"><a class="star">*</a>는 필수항목</small>
						<table>
							<tr>
								<td>사원번호</td>
								<td><input type="text" id="usrSeq" value="${userDTO.usrSeq}" readonly></td>
								<td>입사일<a class="star">*</a></td>
					    		<td><input type="date" id="usrINDT" value="${userDTO.usrINDT}" max="9999-12-31"></td>
							</tr>
					    	<tr>
					    		<td>사원명<a class="star">*</a></td>
					    		<td><input type="text" id="usrNm" value="${userDTO.usrNm}" maxlength="10" style="ime-mode:active;" placeholder="한글 10글자"></td>
					    		<td>재직상태</td>
					    		<td>
					    			<select name="stCD" id="stCD">
										<option value="0">선택</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'ST01'}">
												<c:if test = "${item.dtCD == userDTO.stCD}">
													<option value="${item.dtCD}" selected>${item.dtCDNM}</option>
												</c:if>
												<c:if test = "${item.dtCD != userDTO.stCD}">
													<option value="${item.dtCD}">${item.dtCDNM}</option>
												</c:if>
											</c:if>
										</c:forEach>
									</select>
					    		</td>
					    	</tr> 
					    	<tr>
					    		<td>아이디</td>
					    		<td><input type="text" id="usrId"  value="${userDTO.usrId}" readonly></td>
					    		<td>직급</td>
					    		<td>
						    		<select name="raCD" id="raCD">
										<option value="0">선택</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'RA01'}">
												<c:if test = "${item.dtCD == userDTO.raCD}">
													<option value="${item.dtCD}" selected>${item.dtCDNM}</option>
												</c:if>
												<c:if test = "${item.dtCD != userDTO.raCD}">
													<option value="${item.dtCD}">${item.dtCDNM}</option>
												</c:if>
											</c:if>
										</c:forEach>
									</select>
					    		</td>
					    	</tr> 
					    	<tr>
					    		<td>비밀번호<a class="star">*</a></td>
					    		<td class="pwRow"><button class="pwChangeButton" onclick="chagePwButton(); pwCheck()">비밀번호 변경하기</button></td>
					    		<td>기술등급</td>
					    		<td>
					    			<select name="grCD" id="grCD">
										<option value="0">선택</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'GR01'}">
												<c:if test = "${item.dtCD == userDTO.grCD}">
													<option value="${item.dtCD}" selected>${item.dtCDNM}</option>
												</c:if>
												<c:if test = "${item.dtCD != userDTO.grCD}">
													<option value="${item.dtCD}">${item.dtCDNM}</option>
												</c:if>
											</c:if>
										</c:forEach>
									</select>
								</td>
					    	</tr> 
					    	<tr>
					    		<td>비밀번호 확인<a class="star">*</a></td>
					    		<td class="pwCheckRow"></td>
					    		<td>개발분야</td>
					    		<td>
						    		<select name="dvCD" id="dvCD">
										<option value="0">선택</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'DV01'}">
												<c:if test = "${item.dtCD == userDTO.dvCD}">
													<option value="${item.dtCD}" selected>${item.dtCDNM}</option>
												</c:if>
												<c:if test = "${item.dtCD != userDTO.dvCD}">
													<option value="${item.dtCD}">${item.dtCDNM}</option>
												</c:if>
											</c:if>
										</c:forEach>
									</select>
					    		</td>
					    	</tr> 
					    	<tr>
					    		<td colspan="2">
					    			<button onclick="pwView()">보기</button>
					    			<div id="checkText">
					    			</div>
					    		</td>
					    		<td>전화번호<a class="star">*</a></td>
					    		<td><input type="text" id="usrPn" value="${userDTO.usrPn}" placeholder="숫자만 입력해주세요" maxlength="11" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
					    	</tr> 
					    	<tr>
					    		<td>생년월일</td>
					    		<td><input type="date" id="usrBDT" value="${userDTO.usrBDT}" max="9999-12-31"></td>
					    		<td>이메일</td>
					    		<td><input type="text" id="usrEm" value="${userDTO.usrEm}" placeholder="~@~ 형식으로 입력해주세요"></td>
					    	</tr> 
					    	<tr>
					    		<td>성별</td>
					    		<td>
					    			<select name="gdCD" id="gdCD">
										<option value="0">선택</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'GD01'}">
												<c:if test = "${item.dtCD == userDTO.gdCD}">
													<option value="${item.dtCD}" selected>${item.dtCDNM}</option>
												</c:if>
												<c:if test = "${item.dtCD != userDTO.gdCD}">
													<option value="${item.dtCD}">${item.dtCDNM}</option>
												</c:if>
											</c:if>
										</c:forEach>
									</select>
					    		</td>
					    		<td colspan="2"></td>
					    	</tr> 
					    	<tr>
					    		<td>주소</td>
					    		<td colspan="3">				    			
					    			<input type="text" id="postcode" placeholder="우편번호" readonly>
									<input type="button" id="search" onclick="sample4_execDaumPostcode()" value="주소 검색"><br>
									<input type="text" id="roadAddress" placeholder="도로명주소" readonly>
									<input type="text" id="detailAddress" placeholder="상세주소" maxlength="100">
					    		</td>
					    	</tr> 
					    	<tr>
					    		<td>보유기술<a class="star">*</a></td>
					    		<td colspan="3">
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
						</table>
					</div>
				</div>
				<div class="buttonSection">
					<button id="save" onclick="save()">저장</button>
					<button id="cancel" onclick="cancel()">취소</a>
				</div>
				
			</section>
</main>
</body>
</html>