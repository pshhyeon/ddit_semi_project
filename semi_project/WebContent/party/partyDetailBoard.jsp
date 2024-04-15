<%@page import="ddit.vo.PartyGongjiVO"%>
<%@page import="java.util.List"%>
<%@page import="ddit.vo.ReplyVO"%>
<%@page import="ddit.vo.UserVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="ddit.vo.RequestVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page isELIgnored="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%
PartyGongjiVO vo = (PartyGongjiVO)request.getAttribute("vo"); 
   //List<ReplyVO> rlist = (List<ReplyVO>)request.getAttribute("list"); 
int selectedPartyNo = Integer.parseInt(request.getParameter("selectedPartyNo"));
int userNo = 0;
int boardUserNo = 0;
int requestNo = 0;
String userJsonStr = (String) session.getAttribute("user");
// 세션에서 JSON 데이터를 문자열로 가져오기
if (userJsonStr != null) {
   userJsonStr = (String) session.getAttribute("user");

   Gson gson = new Gson();
   UserVO user = gson.fromJson(userJsonStr, UserVO.class);

   // 필요한 속성에 접근하여 데이터를 가져옵니다.
   //얘는 현재 로그인되어있는놈
   userNo = user.getUser_no();

   //얘는 요구사항 쓴놈
   //    boardUserNo = vo.getUser_no();

   //    requestNo = vo.getRequest_no();
   System.out.println("@@@@@user번호 정보+++++++ : " + userNo);

}
%>
<script src="/semi_project/js/jquery-3.7.1.min.js"></script>

<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
   rel="stylesheet">
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="/semi_project/js/jquery.serializejson.min.js"></script>
<link rel="stylesheet" href="../css/partyMainStyles.css">
<style>
.con {
   text-align: center;
}

#delbox {
   text-align: right;
}
#asdasd {
	text-align: right;
}
.table {
    width: 100%;
    border-collapse: collapse;
    border-spacing: 0;
}

.table th,
.table td {
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #dee2e6;
}

.table th {
    background-color: #f8f9fa;
    vertical-align: middle;
}

/* 버튼 스타일 */
.btn-light {
    background-color: #f8f9fa;
    border-color: #f8f9fa;
    color: #212529;
}

.btn-light:hover {
    background-color: #e2e6ea;
    border-color: #dae0e5;
    color: #212529;
}

.btn-light:focus, .btn-light.focus {
    box-shadow: 0 0 0 0.2rem rgba(248, 249, 250, 0.5);
}

.btn-sm {
    padding: 0.25rem 0.5rem;
    font-size: 0.875rem;
    line-height: 1.5;
    border-radius: 0.2rem;
}

.btn-group {
    margin-right: 5px;
}
</style>
</head>
<body>
   <script>
