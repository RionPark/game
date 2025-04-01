<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.menu{
	position:fixed;
	width:300px;
	height:100%;
	background-color:#bababa;
	color:white;
	top:0;
	right:0;
	padding : 10px;
	transform:translateX(100%);
	transition: 0.5s;
}
.open{
	transform:translateX(0);
}
.toggle{
	position:fixed;
	top:20px;
	right:20px;
	padding:10px;
	background-color: #00cdef;
	border:none;
	color:white;
	cursor:pointer;
	z-index:2;
}
.toggle:hover{
	border: 1px solid #ffcdef
}
</style>
</head>
<body>
<button class="toggle" onclick="openMenu()">메뉴Open</button>
<div class="menu" id="menu">
	<h2>메뉴</h2>
	<ul>
		<li>서브 메뉴1</li>
		<li>서브 메뉴2</li>
		<li>서브 메뉴3</li>
	</ul>
</div>
<script>
function openMenu(){
	document.querySelector('#menu').classList.toggle('open');
}
</script>
</body>
</html>