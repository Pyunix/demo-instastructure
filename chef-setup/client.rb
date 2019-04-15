log_level        :auto
log_location     STDOUT
chef_server_url  "https://chef-server.vagrant.com"
validation_client_name "punishall-validator"
validation_key '/etc/chef/validator.pem'
client_key '/etc/chef/client.pem'