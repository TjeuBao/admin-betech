# frozen_string_literal: true

Rails.application.configure do
  if Rails.env.test? || Rails.env.development?
    config.paperclip_defaults = {
      storage: :fog,
      fog_credentials: {
        provider: 'Local',
        default_url: '/images/:style/missing.png'
      },
      fog_directory: '',
      fog_host: ''
    }
  else
    config.paperclip_defaults = { storage: :cloudinary }
  end
end
