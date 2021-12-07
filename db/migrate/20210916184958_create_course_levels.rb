class CreateCourseLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :course_levels do |t|
      t.string :name
      t.text :comment
      t.boolean :active, default: true
      
      t.timestamps
    end
  end
end
