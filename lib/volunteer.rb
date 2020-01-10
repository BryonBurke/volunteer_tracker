class Volunteer
  attr_accessor :name, :id

  # create a city
  def initialize(attributes)
    @name = attributes.fetch(:name) || nil
    @id = attributes.fetch(:id, nil)
  end


end 
