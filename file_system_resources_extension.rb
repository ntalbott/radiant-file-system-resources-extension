# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class FileSystemResourcesExtension < Radiant::Extension
  version "1.1"
  description "Adds support file system based layouts and snippets."
  url "http://terralien.com/"
  
  def activate
    Layout.send(:include, FileSystemResource)
    Snippet.send(:include, FileSystemResource)
    
    # Radiant chokes on these files...
    # admin.layouts.index.add :thead, 'layout_type_head', :before => 'modify_header'
    # admin.layouts.index.add :tbody, 'layout_type_column', :before => 'modify_cell'
    # admin.snippets.index.add :thead, 'snippet_type_head', :before => 'modify_header'
    # admin.snippets.index.add :tbody, 'snippet_type_column', :before => 'modify_cell'
  end
end
