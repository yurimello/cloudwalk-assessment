class AddDeathMeansToGameActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :game_activities, :death_means, :integer
  end
end
