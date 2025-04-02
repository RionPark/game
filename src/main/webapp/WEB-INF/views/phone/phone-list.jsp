<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border="1">
	<tr>
		<th>번호</th>
		<th>휴대폰명</th>
		<th>가격</th>
		<th>브랜드</th>
	</tr>
	<tbody id="tBody"></tbody>
</table>
<script>
function getPhones(){
	var xhr = new XMLHttpRequest();
	xhr.open('GET','/phones');
	xhr.onreadystatechange = function(){
		if(xhr.readyState === 4){
			if(xhr.status === 200){
				const phones = JSON.parse(xhr.responseText);
				var html = '';
				for(const phone of phones){
					html += '<tr>';
					html += '<td>' + phone.piNum + '</td>';
					html += '<td><a href="/views/phone/phone-view?piNum=' + phone.piNum + '">' + phone.piName + '</a></td>';
					html += '<td>' + phone.piPrice + '</td>';
					html += '<td>' + phone.piVendor + '</td>';
					html += '</tr>';
				}
				document.querySelector('#tBody').innerHTML = html;
			}
		}
	}
	xhr.send();
}
window.onload = function(){
	getPhones();
}
</script>
</body>
</html>