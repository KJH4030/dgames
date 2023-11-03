<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimun-scale=1.0, user-scalable=no">
<title>다이렉트게임즈</title>
<link rel="stylesheet" href="/resources/css/main.css">
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
                <input type="image" class="image" src="/resources/image/search_icon3.png" alt="검색">
            </div>
            <div class="logo">
                <h1><a href="#"><img src="/resources/image/dg_logo.png" alt="directgames"></a></h1>
            </div>
            
            <div class="util">
                <a href="/member/login"><img src="/resources/image/login.png" alt="로그인"></a>
                <a href="/member/logout"><img src="/resources/image/logout.png" alt="로그아웃"></a>
                <a href="/member/regist"><img src="/resources/image/regist.png" alt="회원가입"></a>
                <a href="#"><img src="/resources/image/cart.png" alt="장바구니"></a>
            </div>
            <span class="menu_toggle_btn">전체 메뉴 토글 버튼</span>
            
            <nav class="nav">
                <ul class="gnb clear">
                    <li><a href="#">SERVICE</a></li>
                    <li><a href="#">GAME</a></li>
                    <li><a href="#">SUPPORT</a></li>
                    <li><a href="#">EVENT</a></li>
                    <li><a href="#">PROMOTION</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <nav class="nav2">
        <ul class="gnb2 clear">
            <li><a href="#">SERVICE</a></li>
            <li><a href="#">GAME</a></li>
            <li><a href="#">SUPPORT</a></li>
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
                    <li><a href="#"><div class="text">워해머 40,000: 던오브워 3 한글판.</div></a></li>
                    <li><a href="#"><div class="text">스나이퍼 고스트 워리어 3 한글판</div></a></li>
                    <li><a href="#"><div class="text">Bandai Namco 퍼블리셔 프로모션</div></a></li>
                    <li><a href="#"><div class="text">디즈니 애프터눈 컬렉션 판매 안내</div></a></li>
                    <li><a href="#"><div class="text">UBISOFT 퍼블리셔의 프로모션</div></a></li>
                </ul>
            </div>
        </div>        
    </section>
    <section class="promo">
        <h2>프로모션</h2>
        <a href="#"><img src="/resources/image/promotion.png" alt="유비소프트 프로모션"></a>
    </section>
    
    <section class="banner clear">
        <h2>최신게임</h2>
        <div class="banner_in">
            <a href="#"><img src="/resources/image/mban_1.png" alt="사이베리아 스탠다드"></a>
            <a href="#"><img src="/resources/image/mban_2.png" alt="사이베리아 디럭스"></a>
            <a href="#"><img src="/resources/image/mban_3.png" alt="유로파 유니버셜리스"></a>
        </div>
        
        <h2>인기게임</h2>
        <div class="banner_in">
            <a href="#"><img src="/resources/image/mban_4.png" alt="문명 6"></a>
            <a href="#"><img src="/resources/image/mban_5.png" alt="문명 6 디럭스"></a>
            <a href="#"><img src="/resources/image/mban_6.png" alt="다크소울 3"></a>
        </div>
    </section>
    
    <div id="top_btn">
        <a href="#" class="go"><img src="/resources/image/top_btn.png"></a>
    </div>
</div>
    
    <footer class="footer">
        <div class="copyright">
            <p>DIRECT GAMES</p>
            <p>서울특별시 강서구 가양동 1498 강서한강자이타워 A동 605호</p>
            <p>(주)에이치투 인터렉티브</p>
            <p>Copyright &copy; All Right Reserved.</p>
        </div>
        <div class="copyright2">
            <p>DIRECT GAMES | 소재지 : 서울특별시 강서구 가양동 1498 강서한강자이타워 A동 605호 (주)에이치투 인터렉티브 | 대표이사 : 허준하 | 개인정보관리책임자 : 김지훈<br>
            사업자등록번호 : 206-86-35756 | 통신판매업신고 : 2013-서울강서-0758 | 고객센터 : 02-6968-5550 | 전자우편 : directg@h2interactive.co.kr<br>
            Copyright © DIRECT GAMES. All Rights Reserved.</p>
        </div>
    </footer>

    
    
<!-- 제이쿼리 라이브러리 선언 -->
<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.1.0.min.js"/>"></script>
<script src="/resources/js/main.js"></script>
</body>
</html>