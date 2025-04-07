<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.selected { 
	background-color: blue;
}
</style>
</head>
<body>
<table border="1">
	<tbody id="tBody"></tbody>
</table>
<script>
var ranNums = [];
window.onload = function(){
	while(ranNums.length<9){
		const ranNum = Math.floor(Math.random() * 9) + 1;
		if(!ranNums.includes(ranNum)){
			ranNums.push(ranNum);
		}
	}
	console.log(ranNums);
	var html = '';
	for(var i=0;i<3;i++){
		var clazz = 'selected';
		if(i % 2==1){
			clazz = '';
		}
		html += '<tr>';
		for(var j=0;j<3;j++){
			const idx = (i*3) +j
			html += '<td class="' + clazz + '" id="td' + ranNums[idx] + '">' + ranNums[idx] + '</td>';
		}
		html += '</tr>';
	}
	document.querySelector('#tBody').innerHTML = html;
	
	const tds = document.querySelectorAll('td');
	var rows = [];
	var cols = [];
	var lCross = [];
	var rCross = [];
	const arr = [];
	for(var i=0;i<3;i++){
		const lcIdx = (i*3) +i;
		lCross.push(tds[lcIdx].innerText);
		const rcIdx = (i*3) + 2 - i;
		rCross.push(tds[rcIdx].innerText);
		rows = [];
		cols = [];
		for(var j=0;j<3;j++){
			const rIdx = (i*3)+j;
			rows.push(tds[rIdx].innerText);
			const cIdx = (j*3)+i;
			cols.push(tds[cIdx].innerText);
		}
		arr.push(rows);
		arr.push(cols);
	}
	arr.push(lCross);
	arr.push(rCross);
	var bingoCnt = 0;
	arr.forEach(function(subArr){
		const isBingo = subArr.every(function(num){
			return document.querySelector('#td' + num).classList.contains('selected');
		})
		if(isBingo){
			bingoCnt++;
		}
	});
	alert('빙고 갯수는 ' + bingoCnt + '입니다.');
	
}
</script>
</body>
</html>