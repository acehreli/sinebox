function konumlandir() {
	var sicilNo = document.getElementById("sicilNo").value;

	if (sicilNo != "") {
		document.getElementById("btnGeldi").focus();
	} else {
		document.getElementById("txtArama").focus();
	}
}

konumlandir();