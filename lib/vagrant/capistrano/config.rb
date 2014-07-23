require "vagrant"

module VagrantPlugins
  module Capistrano

    class Config < Vagrant.plugin(2, :config)
      attr_accessor :capfile
      attr_accessor :rubystring
      attr_accessor :stage
      attr_accessor :post_setup_tasks
      attr_accessor :hiera_root

      def initialize
        @capfile = UNSET_VALUE
        @rubystring = UNSET_VALUE
        @stage = UNSET_VALUE
        @post_setup_tasks = []
        @hiera_root = UNSET_VALUE
      end

      def finalize!
        @capfile   = nil if @capfile == UNSET_VALUE
        @rubystring   = nil if @rubystring == UNSET_VALUE
        @stage = nil if @stage == UNSET_VALUE
        @post_setup_tasks = nil if @post_setup_tasks == UNSET_VALUE
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
