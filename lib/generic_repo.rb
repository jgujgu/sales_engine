require "byebug"
require "csv"

class GenericRepo
  attr_reader :collection

  def initialize(file_path, class_name, calling_object = nil)
    @collection = self.create_items(file_path, class_name)
    @calling_object = calling_object
  end

  def find_one_by_id(an_id)
    @collection.find {|entry| entry.info[:id] == an_id.to_s}
  end

  def find_by_id(an_id)
    self.find_one_by_id(an_id)
  end

  def all
    @collection.map {|entry| entry}
  end

  def random
    @collection[rand(@collection.length)]
  end

  def create_items(file_path, class_name)
    repository_file = CSV.open(file_path, headers: true, header_converters: :symbol)

    repository_headers = repository_file.readline.headers
    repository_file.rewind

    repo_objects = repository_file.map do |line|
      new_repo_object = class_name.new(self)
      repository_headers.each {|h| new_repo_object.info[h] = line[h]}
      new_repo_object
    end

    repo_objects
  end

  def inspect
    "#<#{self.class} #{@collection.size} rows>"
  end

  def find_by_name(query_name)
    @collection.find {|entry| entry.info[:name] == query_name}
  end

  def find_all_by_name(query_name)
    @collection.select {|entry| entry.info[:name] == query_name}
  end
end
