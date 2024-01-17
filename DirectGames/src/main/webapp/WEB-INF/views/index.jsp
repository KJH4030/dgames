<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimun-scale=1.0, user-scalable=no">
<title>다이렉트게임즈</title>
<link rel="stylesheet" href="/css/main/main.css">
<link rel="stylesheet" href="/css/main/card.css">
<!-- HTML5와 미디어쿼리를 지원하지 않는 IE8 이하 버전을 위해 -->
<!-- [if lt IE 9]>
	<script src="js/html5shiv/html5shiv.min.js"></scirpt>
	<script src="js/respond/respond.min.js"></scirpt>
<![endif]-->

</head>
<body>
<div id="wrap">
    <header class="header clear">
        <div class="header_in">
            <div class="search_area">
                <input type="text" class="search" id="search_total" value="" name="search" title="검색어 입력">
                <input type="image" class="image" src="/resources/image/search_icon3.png" alt="검색" style="height: 36px;">
            </div>
            <div class="logo">
                <h1><a href="#"><img src="/resources/image/dg_logo.png" alt="directgames"></a></h1>
            </div>
            
            <div class="util">
            	<c:if test="${sessionScope.loginStatus == null}">
            	<a href="/member/login"><img src="/resources/image/login.png" alt="로그인"></a>
    			</c:if>
                <c:if test="${sessionScope.loginStatus != null}">
                <a href="/member/logout"><img src="/resources/image/logout.png" alt="로그아웃"></a>
                </c:if>                
                <a href="/member/regist"><img src="/resources/image/regist.png" alt="회원가입"></a>
                <a href="#"><img src="/resources/image/cart.png" alt="장바구니"></a>
            </div>
            <span class="menu_toggle_btn">전체 메뉴 토글 버튼</span>
            
            <nav class="nav">
                <ul class="gnb clear">
                    <li><a href="#">SERVICE</a></li>
                    <li><a href="/board/game/game_list">GAME</a></li>
                    <li><a href="/board/notice/ntc_list">SUPPORT</a></li>
                    <li><a href="#">EVENT</a></li>
                    <li><a href="#">PROMOTION</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <nav class="nav2">
        <ul class="gnb2 clear">
            <li><a href="#">SERVICE</a></li>
            <li><a href="/board/game/game_list">GAME</a></li>
            <li><a href="/board/notice/ntc_list">SUPPORT</a></li>
            <li><a href="#">EVENT</a></li>
            <li><a href="#">PROMOTION</a></li>
        </ul>
    </nav>
    <section class="mvisual">
        <div class="mvisual_in">
            <ul class="visual">
                <li class="list0"><img src="/resources/image/mvisual.png" alt="이미지1"></li>
                <li class="list1"><img src="/resources/image/mvisual2.png" alt="이미지2"></li>
                <li class="list2"><img src="/resources/image/mvisual3.png" alt="이미지3"></li>
            </ul>
            <div class="btn_area"><!-- 버튼영역 -->
                <span class="active"><span>01</span></span>
                <span><span>02</span></span>
                <span><span>03</span></span>
            </div>
        </div>
    </section>
   
    <section class="info clear">
        <div class="info-main">
                <h2>공지사항</h2>
            <div class="news">
                <ul>
				<c:forEach items="${ntc_list }" var="noticeVO">
					<input type="hidden" id="ntc_id" value="${noticeVO.ntc_id }" />
					<li>									
						<a class="move pro_name" href="#" data-ntc_id="${noticeVO.ntc_id }">${noticeVO.ntc_title }</a>
					</li>
				</c:forEach>
                </ul>
            </div>
        </div>        
    </section>
    <section class="promo">
        <h2>프로모션</h2>
        <a href="#"><img src="/resources/image/promotion.png" alt="유비소프트 프로모션"></a>
    </section>
    
	<form id="actionForm" action="" method="get">
		<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
		<input type="hidden" name="amount"  id="amount" value="${pageMaker.cri.amount}" />
		<input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
		<input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />			
	</form>
	
    <section class="banner clear">
        <h2>최신게임</h2>
	  <div class="card-deck mb-3 row">
	    <c:forEach items="${game_list }" var="gameVO">
	    <div class="">
		    <div class="card mb-4 shadow-sm banner_in">
	            <img class="btn_game_img"  data-game_id="${gameVO.game_id }"  width="255" height="119" style="cursor: pointer;" src="/board/game/imageDisplay?dateFolderName=${gameVO.img_up_folder }&fileName=${gameVO.game_img}">
	
	            <div class="card-body">
	              <p class="btn_game_img text-left" style="cursor: pointer;" data-game_id="${gameVO.game_id }">${gameVO.game_title }</p>
	              <div class="d-flex justify-content-between align-items-center mt-65">
	                <div class="btn-group">
	                  <button type="button" name="btn_cart_add" data-game_id="${gameVO.game_id}" class="btn btn-sm btn-outline-secondary">장바구니</button>
	                  <button type="button" name="btn_buy" class="btn btn-sm btn-outline-secondary">구매</button>
	                </div>
	                <small class="text-muted">
	                	<fmt:formatNumber type="currency" pattern="₩#,###" value="${gameVO.game_price }"></fmt:formatNumber>
	                </small>
	              </div>
	            </div>
	          </div>
	    </div>
	    </c:forEach>
	  </div>
        
        <h2>인기게임</h2>
	  <div class="card-deck mb-3 row">
	    <c:forEach items="${game_list }" var="gameVO">
	    <div class="">
		    <div class="card mb-4 shadow-sm banner_in">
	            <img class="btn_game_img"  data-game_id="${gameVO.game_id }"  width="255" height="119" style="cursor: pointer;" src="/board/game/imageDisplay?dateFolderName=${gameVO.img_up_folder }&fileName=${gameVO.game_img}">
	
	            <div class="card-body">
	              <p class="btn_game_img text-left" style="cursor: pointer;" data-game_id="${gameVO.game_id }">${gameVO.game_title }</p>
	              <div class="d-flex justify-content-between align-items-center mt-65">
	                <div class="btn-group">
	                  <button type="button" name="btn_cart_add" data-game_id="${gameVO.game_id}" class="btn btn-sm btn-outline-secondary">장바구니</button>
	                  <button type="button" name="btn_buy" class="btn btn-sm btn-outline-secondary">구매</button>
	                </div>
	                <small class="text-muted">
	                	<fmt:formatNumber type="currency" pattern="₩#,###" value="${gameVO.game_price }"></fmt:formatNumber>
	                </small>
	              </div>
	            </div>
	          </div>
	    </div>
	    </c:forEach>
	  </div>
    </section>
    
    <div id="top_btn">
        <a href="#" class="go"><img src="/resources/image/top_btn.png"></a>
    </div>
