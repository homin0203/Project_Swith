<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<!-- sockjs -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
<!-- stompjs -->
<script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@6.1.2/bundles/stomp.umd.min.js"></script>
<!-- <title>채팅-방</title> -->
<style>
	.s_receive_chat {
		background-color: lightblue;
		margin-bottom: 5px;
		border-radius: 10px;
		width: 300px;
		font-size: 1.2em;
		margin-right: 67%;
		float: left;
		height: auto;
		padding: 20px;
		position: relative;
		margin-left: 20px;
		word-break: break-all;
	}
	
	.s_receive_chat:after {
		border-top: 15px solid lightblue;
		border-left: 15px solid transparent;
		border-right: 0px solid transparent;
		border-bottom: 0px solid transparent;
		content: "";
		position: absolute;
		top: 10px;
		left: -15px;
	}
	
	.s_sender_chat {
		float: right;
		margin-left: 67%;
		background-color: antiquewhite;
		margin-bottom: 5px;
		border-radius: 10px;
		width: 300px;
		font-size: 1.2em;
		height: auto;
		padding: 20px;
		position: relative;
		margin-right: 20px;
		word-break: break-all;
	}
	
	.s_sender_chat:after {
		border-top: 15px solid antiquewhite;
		border-left: 0px solid transparent;
		border-right: 15px solid transparent;
		border-bottom: 0px solid transparent;
		content: "";
		position: absolute;
		top: 10px;
		right: -15px;
	}
	
	.s_receive {
		background: none;
		font-weight: bold;
		float: left;
		margin-right: 70%;
		height: 55px;
		line-height: 70px;
		margin-left: 20px;
	}
	
	.s_sender {
		background: none;
		font-weight: bold;
		float: right;
		margin-left: 70%;
		height: 55px;
		line-height: 70px;
		margin-right: 20px;
	}
	
	.s_room_tt {
		font-size: 1.2em;
	    font-weight: bold;
	}
	
	.s_room_part {
	    margin: 5px 0 10px;
	}
	
	/* 스크롤바 디자인 */
	.s_scroll::-webkit-scrollbar {
    	width: 10px;   /* 스크롤바의 너비 */
    	height: 10px;  /* 스크롤바의 너비 */
	}
	
	.s_scroll::-webkit-scrollbar-thumb {
	    height: 30%; /* 스크롤바의 길이 */
	    background: #34343482; /* 스크롤바의 색상 */
	    
	    border-radius: 10px;
	}
	
	.s_scroll::-webkit-scrollbar-track{
	    background: #4747471a;  /*스크롤바 뒷 배경 색상*/
	}
