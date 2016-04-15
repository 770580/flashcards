class NotificationsMailer < ApplicationMailer
  def pending_cards(user)
    @user = user
    @card_count = Card.pending_cards_count(user)
    mail(to: @user.email, subject: "Есть #{@card_count} карточек для тренировки")
  end
end
