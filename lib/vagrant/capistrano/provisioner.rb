module VagrantPlugins
  module Capistrano

    class Provisioner < Vagrant.plugin(2, :provisioner)

      def provision
        @machine.env.ui.info "provisioning: #{@config.capfile} with #{@config.rubystring}"
        env = {
          "BUNDLE_GEMFILE" => nil,
          "DEPLOYMENT_USER" => @machine.ssh_info[:username],
          "SSH_IDENTITY" => @machine.ssh_info[:private_key_path].join(":"),
          "HOSTS" => "#{@machine.ssh_info[:host]}:#{@machine.ssh_info[:port]}",
          "HIERA_ROOT" => File.expand_path(@config.hiera_root),
          "HIERA_CONFIG_PATH" => File.join(File.expand_path(@config.hiera_root),'hiera.yaml')
        }.merge(@config.environment)

        rvm_do = "bundle exec rvm #{@config.rubystring} do "
        commands = ["cd #{File.dirname(@config.capfile)}"]
        @config.tasks.each do |task|
          commands << "#{rvm_do} cap #{@config.stage} #{task}"
        end
        system(env, commands.join(" && "))
      end
    end
  end
end
