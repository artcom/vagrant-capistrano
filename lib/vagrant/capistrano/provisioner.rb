module VagrantPlugins
  module Capistrano

    class Provisioner < Vagrant.plugin(2, :provisioner)

      def provision
        @machine.env.ui.info "provisioning: #{@config.capfile} with #{@config.rvm_string}"
        env = {
          "BUNDLE_GEMFILE" => nil,
          "DEPLOYMENT_USER" => @machine.ssh_info[:username],
          "SSH_IDENTITY" => @machine.ssh_info[:private_key_path].join(":"),
          "HOSTS" => "#{@machine.ssh_info[:host]}:#{@machine.ssh_info[:port]}",
        }
        rvm_do = "rvm #{@config.rvm_string} do "
        commands = ["cd #{File.dirname(@config.capfile)}"]
        commands << "#{rvm_do} cap testing rvm:install_ruby" 
        commands << "#{rvm_do} cap testing deploy:setup"
        @config.post_setup_tasks.each do |task|
          commands << "#{rvm_do} cap testing #{task}"
        end
        system(env, commands.join(" && "))

        # now prepare shared files

        @config.config_files.each do |file, contents|
          target_file = "#{File.join(@config.application_dir,'shared', 'config', file.to_s)}.yml"
          @machine.env.ui.info "creating: #{target_file}"
          @machine.communicate.sudo("echo -e #{contents.to_yaml.dump} > #{target_file}")
        end
        # now do cap deploy
        commands = ["cd #{File.dirname(@config.capfile)}"]
        commands << "#{rvm_do} cap testing deploy" 
        system(env, commands.join(" && "))
      end
    end
  end
end
