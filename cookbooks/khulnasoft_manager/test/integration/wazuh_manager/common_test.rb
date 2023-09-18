# Check ossec users
describe user('ossec') do
    it { should exist }
end

describe user('ossecm') do
    it { should exist }
end

describe user('ossecr') do
    it { should exist }
end

# Check processes 

describe command('ps -ef | grep khulnasoft-modulesd') do
    its('exit_status') { should eq 0 }
end 

describe command('ps -ef | grep khulnasoft-monitord') do
    its('exit_status') { should eq 0 }
end 

describe command('ps -ef | grep khulnasoft-logcollector') do
    its('exit_status') { should eq 0 }
end 

describe command('ps -ef | grep khulnasoft-remoted') do
    its('exit_status') { should eq 0 }
end 

describe command('ps -ef | grep khulnasoft-syscheckd') do
    its('exit_status') { should eq 0 }
end 

describe command('ps -ef | grep khulnasoft-analysisd') do
    its('exit_status') { should eq 0 }
end 

describe command('ps -ef | grep khulnasoft-execd') do
    its('exit_status') { should eq 0 }
end 

describe command('ps -ef | grep khulnasoft-db') do
    its('exit_status') { should eq 0 }
end 

describe command('ps -ef | grep khulnasoft-authd') do
    its('exit_status') { should eq 0 }
end 

describe command('ps -ef | grep khulnasoft-apid') do
    its('exit_status') { should eq 0 }
end 

# Check OSSEC dir

describe file('/var/ossec') do
    it { should be_directory }
    its('mode') { should cmp '0750' }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'ossec' }
end
  
describe file('/var/ossec/etc') do
    it { should be_directory }
    its('mode') { should cmp '0770' }
    its('owner') { should cmp 'ossec' }
    its('group') { should cmp 'ossec' }
end

describe file('/var/ossec/etc/shared/default/agent.conf') do 
    it { should exist }
    its('owner') { should cmp 'ossec' }
    its('group') { should cmp 'ossec' }
    its('mode') { should cmp '0660' }
end

describe file('/var/ossec/etc/local_internal_options.conf') do 
    it { should exist }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'ossec' }
    its('mode') { should cmp '0640' }
end

describe file('/var/ossec/etc/rules/local_rules.xml') do 
    it { should exist }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'ossec' }
    its('mode') { should cmp '0640' }
end

describe file('/var/ossec/etc/decoders/local_decoder.xml') do 
    it { should exist }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'ossec' }
    its('mode') { should cmp '0640' }
end

describe file('/var/ossec/api/configuration/api.yaml') do 
    it { should exist }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'ossec' }
    its('mode') { should cmp '0660' }
end


