<%@page import="java.util.List"%>
<%@page import="ddit.vo.ReplyVO"%>
<%@page import="ddit.vo.UserVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="ddit.vo.RequestVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true"  %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%
// ReplyVO rvo = (ReplyVO)request.getAttribute("rvo"); 
RequestVO vo  = (RequestVO)request.getAttribute("vo");
List<ReplyVO> rlist = (List<ReplyVO>)request.getAttribute("list"); 
int userNo = 0;
int boardUserNo = 0;
int requestNo =0;
String userJsonStr = (String) session.getAttribute("user");
// 세션에서 JSON 데이터를 문자열로 가져오기
if(userJsonStr != null) {
   userJsonStr = (String) session.getAttribute("user");
   
   Gson gson = new Gson();
   UserVO user = gson.fromJson(userJsonStr, UserVO.class);

   // 필요한 속성에 접근하여 데이터를 가져옵니다.
   //얘는 현재 로그인되어있는놈
   userNo = user.getUser_no();
   
   //얘는 요구사항 쓴놈
   boardUserNo = vo.getUser_no();
   
   
   requestNo = vo.getRequest_no();
   System.out.println("@@@@@user번호 정보+++++++ : " + userNo);
   
   
}
%>
 <script src="/semi_project/js/jquery-3.7.1.min.js"></script>
 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="/semi_project/js/jquery.serializejson.min.js"></script>
<script src="/semi_project/js/weather.js" defer></script>
<style>
.con{
	text-align : center; 
}
#delbox{
	text-align : right;
}
/*  .reply-content {
        max-height: 200px; /* 최대 높이 지정 */
        overflow-y: auto; /* 세로 스크롤을 추가하여 내용이 넘치면 스크롤 표시 */
    } */
    .reply-content {
        white-space: pre-line;
    }

