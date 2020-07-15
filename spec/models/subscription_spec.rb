# == Schema Information
#
# Table name: subscriptions
#
#  id                :bigint           not null, primary key
#  email             :string           not null
#  name              :string           not null
#  subscription_type :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'factories' do
    subject { FactoryBot.build :subscription }
    it { should be_valid }
  end

  describe 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should allow_value('email@addresse.foo').for(:email) }
    it { should_not allow_value('email').for(:email) }
  end

  describe '.sent email' do
    let(:subscription) { FactoryBot.create(:subscription, email: 'test@host.com', subscription_type: 'post') }

    it 'sends a mail' do
      expect(SubscriptionMailer).to receive_message_chain(:subscribe_email_successfull, :deliver_later)
      subscription
    end
  end
end
