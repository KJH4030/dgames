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
  <title>AdminLTE 2 | Starter</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
  <%@include file="/WEB-INF/views/admin/include/plugin1.jsp" %>
  
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
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <%@ include file="/WEB-INF/views/admin/include/header.jsp" %>
  <!-- Left side column. contains the logo and sidebar -->
  <%@ include file="/WEB-INF/views/admin/include/nav.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Page Header
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

      <div class="row">
    		<div class="col-md-12">
    			<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title mt-5">Product View</h3>
						<form id="actionForm" action="" method="get">
							<input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
							<input type="hidden" name="amount"  id="amount" value="${cri.amount}" />
							<input type="hidden" name="type" id="type" value="${cri.type}" />
							<input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
						</form>
					</div>
					<!-- 절대경로 /board/register -->
					<form role="form" method="post" action="/admin/game/game_edit" enctype="multipart/form-data">
		              <div class="col-sm-3">
		                <input type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
						<input type="hidden" name="amount"  id="amount" value="${cri.amount}" />
						<input type="hidden" name="type" id="type" value="${cri.type}" />
						<input type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
		              	<input type="hidden" name="game_id" value="${gameVO.game_id }">
		              </div>						
						<div class="box-body">
						<div class="form-group row">
							<label for="game_title" class="col-sm-2">게임명</label>
							<div class="col-sm-4">
							    <input type="text" class="form-control" name="game_title" id="game_title" value="${gameVO.game_title }">
							</div>
							<label for="game_price" class="col-sm-2">게임 가격</label>
							<div class="col-sm-4">
								<input type="text" class="form-control" name="game_price" id="game_price" value="${gameVO.game_price }">
							</div>
							
						</div>
						<div class="form-group row">
							<label for="game_discount" class="col-sm-2">할인율</label>
							<div class="col-sm-4">
							    <input type="text" class="form-control" name="game_discount" id="game_discount" value="${gameVO.game_discount }">
							</div>
							<label for="genre_code" class="col-sm-2">장르</label>							
							<div class="col-sm-4">
							    <select class="form-control" id="genre_code" name="genre_code">
							      <option>장르 선택</option>
							      <c:forEach items="${getGenre }" var="genreVO">
							      	<option value="${genreVO.genre_code }"  ${genreVO.genre_code == gameVO.genre_code? 'selected':'' }>${genreVO.genre_name }</option>
							      </c:forEach>							      
							    </select>
							</div>			
						</div>
						<div class="form-group row">
							<label for="platform_code" class="col-sm-2">플랫폼</label>							
							<div class="col-sm-4">
							    <select class="form-control" id="platform_code" name="platform_code">
							      <option>플랫폼 선택</option>
							      <c:forEach items="${getPlatform }" var="platformVO">
							      	<option value="${platformVO.platform_code }"  ${platformVO.platform_code == gameVO.platform_code? 'selected':'' }>${platformVO.platform_name }</option>
							      </c:forEach>							      
							    </select>
							</div>	
							<label for="publisher_code" class="col-sm-2">퍼블리셔</label>							
							<div class="col-sm-4">
							    <select class="form-control" id="publisher_code" name="publisher_code">
							      <option>퍼블리셔 선택</option>
							      <c:forEach items="${getPublisher }" var="publisherVO">
							      	<option value="${publisherVO.publisher_code }" ${publisherVO.publisher_code == gameVO.publisher_code? 'selected':''} >${publisherVO.publisher_name }</option>
							      </c:forEach>							      
							    </select>
							</div>							
						</div>
						<div class="form-group row">
							<label for="title" class="col-sm-2">상품 이미지</label>
							<div class="col-sm-4">
							    <input type="file" class="form-control" name="uploadFile" id="uploadFile">
				                <input type="hidden" name="img_up_folder" value="${gameVO.img_up_folder }">
				                <input type="hidden" name="game_img" value="${gameVO.game_img }">
							</div>
							<label for="title" class="col-sm-2">미리보기 이미지</label>
							<div class="col-sm-4">
								<img id="img_preview" src="/admin/game/imageDisplay?dateFolderName=${gameVO.img_up_folder }&fileName=${gameVO.game_img }" style="width:320px;height:150px;">
							</div>							
						</div>
						<div class="form-group row">
							<label for="game_description" class="col-sm-2">게임 설명</label>
							<div class="col-sm-10">
							    <textarea name="game_description" id="game_description" class="form-control" rows="3">${gameVO.game_description }</textarea>
							</div>
						</div>
						<div class="form-group row">
							<label for="game_language" class="col-sm-2">지원 언어</label>
							<div class="col-sm-4">
							    <select class="form-control" id="game_language" name="game_language">
							    	<option value="korean" ${gameVO.game_language == '한국어'? 'selected':'' }>한국어</option>
							    	<option value="english" ${gameVO.game_language == '영어'? 'selected':'' }>영어</option>
							    </select>
							</div>
							<label for="game_status" class="col-sm-2">판매여부</label>
							<div class="col-sm-4">
							    <select class="form-control" id="game_status" name="game_status">
							      <option value="Y" ${gameVO.game_status == 'Y'? 'selected':'' }>판매가능</option>
							      <option value="N" ${gameVO.game_status == 'N'? 'selected':'' }>판매불가</option>
							    </select>								
							</div>							
						</div>
						</div>
					  <div class="box-footer">
							<div class="form-group">
								<ul class="uploadedList"></ul>
							</div>
							<div class="text-center">
								<button type="submit" class="btn btn-primary">상품수정</button>
								<button type="reset" class="btn btn-primary">취소</button>
							</div>
					 </div>
					</form>
				</div>
    		</div>
    	</div>

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <%@include file="/WEB-INF/views/admin/include/footer.jsp" %>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<%@include file="/WEB-INF/views/admin/include/plugin2.jsp" %>
<script src="/bower_components/ckeditor/ckeditor.js"></script>
<script>
  $(document).ready(function() {

    // ckeditor 환경설정. 자바스크립트 Ojbect문법
    var ckeditor_config = {
			resize_enabled : false,
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			toolbarCanCollapse : true,
			removePlugins : "elementspath", 
			//업로드 탭기능추가 속성. CKEditor에서 파일업로드해서 서버로 전송클릭하면 , 이 주소가 동작된다.
			filebrowserUploadUrl: '/admin/game/imageUpload' 
    }

    CKEDITOR.replace("game_description", ckeditor_config);

    console.log("ckediotr 버전: ", CKEDITOR.version);

    //파일첨부시 이미지 미리보기
    // 파일첨부에 따른 이벤트관련정보를 e라는 매개변수를 통하여, 참조가 됨.
    $("#uploadFile").change(function(e) {
      let file = e.target.files[0]; // 선택파일들중 첫번째 파일.

      let reader = new FileReader(); // 첨부된 파일을 이용하여, File객체를 생성하는 용도
      reader.readAsDataURL(file); // reader객체에 파일정보가 할당.


      reader.onload = function(e) {
        // <img id="img_preview" style="width:200px;height:200px;">
        // e.target.result : reader객체의 이미지파일정보
        $("#img_preview").attr("src", e.target.result);
      }
      
    });

  });
</script>
</body>
</html>