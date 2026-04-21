-- ========== 清理旧表 ==========
TRUNCATE TABLE enrollments,
courses,
students,
teachers RESTART IDENTITY CASCADE;

-- ========== teachers ==========
-- 设计说明：
-- 1. 覆盖多个院系，便于做分组统计、连接查询
-- 2. 保留少量“没有开课的教师”，便于练习 LEFT JOIN / NOT EXISTS
INSERT INTO teachers (name, department)
VALUES
    ('Alice', 'CS'),
    ('Bob', 'Math'),
    ('Charlie', 'CS'),
    ('David', 'Physics'),
    ('Eve', 'AI'),
    ('Frank', 'History'),
    ('Grace', 'Biology'),
    ('Henry', 'Chemistry'),
    ('Ivy', 'Economics'),
    ('Jack', 'Statistics'),
    ('Karen', 'Philosophy'),
    ('Leo', 'Data Science');

-- ========== students ==========
-- 设计说明：
-- 1. 增加更多专业类型与人数，便于练习 major 相关筛选与聚合
-- 2. 保留少量“未选课学生”，便于练习外连接与空值判断
INSERT INTO students (name, major)
VALUES
    ('Tom', 'CS'),
    ('Jerry', 'AI'),
    ('Mike', 'Math'),
    ('Lucy', 'CS'),
    ('Anna', 'Physics'),
    ('John', 'AI'),
    ('Lily', 'Math'),
    ('Peter', 'CS'),
    ('Chris', 'AI'),
    ('Sophia', 'Physics'),
    ('Emma', 'Biology'),
    ('Noah', 'Chemistry'),
    ('Olivia', 'Economics'),
    ('Liam', 'Statistics'),
    ('Mason', 'Data Science'),
    ('Ava', 'CS'),
    ('Ethan', 'AI'),
    ('Isabella', 'Biology'),
    ('James', 'Physics'),
    ('Mia', 'Math'),
    ('Benjamin', 'Economics'),
    ('Charlotte', 'Data Science'),
    ('Amelia', 'Chemistry'),
    ('Elijah', 'CS'),
    ('Harper', 'AI'),
    ('Lucas', 'History'),
    ('Evelyn', 'Philosophy'),
    ('Alexander', 'Statistics'),
    ('Abigail', 'Biology'),
    ('Daniel', 'CS');

-- ========== courses ==========
-- 设计说明：
-- 1. 不同学分分布（2/3/4）
-- 2. 每个院系都有一定课程覆盖
-- 3. 保留“无课教师”：Frank(History), Karen(Philosophy)
INSERT INTO courses (course_name, teacher_id, credits)
VALUES
    ('Database Systems', 1, 3),
    ('Algorithms', 1, 4),
    ('Operating Systems', 3, 4),
    ('Computer Networks', 3, 3),
    ('Linear Algebra', 2, 3),
    ('Calculus', 2, 4),
    ('Probability Theory', 10, 3),
    ('Physics I', 4, 3),
    ('Quantum Mechanics', 4, 4),
    ('AI Intro', 5, 3),
    ('Machine Learning', 5, 4),
    ('Natural Language Processing', 5, 4),
    ('Molecular Biology', 7, 3),
    ('Genetics', 7, 4),
    ('Organic Chemistry', 8, 4),
    ('Microeconomics', 9, 3),
    ('Macroeconomics', 9, 3),
    ('Data Mining', 12, 3),
    ('Deep Learning', 12, 4),
    ('Scientific Computing', 10, 2);

