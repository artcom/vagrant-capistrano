require "vagrant"

module VagrantPlugins
  module Capistrano

    class Config < Vagrant.plugin(2, :config)
      attr_accessor :capfile
      attr_accessor :cap_ruby_string
      attr_accessor :app_ruby_string
      attr_accessor :stage
      attr_accessor :application_dir
      attr_accessor :config_files
      attr_accessor :post_setup_tasks
      attr_accessor :hiera_config_path
      attr_accessor :hiera_root

      def initialize
        @capfile = UNSET_VALUE
        @cap_ruby_string = UNSET_VALUE
        @app_ruby_string = UNSET_VALUE
        @stage = UNSET_VALUE
        @application_dir = UNSET_VALUE
        @post_setup_tasks = []
        @hiera_config_path = UNSET_VALUE
        @hiera_root = UNSET_VALUE
        @config_files = {}
      end

      def finalize!
        @capfile   = nil if @capfile == UNSET_VALUE
        @cap_ruby_string   = nil if @cap_ruby_string == UNSET_VALUE
        @app_ruby_string   = nil if @app_ruby_string == UNSET_VALUE
        @stage = nil if @stage == UNSET_VALUE
        @application_dir = nil if @application_dir == UNSET_VALUE
        @post_setup_tasks = nil if @post_setup_tasks == UNSET_VALUE
        @config_files = nil if @config_files == {}
        @hiera_config_path = nil if @hiera_config_path == UNSET_VALUE
        @hiera_root = nil if @hiera_root == UNSET_VALUE
      end


      def validate(machine)
        errors = []

        if !@capfile
          errors << "missing capfile parameter"
        end

        return { :capistrano => errors }
      end
    end
  end
end
