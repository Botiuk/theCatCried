require "test_helper"

class OperationTest < ActiveSupport::TestCase

  test "check the operation description" do
    operation_first = Operation.find_by(odate: "2023-01-11 07:45:43")
    assert_equal("MyString", operation_first.description)
  end

  test "saving and gathering" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-05 09:45:43", description: "new description", category_id: Category.find_by(name: 'First cat').id, otype: 0, user_id: User.find_by(username: 'First').id)
    new_operation.save()
    new_op = Operation.find_by(odate: "2023-01-05 09:45:43")
    assert_equal("new description", new_op.description)
  end

  test "saving and updating" do
    new_operation = Operation.new(amount: 10, odate: "2023-01-10 09:45:43", description: "new description", category_id: Category.find_by(name: 'First cat').id, otype: 0, user_id: User.find_by(username: 'First').id)
    new_operation.save()
    new_operation.update(odate: "2023-02-12 09:45:43")
    update_operation = Operation.find_by(odate: "2023-02-12 09:45:43")
    assert_equal(10, update_operation.amount)
  end

  test "saving and destroying" do
    new_operation = Operation.new(amount: 15, odate: "2023-01-15 09:45:43", description: "new description", category_id: Category.find_by(name: 'First cat').id, otype: 0, user_id: User.find_by(username: 'First').id)
    new_operation.save()
    new_operation.destroy()
    destroy_operation = Operation.find_by(odate: "2023-01-15 09:45:43")
    assert_nil(destroy_operation)
  end

#testing creating new operation

  test "return false if amount is missed" do
    new_operation = Operation.new(odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 1, user_id: User.find_by(username: 'First').id)
    assert_not(new_operation.valid?)
  end

  test "return false if amount negative" do
    new_operation = Operation.new(amount: -5, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 1, user_id: User.find_by(username: 'First').id)
    assert_not(new_operation.valid?)
  end

  test "return false if amount zero" do
    new_operation = Operation.new(amount: 0, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 1, user_id: User.find_by(username: 'First').id)
    assert_not(new_operation.valid?)
  end

  test "return false if odate missed" do
    new_operation = Operation.new(amount: 5, description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 1, user_id: User.find_by(username: 'First').id)
    assert_not(new_operation.valid?)
  end

  test "return false if description missed" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", category_id: Category.find_by(name: 'First cat').id, otype: 1, user_id: User.find_by(username: 'First').id)
    assert_not(new_operation.valid?)
  end

  test "return false if category_id missed" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", description: "some description", otype: 1, user_id: User.find_by(username: 'First').id)
    assert_not(new_operation.valid?)
  end

  test "return false if otype missed" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, user_id: User.find_by(username: 'First').id)
    assert_not(new_operation.valid?)
  end

  test "return true if everything is good" do
    new_operation = Operation.new(amount: 5, odate: "2023-01-11 07:45:43", description: "some description", category_id: Category.find_by(name: 'First cat').id, otype: 1, user_id: User.find_by(username: 'First').id)
    assert(new_operation.valid?)
  end

#testing reports_data_by_dates

  test "check reports_data_by_dates with fix_1 and fix_2" do
    graph_data = Operation.reports_data_by_dates("2023-01-10", "2023-02-12", "1", Category.find_by(name: 'First cat').id, User.find_by(username: 'First').id)
    assert_equal([["2023-01-11", 9.99], ["2023-02-11", 99.99]], graph_data.map { |e| [e[0].strftime("%Y-%m-%d"), e[1].to_f] })
  end

  test "check reports_data_by_dates with empty dates period" do
    graph_data = Operation.reports_data_by_dates("2020-09-01", "2020-10-01", "1", Category.find_by(name: 'Third cat').id, User.find_by(username: 'Second').id)
    assert_empty(graph_data)
  end

  test "check reports_data_by_dates with dates period from faker" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "1", Category.find_by(name: 'Third cat').id, User.find_by(username: 'Second').id)
    assert_not_empty(graph_data)
  end

  test "check reports_data_by_dates with empty category" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "0", Category.find_by(name: 'Twelfth cat').id, User.find_by(username: 'First').id)
    assert_empty(graph_data)
  end

  test "check reports_data_by_dates with wrong pair otype-category_id" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "1", Category.find_by(name: 'Tenth cat').id, User.find_by(username: 'First').id)
    assert_empty(graph_data)
  end

  test "check reports_data_by_dates with correct pair otype-category_id" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "0", Category.find_by(name: 'Tenth cat').id, User.find_by(username: 'First').id)
    assert_not_empty(graph_data)
  end

  test "check reports_data_by_dates with all outcome category user First" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "0","0", User.find_by(username: 'First').id)
    assert_not_empty(graph_data)
  end

  test "check reports_data_by_dates with all income category user Second" do
    graph_data = Operation.reports_data_by_dates("2022-11-01", "2023-01-01", "1","0", User.find_by(username: 'Second').id)
    assert_not_empty(graph_data)
  end

#testing reports_data_by_category

    test "check reports_data_by_category with fix_1 and fix_2" do
      diagram_data = Operation.reports_data_by_category("2023-01-10", "2023-02-12", "1", Category.find_by(name: 'First cat').id, User.find_by(username: 'First').id)
      assert_equal([["First cat", 109.98]], diagram_data)
    end

  test "check reports_data_by_category with false dates period" do
    diagram_data = Operation.reports_data_by_category("2020-09-01", "2020-10-01", "1", Category.find_by(name: 'Third cat').id, User.find_by(username: 'Second').id)
    assert_empty(diagram_data)
  end

  test "check reports_data_by_category with true dates period from faker" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "1", Category.find_by(name: 'Third cat').id, User.find_by(username: 'Second').id)
    assert_not_empty(diagram_data)
  end

  test "check reports_data_by_category with empty category" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "0", Category.find_by(name: 'Twelfth cat').id, User.find_by(username: 'First').id)
    assert_empty(diagram_data)
  end

  test "check reports_data_by_category with wrong pair otype-category_id" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "1", Category.find_by(name: 'Tenth cat').id, User.find_by(username: 'First').id)
    assert_empty(diagram_data)
  end

  test "check report_data_by_dates with correct pair otype-category_id" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "0", Category.find_by(name: 'Tenth cat').id, User.find_by(username: 'First').id)
    assert_not_empty(diagram_data)
  end

  test "check report_data_by_dates with all outcome category user Second" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "0","0", User.find_by(username: 'Second').id)
    assert_not_empty(diagram_data)
  end

  test "check report_data_by_dates with all income category user First" do
    diagram_data = Operation.reports_data_by_category("2022-11-01", "2023-01-01", "1","0", User.find_by(username: 'First').id)
    assert_not_empty(diagram_data)
  end

end
