project('com.github.plugarut.wingpanel-indicator-sys-monitor', 'vala', 'c')

gettext_name = meson.project_name() + '-indicator'
gnome = import('gnome')
i18n = import('i18n')

add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(gettext_name), language:'c')

wingpanel_dep = dependency('wingpanel-2.0')

shared_module(
    meson.project_name(),
    'src/Indicator.vala',
    'src/Services/CPU.vala',
    'src/Services/Memory.vala',
    'src/Services/System.vala',
    'src/Services/Utils.vala',
    'src/Services/Settings.vala',
    'src/Widgets/PopoverWidget.vala',
    'src/Widgets/MainView.vala',
    'src/Widgets/SettingsView.vala',
    'src/Widgets/DisplayWidget.vala',
    link_args : ['-lm', '-nostartfiles'],
    name_prefix: '',
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('libgtop-2.0'),
        wingpanel_dep
    ],
    vala_args: [
            '--vapidir=' + meson.source_root() + '/vapi/',
          ],
    install: true,
    install_dir : wingpanel_dep.get_pkgconfig_variable('indicatorsdir')
)

install_data(
    'schemas/com.github.plugarut.wingpanel-indicator-sys-monitor.gschema.xml',
    install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas')
)

subdir('po')

meson.add_install_script('meson/post_install.py')
