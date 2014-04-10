class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :twitter_id
      t.int :rating
      t.int :wins
      t.int :losses
      t.int :ties

      t.timestamps
    end
  end
end
