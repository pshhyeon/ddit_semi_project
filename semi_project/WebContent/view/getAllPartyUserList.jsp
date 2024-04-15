<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
	JsonObject obj = new JsonObject();
	Gson gson = new Gson();
	JsonElement jele = gson.toJsonTree(list);
	obj.add("list", jele);
	out.print(obj);
	out.flush();
%>