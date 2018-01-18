describe Fastlane::Actions::DeployModuleBintrayAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The deploy_module_bintray plugin is working!")

      Fastlane::Actions::DeployModuleBintrayAction.run(nil)
    end
  end
end
