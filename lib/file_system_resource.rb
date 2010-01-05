module FileSystemResource
  def self.included(klass)
    klass.class_eval do
      def content
        if file_system_resource?
          File.read(path)
        else
          self[:content]
        end
      end
      
      def name
        file_system_resource? ? self[:name] + ' (standard)' : self[:name]
      end

      def path
        RAILS_ROOT + "/radiant/#{self.class.name.downcase.pluralize}/#{filename}.radius"
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