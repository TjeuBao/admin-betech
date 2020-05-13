module Api
  module V1
    class JobSubmissionSerializer
      include FastJsonapi::ObjectSerializer
      attributes  :first_name,
                  :last_name,
                  :email,
                  :port_folio,
                  :answer
    end
  end
end
