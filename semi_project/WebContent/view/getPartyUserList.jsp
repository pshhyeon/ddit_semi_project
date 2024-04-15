<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="ddit.vo.UserVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<UserVO> list = (List<UserVO>)request.getAttribute("list");

	for(UserVO vo : list){
		System.out.println("@@view/getPartyUserListjsp@@" + vo);
	}

	JsonObject obj = new JsonObject();
	Gson gson = new Gson();
	JsonElement jele = gson.toJsonTree(list);
	obj.add("list", jele);
	out.print(obj);
	out.flush();
%>