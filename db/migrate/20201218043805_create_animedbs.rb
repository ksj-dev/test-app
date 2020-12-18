class CreateAnimedbs < ActiveRecord::Migration[5.0]
  def change
    create_table :animedbs do |t|
      t.integer :sora_id
      t.string :title
      t.string :title_short1
      t.string :title_short2
      t.string :title_short3
      t.string :public_url
      t.string :twitter_account
      t.string :twitter_hash_tag
      t.integer :cours_id
      t.integer :sex
      t.integer :sequel
      t.integer :city_code
      t.string :city_name
      t.integer :year
      t.integer :cours

      t.timestamps
    end
  end
end
