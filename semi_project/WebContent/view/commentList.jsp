<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="ddit.vo.CommentVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
List<CommentVO> list = (List<CommentVO>)request.getAttribute("list");
List<CommentVO> nicknameList = (List<CommentVO>)request.getAttribute("nicknameList");

JsonObject obj = new JsonObject();
JsonArray dataArray = new JsonArray();

Gson gson = new GsonBuilder().setPrettyPrinting().create();

for(int i = 0; i<list.size(); i++){
	CommentVO comment =list.get(i);
	CommentVO nickname = nicknameList.get(i);
	
	JsonObject dataObj = new JsonObject();
	dataObj.addProperty("comments_no", comment.getComments_no());
	dataObj.addProperty("comments_con", comment.getComments_con());
	dataObj.addProperty("nickname", nickname.getNickname());
	dataObj.addProperty("user_no", comment.getUser_no());
			
	
	dataArray.add(dataObj);
	
}
obj.add("datas",dataArray);

out.print(obj);
out.flush();




%>