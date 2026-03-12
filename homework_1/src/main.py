# 主程序入口
from utils import print_menu


def main():
    while True:
        # 打印菜单
        print_menu()

        # 获取用户选择
        choice = input("请输入您的选择 (0-5): ").strip()

