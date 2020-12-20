class AddReviewToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :review_point, :integer
  end
end
