control 'repositories' do
  impact 0.5
  title 'Required repositories should be available.'
  describe yum do
    its('repos') { should include 'mysql-connectors-community/x86_64' }
    its('repos') { should include 'mysql-tools-community/x86_64' }
    its('repos') { should include 'mysql56-community/x86_64' }
  end
end

control 'packages' do
  impact 1.0
  title 'Required packages should be installed.'
  describe package('mysql-community-server') do
    it { should be_installed }
  end
  describe package('MySQL-python') do
    it { should be_installed }
  end
end

control 'config-file' do
  impact 1.0
  title 'Configuration file should be in place.'
  describe file('/etc/my.cnf') do
    it { should exist }
  end
end

control 'mysql-daemon' do
  impact 1.0
  title 'MySQL daemon should be installed/enabled/running.'
  describe service('mysqld') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
