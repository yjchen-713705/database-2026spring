-- 错误示例：直接删除被外键引用的学生记录
-- 这个操作会因为外键约束而失败

-- 尝试直接删除学生（该学生在enrollments表中有选课记录）
DELETE FROM students 
WHERE id = 1;