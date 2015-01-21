class Container
  attr_accessor :info 
  attr_reader :calling_object

  def initialize(calling_object)
    @info = {}
    @calling_object = calling_object
  end
end
