describe package('khulnasoft-manager') do
    it { should be_installed }
end

describe service('khulnasoft-manager') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
end

describe port(55000) do
    it { should be_listening }
    its('processes') {should include 'python3'}
end

describe port(1515) do
    it { should be_listening }
    its('processes') {should include 'khulnasoft-authd'}
end

describe port(1514) do
    it { should be_listening }
    its('processes') {should include 'khulnasoft-remoted'}
end
