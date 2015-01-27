class Entry
  attr_accessor :info
  attr_reader :calling_object

  def initialize(calling_object)
    @info = {}
    @calling_object = calling_object
  end

  def current_time
    Time.parse(DateTime.now.to_s).utc
  end

  def increment_id
    (@collection[-1].info[:id].to_i + 1).to_s
  end
end
