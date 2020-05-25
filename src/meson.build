sources = [
    'Launchy.vala',
    'LaunchyView.vala',
    'Settings.vala',
    'Utils.vala',
    'Pixels.vala',

    'Backend/App.vala',
    'Backend/AppSystem.vala',
    'Backend/DBusService.vala',
    'Backend/Plank.vala',
    #'Backend/RelevancyService.vala',
    'Backend/SynapseSearch.vala',

    'Widgets/AppEntry.vala',
    'Widgets/Grid.vala',
    'Widgets/Switcher.vala',
    'Widgets/SearchView.vala',
    'Widgets/SearchItem.vala',
    'Widgets/Sidebar.vala',
    'Widgets/CategoryView.vala',
    #'Widgets/CompositedWindow.vala',
    #'Widgets/PageChecker.vala',
    'Widgets/StaredView.vala',
    #'Widgets/ActionsView.vala',
    asresources
]

dependencies = [
    glib_dep,
    gobject_dep,
    gio_dep,
    gio_unix_dep,
    gee_dep,
    gtk_dep,
    json_glib_dep,
    libgnome_menu_dep,
    libsoup_dep,
    plank_dep,
    unity_dep,
    synapse_core_dep,
    synapse_plugins_dep,
    posix_dep,
    meson.get_compiler('vala').find_library('config', dirs: join_paths(meson.source_root(), 'vapi'))
]

executable(
    meson.project_name(),
    sources,
    dependencies: dependencies,
    c_args : '-DGMENU_I_KNOW_THIS_IS_UNSTABLE',
    vala_args:['--target-glib=2.38', '--gresources=' + meson.source_root () + '/data/icons.gresource.xml'],
    install: true
)
