class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
    	t.belongs_to :user
    	t.string :name
    	t.string :document, unique: true
    	t.string :address
    	t.string :telephone
      t.timestamps
    end
  end
end