$(function(){
   let myPath = "<%=request.getContextPath()%>";
   let user = <%=session.getAttribute("user")%>;
   console.log(user);
    
   // 로그인 돼있으면 마이페이지로 아니면 로그인폼으로
   // 마이페이지 버튼 이벤트
	$("#link-myPage").click(function(){
		if(user == null) {
			location.href = `${myPath}/user/loginForm.jsp`;
		} else if(user.user_admin_chk == "Y") {
			location.href = `${myPath}/user/adminPage.jsp`;
		} else {
			location.href = `${myPath}/user/myPage.jsp`;
		}
	})
   var currentPage = 1;
   //게시글 리시트
   function listGongji() {
       categoryValue = $('#category option:selected').val().trim();
       searchValue = $('#search').val().trim();
       
//        if(currentPage != 1){
<%--     	   currentPage = <%=request.getAttribute("currentPage")%>; --%>
//        }
       
       let data = {
               "page" : currentPage,
               "category" : categoryValue,
               "search" : searchValue,
               "party_no": <%=selectedPartyNo%>
           };
       console.log("tryytr",data);
       
       $.ajax({
           url: `${myPath}/partyGongjiList.do`,
           data: data,
           type: 'get',
           success: function(res) {
               let code = `<div class="container">`; // 부트스트랩 컨테이너 추가
               $.each(res.datas, function(index, gongji) {
                   code += `<div class="row mb-3">
                               <div class="col-md-10">
                                   <div class="card">
                                         <p class="card-text gongjinos" style="display: none;">${gongji.party_gongji_no}</p>
                                       <div class="card-body">
                                           <h5 class="card-title clickable" style="font-size: 24px; text-decoration: underline;">${gongji.party_gongji_title}</h5>
                                           <p class="card-text content" style="display: none;">${gongji.party_gongji_content}</p>
                                           <p class="card-text"><small class="text-muted">${gongji.party_gongji_date}</small></p>
                                       </div>
                                       <div class="card-footer text-right"  style="display:none"> <!-- 수정 및 삭제 버튼 추가 -->
                                           <button idx="${gongji.selectedPartyNo}" type="button" class="btn btn-light btn-sm rmodi" >수정</button>
                                           <button idx="${gongji.selectedPartyNo}" type="button" class="btn btn-light btn-sm rdel" >삭제</button>
                                       </div>
                                   </div>
                               </div>
                           </div>`;
               });
               code += `</div>`; // 부트스트랩 컨테이너 닫기
               $('#listGongji').html(code);
               pagecontroll= pageNation(res.startPage, res.endPage, res.totalPage);
               $('#pageNation').html(pagecontroll);
               
               // 클릭 이벤트 처리
               $('.clickable').click(function() {
                   $(this).siblings('.content').slideToggle();
                   $(this).closest('.card').find('.card-footer').slideToggle(); // 해당 카드의 footer 토글
               });
           },
           error: function(xhr) {
               alert("실패" + xhr.status);
           },
           dataType: 'json'
       });
   }
   
    findPartyAdminNo = function(callback){
      let selectedPartyNo = <%=selectedPartyNo%>;
      console.log("파티넘버",selectedPartyNo);
      
      $.ajax({
         url : `${myPath}/findPartyAdmin.do`,
         data : { "partyNo" : selectedPartyNo},
         type : 'get',
         success : function(res){
            
            partyAdminNo = res.flag;
            console.log(partyAdminNo);
            callback(partyAdminNo);
         },
         error : function(xhr){
            alert("실패")
         },
         dataType : 'json'
      })
   }
   
   function myCallback(result){
      console.log("관리자 번호 : ",result);
   } 
   //게시글 삭제
   $(document).on('click','.rdel',function(){
	    var party_gongji_no = $(this).parents(".card").find('.gongjinos').html();

	    // findPartyAdminNo 함수를 호출하여 관리자 번호를  가져온다
	    findPartyAdminNo(function(adminNo) {
	        console.log(party_gongji_no);
	        console.log("관리자 번호:", adminNo);
	        console.log("사용자 번호:", <%= userNo %>);

	        if(<%= userNo %> == adminNo){
	            // 삭제 권한이 있는 경우, 삭제를 수행
	            $.ajax({
	                url : `${myPath}/gongjiDelete.do`,
	                type : 'get',
	                data : {"party_gongji_no" : party_gongji_no},
	                success : function(res){
	                    location.reload();      
	                    alert("삭제가 완료되었습니다.");
	                },
	                error : function(xhr){
	                    alert("실패: "+xhr.status);
	                },
	                dataType : 'json'
	            });
	        } else {
	            // 삭제 권한이 없는 경우, 경고 메시지를 표시합니다.
	            alert("삭제할 권한이 없습니다.");
	        }
	    });
	}); 
   $(document).on('click', '.rmodi', function() {
	    var card = $(this).closest(".card");
	    var title = card.find('.card-title').text().trim();
	    var content = card.find('.content').text().trim();
	    var party_gongji_no = card.find('.gongjinos').html();

	    // 관리자 권한 체크
	    findPartyAdminNo(function(adminNo) {
	        console.log("관리자 번호:", adminNo);
	        console.log("사용자 번호:", <%= userNo %>);

	        if (<%= userNo %> == adminNo) {
	            // 모달에 제목과 내용을 세팅
	            $('#gongjiTitle').val(title);
	            $('#gongjiContent').val(content);

	            // 모달 표시
	            $('#gongjiModal').modal('show');

	            // 수정 완료 버튼 클릭 이벤트
	            $('#gongjiSubmit').off('click').on('click', function() {
	                var party_gongji_title = $('#gongjiTitle').val();
	                var party_gongji_content = $('#gongjiContent').val();

	                // 수정 권한이 있는 경우, 수정을 수행
	                $.ajax({
	                    url: `${myPath}/gongjiUpdate.do`,
	                    type: 'post',
	                    data: {
	                        "party_gongji_no": party_gongji_no,
	                        "party_gongji_title": party_gongji_title,
	                        "party_gongji_content": party_gongji_content
	                    },
	                    success: function(res) {
	                        location.reload();
	                        alert("수정이 완료되었습니다.");
	                    },
	                    error: function(xhr) {
	                        alert("수정에 실패하였습니다: " + xhr.status);
	                    },
	                    dataType: 'json'
	                });
	            });
	        } else {
	            // 수정 권한이 없는 경우, 아무 동작도 수행하지 않음
	            alert("수정할 권한이 없습니다.");
	            console.log("수정할 권한이 없습니다.");
	            return false; // 클릭 이벤트 핸들러 종료
	        }
	    });
	});


   listGongji();
   
   
   $(function(){
	    // 게시글 작성하기 버튼 클릭 이벤트
	    $('#writeGongjiBtn').click(function() {
	        // 관리자 번호 가져오기
	        findPartyAdminNo(function(adminNo) {
	            // 사용자 번호와 관리자 번호 비교
	            if (<%= userNo %> != adminNo) {
	                // 관리자가 아닌 경우 모달 열기 중단
	                alert("권한이 없습니다");
	                return;
	            }

	            // 모달에 제목과 내용을 초기화
	            $('#writeGongjiTitle').val('');
	            $('#writeGongjiContent').val('');

	            // 모달 표시
	            $('#writeGongjiModal').modal('show');
	        });
	    });

	    // 작성 완료 버튼 클릭 이벤트
	    $('#writeGongjiSubmit').click(function() {
	        var party_gongji_title = $('#writeGongjiTitle').val().trim();
	        var party_gongji_content = $('#writeGongjiContent').val().trim();

	        // 제목과 내용이 비어있는지 확인
	        if (party_gongji_title === '' || party_gongji_content === '') {
	            alert('제목과 내용을 입력해주세요.');
	            return;
	        }

	        // 게시글 데이터를 서버로 전송
	        let party_no = <%=selectedPartyNo%>;
	        $.ajax({
	            url:  `${myPath}/gongjiInsert.do`,
	            type: 'POST',
	            data: {
	                "party_no" : party_no,
	                "party_gongji_title": party_gongji_title,
	                "party_gongji_content": party_gongji_content
	            },
	            success: function(response) {
	                alert('게시글이 작성되었습니다.');
	                $('#writeGongjiModal').modal('hide');
	                listGongji();
	            },
	            error: function(xhr) {
	                alert('게시글 작성에 실패했습니다.');
	                console.error(xhr);
	            }
	        }); 
	    });
	});

   pageNation = function(sp, ep, tp){
      pager = `<ul class='pagination justify-content-center'>`;
      
      //이전 버튼 생성
      if(sp>1){
         pager += `<li class="page-item"><a class="page-link prev" href="#">이전</a></li>`;
         
      };
      
      //페이지번호 생성
      if(currentPage > tp) currentPage = tp;
      
      
      for(i=sp ; i<=ep; i++){
         
         if(i==currentPage){
            pager += `<li class="page-item active"><a class="page-link pnum" href="#">${i}</a></li>`;
         }else{
            pager += `<li class="page-item"><a class="page-link pnum" href="#">${i}</a></li>`;
         }
         
         
      };
      
      //다음버튼 생성
      if(tp > ep){
         pager += `<li class="page-item"><a class="page-link next" href="#">다음</a></li>`;
      };
      
      pager += `</ul>`;
      
      return pager;
      
      
   }
   //이전버튼
   $(document).on('click','.prevp',function(){
      currentPage = parseInt($('.pnum').first().text())-1;
      listGongji();
   })
   //다음버튼
   $(document).on('click','.nextp',function(){
      currentPage = parseInt($('.pnum').last().text())+1;
      listGongji();
   })
   //다음버튼
   $(document).on('click','.pnum',function(){
      currentPage = parseInt($(this).text());
      listGongji();
   })
   //검색버튼
   $('#searchbtn').on('click',function(){
      currentPage = 1;
      listGongji();
   })
});
</script>
</body>
<main>
	<div id="asdasd">
    <button id="writeGongjiBtn" class="btn btn-primary" style="border: none; background-color: #ed4c78; margin-bottom: 10px;">게시글 작성하기</button>
	</div>
    <div id="searchbox" class="d-flex flex-row">
        <select id="category" class="form-select-sm" style="width: 200px; text-align: center; border-color : #ed4c78; border-radius: 0.375rem;">
            <option value="">검색유형선택</option>
            <option value="party_gongji_title">제목</option>
            <option value="party_gongji_content">내용</option>
        </select>
        <div style="width: 50px"></div>
        <input type="text" id="search" class="form-control" style="border-color: #ed4c78; margin-right: 10px;"/>
        <input type="button" id="searchbtn" class="btn btn-primary" value="검색" style="border: none; background-color: #ed4c78"/>
    </div>
    <br>
    <div class="con"></div>
    <div id="listGongji"></div>
    <div id="pageNation"></div>

