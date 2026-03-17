# 学生管理函数
import time

from constants import (
    DATA_FILE,
    DELIMITER,
    ID_INDEX,
    NAME_INDEX,
    MAJOR_INDEX,
    GRADE_INDEX,
)
from utils import (
    print_student_record,
    print_list,
    is_id_valid,
    is_id_exist,
    load_students,
    save_students,
    is_grade_valid,
)

# 添加学生记录
def add_student():
    # 输入学号
    id = input("请输入学号：").strip()
    # 检查学号是否合法
    if not is_id_valid(id):
        time.sleep(2)
        return False
    # 检查学号是否重复
    if is_id_exist(id):
        print("学号已存在")
        time.sleep(2)
        return False

    # 输入姓名
    name = input("请输入姓名：").strip()
    if not name:
        print("姓名不能为空")
        input("按任意键返回...")
        return False
    # 输入专业
    major = input("请输入专业：").strip()
    if not major:
        print("专业不能为空")
        input("按任意键返回...")
        return False
    # 输入年级
    grade = input("请输入年级：").strip()
    if not is_grade_valid(grade):   # 为空或不是4位数字年份
        print("年级必须是4位数字年份")
        input("按任意键返回...")
        return False

    # 新增一条学生记录
    student = [id, name, major, grade]
    # 保存到学生列表
    students = load_students()
    students.append(student)
    save_students(students)
    print("学生记录添加成功")
    input("按任意键返回...")
    return True

# 查询学生记录
def search_student():
    # 用户选择模式
    print("\n1. 按学号查询")
    print("2. 按姓名查询")
    choice = input("请输入您的选择 (1-2): ").strip()

    # 学号查询
    if choice == "1":
        id = input("请输入学号：").strip()
        # 检查学号是否合法
        if not is_id_valid(id):
            print("学号格式错误，重新输入：")
            input("按任意键返回...")
            return False
        
        # 在学生列表中寻找该学号学生
        students = load_students()
        found = False
        for student in students:
            if student[ID_INDEX] == id:
                # print("\n找到学生记录:")
                # print(f"学号: {student[ID_INDEX]}")
                # print(f"姓名: {student[NAME_INDEX]}")
                # print(f"专业: {student[MAJOR_INDEX]}")
                # print(f"年级: {student[GRADE_INDEX]}")
                print_student_record(student)
                input("按任意键返回...")
                found = True
                break
        if not found:
            print("未找到该学号的学生记录")
            input("按任意键返回...")
            return False

    # 姓名查询
    elif choice == "2":
        name = input("请输入姓名：").strip()
        # 检查姓名是否为空
        if not name:
            print("姓名不能为空")
            input("按任意键返回...")
            return False

        # TODO：精确or模糊？
        # TODO：查询所有模糊？
        # 精确查询
        students = load_students()
        found = False
        for student in students:
            if student[NAME_INDEX] == name:
                print_student_record(student)
                found = True
                break
        if not found:
            print("未找到该姓名的学生记录")
            input("按任意键返回...")
            return False

        # TODO: 姓名格式错误
    else:
        print("输入不合法，请重新选择")
        input("按任意键返回...")
        return False

# TODO: 实现修改学生信息函数
def modify_student():
    # 读取学号
    id = input("请输入待修改学生的学号：").strip()
    # 检查学号是否合法
    if not is_id_valid(id):
        print("学号格式错误，重新输入：")
        input("按任意键返回...")
        return False
    # 如果学生不存在
    if not is_id_exist(id):
        print("未找到该学号的学生记录")
        input("按任意键返回...")
        return
    
    # 将文件全部读入内存，修改对应记录后，将所有数据重新写回文件
    # 如果学生存在
    # 读入学生列表进入内存
    students = load_students()
    # TODO：使用初学者方法
    # 遍历学生列表，找到对应学号的学生
    for student in students:
        if student[ID_INDEX] == id:
            # 输入新的专业或年级
            major = input("请输入新的专业：").strip()
            if not major:
                print("专业不能为空")
                input("按任意键返回...")
                return False
            
            grade = input("请输入新的年级：").strip()
            if not is_grade_valid(grade):
                print("年级必须是4位数字年份")
                input("按任意键返回...")
                return False
            
            # 更新学生记录
            student[MAJOR_INDEX] = major
            student[GRADE_INDEX] = grade
            print("学生记录修改成功")

            # 保存到学生列表并覆盖回txt文件
            # TODO：是否覆盖？
            save_students(students)
            input("按任意键返回...")
            return True

    # 如果遍历完所有学生都没有找到对应学号的学生
    print("未找到该学号的学生记录")
    input("按任意键返回...")
    return False


# TODO：删除学生记录
def delete_student():
    # 读取学号
    id = input("请输入待删除学生的学号：").strip()
    # 检查学号是否合法
    if not is_id_valid(id):
        print("学号格式错误")
        input("按任意键返回...")
        return False
    # 如果学生不存在
    if not is_id_exist(id):
        print("未找到该学号的学生记录")
        input("按任意键返回...")
        return

    # TODO：封装到utils里去
    # 创建临时文件 → 拷贝除待删除记录外的数据 → 用临时文件覆盖原文件
    temp_file = "data/students_temp.txt"
    # 拷贝除待删除学生记录外的数据
    with open("data/students.txt", "r") as f_in, open(temp_file, "w") as f_out:
        for line in f_in:
            if line.strip().split(DELIMITER)[ID_INDEX] != id:
                f_out.write(line)

# 显示所有学生记录
def show_all_students():
    students = load_students()
    print_list(students)
    input("按任意键返回...")
    return True
