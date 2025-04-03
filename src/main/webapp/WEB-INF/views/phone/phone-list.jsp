<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/resources/jquery-3.7.1.js"></script>
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
// 변수명 영문 소문자
// 특수 문자 숫자가 첫글자 안됨!
// 단 특수 문자중에 딱 2가지가 예외 $, _
function getPhones(){
	$.ajax({
		method:'GET',
		url:'/phones',
		success: function(phones){
			var html = '';
			for(const phone of phones){
				html += '<tr>';
				html += '<td>' + phone.piNum + '</td>';
				html += '<td><a href="/views/phone/phone-view?piNum=' + phone.piNum + '">' + phone.piName + '</a></td>';
				html += '<td>' + phone.piPrice + '</td>';
				html += '<td>' + phone.piVendor + '</td>';
				html += '</tr>';
			}
			$('#tBody').html(html);
		}
	});
}

window.onload = function(){
	getPhones();
}
</script>
</body>
</html>