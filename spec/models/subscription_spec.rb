# == Schema Information
#
# Table name: subscriptions
#
#  id                :bigint           not null, primary key
#  email             :string           not null
#  name              :string
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
    # it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should allow_value('email@addresse.foo').for(:email) }
    it { should_not allow_value('email').for(:email) }
    it { should validate_inclusion_of(:subscription_type).in_array(%w[both post career]) }
  end

  describe '.user_name' do
    let(:subscription) { FactoryBot.create(:subscription, email: 'user_name@email.com', subscription_type: 'post') }

    it 'return user name' do
      expect(subscription.user_name).to eq 'user_name'
    end
  end

  describe '.sent email with subscription_type is post' do
    let(:subscription) { FactoryBot.create(:subscription, email: 'test@host.com', subscription_type: 'post') }

    it 'sends a mail' do
      expect(SubscriptionMailer).to receive_message_chain(:subscribe_email_successfull, :deliver_later)
      subscription
    end
  end

  describe '.sent email with subscription_type is career' do
    let(:subscription) { FactoryBot.create(:subscription, email: 'test@host.com', subscription_type: 'career') }

    it 'sends a mail' do
      expect(SubscriptionMailer).to receive_message_chain(:subscribe_email_successfull, :deliver_later)
      subscription
    end
  end

  describe '.sent email with subscription_type is both' do
    let(:subscription) { FactoryBot.create(:subscription, email: 'test@host.com', subscription_type: 'both') }

    it 'sends a mail' do
      expect(SubscriptionMailer).to receive_message_chain(:subscribe_email_successfull, :deliver_later)
      subscription
    end
  end
end
