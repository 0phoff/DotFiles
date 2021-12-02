def import_modules():
    # Imports
    import os
    from pathlib import Path

    try:
        import top
    except ImportError:
        print('\033[01m\033[34mPythonStartup\033[00m Could not find topcraft install.')

    loc = locals()
    recurse_import = {'top'}
    glob = globals()

    # Expose imports as globals
    for name, value in loc.items():
        if name in recurse_import:
            for subname in dir(value):
                if not subname.startswith('_'):
                    if subname not in glob:
                        glob[subname] = getattr(top, subname)
                    else:
                        print(f'\033[01m\033[34mPythonStartup\033[00m Not overwriting global "{subname}" with value from "{name}".')
        elif name not in glob:
            glob[name] = value
        else:
            print(f'\033[01m\033[34mPythonStartup\033[00m Not overwriting global "{name}".')


import_modules()
