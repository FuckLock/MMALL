$(function(){


	$('.all-check').each(function(){
		$(this).on('click', function(){
			// window.alert("bao")
			$(".check-value").each(function(){
				// var checkValue = $(this).val();
				if ($(this).attr('checked')){
					$(this).removeAttr("checked");
					// $(this).val(0);
				}else {
					$(this).attr("checked","checked");
					// $(this).val(1);
				}
				
			});
				// window.alert("bao")
				// $(this).removeAttr("checked");	
		});
	});

	// window.alert($(".check-value:first").val());

	// $(".check-value").each(function(){
	// 	var checkValue = $(this).val();
	// 	if (checkValue == 1){
	// 		$(this).prop("checked", "checked");
	// 	}

	// 	// $(this).on('click', function(){
	// 	// 	window.alert("bao");
	// 	// 	$(this).val(0);
	// 	// });
	// });
});