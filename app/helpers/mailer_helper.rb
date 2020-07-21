# frozen_string_literal: true

module MailerHelper
  def full_title(page_title = '')
    page_title.empty? ? 'Golden Owl' : page_title
  end
end
