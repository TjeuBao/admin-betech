# == Schema Information
#
# Table name: careers
#
#  id                 :bigint           not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  job_type           :string
#  slug               :string
#  status             :string
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_careers_on_slug  (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe Career, type: :model do
  describe 'factories' do
    subject { FactoryBot.build :career }
    it { should be_valid }
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :content }
    it do
      should define_enum_for(:status)
        .with_values(
          open: 'Open',
          job_filled: 'Job Filled'
        )
        .backed_by_column_of_type(:string)
    end
  end

  describe 'serializable_rich_content' do
    subject { FactoryBot.build(:post, :with_image_from_file, content: 'Test content') }
    it { expect(subject.serializable_rich_content).to eq ActionController::Base.helpers.raw(subject.content) }
  end



  # describe 'Not sent email, status career is not open' do
  #   let(:career) { FactoryBot.create(:career, status: status.job_filled) }
  #   let!(:subscription) { FactoryBot.create(:subscription, email: 'test@host.com', subscription_type: 'both') }

  #   it 'not sends a mail' do
  #     expect(sent_email).to eq nil
  #   end
  # end

  describe 'callbacks' do
    describe '.sent email with subcription type is career' do
      let(:career) { FactoryBot.create(:career, status: 'open') }
      let!(:subscription) { FactoryBot.create(:subscription, email: 'test@host.com', subscription_type: 'career') }

      it 'sends a mail' do
        expect(SubscriptionMailer).to receive_message_chain(
          :subscription_email_for_career,
          :deliver_later
        )
        career
      end
    end

    describe '.sent email with subcription type is both' do
      let(:career) { FactoryBot.create(:career, status: 'open') }
      let!(:subscription) { FactoryBot.create(:subscription, email: 'test@host.com', subscription_type: 'both') }

      it 'sends a mail' do
        expect(SubscriptionMailer).to receive_message_chain(
          :subscription_email_for_career,
          :deliver_later
        )
        career
      end
    end
    describe '#send_email' do
      let(:career) { build(:career, status: Career::STATUSES[1]) }

      before do
        allow_any_instance_of(Career).to receive(:send_mail).and_return(nil)
      end

      it 'should not sent email' do
        expect(career).to receive(:send_mail)
        career.save
      end
    end
  end
end
