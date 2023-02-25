class RemoveInstrumentTypeFromInstruments < ActiveRecord::Migration[7.0]
  def change
    remove_column :instruments, :instrument_type, :string
  end
end
