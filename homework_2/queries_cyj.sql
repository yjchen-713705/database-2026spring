-- ========== 问题1：多表连接查询 ==========
-- 查询所有学生的姓名、专业以及他们所选课程的课程名称和对应的教师姓名，按学生姓名排序
SELECT 
    s.name AS student_name, 
    s.major, 
    c.course_name, 
    t.name AS teacher_name
FROM 
    students s
INNER JOIN 
    enrollments e ON s.id = e.student_id
INNER JOIN 
    courses c ON e.course_id = c.id
INNER JOIN 
    teachers t ON c.teacher_id = t.id
ORDER BY 
    s.name;

-- ========== 问题2：分组聚合查询 ==========
-- 统计每个专业的学生人数以及他们的平均成绩，只显示平均成绩大于80的专业
SELECT 
    s.major, 
    COUNT(DISTINCT s.id) AS student_count, 
    AVG(e.grade) AS avg_grade
FROM 
    students s
LEFT JOIN 
    enrollments e ON s.id = e.student_id
GROUP BY 
    s.major
HAVING 
    AVG(e.grade) > 80
ORDER BY 
    avg_grade DESC;

-- ========== 问题3：嵌套查询 ==========
-- 查询没有选修任何课程的学生姓名和专业
SELECT 
    name, 
    major
FROM 
    students s
WHERE 
    NOT EXISTS (
        SELECT 
            1 
        FROM 
            enrollments e 
        WHERE 
            e.student_id = s.id
    );

-- ========== 问题4：数据更新操作 ==========
-- 将所有成绩低于60分的学生的成绩提高5分
UPDATE 
    enrollments
SET 
    grade = grade + 5
WHERE 
    grade < 60;

-- 验证更新结果
SELECT 
    student_id, 
    course_id, 
    grade
FROM 
    enrollments
WHERE 
    grade >= 55 AND grade < 65
ORDER BY 
    student_id, course_id;

-- ========== 问题5：综合题目 ==========
-- 查询每个教师所授课程的平均成绩，按平均成绩降序排序，只显示平均成绩前5名的教师信息
SELECT 
    t.name AS teacher_name, 
    t.department, 
    AVG(e.grade) AS avg_grade
FROM 
    teachers t
LEFT JOIN 
    courses c ON t.id = c.teacher_id
LEFT JOIN 
    enrollments e ON c.id = e.course_id
GROUP BY 
    t.id, t.name, t.department
HAVING 
    AVG(e.grade) IS NOT NULL
ORDER BY 
    avg_grade DESC
LIMIT 5;