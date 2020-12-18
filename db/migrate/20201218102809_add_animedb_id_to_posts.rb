class AddAnimedbIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :sora_id, :integer
  end
end
