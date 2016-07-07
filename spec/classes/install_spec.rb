require 'spec_helper'
describe 'webmin::install', :type => :class do
  let :pre_condition do
      'class { "webmin": }'
  end

  let(:facts) { {
    :operatingsystem => 'Archlinux'
  } }

  it { is_expected.to contain_package('webmin') }
end
