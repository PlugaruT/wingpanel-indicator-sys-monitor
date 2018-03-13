project ('com.github.plugarut.wingpanel-indicator-sys-monitor', ['vala', 'c'],
  version: '1.3.1',
  meson_version: '>=0.34'
)

add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')

install_data(
  'schemas/com.github.plugarut.wingpanel-indicator-sys-monitor.gschema.xml',
  install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas')
)

subdir ('src')
subdir ('po')

shared_module(
  meson.project_name (),
  sources,
  link_args : ['-lm', '-nostartfiles'],
  name_prefix: '',
  dependencies : [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gtk+-3.0'),
    dependency('granite'),
    dependency('wingpanel-2.0'),
    dependency('libgtop-2.0')
  ],
  vala_args: [
            '--vapidir=' + meson.source_root() + '/vapi/',
          ],
  install: true,
  install_dir : '/usr/lib/x86_64-linux-gnu/wingpanel/'
)

meson.add_install_script('meson/post_install.py')
