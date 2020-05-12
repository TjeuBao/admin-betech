module Api
  module V1
    module Careers
      class JobSubmission < ApplicationController
        def create
          @job_submission = job_submission.new(submit_params)
          respond_to do |format|
            if @job_submission.save
              format.json { render @job_submission, status: :created, location: @job_submission }
            else
              format.html { render :new }
              format.json { render json: @job_submission.errors, status: :unprocessable_entity }
            end
          end
        end

        def submit_params
          params.require(:job_submission).permit(:first_name, :last_name, :email, :port_folio, :answer, :cv_upload, :career_id)
        end
      end
    end
  end
end
