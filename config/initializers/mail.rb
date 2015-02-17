ActionMailer::Base.smtp_settings = {
  address: "smtp.mandrillapp.com",
  port: 587,
  user_name: "jeffsee.55@gmail.com",
  password: ENV["MANDRILL_API_KEY"],
  enable_starttls_auto: true,
  authentication: "login"
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"
