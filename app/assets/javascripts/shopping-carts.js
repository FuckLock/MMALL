$(function(){
	$('.all-check').each(function(){
		$(this).on('click', function(){
			// window.alert("bao")
			$(".all-check").each(function(){
				var allValue = $(this).val();
				if (allValue == 1){
					$(this).removeProp("checked");
					$(this).val(0);
				}else {
					$(this).prop("checked","checked");
					// window.alert("bao");
					$(this).val(1);
				}
				
			});

			var allValue = $(".all-check:first").val();
			$(".only-value").each(function(){
				var onlyValue = $(this).val();
				if (allValue == 1 && onlyValue == 1){
					return
				};

				if (allValue == 1 && onlyValue == 0){
					$(this).prop("checked","checked");
					$(this).val(1);
				};

				if (allValue == 0 && onlyValue == 0){
					return
				};				

				if (allValue == 0 && onlyValue == 1){
					$(this).removeProp("checked");
					$(this).val(0);
				};				

			});
		});
	});

	$(".check-value").each(function(){
		var checkValue = $(this).val();
		if (checkValue == 1){
			$(this).prop("checked", "checked");
		}
	});

	$(".only-value").each(function(){
		$(this).on('click', function(){
			var onlyValue = $(this).val();
			if (onlyValue == 1){
				$(this).removeProp("checked");
				$(this).val(0);
			}else {
				$(this).prop("checked");
				$(this).val(1);
			};
			$('.all-check').each(function(){
				$(this).removeProp("checked");
				$(this).val(0);
			});
			var onlyValueSize = $(".only-value").size();
			var checkedSize = $(".only-value:checked").size();
			if (onlyValueSize == checkedSize) {
				$('.all-check').each(function(){
					$(this).prop("checked","checked");
					$(this).val(1);
				});
			}
		});
	});
});