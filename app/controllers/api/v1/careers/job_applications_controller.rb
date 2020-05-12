module Api
  module V1
    class CareersController < ApplicationController
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
        params.require(:career).permit(:first_name,
                                       :last_name,
                                       :email,
                                       :port_folio,
                                       :answer,
                                       :cv_upload)
      end
    end
  end
end
