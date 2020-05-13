class AddFileToJobSubmission < ActiveRecord::Migration[6.0]
  def change
    def up
      add_attachment :job_submission, :cv_upload
    end

    def down
      remove_attachment :job_submission, :cv_upload
    end
  end
end
