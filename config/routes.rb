Rails.application.routes.draw do
  root 'courses#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :courses
    post '/courses/disable'
  get 'cursos_finalizados', to: 'courses_finished#index', as: 'courses_finished'
  resources :students
    get 'alumnos_por_empresa/:company_id', to: 'students#students_company', as: 'students_company'
    get 'alumno_cursos/:id', to: 'students#student_courses', as: 'student_courses'

    post '/students/disable'
  resources :teachers
    post '/teachers/disable'
  resources :companies
    post '/companies/disable'
  resources :programs
    post '/programs/disable'
  resources :course_types
  resources :course_levels
    post '/course_levels/disable'
  resources :course_students
    post '/course_students/disable'
    get 'get_notes_student/:id', to: 'course_students#get_notes_student', as: 'get_notes_student'

    get 'get_retest_student/:id/:course_retest_id', to: 'course_students#get_notes_student_retest', as: 'get_retest_student'
    get 'get_retest_student_retest/:id/:course_retest_id', to: 'course_students#get_retest_student_retest', as: 'get_retest_student_retest'
    post 'create_course_student_retest', to: 'course_students#create_course_student_retest', as: 'create_course_student_retest'
    
    get 'certificado_wci/:id', to: 'course_students#certificado_wci', as: 'certificado_wci'
    get 'show_certification/:id', to: 'course_students#show_certification', as: 'show_certification'
    post 'absent_student/:id', to: 'course_students#absent_student', as: 'absent_student'
    get 'register_student', to: 'course_students#register_student', as: 'register_student'
    post 'create_and_register_student', to: 'course_students#create_and_register_student', as: 'create_and_register_student'
    get 'get_student_retest/:id', to: 'course_students#get_student_retest', as: 'get_student_retest'  

  resources :certificates, only: [:new, :create, :show]
    get 'certificates/:id', to: 'certificates#get_certificado', as: 'get_certificado'
end
