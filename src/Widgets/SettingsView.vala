public class SysMonitor.Widgets.SettingsView : Gtk.Grid {
    private Wingpanel.Widgets.Switch show_cpu;
    private Wingpanel.Widgets.Switch show_mem;
    private Wingpanel.Widgets.Switch show_icon;

    public SettingsView () {
        name = "settings";
        orientation = Gtk.Orientation.HORIZONTAL;
        hexpand = true;
    }

    construct {
        show_cpu = new Wingpanel.Widgets.Switch(_("Show CPU usage"), true);
        show_mem = new Wingpanel.Widgets.Switch(_("Show RAM usage"), true);
        show_icon = new Wingpanel.Widgets.Switch(_("Show icon"), true);

        attach (show_cpu, 0, 1, 1, 1);
        attach (show_mem, 0, 2, 1, 1);
        attach (show_icon, 0, 3, 1, 1);
    }

    private void switch_cpu(){

    }

    private void hide_mem(){

    }
}

