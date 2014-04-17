class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :twitter_id
      t.integer :wins
      t.integer :losses
      t.integer :ties

      t.timestamps
    end
  end
end
