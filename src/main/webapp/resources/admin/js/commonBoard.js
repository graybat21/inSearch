function verifyOK()
{
	if ( document.form_search.k.value.trim() == '' )
	{
		alert("검색어를 입력하세요.");
		return false;	
	}
	else
		return true;
}
