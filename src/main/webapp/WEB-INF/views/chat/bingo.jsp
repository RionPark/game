<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빙고 게임</title>
<style>
body {
    text-align: center;
    padding-top: 50px;
}

#init {
    margin-bottom: 30px;
}

#users {
    margin: 20px 0;
}

#player1, #player2 {
    display: inline-block;
    margin: 0 30px;
}

#btns {
    margin: 20px 0;
}

#btns button {
    width: 45px;
    height: 45px;
    margin: 2px;
    border: 1px solid #ccc;
    background: #f0f0f0;
    cursor: pointer;
}

#btns button:hover {
    background: #e0e0e0;
}

#table table {
    margin: 0 auto;
    border-collapse: collapse;
}

#table td {
    width: 60px;
    height: 60px;
    border: 2px solid #333;
    font-size: 20px;
}

#name {
    padding: 8px;
    font-size: 16px;
}

button {
    padding: 8px 15px;
    font-size: 16px;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="init">
    <input type="text" id="name" placeholder="닉네임" value="홍길동">
    <button onclick="connect()">시작</button>
</div>
<div id="game" style="display:none">
    <div id="users">
        <div id="player1">선공: </div>
        <div id="player2">후공: </div>
    </div>
    <div id="btns"></div>
    <div id="table"></div>
</div>
<script>
const $name = $('#name');
const cnt = 4;
var stomp;
var sessionId;

function start(){
	$('#init').hide();
	$('#game').show();
	
	let html = '';
	for(let i=1; i<=16; i++){
		html += '<button onclick="selectNum(this)">' + i + '</button>';
	}
	$('#btns').html(html);
	
	let table = '<table>';
	for(let i=1; i<=4; i++){
		table += '<tr>';
		for(let j=1; j<=4; j++){
			table += '<td>O</td>';
		}
		table += '</tr>';
	}
	table += '</table>';
	$('#table').html(table);
}

function selectNum(obj){ 
	const $tds = $('#table td');
	$tds.each(function() {
		if($(this).text() === 'O'){
			$(this).text($(obj).text());
			$(obj).remove();
			return false; // break the loop
		}
	});
}

var isCorrect = false;
function connect(){
	const socket = new SockJS('/ws');
	stomp = Stomp.over(socket);
	
	// Debug 옵션 끄기
	stomp.debug = null;
	
	stomp.connect({}, function(frame){
		// sessionId 추출
		sessionId = /\/([^\/]+)\/websocket/.exec(socket._transport.url)[1];
		console.log("Connected, session id: " + sessionId);
		
		var checkSub = stomp.subscribe('/topic/check/' + $name.val(), function(data){
			const body = JSON.parse(data.body);
			if(body.errorCode){
				alert(body.errorMsg);
				stomp.disconnect();
				$name.val('').focus();
				return;
			}
			checkSub.unsubscribe();
			start();
		});
		
		// sessionId와 함께 이름 전송
		stomp.send('/app/check/' + $name.val(), {}, JSON.stringify({
			sessionId: sessionId,
			name: $name.val()
		}));
	});
}

function sendMessage(param){
	const json = JSON.stringify({
		...param,
		sessionId: sessionId
	});
	stomp.send('/app/bingo', {}, json);
}
</script>
</body>
</html>