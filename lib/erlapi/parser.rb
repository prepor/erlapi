require 'nokogiri'

require 'xml/xslt'
require 'htmlentities'
coder = HTMLEntities.new


module Erlapi::Parser
  class Base
    attr_accessor :src_dir, :template_dir, :files, :modules, :entities_coder
    def initialize(src_dir = nil)
      self.files = []
      self.modules = {}
      self.src_dir = Pathname.new(src_dir || File.join(File.dirname(__FILE__), '..', 'src'))
      
      self.src_dir.mkdir if !self.src_dir.directory?      
      self.template_dir = File.join(File.dirname(__FILE__), 'templates')
      self.entities_coder = HTMLEntities.new
    end
  
    def parse
      files.each do |file|
        puts "Parsing #{file}"
        doc = Nokogiri::XML(File.read(file))
        
        begin
          
          mod = Erlapi::Parser::Module.new(self, doc)
          self.modules[mod.title] = mod if mod.valid

        end
        
      end
    end
    
    def special_tags(str)
      str.gsub!(/<c>(.*?)<\/c>/mi, '<tt>\1</tt>')
      str.gsub(/<code.*?>(.*?)<\/code>/mi, '<pre>\1</pre>')
      str.gsub(/<v.*?>(.*?)<\/v>/mi, '<b>\1</b><br/>')
    end
    
    def xslt(template, xml)
      xslt = XML::XSLT.new()
      xslt.xml = '<?xml version="1.0" encoding="utf-8" ?><root>' + xml + '</root>'
      xslt.xsl = File.read(File.join(self.template_dir, 'xslt', template))
      str = xslt.serve() || ''
      str.gsub('\011', "\t")
    end
  
    def files
      load_files(src_dir.realpath)
      @files
    end
  
    def load_files(dir_path)
      dir = Dir.new(dir_path)
      dir.each do |file_name|
        full_path = File.join(dir.path, file_name)        
        if file_name != '.' && file_name != '..'
          if File.directory?(full_path)
            load_files(full_path)
          else
            @files << full_path if File.extname(file_name) == '.xml'
          end
        end
      end
      dir.close
    end
  
  end

  class Module
    attr_accessor :parser, :title, :summary, :desc, :datatypes, :funcs, :sections, :valid, :doc
    def initialize(parser, doc)
      self.doc = doc
      self.parser = parser
      self.title = doc.css('module').inner_html
      self.summary = doc.css('modulesummary').inner_html || ''
      if self.title && self.title != ''
        self.valid = true
      else
        self.valid = false
      end
      if valid
        define_desc
        define_sections
        define_funcs
      end
    end
    
    def define_desc
      self.desc = self.parser.special_tags(doc.css('description').inner_html)
    end
    
    def define_sections
      self.sections = []
      doc.css('section').each do |node|
        self.sections << Erlapi::Parser::Section.new(self, node)
      end
    end
    
    def define_funcs
      self.funcs = []
      doc.css('funcs func').each do |node|
        func = Erlapi::Parser::Func.new(self, node)
        self.funcs << func if func.short_name
      end
    end
  end
  
  class Func
    attr_accessor :p_module, :short_name, :names, :summary, :types, :desc, :ref
    
    def initialize(p_module, node)
      self.p_module = p_module
      self.names = node.css('name').map {|v| v.inner_html}
      if self.names
        sh_m = self.names.first.match(/([\w\d_-]*)\(/)
        self.short_name = sh_m[1] if sh_m
      end
      self.ref = self.names.first.gsub(/[^\w]/, '')
      self.summary = node.css('fsummary').inner_html
      self.types = self.p_module.parser.special_tags(node.css('type').inner_html)
      self.desc = self.p_module.parser.special_tags(node.css('desc').inner_html)
    end
  end
  
  class Section
    attr_accessor :p_module, :name, :desc
    
    def initialize(p_module, node)
      self.p_module = p_module
      self.name = node.css('title').inner_html
      self.desc = self.p_module.parser.special_tags(node.inner_html)
    end
  end
end