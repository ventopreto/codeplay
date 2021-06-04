class RemoveDraftFromCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :draft, :boolean
  end
end
