require 'spec_helper'
describe 'webmin::service', :type => :class do
  let :pre_condition do
      'class { "webmin": }'
  end

  let(:facts) { {
    :operatingsystem => 'Archlinux'
  } }

  it { is_expected.to contain_service('webmin') }
end
