function idCheck(id){
	if(id == ""){
		alert("아이디를 입력해주세요.");
		document.regForm.id.focus();				// regForm = 폼 이름
		}else{
			url="idCheck.jsp?id=" + id;
			window.open(url,"post","width=300, height=150");
		}
}

function zipCheck(){
	url="zipCheck.jsp?check=y";
	window.open(url,"post","toolbar=no, width=500, height=300, directories=no, status=yes, scrollbars=yes,menubar=no");
}

function dongCheck(){
	if(document.zipForm.dong.value==""){
		alert("동을 입력해주세요");
		document.zipForm.dong.focus();
		return ;
	}
	
	document.zipForm.submit();
}

function sendAddress(zipcode, sido, gugun, dong, ri, bunji){
	
	var address = sido + " " + gugun + " " + dong + " " + ri + " " + bunji;
	
	opener.document.regForm.zipcode.value=zipcode;
	
	opener.document.regForm.address1.value=address;
}

function inputCheck(){
	
	if(document.regForm.id.value==""){
		alert("아이디를 입력해주세요.");
		document.regForm.id.focus();
		return ;
	}
	
	if(document.regForm.pass.value==""){
		alert("비밀번호를 입력해주세요.");
		document.regForm.pass.focus();
		return ;
	}
		
	if(document.regForm.repass.value==""){
		alert("비밀번호를 확인해주세요.");
		document.regForm.repass.focus();
		return ;
	}
	
	if(document.regForm.repass.value != document.regForm.pass.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.regForm.repass.focus();
		return ;
	}

	if(document.regForm.phone2.value==""){
		alert("번호 앞자리를 입력해주세요.");
		document.regForm.phone2.focus();
		return ;
	}
	
	if(document.regForm.phone3.value==""){
		alert("번호 뒷자리를 입력해주세요.");
		document.regForm.phone3.focus();
		return ;
	}
	
	if(document.regForm.email.value==""){
		alert("이메일을 입력해주세요.");
		document.regForm.email.focus();
		return ;
	}
	
	var str=document.regForm.email.value;
	var atPos=str.indexOf('@');
	var atLastPos=str.lastIndexOf('@');
	var dotPos=str.indexOf('.');
	var spacePos=str.indexOf(' ');
	var commaPos=str.indexOf(',');
	var emailSize=str.length;
	
	if(atPos > 1 && atPos ==atLastPos && dotPos > 3 && spacePos==-1 && commaPos==-1 && atPos+1 < dotPos && dotPos+1 < emailSize);
	else{alert('E_mail 주소 형식을 잘못 입력하셨습니다.\n\r 다시 입력해주세요.');
	document.regForm.email.focus();
	return ;
	}
	
	if(document.regForm.zipcode.value==""){
		alert("우편번호를 입력해 주세요.");
		document.regForm.zipcode.focus();
		return ;
	}

	if(document.regForm.address1.value==""){
		alert("주소를 입력해 주세요.");
		document.regForm.address1.focus();
		return ;
	}
	
	if(document.regForm.address2.value==""){
		alert("상세주소를 입력해 주세요.");
		document.regForm.address2.focus();
		return ;
	}
	
	document.regForm.submit();
}	

function updateCheck(){
	
	if(document.regForm.pass.value==""){
		alert("비밀번호를 입력해주세요.");
		document.regForm.pass.focus();
		return ;
	}
		
	if(document.regForm.repass.value==""){
		alert("비밀번호를 확인해주세요.");
		document.regForm.repass.focus();
		return ;
	}
	
	if(document.regForm.repass.value != document.regForm.pass.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.regForm.repass.focus();
		return ;
	}
	
	if(document.regForm.phone1.value==""){
		alert("통신사 번호를 입력해주세요.");
		document.regForm.phone1.focus();
		return ;
	}
	
	if(document.regForm.phone2.value==""){
		alert("번호 앞자리를 입력해주세요.");
		document.regForm.phone2.focus();
		return ;
	}
	
	if(document.regForm.phone3.value==""){
		alert("번호 뒷자리를 입력해주세요.");
		document.regForm.phone3.focus();
		return ;
	}
	
	if(document.regForm.email.value==""){
		alert("이메일을 입력해주세요.");
		document.regForm.email.focus();
		return ;
	}
	
	var str=document.regForm.email.value;
	var atPos=str.indexOf('@');
	var atLastPos=str.lastIndexOf('@');
	var dotPos=str.indexOf('.');
	var spacePos=str.indexOf(' ');
	var commaPos=str.indexOf(',');
	var emailSize=str.length;
	
	if(atPos > 1 && atPos ==atLastPos && dotPos > 3 && spacePos==-1 && commaPos==-1 && atPos+1 < dotPos && dotPos+1 < emailSize);
	else{alert('E_mail 주소 형식을 잘못 입력하셨습니다.\n\r 다시 입력해주세요.');
	document.regForm.email.focus();
	return ;
	}

	if(document.regForm.zipcode.value==""){
		alert("우편번호를 입력해 주세요.");
		document.regForm.zipcode.focus();
		return ;
	}

	if(document.regForm.address1.value==""){
		alert("주소를 입력해 주세요.");
		document.regForm.address1.focus();
		return ;
	}
	
	if(document.regForm.address2.value==""){
		alert("상세주소를 입력해 주세요.");
		document.regForm.address2.focus();
		return ;
	}
	
	document.regForm.submit();
	
}

function begin(){
	
	document.myForm.pass.focus();
	
	
}

function checkIt(){
	
	if(!document.myForm.pass.value){
	
		alert("비밀번호를 입력하지 않았습니다.");
		document.myForm.pass.focus();
		return false;	
	}
	
}
function writeSave(){
	
	if(document.i_boardWriteForm.mi_writer.value==""){
		alert("작성자를 입력해주세요.");
		document.i_boardWriteForm.mi_writer.focus();
		return false;
	}
	
	
	if(document.i_boardWriteForm.mi_subject.value==""){
		alert("제목을 입력해주세요.");
		document.i_boardWriteForm.mi_subject.focus();
		return false;
	}
	
	if(document.i_boardWriteForm.mi_content.value==""){
		alert("내용을 입력해주세요.");
		document.i_boardWriteForm.mi_content.focus();
		return false;
	}
	
	if(document.i_boardWriteForm.mi_pass.value==""){
		alert("비밀번호를 입력해주세요.");
		document.i_boardWriteForm.mi_pass.focus();
		return false;
	}

}

function deleteSave(){
	
	if(document.delForm.pass.value==""){
		alert("비밀번호를 입력해주세요.");
		document.delForm.pass.focus();
		return false;
	}
	
	
}