class CreateSpents < ActiveRecord::Migration[5.0]
  def change
    create_table :spents do |t|
    	t.belongs_to :user
    	t.float :value
    	t.string :description
      t.timestamps
    end
  end
end
