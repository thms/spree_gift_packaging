module Spree
  module Admin
    class GiftPackageExceptionsController < ResourceController
      respond_to :html
      before_filter :load_data
      
      protected

      # Load up any additional data we might need
      def load_data
       ## @calculators = GiftPackage.calculators.sort_by(&:name)
      end
      
      def collection
        params[:search] ||= {}
        @search = super.metasearch(params[:search])
      end
      


    end
  end
end

