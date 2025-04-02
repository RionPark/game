<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="text" id="name" placeholder="대화명" value="홍길동"><br>
<textarea id="messages" style="width:300px;height:150px;resize:none"></textarea><br>
<input type="text" id="message" style="width:250px" onkeypress="send()"><button onclick="send()">전송</button>
<script>
const name = document.querySelector('#name');
const messages = document.querySelector('#messages');
const message = document.querySelector('#message');

function send(){
	const param = {
			name : name.value,
			message : message.value
	}
	console.log(param);
	const json = JSON.stringify(param);
	console.log(json);
}
</script>
</body>
</html>