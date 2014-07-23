# Vagrant::Capistrano

This vagrant-plugin allows you to call capistrano from vagrant. Useful in combination with the puppet provisioner. 

## Installation

```
vagrant plugin install vagrant-capistrano
```

## Usage

```ruby
config.vm.provision "capistrano" do |cap|
  cap.capfile = '../some-project/Capfile'
  cap.rubystring = 'ruby-2.0.0-p458@project' 
  cap.stage = 'testing'
  cap.post_setup_tasks = ['rvm:install'] 
end
```

This provisioner will set the following environment variables before executing capistrano:

```
DEPLOYMENT_USER = 'vagrant' (or whatever the vagrant ssh user is set to)
SSH_IDENTITY = private ssh key of the DEPLOYMENT_USER
HOSTS= IP address and port of the vagrant ssh daemon
```

In order for this plugin to successfully execute your capsitrano tasks, should your include the following in your Capfile (or deploy.rb):

```ruby
# required for vagrant
set :ssh_options,   { keys: [ENV['SSH_IDENTITY']] } if ENV['SSH_IDENTITY']
set :user,          ENV['DEPLOYMENT_USER'] || "deployment"
```

This provisioner will cd into the directory containing your Capfile, then perform 

```
cap (stage) rvm_install_ruby
cap (stage) deploy:setup
```

then any capistrano tasks in post_setup_tasks, followed by

```
cap (stage) deploy
```

## Contributing

1. Fork it ( http://github.com/artcom/vagrant-capistrano/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
