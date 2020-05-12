class Api::V1::Careers::JobSubmit < ApplicationController
  def create
    @job_submission = job_submission.new(submit_params)
    respond_to do |format|
      if @job_submission.save
        format.html { redirect_to @job_submission, notice: 'Career was successfully created.' }
        format.json { render @job_submission, status: :created, location: @job_submission }
      else
        format.html { render :new }
        format.json { render json: @job_submission.errors, status: :unprocessable_entity }
      end
  end

  def submit_params
    params.require(:job_submission).permit(
                                            :first_name,
                                            :last_name,
                                            :email,
                                            :port_folio,
                                            :answer,
                                            :cv_upload,
                                            :career_id
                                          )
  end
end
