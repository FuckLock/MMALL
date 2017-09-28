$(function(){
	$(".sorter-left").on("click", function(){
		$(".sorter-left").attr("style", "color:white;background:#c60023");
		$(".sorter-right").attr("style", "");
	})

	$(".sorter-right").on("click", function(){
		$(".sorter-right").attr("style", "color:white;background:#c60023");
		$(".sorter-left").attr("style", "");
	})	
});