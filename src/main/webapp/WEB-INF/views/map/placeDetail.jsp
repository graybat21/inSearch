<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>   
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	${storeVo.address} / ${storeVo.lat} / ${storeVo.lng}<br>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="name" id="name" value="${storeVo.name}" />
	<input type="hidden" name="address" id="address" value="${storeVo.address}" />
	<input type="hidden" name="lat" id="lat" value="${storeVo.lat}" />
	<input type="hidden" name="lng" id="lng" value="${storeVo.lng}" />	
	<input type="hidden" name="store_no" id="store_no" value="${storeNo}" />	
	<input type="hidden" name="user_no" id="user_no" value="1" />
	<input type="text" name="comment" id="comment" />
	
	<button type="button" id="submitComment" name="submitComment" title="Submit Comment">한줄평 등록</button>
<script type="text/javascript">
	var header = $("meta[name='_csrf_header']").attr("content");
	var token  = $("meta[name='_csrf']").attr("content");

	$("#submitComment").on("click", function() {
		var user_no =  $("#user_no").val();
    	var comment = $("#comment").val().trim();
    	
    	if ( user_no == '' ) {
    		alert("로그인 후 작성하실 수 있습니다.");
    		return false;
    	}
    	else if ( comment == '' ) {
    		alert("한줄평을 입력해주세요.");
    		return false;
    	}
    	else if ( comment.length > 150 ) {
    		alert("한줄평은 띄어쓰기를 포함하여 최대 150자로 제한됩니다.");
    		return false;
    	}
    	
    	var store_no =  $("#store_no").val();
    	var name =  $("#name").val();
    	var address =  $("#address").val();
    	var lat =  $("#lat").val();
    	var lng =  $("#lng").val();
    	var placeId = '${placeId}';
    	var star = 5;
		
    	if ( store_no == 0 ) {
	    	$.ajax({
	       		type: 'post',
	       		url: '/map/registerStore',
	       		beforeSend: function(xhr){
	   				xhr.setRequestHeader(header, token);
	   		    },
	       		headers: {
	       			"Content-Type" : "application/json",
	       			"X-HTTP-Method-Override" : "POST"
	       		},
	       		dataType: "text",
	       		data: JSON.stringify({name: name, address: address, lat: lat, lng: lng}),
	       		success: function(no) {
	       			console.log("no: " + no);
	       			store_no = no;
	       		},
	       		error: function(request, status, error) {
	       		    alert("code:" + request.status + "\n" + "message:" + request.responseText+ "\n" + "error:" + error);
	       	    }
	       	});
    	}
    	
    	$.ajax({
    		type: 'post',
    		url: '/map/registerComment',
    		beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
		    },
    		headers: {
    			"Content-Type" : "application/json",
    			"X-HTTP-Method-Override" : "POST"
    		},
    		dataType: "text",
    		data: JSON.stringify({store_no: store_no, comment: comment, star: star, user_no, user_no}),
    		success: function(result) {
    			console.log("result: " + result);
    			if ( result == 'SUCCESS' ) {
    				alert("한줄평이 추가되었습니다.");
    				location.href = "/map/placeDetail/" + placeId;
    			}
    			else {
    				alert('해당 상품에 대한 리뷰가 이미 작성되어 있습니다.');
    			}
    		},
    		error: function(request, status, error) {
    		    alert("code:" + request.status + "\n" + "message:" + request.responseText+"\n" + "error:" + error);
    	    }
    	});
	});
</script>