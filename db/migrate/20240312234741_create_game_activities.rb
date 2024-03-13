class CreateGameActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :game_activities do |t|
      t.string :checksum
      t.bigint :killed_id, null: false, foreign_key: true
      t.references :killerable, null: false, polymorphic: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
    add_index :game_activities, :checksum
  end
end
