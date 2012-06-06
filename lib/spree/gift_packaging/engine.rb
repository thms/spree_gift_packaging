module Spree
  module GiftPackaging
    class Engine < Rails::Engine
      isolate_namespace Spree
      engine_name 'spree_gift_packaging'

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), "../../../app/overrides/*.rb")) do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
        
        Dir.glob(File.join(File.dirname(__FILE__), '../../../app/**/*_decorator*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
        
      end

      config.autoload_paths += %W(#{config.root}/lib)
      config.to_prepare &method(:activate).to_proc

      # Register the new calculator for gift packaging
      initializer 'spree.gift_packaging.register.gift_package.calculators' do |app|
        app.config.spree.calculators.add_class('gift_packages')
        app.config.spree.calculators.gift_packages = [
          Spree::Calculator::GiftPackaging
        ]
      end
      
 
    end
  end
end
