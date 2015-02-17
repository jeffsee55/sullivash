class SiteMailer < ActionMailer::Base
  default from: "stefanie@realisticorganizer.com"

  def mandrill_client
    @mandrill_client ||= Mandrill::API.new(ENV["MANDRILL_API_KEY"])
  end

  def new_message(message)
    template_name = "new-message"
    template_content = []
    message = {
      to: [
        {email: "jeffsee.55@gmail.com"},
      ],
      subject: "New Message from #{message.name}",
      merge_vars: [
        {rcpt: "jeffsee.55@gmail.com",
          vars: [
            {name: "NAME", content: message.name},
            {name: "EMAIL", content: message.email},
            {name: "BODY", content: message.body}
          ]
        }
      ]
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end

  def post_notification(post)
    template_name = "post-notification"
    template_content = []
    message = {
      to:
        Subscriber.all.map do |s|
          {email: "#{s.email}"}
        end,
      subject: "RO:#{post.title}",
      merge_vars: [
        {rcpt: "jeffsee.55@gmail.com",
          vars: [
            {name: "TITLE", content: post.title},
            {name: "IMAGE_URL", content: "https://s3-us-west-2.amazonaws.com/real-org-images/store/#{post.image.id}"},
            {name: "POST_URL", content: ""},
            {name: "UNSUBSCRIBE_URL", content: "http://localhost:5000"},
            {name: "EXCERPT", content: post.strip_and_truncate(200) }
          ]
        }
      ]
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end
end
