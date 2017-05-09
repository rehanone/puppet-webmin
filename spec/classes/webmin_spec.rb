require 'spec_helper'

describe 'webmin' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      describe 'webmin::install' do
        describe 'should allow package ensure to be overridden' do
          let(:params) do
            {
              package_ensure: 'latest',
              package_name: 'webmin_super',
              package_manage: true,
            }
          end

          it {
            is_expected.to contain_package('webmin_super').with_ensure('latest')
          }
        end

        describe 'should allow the package name to be overridden' do
          let(:params) do
            {
              package_ensure: 'present',
              package_name: 'webmin',
              package_manage: true,
            }
          end

          it {
            is_expected.to contain_package('webmin').with_ensure('present')
          }
        end

        describe 'should allow the package to be unmanaged' do
          let(:params) do
            {
              package_manage: false,
              package_name: 'webmin',
            }
          end

          it {
            is_expected.not_to contain_package('webmin')
          }
        end
      end

      describe 'webmin::config' do
        it {
          is_expected.to contain_webmin__option('port').with_value('10000')
          is_expected.to contain_webmin__option('ssl').with_value(true)
          is_expected.to contain_webmin__option('keyfile').with_value('/etc/webmin/miniserv.pem')
          is_expected.to contain_webmin__option('certfile').with_value('/etc/webmin/miniserv.cert')
          is_expected.to contain_webmin__option('extracas').with_value('/etc/webmin/extracas.chain')
          is_expected.to contain_webmin__option('no_ssl2').with_value(true)
          is_expected.to contain_webmin__option('no_ssl3').with_value(true)
          is_expected.to contain_webmin__option('no_tls1').with_value(true)
          is_expected.to contain_webmin__option('no_tls1_1').with_value(true)
          is_expected.to contain_webmin__option('no_tls1_2').with_value(false)
          is_expected.to contain_webmin__option('ssl_redirect').with_value(true)
          is_expected.to contain_webmin__option('allow').with_value([])
        }

        it {
          is_expected.to have_webmin__option_resource_count(12)
        }
      end

      describe 'webmin::service' do
        let(:params) do
          {
            service_manage: true,
            service_enable: true,
            service_ensure: 'running',
            service_name: 'webmin',
          }
        end

        it {
          is_expected.to contain_service('webmin').with(
            ensure: 'running',
            enable: true,
            name: 'webmin',
          )
        }
      end
    end
  end
end
