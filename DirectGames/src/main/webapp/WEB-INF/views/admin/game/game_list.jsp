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
    			<div class="box">
					<div class="box-header with-border">
					<h3 class="box-title">Product List</h3>
					</div>

					<div class="box-body">
						<div>
							<form action="/admin/game/game_list" method="get" >
									<select name="type">
										<option selected>검색종류선택</option>
										<option value="N" ${pageMaker.cri.type == 'N'? 'selected': ''}>게임명</option>
										<option value="C" ${pageMaker.cri.type == 'C'? 'selected': ''}>게임코드</option>
									</select>
									<input type="text" name="keyword" value="${pageMaker.cri.keyword}" />
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
									<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
									<button type="submit" class="btn btn-primary">검색</button>
							</form>
						</div>
						<table class="table table-bordered">
							<tbody><tr>
							    <th style="width: 2%"><input type="checkbox" id="checkAll"></th>
								<th style="width: 10%">게임코드</th>
								<th style="width: 40%">게임명</th>
								<th style="width: 10%">가격</th>
								<th style="width: 10%">등록일</th>
								<th style="width: 5%">판매여부</th>
								<th style="width: 5%">수정</th>
								<th style="width: 5%">삭제</th>
							</tr>
							<c:forEach items="${game_list }" var="gameVO">
							<tr>
								<td><input type="checkbox" name="check" value="${gameVO.game_id }"></td>
								<td>${gameVO.game_id }</td>
								<td>
									<a class="move" href="#" data-bno="${gameVO.game_id }"><img src="/admin/game/imageDisplay?dateFolderName=${gameVO.img_up_folder }&fileName=s_${gameVO.game_img }"></a>
									<a class="move game_title" href="#" data-bno="${gameVO.game_id }">${gameVO.game_title }</a>
								</td>
								<td><input type="text" name="game_price" value="${gameVO.game_price }"></td>
								<td><fmt:formatDate value="${gameVO.release_date }" pattern="yyyy-MM-dd" /></td>
								<td>
									<select id="game_status" name="game_status">
										<option value="Y" ${gameVO.game_status == 'Y'? 'selected':''} >판매가능</option>
										<option value="N" ${gameVO.game_status == 'N'? 'selected':''}>판매불가능</option>
									</select>
								</td>
								<td><button type="button" class="btn btn-primary" name="btn_game_edit">수정</button></td>
								<td><button type="button" class="btn btn-danger btn_game_del">삭제</button></td>
							</tr>
							</c:forEach>
							</tbody></table>
					</div>
					<div class="box-footer clearfix">
						<div class="row">
							<div class="col-md-4">
								<button type="button" class="btn btn-primary" id="btn_check_modify1" role="button">체크상품수정1</button>	
                <button type="button" class="btn btn-primary" id="btn_check_modify2" role="button">체크상품수정2</button>	
							<!--1)페이지번호 클릭할 때 사용  [이전]  1	2	3	4	5 [다음]  -->
							<!--2)목록에서 상품이미지 또는 상품명 클릭할 때 사용   -->
							  <form id="actionForm" action="" method="get">
								<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cri.pageNum}" />
								<input type="hidden" name="amount"  id="amount" value="${pageMaker.cri.amount}" />
								<input type="hidden" name="type" id="type" value="${pageMaker.cri.type}" />
								<input type="hidden" name="keyword" id="keyword" value="${pageMaker.cri.keyword}" />
								
							  </form>
							</div>
							<div class="col-md-6 text-center">
								<nav aria-label="...">
								<ul class="pagination">
									<!-- 이전 표시여부 -->
									<c:if test="${pageMaker.prev }">
										<li class="page-item">
											<a href="${pageMaker.startPage - 1 }" class="page-link movepage">Previous</a>
										</li>
									</c:if>
									<!-- 페이지번호 출력 -->
									<!-- 1	2	3	4	5   6	7	8	9	10  [다음] -->
									<!-- [이전] 11   12	13	14	15  16	17	18	19	20   -->
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
							<div class="col-md-2 text-right"><button type="button" class="btn btn-primary" id="btn_game_insert" role="button">상품등록</button></div>
						</div>
						
					</div>
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

