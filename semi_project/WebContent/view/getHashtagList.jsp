<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="ddit.vo.HashtagVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<HashtagVO> list = (List<HashtagVO>)request.getAttribute("list");
	
// 	for(int i = 0; i < list.size(); i++){
// 		HashtagVO vo = list.get(i);
// 		System.out.println("@view/getHashtagList.jsp "+i +"번째 ==> " + vo);
// 	}
	JsonObject obj = new JsonObject();
	Gson gson = new Gson();
	JsonElement jele = gson.toJsonTree(list);
	obj.add("HashmapList", jele);
	out.print(obj);
	out.flush();
%>