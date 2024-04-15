<%@page import="ddit.vo.PhotoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	PhotoVO vo = (PhotoVO)request.getAttribute("pvo");
%>
	{
		"ptitle" : "<%=vo.getPhoto_title() %>",
		"pcontent" : "<%=vo.getPhoto_content() %>",
		"pdate" : "<%=vo.getPhoto_date() %>",
		"pcount" : "<%=vo.getPhoto_count() %>",
		"pfilename" : "<%=vo.getPhoto_filename() %>",
		"ppartyno" : "<%=vo.getParty_no() %>",
		"puserno" : "<%=vo.getUser_no() %>",
		"pnickname" : "<%=vo.getNickname() %>"
	}