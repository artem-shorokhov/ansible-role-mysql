sql = mysql_session('root','root')

control 'no-anonymous-user' do
  impact 0.7
  title 'Anonymous access should be disabled.'
  describe sql.query('SELECT * FROM mysql.user WHERE User = \'\';') do
    its('stdout') { should match(//) }
  end
end


control 'no-test-db' do
  impact 0.7
  title 'Default test database should be absent.'
  describe sql.query('show databases like \'test\';') do
    its('stdout') { should_not match(/test/) }
  end
end

