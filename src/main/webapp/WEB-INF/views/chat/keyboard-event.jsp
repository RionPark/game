<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- keyboard-event.jsp -->
<div id="mirror"></div>
keypress : <input type="text" id="msg" onkeypress="changeDiv(this, event)" ><br>
keydown : <input type="text" id="msg" onkeydown="changeDiv(this)"><br>
keyup : <input type="text" id="msg" onkeyup="changeDiv(this)"><br>
<script>
	/*
		onkeypress, onkeydown, onkeyup
	*/
	function changeDiv(obj, evt){
		console.log(evt.keyCode);
		var str = '';
		if(evt.keyCode===97){
			str = 'a';
		}
		document.querySelector('#mirror').innerHTML += str;
	}
</script>
</body>
</html>