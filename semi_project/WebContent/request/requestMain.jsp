<%@page import="ddit.vo.UserVO"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true"  %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.mt-3{
       text-align: center;
}

#ooooo{
    	text-align: right;
}
/* Modal Header */
.modal-header {
  color: white;
  padding: 10px;
  text-align: center;
}

/* Modal Body */
.modal-body {
  padding: 20px;
}

/* Modal Footer */
.modal-footer {
  padding: 10px;
}

/* /* Form styling */
/* .form-control {
  margin-bottom: 10px;
}  */
 */
/* Checkbox styling */
.form-check-label {
  margin-left: 5px;
}

/* Button styling */
/* .btn {
  margin-right: 5px;
} */

/* Move title above input */
.modal-body label:first-child {
  display: block;
  margin-bottom: 5px;
}
.modal-dialog {
  max-width: 800px; /* Increase the maximum width of the modal */
}

/* Textarea Size */
#content {
  height: 200px; /* Increase the height of the textarea */
}

</style>
<body>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <script src="../js/jquery-3.7.1.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>
<script src="../js/weather.js" defer></script>
<link rel="stylesheet" href="../css/partyMainStyles.css">
<link rel="stylesheet" href="../css/styles.css">
<script>
<%
int user_no = 0;
String userJsonStr = (String) session.getAttribute("user");
// 세션에서 JSON 데이터를 문자열로 가져오기
if(userJsonStr != null) {
   userJsonStr = (String) session.getAttribute("user");
   
   Gson gson = new Gson();
   UserVO user = gson.fromJson(userJsonStr, UserVO.class);

   // 필요한 속성에 접근하여 데이터를 가져옵니다.
   user_no = user.getUser_no();
   System.out.println("@@@@@user번호 정보@@@@@" + user_no);
}
%>

mypath = "<%=request.getContextPath()%>";
user = <%=session.getAttribute("user")%>;

let userNo = <%=user_no %>;

//로그인 돼있으면 마이페이지로 아니면 로그인폼으로


    $(function() {
    	
    	$(document).on('click',"#link-myPage",function(){
    		if(user == null) {
    			location.href = `${myPath}/user/loginForm.jsp`;
    		} else if(user.user_admin_chk == "Y") {
    			location.href = `${myPath}/user/adminPage.jsp`;
    		} else {
    			location.href = `${myPath}/user/myPage.jsp`;
    		}
    		});
    	
    	let requestList = {};
    	
    	currentPage = 1;
		let user = <%=session.getAttribute("user") %>;
		console.log(user);
		//리스트불러오기
		listPage = function(){
			categoryValue = $('#category option:selected').val().trim();
			searchValue = $('#search').val().trim();
			
			console.log(categoryValue,searchValue);
			
			let data = {
				"page" : currentPage,
				"category" : categoryValue,
				"search" : searchValue
			};
			
			$.ajax({
				url : `${mypath}/requestList.do`,
				data : data,
				type : 'post',
				success : function(res){
					requestList = res.datas;
				//	console.log("zz",requestList);
					code = `<table class='table table-hover'>
					    <thead>
					      <tr>
					        <th>#</th>
					        <th>작성자</th>
					        <th>제목</th>
					        <th>등록일자</th>
					      </tr>
					    </thead>
					    <tbody>`
					    
					     
					     $.each(res.datas, function(i,v){
					    	 //console.log(v);
					    	 if(v.request_secret == "N") {
					    		 code += `
								       <tr>
								        <td class="rno">${v.request_no}</td>
								        <td class="ruserno" style="display : none">${v.user_no}</td>
								        <td class="nickname">${v.nickName}</td>
								        <td class="title">${v.request_title}</td>
								        <td class="rdate">${v.request_date}</td>
								      </tr>`		 
					    	 } else {
					    		 code += `
					    		 <tr>
								    <td class="rno">${v.request_no}</td>
								    <td class="userno" style="display : none">${v.user_no}</td>
								    <td class="nickname">${v.nickName}</td>
					    		 	<td class="secretChk">비밀글 입니다.</td>
								    <td class="rdate">${v.request_date}</td>
					    		 </tr>
					    		 `
					    	 }
					     
					    	 
					     })
					code+=  `  </tbody>
					  </table>`
					$('#requestList').html(code);
					pagecontroll= pageNation(res.startPage, res.endPage, res.totalPage);
					$('#pageNation').html(pagecontroll);
				},
				error : function(xhr){
					alert(xhr.status);
				},
				dataType :'json'
			})
				
		}
		listPage();
		
		$(document).on('click', '.title',function(){
				rindex = $(this).parent().find(".rno").text();
				location.href= `${mypath}/requestDetail.do?rindex=${rindex}`;
		})
 		$(document).on('click', '.secretChk',function(){

			//내가 누른 이 게시물의 작성자
				rindex = $(this).parent().find(".rno").text();
				ruserno = $(this).parent().find(".userno").text();
 				console.log(rindex, ruserno);
 				console.log(user);
 				if(ruserno != user.user_no && user.user_admin_chk != 'Y'){
 					alert("게시글 권한이 없습니다.")
 					return false;
 				}
 				location.href= `${mypath}/requestDetail.do?rindex=${rindex}`;
 				

			
		}) 
		
		
		pageNation = function(sp, ep, tp){
			pager = `<ul class='pagination justify-content-center'>`;
			
			//이전 버튼 생성
			if(sp>1){
				pager += `<li class="page-item"><a class="page-link prev" href="javascript:void(0);">이전</a></li>`;
				
			};
			
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
			if(tp > ep){
				pager += `<li class="page-item"><a class="page-link next" href="javascript:void(0);">다음</a></li>`;
			};
			
			pager += `</ul>`;
			
			return pager;
			
			
		}
		//이전버튼
		$(document).on('click','.prevp',function(){
			currentPage = parseInt($('.pnum').first().text())-1;
			listPage();
		})
		//다음버튼
		$(document).on('click','.nextp',function(){
			currentPage = parseInt($('.pnum').last().text())+1;
			listPage();
		})
		//다음버튼
		$(document).on('click','.pnum',function(){
			currentPage = parseInt($(this).text());
			listPage();
		})
		//검색버튼
		$('#searchbtn').on('click',function(){
			currentPage = 1;
			listPage();
		})
		//그냥 요청사항 인서트
		requestInsert = function(){
			$.ajax({
				url : `${mypath}/requestInsert.do`,
				type : 'post',
				data : {"title" : titleVal ,
						"content" : contentVal,
					    "user_no" : <%= user_no%> },  
				success : function(res){
					console.log("결과 =" + res.flag);
					listPage();
					
						
				},
				error : function(xhr){
					alert("상태 : "+xhr.status);
				},
				dataType : 'json'
				
			})
		}
		//비밀글 요청사항 인서트
		secretInsert = function(){
			$.ajax({
				url : `${mypath}/secretInsert.do`,
				type : 'post',
				data : {"title" : titleVal ,
						"content" : contentVal,
					    "user_no" : <%= user_no%> },  
				success : function(res){
					console.log("결과 =" + res.flag);
					listPage();
					
						
				},
				error : function(xhr){
					alert("상태 : "+xhr.status);
				},
				dataType : 'json'
				
			})
		}
		//글쓰기 확인 (전송)버튼
 		$('#wsend').on('click',function(){
			let secretChk = $('#wsecret').prop('checked');
			
			
 			//전체 입력내용 가죠오기
			
			titleVal = $('#title').val().trim();
			contentVal = $('#content').val().trim();
			//서버로 전송 = ajax()
			if(secretChk){
				secretInsert();
				
			}else{
				requestInsert();
				
			}
			//모당에 입력한 내용 지우기
			$('#wform .txt').val("");
			
			//모달창 닫기
			$('#wModal').modal('hide');
		}) 

		//글쓰기 버튼 클릭 이벤트 20240411수정
		if(user !=null && user.user_admin_chk != "Y"){
			$('#write').on('click',function(){
				//모달창 열기
				$('#wModal').modal('show');
				
			})
			
		}else{
			$('#write').on('click',function(){
				//모달창 열기
				alert("권한이없습니다");
				$('#wModal').modal('hide');
				
			})
			return;
		}
		
})
</script>

