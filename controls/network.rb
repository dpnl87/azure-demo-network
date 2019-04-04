control 'azurerm_virtual_network' do
  title "Check vnet 'demo'"
  desc "Check if vnet 'demo' is present and in compliant state"

  describe azurerm_virtual_network(resource_group: 'inspec-demo', name: 'demo-network') do
    it { should exist }
    its('location') { should eq('westeurope') }
    its('name') { should eq('demo-network') }
    its('type') { should eq 'Microsoft.Network/virtualNetworks' }
    its('subnets') { should eq ['internal'] }
    its('address_space') { should eq ['10.0.0.0/16'] }
    its('dns_servers') { should eq ['1.0.0.1', '1.1.1.1'] }
    its('enable_ddos_protection') { should eq false }
  end
end

control 'azurerm_subnet' do
  title "Check subnet 'internal'"
  desc "Check if subnet 'internal' is present and in compliant state"

  describe azurerm_subnet(resource_group: 'inspec-demo', vnet: 'demo-network', name: 'internal') do
    it { should exist }
    its('name') { should eq('internal') }
    its('type') { should eq 'Microsoft.Network/virtualNetworks/subnets' }
    its('address_prefix') { should eq '10.0.2.0/24' }
  end
end

control 'azurerm_network_security_group' do
  title "Check nsg 'inspec-demo-security-group'"
  desc "Check if nsg 'inspec-demo-security-group' is present and in compliant state"

  describe azurerm_network_security_group(resource_group: 'inspec-demo', name: 'inspec-demo-security-group') do
    it { should exist }
    it { should allow_ssh_from_internet }
    it { should_not allow_rdp_from_internet }
    its('security_rules') { should_not be_empty }
    its('default_security_rules') { should_not be_empty }
  end
end
