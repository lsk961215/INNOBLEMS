<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1> 사원 리스트 </h1>

					<c:forEach var="item" items="${userList}" varStatus="i">
						item.toString()
					</c:forEach>
</body>
</html>