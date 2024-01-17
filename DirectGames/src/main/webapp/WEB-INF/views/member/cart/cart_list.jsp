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

      .footer{
      
     	position: absolute;
     	bottom: 0;
      }
    </style>

   
  </head>
  <body>
    
<%@include file="/WEB-INF/views/comm/header.jsp" %>

<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
 <h3>장바구니</h3>
</div>

<div class="container">

  <table class="table table-striped">
    <thead>
      <tr>
        <th scope="col"><input type="checkbox" id="checkAll"></th>
        <th scope="col">게임</th>
        <th scope="col">게임명</th>
        <th scope="col">가격</th>
        <th scope="col">합계</th>
        <th scope="col">비고</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${cart_list }" var="cartDTO">
      <tr>
        <td><input type="checkbox" class="check" name="cart_code" value="${cartDTO.cart_code}"></td>
        <td>
        	<img width="50%" height="50" src="/member/cart/imageDisplay?dateFolderName=${cartDTO.img_up_folder }&fileName=${cartDTO.game_img}">
        </td>
        <td>${cartDTO.game_title }</td>
        <td><span id="unitPrice">${cartDTO.game_price}</span></td>
        <td><span class="unitTotalprice" id="unitTotalprice">${cartDTO.game_price}</span></td>
        <td>
          <button type="button" name="btn_ajax_cart_del" class="btn btn-danger">삭제(ajax용)</button>
          <button type="button" name="btn_nonajax_cart_del" class="btn btn-danger">삭제(non-ajax용)</button>
        </td>
      </tr>
      </c:forEach>
    </tbody>
    <tfoot>
    	<tr>
    		<td colspan="8"><button type="button" name="btn_sel_del" class="btn btn-danger">선택삭제</button></td>
    	</tr>
      <tr>
        <td colspan="8" style="text-align: right;">
          최종결제금액 : <span id="cart_total_price">${cart_total_price}</span>
        </td>
      </tr>
      <tr>
        <td colspan="8" style="text-align: center;">
          <button type="button" id="btn_game" class="btn btn-primary">쇼핑계속하기</button>
          <button type="button" id="btn_cart_empty" class="btn btn-primary">장바구니 비우기</button>
          <button type="button" id="btn_order" class="btn btn-primary">주문하기</button>
        </td>
      </tr>
    </tfoot>
  </table>

</div>

  <%@include file="/WEB-INF/views/comm/footer.jsp" %>
<%@include file="/WEB-INF/views/comm/plugin.jsp" %>
  <!-- 카테고리 메뉴 자바스크립트 작업소스 -->
  <script src="/js/category_menu.js"></script>
  
  <script>
	$(document).ready(function() {

    // 장바구니 삭제(ajax 사용)
    $("button[name='btn_ajax_cart_del']").on("click", function() {

      if(!confirm("장바구니 상품을 삭제하겠습니까?")) return;

      let cur_btn_delete = $(this); // 선택된 버튼태그의 위치를 참조
      let cart_code = $(this).parent().parent().find("input[name='cart_code']").val(); 

      // console.log("장바구니코드", cart_code);

      $.ajax({
        url: '/member/cart/cart_list_del',
        type: 'post',
        data: {cart_code: cart_code}, 
        dataType : 'text',
        beforeSend : function(xhr) {
            xhr.setRequestHeader("AJAX", "true");
          },
        success : function(result) {
          if(result == "success") {
            alert("장바구니 상품이 삭제되었습니다.");

            cur_btn_delete.parent().parent().remove(); // 삭제된 장바구니 데이터행 제거

            // 전체주문금액
            fn_cart_sum_price();
          }
        },
        error : function(xhr, status, error) {
            alert(status);
            alert("로그인 페이지로 이동합니다.");
            location.href = "/member/login";
          }
      });

    });

    //장바구니 삭제(non-ajax용)
    $("button[name='btn_nonajax_cart_del']").on("click", function() {
      
      if(!confirm("장바구니 상품을 삭제하겠습니까?")) return;
      
      let cart_code = $(this).parent().parent().find("input[name='cart_code']").val(); 
      location.href = "/member/cart/cart_list_del?cart_code=" + cart_code;
    });

    //주문정보 페이지
    $("button#btn_order").on("click", function() {
      location.href = "/member/order/order_info";
    });

    //제목행 체크박스 선택
    let isCheck = true;
      $("#checkAll").on("click", function() {
        //데이터 행 checkbox
        $(".check").prop("checked", this.checked);

        isCheck = this.checked;
      });

      //데이터행 체크박스 선택
      $(".check").on("click", function(){
        //제목행 체크박스
        $("#checkAll").prop("checked", this.checked);

        //데이터행의 체크박스 상태를 확인.
        $(".check").each(function() {
          if(!$(this).is(":checked")) {
            $("#checkAll").prop("checked", false);
          }
        });
      });

    //장바구니 선택삭제 name="btn_sel_del"
    $("button[name='btn_sel_del']").on("click", function() {
        if($(".check:checked").length == 0) {
          alert("삭제할 상품을 체크하세요.");
          return;
        }

        if(!confirm("선택 상품을 삭제하시겠습니까?")) return;

        //삭제 할 장바구니코드.  자바스크립트 배열 : https://www.w3schools.com/js/js_arrays.asp
        let cart_code_arr = [];

        //선택한 체크박스 .
        $(".check:checked").each(function() {
          cart_code_arr.push($(this).val());
        });

        console.log("삭제할 장바구니코드: " + cart_code_arr);


        $.ajax({
          url: '/member/cart/cart_sel_delete',
          type: 'post',
          dataType: 'text',
          data: { cart_code_arr: cart_code_arr },
          success: function(result) {
            if(result == "success") {
              alert("선택한 상품이 삭제되었습니다.");
              location.href = "/member/cart/cart_list";
            }
          }
        });

      });

      //장바구니 비우기
      $("#btn_cart_empty").on("click", function(){

          if(!confirm("장바구니를 비우시겠습니까?")) return;
    	  location.href = "/member/cart/cart_empty";          

      });
      

      //사용자정의함수
      // 콤마제거하기. 연산할 때 사용
      $.withoutCommas = function(x) {
        return x.toString().replace(",", "");
      }

      //3자리마다 콤마찍기. 표시할 때 사용.
      $.numberWithCommas = function(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
      }

      //쇼핑 계속하기
      $("#btn_game").on("click", function(){
    	  location.href = "/board/game/game_list";
      });

	}); // jquery ready-end


   // 장바구니 전체주문금액
  function fn_cart_sum_price() {
   let sumPrice = 0;
    $(".unitTotalprice").each(function() {
      sumPrice += Number($(this).text()); 
    });
    $("#cart_total_price").text(sumPrice);
  }

  </script>  
  </body>
</html>
    