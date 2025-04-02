<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
div#btns>button{
	width:25px;
	height:25px;
	border:none;
	cursor:pointer;
	margin:3px;
	background-color:#ababab;
	box-shadow:0 2px 4px;
}
div#btns>button:hover{
	font-weight:bold;
	background-color:#9a9a9a;
}
div#table>table td{
	width:30px;
	height:30px;
	text-align:center;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
<div id="init">
<input type="text" id="name" placeholder="닉네임" value="홍길동"><button onclick="connect()">시작</button>
</div>
<div id="game" style="display:none">
	<div id="users"></div>
	<div id="btns"></div>
	<div id="table"></div>
</div>
<script>
const name = document.querySelector('#name');
const cnt = 4;
var stomp;
function start(){
	document.querySelector('#init').style.display = 'none';
	document.querySelector('#game').style.display = 'block';
	var html = '';
	for(var i=1;i<=(cnt*cnt);i++){
		html += '<button onclick="selectNum(this)">' + i + '</button>'
	}
	document.querySelector('#btns').innerHTML = html;
	
	var table = '<table border="1">';
	for(var i=1;i<=cnt;i++){
		table += '<tr>';
		for(var j=1;j<=cnt;j++){
			table += '<td>O</td>'
		}
		table += '</tr>';
	}
	table += '</table>';
	document.querySelector('#table').innerHTML = table;
}

function selectNum(obj){ 
	const tds = document.querySelectorAll('div#table td'); //16
	for(const idx in tds){ //15
		const td = tds[idx];
		if(td.innerText === 'O'){
			td.innerText = obj.innerText;
			obj.remove();
			return;
		}
	}
}
var isCorrect = false;
function connect(){
	const socket = new SockJS('/ws');
	stomp = Stomp.over(socket);
	stomp.connect({},function(frame){
		var checkSub = stomp.subscribe('/topic/check/' + name.value, function(data){
			const body = JSON.parse(data.body);
			if(body.errorCode){
				alert(body.errorMsg);
				stomp.disconnect();
				name.value = '';
				name.focus();
				return;
			}
			checkSub.unsubscribe();
			start();
		})
		stomp.send('/app/check/' + name.value);
	});
}
function sendMessage(param){
	const json = JSON.stringify(param);
	stomp.send('/app/bingo',{}, json);
}
</script>
</body>
</html>