class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :rating
      t.string :result
      t.integer :opponent_id
      t.integer :player_id

      t.timestamps
    end
  end
end
