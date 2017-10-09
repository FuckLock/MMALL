$(function(){
	// 初始化操作checkbox的value的值为1的都默认改变选中商品的背景色
	$(".only-value:checked").each(function(){
		$(this).parent().parent().css("background", "#fff4e8");
	});

	//点击全选框全部选中或者全部取消 
	$('.all-check').each(function(){
		$(this).on('click', function(){
			// 点击全选按钮就改变value的值,为后面判断做准备
			// 确定全选按钮是选中还是未选中,并做相应的处理
			// 相应的改变全选商品的背景色状态
			// 改变商品数据库中的select_value的值
			$(".all-check").each(function(){
				var allValue = $(this).val();
				if (allValue == 1){
					$(this).val(0);
					$(this).removeProp("checked");
					$(".cart-concon").css("background", "");
					$.post('shopping_carts/select_value', {select_value: 0}, function(){})
				}else {
					$(this).val(1);
					$(this).prop("checked","checked");
					$(".cart-concon").css("background", "#fff4e8");
					$.post('shopping_carts/select_value', {select_value: 1}, function(){})
				};
			});

			// 全选状态下，判断商品的选中情况
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
			// 总计选中状态的值
			cart.totalPrice();
		});
	});

	// 点击商品按钮异步处理
	$(".only-value").each(function(){
		$(this).on('click', function(){
			var onlyValue = $(this).val();
			var shoppingCartId = $(this).next().val();
			if (onlyValue == 1){
				$(this).val(0);
				$(this).removeProp("checked");
				$(this).parent().parent().css("background", "");
				$.post('shopping_carts/select_value', {select_value: 0, id: shoppingCartId}, function(){})
			}else {
				$(this).prop("checked");
				$(this).val(1);
				$(this).parent().parent().css("background", "#fff4e8");
				$.post('shopping_carts/select_value', {select_value: 1, id: shoppingCartId}, function(){})
			};
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
});

// 定义ShoppingCart类
function ShoppingCart(){
}

// 定义方法是否为全选
ShoppingCart.prototype.jugdAllSelect = function(){
	var onlyValueSize = $(".only-value").size();
	var checkedSize = $(".only-value:checked").size();
	$('.all-check').each(function(){
		if (onlyValueSize == checkedSize){
			$(this).prop("checked","checked");
			$(this).val(1);
		}else{
			$(this).removeProp("checked");
			$(this).val(0);
		};
	});
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