$(function(){
	// 初始化操作checkbox的value的值为1的都默认改变选中商品的背景色
	$(".all-check").each(function(){
		var allValue = $(this).val();
		if (allValue == 1){
			$(".cart-concon").css("background", "#fff4e8");
		}
	});

	//点击全选框全部选中或者全部取消 
	$('.all-check').each(function(){
		$(this).on('click', function(){
			$(".all-check").each(function(){
				var allValue = $(this).val();
				if (allValue == 1){
					// $(this).removeProp("checked");
					// $(this).val(0);
					$.post('shopping_carts/select_value', {select_value: 0}, function(){})
					$(".cart-concon").css("background", "");
				}else {
					// $(this).prop("checked","checked");
					$(this).val(1);
					$(".cart-concon").css("background", "#fff4e8");
				};
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
			cart.totalPrice();
		});
	});

	$(".only-value").each(function(){
		$(this).on('click', function(){
			var onlyValue = $(this).val();
			if (onlyValue == 1){
				$(this).removeProp("checked");
				$(this).val(0);
				$(this).parent().parent().css("background", "");
			}else {
				$(this).prop("checked");
				$(this).val(1);
				$(this).parent().parent().css("background", "#fff4e8");
			};

			$('.all-check').each(function(){
				$(this).removeProp("checked");
				$(this).val(0);
			});
			cart.jugdAllSelect();
			cart.totalPrice();
		});
	});

	$(".tt-add").on('click', function(){
		cart.changeStatus(this)
		var amount = $(this).prev().val();
		var productId = $(this).next().val();
		var price = parseInt($(this).parent().prev().text());
		// window.alert(parseInt(price).toFixed(1));
		var amount = parseInt(amount) + 1;
		var totalPrice = price * amount
		$(this).prev().val(amount);
		$(this).parent().next().html('<i class="fa fa-jpy fa-sm" aria-hidden="true"></i>' + totalPrice.toFixed(1));
		$.post('shopping_carts/update_amount', {amount: amount, product_id: productId}, function(){
		})

		if (amount > 1) {
			$(this).prev().prev().removeProp("disabled")
			$(this).prev().prev().val('-');
			$(this).prev().prev().prop("cursor", "pointer");
		}
		cart.jugdAllSelect();
		cart.totalPrice();
	});

	$(".tt-minus").on('click', function(){
		cart.changeStatus(this)
		var amount = $(this).next().val();
		var productId = $(this).next().next().next().val();
		var price = parseInt($(this).parent().prev().text());
		var amount = parseInt(amount) - 1;
		var total_price = price * amount
		$(this).next().val(amount);
		$(this).parent().next().html('<i class="fa fa-jpy fa-sm" aria-hidden="true"></i>' + total_price.toFixed(1));
		$.post('shopping_carts/update_amount', {amount: amount, product_id: productId}, function(){
		})

		if (amount == 1) {
			$(this).prop("disabled", "disabled")
			$(this).val('');
			$(this).removeProp("cursor")
		}
		cart.jugdAllSelect();
		cart.totalPrice();
	});

	$(".tt-text").each(function(){
		var text = $(this).val();
		if(text == 1){
			$(this).prev().prop("disabled", "disabled")
			$(this).prev().val('');
			$(this).prev().removeProp("cursor")
		}
	});

	$(".tt-text").on('change', function(){
		var srcText = $(this).next().next().next().val();
		var text = $(this).val();		
		var re = /^[0-9]+[0-9]*$/
		if (!re.test(text)) {
			alert("请输入数字");
			$(this).val(srcText);
			return false;
		};

		var amount = $(this).val();
		if (amount != srcText) {
			cart.changeStatus(this);
		}
		cart.jugdAllSelect();
		var price = $(this).parent().prev().text();
		var totalPrice = parseInt(amount) * parseInt(price);
		$(this).parent().next().html('<i class="fa fa-jpy fa-sm" aria-hidden="true"></i>' + totalPrice.toFixed(1));
		var productId = $(this).next().next().val();
		$.post('shopping_carts/update_amount', {amount: amount, product_id: productId}, function(){
		})
		cart.totalPrice();
	});

	// 删除选中的商品
	// $(".delete-select").on('click', function(){
	// 	var shoppingCartIdArry = new Array();
	// 	$(".only-value:checked").each(function(){
	// 		shoppingCartIdArry.push($(this).next().val());
	// 	});

	// 	// $.post('shopping_carts/delete-select', {id: shoppingCartIdArry}, function(data){
	// 	// 	$(".shopping-main").html(data);
	// 	// 	// alert(data);
	// 	// });

	// 	$.ajax({
	// 		type: "post",
	// 		url: 'shopping_carts/delete-select',
	// 		data: "id=" + shoppingCartIdArry,
	// 		async: false, 
	// 		success: function(data){

	// 		}
	// 	});
	// });
});

// 定义ShoppingCart类
function ShoppingCart(){
}

// 定义方法是否为全选
ShoppingCart.prototype.jugdAllSelect = function(){
	var onlyValueSize = $(".only-value").size();
	var checkedSize = $(".only-value:checked").size();
	if (onlyValueSize == checkedSize) {
		$('.all-check').each(function(){
			$(this).prop("checked","checked");
			$(this).val(1);
		});
	}
}

// 定义方法点击商品改变选中状态并改变其背景色
ShoppingCart.prototype.changeStatus = function(obj){
	$(obj).parent().parent().parent().css("background", "#fff4e8");
	$(obj).parent().parent().children(":first").val(1);
	$(obj).parent().parent().children(":first").prop("checked","checked");
}

// 计算总价
ShoppingCart.prototype.totalPrice = function(){
	var sum = 0
	$(".tt-total").each(function(){
		if ($(this).parent().children(":first").prop("checked")){
			sum += parseInt($(this).text());
		}
	});
	$(".total-price").html('<i class="fa fa-jpy fa-sm" aria-hidden="true"></i>' + sum.toFixed(1));
}

cart = new ShoppingCart();