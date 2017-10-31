module OrdersHelper
	def get_status status
		return '未支付' if status == 'initial'
		return '已支付' if status == 'paid'
		return '已取消' if status == 'cancel'
	end
end