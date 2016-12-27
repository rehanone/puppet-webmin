require 'spec_helper'

describe 'webmin' do
  let :facts do
    {
      :os => { :name => 'RedHat', },
    }
  end

  let :params do
    {
      :service_manage => false,
    }
  end

  it { is_expected.to compile.with_all_deps }

  context 'with default values for all parameters' do
    it { should contain_class('webmin::repo') }
    it { should contain_class('webmin::install') }
    it { should contain_class('webmin::config') }
    it { should contain_class('webmin::service') }
    it { should contain_class('webmin::firewall') }
  end
end
