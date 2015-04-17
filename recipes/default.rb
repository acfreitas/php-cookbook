#Install PHP
php_packages = ['php5',
                'php5-common',
                'php5-dev',
                'php5-cli',
                'php-pear',
                'php5-curl',
                'php5-gd',
                'php5-xdebug']
php_packages.each do |php|
  apt_package php do
    action :install
  end
end

remote_file "/usr/local/bin/composer" do
  source "https://getcomposer.org/composer.phar"
  mode '0755'
end

execute "move PythonRemoteDebugging" do
  command "sudo mv /tmp/Komodo-PythonRemoteDebugging-4.4.1-20896-linux-x86 /usr/local/pydbgpproxy"
  action :nothing
end

execute "unpack PythonRemoteDebugging" do
  command "tar zxvf /tmp/Komodo-PythonRemoteDebugging-4.4.1-20896-linux-x86.tar.gz -C /tmp"
  action :nothing
  notifies :run, "execute[move PythonRemoteDebugging]", :immediately
end

remote_file "/tmp/Komodo-PythonRemoteDebugging-4.4.1-20896-linux-x86.tar.gz" do
  source "http://downloads.activestate.com/Komodo/releases/archive/4.x/4.4.1/remotedebugging/Komodo-PythonRemoteDebugging-4.4.1-20896-linux-x86.tar.gz"
  user "root"
  mode 0644
  action :create
  notifies :run, "execute[unpack PythonRemoteDebugging]", :immediately
end

template "/usr/bin/debug" do
  source "debug.erb"
  user "root"
  mode 0755
  notifies :run, "execute[run debug]", :immediately
end

execute "run debug" do
  command "debug &"
  action :nothing
end

template "/etc/php5/conf.d/xdebug.ini" do
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode 0755
end

template "/etc/rc.local" do
  source "rc.local.erb"
  owner "root"
  group "root"
  mode 0755
end
