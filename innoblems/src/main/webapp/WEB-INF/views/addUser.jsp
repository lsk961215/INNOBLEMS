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
	
	function add(){
        
        var usrId = $("#usrId").val()
		var usrPw = $("#usrPw").val()
		var usrNm = $("#usrNm").val()
		var usrImg = "";
		var usrBDT = $("#usrBDT").val()
		var usrINDT = $("#usrINDT").val()
		var usrPn = $("#usrPn").val()
		var usrEm = $("#usrEm").val()
		var usrAd = $("#postcode").val() + ", " + $("#roadAddress").val() + ", " + $("#detailAddress").val()
		var raCD = $("#raCD").val()
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
        	if($("#file1").val() != ""){
        		jQuery.ajax({
                    url : "result"
                  , type : "POST"
                  , processData : false
                  , contentType : false
                  , data : form
                  , success:function(response) {
                     
               	   if(response != -1){
                   	  usrImg = response;
                   	   
                      } else {
                   	   alert("�̹����� 5MB ������ ���ϸ� �����մϴ�.")
                      }
                      
                  }
                  ,error: function (jqXHR) 
                  { 
                      alert(jqXHR.responseText); 
                  }
              	})
        	}
        	
        	var param = "usrId="+usrId
	       		param += "&usrPw="+usrPw
	       		param += "&usrNm="+usrNm
	       		param += "&usrImg="+usrImg
	       		param += "&usrBDT="+usrBDT
	       		param += "&usrINDT="+usrINDT
	       		param += "&usrPn="+usrPn
	       		param += "&usrEm="+usrEm
	       		param += "&usrAd="+usrAd
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
			        url: "addUser", 
			        type:"post",
			        data: param,
			        success: function(data) {
			        	alert("��ϵǾ����ϴ�.")
			        	opener.getUserList(1)
			        },
			        error: function() {
			            alert("��Ž���")
			        }
			    })
        	
        } else {
        	alert("�ʼ��׸��� �Է����ּ���")
        }
		
	}
	
	function cancel(){
		window.close()
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
	left: 10px;

	
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
	background-color: lightgrey;
}

#roadAddress {
	background-color: lightgrey;
}
#checkText {
	display: none;
}

.star {
	color: red;
}

</style>
</head>
<body>
<main>
	<section>
	<div class="pageTitle"><h1>��� ���</h1></div>
		<div class="sectionMain">
			<div class=imgSection>
				<img id="img" src="resources/userImages/default.png">
					<label for="file1" class="imgLabel">���� ����</label> 
					<input type="file" id="file1" name="file1"> 
					<button id="btn_submit" onclick="javascript:fn_submit()">����</button>    
			</div>
			<div class="detailSection">
				<small class="essential"><a class="star">*</a>�� �ʼ��׸�</small>
				<table>
					<tr>
						<td>�����<a class="star">*</a></td>
					    <td><input type="text" id="usrNm" maxlength="10" style="ime-mode:active;" placeholder="�ѱ� 10����"></td>
					    <td>�Ի���<a class="star">*</a></td>
					    <td><input type="date" id="usrINDT"></td>
					</tr> 
					<tr>
					    <td>���̵�<a class="star">*</a></td>
					    <td><input type="text" id="usrId" maxlength="20" placeholder="�ҹ���, ���� 20����"></td>
					    <td>����</td>
					    <td>
						    <select name="raCD" id="raCD">
								<option value="0">����</option>
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'RA01'}">
										<option value="${item.dtCD}">${item.dtCDNM}</option>
									</c:if>
								</c:forEach>
							</select>
					    </td>
					</tr> 
					<tr>
					    <td>��й�ȣ<a class="star">*</a></td>
					    <td><input type="password" id="usrPw" maxlength="16" placeholder="Ư������, �������� 16����"></td>
					    <td>������</td>
					    <td>
					    	<select name="grCD" id="grCD">
								<option value="0">����</option>
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'GR01'}">
										<option value="${item.dtCD}">${item.dtCDNM}</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
					</tr> 
					<tr>
					    <td>��й�ȣ Ȯ��<a class="star">*</a></td>
					    <td><input type="password" id="usrPwCheck" maxlength="16" placeholder="Ư������, �������� 16����"></td>
					    <td>���ߺо�</td>
					    <td>
						    <select name="dvCD" id="dvCD">
								<option value="0">����</option>
								<c:forEach var="item" items="${codeList}" varStatus="i">
									<c:if test = "${item.mstCD == 'DV01'}">
										<option value="${item.dtCD}">${item.dtCDNM}</option>
									</c:if>
								</c:forEach>
							</select>
					   </td>
					   </tr> 
					   <tr>
					   <td colspan="2">
					   <button onclick="pwView()">����</button>
					    	<div id="checkText">
					    	</div>
					   </td>
					   <td>��ȭ��ȣ<a class="star">*</a></td>
					   <td><input type="text" id="usrPn" placeholder="���ڸ� �Է����ּ���" maxlength="11" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
					   </tr> 
					   <tr>
					   <td>�������</td>
					   <td><input type="date" id="usrBDT"></td>
					   <td>�̸���</td>
					   <td><input type="text" id="usrEm" placeholder="~@~ �������� �Է����ּ���"></td>
					   </tr> 
					   <tr>
					   <td>����</td>
					   <td>
					    	<select name="gdCD" id="gdCD">
								<option value="0">����</option>
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
					   <td>�ּ�</td>
					   <td colspan="3">				    			
					    	<input type="text" id="postcode" placeholder="�����ȣ" readonly>
							<input type="button" id="search" onclick="sample4_execDaumPostcode()" value="�ּ� �˻�"><br>
							<input type="text" id="roadAddress" placeholder="���θ��ּ�" readonly>
							<input type="text" id="detailAddress" placeholder="���ּ�" maxlength="100">
					   </td>
					   </tr> 
					   <tr>
					    <td>�������<a class="star">*</a></td>
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
			<button id="add" onclick="add()">���</button>
			<button id="cancel" onclick="cancel()">���</button>
		</div>
	</section>
</main>
</body>
</html>