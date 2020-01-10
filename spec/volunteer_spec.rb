class Volunteer
  attr_accessor :name, :id

  # create a volunteer
  def initialize(attributes)
    @name = attributes.fetch(:name) || nil
    @id = attributes.fetch(:id, nil)
  end

  # ensure two volunteers are the same if they have the same name
  def ==(volunteer_to_compare)
    self.name() == volunteer_to_compare.name()
  end

  # save a volunteer
  def save
    result = DB.exec("INSERT INTO volunteers (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  # read all volunteers
  def self.all
    returned_volunteers = DB.exec('SELECT * FROM volunteers;')
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch('name')
      id = volunteer.fetch('id').to_i
      volunteers.push(Volunteer.new({:name => name, :id => id}))
    end
    volunteers
  end

  # update a volunteer
  def update(name)
    @name = name
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  #delete a volunteer
  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  #clear city database
  def self.clear
    DB.exec("DELETE FROM volunteers *;")
  end

  # find a volunteer by id
  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    name = volunteer.fetch("name")
    id = volunteer.fetch("id").to_i
    Volunteer.new({:name => name, :id => id})
  end

end
