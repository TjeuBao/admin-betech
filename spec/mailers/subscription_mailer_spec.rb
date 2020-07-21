require 'rails_helper'

RSpec.describe SubscriptionMailer, type: :mailer do
  describe '.subscription_email_for_post' do
    before do
      @post = FactoryBot.create(:post, :with_image_from_file)
      @reveiver_email = 'to_reveiver@gmail.com'
      @mail = SubscriptionMailer.subscription_email_for_post('to_reveiver@gmail.com', @post.id)
    end

    it 'renders the headers' do
      expect(@mail.subject).to eq('Subscription Email')
      expect(@mail.to).to eq([@reveiver_email])
      expect(@mail.from).to eq(['golden_owl@goldenowl.asia'])
    end

    it 'renders the body' do
      expect(@mail.body.encoded).to include('GOLDEN OWL - NEW BLOG')
      expect(@mail.body.encoded).to include("https://golden-owl-web.herokuapp.com/blog/details/#{@post.slug}")
    end
  end

  describe '.subscription_email_for_carrer' do
    before do
      @career = FactoryBot.create(:career)
      @reveiver_email = 'to_reveiver@gmail.com'
      @mail = SubscriptionMailer.subscription_email_for_career('to_reveiver@gmail.com', @career.id)
    end

    it 'renders the headers' do
      expect(@mail.subject).to eq('Subscription Email')
      expect(@mail.to).to eq([@reveiver_email])
      expect(@mail.from).to eq(['golden_owl@goldenowl.asia'])
    end

    it 'renders the body' do
      expect(@mail.body.encoded).to include('GOLDEN OWL - NEW CAREER')
      expect(@mail.body.encoded).to include("https://golden-owl-web.herokuapp.com/careers/details/#{@career.slug}")
    end
  end
end
