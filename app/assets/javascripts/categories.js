$(function(){
	var count = 0;
	var cateId = $(".cate-id").val()
	$(".sorter-left").attr("style", "color:white;background:#c60023");
	$(".sorter-left").on("click", function(){
		$(".sorter-left").attr("style", "color:white;background:#c60023");
		$(".sorter-right").attr("style", "");

		$(".fa-caret-up").css("color", "")
		$(".fa-caret-down").css("color", "")


		$.post("/categories/show", {id: cateId }, function(data){
			$(".product").html('');
			$(".product").html(data);
		});
	})

	$(".sorter-right").on("click", function(){
		$(".sorter-right").attr("style", "color:white;background:#c60023");
		$(".sorter-left").attr("style", "");
		
		if (count == 0){
			$(".fa-caret-up").css("color", "white")
			$(".fa-caret-down").css("color", "#B8B8B8")
			count ++;

			$.post("/categories/down", {id: cateId }, function(data){
				$(".product").html('');
				$(".product").html(data);
			});
		}else {
			$(".fa-caret-up").css("color", "#B8B8B8")
			$(".fa-caret-down").css("color", "white")
			count = 0;

			$.post("/categories/up", {id: cateId }, function(data){
				$(".product").html('');
				$(".product").html(data);
			});
		}
	})
	
});