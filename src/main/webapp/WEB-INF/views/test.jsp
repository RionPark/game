<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
function  connection(){
	return new Promise(function(resolve, reject) {
		setTimeout(function(){
			resolve(true);
		},10);	
	});
}

connection()
.then(res=>{
	if(res){
		alert('기다리니까 연결 성공');
	}
});

if(connection()===true){
	alert('연결 성공');
}
</script>
</body>
</html>