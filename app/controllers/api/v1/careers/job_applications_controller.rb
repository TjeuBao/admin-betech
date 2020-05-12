module Api
  module V1
    class CareersController < ApplicationController
      def create
        @career = Career.create(career_params)
        render json: @career
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
