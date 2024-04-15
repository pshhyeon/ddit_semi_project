<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int res = 0;
	res = (int)request.getAttribute("userPartystatus");
	
	if (res == 1){%>
		{"flag":"1"}
	<%} else if (res == 2){%>
		{"flag":"2"}
	<%} else if (res == 3){%>
		{"flag":"3"}
	<%} else if (res == 4){%>
		{"flag":"4"}
	<%} else {%>
		{"flag":"0"}
	<%}%>
