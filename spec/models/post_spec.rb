# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validetess' do
    it { is_expected.to validate_presence_of :title }
  end
  context 'validates' do
    it { is_expected.to validate_presence_of :content }
  end
end
