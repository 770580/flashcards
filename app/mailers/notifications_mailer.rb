class NotificationsMailer < ApplicationMailer
  def pending_cards(user, card_count)
    @user = user
    @card_count = card_count
    mail(to: @user.email, subject: "Есть карточки для тренировки")
  end
end
