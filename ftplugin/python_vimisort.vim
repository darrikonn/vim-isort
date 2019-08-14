if has('python3')
    command! -nargs=1 AvailablePython python3 <args>
    let s:available_short_python = ':py3'
else
    throw 'No python3 support present, vim-isort will be disabled'
endif

command! Isort exec("AvailablePython isort_file()")

if !exists('g:vim_isort_map')
    let g:vim_isort_map = '<C-i>'
endif

if g:vim_isort_map != ''
    execute "vnoremap <buffer>" g:vim_isort_map s:available_short_python "isort_visual()<CR>"
endif

AvailablePython <<EOF
from __future__ import print_function

from functools import lru_cache
from subprocess import check_output, CalledProcessError
from sys import version_info

import vim
from pathlib import Path


try:
    from isort import SortImports
    isort_imported = True
except ImportError:
    isort_imported = False


def count_blank_lines_at_end(lines):
    blank_lines = 0
    for line in reversed(lines):
        if line.strip():
            break
        else:
            blank_lines += 1
    return blank_lines


@lru_cache(maxsize=1)
def get_isort_config(path):
    if str(path) == "/":
        return None
    elif Path(f"{path}/setup.cfg").exists() or Path(f"{path}/.isort.cfg").exists():
        return path
    return get_isort_config(path.parent)
  


def isort(text_range):
    if not isort_imported:
        print("No isort python module detected, you should install it. More info at https://github.com/darrikonn/vim-isort")
        return

    blank_lines_at_end = count_blank_lines_at_end(text_range)
    old_text = '\n'.join(text_range)
    settings_path=get_isort_config(Path(text_range.name))
    new_text = SortImports(file_contents=old_text, settings_path=settings_path).output
    new_lines = new_text.split('\n')

    # remove empty lines wrongfully added
    while new_lines and not new_lines[-1].strip() and blank_lines_at_end < count_blank_lines_at_end(new_lines):
        del new_lines[-1]

    text_range[:] = new_lines

def isort_file():
    isort(vim.current.buffer)

def isort_visual():
    isort(vim.current.range)

EOF
