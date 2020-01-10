class Project
  attr_accessor :name, :id

  # create a project
  def initialize(attributes)
    @name = attributes.fetch(:name) || nil
    @id = attributes.fetch(:id, nil)
  end

  # ensure two projects are the same if they have the same name
  def ==(project_to_compare)
    self.name() == project_to_compare.name()
  end



end
