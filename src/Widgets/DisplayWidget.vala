public class SysMonitor.Widgets.DisplayWidget : Gtk.Grid {
    private SysMonitor.Services.SettingsManager settings;
    private Gtk.Label cpu_label;
    private Gtk.Label ram_label;
    private Gtk.Image icon;

    private Gtk.Revealer cpu_revealer;
    private Gtk.Revealer ram_revealer;
    private Gtk.Revealer icon_revealer;

    construct {
        column_spacing = 4;
        margin_top = 4;

        settings = SysMonitor.Services.SettingsManager.get_default();
        icon = new Gtk.Image.from_icon_name ("computer-symbolic", Gtk.IconSize.MENU);
        cpu_label = new Gtk.Label("CPU");
        ram_label = new Gtk.Label("MEM");

        cpu_revealer = new Gtk.Revealer ();
        cpu_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_RIGHT;
        update_cpu_revelear();
        cpu_revealer.add (cpu_label);

        ram_revealer = new Gtk.Revealer ();
        ram_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_RIGHT;
        update_ram_revealer();
        ram_revealer.add (ram_label);

        icon_revealer = new Gtk.Revealer ();
        icon_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_LEFT;
        update_icon_revealer();
        icon_revealer.add (icon);


        settings.changed.connect (() => {
            update_icon_revealer();
            update_cpu_revelear();
            update_ram_revealer();
        });

        add (icon_revealer);
        add (cpu_revealer);
        add (ram_revealer);

    }

    public void set_cpu (int cpu_usage) {
        cpu_label.set_label(this.format_int(cpu_usage));
    }

    public void set_ram (int ram_usage) {
        ram_label.set_label(this.format_int(ram_usage));
    }

    private void update_cpu_revelear () {
        cpu_revealer.reveal_child = settings.show_cpu;
    }

    private void update_ram_revealer () {
        ram_revealer.reveal_child = settings.show_ram;
    }

    private void update_icon_revealer () {
        icon_revealer.reveal_child = settings.show_icon;
    }

    private string format_int (int number) {
        if (number < 10) {
            return "0%i%%".printf(number);
        } else {
            return "%i%%".printf(number);
        }
    }
}

