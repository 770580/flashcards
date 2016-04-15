require 'rails_helper'  

describe 'Notification Mailer' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:card) { FactoryGirl.create(:card) }
    let(:mail) { User.pending_card_notify(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Есть карточки для тренировки')
    end

#    it 'renders the receiver email' do
#      expect(mail.to).to eq([user.email])
#    end

#    it 'renders the sender email' do
#      expect(mail.from).to eq(['noreply@company.com'])
#    end

#    it 'assigns @name' do
#      expect(mail.body.encoded).to match(user.name)
#    end

#    it 'assigns @confirmation_url' do
#      expect(mail.body.encoded)
#        .to match("http://aplication_url/#{user.id}/confirmation")
#    end
end