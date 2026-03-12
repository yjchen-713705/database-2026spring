# 工具函数

from constants import DELIMITER, ID_INDEX, NAME_INDEX, MAJOR_INDEX, GRADE_INDEX

# 打印菜单
def print_menu():
    print("\n=== 学籍管理系统 ===")
    print("1. 添加学生记录")
    print("2. 查询学生记录")
    print("3. 修改学生信息")
    print("4. 删除学生记录")
    print("5. 显示所有记录")
    print("0. 退出系统")
    print("==================")

# txt文件解析函数
# 解析学生记录行
def parse_student_record(line):
    return line.strip().split(DELIMITER)

# 格式化学生记录为字符串
def format_student_record(student):
    return DELIMITER.join(student)

# 打印单条学生记录
def print_student_record(student):
    print(f"学号: {student[ID_INDEX]}")
    print(f"姓名: {student[NAME_INDEX]}")
    print(f"专业: {student[MAJOR_INDEX]}")
    print(f"年级: {student[GRADE_INDEX]}")

# 表格形式打印所有学生记录
def print_list(students):
    print("\n=== 所有学生记录 ===")
    print(f"{'学号':<10}{'姓名':<10}{'专业':<10}{'年级':<10}")
    print("="*40)
    for student in students:
        print(f"{student[ID_INDEX]:<10}{student[NAME_INDEX]:<10}{student[MAJOR_INDEX]:<10}{student[GRADE_INDEX]:<10}")
    print("="*40)