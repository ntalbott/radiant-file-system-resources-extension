namespace :radiant do
  namespace :extensions do
    namespace :file_system_resources do
      
      desc "Runs the migration of the Fs Resources extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          FileSystemResourcesExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          p FileSystemResourcesExtension.migrations_path
          FileSystemResourcesExtension.migrator.migrate
        end
      end

      namespace :migrate do
        task :rollback => :environment do
          step = ENV['STEP'] ? ENV['STEP'].to_i : 1
          FileSystemResourcesExtension.migrator.rollback(FileSystemResourcesExtension.migrations_path, step)
        end
      end

      desc "Copies public assets of the Fs Resources to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from FileSystemResourcesExtension"
        Dir[FileSystemResourcesExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(FileSystemResourcesExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end

        %w(layouts snippets).each do |dir|
          FileUtils.mkdir_p(RAILS_ROOT + "/radiant/#{dir}")
        end
      end
      
      desc "Registers file system resources in the database (needed only when added/removed, not on edit)."
      task :register => :environment do
        [Layout, Snippet].each do |klass|
          seen = []
          fs_name = klass.name.downcase.pluralize
          Dir[RAILS_ROOT + "/radiant/#{fs_name}/*.radius"].each do |f|
            filename = File.basename(f, ".radius")
            seen << filename
            if klass.find_by_file_system_resource_and_content(true, filename)
              puts "Skipped #{klass.name} #{filename} (already registered)."
              next
            else
              name = "#{filename}"
              klass.create!(:name => name, :filename => filename, :file_system_resource => true)
              puts "Registered #{klass.name} #{filename}."
            end
          end          
          klass.find_all_by_file_system_resource(true).reject{|e| seen.include?(e.filename)}.each do |e|
            e.destroy
            puts "Removed #{klass.name }#{e.filename} (no longer exists on file system)."
          end
        end
      end
    end
  end
end
