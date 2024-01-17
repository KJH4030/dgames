<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Direct Games</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<%@ include file="/WEB-INF/views/comm/plugin2.jsp" %>

	<style>
	
	.wrapper{
		width: 1120px;
		margin: 0 auto;
		font-size : 14px;
		text-align: center;
	}
	th {
		color: white;
		background : #6f4e43;
	}
	.pagination{
		margin-left : 20%;
	}
    .footer{
    
   	position: absolute;
   	bottom: 0;
    }
	</style>
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="">
<%@ include file="/WEB-INF/views/comm/header.jsp" %>
<%@include file="/WEB-INF/views/comm/category_menu.jsp" %>
<div class="wrapper">

  <!-- Main Header -->
  <!-- Left side column. contains the logo and sidebar -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <!-- Main content -->
    <section class="content container-fluid">
    	<div class="row">
    		<div class="col-md-12">
    			<div class="box">
					<div class="box-body">
						<table class="table table-bordered">
							<tbody>
							<tr>
								<th style="width: 10%">글번호</th>
								<th style="width: 10%">구분</th>
								<th style="width: 50%">제목</th>
								<th style="width: 20%">작성일</th>
								<th style="width: 10%">조회수</th>
							</tr>
								<c:forEach items="${ntc_list }" var="noticeVO">
							<tr>
								<td>${noticeVO.ntc_id }</td>
								<td>${noticeVO.ntc_cat }</td>
								<td>									
									<a class="move pro_name" href="#" data-ntc_id="${noticeVO.ntc_id }">${noticeVO.ntc_title }</a>
								</td>
								<td><fmt:formatDate value="${noticeVO.ntc_regdate }" pattern="yyyy-MM-dd" /></td>
								<td>${noticeVO.ntc_views }</td>
							</tr>								
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="box-footer clearfix">
						<div class="row">
							<div class="">
								<!--1)페이지번호 클릭할 때 사용  [이전] 1 2 3 4 5 [다음]  action="/board/list"-->
								<!--2)목록에서 상품이지미 또는 상품명을 클릭할 때 동작  action="/board/get" -->
								<form id="actionForm" action="" method="get">
									<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
									<input type="hidden" name="amount"  id="amount" value="${pageMaker.cri.amount}" />
									<input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
									<input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />
									<input type="hidden" name="ntc_id" id="ntc_id" />
								</form>
							</div>
							<div class="col-md-4">							
								<form action="/board/notice/ntc_list" method="get" >
									<input type="text" name="keyword" value="${pageMaker.cri.keyword}" />
									<select name="type">
										<option selected>검색종류선택</option>
										<option value="T" ${pageMaker.cri.type == 'T'? 'selected': ''}>제목</option>
										<option value="C" ${pageMaker.cri.type == 'C'? 'selected': ''}>내용</option>
										<option value="TC" ${pageMaker.cri.type == 'TC'? 'selected': ''}>제목+내용</option>										
									</select>
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
									<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
									<button type="submit" class="btn btn-primary">검색</button>
								</form>
							</div>
							<div class="col-md-6">								
								<nav aria-label="...">
								<ul class="pagination">
									<!-- 이전 표시여부 -->
									<c:if test="${pageMaker.prev }">
										<li class="page-item">
											<a href="${pageMaker.startPage - 1 }" class="page-link movepage">Previous</a>
										</li>
									</c:if>
									<!-- 페이지번호 출력 -->
									<!-- 1	2	3	4	5 6	7	8	9	10  [다음] -->
									<!-- [이전] 11	12	13	14	15 16	17	18	19	20   -->
									<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
										<li class='page-item ${pageMaker.cri.pageNum ==  num ? "active":"" }'aria-current="page">
											<a class="page-link movepage" href="${num }" data-page="${num }">${num }</a>
										</li>
									</c:forEach>
									
									<!--  다음 표시여부 -->
									<c:if test="${pageMaker.next }">
										<li class="page-item">
										<a href="${pageMaker.endPage + 1 }" class="page-link movepage" href="#">Next</a>
										</li>
									</c:if>
									
								</ul>
								</nav>
							</div>
  							<c:if test="${sessionScope.loginStatus.dgm_id == 'admin'}">
							<div class="col-md-2 text-right"> 
								<button type="button" class="btn btn-primary" role="button" id="btn_ntc_regist">공지사항 등록</button>
							</div>
							</c:if>	
						</div>
						
					</div>
			   </div>
    		</div>
    	</div>

    </section>
    <!-- /.content -->
  </div>
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->


<%@include file="/WEB-INF/views/comm/footer.jsp" %>
<%@include file="/WEB-INF/views/comm/plugin.jsp" %>

<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<script>
	$(document).ready(function(){

		let actionForm =$("#actionForm");
		
		//[이전] 1 2 3 4 5 [다음] 클릭 이벤트 설정. <a>태그
		$(".movepage").on("click", function(){
			event.preventDefault(); //a태그의 링크기능 제거. href속성에 페이지번호를 숨겨둠
			

			actionForm.attr("action", "/board/notice/ntc_list");
			//actionForm.find("input[name='pageNum']").val(선택한 페이지번호);
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));

			actionForm.submit();
		});


		//공지사항등록 버튼 페이지 이동
		$("#btn_ntc_regist").on("click", function(){
			location.href = "/board/notice/ntc_regist";
		});



		//게시글 수정
		$("button[name='btn_pro_edit']").on("click", function(){

			//수정 상품코드
			let pro_num = $(this).parent().parent().find("input[name='check']").val();

			console.log(pro_num);
		    //뒤로가기 클릭후 다시 수정버튼 클릭시 코드 중복되는 부분때문에 제거.
		    actionForm.find("input[name='pro_num']").remove();
			
			actionForm.append('<input type="hidden" name="pro_num" id="pro_num" value="' + pro_num + '" /> ');
			
			actionForm.attr("method", "get");
			actionForm.attr("action", "/admin/product/pro_edit");
			actionForm.submit();
			
		});
		
	});//ready

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