class PostIsRevisions < ActiveRecord::Migration[5.2]
  def up
    add_column :revisions, :published, :boolean, default: false
    add_column :revisions, :slug, :string, null: false

    remove_column :posts, :title
    remove_column :posts, :slug
    remove_column :posts, :content
    remove_column :posts, :draft
    remove_column :posts, :url
    remove_column :posts, :published_at
  end

  def down
    remove_column :revisions, :published
    remove_column :revisions, :slug

    add_column :posts, :title, :string, null: false, default: ''
    add_column :posts, :slug, :string, null: false, default: ''
    add_column :posts, :content, :text
    add_column :posts, :draft, :boolean, default: true
    add_column :posts, :url, :string
    add_column :posts, :published_at, :datetime

  end
end
