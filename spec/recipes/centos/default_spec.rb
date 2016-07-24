require 'spec_helper'

describe 'ark::default' do
  context 'when no attributes are specified, on CentOS' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'centos', version: '6.7')
      runner.converge(described_recipe)
    end

    let(:packages) do
      %w( libtool autoconf unzip rsync make gcc xz-lzma-compat bzip2 tar )
    end

    # test for necessary packages
    include_examples 'installs necessary packages'
  end
end
