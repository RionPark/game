<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	
	const xhr = new XMLHttpRequest();
	xhr.open('POST','/phones');
	xhr.onreadystatechange = function(){
		if(xhr.readyState === 4){
			if(xhr.status === 200){
				if(xhr.responseText === '1'){
					alert('등록 완료');
					location.href='/views/phone/phone-list';
				}
			}
		}
	}
	xhr.setRequestHeader('Content-Type','application/json;chatset=UTF-8');
	xhr.send(json);
}
</script>
</body>
</html>