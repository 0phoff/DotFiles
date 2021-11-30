#####################
# Automatic imports #
#####################
import os
from pathlib import Path


##################
# Custom modules #
##################
def import_module(path):
    import importlib

    # Import module
    import_path = 'pythonstartup.' + path.replace('.', '_')
    spec = importlib.util.spec_from_file_location(import_path, Path(__file__).parent / path)
    cfg = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(cfg)

    # Expose variables as globals
    global_vars = globals()
    if hasattr(cfg, '__all__'):
        for name in cfg.__all__:
            if name in global_vars:
                print(f'PythonStartup: Not overwriting "{name}" with value from "{cfg.__file__}"')
            else:
                global_vars[name] = getattr(cfg, name)


import_module('log.py')
import_module('profile.py')
