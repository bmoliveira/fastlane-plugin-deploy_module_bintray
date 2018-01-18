require 'fastlane/action'
require_relative '../helper/deploy_module_bintray_helper'

module Fastlane
  module Actions
    class DeployModuleBintrayAction < Action
      def self.run(params)
        module_name = params[:module_name]
        UI.message "Deploying module :#{module_name} to bintray"
        if params[:should_clean]
          UI.message "Cleaning project"
          cleanOptions = FastlaneCore::Configuration.create(Actions::GradleAction.available_options, { task: "clean" })
          Actions::GradleAction.run(cleanOptions)
        end
        installOptions = FastlaneCore::Configuration.create(Actions::GradleAction.available_options, { task: ":#{module_name}:install" })
        cleanOptions = FastlaneCore::Configuration.create(Actions::GradleAction.available_options, { task: ":#{module_name}:bintrayUpload" })

        Actions::GradleAction.run(installOptions)
        UI.message "Uploading Module :#{module_name} to bintray"
        Actions::GradleAction.run(cleanOptions)
        UI.message "Module uploaded :#{module_name} to bintray, go to bintray to upload to JCenter."
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
                                   env_name: "FL_DEPLOY_BINTRAY_MODULE_NAME",
                                description: "project module to deploy",
                                   optional: false,
                                       type: String),
           FastlaneCore::ConfigItem.new(key: :should_clean,
                                        env_name: "FL_DEPLOY_BINTRAY_SHOULD_DEPLOY",
                                        description: "Flag to indicate if the project should be clean before install",
                                        optional: true,
                                        type: Boolean,
                                        default_value: false)
        ]
      end

      def self.is_supported?(platform)
        [:android].include?(platform)
      end
    end
  end
end
