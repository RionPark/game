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
	right: 0px;
	border : 2px solid #cccccc;
	background-color: #dddddd;
	border-radius: 10px;
	position:absolute;
	align-items: center;
	justify-content:center;
	display:flex;
	transition : 1s;
}
.test{
	margin-right:50px;
	opacity:0;
}
button{
	top:100px;
	position:absolute;
}
</style>
</head>
<body>
<div id="div">오른쪽에서 왼쪽으로</div>
<button onclick="move()">움직여!</button>
<script>
function move(){
	const moveDiv = document.querySelector('#div');
	if(moveDiv.classList.contains('test')){
		moveDiv.classList.remove('test');
	}else{
		moveDiv.classList.add('test');
	}
}
</script>
</body>
</html>