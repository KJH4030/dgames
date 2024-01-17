<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.101.0">
    <title>Pricing example · Bootstrap v4.6</title>    

    

<%@ include file="/WEB-INF/views/comm/plugin2.jsp" %>

<!-- header -->
<%@ include file="/WEB-INF/views/comm/header.jsp" %>
<meta charset="UTF-8">

<style>

      .footer{
      
     	position: absolute;
     	bottom: 0;
      }
      
      label {
      	font-size: 16px;
      }
      
      .box-title{
      
      	margin: 30px 0;
      
      }

</style>

<title>Direct Games</title>
</head>
<body>
	<div class="container">
  <div class="text-center">
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">로그인</h3>
		</div>
    <form role="form" id="loginForm" method="post" action="/member/login" >
      <div class="box-body">
        <div class="form-group row">
            <label for="dgm_id" class="col-2">아이디</label>
            <div class="col-10">
            <input type="text" class="form-control" id="dgm_id" name="dgm_id" placeholder="아이디 입력">
            </div>
        </div>            
        <div class="form-group row">
            <label for="dgm_password" class="col-2">비밀번호</label>
            <div class="col-10">
            <input type="password" class="form-control" id="dgm_password" name="dgm_password" placeholder="비밀번호 입력">
            </div>
        </div>     
      </div>
      
      <div class="box-footer">
      <button type="submit" class="btn btn-primary" id="btnLogin">로그인</button>
      </div>
      </form>
  </div>
	</div>

	<!-- footer -->
  
</div>
<%@include file="/WEB-INF/views/comm/footer.jsp" %>
<%@include file="/WEB-INF/views/comm/plugin.jsp" %>
    <script>
        let msg = '${msg}';
        if(msg != ""){
            alert(msg);
        }
    </script>
</body>
</html>