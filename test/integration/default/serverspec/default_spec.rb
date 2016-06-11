require 'spec_helper'

describe 'unifi_controller::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  describe command('curl -k https://localhost:8443/wizard/s/default') do
    its(:stdout) {should match /Setup - UniFi Controller/ }
  end
end
