require 'spec_helper'

describe 'checkmk::server', :type => :class do

  context "On Debian" do
    let(:facts) {{
      :osfamily        => 'Debian',
      :operatingsystem => 'Debian'
    }}

    it { is_expected.to contain_package('monitoring-plugins') }

  end

  context "On Ubuntu" do
    let(:facts) {{
      :osfamily        => 'Debian',
      :operatingsystem => 'Ubuntu'
    }}

    it { is_expected.to contain_package('nagios-plugins') }

  end

end
