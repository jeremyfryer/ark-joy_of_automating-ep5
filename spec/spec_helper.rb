require 'chefspec'
require 'chefspec/berkshelf'
require 'pry'

at_exit { ChefSpec::Coverage.report! }

shared_examples 'installs necessary packages' do
  it 'installs necessary packages' do
    packages.each do |package_name|
      expect(chef_run).to install_package(package_name)
    end
  end
end

shared_context 'chef run' do
  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(platform_details)
    runner.converge(described_recipe)
  end

  let(:platform_details) { Hash.new }

  let(:node) { chef_run.node }
  let(:attribute) { node['ark'] }
end
