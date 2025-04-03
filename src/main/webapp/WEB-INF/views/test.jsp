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
var str = 'abcd';
String.prototype.size = function(){
	return this.length;
}
alert(str.size());
</script>
</body>
</html>