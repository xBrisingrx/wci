# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2025_01_10_211343) do

  create_table "certificates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "finish_date", null: false
    t.string "student", null: false
    t.bigint "dni", null: false
    t.string "teacher", null: false
    t.string "mode", null: false
    t.string "program_number", null: false
    t.string "course", null: false
    t.string "number", null: false
    t.string "path"
    t.bigint "program_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "expire", default: true
    t.index ["program_id"], name: "index_certificates_on_program_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "cuit"
    t.string "email"
    t.string "country"
    t.string "phone"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_levels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_students", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.integer "simulation_grade", default: 0
    t.date "simulation_grade_date"
    t.integer "simulation_bh_grade", default: 0
    t.date "simulation_bh_grade_date"
    t.integer "simulation_inv_grade", default: 0
    t.date "simulation_inv_grade_date"
    t.integer "final_grade", default: 0
    t.date "final_grade_date"
    t.integer "remedial_exam_note", default: 0
    t.date "remedial_exam_note_date"
    t.integer "status", default: 0
    t.text "comment"
    t.boolean "active", default: true
    t.bigint "student_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "remedial_course_id"
    t.boolean "is_retest", default: false
    t.boolean "retest_pending", default: true
    t.index ["course_id"], name: "index_course_students_on_course_id"
    t.index ["remedial_course_id"], name: "fk_rails_be23097bf7"
    t.index ["student_id"], name: "index_course_students_on_student_id"
  end

  create_table "course_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.date "start_date"
    t.date "finish_date"
    t.time "start_hour"
    t.time "finish_hour"
    t.string "place"
    t.bigint "course_level_id"
    t.bigint "course_type_id"
    t.bigint "teacher_id"
    t.bigint "program_id"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_level_id"], name: "index_courses_on_course_level_id"
    t.index ["course_type_id"], name: "index_courses_on_course_type_id"
    t.index ["program_id"], name: "index_courses_on_program_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "programs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "certificate"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "legajo"
    t.string "name"
    t.string "lastname"
    t.date "birthdate"
    t.string "country"
    t.integer "dni"
    t.string "email"
    t.string "phone"
    t.text "comment"
    t.boolean "active", default: true
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_students_on_company_id"
  end

  create_table "teachers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "dni"
    t.string "country"
    t.string "email"
    t.string "title"
    t.string "phone"
    t.text "comment"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "certificates", "programs"
  add_foreign_key "course_students", "courses"
  add_foreign_key "course_students", "courses", column: "remedial_course_id"
  add_foreign_key "course_students", "students"
  add_foreign_key "courses", "course_levels"
  add_foreign_key "courses", "course_types"
  add_foreign_key "courses", "programs"
  add_foreign_key "courses", "teachers"
  add_foreign_key "students", "companies"
end
