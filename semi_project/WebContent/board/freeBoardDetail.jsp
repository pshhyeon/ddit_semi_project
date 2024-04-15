<%@page import="ddit.vo.UserVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="ddit.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<%
	BoardVO vo = (BoardVO)request.getAttribute("vo");
	if(vo.getBoard_file_name()==null){
		vo.setBoard_file_name("");
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
#btncon{
	text-align : right;
}

</style>
</head>

<body>


<script>
$(function(){
	let myPath = "<%=request.getContextPath()%>";
	user = <%=session.getAttribute("user")%>;
	<%
    int userNo = 0;
    String userJsonStr = (String) session.getAttribute("user");
    // 세션에서 JSON 데이터를 문자열로 가져오기
    if(userJsonStr != null) {
       userJsonStr = (String) session.getAttribute("user");
       
       Gson gson = new Gson();
       UserVO user = gson.fromJson(userJsonStr, UserVO.class);
 
       // 필요한 속성에 접근하여 데이터를 가져옵니다.
       userNo = user.getUser_no();
       
       System.out.println("@@@@@user번호 정보@@@@@" + userNo);
    }
 %>
	console.log(user);
	//댓글리스트 함수
// 	location.reload();
		let boardNo = <%=vo.getBoard_no()%>;
		let loginUserNo = <%=userNo%>;
	listComment = function(){
		
		
		$.ajax({
			url : `${myPath}/commentList.do`,
			data : { "boardNo" : boardNo},
			type : 'get',
			success : function(res){
// 				alert("댓글불러오기성공");
				code= `<table class='table'>
					<thead>
				      <tr>
				        <th style="display : none">#</th>
				        <th>작성자</th>
				        <th>내용</th>
				        <th></th>
				        <th></th>
				      </tr>
				    </thead>
				    <tbody>`
				    
				    $.each(res.datas, function(i,v){
				    	code += `
				    	<tr>
					        <td class='cno' style="display : none">${v.comments_no}</td>
					        <td class='cnickname'>${v.nickname}</td>
					        <td class='ccon'>${v.comments_con}</td>`;
					        
					        if((user !=null && loginUserNo == v.user_no)||(user.user_admin_chk == "Y")){
					        	code += `<td style="text-align : right"><input idx="${v.comments_no}" type="button" value = "수정" id="comodi" name="comodi" class="btn btn-light btn-sm">
					        		     <input idx="${v.comments_no}" type="button" value = "삭제" id="codel"  name="codel" class="btn btn-light btn-sm"><td>`;
					        }else{
					        	code += `<td></td><td></td>`;
					        }
					code+=    `</tr>`;
				    	
				    })
				code+= `</tbody>
					</table>`   
					$('#commentList').html(code);
				
			},
			error : function(xhr){
				alert("실패"+xhr.status);
			},
			dataType : 'json'
			
		})
		
	};
	//댓글리스트 페이지 시작하자마자 출력
	listComment();
	//댓글 삭제버튼 클릭
	$(document).on('click','#codel',function(){
		cindex = $(this).closest('tr').find(".cno").html();
		console.log(cindex);
		
		let result = confirm("정말로 삭제하시겠습니까?"); 
		
		if(result){
			$.ajax({
				url : `${myPath}/commentDelete.do`,
				type : 'get',
				data : {"commentNo" :cindex},
				success : function(res){
					alert("삭제되었습니다.");
					location.reload();				
				},
				error : function(xhr){
					alert("실패 : "+xhr.status);
				},
				dataType : 'json'
			})
			
		}else{
			
		}
	})
	
	
	//댓글 수정버튼 클릭 --모달창 이용하기
	$(document).on('click','#comodi',function(){
		cindex = $(this).closest('tr').find(".cno").html();
		ccontent = $(this).closest('tr').find(".ccon").html();
		console.log(cindex,ccontent);
		
		$('#cModal').modal('show');
		$('#comodicon').val(ccontent);
		
	})
	//댓글 수정- 모달창 안에서 확인버튼 누르면
	$(document).on('click','#csend',function(){
		
		modicomentValue =$('#comodicon').val();
		console.log(cindex,modicomentValue);
		$.ajax({
			url : `${myPath}/commentUpdate.do`,
			type : 'get',
// 			dataType = 'json',
			data : {"commentCon":modicomentValue , "commentNo" : cindex},
			success : function(res){
				alert("수정이 완료되었습니다");
				$('#cModal').modal('hide');
				location.reload();
			},
			error : function(xhr){
				alert("실패 : "+xhr.status);
			},
			dataType : 'json'
		})
		
	})
	
	 $("#link-myPage").click(function() {
			if (user == null) {
				location.href = `${myPath}/user/loginForm.jsp`;
			} else if (user.user_admin_chk == "Y") {
				location.href = `${myPath}/user/adminPage.jsp`;
			} else {
				location.href = `${myPath}/user/myPage.jsp`;
			}
		})

	
	
	//게시물 수정버튼
	$(document).on('click','#modi',function(){
		if((<%=vo.getUser_no() %> ==<%=userNo%>)){
			vparents=$(this).parents('.container');
			vtitle = $(vparents).find('.qtitle').text().trim();
			vcontent = $(vparents).find('.qcontent').text().trim();
			vcontent = vcontent.replaceAll(/<br>/g,"\n");
			
			$('.modi1').show();
			$('.modi2').hide();
			
			$('#titlecode').val(vtitle);
			$('#contentcode').val(vcontent);
			
			
			console.log(vtitle, vcontent);
			
			$('#modi').hide();
			$('#del').hide();
			$('#modisend').show();
			
		}else if(user ==null){
			alert("로그인이 필요한 서비스입니다.")
			return;
		}else if((user.user_admin_chk == "Y")){
			alert("글 작성자만 수정이 가능합니다.")
			return;
		}else{
			  alert("글 작성자만 수정이 가능합니다.");
			  return;
		}
		
		
	});
	//게시물 수정 확인버튼
	$(document).on('click','#modisend',function(){
		modititle = $('#titlecode').val();
		modicontent = $('#contentcode').val();
		modiboardNo = <%=vo.getBoard_no()%>;
		
		$.ajax({
			url : `${myPath}/boardUpdate.do`,
			type : 'get',
			data : {"title" : modititle , "content" : modicontent, "boardNo" : modiboardNo},
			success : function(res){
				alert("수정이 완료되었습니다.");
				location.href = `${myPath}/board/freeBoard.jsp`;
			},
			error : function(xhr){
				alert("실패 : "+xhr.status);
			},
			dataType : 'json'
		})
		
	})
	
	//게시물 삭제버튼
	$(document).on('click','#del',function(){
		if((user !=null && <%=vo.getUser_no()%>==<%=userNo%>)){
			let result = confirm("정말로 삭제하시겠습니까?"); 
			
			modiboardNo = <%=vo.getBoard_no()%>;
			if(result){
				$.ajax({
					url : `${myPath}/boardDelete.do`,
					type : 'get',
					data : {"boardNo" : modiboardNo},
					success : function(res){
						alert("삭제가 완료되었습니다.");
						location.href = `${myPath}/board/freeBoard.jsp`;
					},
					error : function(xhr){
						alert("실패 : "+xhr.status);
					},
					dataType : 'json'
				})
				
			}else{
				
			}
			
		}else if(user.user_admin_chk == "Y"){
		let result = confirm("관리자의 권한으로 정말 삭제하시겠습니까?"); 
			
			modiboardNo = <%=vo.getBoard_no()%>;
			if(result){
				$.ajax({
					url : `${myPath}/boardDelete.do`,
					type : 'get',
					data : {"boardNo" : modiboardNo},
					success : function(res){
						alert("삭제가 완료되었습니다.");
						location.href = `${myPath}/board/freeBoard.jsp`;
					},
					error : function(xhr){
						alert("실패 : "+xhr.status);
					},
					dataType : 'json'
				})
				
			}else{
				
			}
			
		}else{
			  alert("글 작성자만 삭제가 가능합니다.");
			  return;
			
		} 
			
		
	});
	
	//목록버튼
	$(document).on('click','#goBackList',function(){
		history.go(-1);
	})
	
	//댓글 작성하기
	$('#commentWriteBtn').on('click',function(){
		commentValue = $('#commentWrite').val().trim();
		console.log(commentValue);
		
		
		
		//보드넘버, 유저넘버
		$.ajax({
			url : `${myPath}/commentInsert.do`,
			type : 'get',
			data : {"content" : commentValue,
				"boardNo" : <%=vo.getBoard_no()%>,
				"userNo" : <%=userNo%> },
			success : function(res){
				location.reload();				
			},
			error : function(xhr){
				alert("실패 : "+xhr.status);
			},
			dataType : 'json'
			
		})
		
	})
	

	
	
	
	
});
</script>
</body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
<main>
<div class ="container mt-3">
	  <h2 class="con">자유게시판</h2>
  <p class="con">여러분들이 자유롭게 의견을 나누고 소통할 수 있는 공간입니다.</p>
  <input type="button" id="goBackList" class="btn btn-light" value="목록">  <br>  <br>  
 <table class="table table-bordered" class="tablecont">
    <thead>
      <tr>
        <th class="table-light">제목</th>
        
        <th colspan="3" class="qtitle">
        <input type='text' id='titlecode'  class='modi1' style='display: none; size : 100px;'>
        <span class='modi2'><%=vo.getBoard_title() %></span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="table-light">작성자</td>
        <td>
        <%=vo.getNickname() %></td>
        <td class="table-light">작성일</td>
        <td><%=vo.getBoard_date() %></td>
      </tr>
      <tr>
        <td class="table-light">조회수</td>
        <td><%=vo.getBoard_count() %></td>
        <td class="table-light">첨부파일</td>
        <td id="bofile" style="text-decoration: underline;"><a href="<%=request.getContextPath()%>/boardFileDownload.do?filename=<%=vo.getBoard_file_name() %>"><%=vo.getBoard_file_name() %></a></td>
      </tr>
      <tr>
        <td colspan="4" class="qcontent">
        <textarea rows='10' cols='100' id="contentcode" class='modi1' style='display : none;'></textarea>
        <span class='modi2'><%=vo.getBoard_content()%></span></td>
      </tr>
    </tbody>
  </table>	
  <div id="btncon">
  	<input type="button" class="btn btn-light" id="modisend" value="확인" style="display : none;">
  	<input type="button" class="btn btn-light" id="delsend" value="확인" style="display : none;">
  	<input type="button" class="btn btn-light" id="modi" value="수정">
  	<input type="button" class="btn btn-light" id="del" value="삭제">
  </div>
  
	<br><br>
  
	<div>
		<h5 style="text-align: left">댓글 목록</h5>
	</div>
	<div class="input-group mb-3">
	  <input type="text" class="form-control" id="commentWrite" placeholder="댓글을 입력해 주세요.">
	  <button class="btn btn-light" type="button" id="commentWriteBtn">작성</button>
	</div>
	<div id="commentList"></div>
</div>




<br><br>
<!-- 글쓰기 The Modal -->
<div class="modal" id="cModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">댓글 수정</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
       		<label></label>
       		<br>
       		<textarea rows="5" cols="58" class="txt" id="comodicon" name="comodicon"></textarea>
       		<br><br>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
       	<input type="button" id="csend" class="btn btn-light"  value ="확인">
        <button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>

</main>
<footer>
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
</html>