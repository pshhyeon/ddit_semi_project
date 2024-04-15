<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	Map<String, Object> map = (Map<String, Object>)request.getAttribute("partyDetail");
	System.out.println("@@@@ view/partyDetail @@@@ map ==> " + map);
	if (map != null) {
		Gson gson = new Gson();
		JsonObject obj = new JsonObject();
		JsonElement jele = gson.toJsonTree(map);
		obj.add("map", jele);
		
		out.print(obj);
		out.flush();
	}
%>
    
    
    