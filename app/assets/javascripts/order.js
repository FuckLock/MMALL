function showAddress(){
	var $hide = $("#hidebg");	
	$hide.css('display', 'block');
	height = $(document).height();
	$hide.css('height', height);
	$('.address-con').css('display', 'block');
};

function addressHide(){
	var $hide = $("#hidebg");
	$hide.css('display', 'none');
	$('.address-con').css('display', 'none');
}

$(function(){
	$("#city").click(function (e) {
		SelCity(this,e);
	});

});
