require 'spec_helper'

describe 'ark::default' do
  context 'when no attributes are specified, on an unspecified platform' do
    include_context 'chef run'

    let(:packages) do
      %w[ libtool autoconf unzip rsync make gcc autogen ]
    end

    #test for necessary packages
    include_examples 'installs necessary packages'

    it "does not install the gcc-c++ package" do
      expect(chef_run).not_to install_package("gcc-c++")
    end

    it "does not include the seven_zip recipe" do
      expect(chef_run).not_to include_recipe("seven_zip")
    end

    it "apache mirror" do
      expect(attribute['apache_mirror']).to eq "http://apache.mirrors.tds.net"
    end

    it "prefix root" do
      expect(attribute['prefix_root']).to eq "/usr/local"
    end

    it "prefix bin" do
      expect(attribute['prefix_bin']).to eq "/usr/local/bin"
    end

    it "prefix home" do
      expect(attribute['prefix_home']).to eq "/usr/local"
    end

    it "tar binary" do
      expect(attribute['tar']).to eq "/bin/tar"
    end
  end

  context 'when no attributes are specified, on Mac OSX' do
    include_context 'chef run'

    let(:platform_details) do
      { platform: 'mac_os_x', version: '10.11.1' }
    end

    it 'installs necessary packages' do
      expect(chef_run).not_to install_package('libtool')
      expect(chef_run).not_to install_package('autoconf')
      expect(chef_run).not_to install_package('unzip')
      expect(chef_run).not_to install_package('rsync')
      expect(chef_run).not_to install_package('make')
      expect(chef_run).not_to install_package('gcc')
    end

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/usr/bin/tar'
    end
  end

  context 'when no attributes are specified, on RHEL' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'redhat', platform_family: 'rhel', version: '6.5')
      runner.converge(described_recipe)
    end

    it 'installs necessary packages' do
      expect(chef_run).to install_package('libtool')
      expect(chef_run).to install_package('autoconf')
      expect(chef_run).to install_package('unzip')
      expect(chef_run).to install_package('rsync')
      expect(chef_run).to install_package('make')
      expect(chef_run).to install_package('gcc')
      expect(chef_run).to install_package('xz-lzma-compat')
      expect(chef_run).to install_package('bzip2')
      expect(chef_run).to install_package('tar')
    end
  end

  context 'when no attributes are specified, on SmartOS' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'smartos', version: '5.11')
      runner.converge(described_recipe)
    end

    it 'installs necessary packages' do
      expect(chef_run).to install_package('libtool')
      expect(chef_run).to install_package('autoconf')
      expect(chef_run).to install_package('unzip')
      expect(chef_run).to install_package('rsync')
      expect(chef_run).to install_package('make')
      expect(chef_run).to install_package('gcc')
      expect(chef_run).to install_package('gtar')
      expect(chef_run).to install_package('autogen')
    end

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '/bin/gtar'
    end
  end

  context 'when no attributes are specified, on Windows' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'windows', version: '2012R2')
      runner.converge(described_recipe)
    end

    it 'does not installs packages' do
      expect(chef_run).not_to install_package('libtool')
      expect(chef_run).not_to install_package('autoconf')
      expect(chef_run).not_to install_package('unzip')
      expect(chef_run).not_to install_package('rsync')
      expect(chef_run).not_to install_package('make')
      expect(chef_run).not_to install_package('gmake')
      expect(chef_run).not_to install_package('gcc')
      expect(chef_run).not_to install_package('autogen')
      expect(chef_run).not_to install_package('xz-lzma-compat')
      expect(chef_run).not_to install_package('bzip2')
      expect(chef_run).not_to install_package('tar')
    end

    it "tar binary" do
      attribute = chef_run.node['ark']['tar']
      expect(attribute).to eq '"C:\7-zip\7z.exe"'
    end
  end
end
