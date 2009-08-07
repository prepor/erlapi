require 'rubygems'
require 'active_support'
require 'erb'
require 'ostruct'
if Gem.available? "json" 
  gem "json", ">= 1.1.3"
else
  gem "json_pure", ">= 1.1.3"
end
module Erlapi
  require 'erlapi/helpers'
  require 'erlapi/templatable'
  
  require 'erlapi/parser'
  require 'erlapi/generator'
  
  class Cmd
    class << self
      def start!(options)
        if !options[:source_dir] || !options[:output_dir]
          raise "You must define source and output dirs"
        end
        
        pa = Erlapi::Parser::Base.new(options[:source_dir])

        pa.parse

        ge = Erlapi::Generator.new(:data => pa.modules, :output_dir => options[:output_dir])

        options = OpenStruct.new( {:charset => 'utf-8', :title => 'Erlang API'})
        ge.generate(options)
        
        puts 'Generating completed'
      end
    end
  end
  
end