<!--  글쓰기 모달창    -->
<div id="writeGongjiModal" class="modal fade" tabindex="-1" aria-labelledby="writeGongjiModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="writeGongjiModalLabel">게시글 작성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- 게시글 작성 폼 -->
        <form id="writeGongjiForm">
          <div class="mb-3">
            <label for="writeGongjiTitle" class="form-label">제목</label>
            <input type="text" class="form-control" id="writeGongjiTitle" name="writeGongjiTitle">
          </div>
          <div class="mb-3">
            <label for="writeGongjiContent" class="form-label">내용</label>
            <textarea class="form-control" id="writeGongjiContent" name="writeGongjiContent" rows="8"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button id="writeGongjiSubmit" type="button" class="btn btn-primary">작성 완료</button>
      </div>
    </div>
  </div>
</div>


</main>

<!-- 수정 모달 창 -->
<div id="gongjiModal" class="modal fade" tabindex="-1" aria-labelledby="gongjiModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="gongjiModalLabel">게시글 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- 수정할 내용 입력 폼 -->
        <form id="gongjiForm">
          <div class="mb-3">
            <label for="gongjiTitle" class="form-label">제목</label>
            <input type="text" class="form-control" id="gongjiTitle" name="gongjiTitle">
          </div>
          <div class="mb-3">
            <label for="gongjiContent" class="form-label">내용</label>
            <textarea class="form-control" id="gongjiContent" name="gongjiContent" rows="8"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button id="gongjiSubmit" type="button" class="btn btn-primary">수정 완료</button>
      </div>
    </div>
  </div>
</div>
</html>