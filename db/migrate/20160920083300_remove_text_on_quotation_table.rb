class RemoveTextOnQuotationTable < ActiveRecord::Migration[5.0]
  def up
    remove_index :quotations, :text
    remove_column :quotations, :full_text
    change_column :quotations, :text, :text
  end

  def down
    change_column :quotations, :text, :string
    add_column :quotations, :full_text, :text
    add_index :quotations, :text, unique: true
  end
end
