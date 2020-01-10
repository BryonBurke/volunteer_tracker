require('spec_helper')

describe('.#Project') do

  describe('#==') do
    it("is the same project if it has the same attributes as another project") do
      project1 = Project.new({:name => 'Clean up park', :id => nil})
      project2 = Project.new({:name => 'Clean up park', :id => nil})
      expect(project1).to(eq(project2))
    end
  end


end
