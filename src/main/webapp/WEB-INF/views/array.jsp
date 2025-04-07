<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.selected{
	background-color:#abcdef;
}
.bingo{
	background-color:black;
}
</style>
</head>
<body>
<table border="1">
	<tbody id="tBody"></tbody>
</table>
<div id="bingoCnt"></div>
<script>

const cnt = 4;
var num = 1;
const arr = [];
window.onload = function(){
	var html = '';
	for(var i=1;i<=cnt;i++){
		html += '<tr>';
		for(var j=1;j<=cnt;j++){
			var clazz = 'selected';
			if(i%2==1){
				clazz = '';
			}
			if(i==2 && j==1){
				clazz = '';
			}
			html += '<td class="' + clazz + '" id="td' + num + '">' + (num++) + '</td>';
		}
		html += '</tr>';
	}
	document.querySelector('tBody').innerHTML = html;
	const tds = document.querySelectorAll('td');
	var subArr = [];
	for(var i=0;i<cnt;i++){
		subArr = [];
		for(var j=0;j<cnt;j++){
			const idx = (i*4)+j;
			subArr.push(tds[idx].innerText);
		}
		arr.push(subArr);
	}
	for(var i=0;i<cnt;i++){
		subArr = [];
		for(var j=0;j<cnt;j++){
			const idx = (j*4)+i;
			subArr.push(tds[idx].innerText);
		}
		arr.push(subArr);
	}

	subArr = [];
	for(var i=0;i<cnt;i++){
		var idx = (i*cnt)+i;
		subArr.push(tds[idx].innerText);
	}
	arr.push(subArr);

	subArr = [];
	for(var i=0;i<cnt;i++){
		var idx = (i*cnt) + 3 -i;
		subArr.push(tds[idx].innerText);
	}
	arr.push(subArr);
	
	var bingoCnt = 0;
	arr.forEach(function(subArr){
		const isBingo = subArr.every(function(num){
			return document.querySelector('#td' + num).classList.contains('selected');
		})
		if(isBingo){
			bingoCnt++;
			subArr.forEach(function(num){
				document.querySelector('#td' + num).classList.add('bingo');
			})
			document.querySelector('#bingoCnt').innerHTML = bingoCnt + '개';
		}
		
	});
	alert(bingoCnt); 
}
/*
 * [
	 [1,2,3,4],
	 [5,6,7,8],
	 [9,10,11,12],
	 [13,14,15,16],
	 [1,5,9,13],
	 [2,6,10,14],
	 [3,7,11,12],
	 [4,8,12,16],
	 [1,6,11,16],
	 [4,7,10,13]
 ]
 */
</script>
</body>
</html>