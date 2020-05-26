if Rails.env.production? || Rails.env.staging?
  Rails.application.configure do
    # send mail subscription
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      user_name: ENV['USER_NAME'],
      password: ENV['PASSWORD'],
      domain: ENV['DOMAIN'],
      address: 'smtp.sendgrid.net',
      port: '587',
      authentication: 'plain',
      enable_starttls_auto: true
    }
  end
end
