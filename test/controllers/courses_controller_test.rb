require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of courses' do
    get courses_path
    assert_response :success
    assert_select '.course', 2
  end

  test 'render a detailed course' do
    get course_path(courses(:course1))
    assert_response :success
    assert_select '.title', 'Learnig Ruby'
    assert_select '.description', 'This is a course to learn Ruby'
  end

  test 'render the new course form' do
    get new_course_path
    assert_response :success
    assert_select 'form' do
      assert_select 'input[type=submit]', 1
    end
  end

  test 'create a new course' do
    post courses_path,
         params: { course: { title: 'New Course', description: 'This is a new course' } }
    assert_redirected_to courses_path
    assert_equal 'Curso creado con éxito', flash[:notice]
  end

  test 'create a new course with empty values' do
    post courses_path, params: { course: { title: '', description: '' } }
    assert_response :unprocessable_entity
  end

  test 'render the edit course form' do
    get edit_course_path(courses(:course1))
    assert_response :success
    assert_select 'form'
  end

  test 'update course' do
    patch course_path(courses(:course1)),
          params: { course: { title: 'Learnig ruby on rails' } }
    assert_redirected_to courses_path
    assert_equal 'Curso actualizado con éxito', flash[:notice]
  end

  test 'delete couse' do
    delete course_path(courses(:course1))
    assert_redirected_to courses_path
    assert_equal 'Curso eliminado con éxito', flash[:notice]
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
