<%@page import="ddit.vo.PhotoVO"%>
<%@page import="ddit.vo.UserVO"%>
<%@page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
img {
	width : 1000px;
	height : 500px;
}
.cardcon {
	display : flex;
	flex-wrap : wrap;
}
.card{
	width: calc(33.33% - 20px);
}
#insertPhotoNav{
	text-align : right;
}
#insertPhoto{
	margin-right: 30px;
}

</style>
</head>
<body>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <script src="/semi_project/js/jquery-3.7.1.min.js"></script>
<script src="/semi_project/js/jquery.serializejson.min.js"></script>


<script>
    $(function() {
    	myPath = "<%=request.getContextPath()%>";
    	let user = <%=session.getAttribute("user")%>;
    	partyNo = "<%=request.getParameter("selectedPartyNo")%>";
    	console.log(partyNo);
    	
    <%
    int userNo = 0;
	boolean adminChk = false;
	String userJsonStr = (String) session.getAttribute("user");
	// 세션에서 JSON 데이터를 문자열로 가져오기
	if(userJsonStr != null) {
		userJsonStr = (String) session.getAttribute("user");
		
		Gson gson = new Gson();
		UserVO user = gson.fromJson(userJsonStr, UserVO.class);

		// 필요한 속성에 접근하여 데이터를 가져옵니다.
		userNo = user.getUser_no();
		adminChk = "Y".equals(user.getUser_admin_chk()) ? true : false;
           System.out.println("@@@@@user번호 정보@@@@@" + userNo);
        }
    	int partyNo = Integer.parseInt(request.getParameter("selectedPartyNo"));
     %>
		
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
		
		
	
		
	
		
		
		
		findPartyAdminNo = function(callback){
			let selectedPartyNo = <%=partyNo%>;
			console.log(selectedPartyNo);
			partyAdminNo = "";
			$.ajax({
				url : `${myPath}/findPartyAdmin.do`,
				data : { "partyNo" : selectedPartyNo},
				type : 'get',
				success : function(res){
					
					partyAdminNo = res.flag;
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
		
		
		
		
		
		
		countUpdate = function(){
			$.ajax({
				url : `${myPath}/photoCountUpdate.do`,
				type : 'get',
				data : {"photoNo" : photoNon},
				success : function(res){
// 					alert("조회수 증가 성공");
				},
				error : function(xhr){
					alert("조회수 증가 실패"+xhr.status)
				},
				dataType : 'json'
				
				
			})
		}
		
		
		//사진 누르면~
		$(document).on('click','.im',function(){
			photoNon = $(this).prev().html().trim();
			
			countUpdate();
			let selectedPartyNo = <%=partyNo%>;
			
			
			//사진 작성자
			let photoWriterNo = $(this).next().html().trim();
			
			//현재 로그인한유저
			let userNo = <%=userNo%>;
			
			
			//파티장번호 가져오는법
			findPartyAdminNo(myCallback);
			
			if((photoWriterNo == userNo) || user.user_admin_chk == "Y" || (findPartyAdminNo(myCallback) == userNo) ){
				$('#pmodido').show();
				$('#pdeldo').show();
			}
			
			
			
			
			
			///////////////////////////////
			
			
			
// 			if()
			
			//데이터에 넣어 보낼것 
			//1. 내가 누른 사진의 게시물 작성자 유저no
			//2. 소모임 관리자 유저no
			
			//3. 로그인된 내 유저no - 이건 나중에 수정삭제버튼만 잘해놓으면될듯
			$.ajax({
				url : `${myPath}/photoDetail.do`,
				data : { "photoNo" : photoNon} ,
				type : 'get', 
				success : function(res){
// 					alert("성공");
					$('#pDetailCon').html(res.pcontent);
					$('#pDetailDate').html(res.pdate);
					$('#pDetailCount').html(res.pcount);
					$('#pWriter').html(res.pnickname);
					$('#pDetailTitle').html(res.ptitle);
					
					$('#pModal').modal('show');
					
				},
				error : function(xhr){
					alert("실패 : "+xhr.status);
				},
				dataType : 'json'
				
			})
			
			
		});
		//수정버튼 누르면~
		$(document).on('click','#pmodido',function(){
			detailTitle = $('#pDetailTitle').html().trim();
			detailCon = $('#pDetailCon').html().trim();
			
			$('#pDetailTitleModi').show();
			$('#pDetailConModi').show();
			
			$('#pDetailTitle').hide();
			$('#pDetailCon').hide();
			
			$('#pDetailTitleModi').val(detailTitle);
			$('#pDetailConModi').val(detailCon);
			
			$('#pdeldo').hide();
			$('#psenddo').show();
			
			
		});
		
		//닫기버튼 누르면~
		$(document).on('click','.closethedoor',function(){
			$('#pDetailTitleModi').hide();
			$('#pDetailConModi').hide();
			
			$('#pDetailTitle').show();
			$('#pDetailCon').show();
			
			$('#pdeldo').show();
			$('#psenddo').hide();
			
		})
		
		//삭제버튼 누르면~
		$(document).on('click','#pdeldo',function(){

			let result = confirm("정말로 삭제하시겠습니까?");
			
			if(result){
				$.ajax({
					url : `${myPath}/photoDelete.do`,
					data :  { "photoNo" : photoNon} ,
					type : 'get', 
					success : function(){
						alert("삭제되었습니다.");
						location.href = `${myPath}/party/partyPhoto.jsp?selectedPartyNo=<%=request.getParameter("selectedPartyNo")%>`
					},
					error : function(){
						alert("실패"+xhr.status);
					},
					dataType : 'json'
					
				})
				
			}else{
				
			}
		})
		
		//수정할때 확인버튼 누르면~~~
		$(document).on('click','#psenddo',function(){
			modiTitleVal =  $('#pDetailTitleModi').val();
			modiConVal = $('#pDetailConModi').val();
			
// 			console.log(modiTitleVal,modiConVal)
			
			$.ajax({
				url : `${myPath}/photoUpdate.do`,
				data : {"photoNo" : photoNon,
						"title" : modiTitleVal,
						"content" : modiConVal},
				type : 'get',
				success : function(){
					alert("수정이 완료되었습니다");
					$('#pDetailTitleModi').hide();
					$('#pDetailConModi').hide();
					
					$('#pDetailTitle').show();
					$('#pDetailCon').show();
					
					$('#pdeldo').show();
					$('#psenddo').hide();
					$('#pModal').modal('hide');
					
					
					
				},
				error : function(){
					alert("실패");
				},
				dataType : 'json'
				
				
			})
			
			
			
			
		})
		
		
		photoList = function(){
			
			$.ajax({
				url : `${myPath}/photoList.do`,
				data : {"partyNo" : partyNo},
				type : 'get',
				success : function(res){
					console.log(res.datas);
					
					dataList = res.datas;
					
					code = "";
				code += `<div class="cardcon">`
				
				carusel = "";
				

// 				carusel+= `<div class="carousel-indicators">
// 					    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
// 					    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
// 					    <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
// 					  </div>
// 					  <div class="carousel-inner">`
					  
					  if(dataList.length >= 3){
						  carusel+=`<div id="demo" class="carousel slide" data-bs-ride="carousel">`
						  carusel+= `<div class="carousel-indicators">
							    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
							    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
							    <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
							  </div>
							  <div class="carousel-inner">`
						  
						  
						  for(i=0; i<3; i++){
							  carusel +=`<div class="carousel-item active">
							      <img src="${myPath}/imageView.do?filename=${dataList[i].photo_filename}" alt="carousel1.jpg" class="d-block w-100">
							        <div class="carousel-caption">
									   <h3>${dataList[i].photo_title}</h3>
									   <p>${dataList[i].photo_content}</p>
									 </div>
							    </div>`
						  }
							carusel+=  `</div>
								<button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
							    <span class="carousel-control-prev-icon"></span>
							  </button>
							  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
							    <span class="carousel-control-next-icon"></span>
							  </button>
							</div>`
						  
						  
					  }else if(dataList.length == 1){
						  carusel+=`<div id="demo" class="carousel slide" data-bs-ride="carousel">`
						  carusel+= `<div class="carousel-indicators">
							    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
							  </div>
							  <div class="carousel-inner">`
						  
						  
						  carusel +=`<div class="carousel-item active">
						      <img src="${myPath}/imageView.do?filename=${dataList[0].photo_filename}" alt="carousel1.jpg" class="d-block w-100">
						        <div class="carousel-caption">
								   <h3>${dataList[0].photo_title}</h3>
								   <p>${dataList[0].photo_content}</p>
								 </div>
						    </div>`
								carusel+=  `</div>
									<button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
								    <span class="carousel-control-prev-icon"></span>
								  </button>
								  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
								    <span class="carousel-control-next-icon"></span>
								  </button>
								</div>`
						    
						    
					  }else if(dataList.length == 2){
						  carusel+=`<div id="demo" class="carousel slide" data-bs-ride="carousel">`
						  carusel+= `<div class="carousel-indicators">
							    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
							    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
							  </div>
							  <div class="carousel-inner">`
						  
						  for(i=0; i<2; i++){
							  carusel +=`<div class="carousel-item active">
							      <img src="${myPath}/imageView.do?filename=${dataList[i].photo_filename}" alt="carousel1.jpg" class="d-block w-100">
							        <div class="carousel-caption">
									   <h3>${dataList[i].photo_title}</h3>
									   <p>${dataList[i].photo_content}</p>
									 </div>
							    </div>`
						  }
							carusel+=  `</div>
								<button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
							    <span class="carousel-control-prev-icon"></span>
							  </button>
							  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
							    <span class="carousel-control-next-icon"></span>
							  </button>
							</div>`
					  }else{
						  carusel += `<br><h3 style="text-align : center;">아직 사진이 등록되지 않았어요</h1><br><br>
						  <h4 style="text-align : center;">소중한 추억을 소모임 멤버들과 공유해 보세요!</h2><br>`
					  }
				
				
				
					$.each(res.datas, function(i,v){
						imgpath = `/semi_project/photo/${v.photo_filename}`
						
					  	code += `<div class="card" style="width: 32%; margin : 7px; height : 400px">
							<p class="photoNo" style="display : none">${v.photo_no}</p>
						  <img class="card-img-top im" src="${myPath}/imageView.do?filename=${v.photo_filename}"  alt="Card image">
							<p class="userNo" style="display : none">${v.user_no}</p>
					  </div>`
					})
					  
					  
				code += `</div>`  
				$('#listOfCarusel').html(carusel);
				$('#listOfPhoto').html(code);
					
					
					
				},
				error : function(xhr){
					alert("실패"+xhr.status)
				},
				dataType :'json'
				
			})
		};
		
		$(document).on('click','#insertPhoto',function(){
			$('#inModal').modal('show');
			$('#insend').prop('disabled',true);
			
			
			
			function checkInputs(){
				let titley = $('#photointitle').val();
	            let contenty = $('#photoinfile').val();
				let filey = $('#file').val();
				
				if ((titley != '') && (contenty != '') && (filey !== '')) {
		            $('#insend').prop('disabled', false);
		        } else {
		            $('#insend').prop('disabled', true);
		        }
				
			}
			$('#photointitle').on('input',function(){
				checkInputs();
			})
			$('#photoinfile').on('input',function(){
				checkInputs();
			})
			$('#file').on('input',function(){
				checkInputs();
			})
			
			
		});
		photoList();
		
		
	})
</script>
</body>
<header>
<%-- 	<jsp:include page="../jsp/nav.jsp"/> --%>
</header>
<main>


<div id="listOfCarusel"></div>


<br>
<div id="insertPhotoNav">
	<input type="button" id="insertPhoto" class="btn btn-primary"  style="border: none; background-color: #ed4c78;" value="사진 추가">
</div>
<br>

<div id="listOfPhoto">

</div>	 
<br>
<br>
<br>
<br>


<!-- 사진 추가 The Modal -->
<div class="modal" id="inModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">사진 추가</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
	      <form id="photoinform" method="post" enctype="multipart/form-data"  action="<%=request.getContextPath()%>/photoInsert.do">
	      		<label>제목</label>
	      		<input type="text" id="photointitle" name = "photointitle">
	      		<br><br>
	      		<input type="file" id="photoinfile" name = "photoinfile">
	      		<br>
	       		<label>사진 설명</label>
	       		<br>
	       		<textarea rows="5" cols="58" class="txt" id="photoincon" name="photoincon"></textarea>
	       		<br><br>
		      <input type ="text" name="userno" value="<%=userNo%>" style="display:none">
		      <input type ="text" name="partyno" value="<%=partyNo%>" style="display:none">
	       	<input type="submit" id="insend" class="btn btn-light"  value ="등록">
	      </form>
      </div>
      <!-- userNo랑 게시판No -->
		
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>


<!-- 상세보기 The Modal -->
<div class="modal" id="pModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
      
        <h4 class="modal-title" id="pDetailTitle">
        </h4>
        <h4>
        	<input type="text" id="pDetailTitleModi" style="display : none;">
        </h4>
        
        
        <button type="button" class="btn-close closethedoor"  data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
       		<label>설명</label>
       		<div id="pDetailCon">
       		</div>
       		<div>
       			<textarea rows="4" cols="55" id="pDetailConModi" style="display : none;"></textarea>
       		</div>
       		<br><br><br><br><br><br>
       		
       		<label>작성일</label>
       		<p id="pDetailDate"></p>
       		<label>조회수</label>
       		<p id="pDetailCount"></p>
       		
       		<div id="writercont" style ="text-align : right;">
	       		<label>작성자</label>
	       		<h5 id="pWriter"></h5>
       		</div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
       	<input type="button" id="pmodido" class="btn btn-light"  value ="수정" style="display : none">
       	<input type="button" id="psenddo" class="btn btn-light"  value ="확인" style="display : none">
       	<input type="button" id="pdeldo" class="btn btn-light"  value ="삭제" style="display : none">
        <button type="button" class="btn btn-light closethedoor"  data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>




</main>
<footer>
<%-- 	<jsp:include page="../jsp/footer.jsp"/> --%>
</footer>
</html>