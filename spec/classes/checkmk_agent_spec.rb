require 'spec_helper'

describe 'checkmk::agent', :type => :class do

  context "On Debian" do
    let(:facts) {{ :osfamily => 'Debian' }}

    it { is_expected.to contain_package('check-mk-agent') }

  end
end
