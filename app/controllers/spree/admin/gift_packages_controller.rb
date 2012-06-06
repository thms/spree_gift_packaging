module Spree
  module Admin
    class GiftPackagesController < ResourceController
      respond_to :html
      before_filter :load_data
      
      private

      def load_data
        @calculators = GiftPackage.calculators.sort_by(&:name)
      end
      


    end
  end
end

