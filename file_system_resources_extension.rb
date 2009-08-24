# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class FileSystemResourcesExtension < Radiant::Extension
  version "1.0"
  description "Adds support file system based layouts and snippets."
  url "http://terralien.com/"
  
  def activate
    Layout.class_eval do
      def content
        if file_system_resource?
          File.read(path)
        else
          self[:content]
        end
      end
      
      def path
        RAILS_ROOT + "/radiant/layouts/#{filename}.radius"
      end
      
      def content=(value)
        raise "File System Resources are read-only from the admin." if file_system_resource?
        self[:content] = value
      end
      
      def filename
        raise "#filename should not be called unless a file_system_resource." unless file_system_resource?
        self[:content]
      end
      
      def filename=(value)
        self[:content] = value
      end
    end

    Snippet.class_eval do
      def content
        if file_system_resource?
          File.read(path)
        else
          self[:content]
        end
      end
      
      def path
        RAILS_ROOT + "/radiant/snippets/#{filename}.radius"
      end
      
      def content=(value)
        raise "File System Resources are read-only from the admin." if file_system_resource?
        self[:content] = value
      end
      
      def filename
        raise "#filename should not be called unless a file_system_resource." unless file_system_resource?
        self[:content]
      end
      
      def filename=(value)
        self[:content] = value
      end
    end
  end
end
