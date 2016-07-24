require 'spec_helper'

describe 'ark::default' do
  context 'when no attributes are specified, on FreeBSD' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'freebsd', version: '10.2')
      runner.converge(described_recipe)
    end

    let(:packages) do
      %w[ libtool autoconf unzip rsync gmake gcc autogen gtar ]
    end

    #test for necessary packages
    include_examples 'installs necessary packages'

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/usr/bin/tar'
    end
  end

end
