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
<input type="text" id="piName" placeholder="휴대폰명"><br>
<input type="text" id="piPrice" placeholder="가격"><br>
<input type="text" id="piVendor" placeholder="브랜드"><br>
<button onclick="insertPhone()">등록</button>
<script>
function insertPhone(){
	const param = {
			piName:document.querySelector('#piName').value,
			piPrice:document.querySelector('#piPrice').value,
			piVendor:document.querySelector('#piVendor').value
	}
	const json = JSON.stringify(param);
	$.ajax({
		method:'POST',
		url : '/phones',
		data : json,
		contentType : 'application/json',
		success : function (res){
			if(res === 1){
				alert('등록 완료');
				location.href='/views/phone/phone-list';
			}
		}
	});
}
</script>
</body>
</html>