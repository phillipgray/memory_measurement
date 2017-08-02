class CreateFinancials < ActiveRecord::Migration[5.1]
  def change
    create_table :financials do |t|
      t.string :company
      t.integer :year
      t.jsonb :data

      t.timestamps
    end
  end
end
