class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :player1id
      t.integer :player2id
      t.string :date
      t.string :score

      t.timestamps
    end
    add_index :matches, [:player1id, :created_at];
    add_index :matches, [:player2id, :created_at];
  end
end
