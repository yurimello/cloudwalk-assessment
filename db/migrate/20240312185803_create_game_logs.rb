class CreateGameLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :game_logs do |t|
      t.string :filename

      t.timestamps
    end
  end
end
