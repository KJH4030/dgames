<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!doctype html>
<html lang="en" class="h-100">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.101.0">
    <title>Sticky Footer Navbar Template · Bootstrap v4.6</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/sticky-footer-navbar/">

    

    <!-- Bootstrap core CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">    



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

	.leading {
	    background: transparent;
	    border: 1px solid rgba(0,0,0,0.25);
	    box-shadow: 0 0 1px rgba(255,255,255,0.25) inset;
	    position: relative;
	    -webkit-transition: box-shadow 350ms;
	    -o-transition: box-shadow 350ms;
	    transition: box-shadow 350ms;
	    margin-bottom: 40px;
	    padding: 32px;
	}
	.article-title {
	    margin: 0 0 10px 0;
	    color: #000000;
	    font-size: 16px;
	}
	.article-asides{
		font-size: 13px;
	}
	.box{
		font-size: 14px;
	}
    </style>

    
    <!-- Custom styles for this template -->
    <link href="/resources/sticky-footer-navbar.css" rel="stylesheet">
  </head>
  <body class="d-flex flex-column h-100">
    
<header>
  <!-- Fixed navbar -->
  <%@include file="/WEB-INF/views/comm/header.jsp" %>
</header>

<!-- Begin page content -->
<main role="main" class="flex-shrink-0">
  <div class="container">
    <section>
    	<div class="row ">
    		<div class="leading col-12">
    			<div class="box box-primary">
					<div class="box-header with-border">
						<h1 class="article-title" id="ntc_title">
							${notice.ntc_title }
						</h1>
					</div>
					
					<!-- Aside -->
					<aside class="article-aside clearfix">
						<input type="hidden" class="form-control" name="ntc_id" id="ntc_id" value="${notice.ntc_id }" readonly>	
						<dl class="article-info  muted">							
							<dd class="createdby hasTooltip">
								<i class="fa fa-user"></i>
								<span >작성자 : 다이렉트 게임즈</span>
							</dd>
							<dd class="category-name hasTooltip">
								<i class="fa fa-folder-open"></i>
								<span>${notice.ntc_cat }</span>
							</dd>
							<dd class="published hasTooltip">
								<i class="fa fa-calendar"></i>
								<span>작성일 : ${notice.ntc_mdfdate }</span>
							</dd>
							<dd class="hits">
								<i class="fa fa-eye"></i>
								<span>조회수 : ${notice.ntc_views }</span>											
							</dd>	
						</dl>
					</aside>  
					<!-- //Aside -->
					
						<div class="clearfix">
								<div class="" name="ntc_content">${notice.ntc_content }</div>
						</div>
					</div>	
					
					
					<div class="box-footer text-right">
					<!-- Modify, Delete,  List 버튼클릭시 아래 form태그를 전송 -->
					<form id="curListInfo" action="" method="get">
						<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
						<input type="hidden" name="amount"  id="amount" value="${cri.amount}" />
						<input type="hidden" name="type" id="type" value="${cri.type}" />
						<input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
						<input type="hidden" name="ntc_id" id="ntc_id" value="${notice.ntc_id }" />
					</form>	
					<button type="button" id="btn_modify" class="btn btn-primary">Modify</button>
					<button type="button" id="btn_delete" class="btn btn-primary">Delete</button>
					<button type="button" id="btn_list" class="btn btn-primary">List</button>
					</div>	
    		</div>	
    	</div>
    </section>
  </div>
</main>

<footer class="footer mt-auto py-3">
  <%@include file="/WEB-INF/views/comm/footer.jsp" %>
</footer>
<%@include file="/WEB-INF/views/comm/plugin.jsp" %>
   
  <script>
	// <form id="curListInfo" action="" method="get">
	let curListInfo = document.getElementById("curListInfo");
	
	// 수정버튼 클릭
	document.getElementById("btn_modify").addEventListener("click", fn_modify);

  	function fn_modify() {

		curListInfo.setAttribute("action", "/board/notice/ntc_modify");
		curListInfo.submit();
  	}

  	//삭제버튼 클릭
  	document.getElementById("btn_delete").addEventListener("click", fn_delete); // 가로는 제외

  	function fn_delete() {

		if(!confirm("삭제 하시겠습니까?")) return;
		//페이지(주소) 이동 
		curListInfo.setAttribute("action", "/board/notice/ntc_delete");
		curListInfo.submit();
  	}

	//리스트 클릭
	document.getElementById("btn_list").addEventListener("click", fn_list); // 가로는 제외

  	function fn_list() {

		curListInfo.setAttribute("action", "/board/notice/ntc_list");
		curListInfo.submit();
  	}
  </script> 
      
  </body>
</html>
    