-- ========== 问题1：多表连接查询 ==========
-- 查询跨专业选课记录
SELECT
    s.name AS student_name,
    s.major AS student_major,
    c.name AS course_name,
    c.credits AS course_credits,
    t.name AS teacher_name,
    t.department AS teacher_department,
    e.grade AS grade
FROM
    students s
INNER JOIN enrollments e ON s.id = e.student_id
INNER JOIN courses c ON e.course_id = c.id
INNER JOIN teachers t ON c.teacher_id = t.id
WHERE
    s.major <> t.department

ORDER BY
    course_credits DESC, grade DESC;


-- ========== 问题2：分组聚合查询 ==========
-- 需要将选课表和课程表连接起来
SELECT
    c.credits AS course_credits,
    COUNT(DISTINCT c.id) AS course_count,
    COUNT(DISTINCT e.id) AS enrollment_count,
    MAX(e.grade) AS max_grade,
    MIN(e.grade) AS min_grade,
    ROUND(AVG(e.grade), 2) AS avg_grade
FROM courses c
INNER JOIN enrollments e ON c.id = e.course_id
GROUP BY c.credits
HAVING COUNT(DISTINCT e.id) >= 10;


-- ========== 问题3：嵌套查询 ==========
-- 查询从未被 AI 专业学生选修过的课程名称、学分以及对应授课教师姓名
SELECT
    c.name AS course_name,
    c.credits AS course_credits,
    t.name AS teacher_name
FROM courses c
INNER JOIN teachers t ON c.teacher_id = t.id
WHERE NOT EXISTS (
    SELECT 1 FROM enrollments e
    INNER JOIN students s ON e.student_id = s.id
    WHERE e.course_id = c.id AND s.major = 'AI'
)
ORDER BY c.credits DESC;


-- -- ========== 问题4：数据更新操作 ==========
UPDATE enrollments e
SET grade = LEAST(grade + 3, 100)
FROM courses c
WHERE e.course_id = c.id AND c.credits = 2; -- TODO: 验证更新结果



-- ========== 问题5：综合题 ==========
SELECT
    c.name AS course_name,
    c.credits AS course_credits,
    t.name AS teacher_name,
    t.department AS teacher_department,
    COUNT(e.student_id) AS enrollment_count,
    ROUND(AVG(e.grade),2) AS avg_grade,
    ROUND(SUM(CASE WHEN e.grade >= 90 THEN 1 ELSE 0 END)*100.00/COUNT(e.student_id), 2) AS A_percentage
FROM courses c
INNER JOIN teachers t ON c.teacher_id = t.id
INNER JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.name, c.credits, t.name, t.department
ORDER BY enrollment_count DESC, avg_grade DESC
LIMIT 5;