class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.enrolled_in?(current_lesson.section.course)

    else

      redirect_to course_path(current_lesson.section.course), alert: "You first must enroll in this course to access its lessons"

    end
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

end
