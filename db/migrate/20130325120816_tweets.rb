class Tweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.integer :tweet_id, :limit => 8
      t.datetime :tweet_created_at
      t.references :user
      t.timestamps
    end
  end
end
