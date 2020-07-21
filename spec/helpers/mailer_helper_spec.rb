require "rails_helper"

RSpec.describe MailerHelper, type: :helper do
  describe '#full_title' do
    it 'return base title' do
      expect(full_title('')).to eq('Golden Owl')
    end

    it 'return page title' do
      expect(full_title('Subscription Email')).to eq('Subscription Email')
    end
  end
end
