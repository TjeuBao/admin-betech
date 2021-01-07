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
#  slug               :string
#  source             :string
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  post_category_id   :bigint
#
# Indexes
#
#  index_posts_on_post_category_id  (post_category_id)
#  index_posts_on_slug              (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'factories' do
    let(:post_category) { FactoryBot.create(:post_category) }
    subject { FactoryBot.build :post, :with_image_from_file, post_category_id: post_category.id }
    it { should be_valid }
  end

  describe 'validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:image) }
  end

  describe 'assocation' do
    it { is_expected.to belong_to :post_category }
  end

  describe 'serializable_rich_content' do
    subject { FactoryBot.build(:post, :with_image_from_file, content: 'Test content') }
    it { expect(subject.serializable_rich_content).to eq ActionController::Base.helpers.raw(subject.content) }
  end

  describe '.sent email with subcription type is post' do
    let(:post_category) { FactoryBot.create(:post_category) }
    let(:post) { FactoryBot.create(:post, :with_image_from_file, post_category_id: post_category.id) }
    let!(:subscription) { FactoryBot.create(:subscription, email: 'test@host.com', subscription_type: 'post') }

    it 'sends a mail' do
      expect(SubscriptionMailer).to receive_message_chain(
        :subscription_email_for_post,
        :deliver_later
      )
      post
    end
  end

  describe '.sent email with subcription type is both' do
    let(:post_category) { FactoryBot.create(:post_category) }
    let(:post) { FactoryBot.create(:post, :with_image_from_file, post_category_id: post_category.id) }
    let!(:subscription) { FactoryBot.create(:subscription, email: 'test@host.com', subscription_type: 'both') }

    it 'sends a mail' do
      expect(SubscriptionMailer).to receive_message_chain(
        :subscription_email_for_post,
        :deliver_later
      )
      post
    end
  end
end
