require "byebug"
require "csv"

class GenericRepo
  attr_reader :collection

  def initialize(file, class_name, calling_object = nil)
    @collection = self.create_items(file, class_name)
    @calling_object = calling_object
	end
  
  def find_one_by_id(an_id)
    @collection.find {|entry| entry.info[:id] == an_id}.info
	end

	def all
    @collection.map {|entry| entry.info}
  end

	def random
    @collection[rand(@collection.length)].info
	end

	def create_items(item_file, class_name)
		repository_file = CSV.open("./data/#{item_file}", headers: true, header_converters: :symbol)

		repository_headers = repository_file.readline.headers
		repository_file.rewind

    repo_objects = repository_file.map do |line|
      new_repo_object = class_name.new(self)
      repository_headers.each {|h| new_repo_object.info[h] = line[h]}
			new_repo_object
		end

		repo_objects
  end
end
