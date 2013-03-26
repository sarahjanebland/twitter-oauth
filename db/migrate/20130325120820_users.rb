class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.datetime :cached_at
      t.timestamps
    end
  end
end
