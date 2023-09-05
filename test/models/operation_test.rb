require "test_helper"

class OperationTest < ActiveSupport::TestCase

test "check the operation description" do
  operation_first = Operation.find_by(odate: "2023-01-11 07:45:43")
  assert_equal("MyString", operation_first.description)
end

test "saving and gathering" do
  new_operation = Operation.new(amount: 5, odate: "2023-01-11 09:45:43", description: "new description", category_id: Category.find_by(name: 'First cat').id, otype: 0)
  new_operation.save()
  new_op = Operation.find_by(odate: "2023-01-11 09:45:43")
  assert_equal("new description", new_op.description)
end

  test "return false if amount is missed" do
    new_operation = Operation.new(odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 0)
    assert_not(new_operation.valid?)
  end

  test "return false if amount negative" do
    new_operation = Operation.new(amount: -5, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 0)
    assert_not(new_operation.valid?) 
  end

  test "return false if amount zero" do
    new_operation = Operation.new(amount: 0, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 0)
    assert_not(new_operation.valid?) 
  end

  test "return false if odate missed" do
    new_operation = Operation.new(amount: 5, description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 0)
    assert_not(new_operation.valid?) 
  end

  test "return false if description missed" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", category_id: Category.find_by(name: 'First cat').id, otype: 0)
    assert_not(new_operation.valid?) 
  end

  test "return false if category_id missed" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", description: "some description", otype: 0)
    assert_not(new_operation.valid?) 
  end

  test "return false if otype missed" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id)
    assert_not(new_operation.valid?) 
  end

  test "return true if everything is good" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 0)
    assert(new_operation.valid?) 
  end
 

end
