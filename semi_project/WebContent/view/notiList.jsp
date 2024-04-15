<%@page import="ddit.vo.NotificeVO"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
//컨트롤러에서 저장한 데이터 꺼내기

List<NotificeVO> list = (List<NotificeVO>)request.getAttribute("list");
int startPage = (int)request.getAttribute("startpage");
int endPage = (int)request.getAttribute("endpage");
int totalPage = (int)request.getAttribute("totalpage");

JsonObject obj = new JsonObject();
obj.addProperty("startPage", startPage);
obj.addProperty("endPage", endPage);
obj.addProperty("totalPage", totalPage);


Gson gson = new GsonBuilder().setPrettyPrinting().create();
JsonElement ele = gson.toJsonTree(list);
obj.add("datas",ele);

out.print(obj);
out.flush();

%>