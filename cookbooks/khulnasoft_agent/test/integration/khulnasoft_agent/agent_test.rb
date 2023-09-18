describe package('khulnasoft-agent') do
    it { should be_installed }
end

describe service('khulnasoft-agent') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
end