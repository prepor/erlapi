require 'nokogiri'

module Erlapi::Parser
  class Base
    attr_accessor :src_dir, :template_dir, :files, :modules, :entities_coder
    def initialize(src_dir = nil)
      self.files = []
      self.modules = {}
      self.src_dir = Pathname.new(src_dir || File.join(File.dirname(__FILE__), '..', 'src'))    
      self.template_dir = File.join(File.dirname(__FILE__), 'templates')
    end
  
    def parse
      files.each do |file|
        puts "Parsing #{file}"
        doc = Nokogiri::XML(File.read(file))
        
        mod = Erlapi::Parser::Module.new(self, doc)
        self.modules[mod.title] = mod if mod.valid
      end
    end
    
    def inner_xml(node)
      node.is_a?(Nokogiri::XML::NodeSet) ? node.collect{|j| j.children.to_xml}.join('') : node.children.to_xml      
    end
    
    def special_tags(str)
      str.gsub!(/<c>(.*?)<\/c>/mi, '<tt>\1</tt>')
      str.gsub!(/<code.*?>(.*?)<\/code>/mi, '<pre>\1</pre>')
      str.gsub!(/<v.*?>(.*?)<\/v>/mi, '<b>\1</b><br/>')
      str.gsub!(/<input.*?>(.*?)<\/input>/mi, '<tt>\1</tt><br/>')
      str
    end
    
    def prepare_string(str)
      str.gsub(/\\\\/, '\\')
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
      self.desc = self.parser.special_tags(self.parser.inner_xml(doc.css('description')))
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
    attr_accessor :p_module, :short_name, :names, :summary, :types, :desc, :ref, :short_names
    
    def initialize(p_module, node)
      self.p_module = p_module
      self.names = node.css('name').map {|v| v.inner_html}
      if self.names
        self.short_names = self.names.map { |n| n.match(/([\w\d_-]*)\(/) ? $~[1] : nil }.compact.uniq
        self.short_name = self.short_names.first if self.short_names
      end
      self.ref = self.names.first.gsub(/[^\w]/, '')
      self.summary = parser.inner_xml(node.css('fsummary'))
      self.types = parser.special_tags(parser.inner_xml(node.css('type')))
      self.desc = parser.special_tags(parser.inner_xml(node.css('desc')))
    end
    
    def parser
      self.p_module.parser
    end
  end
  
  class Section
    attr_accessor :p_module, :name, :desc
    
    def initialize(p_module, node)
      self.p_module = p_module
      self.name = node.css('title').inner_html
      self.desc = parser.special_tags(parser.inner_xml(node))
    end
    
    def parser
      self.p_module.parser
    end
  end
end