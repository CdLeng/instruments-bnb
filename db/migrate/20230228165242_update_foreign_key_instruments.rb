class UpdateForeignKeyInstruments < ActiveRecord::Migration[7.0]
  def change

    remove_foreign_key :instruments, :instrument_categories

    add_foreign_key :instruments, :instrument_categories, on_delete: :nullify
  end
end
