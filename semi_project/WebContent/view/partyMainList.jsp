<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
	int sp = (Integer)request.getAttribute("startp");
	int ep = (Integer)request.getAttribute("endp");
	int tp = (Integer)request.getAttribute("totalp");
	
	JsonObject obj = new JsonObject();
	obj.addProperty("sp", sp);
	obj.addProperty("ep", ep);
	obj.addProperty("tp", tp);
	
	Gson gson = new Gson();
	JsonElement jele = gson.toJsonTree(list);
	obj.add("list", jele);
	
	System.out.println("@@view.partyMainList@@sp" + sp);
	System.out.println("@@view.partyMainList@@ep" + ep);
	System.out.println("@@view.partyMainList@@tp" + tp);
	System.out.println("@@view.partyMainList@@list JSON 객체로 변환" + jele);
	
	out.print(obj);
	out.flush();
	
%>