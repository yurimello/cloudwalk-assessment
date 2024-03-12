class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.references :game_log, null: false, foreign_key: true
      t.string :checksum

      t.timestamps
    end
    add_index :games, :checksum
  end
end
