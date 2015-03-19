class SiteMailer < ActionMailer::Base
  default from: "stefanie@realisticorganizer.com"

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new(ENV["MANDRILL_API_KEY"])
  end

  def new_message(message)
    template_name = "sullivash-new-message"
    template_content = []
    message = {
      to: [
        {email: "jeffsee.55@gmail.com"},
      ],
      subject: "New Message from #{message.name}",
      merge_vars: [
        {rcpt: "jeffsee.55@gmail.com",
          vars: [
            { name: "NAME", content: message.name },
            { name: "EMAIL", content: message.email },
            { name: "BODY", content: "SUBJECT: #{ message.subject }, #{ message.body }" },
            { name: "MESSAGE_URL", content: admin_message_url(message.id) }
          ]
        }
      ]
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end
end
