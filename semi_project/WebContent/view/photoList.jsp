<%@page import="ddit.vo.PhotoVO"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
List<PhotoVO> list = (List<PhotoVO>)request.getAttribute("list");


JsonObject obj = new JsonObject();

Gson gson = new GsonBuilder().setPrettyPrinting().create();
JsonElement ele = gson.toJsonTree(list);
obj.add("datas",ele);

out.print(obj);
out.flush();


%>