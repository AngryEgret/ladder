class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.int :challenger_id
      t.int :defender_id
      t.int :challenger_rating
      t.int :defender_rating
      t.int :winner_id

      t.timestamps
    end
  end
end
