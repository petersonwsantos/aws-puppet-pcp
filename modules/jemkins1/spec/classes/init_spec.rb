require 'spec_helper'
describe 'jemkins' do
  context 'with default values for all parameters' do
    it { should contain_class('jemkins') }
  end
end
