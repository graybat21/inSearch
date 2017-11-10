<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
ul { list-style-type: none; }
ul li { margin: 0 5px; display: inline;}
</style>
</head>
<body>
	<div>
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
						</label> <input type="password" required autocomplete="off" name="pw" />
					</div>

				
					<ul class="tab-group">
						<li class="tab active"><input type="checkbox" name="autologin">Auto-Login</li>
						<li>/</li>
						<li class="tab active"><a onclick="changepage(0)">Sign Up</a></li>
						<li>/</li>
						<li class="tab"><a onclick="changepage(1)">Forgot Password?</a></li>
					</ul>
					

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
									<option value="10">10 대</option>
									<option value="20">20 대</option>
									<option value="30">30 대</option>
									<option value="40">40 대</option>
									<option value="50">50 대 이상</option>
								</select>
						</div>
					</div>
					
					<ul class="tab-group">
						<li class="tab"><a onclick="changepage(0)">Log In</a></li>
					</ul>
					
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
					
					<ul class="tab-group">
						<li class="tab"><a onclick="changepage(1)">Log In</a></li>
					</ul>
					
					<button type="button" onclick="emailSend()" class="button button-block">Email Send</button>

				</form>

			</div>
		</div>
	</div>
<script>

function changepage(check){
	if(check==0){
		if(document.getElementById("signup").style.display=="none"){		
			document.getElementById("login").style.display="none";
			document.getElementById("signup").style.display="block";
		}else{		
			document.getElementById("login").style.display="block";
			document.getElementById("signup").style.display="none";
		}
	}else{
		if(document.getElementById("forgotPwd").style.display=="none"){
			document.getElementById("login").style.display="none";
			document.getElementById("forgotPwd").style.display="block";
		}else{
			document.getElementById("login").style.display="block";
			document.getElementById("forgotPwd").style.display="none";
		}
	}	
}
function emailCheck() {
	var email_check = document.sign_up.email.value;
	var inputEmailChcek=0;
	for(var i=0;i<email_check.length;i++){
		if(email_check.substring(i,i+1)=='@'){
			inputEmailChcek++;
		}else if(email_check.substring(i,i+1)=='.'){
			inputEmailChcek++;
		}
	}
	var password=document.sign_up.pw.value;
	var gender = document.sign_up.gender.value;
	var age = document.sign_up.agerange.value;
	if(email_check.length<10||inputEmailChcek!=2){
		alert('이메일이 잘못 입력되었습니다.');
	}else if(password.length<6){
		alert('비밀전호를 최소 6자리 이상 입력해야합니다.');
	}else if (gender == 0 || age == 0) {		
		if (gender == 0)
			alert("성별을 선택해주세요");
		else if (age == 0)
			alert("연령대를 선택해주세요");
	} else {
		
		var params = "email=" + email_check;
		$.ajax({
			type : "GET",
			url : "email?"+params,
			dataType : "json",
			error : function(e) {
				alert(e.responseText);
			},
			success : function(data) {
				if (data.msg != "" && data.msg != null) {
					alert(data.msg);
				} else {
					document.sign_up.submit();
				}
			}
		});
	}
}
function login_email() {
	var param = $("form[name=login]").serialize();  	
	var email_id=document.login.email.value;		
	$.ajax({
		type : "post",
		url : "login",
		data : param,
		beforeSend : function(xhr)
        {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        error:function(request,status,error){
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);},
		success : function(data) {
			if (data.msg != "" && data.msg != null) {
				alert(data.msg);
			} else {			
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
			} else {				
				document.forgotPwd.submit();
			}
		}
	});
}

</script>
</body>
</html>