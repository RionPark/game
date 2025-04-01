<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
div{
	width:200px;
	height:200px;
	background-color : black;
	transition : 1s;
}
.circle{
	border-radius: 50%;
	background-color:blue;
}
</style>
</head>
<body>
<div onmouseover="this.classList.add('circle')" onmouseout="this.classList.remove('circle')"></div>
<button onclick="changeDiv()">클릭</button>
<!-- 클릭버튼을 클릭했을떄 div의 class에 circle을 추가하고
다시 클릭했을때는 원래 상태로 돌아가게 만들어주세요. -->
<script>
function changeDiv(){
	const div = document.querySelector('div');
	if(div.classList.contains('circle')){
		div.classList.remove('circle')	
	}else{
		div.classList.add('circle')
	}
}
</script>
</body>
</html>