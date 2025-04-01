<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
div{
	margin-bottom:5px;
	width : 100px;
	height : 50px;
	left: 0px;
	border : 2px solid #cccccc;
	background-color: #dddddd;
	border-radius: 10px;
	position:relative;
	align-items: center;
	justify-content:center;
	display:flex;
}
.test{
	left:50px!important;
	opacity:0;
}
</style>
</head>
<body>
<div id="move1">Move1</div>
<div id="move2">Move2</div>
<button onclick="move1()">Move1</button>
<button onclick="move2(100, 5)">Move2</button>
<script>
function move1(){
	const moveDiv = document.querySelector('#move1');
	if(moveDiv.classList.contains('test')){
		moveDiv.classList.remove('test');
	}else{
		moveDiv.classList.add('test');
	}
}
function move2(max, sec){
	const moveDiv = document.querySelector('#move2');
	var left = 1;
	var opacity = 1;
	var leftMove = setInterval(function(){
		moveDiv.style.left=(left++) + 'px';
		if(left % 10 ==0){
			opacity -= 0.2;
			moveDiv.style.opacity = opacity;
		}
		if(left==max){
			clearInterval(leftMove);
		}
	},sec);
}
</script>
</body>
</html>