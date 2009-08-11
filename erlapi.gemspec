# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{erlapi}
  s.version = "0.1.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrew Rudenko"]
  s.date = %q{2009-08-11}
  s.default_executable = %q{erlapi}
  s.email = %q{ceo@prepor.ru}
  s.executables = ["erlapi"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/erlapi",
     "erlapi.gemspec",
     "lib/erlapi.rb",
     "lib/erlapi/generator.rb",
     "lib/erlapi/generator/shtml.rb",
     "lib/erlapi/generator/template/direct/_context.rhtml",
     "lib/erlapi/generator/template/direct/class.rhtml",
     "lib/erlapi/generator/template/direct/file.rhtml",
     "lib/erlapi/generator/template/direct/index.rhtml",
     "lib/erlapi/generator/template/direct/resources/apple-touch-icon.png",
     "lib/erlapi/generator/template/direct/resources/css/main.css",
     "lib/erlapi/generator/template/direct/resources/css/panel.css",
     "lib/erlapi/generator/template/direct/resources/css/reset.css",
     "lib/erlapi/generator/template/direct/resources/favicon.ico",
     "lib/erlapi/generator/template/direct/resources/i/arrows.png",
     "lib/erlapi/generator/template/direct/resources/i/results_bg.png",
     "lib/erlapi/generator/template/direct/resources/i/tree_bg.png",
     "lib/erlapi/generator/template/direct/resources/js/jquery-1.3.2.min.js",
     "lib/erlapi/generator/template/direct/resources/js/jquery-effect.js",
     "lib/erlapi/generator/template/direct/resources/js/main.js",
     "lib/erlapi/generator/template/direct/resources/js/searchdoc.js",
     "lib/erlapi/generator/template/direct/resources/panel/index.html",
     "lib/erlapi/generator/template/merge/index.rhtml",
     "lib/erlapi/generator/template/shtml/_context.rhtml",
     "lib/erlapi/generator/template/shtml/class.rhtml",
     "lib/erlapi/generator/template/shtml/file.rhtml",
     "lib/erlapi/generator/template/shtml/index.rhtml",
     "lib/erlapi/generator/template/shtml/resources/apple-touch-icon.png",
     "lib/erlapi/generator/template/shtml/resources/css/main.css",
     "lib/erlapi/generator/template/shtml/resources/css/panel.css",
     "lib/erlapi/generator/template/shtml/resources/css/reset.css",
     "lib/erlapi/generator/template/shtml/resources/favicon.ico",
     "lib/erlapi/generator/template/shtml/resources/i/arrows.png",
     "lib/erlapi/generator/template/shtml/resources/i/results_bg.png",
     "lib/erlapi/generator/template/shtml/resources/i/tree_bg.png",
     "lib/erlapi/generator/template/shtml/resources/js/jquery-1.3.2.min.js",
     "lib/erlapi/generator/template/shtml/resources/js/main.js",
     "lib/erlapi/generator/template/shtml/resources/js/searchdoc.js",
     "lib/erlapi/generator/template/shtml/resources/panel/index.html",
     "lib/erlapi/helpers.rb",
     "lib/erlapi/merge.rb",
     "lib/erlapi/parser.rb",
     "lib/erlapi/shtml.rb",
     "lib/erlapi/templatable.rb",
     "lib/erlapi/templates/html/direct/_context.rhtml",
     "lib/erlapi/templates/html/direct/class.rhtml",
     "lib/erlapi/templates/html/direct/file.rhtml",
     "lib/erlapi/templates/html/direct/index.rhtml",
     "lib/erlapi/templates/html/direct/resources/apple-touch-icon.png",
     "lib/erlapi/templates/html/direct/resources/css/main.css",
     "lib/erlapi/templates/html/direct/resources/css/panel.css",
     "lib/erlapi/templates/html/direct/resources/css/reset.css",
     "lib/erlapi/templates/html/direct/resources/favicon.ico",
     "lib/erlapi/templates/html/direct/resources/i/arrows.png",
     "lib/erlapi/templates/html/direct/resources/i/results_bg.png",
     "lib/erlapi/templates/html/direct/resources/i/tree_bg.png",
     "lib/erlapi/templates/html/direct/resources/js/jquery-1.3.2.min.js",
     "lib/erlapi/templates/html/direct/resources/js/jquery-effect.js",
     "lib/erlapi/templates/html/direct/resources/js/main.js",
     "lib/erlapi/templates/html/direct/resources/js/searchdoc.js",
     "lib/erlapi/templates/html/direct/resources/panel/index.html",
     "lib/erlapi/templates/html/merge/index.rhtml",
     "lib/erlapi/templates/html/shtml/_context.rhtml",
     "lib/erlapi/templates/html/shtml/class.rhtml",
     "lib/erlapi/templates/html/shtml/file.rhtml",
     "lib/erlapi/templates/html/shtml/index.rhtml",
     "lib/erlapi/templates/html/shtml/resources copy/apple-touch-icon.png",
     "lib/erlapi/templates/html/shtml/resources copy/css/main.css",
     "lib/erlapi/templates/html/shtml/resources copy/css/panel.css",
     "lib/erlapi/templates/html/shtml/resources copy/css/reset.css",
     "lib/erlapi/templates/html/shtml/resources copy/favicon.ico",
     "lib/erlapi/templates/html/shtml/resources copy/i/arrows.png",
     "lib/erlapi/templates/html/shtml/resources copy/i/results_bg.png",
     "lib/erlapi/templates/html/shtml/resources copy/i/tree_bg.png",
     "lib/erlapi/templates/html/shtml/resources copy/js/jquery-1.3.2.min.js",
     "lib/erlapi/templates/html/shtml/resources copy/js/main.js",
     "lib/erlapi/templates/html/shtml/resources copy/js/searchdoc.js",
     "lib/erlapi/templates/html/shtml/resources copy/panel/index.html",
     "lib/erlapi/templates/html/shtml/resources/apple-touch-icon.png",
     "lib/erlapi/templates/html/shtml/resources/css/main.css",
     "lib/erlapi/templates/html/shtml/resources/css/panel.css",
     "lib/erlapi/templates/html/shtml/resources/css/reset.css",
     "lib/erlapi/templates/html/shtml/resources/favicon.ico",
     "lib/erlapi/templates/html/shtml/resources/i/arrows.png",
     "lib/erlapi/templates/html/shtml/resources/i/results_bg.png",
     "lib/erlapi/templates/html/shtml/resources/i/tree_bg.png",
     "lib/erlapi/templates/html/shtml/resources/js/jquery-1.3.2.min.js",
     "lib/erlapi/templates/html/shtml/resources/js/jquery-effect.js",
     "lib/erlapi/templates/html/shtml/resources/js/main.js",
     "lib/erlapi/templates/html/shtml/resources/js/searchdoc.js",
     "lib/erlapi/templates/html/shtml/resources/panel/index.html",
     "test/erlapi_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/prepor/erlapi}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "test/erlapi_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
