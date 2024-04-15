<%@page import="java.util.List"%>
<%@page import="ddit.vo.NotificeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<script src="../js/jquery.serializejson.min.js"></script>
<script src="../js/weather.js" defer></script>
<link rel="stylesheet" href="../css/partyMainStyles.css">
<style>
    .mt-3{
       text-align: center;
    }
    
    .notiTitle {
  cursor: pointer; /* 마우스 커서를 손모양으로 변경 */
  transition: font-size 0.3s ease; /* 글씨 크기 변화 애니메이션 */
}
</style>
</head>

<body>

<script>
    $(function() {
    	
    	currentPage = 1;
		let myPath = "<%=request.getContextPath()%>"
		let user = <%=session.getAttribute("user")%>;
		console.log(user);
		
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
			url : `${myPath}/notiList.do`,
			data : data,
			type : 'get',
			success : function(res){
				
				console.log("zz",res.datas);
				code = `<table class="table table-hover">
				    <thead>
				      <tr>
				        <th>#</th>
				        <th>TITLE</th>
				        
				        <th>DATE</th>
				        <th>HIT</th>
				      </tr>
				    </thead>
				    <tbody>
				    `
				    
				    $.each(res.datas, function(i,v){
				    	code += `
				    		<tr>
				            <td class="notiNo">${v.notifice_no}</td>
				            <td class="notiTitle">${v.notifice_title}</td>
				         
				            <td class="notiTDate">${v.notifice_date}</td>
				            <td class="notiCount">${v.notifice_count}</td>
				          </tr>`
				    })
				    
				    if(user == null || user.user_admin_chk == null){
				        // user 객체가 null이거나 user_admin_chk 속성이 null인 경우
				        code += `</tbody>
				                 </table>`;
				    } else if(user.user_admin_chk == "Y"){
				        // user_admin_chk 속성이 "Y"인 경우
				        code += `</tbody>
				                  </table>
				                  <div style="text-align: right;">
				                      <input type='button' class="btn btn-primary goNotiWrite"  style="background-color: #ed4c78; border : none;" value='글쓰기'>
				                  </div>`;
				    } else if(user.user_admin_chk == "N"){
				        // user_admin_chk 속성이 "N"인 경우
				        code += `</tbody>
				                 </table>`;
				    }
				    $('#notiList').html(code);
				pagecontroll= pageNation(res.startPage, res.endPage, res.totalPage);
				$('#pageNation').html(pagecontroll);
			},
			error : function(xhr){
				alert(xhr.status);
			},
			dataType : 'json'
			
		})
		
		}
		listPage();
		
		
		$(document).on('click', '.goNotiWrite', function(){
 			
			location.href = `${myPath}/board/notiWrite.jsp`;
			
		})
		
		// 로그인 돼있으면 마이페이지로 아니면 로그인폼으로
		$("#link-myPage").click(function(){
	if(user == null) {
		location.href = `${myPath}/user/loginForm.jsp`;
	} else if(user.user_admin_chk == "Y") {
		location.href = `${myPath}/user/adminPage.jsp`;
	} else {
		location.href = `${myPath}/user/myPage.jsp`;
	}
})
		
		// 상세 보기
		$(document).on('click','.notiTitle',function(){
			bindex = $(this).parent().find(".notiNo").text();
			location.href= `${myPath}/notiDetail.do?bindex=${bindex}`;

		})
		
		//페이지네이션 함수
		pageNation = function(sp, ep, tp){
			pager = `<ul class='pagination justify-content-center'>`;
			//이전 버튼 생성
			if(sp>1){
				pager += `<li class="page-item"><a class="page-link prevp" href="javascript:void(0);">이전</a></li>`;
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
				pager += `<li class="page-item"><a class="page-link nextp" href="javascript:void(0);">다음</a></li>`;
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
	})
</script>
</body>
<header>
	<jsp:include page="../jsp/nav.jsp"/>
</header>
<main>
<!-- 여기 작성 -->
<div class="container mt-3">
  <h2>공지사항</h2>
  <br><br>
  
  <div id="searching" class="d-flex flex-row">
	  <select id="category" class="form-select-sm" 
	  			style="width: 200px; text-align: center; border-color : #ed4c78; border-radius: 0.375rem;">
	    <option value="">검색유형선택</option>
	    <option value="notifice_title">제목</option>
	    <option value="notifice_content">내용</option>
	  </select>
	  <div style="width : 50px"></div>
	  <input type="text" id="search" class="form-control" style="border-color: #ed4c78"/>
	  <div style="width : 50px"></div>
	  <input type="button" id="searchbtn" class="btn btn-primary"  value="검색" style="border: none; background-color: #ed4c78"/>
	</div>
  
  <div id="notiList" class="mt-5">
  </div>

<div id="pageNation">
</div>
</div>
</main>
<footer>
	<jsp:include page="../jsp/footer.jsp"/>
</footer>
</html>