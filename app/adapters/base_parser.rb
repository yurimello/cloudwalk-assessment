class BaseParser
  def initialize(file_path)
    @file_path = file_path
  end

  def games;end

  def game_id(game_log_id, content);end

  def kills(game_data)
    []
  end

  def parse_kill(game_id, kill_data)
    {
      killer: '',
      killer_class: '',
      killed: '',
      death_means: '',
      kill_id: ''
    }
  end
  
  private
  def log_content;end
end