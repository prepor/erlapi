require 'pathname'
class Erlapi::Generator
  attr_accessor :data, :output_dir, :source_dir
  
  GENERATOR_DIRS = [File.join('sdoc', 'generator'), File.join('rdoc', 'generator')]
  
  # Used in js to reduce index sizes
  TYPE_CLASS  = 1
  TYPE_METHOD = 2
  TYPE_FILE   = 3
  
  
  TEMPLATE_DIR = Pathname.new(File.dirname(__FILE__)) + 'templates' + 'html' + 'shtml'
  
  
  FILE_DIR = 'files'
  CLASS_DIR = 'classes'
  
  RESOURCES_DIR = 'resources'
  
  
  include ERB::Util
  include Erlapi::Templatable
  include Erlapi::Helpers
  
  def initialize(options = {})    
    self.output_dir = Pathname.new(options[:output_dir])
    
    self.output_dir.mkdir if !self.output_dir.directory?      
      
    self.data = options[:data]
    define_paths
  end
  
  def define_paths
    @tree_file = output_dir + 'panel' + 'tree.js'
    @search_index_file = output_dir + 'panel' + 'search_index.js'
  end
  
  def generate(options = {})
    @options = options
    copy_resources
    generate_search_index
    generate_class_tree
    generate_class_files
    generate_index_file
  end
  
  ### Copy all the resource files to output dir
  def copy_resources
    resources_path = File.join(TEMPLATE_DIR, RESOURCES_DIR) + '/.'
		debug_msg "Copying #{resources_path}/** to #{output_dir}/**"
    FileUtils.cp_r resources_path.to_s, output_dir.to_s, :preserve => true
  end
  
  ### Generate a documentation file for each class
	def generate_class_files
		debug_msg "Generating class documentation in #{output_dir}"
    templatefile = TEMPLATE_DIR + 'class.rhtml'

		self.data.each do |mod_name, mod|
		  if mod_name
  			debug_msg "  working on %s" % [ mod.title]
  			outfile     = output_dir + (mod.title + '.html')
        # rel_prefix  = OUTPUT_DIR.relative_path_from( outfile.dirname )
      
  			debug_msg "  rendering #{outfile}"
  			self.render_template( templatefile, binding(), outfile )
  		end
		end
	end
	
	### Create index.html with frameset
	def generate_index_file
		debug_msg "Generating index file in #{output_dir}"
    templatefile = TEMPLATE_DIR + 'index.rhtml'
    outfile      = output_dir + 'index.html'
	  index_path = self.data.to_a.first[1].title + '.html'
	  self.render_template( templatefile, binding(), outfile )
	end
	
	### Create class tree structure and write it as json
  def generate_class_tree
    debug_msg "Generating class tree"    
    tree = self.data.map { |mod_name, mod| [mod_name, mod_name + '.html', '', []] }.sort{ |a, b| a[0] <=> b[0] }
    debug_msg "  writing class tree to %s" % @tree_file
    File.open(@tree_file, "w", 0644) do |f|
      f.write('var tree = '); f.write(tree.to_json)
    end
  end
  
  def generate_search_index
    debug_msg "Generating search index"
    
    index = {
      :searchIndex => [],
      :longSearchIndex => [],
      :info => []
    }
    
    add_class_search_index(index)
    add_method_search_index(index)
    
    debug_msg "  writing search index to %s" % @search_index_file
    data = {
      :index => index
    }
    File.open(@search_index_file, "w", 0644) do |f|
      f.write('var search_data = '); f.write(data.to_json)
    end
  end
  
  
  ### Add classes to search +index+ array
  def add_class_search_index(index)
    debug_msg "  generating class search index"
    
    self.data.each do |mod_name, mod|      
      index[:searchIndex].push( search_string(mod.title) )
      index[:longSearchIndex].push( search_string(mod.title) )
      index[:info].push([
        mod.title,
        '',
        mod.title + '.html',
        '',       
        snippet(mod.summary),
        TYPE_CLASS
      ])
    end
  end
  
  ### Add methods to search +index+ array
  def add_method_search_index(index)
    debug_msg "  generating method search index"
    
    list = self.data.map { |mod_name, mod| 
      mod.funcs
    }.flatten
    
    list.each do |method|
      index[:searchIndex].push( search_string(method.p_module.title + ':' + method.short_name) + '()' )
      index[:longSearchIndex].push( search_string(method.short_name) )
      index[:info].push([
        method.short_name, 
        method.p_module.title + ':' + method.short_name,
        method.p_module.title + '.html#' + method.ref,
        '',        
        snippet(method.summary),
        TYPE_METHOD
      ])
    end
  end
  
  
  
  ### Build search index key
  def search_string(string)
    string ||= ''
    string.downcase.gsub(/\s/,'')
  end
  
  def snippet(str)
    str ||= ''
    if str =~ /^(?>\s*)[^\#]/
      content = str
    else
      content = str.gsub(/^\s*(#+)\s*/, '')
    end
    
    content = content.sub(/^(.{100,}?)\s.*/m, "\\1").gsub(/\r?\n/m, ' ')
    
    begin
      content.to_json
    rescue # might fail on non-unicode string
      begin
        content = Iconv.conv('latin1//ignore', "UTF8", content) # remove all non-unicode chars
        content.to_json
      rescue
        content = '' # something hugely wrong happend
      end
    end
    content
  end
  
  ### Output progress information if debugging is enabled
	def debug_msg( *msg )
		return unless $DEBUG_DOC
		$stderr.puts( *msg )
	end
	
	
end