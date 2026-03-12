# 学生管理函数

from constants import (
    DATA_FILE,
    DELIMITER,
    ID_INDEX,
    NAME_INDEX,
    MAJOR_INDEX,
    GRADE_INDEX,
)
from utils import format_student_record, parse_student_record

# 加载学生记录
def load_students():
    students = [];
    try:
        with open(DATA_FILE, 'r', encoding='utf-8') as file:
            for line in file:
                if line.strip():
                    students.append(parse_student_record(line))
    except FileNotFoundError:
        # 文件不存在，返回空列表
        pass
    return students

# 学生记录写入到文件
def save_students(students):
    with open (DATA_FILE, 'w', encoding='utf-8') as file:
        for student in students:
            file.write(format_student_record(student) + '\n')

# 检查学号是否已经存在
def is_id_exist(id):
    students = load_students()
    for student in students:
        if student[ID_INDEX] == id:
            return True
    return False

# 添加学生记录
def add_student():
    # 输入学号
    id = input("请输入学号：").strip()
    # 检查学号是否为空
    if not id:
        print("学号不能为空")
        return False
    # 检查学号是否重复
    if is_id_exist(id):
        print("学号已存在")
        return False
    # 检查学号格式
    if not id.isdigit():
        print("学号必须是数字")
        return False

    # 输入姓名
    name = input("请输入姓名：").strip()
    if not name:
        print("姓名不能为空")
        return False
    # 输入专业
    major = input("请输入专业：").strip()
    if not major:
        print("专业不能为空")
        return False
    # 输入年级
    grade = input("请输入年级：").strip()
    if not grade.isdigit() or len(grade)!=4:
        print("年级必须是4位数字年份")
        return False
    
    # 构建一条学生记录
    student = [id, name, major, grade]

    # 保存到学生列表
    students = load_students()
    students.append(student)
    save_students(students)
    print("学生记录添加成功")
    return True