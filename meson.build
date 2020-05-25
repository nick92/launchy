project(
  'launchy',['vala', 'c']
)

i18n = import('i18n')
gnome = import('gnome')

add_project_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: 'c'
)

vala_version_required = '0.26.0'
vala = meson.get_compiler('vala')
if not vala.version().version_compare('>= @0@'.format(vala_version_required))
	error('Valac >= @0@ required!'.format(vala_version_required))
endif

asresources = gnome.compile_resources(
    'as-resources', 'data/icons.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

glib_dep = dependency('glib-2.0')
gee_dep = dependency('gee-0.8')
gio_dep = dependency('gio-2.0')
gtk_dep = dependency('gtk+-3.0')
gobject_dep = dependency('gobject-2.0')
libsoup_dep = dependency('libsoup-2.4')
gio_unix_dep = dependency('gio-unix-2.0')
json_glib_dep = dependency('json-glib-1.0')
libgnome_menu_dep = dependency('libgnome-menu-3.0')
posix_dep = vala.find_library('posix')

unity_dep = []
plank_dep = []

#if get_option('with-unity')
 #   unity_dep = dependency('unity', version: '>=4.0.0')
  #  add_project_arguments('--define=HAVE_UNITY', language: 'vala')

    plank_dep = dependency('plank')
    if plank_dep.version().version_compare('>=0.10.9')
        add_project_arguments('--define=HAS_PLANK_0_11', language: 'vala')
    endif
    if plank_dep.version().version_compare('>=0.9.0')
        add_project_arguments('--define=HAS_PLANK', language: 'vala')
    endif
#endif

subdir('data')
subdir('lib')
subdir('src')

meson.add_install_script('meson/post_install.py')