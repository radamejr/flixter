class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show, :update, :edit]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)

    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end

  end

  def show
    
  end
  
  def edit

  end

  def update
    @course = Course.find(params[:id])

    if @course.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end

    @course.update_attributes(course_params)
    
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :edit, status: :unprocessable_entity
    end
  
  end


  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      render plain: "Unauthorized", status: :unauthorized
    end
  end
    
  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :cost, :image)
  end

end
