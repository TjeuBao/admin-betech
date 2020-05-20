require 'rails_helper'

RSpec.describe Api::V1::JobSubmissionsController, type: :controller do
  describe 'POST create' do
    context 'with invalid attributes' do
      let(:empty_job_submission_params) { attributes_for(:job_submission, :invaid_job_submission) }

      it 'Career was not created' do
        expect { post :create, params: { job_submission: empty_job_submission_params }, format: :json }.not_to change(JobSubmission, :count)
      end
    end

    context 'Career was successfully created' do
      let(:valid_job_submission_param) { attributes_for(:job_submission) }

      it 'create a new job_submission' do
        expect { post :create, params: { job_submission: valid_job_submission_param }, format: :json }.to change { JobSubmission.count }.by(1)
      end
    end
  end
end
