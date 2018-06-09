class ImplicitBetterThanExplicit < ActiveRecord::Migration[5.2]
  def up
    remove_column :urls, :canonical
  end

  def down
    add_column :urls, :canonical, :boolean, null: false, default: false
  end
end
