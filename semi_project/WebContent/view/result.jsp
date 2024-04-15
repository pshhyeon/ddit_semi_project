<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%if((int)request.getAttribute("cnt") > 0){%>
	{"flag":"true"}
<%} else {%>
	{"flag":"false"}
<%}%>