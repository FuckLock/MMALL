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


$(function(){
	// $('.set-address').off('click')
	$(document).on('click', '.set-address', function(){
		var addressId = $(this).next().val();
		$.post('/addresses/update-params', {id: addressId}, function(data){
			var orderContent = $(data).find(".order-content-w").html();
			// alert($(data).find(".order-content-w").html());
			$('.order-content-w').html(orderContent);
		});
	});
});