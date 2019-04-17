import sys, os
import argparse
from utils import write_to_file, tokenize_file, recognize_file

def main():
    testfile_path = args.file
    tokens = tokenize_file(testfile_path)
    #recognized = recognize_file(testfile_path)

    res_filename = sys.modules[__name__].__file__.rpartition(".")[0] + "_result.txt" 
    write_to_file(res_filename, "\n".join(tokens) )


if __name__ == '__main__':
    parser = argparse.ArgumentParser(add_help=True, description='command-line args parser')

    parser.add_argument('--file', action="store", help="path to file that contains input test grammar", nargs="?", 
    metavar="file")
    
    args = parser.parse_args()

main()