</style>
</head>
<body>
<script>
$(function(){
	
	
	let myPath = "<%=request.getContextPath()%>";
	let user = <%=session.getAttribute("user")%>;
	
	$(document).on('click',"#link-myPage",function(){
		if(user == null) {
			location.href = `${myPath}/user/loginForm.jsp`;
		} else if(user.user_admin_chk == "Y") {
			location.href = `${myPath}/user/adminPage.jsp`;
		} else {
			location.href = `${myPath}/user/myPage.jsp`;
		}
		});
	
	console.log(user);
	$(document).on('click','#del',function(){
		if(user !=null && <%=vo.getUser_no() %> ==<%=userNo%> || user.user_admin_chk == "Y"){
			
			let result = confirm("정말로 삭제하시겠습니까?"); 
			
			reqeust_no = <%=vo.getRequest_no()%>;
			if(result){
				$.ajax({
					url : `${myPath}/requestDelete.do`,
					type : 'get',
					data : {"request_no" : <%=vo.getRequest_no()%>},
					success : function(res){
						alert("삭제가 완료되었습니다.");
						location.href = `${myPath}/request/requestMain.jsp`;
					},
					error : function(xhr){
						alert("실패 : "+xhr.status);
					},
					dataType : 'json'
				})
				
			}else{
				
			}
			
		}
		
	});
	
	
	
function listReply() {
    //let requestNo = parseInt($(this).parent().find("rno").text());
    let requestNo = <%= vo.getRequest_no() %>;
    console.log(requestNo);
    
    $.ajax({
        url : `${myPath}/replyList.do`,
        data : {"requestNo" : requestNo},
        type : 'get',
        success : function(res){
        	let resLength = res.length
        	let res_check = 'no-data'
        	if(resLength != 0){
        		res_check = 'yes-data'
        	}
        	
            let code = `<table class='table' id = ${res_check} >
                            <thead>
                                <tr>
                                    <th style="display : none">#</th>
                                    <th>관리자</th>
                                    <th>내용</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>`;
            $.each(res, function(index, reply) {
            	console.log(reply)
                code += `<tr class='rno-1'>
                            <td class='rno' style="display : none">${res.request_no}</td>
                            <td class='rtitle'>${reply.reply_title}</td>
                            <td class='rcontent reply-content'><pre>${reply.reply_content}</pre></td>`;
                    code += `<td style="text-align : right">
                                <input idx="${reply.request_no}" type="button" value = "수정" id="rmodi" name="rmodi" class="btn btn-danger">
                                <input idx="${reply.request_no}" type="button" value = "삭제" id="rdel"  name="rdel" class="btn btn-danger">
                            <td>`;
                code += `</tr>`;
            });
            code += `</tbody>
                    </table>`;
            $('#listReply').html(code);
            let data_check = $("#no-data").length
            if(data_check == 0){
            	$("#data-check").html("")
            }
        },
        error : function(xhr){
            alert("실패" + xhr.status);
        },
        dataType : 'json'
    });
}

// 함수 호출
listReply();


 $(document).on('click' , '#rdel' , function(){
	//rindex = $(this).closest('tr').find(".rno").html();
	requestNo = <%= requestNo %>;
	console.log(requestNo);
	if(user.user_admin_chk == "Y"){
		let result = confirm("삭제를 진행하시겠습니까?");
		if(result){
			$.ajax({
				url : `${myPath}/replyDelete.do`,
				type : 'get',
				data : {"requestNo" : requestNo},
				success : function(res){
					location.reload();		
					//alert("결과 : "+res.flag);
				},
				error : function(xhr){
					alert("실패: "+xhr.status);
				},
				dataType : 'json'
			})
		}
		
	}
}) 
		//댓글 작성하기
	$('#contentWriteBtn').on('click',function(){
		titleValue = $('#titleWrite').val();;
		contentValue = $('#contentWrite').val();
		console.log(titleValue , contentValue);
		requestNo = <%= vo.getRequest_no() %>;
		if(user.user_admin_chk == "Y"){
		//보드넘버, 유저넘버
	 		$.ajax({
				url : `${myPath}/replyInsert.do`,
				type : 'get',
				data : {"request_no" : requestNo,
					"reply_title" : titleValue,
					"reply_content" : contentValue},
				success : function(res){
					location.reload();				
				},
				error : function(xhr){
					alert("실패 : "+xhr.status);
				},
				dataType : 'json'
				
			})
			
		}
		else{
			alert("관리자 권한이 없습니다");
		}
		
	}) 
	
	
	$(function(){
	      if(user.user_admin_chk == "Y"){
	    	  
		    // 수정 버튼 클릭 시
		    $(document).on('click','#rmodi', function(){
			    // 수정할 답변의 번호
		    	requestNo = <%= vo.getRequest_no() %>;
		    	//console.log(requestNo);
		        
		        // 현재 답변의 내용 가져오기
		        let modifiedTitle = $(this).closest('tr').find(".rtitle").text();
		        let modifiedContent = $(this).closest('tr').find(".rcontent").text();
		        
		        // 모달에 내용 채우기
		        $("#modifiedTitle").val(modifiedTitle);
		        $("#modifiedContent").val(modifiedContent);
		        
		        // 모달 열기
		        $("#replyModal").modal('show');
		    });
	    	  
	      }

	    
	    
	    
	    // 수정 완료 버튼 클릭 시
	    $(document).on('click','#updateReplyBtn', function(){
	        // 수정된 내용 가져오기
	        let modifiedTitle = $("#modifiedTitle").val();
	        let modifiedContent = $("#modifiedContent").val();
	        console.log(modifiedTitle);
	        console.log(modifiedContent);
	        console.log(requestNo);
	        
	        // AJAX를 통해 수정된 내용 서버로 전송
	        if(user.user_admin_chk == "Y"){
		        $.ajax({
		            url : `${myPath}/replyUpdate.do`,
		            type : 'get',
		            data : {
		                "request_no" : requestNo,
		                "reply_title" : modifiedTitle,
		                "reply_content" : modifiedContent
		            },
		            success : function(res){
		                alert("답변이 수정되었습니다.");
		                location.reload(); // 페이지 새로고침
		            },
		            error : function(xhr){
		                alert("답변 수정에 실패했습니다.: " + xhr.status);
		            },
		            dataType : 'json'
		        });
	
		        // 모달 닫기
		        $("#replyModal").modal('hide');
	        }
	    });
	});
	
	

	
});
</script>
</body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
<main>
<div class ="container mt-3">
	  <h2 class="con">1대1문의</h2>
  <p class="con">여러분들의 소중한 의견을 들려주세요.</p>     
	
 <table class="table table-bordered">
    <thead>
      <tr>
        <th class="table-light">제목</th>
        <th colspan="3"><%=vo.getRequest_title() %></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="table-light">문의 내용</td>
        <td><%=vo.getRequest_content() %></td>
      </tr>
      <tr>
        <td class="table-light">작성자</td>
        <td colspan="3"><%=vo.getNickName()%></td>
      </tr>
      <tr>
        <td class="table-light">문의 작성일</td>
        <td colspan="4"><%=vo.getRequest_date() %></td>
      </tr>
    </tbody>
	<div id="delbox">    
	    <input type = "button" value="삭제" id="del" class="del btn btn-danger"><br>
	</div>
  </table>	
	<br><br>
	<div id="listReply"></div>
	<div id = "data-check" class="input-group mb-3">
	  <input type="text" class="form-control" id="titleWrite" placeholder="제목을 입력해주세요.">
	  <input type="text" class="form-control" id="contentWrite" placeholder="댓글을 입력해 주세요.">
	  <button class="btn btn-light" type="button" id="contentWriteBtn">작성</button>
	</div>
	
</div>



</main>
<!-- 모달 창 -->
<div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">답변 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label for="modifiedTitle" class="form-label">제목</label>
          <input type="text" class="form-control" id="modifiedTitle">
        </div>
        <div class="mb-3">
          <label for="modifiedContent" class="form-label">내용</label>
          <textarea class="form-control" id="modifiedContent" rows="3"></textarea>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="updateReplyBtn">수정 완료</button>
      </div>
    </div>
  </div>
</div>

<footer>
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
</html>