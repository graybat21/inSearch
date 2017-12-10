<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>   
<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link href="${myContextPath}/css/map_css.css" rel="stylesheet" type="text/css" />

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="name" id="name" value="${storeVo.name}" />
	<input type="hidden" name="address" id="address" value="${storeVo.address}" />
	<input type="hidden" name="lat" id="lat" value="${storeVo.lat}" />
	<input type="hidden" name="lng" id="lng" value="${storeVo.lng}" />	
	<input type="hidden" name="store_no" id="store_no" value="${storeNo}" />	
	<input type="hidden" name="user_no" id="user_no" value="${userNo}" />
	<input type="hidden" id="star" value="3"/>
<div>	
	<div id="r" style="float:left;width:90%;">
		<h2 id="detail">${storeVo.name}</h2>
		<h2 id="detail">${storeVo.address}</h2>
	</div>
	<div id="commentCount">

	</div>
</div>	
	<div class="field-wrap" style="margin-bottom: 0px !important;">
		<input type="text" name="comment" id="comment" placeholder="한줄평을 입력해주세요(최대 150자까지 가능)." />
	</div>
	<div class="field-wrap" style="margin:10px !important;">
		<div id="starMap"></div>
		<button type="button" id="submitComment" name="submitComment" title="Submit Comment">review add</button>
	</div>
	
	

	<div id="block-commentList" style="display:inline-flex;">	
		<div class="comment-box">
		
		</div>
	</div>
	<div class="pages pagination">
			
	</div>

<script id="template" type="text/x-handlebars-template">
{{#each this}}
<div class="block-comment box" style="display: flow-root;">	
	<div style="margin-bottom:10px;">{{this.comment}}</div>
	<div style="float:left;" id="star-{{this.star}}"></div>
	<div id="review_box" style="float:right;"> {{trimString this.email}}**** / {{prettifyDate this.createdate}}</div>
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

Handlebars.registerHelper('trimString', function(passedString) {
   	var theString = passedString.substring(0, 4);
   	return new Handlebars.SafeString(theString);
});

var printCommentCnt = function(totalCommentCnt, avgStar, target) {
	var str = "<h2 id='review' style='margin-right:20ox;'> review " + totalCommentCnt + "</h2>";
	str += "<h2 id='review'> avg star " + avgStar+"</h2>";
	
	target.html(str);
};

var printNoComment = function(target) {
	var str = "<h2 id='review' style='margin-right:20ox;'> review 0</h2>";
	str += "<h2 id='review'> avg star 0 </h2>";
	
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

$("#comment").keyup(function(event) {
    if ( event.keyCode === 13 ) {
        $("#submitComment").click();
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