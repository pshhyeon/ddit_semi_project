<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <script src="../js/jquery-3.7.1.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#go').on('click', function(){
		let nameVal = $("#mem_Id").val().trim();
		let mailVal = $("#mem_mail").val().trim();
		
		let sendData = 
			{
				"username" : nameVal,
				"usermail" : mailVal
			}
		$.ajax({
			url : "<%=request.getContextPath()%>/findId.do",
			type : 'get',
			data : sendData,
			success : function(res){
				
				var modifiedId = res.flag.substring(0, res.flag.length - 2) + "***";
				
				alert(modifiedId);
				
			},
			error : function(xhr){
				alert("오류" + xhr.status);
			},
			dataType : 'json'
		})
	})
	
	$('#cancel').on('click',function(){
		location.href = "<%=request.getContextPath()%>/user/loginForm.jsp";
	})
})

</script>
</head>
<body>
<h2>아이디 찾기</h2>
<table border="1">
 <tr>
  <td>이  름</td>
  <td><input type="text" id="mem_Id" name="id" required="required"></td>
 </tr>
 
 <tr>
  <td>이메일</td>
  <td><input type="email" id="mem_mail" name="mem_mail" required="required"></td>
 </tr>
 
 <tr>
   <td style="text-align: center;" colspan="2"> 
    <input type="button" value="입력" id="go" name="입력">
    <input value="취소" type="button" name="취소" id="cancel"> 
  </td> 
 </tr>
</table>



</body>
</html>