# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id                 :bigint           not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  post_type          :string
#  source             :string
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'factories' do
    subject { FactoryBot.build :post, :with_image_from_file }
    it { should be_valid }
  end

  describe 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:image) }
  end

  describe 'serializable_rich_content' do
    subject { FactoryBot.build(:post, :with_image_from_file, content: 'Test content') }
    it { expect(subject.serializable_rich_content).to eq ActionController::Base.helpers.raw(subject.content) }
  end

  describe '.sent email' do
    let(:post) { FactoryBot.create(:post, :with_image_from_file) }
    let!(:subscription) { FactoryBot.create(:subscription, email: 'test@host.com', subscription_type: 'post') }

    it 'sends a mail' do
      expect(SubscriptionMailer).to receive_message_chain(:subscription_email_for_post, :deliver_later)
      post
    end
  end
end
