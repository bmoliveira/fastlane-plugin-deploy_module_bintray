require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class DeployModuleBintrayHelper
      # class methods that you define here become available in your action
      # as `Helper::DeployModuleBintrayHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the deploy_module_bintray plugin helper!")
      end
    end
  end
end
