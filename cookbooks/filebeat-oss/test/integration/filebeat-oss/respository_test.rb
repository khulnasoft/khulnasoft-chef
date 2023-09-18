# frozen_string_literal: true

case os.family
when 'debian'
    describe apt('https://packages.khulnasoft.com/4.x/apt/') do
        it { should exist }
        it { should be_enabled }
    end
when 'redhat', 'suse'
    describe yum.repo('khulnasoft') do
        it { should exist }
        it { should be_enabled }
    end 
end