# To check the correct dependencies are set up for webmin.

require 'spec_helper'
describe 'webmin' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it {
        is_expected.to compile.with_all_deps
      }

      describe 'Testing the dependencies between the classes' do
        it { is_expected.to contain_class('webmin::repo') }
        it { is_expected.to contain_class('webmin::install') }
        it { is_expected.to contain_class('webmin::config') }
        it { is_expected.to contain_class('webmin::service') }
        it { is_expected.to contain_class('webmin::firewall') }

        it { is_expected.to contain_class('webmin::repo').that_comes_before('Class[webmin::install]') }
        it { is_expected.to contain_class('webmin::install').that_comes_before('Class[webmin::config]') }
        it { is_expected.to contain_class('webmin::config').that_comes_before('Class[webmin::service]') }
        it { is_expected.to contain_class('webmin::service').that_comes_before('Class[webmin::firewall]') }
      end
    end
  end
end
