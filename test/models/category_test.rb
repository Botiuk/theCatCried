require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  test "check the 'First cat' description" do
    category_first = Category.find_by(name: 'First cat')
    assert_equal("First cat description", category_first.description)
  end

  test "saving and gathering" do
    new_category = Category.new(name: "new category", description: "new description", ctype: 0, user_id: User.find_by(username: 'First').id)
    new_category.save()
    new_cat = Category.find_by(name: "new category")
    assert_equal("new description", new_cat.description)
  end

  test "saving and updating" do
    new_category = Category.new(name: "new category", description: "new description", ctype: 0, user_id: User.find_by(username: 'First').id)
    new_category.save()
    new_category.update(name: "update category")
    update_category = Category.find_by(name: "update category")
    assert_equal("new description", update_category.description)
  end

  test "saving and destroying" do
    new_category = Category.new(name: "destroy category", description: "new description", ctype: 0, user_id: User.find_by(username: 'First').id)
    new_category.save()
    new_category.destroy()
    destroy_category = Category.find_by(name: "destroy category")
    assert_nil(destroy_category)
  end

#testing creating new category

  test "return false if name is missed" do
    new_category = Category.new(description: "some description", ctype: 0, user_id: User.find_by(username: 'First').id)
    assert_not(new_category.valid?)
  end

  test "return false if description is missed" do
    new_category = Category.new(name: "some name", ctype: 0, user_id: User.find_by(username: 'First').id)
    assert_not(new_category.valid?)
  end

  test "return false if ctype is missed" do
    new_category = Category.new(name: "some name", description: "other description", user_id: User.find_by(username: 'First').id)
    assert_not(new_category.valid?)
  end

  test "return false if name not unique" do
    new_category1 = Category.new(name: "some name", description: "some description", ctype: 0, user_id: User.find_by(username: 'First').id)
    new_category1.save()
    new_category2 = Category.new(name: "some name", description: "other description", ctype: 0, user_id: User.find_by(username: 'First').id)
    assert_not(new_category2.valid?)
  end

  test "return true if description not unique" do
    new_category1 = Category.new(name: "some name", description: "some description", ctype: 0, user_id: User.find_by(username: 'First').id)
    new_category1.save()
    new_category2 = Category.new(name: "other name", description: "some description", ctype: 0, user_id: User.find_by(username: 'First').id)
    assert(new_category2.valid?)
  end

  test "return true if everything is good" do
    new_category = Category.new(name: "new category", description: "new description", ctype: 1, user_id: User.find_by(username: 'Second').id)
    assert(new_category.valid?) 
  end
  
end
