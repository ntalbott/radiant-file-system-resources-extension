# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class FileSystemResourcesExtension < Radiant::Extension
  version "1.1"
  description "Adds support file system based layouts and snippets."
  url "http://terralien.com/"
  
  def activate
    Layout.send(:include, FileSystemResource)
    Snippet.send(:include, FileSystemResource)
  end
end
