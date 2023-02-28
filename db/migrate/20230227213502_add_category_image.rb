class AddCategoryImage < ActiveRecord::Migration[7.0]
  def change
    add_column :instrument_categories, :image, :string
  end
end
