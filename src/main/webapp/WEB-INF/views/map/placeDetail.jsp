<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>   
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link href="${myContextPath}/css/map_css.css" rel="stylesheet" type="text/css" />

	<div id="r" class="field-wrap">
		<ul>
			<li>${storeVo.name}</li>
			<li>${storeVo.address}</li>
		</ul>
	</div>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="name" id="name" value="${storeVo.name}" />
	<input type="hidden" name="address" id="address" value="${storeVo.address}" />
	<input type="hidden" name="lat" id="lat" value="${storeVo.lat}" />
	<input type="hidden" name="lng" id="lng" value="${storeVo.lng}" />	
	<input type="hidden" name="store_no" id="store_no" value="${storeNo}" />	
	<input type="hidden" name="user_no" id="user_no" value="${userNo}" />
	<input type="hidden" id="star" value="3"/>
	
	<div id="commentCount">

	</div>
	
	<div class="field-wrap">
		<input type="text" name="comment" id="comment" placeholder="한줄평을 입력해주세요(최대 150자까지 가능)." />
	</div>
	<div class="field-wrap">
		<div id="starMap"></div>
	</div>
	
	<button type="button" id="submitComment" name="submitComment" title="Submit Comment">한줄평 등록</button>

	<div id="block-commentList">
		<div class="comment-box">
		
		</div>
	</div>
	<div class="pages pagination">
			
	</div>

<script id="template" type="text/x-handlebars-template">
{{#each this}}
<div class="block-comment box">
	<p style="text-align:left"><div id="star-{{this.star}}"></div></p>
	<p style="text-align:left">{{this.comment}}</p>
	<p style="text-align:right">작성자 : {{this.email}}****</p>
	<p style="text-align:right">작성일 : {{prettifyDate this.createdate}}</p>
</div>
{{else}}
<div class="block-content box">
	<p style="text-align:center">작성된 리뷰가 없습니다.</p>
</div>
{{/each}}
</script>
<script type="text/javascript">
var header = $("meta[name='_csrf_header']").attr("content");
var token  = $("meta[name='_csrf']").attr("content");
var placeId = '${placeId}';

var store_no = $("#store_no").val();

function registerComment(store_no, comment, star, user_no) {
	$.ajax({
		type: 'post',
		url: '/comment/registerComment',
		beforeSend: function(xhr){
			xhr.setRequestHeader(header, token);
	    },
		headers: {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType: "text",
		data: JSON.stringify({store_no: store_no, comment: comment, star: star, user_no: user_no}),
		success: function(result) {
			console.log("result: " + result);
			if ( result == 'SUCCESS' ) {
				alert("한줄평이 추가되었습니다.");
				location.href = "/map/placeDetail/" + placeId;
			}
			else {
				alert('해당 장소에 대한 한줄평이 이미 작성되어 있습니다.');
			}
		},
		error: function(request, status, error) {
		    alert("code:" + request.status + "\n" + "message:" + request.responseText+"\n" + "error:" + error);
	    }
	});
}

var printData = function (commentArr, target, templateObject) {
	var template = Handlebars.compile(templateObject.html());
	
	var html = template(commentArr);
	$(".block-comment").remove();
	target.after(html);
};

function getPage(pageInfo) {
	$.getJSON(pageInfo, function(data) {
		printData(data.commentList, $("#block-commentList"), $("#template"));
		
		for ( var i = 1; i <= 5; i++ ) {
			$('div#star-' + i).raty({
				score: i,
				path : "/images",
				width : 200,
				readOnly: true
			});
		}
		
		if ( data.commentList != '' ) {
			printCommentCnt(data.totalCommentCnt, data.avgStar, $("#commentCount"));
			printPaging(data.pageMaker, $(".pagination"));
		}
	});
}

Number.prototype.padLeft = function(base,chr){
	var len = (String(base || 10).length - String(this).length) + 1;
   	return ( len > 0 ) ? new Array(len).join(chr || '0') + this : this;
}

Handlebars.registerHelper("prettifyDate", function(timeValue) {
	var d = new Date(timeValue);
	
	var dformat = [ d.getFullYear(), (d.getMonth()+1).padLeft(), d.getDate().padLeft()].join('/') 
			+ ' ' + [ d.getHours().padLeft(), d.getMinutes().padLeft()].join(':');
	
	return dformat;
});

var printCommentCnt = function(totalCommentCnt, avgStar, target) {
	var str = "<div class='field-wrap'>이 장소에 대하여 총 " + totalCommentCnt + "개의 한줄평이 작성되었습니다.</div>";
	str += "<div class='field-wrap'>평균 별점 : " + avgStar + "</div>";
	
	target.html(str);
};

var printNoComment = function(target) {
	var str = "<div class='field-wrap'>이 장소에 대한 한줄평이 없습니다.</div>";
	
	target.html(str);
};

var printPaging = function(pageMaker, target) {
	var str = "<ul>";
	
	if ( pageMaker.prev ) {
		str += "<li><a class='fa fa-angle-left' href='" + (pageMaker.start - 1) + "' title='Prev'>" + "<" + "</a></li>";
	}
	
	for ( var i = pageMaker.start, len = pageMaker.end; i <= len; i++ ) {
		var strClass = ( pageMaker.page == i ) ? "current" : "";
		str += "<li><a class='" + strClass + "' href='" + i + "'>" + i + "</a></li>";
	}
		
	if ( pageMaker.next ) {
		str += "<li><a class='fa fa-angle-right' href='" + (pageMaker.end + 1) + "' title='Next'>" + ">" + "</a></li>";
	}
	
	str += "</ul>";
	
	target.html(str);
};

$(document).ready(function() {
	if ( store_no > 0 ) {
		getPage("/comment/" + store_no + "/1");
	}
	else {
		printNoComment($("#commentCount"));	
	}
}); 

$(".pagination").on("click", "li a", function(event) {
	event.preventDefault();
	
	replyPage = $(this).attr("href");
	
	getPage("/comment/" + store_no + "/" + replyPage);
});

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
   	
   	var name = $("#name").val();
   	var address = $("#address").val();
   	var lat = $("#lat").val();
   	var lng = $("#lng").val();
   	var star = $("#star").val();
	
   	if ( store_no == 0 ) {
    	$.ajax({
       		type: 'post',
       		url: '/comment/registerStore',
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
       			registerComment(store_no, comment, star, user_no);
       		},
       		error: function(request, status, error) {
       		    alert("code:" + request.status + "\n" + "message:" + request.responseText+ "\n" + "error:" + error);
       	    }
       	});
   	}
   	else {
   		registerComment(store_no, comment, star, user_no);
   	}
});

$('div#starMap').raty({
	score: 3,
	path : "/images",
	width : 200,
	click: function(score, evt) {
		$("#star").val(score);
	}
});

</script>