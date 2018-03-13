#!/usr/bin/env python3

import os
import subprocess

if not os.environ.get('DESTDIR'):
	print('Compiling gsettings schemas...')
	subprocess.call(['glib-compile-schemas', '/usr/share/glib-2.0/schemas'])
