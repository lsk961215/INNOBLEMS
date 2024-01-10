<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<aside>
	<c:forEach var="item" items="${codeList}" varStatus="i">
		<c:if test = "${item.mstCD == 'EM01'}">
			<a href="${item.dtCDURL}">${item.dtCDNM}</a>
		</c:if>
	</c:forEach>
	<c:forEach var="item" items="${codeList}" varStatus="i">
		<c:if test = "${sessionScope.userDTO.raCD <= 6 and sessionScope.userDTO.raCD >= 1 and item.mstCD == 'AD01'}">
			<a href="${item.dtCDURL}">${item.dtCDNM}</a>
		</c:if>
	</c:forEach>
</aside>