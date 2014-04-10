class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :challenger_id
      t.integer :defender_id
      t.integer :challenger_rating
      t.integer :defender_rating
      t.integer :winner_id

      t.timestamps
    end
  end
end
