-- 第1题-------------------------------------------------------------------
-- 出题人：陈一璟       答题人：佘子曦
SELECT students.name AS student_name,students.major,
        courses.name AS course_name,teachers.name AS teacher_name
FROM students
JOIN enrollments
    ON enrollments.student_id=students.id
JOIN courses
    ON courses.id=enrollments.course_id
JOIN teachers
    ON courses.teacher_id=teachers.id
ORDER BY students.name ASC;

-- 第2题-------------------------------------------------------------------
-- 出题人：陈一璟       答题人：佘子曦
SELECT students.major, COUNT(DISTINCT students.id) AS students_number,
    ROUND(AVG(enrollments.grade),2) AS avg_grade
FROM students
JOIN enrollments
    ON enrollments.student_id=students.id
GROUP BY students.major
HAVING AVG(enrollments.grade)>80;

-- 第3题-------------------------------------------------------------------
-- 出题人：陈一璟       答题人：佘子曦
SELECT students.name,students.major
FROM students
WHERE NOT EXISTS(
    SELECT enrollments.student_id
    FROM enrollments
    WHERE enrollments.student_id=students.id
);

-- 第4题-------------------------------------------------------------------
-- 出题人：陈一璟       答题人：佘子曦
UPDATE enrollments
SET grade=grade+5
WHERE grade<60;

-- 第5题-------------------------------------------------------------------
-- 出题人：陈一璟       答题人：佘子曦
SELECT teachers.name AS teacher_name,teachers.department,
        ROUND(AVG(enrollments.grade),2)AS avg_grade 
FROM teachers
JOIN courses
    ON courses.teacher_id=teachers.id
JOIN enrollments
    ON enrollments.course_id=courses.id
GROUP BY teachers.name,teachers.department
ORDER BY avg_grade DESC
LIMIT 5;

-- 第6题-------------------------------------------------------------------
-- 出题人：佘子曦       答题人：陈一璟
SELECT s.name AS student_name,
    s.major AS student_major,
    c.name AS course_name,
    c.credits AS course_credits,
    t.name AS teacher_name,
    t.department AS teacher_department,
    e.grade AS grade
FROM students s
INNER JOIN enrollments e ON s.id = e.student_id
INNER JOIN courses c ON e.course_id = c.id
INNER JOIN teachers t ON c.teacher_id = t.id
WHERE s.major <> t.department
ORDER BY c.credits DESC, e.grade DESC, s.name ASC;

-- 第7题-------------------------------------------------------------------
-- 出题人：佘子曦       答题人：陈一璟
SELECT c.credits AS course_credits,
    COUNT(DISTINCT c.id) AS course_count,
    COUNT(DISTINCT e.id) AS enrollment_count,
    MAX(e.grade) AS max_grade,
    MIN(e.grade) AS min_grade,
    ROUND(AVG(e.grade), 2) AS avg_grade
FROM courses c
INNER JOIN enrollments e ON c.id = e.course_id
GROUP BY c.credits
HAVING COUNT(DISTINCT e.id) >= 10;

-- 第8题-------------------------------------------------------------------
-- 出题人：佘子曦       答题人：陈一璟
SELECT c.name AS course_name,
    c.credits AS course_credits,
    t.name AS teacher_name
FROM courses c
INNER JOIN teachers t ON c.teacher_id = t.id
WHERE NOT EXISTS (
        SELECT 1
        FROM enrollments e
            INNER JOIN students s ON e.student_id = s.id
        WHERE e.course_id = c.id
            AND s.major = 'AI'
    )
ORDER BY c.credits DESC, c.name ASC;

-- 第9题-------------------------------------------------------------------
-- 出题人：佘子曦       答题人：陈一璟
UPDATE enrollments e
SET grade = LEAST(e.grade + 3, 100)
FROM courses c
WHERE e.course_id = c.id
    AND c.credits = 2;

-- 第10题-------------------------------------------------------------------
-- 出题人：佘子曦       答题人：陈一璟
SELECT c.name AS course_name,
    c.credits AS course_credits,
    t.name AS teacher_name,
    t.department AS teacher_department,
    COUNT(e.student_id) AS enrollment_count,
    ROUND(AVG(e.grade), 2) AS avg_grade,
    ROUND(
        SUM(
            CASE
                WHEN e.grade >= 90 THEN 1
                ELSE 0
            END
        ) * 100.00 / COUNT(e.student_id),
        2
    ) AS excellent_rate
FROM courses c
INNER JOIN teachers t ON c.teacher_id = t.id
INNER JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id,
    c.name,
    c.credits,
    t.name,
    t.department
ORDER BY enrollment_count DESC,
    avg_grade DESC
LIMIT 5;