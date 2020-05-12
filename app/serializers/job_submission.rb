class JobSubmissionSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :first_name,
              :last_name,
              :email,
              :port_folio,
              :answer,
              :career_id
end