<script>
  $(document).ready(function() {

    let actionForm = $("#actionForm"); //전역변수

    // [이전] 1 2 3 4 5 [다음] 클릭 이벤트 설정. <a>태그 <a class="movepage" href="5">5</a>
    $(".movepage").on("click", function(e) {
      e.preventDefault(); // a태그의 href 링크기능을 제거. href속성에 페이지번호를 숨겨둠.

      actionForm.attr("action", "/admin/game/game_list");
      actionForm.find("input[name='pageNum']").val($(this).attr("href"));

      actionForm.submit();
    });
    
    // 목록에서 제목행 체크박스 선택
    let isCheck = true;
    $("#checkAll").on("click", function() {
      $("input[name='check']").prop("checked", this.checked);
      isCheck = this.checked;
    });

    // 목록에서 데이터행 체크박스 선택
    $("input[name='check']").on("click", function() {
      //제목행 체크상태 변경
      $("#checkAll").prop("checked", this.checked);

      //데이터 행의 체크박스 상태를 확인해서 제목행 체크상태 변경
      $("input[name='check']").each(function() {
        if(!$(this).is(":checked")) {
          $("#checkAll").prop("checked", false);
        }
      });
    });

    //체크박스수정1 버튼 클릭
    $("#btn_check_modify1").on("click", function(){
      // 체크박스 유무확인
      if($("input[name='check']:checked").length == 0) {
        alert("수정할 상품을 체크하세요.");
        return;
      }

      // 배열문법
      let game_id_arr = []; // 체크된 상품코드 배열
      let game_price_arr = []; // 체크된 상품가격 배열
      let game_status_arr = []; // 체크된 상품진열 배열

      //데이터행에서 체크된 체크박스 선택자
      $("input[name='check']:checked").each(function() {
        game_id_arr.push($(this).val());
        game_price_arr.push($(this).parent().parent().find("input[name='game_price']").val());
        game_status_arr.push($(this).parent().parent().find("select[name='game_status']").val());
      });

      console.log("상품코드", game_id_arr);
      console.log("상품가격", game_price_arr );
      console.log("상품진열",game_status_arr );

      $.ajax({
      url: '/admin/game/game_checked_modify1',
      type: 'post',
      data: {game_id_arr: game_id_arr, game_price_arr: game_price_arr, game_status_arr: game_status_arr},
      dataType: 'text',
      success: function(result) {
        if(result == "success") {
          alert("체크상품이 수정되었습니다.");

          //db에서 다시 불러오는 작업.
          //1) location.href = "/admin/game/game_list";
          //2) 현재 리스트 상태로 불러오는 의미.
          /* 
          actionForm.attr("method", "get");
          actionForm.attr("action", "/admin/game/game_list");
          actionForm.submit();
          */
        }
      }
     });
    }); 

    //체크박스수정2 버튼 클릭
    $("#btn_check_modify2").on("click", function(){
      // 체크박스 유무확인
      if($("input[name='check']:checked").length == 0) {
        alert("수정할 상품을 체크하세요.");
        return;
      }

      // 배열문법
      let game_id_arr = []; // 체크된 상품코드 배열
      let game_price_arr = []; // 체크된 상품가격 배열
      let game_status_arr = []; // 체크된 상품진열 배열

      //데이터행에서 체크된 체크박스 선택자
      $("input[name='check']:checked").each(function() {
        game_id_arr.push($(this).val());
        game_price_arr.push($(this).parent().parent().find("input[name='game_price']").val());
        game_status_arr.push($(this).parent().parent().find("select[name='game_status']").val());
      });

      console.log("상품코드", game_id_arr);
      console.log("상품가격", game_price_arr );
      console.log("상품진열",game_status_arr );

      $.ajax({
      url: '/admin/game/game_checked_modify2',
      type: 'post',
      data: {game_id_arr: game_id_arr, game_price_arr: game_price_arr, game_status_arr: game_status_arr},
      dataType: 'text',
      success: function(result) {
        if(result == "success") {
          alert("체크상품이 수정되었습니다.");

          //db에서 다시 불러오는 작업.
          //1) location.href = "/admin/product/pro_list";
          //2) 현재 리스트 상태로 불러오는 의미.
          /* 
          actionForm.attr("method", "get");
          actionForm.attr("action", "/admin/product/pro_list");
          actionForm.submit();
          */
        }
      }
     });
    }); 
   
  
  //상품등록
  $("#btn_game_insert").on("click", function() {
    location.href = "/admin/game/game_insert";
  });
    
  //상품수정
  $("button[name='btn_game_edit']").on("click", function() {
    
    //수정 상품코드
    //체크박스에 숨겨둔 상품코드
    let game_id = $(this).parent().parent().find("input[name='check']").val();

    console.log(game_id);
    //뒤로가기 클릭후 다시 수정버튼 클릭시 코드 중복되는 부분때문에 제거.
    actionForm.find("input[name='game_id']").remove();

    // <input type="hidden" name="game_id" id="game_id" value="24" />
    actionForm.append('<input type="hidden" name="game_id" id="game_id" value="' + game_id + '" />');
    
    actionForm.attr("method", "get");
    actionForm.attr("action", "/admin/game/game_edit");
    actionForm.submit();
    

  });

  //상품삭제.  화살표함수 사용시 상품코드값을 읽을수 없다.
  $(".btn_game_del").on("click", function() {
    
    // text(): 입력양식태그가 아닌 일반태그의 값을 변경하거나 읽을 때 사용 
    let game_title = $(this).parent().parent().find(".game_title").text();
    if(!confirm(game_title + " 상품을 삭제하겠습니까?")) return;

    // val() : input, select, textarea태그의 값을 변경하거나 읽을 때 사용    
    let game_id = $(this).parent().parent().find("input[name='check']").val();
    
    console.log("상품코드", game_id);

    actionForm.find("input[name='game_id']").remove();

    // <input type="hidden" name="game_id" id="game_id" value="24" />
    actionForm.append('<input type="hidden" name="game_id" id="game_id" value="' + game_id + '" />');
    
    actionForm.attr("method", "post");
    actionForm.attr("action", "/admin/game/game_delete");
    actionForm.submit();


  });



}); // ready 이벤트
</script>
</body>
</html>
