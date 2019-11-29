vim-isort
=========

Vim plugin to sort python imports using `isort <https://github.com/timothycrosley/isort>`_



**NOTE**:

`darrikonn/vim-isort <https://github.com/darrikonn/vim-isort>`_ is a fork from `fisadev/vim-isort <https://github.com/fisadev/vim-isort>`_. The base logic is the same, with small additional changes/features.

----

How `darrikonn/vim-isort <https://github.com/darrikonn/vim-isort>`_ differs from  `fisadev/vim-isort <https://github.com/fisadev/vim-isort>`_:

    - *darrikonn/vim-isort* works with `vim-rooter <https://github.com/airblade/vim-rooter>`_.
    - *darrikonn/vim-isort* works with **monorepos** + with/without `vim-rooter <https://github.com/airblade/vim-rooter>`_.
    - *darrikonn/vim-isort* works with **nested isort configurations**.

Usage
=====

Just call the ``:Isort`` command, and it will reorder the imports of the current python file.
Or select a block of imports with visual mode, and press ``Ctrl-i`` to sort them.

You can also configure isort options, check them on the `isort docs <https://github.com/timothycrosley/isort>`_.


Installation
============

* Install `isort <https://github.com/timothycrosley/isort>`_:

.. code::

    pip3 install isort

* Add the plugin using your favourite package manager, e.g.:

.. code::

    Plug 'darrikonn/vim-isort'

.. code::

    Plugin 'darrikonn/vim-isort'

(Or if you don't use any plugin manager, you can just copy the ``python_vimisort.vim`` file to your ``.vim/ftplugin`` folder)

Setup
============

* First you need to allow vim to keep you in the root inside your repo, regardless of where you open your file

.. code-block:: viml

    " CWD to the root of git repo when opening file inside repo
    let g:gitroot=system("git rev-parse --show-toplevel")
    let g:is_gitrepo = v:shell_error == 0
    silent! cd `=gitroot`

Configuration
=============

You can configure the default mapping for the visual mode sorter, like this:

.. code-block:: viml

    let g:vim_isort_map = '<C-i>'

Or disable the mapping with this:

.. code-block:: viml

    let g:vim_isort_map = ''

Troubleshooting?
============
Your virtual environment might confuse the configuration path, which results in your repo based isort configuration not working (even though it's loaded).
The fix is to tell isort the name of your virtual environment directory in either `.isort.cfg` or `setup.cfg`:

.. code-block:: cfg

    virtual_env = venv
    not_skip = __init__.py
