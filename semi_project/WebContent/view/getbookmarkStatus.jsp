<%@page import="ddit.vo.MarkVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MarkVO vo = (MarkVO)request.getAttribute("vo");
	if(vo == null) {
%>
	{"flag":"null"}
<%	
	} else {
%>
	{"flag":"exist"}
<%	
	}
%>