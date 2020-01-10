class Project
  attr_accessor :id, :title

  # create a project
  def initialize(attributes)
    @id = attributes.fetch(:id, nil)
    @title = attributes.fetch(:title) || nil
  end

  # ensure two projects are the same if they have the same  title
  def ==(project_to_compare)
    self.title() == project_to_compare.title()
  end

  # save a project
  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.sort()
    sorted_array = []

    self.all.each do |a|
      sorted_array.push(a.title)
    end
    results = sorted_array.sort.map { |a|  self.search(a)[0] }
  end

  # read all projects
  def self.all
    returned_projects = DB.exec('SELECT * FROM projects;')
    projects = []
    returned_projects.each() do |project|
      title = project.fetch('title')
      id = project.fetch('id').to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  # update a project
  def update(title)
    @title = title
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  #delete a project
  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end

  #clear city database
  def self.clear
    DB.exec("DELETE FROM projects *;")
  end

  # find a project by id
  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    title = project.fetch("title")
    id = project.fetch("id").to_i
    Project.new({:title =>title, :id => id})
  end

end
