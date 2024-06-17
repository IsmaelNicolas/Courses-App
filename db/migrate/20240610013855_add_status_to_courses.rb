class AddStatusToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :status, :integer, default: 0, null: false
  end
end
