class AddTitleToTasklists < ActiveRecord::Migration[5.0]
  def change
    add_column :tasklists, :title, :string
  end
end
