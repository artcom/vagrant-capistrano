module VagrantPlugins
  module Capistrano

    class Provisioner < Vagrant.plugin(2, :provisioner)

      def provision
        @machine.env.ui.info "provisioning: #{@config.capfile}"
        env = {
          "BUNDLE_GEMFILE" => nil,
          "DEPLOYMENT_USER" => @machine.ssh_info[:username],
          "SSH_IDENTITY" => @machine.ssh_info[:private_key_path].join(":"),
          "HOSTS" => "#{@machine.ssh_info[:host]}:#{@machine.ssh_info[:port]}"
        }
        @machine.env.ui.info "calling cap with environment: #{env}"
        rvm_do = "rvm #{@config.rvm_string} do "
        commands = []
        commands << "cd #{File.dirname(@config.capfile)}"
        commands << "#{rvm_do} cap testing rvm:install_ruby" 
        commands << "#{rvm_do} cap testing deploy:setup" 
        # commands << "#{rvm_do} cap testing deploy" 
        system(env, commands.join(" && "))
      end
    end
  end
end
