-- 正确的删除顺序：先删除关联的选课记录，再删除学生
-- 第一步：删除该学生的所有选课记录
DELETE FROM enrollments WHERE student_id = 1;

-- 第二步：现在可以成功删除学生
DELETE FROM students WHERE id = 1;

