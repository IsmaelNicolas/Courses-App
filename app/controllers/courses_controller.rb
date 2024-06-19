class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy enroll]
  before_action :authorize_creator_or_admin!, only: %i[edit update destroy]
  before_action :validate_active_course_limit, only: %i[update]

  # GET /courses or /courses.json
  def index
    if Current.user.nil? || Current.user.consumer? || Current.user.admin?
      @courses = Course.all.with_attached_image
    elsif Current.user.creator?
      @courses = Current.user.courses.with_attached_image
    else
      @courses = Course.none
    end
  end

  # GET /courses/1 or /courses/1.json
  def show; end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit; end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_path, notice: 'Curso creado con éxito' }
      else
        Rails.logger.info @course.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to courses_path, notice: 'Curso actualizado con éxito' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy!

    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Curso eliminado con éxito' }
    end
  end

  def enroll
    if Current.user.consumer? && !@course.consumer_enrolled?(Current.user)
      @course.enrollments.create(user: Current.user)
      redirect_to courses_path, notice: 'Inscripción realizada con éxito.'
    else
      redirect_to courses_path, alert: 'No se pudo realizar la inscripción.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :image, :status)
  end

  def authorize_creator_or_admin!
    unless Current.user.admin? || (Current.user.creator? && @course.user == Current.user)
      redirect_to courses_path, alert: 'No tienes permiso para realizar esta acción'
    end
  end

  def validate_active_course_limit
    if course_params[:status] == 'active' && Current.user.creator? && Current.user.courses.active.count >= 2 && @course.status != 'active'
      redirect_to edit_course_path(@course), alert: 'No puedes tener más de dos cursos activos.'
    end
  end
end
