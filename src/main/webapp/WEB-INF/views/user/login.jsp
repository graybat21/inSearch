<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<div class="form">		
		<h1>Insearch</h1>
		<div class="tab-content">
			<div id="login">
				<form action="login.do" method="post" name="login">
					<div class="field-wrap">
						<label> Email Address<span class="req">*</span>
						</label> <input type="email" required autocomplete="off" name="email" />
					</div>

					<div class="field-wrap">
						<label> Password<span class="req">*</span>
						</label> <input type="password" required autocomplete="off" name="pwd"/>
					</div>

					<p class="forgot">
						<ul class="tab-group">
							<li class="tab active"><a href="#signup">Sign Up</a></li>
							<li>/</li>							
							<li class="tab"><a href="#">Forgot Password?</a></li>
						</ul>
					</p>

					<button type="button" class="button button-block" onclick="login_email()">Log In</button>

				</form>

			</div>

			<div id="signup">
				<form name="sign_up" action="join.do" method="post">

					<div class="top-row">
						<div class="field-wrap">
							<label> Email Address<span class="req">*</span>
							</label> <input type="email" required autocomplete="off" name="email2"/>
						</div>
						<div class="field-wrap">
							<label> Set A Password<span class="req">*</span>
							</label> <input type="password" required autocomplete="off" name="pwd"/>
						</div>
					
						<div class="field-wrap">
						<label class="labeloption2">Sex </label>							
							<select name="gender" style="margin-left:3%;margin-right:27%;"><option value="0">선택</option><option value="1">man</option><option value=2>woman</option></select>
						<label class="labeloption2">Age </label> <select name="agerange"><option value="0">선택</option><option value="10">10 대</option><option value="20">20 대</option><option value="30">30 대</option><option value="40">40 대</option><option value="50">50 대 이상</option></select>													
						</div>
					</div>
					<p class="forgot">
						<ul class="tab-group">
							<li class="tab"><a href="#login">Log In</a></li>							
						</ul>
					</p>
					<button type="button" onclick="emailCheck();" class="button button-block">Get Started</button>

				</form>

			</div>
		</div>
	</div>
<!-- /form -->
<script
	src="//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js"></script>

<script	src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script>
$('.form').find('input, textarea').on('keyup blur focus', function(e) {
	var $this = $(this), label = $this.prev('label');

	if (e.type === 'keyup') {
		if ($this.val() === '') {
			label.removeClass('active highlight');
		} else {
			label.addClass('active highlight');
		}
	} else if (e.type === 'blur') {
		if ($this.val() === '') {
			label.removeClass('active highlight');
		} else {
			label.removeClass('highlight');
		}
	} else if (e.type === 'focus') {

		if ($this.val() === '') {
			label.removeClass('highlight');
		} else if ($this.val() !== '') {
			label.addClass('highlight');
		}
	}

});
$('.tab a').on('click', function(e) {
	e.preventDefault();
	$(this).parent().addClass('active');
	$(this).parent().siblings().removeClass('active');
	target = $(this).attr('href');
	$('.tab-content > div').not(target).hide();
	$(target).fadeIn(600);	
});
function emailCheck(){	
	var gender=document.sign_up.gender.value;
	var age=document.sign_up.agerange.value;
	if(gender==0||age==0){
		if(gender==0)alert("성별을 선택해주세요");
		else if(age==0)alert("연령대를 선택해주세요");
	}else{	
		var email_check=document.sign_up.email1.value;		
		var params="email="+email_check;	
		$.ajax({						
			type : "GET",
			url : "emailCheck.do",
			data : params, 
			error:function (e){
				alert(e.responseText);
			},
			success:function(data){	
				if(data.msg!=""&&data.msg!=null){
					alert(data.msg);
				}else{
					document.sign_up.submit();					
				}
			}
		});
	}	
}
function login_email(){
	var param= $("form[name=login]").serialize();	
	$.ajax({						
		type : "post",
		url : "login.do",
		data : param,		
		error:function (e){
			alert(e.responseText);
		},
		success:function(data){	
			if(data.msg!=""&&data.msg!=null){
				alert(data.msg);
			}else{
				location.href="searchmap.jsp";			
			}
		}
	});
}
</script>
</body>
</html>