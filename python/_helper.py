import chardet
from enum import Enum, auto
from dataclasses import dataclass
from pathlib import Path

import re
import copy

def rreplace(s : str, old, new, occurrence):
    li = s.rsplit(old, occurrence)
    return new.join(li)

def build_hook_path(pth):
    flag_record = False
    build = []
    split = pth.split('/')
    for s in split:
        if s == 'scripts': 
            flag_record = True
            continue
        if flag_record: build.append(s)
    build.pop()
    return '/'.join(build)


def get_file_encoding(file_path):
    """
    Detects the character encoding of a given file using chardet.

    Args:
        file_path (str): The path to the file.

    Returns:
        str: The detected character encoding, or None if detection fails.
    """
    try:
        with open(file_path, 'rb') as f:
            raw_data = f.read()
        result = chardet.detect(raw_data)
        return result['encoding']
    except FileNotFoundError:
        print(f"Error: File not found at {file_path}")
        return None
    except Exception as e:
        print(f"An error occurred: {e}")
        return None

    
