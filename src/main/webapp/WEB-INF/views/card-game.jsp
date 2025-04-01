<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
td{
    width: 54px;
    height: 74px;
    border: 1px solid blue;
}
.card {
    width: 50px;
    height: 70px;
    background: white;
    border: 2px solid #333;
    border-radius: 10px;
    position: relative;
    box-shadow: 2px 2px 8px rgba(0,0,0,0.1);
}

.card-value {
    position: absolute;
    top: 3px;
    left: 3px;
    font-size: 14px;
}

.card-suit {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 30px;
}
.card-suit.red-suit{
	color : red
}
</style>
</head>
<body>
<div id="game" style="display:none">
	<table>
		<tbody id="tBody"></tbody>
	</table>
</div>
<div id="start">
	<button onclick="startGame()">게임 시작</button>
</div>
<script>
const cardTypes = ['♠','◆','♥', '♣']
const cardValues = ['A','2','3','4','5','6','7','8','9','10','J','Q','K'];

const cards = []
function startGame(){
	while(cards.length<52){
		var fNum = Math.floor(Math.random() * 4); // 0-3
		var lNum = Math.floor(Math.random() * 13); // 0-12
		var card = cardTypes[fNum] + ',' + cardValues[lNum];
		if(!cards.includes(card)){
			cards.push(card);
		}
	}
	var html = '';
	var idx = 0;
	for(var i = 0;i<cardTypes.length;i++){
		html += '<tr>';
		for(var j=0;j<cardValues.length;j++){
			const card = cards[idx++];
			const value = card.split(',')[1];
			const suit = card.split(',')[0];
			html += '<td onclick="show(this)">';
			html += '<div class="card" style="display:none">';
		    html += '<div class="card-value">' + value + '</div>'
		    var red = '';
		    if(suit === '♥' || card.split(',')[0] === '◆'){
		    	red = ' red-suit';
		    }
		    html += '<div class="card-suit' + red + '">' +  suit + '</div>'
		    html += '</div>';
		    html += '</td>';
		}
		html += '</tr>';
	}
	document.querySelector('#tBody').innerHTML = html;
	document.querySelector('#game').style.display='block';
}

function show(obj){
	const card = obj.querySelector('.card');
	if(card.style.display === 'none'){
		setTimeout(function (){
			card.style.display='none';
		},3000);
		card.style.display = 'block';
	}else{
		card.style.display = 'none';
	}
}
</script>
</body>
</html>