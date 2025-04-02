<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>유저리스트</h3>
<input type="text" id="uiName" placeholder="이름"><button onclick="getUserList()">검색</button>
<table border="1">
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>이름</th>
	</tr>
	<tbody id="tBody"></tbody>
</table>

<script>
function getUserList(){
	const uiName = document.querySelector('#uiName');
	document.querySelector('#tBody').innerHTML ='';
	const xhr = new XMLHttpRequest();
	xhr.open('GET','/users?uiName=' + uiName.value);
	xhr.onreadystatechange = function(){
		if(xhr.readyState === 4){
			if(xhr.status === 200){
				const users = JSON.parse(xhr.responseText);
				var html = '';
				for(const user of users){
					html += '<tr>';
					html += '<td>' + user.uiNum + '</td>';
					html += '<td>' + user.uiId + '</td>';
					html += '<td>' + user.uiName + '</td>';
					html += '</tr>';
				}
				document.querySelector('#tBody').innerHTML = html;
			}
		}
	}
	xhr.send();
}
getUserList();

</script>
</body>
</html>