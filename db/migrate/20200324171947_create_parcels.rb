class CreateParcels < ActiveRecord::Migration[5.0]
  def change
    create_table :parcels do |t|
    	t.belongs_to :office_visit
    	t.float :value
    	t.string :observation
      t.timestamps
    end
  end
end
