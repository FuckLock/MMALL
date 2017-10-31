// 验证表单
function check(){
	var area = $('#address_area').val();
	// areaLen = area.replace(/(^\s*)|(\s*$)/g,"").length;

	var contactName = $('#address_contact_name').val();
	contactNameLen = contactName.replace(/(^\s*)|(\s*$)/g,"").length;

	var address = $('#address_address').val();
	addressLen = address.replace(/(^\s*)|(\s*$)/g,"").length;

	var cellphone = $('#address_cellphone').val();
	cellphoneLen = cellphone.replace(/(^\s*)|(\s*$)/g,"").length;

  //验证手机号ß
  regu = /^1[3|4|5|7|8][0-9]\d{8}$/
  phone = cellphoneLen > 0 && regu.test(cellphone)
	// contactName = $.trim(contactName)

	if(area == '--请选择--'){
		$('.error-area').show();
	}else{
		$('.error-area').hide();
	}

	if (contactNameLen == 0){							
		$('.error-contact').show();
	}else{
		$('.error-contact').hide();
	}

	if(addressLen == 0){
		$('.error-address').show();
	}else{
		$('.error-address').hide();
	}
	
	if(cellphoneLen == 0){
		$('.error-cellphone').children(2).text("请您填写收货人手机号码");
		$('.error-cellphone').show();
	}else if(!phone){
		$('.error-cellphone').children(2).text("手机号码格式不正确");
		$('.error-cellphone').show();
	}else{
		$('.error-cellphone').hide();
	}

	if (area == '--请选择--' || contactNameLen == 0 || addressLen == 0 || cellphoneLen == 0 || !phone){
		return false;
	}else {
		return true;
	}
	
}

function orderCheck(){
	if($(".address-area-ss").length > 0){
		return true;
	}else{
		window.alert('请确认地址')
		return false;
	};
};

function showAddress(){
	$.post('/address/new', function(data){
		addressPop(data);
	});
};

function editAddress(addressId){
	$.post('/address/edit', {id: addressId}, function(data){
		addressPop(data);
	});
}

function addressHide(){
	var $hide = $("#address-back");
	$hide.hide();
	$('.address-con').hide();
}

function addressPop(data){
	if($(".order-new").find('.tan-ku').length > 0){
			$('.tan-ku').remove();
		}
	$(".order-new").append($(data));
}

$(function(){
	$("#city").click(function (e) {
		SelCity(this,e);
	});

});

$(function(){
	// 点击设置默认地址后变成默认地址
	$(document).on('click', '.add-two', function(){
		var addressId = $(this).parent().next().val();
		$.post('/addresses/update-params', {id: addressId}, function(data){
			var orderContent = $(data).find(".order-content-w").html();
			var orderBottom = $(data).find(".order-bottom").html();
			var submitOrderCon = $(data).find(".submit-order-con")
			$('.order-content-w').html(orderContent);
			$('.order-bottom').html(orderBottom);
			$('submit-order-con').html(submitOrderCon);
		});
	});

	$(document).on('click', '.address-area-common', function(){
		$('.address-area-common').each(function(){
			$(this).attr('style', 'border: 1px solid #ddd;');
			$('b').remove();
		});
		$(this).attr('style', 'border: 2px solid #e4393c;')
		$(this).append("<b></b>");
		$(".yf-dz").text($(this).next().val())
		// alert($(this).next().next().val())
		$('.order-address').val($(this).next().next().val());
		var addressId = $(this).parent().children(':last').find('input').val();
		$.post('/addresses/update-params', {id: addressId, type: "changeSelect"});

	})

	$(document).on('mouseover','.address-right', function(){
		$(this).css('background', '#fff3f3');
		$(this).find('.add-two').show();
		$(this).find('.edit-class').show();
	});

	$(document).on('mouseout', '.address-right', function(){
		$(this).css('background', '');
		$(this).find('.add-two').hide();
		$(this).find('.edit-class').hide();
	});

	$(document).on('click', '.switch-on', function(){
		$(".con-show-hide").show();
		$(".switch-on").hide();
		$(".switch-off").show();
		$('.scoll').css('height', '165px');
		$('.scoll').css('overflow-y', 'scroll');
	});

	$(document).on('click', '.switch-off', function(){
		$.get('/switchoff', function(data){
			var orderContent = $(data).find(".order-content-w").html();
			$('.order-content-w').html(orderContent);
		});
	});
});