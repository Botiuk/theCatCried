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

#testing creating new operation

  test "return false if amount is missed" do
    new_operation = Operation.new(odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 1)
    assert_not(new_operation.valid?)
  end

  test "return false if amount negative" do
    new_operation = Operation.new(amount: -5, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 1)
    assert_not(new_operation.valid?) 
  end

  test "return false if amount zero" do
    new_operation = Operation.new(amount: 0, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 1)
    assert_not(new_operation.valid?) 
  end

  test "return false if odate missed" do
    new_operation = Operation.new(amount: 5, description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 1)
    assert_not(new_operation.valid?) 
  end

  test "return false if description missed" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", category_id: Category.find_by(name: 'First cat').id, otype: 1)
    assert_not(new_operation.valid?) 
  end

  test "return false if category_id missed" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", description: "some description", otype: 1)
    assert_not(new_operation.valid?) 
  end

  test "return false if otype missed" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id)
    assert_not(new_operation.valid?) 
  end

  test "return true if everything is good" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 1)
    assert(new_operation.valid?) 
  end

#testing reports_data_by_dates

  test "check reports_data_by_dates with false dates period" do
    graph_data = Operation.reports_data_by_dates("2020-09-01", "2020-10-01", "1", Category.find_by(name: 'Third cat').id)
    assert_empty(graph_data)
  end

  test "check reports_data_by_dates with true dates period from faker" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "1", Category.find_by(name: 'Third cat').id)
    assert_not_empty(graph_data)
  end

  test "check reports_data_by_dates with empty category" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "0", Category.find_by(name: 'Twelfth cat').id)
    assert_empty(graph_data)
  end

  test "check reports_data_by_dates with wrong pair otype-category_id" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "1", Category.find_by(name: 'Tenth cat').id)
    assert_empty(graph_data)
  end

  test "check reports_data_by_dates with correct pair otype-category_id" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "0", Category.find_by(name: 'Tenth cat').id)
    assert_not_empty(graph_data)
  end

  test "check reports_data_by_dates with all outcome category" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "0","0")
    assert_not_empty(graph_data)
  end

  test "check reports_data_by_dates with all income category" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "1","0")
    assert_not_empty(graph_data)
  end

#testing reports_data_by_category

  test "check reports_data_by_category with false dates period" do
    diagram_data = Operation.reports_data_by_category("2020-09-01", "2020-10-01", "1", Category.find_by(name: 'Third cat').id)
    assert_empty(diagram_data)
  end

  test "check reports_data_by_category with true dates period from faker" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "1", Category.find_by(name: 'Third cat').id)
    assert_not_empty(diagram_data)
  end

  test "check reports_data_by_category with empty category" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "0", Category.find_by(name: 'Twelfth cat').id)
    assert_empty(diagram_data)
  end

  test "check reports_data_by_category with wrong pair otype-category_id" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "1", Category.find_by(name: 'Tenth cat').id)
    assert_empty(diagram_data)
  end

  test "check report_data_by_dates with correct pair otype-category_id" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "0", Category.find_by(name: 'Tenth cat').id)
    assert_not_empty(diagram_data)
  end

  test "check report_data_by_dates with all outcome category" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "0","0")
    assert_not_empty(diagram_data)
  end

  test "check report_data_by_dates with all income category" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "1","0")
    assert_not_empty(diagram_data)
  end

end
