# 工具函数

from constants import DELIMITER, ID_INDEX, NAME_INDEX, MAJOR_INDEX, GRADE_INDEX, DATA_FILE


# txt文件读写函数
# 解析学生记录行
def parse_student_record(line):
    return line.strip().split(DELIMITER)

# 格式化学生记录为字符串
def format_student_record(student):
    return DELIMITER.join(student)

# 加载学生记录
def load_students():
    students = []
    try:
        with open(DATA_FILE, "r", encoding="utf-8") as file:
            for line in file:
                if line.strip():
                    students.append(parse_student_record(line))
    except FileNotFoundError:
        # 文件不存在，返回空列表
        pass
    return students

# 学生记录重新保存到文件
def save_students(students):
    with open(DATA_FILE, "w", encoding="utf-8") as file:
        for student in students:
            file.write(format_student_record(student) + "\n")


# 输入合法性检查函数
# 检查学号是否合法
def is_id_valid(id):
    # 学号为空或非数字不合法
    if not id:
        print("学号不能为空")
        return False
    if not id.isdigit():
        print("学号必须是数字")
        return False
    return True

# 检查学号是否已经存在
def is_id_exist(id):
    students = load_students()
    for student in students:
        if student[ID_INDEX] == id:
            return True
    return False

# 检查年级是否合法
def is_grade_valid(grade):
    # 年级为空或非4位数字
    if not grade:
        print("年级不能为空")
        return False
    if not grade.isdigit() or len(grade) != 4:
        print("年级必须是4位数字年份")
        return False
    return True

# 打印函数
# 打印开始菜单
def print_menu():
    print("\n=== 学籍管理系统 ===")
    print("1. 添加学生记录")
    print("2. 查询学生记录")
    print("3. 修改学生信息")
    print("4. 删除学生记录")
    print("5. 显示所有记录")
    print("0. 退出系统")
    print("====================")

# 打印单条学生记录
def print_student_record(student):
    print(f"{'学号: '}{student[ID_INDEX]:<10}{'姓名: '}{student[NAME_INDEX]:<8}{'专业: '}{student[MAJOR_INDEX]:<10}{'年级:'}{student[GRADE_INDEX]}")

# 表格形式打印所有学生记录
def print_list(students):
    print("\n所有学生记录:")
    print(f"{'学号':<10}{'姓名':<10}{'专业':<10}{'年级':<10}")
    print("=" * 40)
    if not students:
        print("\n暂无学生记录")
    else:
        for student in students:
            print(f"{student[ID_INDEX]:<10}{student[NAME_INDEX]:<10}{student[MAJOR_INDEX]:<10}{student[GRADE_INDEX]:<10}")
    print("=" * 40)