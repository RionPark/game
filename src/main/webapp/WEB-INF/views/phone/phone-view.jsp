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
		<td data-col="piNum"></td>
	</tr>
	<tr>
		<th>휴대폰명</th>
		<td data-col="piName"></td>
	</tr>
	<tr>
		<th>가격</th>
		<td data-col="piPrice"></td>
	</tr>
	<tr>
		<th>제조사</th>
		<td data-col="piVendor"></td>
	</tr>
	<tr>
		<th colspan="2">
			<button>수정</button>
			<button onclick="deletePhone()">삭제</button>
		</th>
	</tr>
</table>
<script>
const piNum = '${param.piNum}';
function deletePhone(){
	const xhr = new XMLHttpRequest();
	xhr.open('DELETE','/phones/' + piNum);
	xhr.onreadystatechange = function(){
		if(xhr.readyState === 4){
			if(xhr.status === 200){
				if(xhr.responseText === '1'){
					alert('삭제 완료');
					location.href='/views/phone/phone-list';
				}
			}
		}
	}
	xhr.setRequestHeader('Content-Type','application/json;chatset=UTF-8');
	xhr.send();
}
function getPhone(){
	var xhr = new XMLHttpRequest();
	xhr.open('GET','/phones/' + piNum);
	xhr.onreadystatechange = function(){
		if(xhr.readyState === 4){
			if(xhr.status === 200){
				const phone = JSON.parse(xhr.responseText);
				for(const key in phone){
					if(document.querySelector('[data-col=' + key + ']')){
						document.querySelector('[data-col=' + key + ']').innerHTML = phone[key];
					}
				}
			}
		}
	}
	xhr.send();
}
window.onload = function(){
	getPhone();
}
</script>
</body>
</html>