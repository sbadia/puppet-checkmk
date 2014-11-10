require 'spec_helper_acceptance'

describe 'checkmk::agent::xinetd class' do
  context 'default parameters' do
   it 'should work with no errors' do
     pp= <<-EOS

      class {'checkmk::agent::xinetd': }
    EOS

    # Run it twice and test for idempotency
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end

 end
end
