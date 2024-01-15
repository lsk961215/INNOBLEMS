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
	            alert("�ѱ۸� �Է°��� �մϴ�.");
	            $(this).val(v.replace(regexp, ''));
	        }
	    });
		
		$("#usrEm").focusout(function (event) {
			let check = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    		
    		if(!check.test($(this).val()) || !$(this).val() == null){
    			alert("�̸����� ���Ŀ� ���� �ʽ��ϴ�.")
    		}  else {
    			
    		}
		});
		
		$("#usrId").keyup(function (event) {
	    	regexp = /^[a-zA-Z0-9]*$/;
	        v = $(this).val();
	        if (!regexp.test(v)) {
	            alert("�ҹ��ڿ� ���ڸ� �Է°��� �մϴ�.");
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
				$("#checkText").text("��й�ȣ�� ��ġ�մϴ�.")
				$("#checkText").css("color", "green")
				$("#checkText").css("display", "block")
			} else {
				$("#checkText").text("��й�ȣ�� ��ġ���� �ʽ��ϴ�.")
				$("#checkText").css("color", "red")
				$("#checkText").css("display", "block")
			}
		})
		
		$("#usrPwCheck").keyup(function (){
			if($(this).val() == $("#usrPw").val()){
				$("#checkText").text("��й�ȣ�� ��ġ�մϴ�.")
				$("#checkText").css("color", "green")
				$("#checkText").css("display", "block")
			} else {
				$("#checkText").text("��й�ȣ�� ��ġ���� �ʽ��ϴ�.")
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
            	alert("��ϵǾ����ϴ�.")
            	opener.getBoardList(1)
            },
            error: function() {
            	alert("��Ž���")
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
        	alert("Ÿ���� �������ּ���.")
        } else {
        	if(boTi == ""){
        		alert("������ �Է����ּ���.")
        	} else {
        		if(boTXT == ""){
        			alert("������ �Է����ּ���.")
        		} else {
        			if($("#file1").val() != ""){
                		jQuery.ajax({
                            url : "boardImage"
                          , type : "POST"
                          , processData : false
                          , contentType : false
                          , data : form
                          , success:function(response) {
                             console.log("�̹������� �̸� = "+ response)
                       	   if(response != -1){
                        	boImg = response;
                           	   
                              } else {
                           	   alert("�̹����� 5MB ������ ���ϸ� �����մϴ�.")
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
              			        	alert("��ϵǾ����ϴ�.")
              			        	opener.getBoardList(1)
              			        },
              			        error: function() {
              			            alert("��Ž���")
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
    //�̹��� �̸�����
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
                alert("Ȯ���ڴ� �̹��� Ȯ���ڸ� �����մϴ�.");
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
//���� ���ε�
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
               alert("�����Ͽ����ϴ�.");
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
    //�� ���������� ���θ� �ּ� ǥ�� ��Ŀ� ���� ���ɿ� ����, �������� �����͸� �����Ͽ� �ùٸ� �ּҸ� �����ϴ� ����� �����մϴ�.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

                // ���θ� �ּ��� ���� ��Ģ�� ���� �ּҸ� ǥ���Ѵ�.
                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
                var roadAddr = data.roadAddress; // ���θ� �ּ� ����
                var extraRoadAddr = ''; // ���� �׸� ����

                // ���������� ���� ��� �߰��Ѵ�. (�������� ����)
                // �������� ��� ������ ���ڰ� "��/��/��"�� ������.
                if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // ǥ���� �����׸��� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
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
		<div class="pageTitle"><h1>�Խù� ���</h1></div>
		<div class="middle">
			<jsp:include page="aside.jsp"/>
			<section>
				<div class="sectionMain">
					<div class="topSection">
						<table>
							<tr>
							    <td>Ÿ��</td>
							    <td>
							    	<select name="tpCD" id="tpCD">
										<option value="0">����</option>
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
								<td>����</td>
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
										<label for="file1" class="imgLabel">���� ÷��</label> 
										<input type="file" id="file1" name="file1"> 
										<button id="btn_submit" onclick="javascript:fn_submit()">����</button>    
									</div>
							   	</td>
							</tr>
							<tr class="boTXTRow">
							    <td>����</td>
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
					<button id="add" onclick="add2()">���</button>
					<button id="cancel" onclick="cancel()">���</button>
				</div>
			</section>
		</div>
	</div>
</main>
</body>
</html>