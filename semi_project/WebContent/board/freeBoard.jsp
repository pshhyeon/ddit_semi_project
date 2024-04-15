<%@page import="com.google.gson.Gson"%>
<%@page import="ddit.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<style>
.mt-3{
	text-align: center;
}

</style>
</head>
<body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<script src="/semi_project/js/jquery.serializejson.min.js"></script>
<script src="/semi_project/js/weather.js" defer></script>
<script src="/semi_project/js/myPagePath.js"></script>
<link rel="stylesheet" href="/semi_project/css/partyMainStyles.css">
<script>
    $(function() {
    	currentPage = 1;
		mypath = "<%=request.getContextPath()%>";
		let user = <%=session.getAttribute("user")%>;
		console.log(user);
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
		
		
	 $("#link-myPage").click(function() {
			if (user == null) {
				location.href = `${mypath}/user/loginForm.jsp`;
			} else if (user.user_admin_chk == "Y") {
				location.href = `${mypath}/user/adminPage.jsp`;
			} else {
				location.href = `${mypath}/user/myPage.jsp`;
			}
		})
		
		//게시판 리스트 불러오기
		listPage = function(){
			let loginUserNo = <%=userNo%>;
			categoryValue = $('#category option:selected').val().trim();
			searchValue = $('#search').val().trim();
			
			console.log(categoryValue,searchValue);
			
			let data = {
				"page" : currentPage,
				"category" : categoryValue,
				"search" : searchValue
			};
			
			$.ajax({
				url : `${mypath}/boardList.do`,
				data : data,
				type : 'post',
				success : function(res){
					console.log(res.datas);
					code = `<table class='table table-hover'>
					<thead>
					      <tr>
					        <th>#</th>
					        <th>작성자</th>
					        <th>제목</th>
					        <th>조회수</th>`
					   
					        
					        
					        
					    code+=  `</tr>
					    <tbody>`
					     
					     $.each(res.datas, function(i,v){
					     code += `
					       <tr>
					        <td class='bno'>${v.board_no}</td>
					        <td class='nickname'>${v.nickname}</td>
					        <td class='title'>${v.board_title}</td>
					        <td class='bcount'>${v.board_count}</td>`
					        
					 code+= `</tr>`
					    	 
					     })
					code+=  `  </tbody>
					  </table>`
					$('#boardList').html(code);
					pagecontroll= pageNation(res.startPage, res.endPage, res.totalPage);
					$('#pageNation').html(pagecontroll);
				},
				error : function(xhr){
					alert(xhr.status);
				},
				dataType :'json'
			})
				
		}
		
		//조회수 증가
		countUpdate = function(){
			$.ajax({
				url : `${mypath}/boardCountUpdate.do`,
				type : 'get',
				data : {"boardNo" : bindex},
				success : function(res){
				},
				error : function(xhr){
					alert("오류 : "+xhr.status);
				},
				dataType : 'json'
			})
		}
		
		//시작하자마자 목록 불러오기(함수호출)
		listPage();
    	
		//상세보기 
		$(document).on('click','.title',function(){
			bindex = $(this).parent().find(".bno").text();
			countUpdate();
			location.href= `${mypath}/boardDetail.do?bindex=${bindex}`;
		})
		
		//페이지네이션 함수
		pageNation = function(sp, ep, tp){
			pager = `<ul class='pagination justify-content-center'>`;
			//이전 버튼 생성
			
			pager += `<li class="page-item"><a class="page-link prevp" href="javascript:void(0);">이전</a></li>`;
			
			//페이지번호 생성
			if(currentPage > tp) currentPage = tp;
			
			for(i=sp ; i<=ep; i++){
				
				if(i==currentPage){
					pager += `<li class="page-item active"><a class="page-link pnum" href="javascript:void(0);">${i}</a></li>`;
				}else{
					pager += `<li class="page-item"><a class="page-link pnum" href="javascript:void(0);">${i}</a></li>`;
				}
			};
			//다음버튼 생성
				pager += `<li class="page-item"><a class="page-link nextp" href="javascript:void(0);">다음</a></li>`;
				
			pager += `</ul>`;
			return pager;
		}
		//이전버튼
		$(document).on('click','.prevp',function(){
			if(currentPage>5){
				currentPage = parseInt($('.pnum').first().text())-1;
				
				listPage();
			}
		})
		//다음버튼
		$(document).on('click','.nextp',function(){
			currentPage = parseInt($('.pnum').last().text())+1;
			listPage();
		})
		//해당번호페이지클릭버튼
		$(document).on('click','.pnum',function(){
			currentPage = parseInt($(this).text());
			listPage();
		})
		//검색버튼
		$('#searchbtn').on('click',function(){
			currentPage = 1;
			listPage();
		})
		//글쓰기버튼
		$('#writebtn').on('click',function(){
			if(user == null){
				alert("로그인 후 가능한 서비스입니다.");
				return false;
			}else if(user.user_admin_chk == "Y"){
				alert("관리자는 자유게시판 게시물 작성이 불가능합니다.");
				return false;
			}
			
			location.href= `${mypath}/board/boardInsert.jsp`;
		})
	})
</script>

</body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
<main>
<div class="container mt-3">
  <h2>자유게시판</h2>
  <p>여러분들이 자유롭게 의견을 나누고 소통할 수 있는 공간입니다.</p>     
<div id="searching" class="d-flex flex-row">
	  <select id="category" class="form-select-sm" 
	  			style="width: 200px; text-align: center; border-color : #ed4c78; border-radius: 0.375rem;">
	    <option value="">검색유형선택</option>
	    <option value="board_title">제목</option>
	    <option value="board_content">내용</option>
	  </select>
	  <div style="width : 50px"></div>
	  <input type="text" id="search" class="form-control" style="border-color: #ed4c78"/>
	  <div style="width : 50px"></div>
	  <input type="button" id="searchbtn" class="btn btn-primary"  value="검색" style="border: none; background-color: #ed4c78"/>
</div>
<div id="boardList" class="mt-5">
</div>
<div id="pageNation">
</div>
<form style="text-align: right;">
        <button class="btn btn-primary" id="writebtn" type="button" style="border: none; background-color: #ed4c78">글쓰기</button>
</form>
<br>
</div>
</main>
<footer>
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
</html>