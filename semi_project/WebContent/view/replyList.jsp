<%@page import="ddit.vo.ReplyVO"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<ReplyVO> list = (List<ReplyVO>)request.getAttribute("list");
JsonObject obj = new JsonObject();

Gson gson = new GsonBuilder().setPrettyPrinting().create();
JsonElement ele = gson.toJsonTree(list);
obj.add("datas",ele);
System.out.println("@@replyList view @@ ==> " + ele);
out.print(obj);
out.flush();
%>