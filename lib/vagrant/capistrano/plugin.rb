module VagrantPlugins
  module Capistrano
    class Plugin < Vagrant.plugin("2")
      name "vagrant-capistrano"
      description <<-DESC
A Vagrant plugin to install capified projects.
DESC

      config :capistrano, :provisioner do
        require_relative "config"
        Config
      end

      provisioner :capistrano do
        require_relative "provisioner"
        Provisioner
      end
    end
  end
end

