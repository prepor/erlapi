require 'erlapi'
require 'ostruct'
$DEBUG_DOC = true

pa = Erlapi::Parser::Base.new

pa.parse

ge = Erlapi::Generator.new(pa.modules)

options = OpenStruct.new( {:charset => 'utf-8', :title => 'Erlang API'})
ge.generate(options)