</div>
    
<%@ include file="/WEB-INF/views/comm/footer.jsp" %>  

    
    
<!-- 제이쿼리 라이브러리 선언 -->
<script type="text/javascript" src="<c:url value="/js/jquery-3.1.0.min.js"/>"></script>
<script src="/js/main.js"></script>

  <!-- 카테고리 메뉴 자바스크립트 작업소스 -->
  
  <script>
	//장바구니 중복 검사
	let cartCheck = false;
  
	$(document).ready(function() {

		let actionForm = $("#actionForm");

	    // [이전] 1 2 3 4 5 [다음] 클릭 이벤트 설정. <a>태그
	    $(".movepage").on("click", function(e) {
	      e.preventDefault(); // a태그의 href 링크기능을 제거. href속성에 페이지번호를 숨겨둠.

	      actionForm.attr("action", "/board/game/game_list");
	      actionForm.find("input[name='pageNum']").val($(this).attr("href"));

	       actionForm.submit();
	    });

		
	    

	      //장바구니 추가
	      $("button[name='btn_cart_add']").on("click", function() {
	        // console.log("장바구니");

	        $.ajax({
	          url: '/member/cart/cart_add',
	          type: 'post',
	          data: {game_id : $(this).data("game_id"), cart_amount : 1},
	          dataType : 'text',
	          success: function(result) {
	            if(result == "success") {
	              alert("장바구니에 추가됨");
	              if(confirm("장바구니로 이동하겠습니까?")) {
	                location.href = "/member/cart/cart_list";
	              }
	            }else if(result == "failed2"){
				  alert("이미 장바구니에 등록된 상품입니다.");
	              if(confirm("장바구니로 이동하겠습니까?")) {
	                  location.href = "/member/cart/cart_list";
	              }		  
	            }else{
				  alert("로그인을 해주세요.");
				  location.href = "/member/login";
	            }
	          }
	        });


	      });

	      //구매 버튼 클릭
	      $("button[name='btn_buy']").on("click", function() {
	          // console.log("장바구니");

	          $.ajax({
	            url: '/member/cart/cart_add',
	            type: 'post',
	            data: {game_id : $(this).data("game_id"), cart_amount : 1},
	            dataType : 'text',
	            success: function(result) {
	              if(result == "success") {
	                  location.href = "/member/order/order_info";
	                
	              }else if(result == "failed2"){
		              location.href = "/member/order/order_info";	            
	              }else{
		  			  alert("로그인을 해주세요.");
		  			  location.href = "/member/login";
	              }
	            }
	          });


	        });

      // 상품이미지 또는 상품명 클릭시 상품상세로 보내는 작업
      $(".btn_game_img").on("click", function() {
        console.log("상품상세설명");

        actionForm.attr("action", "/board/game/game_detail");

        let game_id = $(this).data("game_id");

        actionForm.find("input[name='game_id']").remove();
        // <input type='hidden' name='game_id' value='상품코드' >
        actionForm.append("<input type='hidden' name='game_id' value='" + game_id +  "'>");
        actionForm.submit();
      });

	}); // ready event end

	//게시글 읽기
	const moves = document.getElementsByClassName("move");
	Array.from(moves).forEach(function(move) {
		// actionForm폼 전송
		move.addEventListener("click", function(event) {
			event.preventDefault();

			//ntc_id 제거작업
			// 목록에서 제목 클릭후 게시물읽기에서 뒤로버튼에 의하여 목록으로 돌아가서
			// 다시 제목을 클릭하면, ntc_id파라미터가 추가되기때문에
			// 기존 ntc_id파라미터를 삭제해야 한다.
			document.getElementById("ntc_id").remove();

			// <a href="#" data-ntc_id="게시물번호" data-name="값" data-title="값">
			let ntc_id = event.target.dataset.ntc_id;
			// <input type='hidden' name='ntc_id' value='게시물번호'>
			// HTML DOM문법
			const newInput = document.createElement("input");
			newInput.setAttribute("type", "hidden");
			newInput.setAttribute("name", "ntc_id");
			newInput.setAttribute("id", "ntc_id");
			newInput.setAttribute("value", ntc_id);
			actionForm.appendChild(newInput);

			actionForm.setAttribute("action", "/board/notice/ntc_get");
			actionForm.submit();
		});
	});
  </script> 
</body>
</html>
