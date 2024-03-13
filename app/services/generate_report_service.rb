class GenerateReportService
  def self.call
    new.call
  end

  def call
    games = Game.includes(activities: [:killerable, :killed]).all
    report = {}
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
      players: players(killers, activities),
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

  def players(killers, activities)
    killeds = activities.map(&:killed)
    killers.map(&:name).concat(killeds.map(&:name)).uniq
  end
end