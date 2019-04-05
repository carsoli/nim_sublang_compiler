import os
import argparse
from utils import read_file, write_to_file, tokenize_file

def main():
    grammar_path = args.grammar
    tokens = tokenize_file(grammar_path)
    
    res_filename = sys.modules[__name__].__file__.rpartition(".")[0] + "_result.txt" 
    write_to_file(res_filename, "\n".join(tokens) )



if __name__ == '__main__':
    parser = argparse.ArgumentParser(add_help=True, description='command-line args parser')

    parser.add_argument('--grammar', action="store", help="path to file that contains rule definitons", nargs="?", 
    metavar="grammar_file")
    
    args = parser.parse_args()

main()