require ('spec_helper')

describe(Task) do
  describe("#list") do
    it("tells which list it belongs to") do
      test_list = List.create({:name => "list"})
      test_task = Task.create({:description => "task", :list_id => test_list.id})
      expect(test_task.list()).to(eq(test_list))
    end
  end
end
