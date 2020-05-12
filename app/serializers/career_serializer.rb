class CareerSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :title,
              :content,
              :job_type,
              :status
end
