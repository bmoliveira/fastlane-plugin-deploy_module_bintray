require 'fastlane/action'
require_relative '../helper/deploy_module_bintray_helper'

module Fastlane
  module Actions
    class DeployModuleBintrayAction < Action
      def self.run(params)
        module_name = params[:module_name]
        should_clean? = params[:should_clean?] ?: false
        UI.message "Deploying module: #{module_name} to bintray"
        if should_clean?
          UI.message "Cleaning project"
          gradle(task: "clean")
        end
        gradle(task: ":#{module_name}:install")
        gradle(task: ":#{module_name}:bintrayUpload")
        UI.message "Module uploaded: #{module_name} to bintray, go to bintray to upload to JCenter."
      end

      def self.description
        "Gradle actions to deploy a module from an Android project"
      end

      def self.authors
        ["Bruno Oliveira"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "This plugin runs a gradle clean, gradle install <module-name> and gradle bintrayUpload <module-name>"
      end

      def self.available_options
        [
           FastlaneCore::ConfigItem.new(key: :module_name,
                                   env_name: "FL_DEPLOY_MODULE_NAME",
                                description: "project module to deploy",
                                   optional: false,
                                       type: String),
           FastlaneCore::ConfigItem.new(key: :should_clean?,
                                        env_name: "FL_DEPLOY_SHOULD_DEPLOY",
                                        description: "Flag to indicate if the project should be clean before install",
                                        optional: true,
                                        type: Boolean,
                                        default_value: false))
        ]
      end

      def self.is_supported?(platform)
        [:android].include?(platform)
      end
    end
  end
end
