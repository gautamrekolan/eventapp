class Notifier < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_friend.subject
  #
  def email_friend(event, sender_name, receiver_email)
    @event = event
	@sender_name = sender_name
	
	mail :to => receiver_email, :subject => "interesting article"
	
    #@greeting = "Hi"
    #mail :to => "to@example.org"
  end
end
