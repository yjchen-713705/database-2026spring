-- ========== 清理旧表中所有数据 ==========
TRUNCATE TABLE enrollments,
courses,
students,
teachers RESTART IDENTITY CASCADE;
-- ========== teachers ==========
INSERT INTO teachers (name, department)
VALUES ('Alice', 'CS'),
    ('Bob', 'Math'),
    ('Charlie', 'CS'),
    ('David', 'Physics'),
    ('Eve', 'AI'),
    -- Frank不教课
    ('Frank', 'History');
-- ========== students ==========
INSERT INTO students (name, major)
VALUES ('Tom', 'CS'),
    ('Jerry', 'AI'),
    ('Mike', 'Math'),
    ('Lucy', 'CS'),
    ('Anna', 'Physics'),
    ('John', 'AI'),
    ('Lily', 'Math'),
    ('Peter', 'CS'),
    ('Chris', 'AI'),
    -- sophia不选课
    ('Sophia', 'Physics');
-- ========== courses ==========
INSERT INTO courses (course_name, teacher_id, credits)
VALUES ('Database', 1, 3),
    ('Algorithms', 1, 4),
    ('Linear Algebra', 2, 3),
    ('Calculus', 2, 4),
    ('Computer Visualization', 3, 3),
    ('Physics I', 4, 3),
    ('Introduction to Computer Systems', 4, 4),
    ('Natural Language Processing', 5, 4),
    ('AI Intro', 5, 3);
-- ========== enrollments ==========
INSERT INTO enrollments (student_id, course_id, grade)
VALUES -- Tom
    (1, 1, 95),
    (1, 4, 90),
    (1, 5, 90),
    -- Jerry
    (2, 5, 92),
    (2, 6, 87),
    (2, 9, 90),
    -- Mike
    (3, 5, 70),
    -- Lucy
    (4, 1, 95),
    (4, 2, 88),
    (4, 5, 91),
    (4, 6, 80),
    (4, 8, 85),
    -- Anna
    (5, 2, 78),
    -- John
    (6, 1, 55),
    (6, 2, 65),
    (6, 5, 57),
    -- Lily
    (7, 3, 80),
    (7, 4, 82),
    -- Peter
    (8, 1, 90),
    (8, 2, 92),
    (8, 3, 85),
    (8, 4, 88),
    (8, 8, 80),
    -- Chris
    (9, 6, 75);
    -- sophia不选课