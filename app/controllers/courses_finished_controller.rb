class CoursesFinishedController < ApplicationController
  def index
    limit_date = Time.now.strftime("%Y-%m-%d")
    @courses = Course.where(active: :true).where("finish_date < '#{ limit_date }'")
    @breadcrumbs = [
      [ :name =>'Cursos', :path => courses_path],
      [ :name =>'Cursos finalizados', :path => ''] 
    ]
    @nav_active = [:clients=> '', :courses=> 'active', :programs=> '', :teachers => '']
  end
end
