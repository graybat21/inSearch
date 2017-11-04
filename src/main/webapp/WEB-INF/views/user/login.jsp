<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<div class="form">		
		<h1>Insearch</h1>
		<div class="tab-content">
			<div id="login">
				<form action="login" method="post" name="login">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="field-wrap">
						<label> Email Address<span class="req">*</span>
						</label> <input type="email" required autocomplete="off" name="email" />
					</div>

					<div class="field-wrap">
						<label> Password<span class="req">*</span>
						</label> <input type="password" required autocomplete="off" name="pw"/>
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
				<form name="sign_up" action="join" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="top-row">
						<div class="field-wrap">
							<label> ID<span class="req">*</span>
							</label> <input type="text" required autocomplete="off" name="id" onmouseup="removeDuplicateResult()"/>
						</div>
						<div class="field-wrap">
							<button type="button" style="margin-up:3%;margin-down:3%;" onclick="isExistUser();">아이디 중복 체크</button><br>
							<font color="red">
								<span id="duplicateResult"></span><br>
							</font>
						</div>
						<div class="field-wrap">
							<label> Set A Password<span class="req">*</span>
							</label> <input type="password" required autocomplete="off" name="pw"/>
						</div>
						<div class="field-wrap">
							<label> Confirm Password<span class="req">*</span>
							</label> <input type="password" required autocomplete="off" name="confirmpw"/>
						</div>
						<div class="field-wrap">
							<label> Email Address<span class="req">*</span>
							</label> <input type="email" required autocomplete="off" name="email"/>
						</div>
						<div class="field-wrap">
						<label class="labeloption2" style="padding-right:10px;">Gender</label>							
							<select name="gender">
								<option value="0">선택</option>
								<option value="1">Man</option>
								<option value=2>Woman</option>
							</select>
						</div>
						<div class="field-wrap">
							<label class="labeloption2" style="padding-right:10px;">Age</label> 
							<select name="agerange">
								<option value="0">선택</option>
								<option value="10">10대</option>
								<option value="20">20대</option>
								<option value="30">30대</option>
								<option value="40">40대</option>
								<option value="50">50대 이상</option>
							</select>													
						</div>
					</div>
					<p class="forgot">
						<ul class="tab-group">
							<li class="tab"><a href="#login">Log In</a></li>							
						</ul>
					</p>
					<button type="button" onclick="registerCheck();" class="button button-block">Get Started</button>
				</form>
			</div>
		</div>
	</div>
<!-- /form -->
<script src="//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js"></script>
<script type="text/javascript">
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

function removeDuplicateResult() {
	$("#duplicateResult").text(""); 
}

function isExistUser()		// use keyup event -> To check id
{
	var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;	
	var header = $("meta[name='_csrf_header']").attr("content");
	var token = $("meta[name='_csrf']").attr("content");
	var id = document.sign_up.id.value;
	
	if ( idReg.test(id) ) {	
		$.ajax({
		  url : "/duplicationCheck",
		  type : "post",
		  contentType : 'application/json; charset=utf-8',
		  data : JSON.stringify({ id : id }),
		  dataType: "json",
		  beforeSend: function(xhr) {
		        xhr.setRequestHeader(header, token);
		    },
		  success : function(data) {
		    if (data) {
		    	$("#duplicateResult").text("이미 해당 아이디로 가입된 회원이 있습니다. 다른 아이디를 입력해주세요."); 
		    } 
		    else {
		    	$("#duplicateResult").text("사용 가능한 아이디입니다."); 
		    }
		  },
		  error : function(error) {
		    alert(error.statusText);  
		  }
		});
	}
	else {
    	$("#duplicateResult").text("아이디는 영문 소문자로 시작하는 6~20자의 영문자 또는 숫자이어야 합니다."); 
	}
}

function registerCheck() {	
	var header = $("meta[name='_csrf_header']").attr("content");
	var token = $("meta[name='_csrf']").attr("content");
	
	var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;		
	var pwReg = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/g;
	var mailReg = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/g;
	
	var id = document.sign_up.id.value;
	var email = document.sign_up.email.value;
	var pw = document.sign_up.pw.value;
	var confirmpw = document.sign_up.confirmpw.value;
	
	var gender = document.sign_up.gender.value;
	var age = document.sign_up.agerange.value;
	
	if ( pw != confirmpw ) {
		alert("비밀번호와 비밀번호 확인이 서로 일치하지 않습니다. 다시 확인해주세요.");
		return false;	
	}
	else if ( $("#duplicateResult").text() != '사용 가능한 아이디입니다.' || id == '' ) {
		alert("아이디 체크를 다시 진행해주세요.");
		return false;
	}
	else if ( !pwReg.test(pw) ) {
		alert("비밀번호는 6~20자의 영문 대소문자, 숫자, 특수문자로 이루어져야 하며, 최소 한개의 숫자 혹은 특수문자가 포함되어야 합니다.");
		return false;
	}
	else if ( !mailReg.test(email) ) {
		alert("올바른 메일주소 형식이 아닙니다. 다시 확인해주세요.");
		return false;
	}
	else if ( gender == 0 || age == 0 ) {
		if ( gender == 0 ) {
			alert("성별을 선택해주세요");
			return false;
		}
		else {
			alert("연령대를 선택해주세요");
			return false;
		}
	}
	else {	
		document.sign_up.submit();					
	}	
}

function login_email(){
	var param= $("form[name=login]").serialize();	
	$.ajax({						
		type : "post",
		url : "login",
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