module Spree
  module Admin
    class GiftPackageExceptionsController < ResourceController
      respond_to :html
      before_filter :load_data
      
      private

      # Load up any additional data we might need
      def load_data
       ## @calculators = GiftPackage.calculators.sort_by(&:name)
      end
      


    end
  end
end

