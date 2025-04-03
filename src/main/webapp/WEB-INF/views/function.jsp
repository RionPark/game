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
//test1();  <-- 정상
function test1(){
	alert(1);
}
//test2(); <-- 오류
var test2 = function(){
	alert(2);
}

function Person(){ // private , public
	alert(window===this);
	this.userName = '홍길동';
	this.age = 33;
}

function test(conf){
	conf.callback('1')
}


const conf = {
		method : 'GET',
		callback : function(res){
			if(res==='1'){
				alert('정상입력');
			}
		}
}
test(conf);
</script>
</body>
</html>