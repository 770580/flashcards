require 'rails_helper'

describe 'Notification Mailer mail should has' do
  let(:user) { FactoryGirl.create(:user) }
  let(:card) { FactoryGirl.create(:card) }
  let(:card_count) { Card.pending_cards_count(user) }
  let(:mail) { NotificationsMailer.pending_cards(user, card_count).deliver_now }

  it 'subject' do
    expect(mail.subject).to eq('Есть карточки для тренировки')
  end

  it 'the receiver email' do
    expect(mail.to).to eq([user.email])
  end

  it 'body' do
    expect(mail.body).to have_content("У тебя есть карточки для тренировки: #{card_count}!")
  end
end
