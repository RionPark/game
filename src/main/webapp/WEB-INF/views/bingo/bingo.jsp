<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
*{
	margin : 0;
	padding: 0;
}

body{
	display: flex;
	justify-content: center;
	text-align: center;
	padding-top:50px;
}
.first, .second {
	display: inline-flex;
	margin: 0 30px;
	padding-bottom:30px;
	align-items:center;
}

button{
	width: 45px;
	height: 45px;
	margin : 2px;
	border:1px solid #aaa;
	background-color:#fafafa;
	cursor: pointer;
	font-weight:bold;
	font-size:16px;
}
button:hover{
	background-color:#e2e2e2;
}
table{
	margin: 0 auto;
	padding-top:30px;
	border-collpase:collpase;
}
td{
	width: 60px;
	height:60px;
	border: 1px solid black;
	font-size:18px;
}
.my{
	background-color: #CCFF99;
}
.now{
	border: 1px solid red;
}
.selected{
	background-color:#abcdef;
}
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/resources/jquery-3.7.1.js"></script>
</head>
<body>
	<div class="container">
		<div class="start">
			<div class="input-name">
				<input type="text" class="player" placeholder="플레이어 이름">
			</div>
			<button onclick="connect()">접속</button>
		</div>
		<div class="game">
			<div class="turn">
				<div class="first">선공 : <span id="firstSpan"></span></div>
				<div class="second">후공 : <span id="secondSpan"></span></div>
			</div>
			<div id="btns">
			</div>
			<div id="table"></div>
		</div>
	</div>
<script>
$(document).ready(function(){
	$('.game').hide();
})
var stomp = null;
var sessionId = null;
var bingoCnt = 4;
var players = null;
function setNumber(obj){
	const tds = document.querySelectorAll('td');
	for(const idx in tds){
		const td = tds[idx];
		if(td.innerText === 'O'){
			td.id = 'td' + obj.innerText;
			td.innerText = obj.innerText;
			obj.remove();
			console.log(tds.length-1, idx);
			if(idx == tds.length-1){
				$('td').css('cursor','pointer');
				$('td').on('click',function(){
					if(players[players.mySessionId]!==$('.now span').text()){
						alert('아직 선택할 차례가 아닙니다.');
						return;
					}
					const param = {
							sessionId : players.mySessionId,
							number : $(this).text()
					}
					stomp.send('/app/bingo',{},JSON.stringify(param));
				})
				alert('게임준비 완료!');
				stomp.subscribe('/topic/bingo',function(data){
					const body = JSON.parse(data.body);
					$('.first').toggleClass('now');
					$('.second').toggleClass('now');
					$('td#td' + body.number).addClass('selected');
					checkBingo();
				})
			}
			return;
		}
	}
}
function checkBingo(){
	const tds = document.querySelectorAll('td');
	var rows = [];
	var cols = [];
	var lCross = [];
	var rCross = [];
	const arr = [];
	for(var i=0;i<bingoCnt;i++){
		const lcIdx = (i*bingoCnt) +i;
		lCross.push(tds[lcIdx].innerText);
		const rcIdx = (i*bingoCnt) + (bingoCnt-1) - i;
		rCross.push(tds[rcIdx].innerText);
		rows = [];
		cols = [];
		for(var j=0;j<bingoCnt;j++){
			const rIdx = (i*bingoCnt)+j;
			rows.push(tds[rIdx].innerText);
			const cIdx = (j*bingoCnt)+i;
			cols.push(tds[cIdx].innerText);
		}
		arr.push(rows);
		arr.push(cols);
	}
	arr.push(lCross);
	arr.push(rCross);
	var checkBingo = 0;
	arr.forEach(function(subArr){
		const isBingo = subArr.every(function(num){
			return document.querySelector('#td' + num).classList.contains('selected');
		})
		if(isBingo){
			checkBingo++;
		}
	});
	if(checkBingo>0){
		alert('빙고 갯수는 ' + checkBingo + '입니다.');
		if(checkBingo==3){
			alert('이겼습니다.');
		}
	}
}
function init(){
	var btnsHtml = '';
	for(var i=1;i<=(bingoCnt*bingoCnt);i++){
		btnsHtml += '<button onclick="setNumber(this)">' + i + '</button>';
	}
	$('#btns').html(btnsHtml);
	var tableHtml = '<table>';
	for(var i=1;i<=bingoCnt;i++){
		tableHtml += '<tr>';
		for(var j=1;j<=bingoCnt;j++){
			tableHtml += '<td>O</td>';
		}
		tableHtml += '</tr>';
	}
	tableHtml += '</table>';
	$('#table').html(tableHtml);
	while(document.querySelectorAll('#btns button').length>0){
		const rNum = Math.floor(Math.random()*document.querySelectorAll('#btns button').length);
		document.querySelectorAll('#btns button')[rNum].click();
		console.log(document.querySelectorAll('#btns button').length);
	}
}
function start(){
	$('.start').hide();
	$('.game').show();
	
	stomp.subscribe('/topic/visite', function(data){
		const body = JSON.parse(data.body);
		if(body.type==='exit'){
			console.log(players);
			alert(players[body.sessionId] + '님이 나가셨습니다.');
			$('#secondSpan').html('');
			$('#firstSpan').html(players[players.mySessionId]);
			init();
		}else{
			const name = body[body.mySessionId];
			players[body.mySessionId] = name;
			alert(name + '님이 들어오셨습니다.');
			$('#secondSpan').html(name);
			init();
		}
	})
}
function connect(){
	if($('input.player').val().trim().length<2){
		alert('플레이어 이름은 2글자 이상입니다.');
		$('input.player').val('');
		$('input.player').focus();
		return;
	}
	const socket = new SockJS('/ws');
	stomp = Stomp.over(socket);
	stomp.connect({}, function(frame){
		var checkSub = stomp.subscribe('/topic/check/' + $('input.player').val(), function(data){
			const body = JSON.parse(data.body);
			players = body;
			if(body.errorCode){
				alert(body.errorMsg);
				stomp.disconnect();
				$('input.player').val('');
				$('input.player').focus();
				return;
			}
			sessionId = body.mySessionId;
			if(body.playerCnt == '1'){
				$('#firstSpan').html(body[sessionId]);
				$('#firstSpan').parent().addClass('my');
			}else{
				for(const key in body){
					if(key === sessionId){
						$('#secondSpan').html(body[sessionId]);
						$('#secondSpan').parent().addClass('my');
					}else if(key!=='playerCnt' && key!=='mySessionId'){
						$('#firstSpan').html(body[key]);
					}
				}
				init();
			}

			$('#firstSpan').parent().addClass('now');
			checkSub.unsubscribe();
			start();
		})
		stomp.send('/app/check/' + $('input.player').val(), function(data){
			
		})
	})
}
</script>
</body>
</html>