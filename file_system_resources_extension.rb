# -*- encoding: utf-8 -*-
require 'radiant-file_system_resources-extension'

class FileSystemResourcesExtension < Radiant::Extension
  version RadiantFileSystemResourcesExtension::VERSION
  description RadiantFileSystemResourcesExtension::DESCRIPTION
  url RadiantFileSystemResourcesExtension::URL
  
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
