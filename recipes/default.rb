include_recipe 'apt'

#Install PHP
php_packages = ['php5',
                'php5-common',
                'php5-dev',
                'php5-cli',
                'php-pear'] 
php_packages.each do |php|
  apt_package php do
    action :install
  end
end

remote_file "/usr/local/bin/phpunit" do
  source "https://phar.phpunit.de/phpunit.phar"
  mode '0755'
end

remote_file "/usr/local/bin/phploc" do
  source "https://phar.phpunit.de/phploc.phar"
  mode '0755'
end

remote_file "/usr/local/bin/pdepend" do
  source "http://static.pdepend.org/php/latest/pdepend.phar"
  mode '0755'
end

remote_file "/usr/local/bin/phpmd" do
  source "http://static.phpmd.org/php/2.1.3/phpmd.phar"
  mode '0755'
end

remote_file "/usr/local/bin/phpdox" do
  source "http://phpdox.de/releases/phpdox.phar"
  mode '0755'
end

remote_file "/usr/local/bin/phpcpd" do
  source "https://phar.phpunit.de/phpcpd.phar"
  mode '0755'
end

bash "Install PHP_CodeSniffer" do
 user "root"
  code <<-EOH
    pear install PHP_CodeSniffer
  EOH
end