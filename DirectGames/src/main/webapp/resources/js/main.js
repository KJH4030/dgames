$(document).ready(function(){

	$(".menu_toggle_btn").click(function(){
		$(".gnb").stop().slideToggle("fast");
	});
});
/*메인이미지 자동롤링*/
old=0;
num=0;
chk=true;

oldd=0;
numm=0;
chkk=true;


function visual(){ //이미지가 롤링되는 함수를 생성
    num++;
    if(num==3){
        num=0;
    }
    $(".mvisual_in .btn_area>span").eq(old).removeClass("active");
	$(".mvisual_in .btn_area>span").eq(num).addClass("active");
	
    $(".visual li").eq(old).stop(true,true).fadeOut(2000);
    $(".visual li").eq(num).stop(true,true).fadeIn(2000,function(){
        old=num;
    });
}
auto=setInterval("visual()",3000);

$(document).ready(function(){
    
    $(".mvisual_in").hover(function(){
        clearInterval(auto);
    },function(){
        auto=setInterval("visual()",3000);
    });
    
    /*하단버튼*/
	$(".mvisual_in .btn_area>span").click(function(){
	
		if(chk){
			chk = false;
			num = $(this).index();	//0,1,2,3..
			
           	$(".mvisual_in .btn_area>span").eq(old).removeClass("active");
			$(this).addClass("active");
			
			$(".visual li").eq(old).stop(true,true).fadeOut(0);
			$(".visual li").eq(num).stop(true,true).fadeIn(function(){
            
                
                old = num;
				chk = true;
			});		
		}
	});
//서브2-1 사진 클릭시 상세 바뀜
    $(".photo li").click(function(){
	
		if(chkk){
			chkk = false;
			numm = $(this).index();	//0,1,2,3..
            $(".photo li").eq(numm).find("a").css({"opacity":"1.0"});
            $(".photo li").eq(oldd).find("a").css({"opacity":"0.6"});
            
			$(".photo li>a").eq(oldd).removeClass("pactive");
			$(this).addClass("pactive");
            
            $(".photo_detail li").eq(oldd).stop(true,true).fadeOut();
			$(".photo_detail li").eq(numm).stop(true,true).fadeIn(function(){
                
                oldd = numm;
				chkk = true; 
                
			});		
		}
	});
    
});