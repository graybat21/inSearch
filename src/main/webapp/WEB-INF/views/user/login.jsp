<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="form">
	<h1>Insearch</h1>
	<div class="tab-content">
		<div id="login">
			<form action="login" method="post" name="login">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 		
				<div class="field-wrap">
					<label> Email Address<span class="req">*</span></label>
					<input type="email" required autocomplete="off" name="email" />
				</div>
				
				<div class="field-wrap">
					<label> Password<span class="req">*</span></label>
					<input type="password" required autocomplete="off" name="pw" />
				</div>
				
				<div class="field-wrap">
					<ul class="tab-group">
						<li class="tab active">
							<input type="checkbox" name="autologin">&nbsp;Auto-Login</li>
						<li>/</li>
						<li class="tab active"><a onclick="changepage(0)">Sign Up</a></li>
						<li>/</li>
						<li class="tab"><a onclick="changepage(1)">Forgot Password?</a></li>
					</ul>
				</div>

				<button type="button" class="button button-block"
					onclick="login_email()">Log In</button>
			</form>
		</div>

		<div id="signup" style="display:none;">
			<form name="sign_up" action="join" method="post">	
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />			
				<div class="top-row">
					<div class="field-wrap">
						<label> Email Address<span class="req">*</span>
						</label> <input type="email" required autocomplete="off" name="email" />
					</div>
					<div class="field-wrap">
						<label> Set A Password<span class="req">*</span>
						</label> <input type="password" required autocomplete="off" name="pw" />
					</div>
					
					<div class="field-wrap">
						<label> Set A Confirm Password<span class="req">*</span>
						</label> <input type="password" required autocomplete="off" name="confPw" />
					</div>

					<div class="field-wrap">
						<label class="labeloption2">Gender </label> 
							<select name="gender" >
								<option	value="0">선택</option>
								<option value="1">man</option>
								<option value=2>woman</option>
							</select> 		
					</div>					
					<div class="field-wrap">			
						<label class="labeloption2">Age </label> 
							<select name="agerange" >								
								<option value="0">선택</option>
								<option value="10">10대</option>
								<option value="20">20대</option>
								<option value="30">30대</option>
								<option value="40">40대</option>
								<option value="50">50대 이상</option>
							</select>
					</div>
				</div>
				
				<div class="field-wrap">
					<ul class="tab-group">
						<li class="tab"><a onclick="changepage(0)">Log In</a></li>
					</ul>
				</div>
				
				<button type="button" onclick="emailCheck()" class="button button-block">Get Started</button>

			</form>

		</div>
		
		<div id="forgotPwd" style="display:none;">
			<form name="forgotPwd" action="pwChange" method="get">	
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />		
				<div class="top-row">
					<div class="field-wrap">
						<label> Email Address<span class="req">*</span>
						</label> <input type="email" required autocomplete="off" name="email" />
					</div>					
				</div>
				
				<div class="field-wrap">
					<ul class="tab-group">
						<li class="tab"><a onclick="changepage(1)">Log In</a></li>
					</ul>
				</div>
				
				<button type="button" onclick="emailSend()" class="button button-block">Email Send</button>

			</form>

		</div>
	</div>
</div>
<script src="http://production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js"></script>
<script type="text/javascript">

var header = $("meta[name='_csrf_header']").attr("content");
var token = $("meta[name='_csrf']").attr("content");

$('.form').find('input, textarea').on('keyup blur focus', function(e) {
	var $this = $(this), label = $this.prev('label');
	
	if ( e.type === 'keyup' ) {
		if ( $this.val() === '' ) {
			label.removeClass('active highlight');
		} 
		else {
			label.addClass('active highlight');
		}
	} 
	else if ( e.type === 'blur' ) {
		if ( $this.val() === '' ) {
			label.removeClass('active highlight');
		} 
		else {
			label.removeClass('highlight');
		}
	} 
	else if ( e.type === 'focus' ) {
		if ( $this.val() === '' ) {
			label.removeClass('highlight');
		} 
		else if ( $this.val() !== '' ) {
			label.addClass('highlight');
		}
	}
});

