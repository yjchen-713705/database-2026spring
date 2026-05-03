--Q1-------------------------------------------------------------------
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

--Q2-------------------------------------------------------------------
SELECT students.major, COUNT(DISTINCT students.id) AS students_number,
    ROUND(AVG(enrollments.grade),2) AS avg_grade
FROM students
JOIN enrollments
    ON enrollments.student_id=students.id
GROUP BY students.major
HAVING AVG(enrollments.grade)>80;

--Q3-------------------------------------------------------------------
SELECT students.name,students.major
FROM students
WHERE NOT EXISTS(
    SELECT enrollments.student_id
    FROM enrollments
    WHERE enrollments.student_id=students.id
);

--Q4-------------------------------------------------------------------
UPDATE enrollments
SET grade=grade+5
WHERE grade<60;

--Q5-------------------------------------------------------------------
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