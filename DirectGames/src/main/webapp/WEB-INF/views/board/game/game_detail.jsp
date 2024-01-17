<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.101.0">
    <title>Pricing example · Bootstrap v4.6</title>

    <!-- Bootstrap core CSS -->
<%@include file="/WEB-INF/views/comm/plugin2.jsp" %>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://code.jquery.com/resources/demos/style.css">
 <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="reviewTemplate" type="text/x-handlebars-template">
  <table class="table table-sm">
  <thead>
    <tr>
      <th scope="col">번호</th>
      <th scope="col">리뷰내용</th>
      <th scope="col">별평점</th>
      <th scope="col">날짜</th>
      <th scope="col">비고</th>
    </tr>
  </thead>
  <tbody>
    {{#each .}}
    <tr>
      <th scope="row" class="rev_num">{{rev_num}}</th>
      <td class="rev_content">{{rev_content}}</td>
      <td class="rev_score">{{displayStar rev_score}}</td>
      <td class="rev_regdate">{{convertDate rev_regdate}}</td>
      <td>{{authControlView dgm_id rev_num rev_score}}</td>
    </tr>
    {{/each}}
  </tbody>
</table>
</script>

<script>
  $( function() {
    $("#tabs_game_detail").tabs();
  });
  </script>

    <!-- Favicons -->


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .ui-draggable, .ui-droppable {
	      background-position: top;
      }

      /* 별평점 기본선택자 */
      p#star_rv_score a.rv_score {
        font-size: 22px;
        text-decoration: none;
        color: lightgray;
      }

      /* 별평점에 마우스 오버했을 경우 사용되는 CSS선택자 */
      p#star_rv_score a.rv_score.on {
        color: red;
      }
    .div-info{
    	
    	font-size: 16px;
    }
    .div-info .btn-primary{
    	
    	margin-top : 60px;
    }
    .info-title{
    	
    	text-align: center; 
    	font-size : 24px;
    	font-weight: bold;
    }
    </style>

   
  </head>
  <body>
    
<%@include file="/WEB-INF/views/comm/header.jsp" %>

<div class="container">
  <div class="card-deck mb-3 text-center row">
    <div class="col-md-6">
      	 <img class="btn_game_img"  data-game_id="${gameVO.game_id }"  width="100%" height="200" src="/board/game/imageDisplay?dateFolderName=${gameVO.img_up_folder }&fileName=${gameVO.game_img}">
    </div>
    <div class="col-md-6 div-info">
      <div class="row text-left">
        <div class="col info-title">
          ${gameVO.game_title }
        </div>
      </div>
      <div class="row text-left">
        <div class="col">
          <span id="game_price">판매가 : ${gameVO.game_price }원</span>
        </div>
      </div>
      <div class="row text-left">
        <div class="col">
 		         출시일 : <span id="release_date"><fmt:formatDate value="${gameVO.release_date }" pattern="yyyy-MM-dd" /></span>
        </div>
      </div>
      <div class="row text-left">
        <div class="col">
 		         장르 : <span id="genre_name">${genreVO.genre_name }</span>
        </div>
      </div>
      <div class="row text-left">
        <div class="col">
 		         퍼블리셔 : <span id="publisher_name">${publisherVO.publisher_name }</span>
        </div>
      </div>
      <div class="row text-left">
        <div class="col">
 		         플랫폼 : <span id="platform_name">${platformVO.platform_name }</span>
        </div>
      </div>
      <div class="row text-left">
        <div class="col">
 		         언어 : <span id="game_language">${gameVO.game_language }</span>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <button type="button" class="btn btn-primary" name="btn_order" data-game_id="${gameVO.game_id }">구매하기</button>
        </div>
        <div class="col-md-6">
          <button type="button" class="btn btn-primary" name="btn_cart_add" data-game_id="${gameVO.game_id }">장바구니</button>
        </div>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div id="tabs_game_detail">
        <ul>
          <li><a href="#tabs-gamedetail">상품설명</a></li>
          <li><a href="#tabs-gamereview">상품후기</a></li>
        </ul>
        <div id="tabs-gamedetail">
          <p>${gameVO.game_description }</p>
        </div>
        <div id="tabs-gamereview">
          <p>상품후기 목록</p>
          <div class="row">
            <div class="col-md-12" id="review_list">

            </div>
          </div>
          <div class="row">
            <div class="col-md-8 text-center" id="review_paging">
             
            </div>
            <div class="col-md-4 text-right">
              <button type="button" id="btn_review_write" class="btn btn-info">상품후기작성</button>
            </div>
          </div>
        </div>        
      </div>
    </div>
  </div>
