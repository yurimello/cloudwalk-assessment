class CreateWorldEnvironments < ActiveRecord::Migration[7.0]
  def up
    create_table :world_environments do |t|
      t.string :name

      t.timestamps
    end
    WorldEnvironment.instance
  end

  def down
    drop_table :world_environments
  end
end
