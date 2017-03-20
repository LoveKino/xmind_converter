Gem::Specification.new do |s|
    s.name           = 'xmind_converter'
    s.version        = '0.0.0'
    s.executables << 'tim'
    s.executables << 'count'
    s.add_runtime_dependency "rubyzip", [">= 1.0.0"]
    s.add_runtime_dependency "writeexcel"
    s.date           = '2017-01-05'
    s.summary        = 'import mind map to tapd'
    s.description    = 'A simple program to convert xmind files'
    s.authors        = ['ddchen']
    s.email          = '842914439@qq.com'
    s.files          = ['lib/xmindConverter.rb', 'lib/xmindParser.rb', 'lib/transfer.rb']
    s.homepage       = 'http://rubygems.org/gems/tapd_import_mindmap'
    s.license        = 'MIT'
end
