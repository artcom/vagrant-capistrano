require "vagrant"

module VagrantPlugins
  module Capistrano

    class Config < Vagrant.plugin(2, :config)
      attr_accessor :capfile
      attr_accessor :rvm_string
      attr_accessor :stage
      attr_accessor :application_dir
      attr_accessor :config_files

      def initialize
        @capfile = UNSET_VALUE
        @rvm_string = UNSET_VALUE
        @stage = UNSET_VALUE
        @application_dir = UNSET_VALUE
        @config_files = {}
      end

      def finalize!
        @capfile   = nil if @capfile == UNSET_VALUE
        @rvm_string   = nil if @rvm_string == UNSET_VALUE
        @stage = nil if @stage == UNSET_VALUE
        @application_dir = nil if @application_dir == UNSET_VALUE
        @config_files = nil if @config_files == {}
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
