<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="ddit.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserVO vo = (UserVO)request.getAttribute("vo");
	System.out.println("@@@@@vovovovovo@@@@@@@@@@@" + vo);
	JsonObject obj = new JsonObject();
	Gson gson = new Gson();
	JsonElement jele = gson.toJsonTree(vo);
	obj.add("vo", jele);
	out.print(obj);
	out.flush();
%>