</body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
<main>


<div class="container mt-3">
  <h2>1:1고객센터</h2>
  <p>여러분의 소중한 의견을 말씀해주세요</p>    
  
	<div id="ooooo">
 	  <input type="button" value="1대1문의하기" id="write" class="btn btn-primary"  style="border: none; background-color: #ed4c78">
	</div>
 <br>
       

<div id="searchbox" class="d-flex align-items-center">
  <select id="category" class="form-select-sm mr-2" style="width: 200px; text-align: center; border-color : #ed4c78; border-radius: 0.375rem; height: 38px;">
    <option value="">검색유형선택</option>
    <option value="request_title">제목</option>
    <option value="request_content">내용</option>
    <!-- request_content == vo에 있는거랑 맞아야 검색이 가능하다 -->
  </select>
  <div style="width : 50px"></div>
  <input type="text" id="search" class="form-control mr-2" style="border-color: #ed4c78; height: 38px;"/>
  <div style="width : 50px"></div>
  <input type="button" id="searchbtn" class="btn btn-primary" value="검색" style="border: none; background-color: #ed4c78; height: 38px;"/>
</div>




<div id="requestList" class="mt-5">
</div>
<div id="pageNation">
</div>
</div>

<!-- The Modal 글쓰기-->
<div class="modal" id="wModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">1대1문의하기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
       <div class="modal-body">
      	<form name ="wmodal" id ="wform" >
      		<label>제 목</label>
      		<input type = "text" class ="txt" id="title" name="title"><br>
      		<!-- <label>이 름</label>
      		<input type = "text" class ="txt" id="writer" name="writer"><br> -->
      		<label>문의 내용</label><br>
      		<textarea row="10" cols="40" class ="txt" id="content" name="content"></textarea>
      		<br>
      		<input type = "button" value="확인" id="wsend"><br>
      		<input type = "checkbox" id="wsecret">비밀글 등록하기<br>
      	</form>
      </div> 

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>








</main>
<footer>
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
</html>