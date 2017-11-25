<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="form">
	<h1>Insearch</h1>
	<div id="update">
		<form name="updateForm" action="update" method="post">	
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />			
			<div class="top-row">
				<div class="field-wrap">
					<input type="email" required autocomplete="off" name="email" value="${loginUser.email}" readonly/>
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
						<select name="gender">
							<option	value="0">선택</option>
							<option value="1"
							<c:out value="${ ( loginUser.gender == 1 ) ? 'selected' : ''}"/>>man</option>
							<option value="2"
							<c:out value="${ ( loginUser.gender == 2 ) ? 'selected' : ''}"/>>woman</option>
						</select> 		
				</div>					
				<div class="field-wrap">			
					<label class="labeloption2">Age </label> 
						<select name="agerange">								
							<option value="0">선택</option>
							<option value="10"
							<c:out value="${ ( loginUser.agerange == 10 ) ? 'selected' : ''}"/>>10대</option>
							<option value="20"
							<c:out value="${ ( loginUser.agerange == 20 ) ? 'selected' : ''}"/>>20대</option>
							<option value="30"
							<c:out value="${ ( loginUser.agerange == 30 ) ? 'selected' : ''}"/>>30대</option>
							<option value="40"
							<c:out value="${ ( loginUser.agerange == 40 ) ? 'selected' : ''}"/>>40대</option>
							<option value="50"
							<c:out value="${ ( loginUser.agerange == 50 ) ? 'selected' : ''}"/>>50대 이상</option>
						</select>
				</div>
			</div>
			
			<div class="field-wrap">
				<ul class="tab-group">
					<li class="tab"><a onclick="changepage()">Delete</a></li>
				</ul>
			</div>
			
			<button type="button" onclick="updateCheck()" class="button button-block">Update</button>
		</form>
	</div>
	<div id="delete" style="display:none;">
		<form name="deleteForm" action="delete" method="post">	
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="email" value="${loginUser.email}" />	
			<div class="field-wrap">
				<label> Set A Password<span class="req">*</span>
				</label> <input type="password" required autocomplete="off" name="pw" />
			</div>
			<div class="field-wrap">
				<ul class="tab-group">
					<li class="tab"><a onclick="changepage()">Update</a></li>
				</ul>
			</div>
			
			<button type="button" onclick="deleteCheck()" class="button button-block">Delete</button>
		</form>
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

function changepage() {
	if ( document.getElementById("update").style.display == "none" ) {		
		document.getElementById("delete").style.display = "none";
		document.getElementById("update").style.display = "block";
	}
	else {		
		document.getElementById("update").style.display = "none";
		document.getElementById("delete").style.display = "block";
	}
}

function passwordTypeCheck(passwordVal, passwordConfirmVal) {
	
	var pwReg = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/g;
	
	if ( passwordVal == '' ) {
		alert("비밀번호를 입력해주세요.");
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

function updateCheck() {
	var email_check = document.updateForm.email.value;
	
	var password = document.updateForm.pw.value;
	var confPassword = document.updateForm.confPw.value;
	var gender = document.updateForm.gender.value;
	var age = document.updateForm.agerange.value;
	
	if ( passwordTypeCheck(password, confPassword) == false ) {
		return;
	}
	else if ( gender == 0 ) {
		alert("성별을 선택해주세요.");
		return;
	}
	else if ( age == 0 ) {
		alert("연령대를 선택해주세요.");
		return;
	} 
	else {
		document.updateForm.submit();
	}
}

function deleteCheck(email) {
	var result = confirm("탈퇴하겠습니까? 탈퇴하면 그동안 작성했던 한줄평이 모두 삭제됩니다.");
	
	if ( result ) {
		document.deleteForm.submit();
	}
}
</script>