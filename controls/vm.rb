control 'azurerm_virtual_machine' do
  title "Check vm 'inspec-demo-vm'"
  desc "Check if vm 'inspec-demo-vm' is present and in compliant state"

  describe azurerm_virtual_machine(resource_group: 'inspec-demo', name: 'inspec-demo-vm') do
    it { should exist }
    its('location') { should eq('westeurope') }
    its('name') { should eq('inspec-demo-vm') }
    its('type') { should eq 'Microsoft.Compute/virtualMachines' }
  end
end
