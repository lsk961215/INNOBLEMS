<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.spring.innoblems.dto.UserDTO" %>
<header>
	<div class="header_logo">
		<a href="/innoblems"><img src="resources/images/logo.png"></a>
	</div>
	<div>
		<ul class="menu_wrap">
			<li><img class="menu_img" src="resources/images/menu.png"></li>
				<ul class="menu">
						<%
						if(session.getAttribute("userDTO") == null){
						%>
							<li class="menu_login"><a href="goLogin">�α���</a></li>
							<li class="menu_join"><a href="goJoin_1">ȸ������</a></li>
							<%
							} else {
							%>
							<li>${sessionScope.userDTO.usrNm}�� ȯ���մϴ�.</li>
							<li class="menu_logout"><a href="logout">�α׾ƿ�</a></li>
							<li class="menu_my"><a href="goInfo">�� ����</a></li>
							<%	
							}
							%>
				</ul>
		</ul>
	</div>
</header>