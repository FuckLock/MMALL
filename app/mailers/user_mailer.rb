class UserMailer < ApplicationMailer
	default from: 'bao1214063293@gmail.com'
	def send_email user
		# @user = user.email
		mail(to: 'baodongdong@tigerjoys.com',
				 body: "<html><body>欢迎注册成功</body></html>",
				 content_type: "text/html",
				 subject: 'Welcome to dongdongshangcheng')
	end

end
