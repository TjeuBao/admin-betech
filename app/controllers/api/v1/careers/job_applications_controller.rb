module Api
  module V1
    module Career
      def create
        @career = Career.new(career_params)

        respond_to do |format|
          if @career.save
            format.json { render @career, status: :created, location: @career }
          else
            format.json { render json: @career.errors, status: :unprocessable_entity }
          end
        end
      end

      def career_params
        params.require(:career).permit(:title, :content, :job_type, :status, :image)
      end
    end
  end
end
