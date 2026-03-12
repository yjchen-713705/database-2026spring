# 主程序入口
from utils import print_menu
from student_manager import add_student, search_student, modify_student, delete_student, show_all_students

def main():
    while True:
        # 打印菜单
        print_menu()

        # 获取用户选择
        choice = input("请输入您的选择 (0-5): ").strip()

        # 处理用户选择
        if choice == '0':
            print("退出系统，再见！")
            break
        elif choice == '1':
            add_student()
        elif choice == '2':
            search_student()
        elif choice == '3':
            modify_student()
        elif choice == '4':
            delete_student()
        elif choice == '5':
            show_all_students()
        else:
            print("输入不合法，请重新选择")

if __name__ == "__main__":
    main()