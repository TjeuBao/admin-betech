module Api
  module V1
    class JobSubmissionsController < ApplicationController
      def create
        @job_submission = JobSubmission.new(submit_params)
        if @job_submission.save
          render json: JobSubmissionSerializer.new(@job_submission).serialized_json, status: :created
        else
          render json: @job_submission.errors, status: :unprocessable_entity
        end
      end

      private

      def submit_params
        params.require(:job_submission).permit(:first_name, :last_name, :email, :port_folio, :answer, :cv_upload, :career_id)
      end
    end
  end
end
