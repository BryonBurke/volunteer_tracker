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

  # save a project
  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  # read all projects
  def self.all
    returned_projects = DB.exec('SELECT * FROM projects;')
    projects = []
    returned_projects.each() do |project|
      name = project.fetch('name')
      id = project.fetch('id').to_i
      projects.push(Project.new({:name => name, :id => id}))
    end
    projects
  end



end
