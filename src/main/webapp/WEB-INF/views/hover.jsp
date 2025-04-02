<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
div{
	width:200px; /*넓이값*/
	height:200px; /*높이값*/
	background-color:blue; /*배경색*/
	color:white; /*글자색*/
	transition:3s;
}
div:hover{ /*div태그중에 마우스가 올라간상태*/
	border-radius:15px; /*태두리를 15px 원으로 만들고 */
	background-color:red; /*배경색 빨간색으로 만듬*/
}
</style>
</head>
<body>

<div>마우스를 올려봐</div>
</body>
</html>