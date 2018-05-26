class BustOutSlugs < ActiveRecord::Migration[5.2]
  def up
    remove_column :revisions, :slug

    create_table :urls do |t|
      t.string :slug, null: false
      t.boolean :canonical, null: false, default: false
      t.integer :post_id, null: false
      t.timestamps null: false
    end

    add_foreign_key :urls, :posts
    add_index :urls, :slug, unique: true
  end

  def down
    remove_foreign_key :urls, :posts
    drop_table :urls
    add_column :revisions, :slug, :string, null: false
  end
end
