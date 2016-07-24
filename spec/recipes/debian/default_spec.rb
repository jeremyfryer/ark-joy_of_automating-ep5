require 'spec_helper'

describe 'ark::default' do
  context 'when no attributes are specified, on Debian' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', platform_family: 'debian', version: '14.04')
      runner.converge(described_recipe)
    end

    let(:packages) do
      %w( libtool autoconf unzip rsync make gcc autogen shtool pkg-config )
    end

    # test for necessary packages
    include_examples 'installs necessary packages'
  end
end
