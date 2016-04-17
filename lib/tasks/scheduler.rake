desc "This task is called by the Heroku scheduler add-on"

task :pending_card_notify => :environment do
  User.pending_card_notify
end