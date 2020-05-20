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
#  status             :string
#  title              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class CareerSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :title,
              :content,
              :job_type,
              :status
  attributes :content do |career|
    ActionController::Base.helpers.sanitize(ActionController::Base.helpers.raw(career.content))
  end
end
