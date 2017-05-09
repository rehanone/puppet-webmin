require 'spec_helper'

describe 'webmin::option' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :pre_condition do
        'class { "webmin": }'
      end

      context 'with boolean true as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: true } }

        it {
          is_expected.to contain_augeas('webmin-test').with(
            'incl' => '/etc/webmin/miniserv.conf',
            'lens' => 'Webmin.lns',
            'changes' => 'set "test" "1"',
          )
        }
      end

      context 'with boolean false as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: false } }

        it {
          is_expected.to contain_augeas('webmin-test').with(
            'incl' => '/etc/webmin/miniserv.conf',
            'lens' => 'Webmin.lns',
            'changes' => 'clear "test"',
          )
        }
      end

      context 'with integer as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: 100 } }

        it {
          is_expected.to contain_augeas('webmin-test').with(
            'incl' => '/etc/webmin/miniserv.conf',
            'lens' => 'Webmin.lns',
            'changes' => 'set "test" "100"',
          )
        }
      end

      context 'with string as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: 'ssl' } }

        it {
          is_expected.to contain_augeas('webmin-test').with(
            'incl' => '/etc/webmin/miniserv.conf',
            'lens' => 'Webmin.lns',
            'changes' => 'set "test" "ssl"',
          )
        }
      end

      context 'with an empty array as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: [] } }

        it {
          is_expected.to contain_augeas('webmin-test').with(
            'incl' => '/etc/webmin/miniserv.conf',
            'lens' => 'Webmin.lns',
            'changes' => 'clear "test"',
          )
        }
      end

      context 'with an array of strings as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: %w[ssl tls] } }

        it {
          is_expected.to contain_augeas('webmin-test').with(
            'incl' => '/etc/webmin/miniserv.conf',
            'lens' => 'Webmin.lns',
            'changes' => 'set "test" "ssl tls"',
          )
        }
      end
    end
  end
end