<div class="row text-center">
	<div class="col-md-12">
			
	<!--1)페이지번호 클릭할 때 사용  [이전]  1	2	3	4	5 [다음]  -->
	<!--2)목록에서 상품이미지 또는 상품명 클릭할 때 사용   -->
	 <form id="actionForm" action="" method="get">
	<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
	<input type="hidden" name="amount"  id="amount" value="${pageMaker.cri.amount}" />
	<input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
	<input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />
	
		
	  </form>

	
	</div>
</div>

</div>

 <%@include file="/WEB-INF/views/comm/footer.jsp" %>
<%-- <%@include file="/WEB-INF/views/comm/plugIn.jsp" %> --%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
  <!-- 카테고리 메뉴 자바스크립트 작업소스 -->
  <script src="/js/category_menu.js"></script>
  
  <script>
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
          data: {game_id : $(this).data("game_id")},
          dataType : 'text',
          success: function(result) {
            if(result == "success") {
              alert("장바구니에 추가됨");
              if(confirm("장바구니로 이동하겠읍니까?")) {
                location.href = "/member/cart/cart_list";
              }
            }
          }
        });


      });

      //구매하기(주문)
      $("button[name='btn_order']").on("click", function() {

        let url = "/member/order/order_ready?game_id=" + $(this).data("game_id");
        location.href = url;
      })

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

      //상품후기작성 폼
      $("#btn_review_write").on("click", function() {
        
        $("#btn_review_modify").hide(); // 상품수정하기 버튼 숨김.
        $("#btn_review_save").show(); // 상품후기저장 버튼 보임.
        $('#review_modal').modal('show');
      });

      //별평점 클릭시. 별평점 태그 5개  ☆☆☆☆☆
      $("p#star_rv_score a.rv_score").on("click", function(e){
        e.preventDefault();
        // $(this) : 클릭한 a태그
        $(this).parent().children().removeClass("on");
        $(this).addClass("on").prevAll("a").addClass("on");


      });

      // 상품평 목록 불러오는 작업. (이벤트 사용 안하고, 직접 호출)
      let reviewPage = 1; // 목록에서 1번째 페이지를 의미.
      // 	@GetMapping("/list/{game_id}/{page}")
      let url = "/user/review/list/" + ${gameVO.game_id } + "/" + reviewPage;

      getReviewInfo(url);
      
      function getReviewInfo(url) {
        $.getJSON(url, function(data) {

          // console.log("상품후기", data.list[0].rev_content);
          // console.log("페이징정보", data.pageMaker.total);
          // review_list

          printReviewList(data.list, $("#review_list"), $("#reviewTemplate"))

          // review_paging
          printPaging(data.pageMaker, $("#review_paging"));

        });
      }

      //1)상품후기작업함수
      let printReviewList = function(reviewData, target, template) {
      let templateObj = Handlebars.compile(template.html());
      let reviewHtml = templateObj(reviewData);

        //상품후기목록 위치를 참조하여, 추가
        target.children().remove(); 
        target.append(reviewHtml);
      }

      //2)페이징기능작업함수
      let printPaging = function(pageMaker, target) {
        
        let pagingStr = '<nav id="navigation" aria-label="Page navigation example">';
        pagingStr += '<ul class="pagination">';
        
        //이전표시여부
        if(pageMaker.prev) {
          pagingStr += '<li class="page-item"><a class="page-link" href="' + (pageMaker.startpage -1) + '">[prev]</a></li>';
        }
        //페이지번호 출력
        for(let i=pageMaker.startPage; i<=pageMaker.endPage; i++) {
          let className = pageMaker.cri.pageNum == i ? 'active' : '';
          pagingStr += '<li class="page-item ' + className + '"><a class="page-link" href="' + i + '">' + i + '</a></li>';
        }

        
        //다음표시여부
        if(pageMaker.next) {
          pagingStr += '<li class="page-item"><a class="page-link" href="' + (pageMaker.startpage +1) + '">[next]</a></li>';
        }
        pagingStr += '</ul>';
        pagingStr += '</nav>';

        target.children().remove(); 
        target.append(pagingStr);
      }


      // 사용자정의 Helper (핸들바의 함수정의) 
      // 상품후기 등록일 milisecond -> 자바스크립트의 Date객체로 변환.
      Handlebars.registerHelper("convertDate", function(reviewtime) {

        const dateObj = new Date(reviewtime);
        let year = dateObj.getFullYear();
        let month = dateObj.getMonth() + 1;
        let date = dateObj.getDate();
        let hour = dateObj.getHours();
        let minute = dateObj.getMinutes();

        return year + "/" + month + "/" + date + " " + hour + ":" + minute;
      });

      // 별평점(숫자)을 별로 출력하기.
      Handlebars.registerHelper("displayStar", function(rating) {

        let starStr = "";
        switch(rating) {
          case 1:
            starStr = "★☆☆☆☆";
            break;
          case 2:
            starStr = "★★☆☆☆";
            break;
          case 3:
            starStr = "★★★☆☆";
            break;
          case 4:
            starStr = "★★★★☆";
            break;
          case 5:
            starStr = "★★★★★";
            break;
        }

        return starStr;

      });

      //상품후기 수정/삭제버튼 표시
      Handlebars.registerHelper("authControlView", function(dgm_id, rev_num, rev_score) {
        let str = "";
        let login_id = '${sessionScope.loginStatus.dgm_id}';

        // 로그인 한 사용자와 상품후기 등록 사용자 동일여부체크
        if(login_id == dgm_id) {
          str += '<button type="button" name="btn_review_edit" class="btn btn-info" data-rev_score="' + rev_score + '">edit</button>';
          str += ' <button type="button" name="btn_review_del" class="btn btn-danger" data-rev_num="' + rev_num + '">delete</button>';

          console.log(str);
          // 출력내용이 태그일 때 사용.
          return new Handlebars.SafeString(str);
        }

      });

      //상품후기 수정버튼 클릭 : 상품후기 수정폼
      $("div#review_list").on("click", "button[name='btn_review_edit']", function() {
        // modal()메서드는 부트스트랩 메서드

        /*
        console.log("번호", $(this).parent().parent().find(".rev_num").text());
        console.log("내용", $(this).parent().parent().find(".rev_content").text());
        console.log("평점", $(this).parent().parent().find(".rev_score").text());
        console.log("날짜", $(this).parent().parent().find(".rev_regdate").text());
        */

        //평점작업. 선택자 5개
        let rev_score = $(this).data("rev_score");
        console.log("별평점", rev_score);
        $("#star_rv_score a.rv_score").each(function(index, item) {
          if(index < rev_score) {
            $(item).addClass("on");
          }else {
            $(item).removeClass("on");
          }
        });
        // 상품후기 내용
        $("#rev_content").text($(this).parent().parent().find(".rev_content").text());
        // 상품후기 번호
        $("#rev_num").text($(this).parent().parent().find(".rev_num").text());
        // 상품후기 등록일
        $("#rev_regdate").text($(this).parent().parent().find(".rev_regdate").text());

        $("#btn_review_save").hide(); // 상품후기저장 버튼 숨김.
        $("#btn_review_modify").show(); // 상품후기수정 버튼 보임.
        // 상품후기수정 버튼에 후기번호를 data-rev_num 속성으로 저장.
        // $("#btn_review_modify").data("rev_num", $(this).parent().parent().find(".rev_num").text());
        $('#review_modal').modal('show');

        

      });

      // 상품후기 수정하기
      $("#btn_review_modify").on("click", function() {

        let rev_num = $("#rev_num").text();
        let rev_content = $("#rev_content").val();
        //평점
        let rev_score = 0;
        $("p#star_rv_score a.rv_score").each(function(index, item) {
          if($(this).attr("class") == "rv_score on") {
            rev_score += 1;
          }
        });
        let review_data = {rev_num : rev_num, rev_content : rev_content, rev_score : rev_score};

        $.ajax({
          url : '/user/review/modify',
          headers: {
            "Content-Type" : "application/json", "X-HTTP-Method-Override" : "PUT"
          },
          type : 'put',
          data : JSON.stringify(review_data),   // 데이터포맷 object -> json 으로 변환
          dataType: 'text',
          success : function(result) {
            if(result == 'success') {
              alert("상품평이 수정됨");
              $('#review_modal').modal('hide'); // 부트스트랩 4.6버전의 자바스크립트 명령어
              // 상품평 목록 불러오는 작업.
              getReviewInfo(url);
            }
          }
        });

      });


      //상품후기 삭제버튼 클릭
      $("div#review_list").on("click", "button[name='btn_review_del']",function() {
        
        if(!confirm("상품후기를 삭제하겠읍니까?")) return;
        
        let rev_num = $(this).data("rev_num");

        $.ajax({
          url : '/user/review/delete/' + rev_num,
          headers: {
            "Content-Type" : "application/json", "X-HTTP-Method-Override" : "DELETE"
          },
          type : 'delete',
          dataType: 'text',
          success : function(result) {
            if(result == 'success') {
              alert("상품평이 삭제됨");
             
              url = "/user/review/list/" + ${gameVO.game_id } + "/" + reviewPage;
              getReviewInfo(url);
            }
          }
        });
      });


      //페이징번호 클릭
      $("div#review_paging").on("click", "nav#navigation ul a", function(e) {
        e.preventDefault();
        // console.log("페이지번호");

        reviewPage = $(this).attr("href"); // 상품후기 선택 페이지번호 
        
        url = "/user/review/list/" + ${gameVO.game_id } + "/" + reviewPage;

        getReviewInfo(url); // 스프링에서 상품후기, 페이지번호 데이타 가져오는 함수.

      });


      //상품후기저장
      $("#btn_review_save").on("click", function() {
        //별평점 값
        let rev_score = 0;
        let rev_content = $("#rev_content").val();

        $("p#star_rv_score a.rv_score").each(function(index, item) {
          if($(this).attr("class") == "rv_score on") {
            rev_score += 1;
          }
        });

        // 별선택 안했을 경우 체크
        if(rev_score == 0) {
          alert("별 평점을 선택하세요.");
          return;
        }

        //후기 체크
        if(rev_content == "") {
          alert("상품평을 작성하세요");
          reutrn;
        }

        // ajax를 사용하여 스프링으로 리뷰데이타 전송작업
        let review_data = {game_id : $(this).data("game_id"), rev_content : rev_content, rev_score : rev_score};

        $.ajax({
          url : '/user/review/new',
          headers: {
            "Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"
          },
          type : 'post',
          data : JSON.stringify(review_data),   // 데이터포맷 object -> json 으로 변환
          dataType: 'text',
          success : function(result) {
            if(result == 'success') {
              alert("상품평이 등록됨");
              $('#review_modal').modal('hide'); // 부트스트랩 4.6버전의 자바스크립트 명령어
              // 상품평 목록 불러오는 작업.
              getReviewInfo(url);
            }
          }
        });

      });

	}); // ready event end

  </script>  

  <!--상품후기 Modal-->
<div class="modal fade" id="review_modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <!--<h5 class="modal-title" id="exampleModalLabel">상품후기</h5>-->
        <b>상품후기</b><span id="rev_num">5</span><span id="rev_regdate"></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">별평점</label>
            <p id="star_rv_score">
              <a class="rv_score" href="#">☆</a>
              <a class="rv_score" href="#">☆</a>
              <a class="rv_score" href="#">☆</a>
              <a class="rv_score" href="#">☆</a>
              <a class="rv_score" href="#">☆</a>
            </p>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">내용</label>
            <textarea class="form-control" id="rev_content"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="btn_review_save" class="btn btn-primary" data-game_id="${gameVO.game_id }" >상품후기저장</button>
        <button type="button" id="btn_review_modify" class="btn btn-primary">상품후기수정</button>
      </div>
    </div>
  </div>
</div>

  </body>
</html>
    