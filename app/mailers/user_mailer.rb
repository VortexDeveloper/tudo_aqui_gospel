class UserMailer < ApplicationMailer
  def activated_account(user)
    @user = user
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "Sua conta no portal Tudo Aqui Gospel foi ativada!"
    )
  end
end
