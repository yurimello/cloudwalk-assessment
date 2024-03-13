class GenerateReportService
  def self.call
    new.call
  end

  def call
    games = Game.includes(activities: [:killerable, :killed]).all
    report = {raking: ranking}
    games.each do |game|
      activities = game.activities
      report["game_#{game.id}".to_sym] = {
        total_kills: activities.size
      }.merge(report_activities(activities))
    end
    report
  end
  
  private 
  def report_activities(activities)
    killers = activities.map {|activity| activity.killerable if activity.killerable_type == 'Player'}.compact
    {
      players: players(activities, killers),
      kills: killer_score(activities, killers),
      death_means: death_means(activities)
    }
  end

  def killer_score(activities, killers)
    killers.group_by {|killer| killer.name}.map do |k, v| 
      world_kills = activities.select do |activity| 
        activity if activity.killed.name == k && activity.killerable_type == 'WorldEnvironment'
      end.size
      score = v.count - world_kills
      {k => score}
    end.reduce(Hash.new, :merge)
  end

  def death_means(activities)
    grouped_activities = activities.group_by do |activity| 
      activity.death_means 
    end
    grouped_activities.map {|k,v| {k => v.count} }.reduce(Hash.new, :merge)
  end

  def players(activities, killers)
    killeds = activities.map(&:killed)
    killers.map(&:name).concat(killeds.map(&:name)).uniq
  end

  def ranking
    kills = GameActivity.where.not(killerable_type: 'WorldEnvironment').group(:killerable_id, :killerable_type).count.map{|k, v| [k[0], v]}
    killeds_by_world = GameActivity.where(killerable_type: 'WorldEnvironment').group(:killed_id).count
    player_ranking = kills.map do |kill|
      player_id = kill[0]
      kill_count = kill[1]
      kill_count = kill_count - killeds_by_world[player_id].to_i
      player = Player.find(player_id)
      [ player.name, kill_count ]
    end
    Hash[player_ranking.sort {|r| -r[1]}]
  end
end