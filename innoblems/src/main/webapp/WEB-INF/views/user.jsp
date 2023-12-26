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
		
	})
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
	
	padding: 50px;
}

button {
	border: none;
	background-color: white;
	cursor: pointer;
}

table input[type=text], table input[type=password] {
	width: 80%;
}

select {
	width: 80%;
}

table {
	width: 100%;
	
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
	top: 25px;
	left: 20px;
	
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
	border: none;
	background-color: lightgrey;
	color: white;
	
	font-weight: bold;
	font-size: 105%;
	
	width: 80px;
	height: 30px;
	
	cursor: pointer;
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
				<div class="sectionMain">
					<div class=imgSection>
						<img id="img" src="resources/userImages/default.png">
					    <label for="file1" class="imgLabel">파일 선택</label> 
					    <input type="file" id="file1" name="file1"> 
					    <button id="btn_submit" onclick="javascript:fn_submit()">전송</button>    
					</div>
					<div class="detailSection">
						<table>
					    	<tr>
					    		<td>사원명</td>
					    		<td><input type="text"></td>
					    		<td>입사일</td>
					    		<td><input type="date"></td>
					    	</tr> 
					    	<tr>
					    		<td>아이디</td>
					    		<td><input type="text"></td>
					    		<td>직급</td>
					    		<td>
						    		<select name="raCD" id="raCD">
										<option value="0">선택</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'RA01'}">
												<option value="${item.dtCD}">${item.dtCDNM}</option>
											</c:if>
										</c:forEach>
									</select>
					    		</td>
					    	</tr> 
					    	<tr>
					    		<td>비밀번호</td>
					    		<td><input type="password"></td>
					    		<td>기술등급</td>
					    		<td>
					    			<select name="grCD" id="grCD">
										<option value="0">선택</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'GR01'}">
												<option value="${item.dtCD}">${item.dtCDNM}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
					    	</tr> 
					    	<tr>
					    		<td>비밀번호 확인</td>
					    		<td><input type="password"></td>
					    		<td>개발분야</td>
					    		<td>
						    		<select name="dvCD" id="dvCD">
										<option value="0">선택</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'DV01'}">
												<option value="${item.dtCD}">${item.dtCDNM}</option>
											</c:if>
										</c:forEach>
									</select>
					    		</td>
					    	</tr> 
					    	<tr>
					    		<td colspan="2"></td>
					    		<td>전화번호</td>
					    		<td><input type="text"></td>
					    	</tr> 
					    	<tr>
					    		<td>생년월일</td>
					    		<td><input type="date"></td>
					    		<td>이메일</td>
					    		<td><input type="text"></td>
					    	</tr> 
					    	<tr>
					    		<td>성별</td>
					    		<td>
					    			<select name="gdCD" id="gdCD">
										<option value="0">선택</option>
										<c:forEach var="item" items="${codeList}" varStatus="i">
											<c:if test = "${item.mstCD == 'GD01'}">
												<option value="${item.dtCD}">${item.dtCDNM}</option>
											</c:if>
										</c:forEach>
									</select>
					    		</td>
					    		<td colspan="2"></td>
					    	</tr> 
					    	<tr>
					    		<td>주소</td>
					    		<td colspan="3">
					    			<input type="text">
					    			<button id="search">주소 검색</button>
					    		</td>
					    	</tr> 
					    	<tr>
					    		<td>보유기술</td>
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
					    	<tr>
					    		<td></td>
					    		<td colspan="3"></td>
					    	</tr> 
					    	<tr>
					    		<td></td>
					    		<td colspan="3"></td>
					    	</tr> 
						</table>
					</div>
				</div>
				<div class="buttonSection">
					<button id="add">등록</button>
					<button id="cancel">취소</button>
				</div>
				
			</section>
		</div>
		
	</div>
	
</main>
</body>
</html>