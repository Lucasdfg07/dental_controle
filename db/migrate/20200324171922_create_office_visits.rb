class CreateOfficeVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :office_visits do |t|
    	t.belongs_to :patient
    	t.date :date
    	t.string :hour
    	t.string :status
    	t.integer :payment_method
    	t.string :treatment
    	t.float :value
    	t.json :upload
      t.timestamps
    end
  end
end
