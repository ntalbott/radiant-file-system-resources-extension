class AddFileSystemResources < ActiveRecord::Migration
  def self.up
    add_column :layouts, :file_system_resource, :boolean
    add_column :snippets, :file_system_resource, :boolean
  end

  def self.down
    remove_column :layouts, :file_system_resource
    remove_column :snippets, :file_system_resource
  end
end
