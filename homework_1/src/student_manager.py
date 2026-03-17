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
    id = input("\n请输入学号：").strip()
    # 检查学号是否合法
    if not is_id_valid(id):
        print("\n学号格式错误")
        input("\n按任意键返回...")
        return False
    # 检查学号是否重复
    if is_id_exist(id):
        print("\n学号已存在")
        input("\n按任意键返回...")
        return False

    # 输入姓名
    name = input("\n请输入姓名：").strip()
    if not name:
        print("姓名不能为空")
        input("\n按任意键返回...")
        return False
    # 输入专业
    major = input("\n请输入专业：").strip()
    if not major:
        print("专业不能为空")
        input("\n按任意键返回...")
        return False
    # 输入年级
    grade = input("\n请输入年级：").strip()
    if not is_grade_valid(grade):
        print("年级必须是4位数字年份")
        input("\n按任意键返回...")
        return False

    # 新增一条学生记录
    # TODO: 报告里写是什么类型
    student = [id, name, major, grade]
    # 保存到学生列表
    students = load_students()
    students.append(student)
    save_students(students)
    print("学生记录添加成功")
    input("\n按任意键返回...")
    return True

# 查询学生记录
def search_student():
    # 用户选择模式
    print("\n1. 按学号查询")
    print("2. 按姓名精确查询")
    print("3. 按姓名模糊查询")
    choice = input("请输入您的选择 (1-3): ").strip()

    # 学号查询
    if choice == "1":
        id = input("\n请输入学号：").strip()
        # 检查学号是否合法
        if not is_id_valid(id):
            print("\n学号格式错误")
            input("\n按任意键返回...")
            return False
        
        # 在学生列表中寻找该学号学生
        students = load_students()
        found = False
        for student in students:
            if student[ID_INDEX] == id:
                print("\n找到该学号的学生记录：\n")
                print_student_record(student)
                input("\n按任意键返回...")
                found = True
                break
        if not found:
            print("\n未找到该学号的学生记录")
            input("\n按任意键返回...")
            return False

    # 姓名查询
    elif choice == "2":
        name = input("\n请输入姓名：").strip()
        # 检查姓名是否为空
        if not name:
            print("\n姓名不能为空")
            input("\n按任意键返回...")
            return False
        
        # TODO：查询所有模糊？
        # 精确查询
        students = load_students()
        found = False
        # 如果找到，一次性打印所有姓名为name的记录
        for student in students:
            if student[NAME_INDEX] == name:
                print("\n找到该姓名的学生记录：\n")
                print_student_record(student)
                input("\n按任意键返回...")
                found = True
                break
        if not found:
            print("\n未找到该姓名的学生记录")
            input("\n按任意键返回...")
            return False

    # TODO：模糊查询
    elif choice == "3":
        name = input("\n请输入姓名：").strip()
        # 检查姓名是否为空
        if not name:
            print("\n姓名不能为空")
            input("\n按任意键返回...")
            return False
        
        # 模糊查询
        students = load_students()
        found = False
        for student in students:
            if name in student[NAME_INDEX]:
                print("\n找到该姓名的学生记录：\n")
                print_student_record(student)
                input("\n按任意键返回...")
                found = True
                
        if not found:
            print("\n未找到该姓名的学生记录")
            input("\n按任意键返回...")
            return False
        
    else:
        print("\n输入不合法，请重新选择")
        input("\n按任意键返回...")
        return False

# TODO: 实现修改学生信息函数
def modify_student():
    # 读取学号
    id = input("\n请输入待修改学生的学号：").strip()
    # 检查学号是否合法
    if not is_id_valid(id):
        print("\n学号格式错误，重新输入：")
        input("\n按任意键返回...")
        return False
    # 如果学生不存在
    if not is_id_exist(id):
        print("\n未找到该学号的学生记录")
        input("\n按任意键返回...")
        return False
    
    # 如果学生存在
    # 读入学生列表进入内存
    students = load_students()
    # 遍历学生列表，找到对应学号的学生
    for student in students:
        if student[ID_INDEX] == id:
            # 输入新的专业或年级
            major = input("\n请输入新的专业：").strip()
            if not major:
                print("\n专业不能为空")
                input("\n按任意键返回...")
                return False
            
            grade = input("\n请输入新的年级：").strip()
            if not is_grade_valid(grade):
                print("\n年级必须是4位数字年份")
                input("\n按任意键返回...")
                return False
            
            # 更新学生记录
            student[MAJOR_INDEX] = major
            student[GRADE_INDEX] = grade
            print("\n学生记录修改成功")

            # 保存到学生列表并覆盖回txt文件
            save_students(students)
            input("\n按任意键返回...")
            return True

    # 如果遍历完所有学生都没有找到对应学号的学生
    print("\n未找到该学号的学生记录")
    input("\n按任意键返回...")
    return False


# TODO：删除学生记录
def delete_student():
    # 读取学号
    id = input("\n请输入待删除学生的学号：").strip()
    # 检查学号是否合法
    if not is_id_valid(id):
        print("\n学号格式错误")
        input("\n按任意键返回...")
        return False
    # 如果学生不存在
    if not is_id_exist(id):
        print("\n未找到该学号的学生记录")
        input("\n按任意键返回...")
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
    input("\n按任意键返回...")
    return True
