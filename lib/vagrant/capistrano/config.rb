require "vagrant"

module VagrantPlugins
  module Capistrano

    class Config < Vagrant.plugin(2, :config)
      attr_accessor :capfile
      attr_accessor :rvm_string

      def initialize
        @capfile = UNSET_VALUE
        @rvm_string = UNSET_VALUE
      end

      def finalize!
        @capfile   = nil if @capfile == UNSET_VALUE
        @rvm_string   = nil if @rvm_string == UNSET_VALUE
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