function changepage(check) {
	if ( check == 0 ) {
		if ( document.getElementById("signup").style.display == "none" ) {		
			document.getElementById("login").style.display = "none";
			document.getElementById("signup").style.display = "block";
		}
		else {		
			document.getElementById("login").style.display = "block";
			document.getElementById("signup").style.display = "none";
		}
	}
	else {
		if ( document.getElementById("forgotPwd").style.display == "none") {
			document.getElementById("login").style.display = "none";
			document.getElementById("forgotPwd").style.display = "block";
		}
		else{
			document.getElementById("login").style.display = "block";
			document.getElementById("forgotPwd").style.display = "none";
		}
	}	
}

function emailTypeCheck(emailAddr) {
	
	var mailReg = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/g;
	
	if ( emailAddr == '' ) {
		alert("이메일을 입력해주세요.");
		return false;
	}
	else if ( !mailReg.test(emailAddr) ) {
		alert('이메일 형식이 잘못 입력되었습니다. 올바르게 다시 입력해주세요.');
		return false;
	}
	
	return true;
}

function passwordTypeCheck(passwordVal, passwordConfirmVal) {
	
	var pwReg = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/g;
	
	if ( passwordVal == '' ) {
		alert("비밀번호을 입력해주세요.");
		return false;
	}
	else if ( passwordConfirmVal == '' ) {
		alert("비밀번호 확인을 입력해주세요.");
		return false;
	}
	else if ( passwordVal != passwordConfirmVal ) {
		alert("비밀번호와 비밀번호 확인이 서로 일치하지 않습니다. 다시 확인해주세요.");
		return false;	
	}
	else if ( !pwReg.test(passwordVal) ) {
		alert("비밀번호는 6~20자의 영문 대소문자, 숫자, 특수문자로 이루어져야 하며, 최소 한개의 숫자 혹은 특수문자가 포함되어야 합니다.");
		return false;
	}
	
	return true;
}

function emailCheck() {
	var email_check = document.sign_up.email.value;
	
	var password = document.sign_up.pw.value;
	var confPassword = document.sign_up.confPw.value;
	var gender = document.sign_up.gender.value;
	var age = document.sign_up.agerange.value;
	
	if ( emailTypeCheck(email_check) == false ) {
		return;
	}
	else if ( passwordTypeCheck(password, confPassword) == false ) {
		return;
	}
	else if ( gender == 0 ) {
		alert("성별을 선택해주세요");
		return;
	}
	else if ( age == 0 ) {
		alert("연령대를 선택해주세요");
		return;
	} 
	else {
		$.ajax({
			type : "POST",
			url : "email",
			dataType : "json",
			contentType : "application/json; charset=UTF-8",
			beforeSend: function(xhr){
		        xhr.setRequestHeader(header, token);
		    },
			data : JSON.stringify({ email : email_check }),
			success : function(data) {
				if ( data.msg != "" && data.msg != null ) {
					alert(data.msg);
				} 
				else {
					document.sign_up.submit();
				}
			},
			error : function(e) {
				alert(e.responseText);
			}
		});
	}
}

function login_email() {
	var param = $("form[name=login]").serialize();  	
	var email_id = document.login.email.value;	
	
	if ( emailTypeCheck(email_id) == false ) {
		return;
	}
	
	$.ajax({
		type : "post",
		url : "login",
		data : param,
		beforeSend : function(xhr) {   // 데이터를 전송하기 전에 헤더에 csrf값을 설정한다.
            xhr.setRequestHeader(header, token);
        },
        error : function(request, status, error) {
            alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n"
            		+ "error: " + error);
        },
		success : function(data) {
			if (data.msg != "" && data.msg != null) {
				alert(data.msg);
			} 
			else {			
				location.href = "searchmap";
			}
		}
	});
}

function emailSend(){
	var email_check = document.forgotPwd.email.value;
	var params = "email=" + email_check;
	
	$.ajax({
		type : "GET",
		url : "pwChange_emailCheck?"+params,
		dataType : "json",
		error : function(e) {
			alert(e.responseText);
		},
		success : function(data) {
			if (data.msg != "" && data.msg != null) {
				alert(data.msg);
			}
			else {				
				document.forgotPwd.submit();
			}
		}
	});
}
</script>