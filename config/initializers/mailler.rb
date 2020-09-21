if Rails.env.production? || Rails.env.staging?
  Rails.application.configure do
    # send mail subscription
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      from: ENV['MAIL_ADMIN_SENDER'],
      user_name: ENV['SENDGRID_USERNAME'],
      password: ENV['SENDGRID_PASSWORD'],
      domain: ENV['SENDGRID_DOMAIN'],
      address: 'smtp.sendgrid.net',
      port: '587',
      authentication: 'plain',
      enable_starttls_auto: true
    }
  end
end
