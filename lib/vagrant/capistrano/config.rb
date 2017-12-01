require "vagrant"

module VagrantPlugins
  module Capistrano

    class Config < Vagrant.plugin(2, :config)
      attr_accessor :capfile
      attr_accessor :rubystring
      attr_accessor :stage
      attr_accessor :tasks
      attr_accessor :environment
      attr_accessor :hiera_root
      attr_accessor :hiera_role

      def initialize
        @capfile = UNSET_VALUE
        @rubystring = UNSET_VALUE
        @stage = UNSET_VALUE
        @tasks = UNSET_VALUE
        @environment = UNSET_VALUE
        @hiera_root = UNSET_VALUE
        @hiera_role = UNSET_VALUE
      end

      def finalize!
        @capfile   = nil if @capfile == UNSET_VALUE
        @rubystring   = nil if @rubystring == UNSET_VALUE
        @stage = nil if @stage == UNSET_VALUE
        @tasks = ['misc:update_needed?', 'rvm:install_ruby','deploy:setup','deploy'] if @tasks == UNSET_VALUE
        @environment = {} if @environment == UNSET_VALUE
        @hiera_root = nil if @hiera_root == UNSET_VALUE
        @hiera_role = nil if @hiera_role == UNSET_VALUE
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
