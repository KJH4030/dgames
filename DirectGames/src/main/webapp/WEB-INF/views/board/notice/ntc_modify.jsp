<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

      .footer{
      
     	position: absolute;
     	bottom: 0;
      }
    </style>

    
    <!-- Custom styles for this template -->
    <link href="/resources/sticky-footer-navbar.css" rel="stylesheet">
  </head>
  <body class="d-flex flex-column h-100">
    
<header>
  <!-- Fixed navbar -->
<%@include file="/WEB-INF/views/comm/plugin2.jsp" %>
  <%@include file="/WEB-INF/views/comm/header.jsp" %>
</header>

<!-- Begin page content -->
<main role="main" class="flex-shrink-0">
  <div class="container">
    <section>
    	<div class="row">
    		<div class="col-md-12">
    			<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title mt-5">글쓰기</h3>
					</div>
					<!-- 절대경로 /board/register -->
					<form role="form" method="post" action="/board/notice/ntc_modify">
					
						<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
						<input type="hidden" name="amount"  id="amount" value="${cri.amount}" />
						<input type="hidden" name="type" id="type" value="${cri.type}" />
						<input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
						<input type="hidden" name="ntc_id" id="ntc_id" value="${notice.ntc_id }" />						
						<div class="box-body">
							<div class="form-group">
								<label for="ntc_title">제목</label>
								<input type="text" class="form-control" name="ntc_title" id="ntc_title" placeholder="제목 입력..." value="${notice.ntc_title }">
							</div>
						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="3" name="ntc_content" id="ntc_content" placeholder="내용입력...." >${notice.ntc_content }</textarea>
						</div>
						</div>
						
						<div class="box-footer">
						<button type="submit" class="btn btn-primary">저장</button>
						<button type="reset" class="btn btn-primary" id="btn_reset">취소</button>
						</div>
					</form>
				</div>
    		</div>
    	</div>
    </section>
  </div>
</main>

  <%@include file="/WEB-INF/views/comm/footer.jsp" %>
<%@include file="/WEB-INF/views/comm/plugin.jsp" %>
     <script src="/resources/ckeditor/ckeditor.js"></script>      
<script>
	$(document).ready(function(){

		// ckeditor 환경설정. 자바스크립트 Ojbect문법
	    var ckeditor_config = {
	         resize_enabled : false,
	         enterMode : CKEDITOR.ENTER_BR,
	         shiftEnterMode : CKEDITOR.ENTER_P,
	         toolbarCanCollapse : true,
	         removePlugins : "elementspath", 
	         //업로드 탭기능추가 속성. CKEditor에서 파일업로드해서 서버로 전송클릭하면 , 이 주소가 동작된다.
	         filebrowserUploadUrl: '/board/notice/ntc_imageUpload'
		}

		CKEDITOR.replace("ntc_content", ckeditor_config);

		console.log("ckeditor 버전 : ", CKEDITOR.version);
		
		//취소시 뒤로가기
		$("#btn_reset").on("click", function(){
			history.back();
		});
		
	});
</script>
  </body>
</html>
    