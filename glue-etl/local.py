import sys
import os

scripts_path = '/home/glue/scripts'
if scripts_path not in sys.path:
    sys.path.insert(0, scripts_path)

from script1 import main as main_script1

def dispatcher(script_name):
    if script_name == "script1":
        main_script1()
    else:
        print(f"Unknown script {script_name}")

def main():
    script_to_run = os.getenv('SCRIPT_NAME', 'script1')
    print(f"Running: {script_to_run}")
    dispatcher(script_to_run)

if __name__ == "__main__":
    main()