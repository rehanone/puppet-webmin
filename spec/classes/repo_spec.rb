require 'spec_helper'
describe 'webmin::repo', :type => :class do
  let :pre_condition do
      'class { "webmin": }'
  end

  let(:facts) { {
    :operatingsystem => 'CentOS',
    :lsbdistcodename => 'xenial'
  } }

  it { is_expected.to contain_yumrepo('webmin') }
end
