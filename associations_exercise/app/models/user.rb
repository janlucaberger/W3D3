class User < ActiveRecord::Base

  has_many :enrollments,
    class_name: "Enrollment",
    primary_key: :id,
    foreign_key: :student_id

  has_many :enrolled_courses, through: :enrollments, source: :course

  has_many :taught_courses,
    primary_key: :id,
    foreign_key: :instructor_id,
    class_name: :Course
end
