require('spec_helper')

describe('.#Project') do

  describe('#==') do
    it("is the same project if it has the same attributes as another project") do
      project1 = Project.new({:name => 'Clean up park', :id => nil})
      project2 = Project.new({:name => 'Clean up park', :id => nil})
      expect(project1).to(eq(project2))
    end
  end

  describe('#save') do
    it("saves a project") do
      project = Project.new({:name => "Clean up park", :id => nil}) # nil added as second argument
      project.save()
      project2 = Project.new({:name => "Collect for food drive", :id => nil}) # nil added as second argument
      project2.save()
      expect(Project.all).to(eq([project, project2]))
    end
  end

  describe('#update') do
    it("updates a project by id") do
      project = Project.new({:name => "Distribute blankets", :id => nil})
      project.save()
      project.update("Distribute jackets")
      expect(project.name).to(eq("Distribute jackets"))
    end
  end

  describe('#delete') do
    it("deletes a project") do
      project = Project.new({:name => "Distribute blankets", :id => nil})
      project.save()
      project2 = Project.new({:name => "Distribute jackets", :id => nil})
      project2.save()
      project.delete()
      expect(Project.all).to(eq([project2]))
    end
  end

  describe('.clear') do
    it("clears all projects") do
      project = Project.new({:name => "Distribute blankets", :id => nil})
      project.save()
      project2 = Project.new({:name => "Distribute shoes", :id => nil})
      project2.save()
      Project.clear()
      expect(Project.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds a project by id") do
      project = Project.new({:name => "Distribute blankets", :id => nil})
      project.save()
      project2 = Project.new({:name => "Distribute shoes", :id => nil})
      project2.save()
      expect(Project.find(project.id)).to(eq(project))
    end
  end

end
