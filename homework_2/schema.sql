-- ========== 清理旧表 ==========
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS teachers;
-- ========== teachers ==========
CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    department TEXT
);
-- ========== students ==========
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    major TEXT
);
-- ========== courses ==========
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    teacher_id INT,
    credits INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);
-- ========== enrollments ==========
CREATE TABLE enrollments (
    id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade INT,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