</style>
</head>
<body>

	<div class="s_chat_home">
       	<div class="s_room_tt">${readRoom.study_name } <c:if test="${memberCnt > 2}">(${memberCnt })</c:if></div>
       	<div class="s_room_part">
       		<c:forEach items="${readMember }" var="i">
       			<span>${i.member_id } </span>
       		</c:forEach>
       	</div>
       	<div style="border: 1px solid lightgray; margin-bottom: 10px;"></div>
       	<div id="messageArea" class="s_scroll" style="height: 530px; overflow: auto;">
			       		<!-- 채팅 DB 저장한 것 뿌리기(로그인한 사람 이름과 채팅한 사람 이름이 다르면 수신/같으면 발신 -->
			<c:forEach items="${selectChatting }" var="i" varStatus="status">
  				<c:choose>
  					<%-- 채팅 작성자와 로그인한 사람과 같으면(발신) --%>
   					<c:when test="${member_id eq i.member_id}">
   						<!-- 이전 index와 비교하려고 index 1 이상부터 -->
	  					<c:if test="${status.index != 0}">
	  						<!-- 이전 index의 이름이랑 현재 index의 이름이랑 비교해서 같으면 -->
	  						<c:if test="${selectChatting[status.index-1].member_id eq selectChatting[status.index].member_id}">
	  							<!-- 채팅 내용만 띄우기 -->
	  							<div class="s_sender_chat">${i.chatting_content }</div>
	  						</c:if>
	  						<!-- 이전 index의 이름이랑 현재 index의 이름이랑 비교해서 다르면 -->
	  						<c:if test="${selectChatting[status.index-1].member_id ne selectChatting[status.index].member_id}">
	  							<!-- 이름이랑 채팅 내용 띄우기 -->
	  							<div class="s_sender">${i.member_id }</div>
			      				<div class="s_sender_chat">${i.chatting_content }</div>
	  						</c:if>
		      			</c:if>
		      			<!-- 현재 index가 0이면 -->
		      			<c:if test="${status.index == 0 }">
		      				<!-- 이름이랑 채팅 내용 띄우기 -->
		      				<div class="s_sender">${i.member_id }</div>
		      				<div class="s_sender_chat">${i.chatting_content }</div>
		      			</c:if>
   					</c:when>
   					<%-- 채팅 작성자와 로그인한 사람과 다르면(수신) --%>
					<c:otherwise>
						<!-- 이전 index와 비교하려고 index 1 이상부터 -->
						<c:if test="${status.index != 0}">
							<!-- 이전 index의 이름이랑 현재 index의 이름이랑 비교해서 같으면 -->
	  						<c:if test="${selectChatting[status.index-1].member_id eq selectChatting[status.index].member_id}">
	  							<!-- 채팅 내용만 띄우기 -->
	  							<div class="s_receive_chat">${i.chatting_content }</div>
	  						</c:if>
	  						<!-- 이전 index의 이름이랑 현재 index의 이름이랑 비교해서 다르면 -->
	  						<c:if test="${selectChatting[status.index-1].member_id ne selectChatting[status.index].member_id}">
	  							<!-- 이름이랑 채팅 내용 띄우기 -->
	  							<div class="s_receive">${i.member_id }</div>
			      				<div class="s_receive_chat">${i.chatting_content }</div>
	  						</c:if>
		      			</c:if>
		      			<!-- 현재 index가 0이면 -->
		      			<c:if test="${status.index == 0 }">
		      				<!-- 이름이랑 채팅 내용 띄우기 -->
		      				<div class="s_receive">${i.member_id }</div>
	       					<div class="s_receive_chat">${i.chatting_content }</div>
		      			</c:if>
   					</c:otherwise>
  				</c:choose>
   			</c:forEach>       	
       	</div>
       	<div style="margin-top: 10px;display: flex;justify-content: center;">
         	<input style="width: 900px; height: 50px; display: inline-block;" type="text" placeholder="채팅 입력" id="message" onkeyup="fn_enter(event)" class="form-control" />
			<button id="sendBtn" style="height: 50px; width: 80px; margin-left: 10px;" class="btn btn-success">전송</button>
		</div>
	</div>

<!-- 채팅 -->
<script>
	// 전송 버튼 눌렀을 때
	$("#sendBtn").click(function() {
		sendMessage();
		$('#message').val('')
	});
	
	// 엔터키 눌렀을 때
	function fn_enter(e){
		if(e.keyCode == 13){
			sendMessage();
			$('#message').val('');
		}
	}
	// 로그인한 사람 이름
	var member_id = "${member_id}";
	// 채팅 연결할 주소
	//let sock = new SockJS("${pageContext.request.contextPath}/echo");
	let sock = new SockJS("/swith/echo");
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	// 메시지 전송
	function sendMessage() {
		sock.send(member_id + ',' + $("#message").val());
	}
	// 서버로부터 메시지를 받았을 때
	function onMessage(msg) {
		var data = msg.data;
		var name = data.substring(0,data.indexOf(","));
		var message = data.substring(data.indexOf(",")+1);
		// 보낸사람/받는사람 구분은 로그인한 이름과 비교
		if(name == member_id){ // 보낸 사람의 경우
			// 채팅 여러개 보내면 이름 안뜨게 하기
			if($("#messageArea").children().last().hasClass("s_sender_chat")) {
				$("#messageArea").append('<div class="s_sender_chat">' + message + '</div>');
			} else { // 하나면 이름 매번 뜨기
				$("#messageArea").append('<div class="s_sender">' + name + '</div>');
				$("#messageArea").append('<div class="s_sender_chat">' + message + '</div>');
			}
		} else { // 받는 사람의 경우
			if($("#messageArea").children().last().hasClass("s_receive_chat")) {
				$("#messageArea").append('<div class="s_receive_chat">' + message + '</div>');
			} else {
				$("#messageArea").append('<div class="s_receive">' + name + '</div>');
				$("#messageArea").append('<div class="s_receive_chat">' + message + '</div>');
			}
		}
		
		// 채팅 여러개 쌓여서 스크롤 바 생길 때 자동으로 가장 하단으로 가기
		var offset = $("#messageArea").children().last().offset();
		console.log(offset);
		$("#messageArea").animate({scrollTop : "90000"},0);
	
	}
	// 서버와 연결을 끊었을 때
	function onClose(evt) {
		$("#messageArea").append(member_id + "님이 대화를 종료하셨습니다.");
	}
</script>
</body>
</html>