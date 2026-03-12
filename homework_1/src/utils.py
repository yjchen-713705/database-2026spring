# 工具函数

from constants import DELIMITER

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