class CreateInstrumentCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :instrument_categories do |t|
      t.string :category

      t.timestamps
    end
  end
end
