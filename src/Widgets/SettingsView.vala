public class SysMonitor.Widgets.SettingsView : Gtk.Grid {
    private Wingpanel.Widgets.Switch show_cpu_switch;
    private Wingpanel.Widgets.Switch show_ram_switch;
    private Wingpanel.Widgets.Switch show_icon_switch;
    private SysMonitor.Services.SettingsManager settings;

    public SettingsView () {
        name = "settings";
        orientation = Gtk.Orientation.HORIZONTAL;
        hexpand = true;
    }

    construct {
        settings = SysMonitor.Services.SettingsManager.get_default ();
        show_cpu_switch = new Wingpanel.Widgets.Switch (_ ("Display CPU usage"), settings.show_cpu);
        show_ram_switch = new Wingpanel.Widgets.Switch (_ ("Display RAM usage"), settings.show_ram);
        show_icon_switch = new Wingpanel.Widgets.Switch (_ ("Display icon"), settings.show_icon);

        show_cpu_switch.switched.connect (
            () => {
                settings.show_cpu = show_cpu_switch.get_active ();
            });

        show_ram_switch.switched.connect (
            () => {
                settings.show_ram = show_ram_switch.get_active ();
            });

        show_icon_switch.switched.connect (
            () => {
                settings.show_icon = show_icon_switch.get_active ();
            });

        attach (show_cpu_switch,  0, 1, 1, 1);
        attach (show_ram_switch,  0, 2, 1, 1);
        attach (show_icon_switch, 0, 3, 1, 1);
    }
}

