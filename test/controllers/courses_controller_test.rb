require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of courses' do
    get courses_path
    assert_response :success
    assert_select '.course', 2
  end

  test 'render a detailed course' do
    get courses_path(courses(:course1))
    assert_response :success
    assert_select '.title', 'Learnig Ruby'
    assert_select '.description', 'This is a course to learn Ruby'
  end

  # setup do
  #   @course = courses(:one)
  # end

  # test "should get index" do
  #   get courses_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_course_url
  #   assert_response :success
  # end

  # test "should create course" do
  #   assert_difference("Course.count") do
  #     post courses_url, params: { course: { description: @course.description, title: @course.title } }
  #   end

  #   assert_redirected_to course_url(Course.last)
  # end

  # test "should show course" do
  #   get course_url(@course)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_course_url(@course)
  #   assert_response :success
  # end

  # test "should update course" do
  #   patch course_url(@course), params: { course: { description: @course.description, title: @course.title } }
  #   assert_redirected_to course_url(@course)
  # end

  # test "should destroy course" do
  #   assert_difference("Course.count", -1) do
  #     delete course_url(@course)
  #   end

  #   assert_redirected_to courses_url
  # end
end