-- ========== enrollments ==========
-- 设计说明：
-- 1. 成绩分布覆盖优秀/良好/及格/不及格
-- 2. 存在跨专业选课，便于练习“本专业 vs 跨专业”分析
-- 3. 存在高课载和低课载学生，便于做计数/排名
-- 4. Sophia(id=10) 与 Evelyn(id=27) 不选课，便于练习“未选课学生”
INSERT INTO enrollments (student_id, course_id, grade)
VALUES
    -- Tom (CS)
    (1, 1, 95),
    (1, 2, 91),
    (1, 5, 88),
    (1, 10, 84),

    -- Jerry (AI)
    (2, 10, 93),
    (2, 11, 96),
    (2, 12, 90),
    (2, 18, 89),

    -- Mike (Math)
    (3, 5, 86),
    (3, 6, 82),
    (3, 7, 79),
    (3, 20, 85),

    -- Lucy (CS)
    (4, 1, 94),
    (4, 2, 89),
    (4, 3, 92),
    (4, 4, 87),
    (4, 19, 85),

    -- Anna (Physics)
    (5, 8, 90),
    (5, 9, 84),
    (5, 6, 76),
    (5, 20, 81),

    -- John (AI)
    (6, 10, 58),
    (6, 11, 65),
    (6, 12, 61),
    (6, 18, 72),

    -- Lily (Math)
    (7, 5, 91),
    (7, 6, 88),
    (7, 7, 93),

    -- Peter (CS)
    (8, 1, 90),
    (8, 2, 92),
    (8, 5, 85),
    (8, 11, 87),
    (8, 19, 91),

    -- Chris (AI)
    (9, 10, 78),
    (9, 11, 82),
    (9, 18, 80),

    -- Sophia (Physics) -> 不选课

    -- Emma (Biology)
    (11, 13, 94),
    (11, 14, 92),
    (11, 15, 78),
    (11, 20, 88),

    -- Noah (Chemistry)
    (12, 15, 90),
    (12, 13, 74),
    (12, 6, 69),

    -- Olivia (Economics)
    (13, 16, 95),
    (13, 17, 91),
    (13, 7, 84),
    (13, 18, 87),

    -- Liam (Statistics)
    (14, 7, 93),
    (14, 20, 90),
    (14, 18, 88),
    (14, 11, 86),

    -- Mason (Data Science)
    (15, 18, 92),
    (15, 19, 94),
    (15, 11, 90),
    (15, 7, 85),

    -- Ava (CS)
    (16, 1, 88),
    (16, 3, 90),
    (16, 4, 86),
    (16, 19, 89),

    -- Ethan (AI)
    (17, 10, 85),
    (17, 11, 87),
    (17, 12, 83),
    (17, 19, 91),

    -- Isabella (Biology)
    (18, 13, 89),
    (18, 14, 87),
    (18, 20, 84),

    -- James (Physics)
    (19, 8, 77),
    (19, 9, 73),
    (19, 6, 68),
    (19, 15, 70),

    -- Mia (Math)
    (20, 5, 84),
    (20, 6, 80),
    (20, 7, 82),
    (20, 16, 75),

    -- Benjamin (Economics)
    (21, 16, 88),
    (21, 17, 86),
    (21, 18, 79),

    -- Charlotte (Data Science)
    (22, 18, 95),
    (22, 19, 96),
    (22, 7, 90),
    (22, 20, 93),

    -- Amelia (Chemistry)
    (23, 15, 85),
    (23, 13, 80),
    (23, 14, 76),

    -- Elijah (CS)
    (24, 2, 59),
    (24, 3, 72),
    (24, 4, 68),
    (24, 19, 74),

    -- Harper (AI)
    (25, 10, 91),
    (25, 11, 93),
    (25, 12, 94),
    (25, 18, 90),
    (25, 19, 92),

    -- Lucas (History)
    (26, 16, 72),
    (26, 17, 75),
    (26, 13, 70),

    -- Evelyn (Philosophy) -> 不选课

    -- Alexander (Statistics)
    (28, 7, 88),
    (28, 20, 91),
    (28, 18, 86),
    (28, 17, 78),

    -- Abigail (Biology)
    (29, 13, 93),
    (29, 14, 90),
    (29, 20, 89),
    (29, 11, 81),

    -- Daniel (CS)
    (30, 1, 83),
    (30, 2, 79),
    (30, 3, 85),
    (30, 4, 80),
    (30, 18, 88);

-- 额外保留的边界情况：
-- 1. Frank(id=6)、Karen(id=11) 没有开课
-- 2. Sophia(id=10)、Evelyn(id=27) 没有选课
-- 3. John(id=6)、Elijah(id=24) 存在不及格成绩
-- 4. 多名学生存在跨专业选课，可用于连接分析与统计练习
