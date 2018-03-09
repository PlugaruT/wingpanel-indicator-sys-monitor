public class SysMonitor.Widgets.PopoverWidget : Gtk.Grid {
    private SysMonitor.Indicator indicator;

    private Gtk.Label title_label;
    private Gtk.Label ram_value_label;
    private Gtk.Label swap_value_label;
    private Gtk.Label freq_value_label;
    private Gtk.Label uptime_value_label;
    private Gtk.Label network_value_label;

    public PopoverWidget (SysMonitor.Indicator _indicator) {
        Object (orientation: Gtk.Orientation.VERTICAL);
        indicator = _indicator;
    }

    construct {
        title_label = new Granite.HeaderLabel(_("System Monitor"));
        title_label.halign = Gtk.Align.CENTER;

        ram_value_label = create_value_label();
        swap_value_label = create_value_label();
        freq_value_label = create_value_label();
        uptime_value_label = create_value_label();
        network_value_label = create_value_label();

        var separator_start = new Wingpanel.Widgets.Separator ();
        separator_start.hexpand = true;

        var separator_end = new Wingpanel.Widgets.Separator ();
        separator_end.hexpand = true;

        var quit_button = new Gtk.ModelButton ();
        quit_button.text = _("Quit");
        quit_button.get_style_context().add_class("menuitem");
        //quit_button.hexpand = true;

        var ram_label = create_name_label(_("Ram:"));
        var swap_label = create_name_label(_("Swap:"));
        var freq_label = create_name_label(_("Frequency:"));
        var uptime_label = create_name_label(_("Uptime:"));
        var network_label = create_name_label(_("Network:"));

        attach (title_label, 1, 1, 2);
        attach (separator_start, 1, 2, 2);

        attach (freq_label, 1, 3, 1);
        attach (freq_value_label, 2, 3, 1);

        attach (ram_label, 1, 4, 1);
        attach (ram_value_label, 2, 4, 1);

        attach (swap_label, 1, 5, 1);
        attach (swap_value_label, 2, 5, 1);

        //attach (network_label, 1, 6, 1);
        //attach (network_value_label, 2, 6, 1);

        attach (uptime_label, 1, 6, 1);
        attach (uptime_value_label, 2, 6, 1);

        attach (separator_end, 1, 7, 2);

        attach (quit_button, 1, 8, 2);

        quit_button.clicked.connect (() => {
            indicator.hide();
        });
    }

    private Gtk.Label create_name_label (string label_name) {
        var label = new Gtk.Label(label_name);
        label.halign = Gtk.Align.START;
        label.get_style_context ().add_class ("menuitem");
        label.margin_start = 9;
        return label;
    }

    private Gtk.Label create_value_label (string label_name="") {
        var label = new Gtk.Label(label_name);
        label.halign = Gtk.Align.END;
        label.get_style_context ().add_class ("menuitem");
        label.margin_end = 9;
        return label;
    }

    public void update_ram_info (double used_ram, double total_ram) {
        ram_value_label.set_label("%s / %s".printf(SysMonitor.Services.Utils.format_size(used_ram), SysMonitor.Services.Utils.format_size(total_ram)));
    }

    public void update_swap_info (double used_swap, double total_swap) {
        swap_value_label.set_label("%s / %s".printf(SysMonitor.Services.Utils.format_size(used_swap), SysMonitor.Services.Utils.format_size(total_swap)));
    }

    public void update_freq_info (double frequency) {
        freq_value_label.set_label(SysMonitor.Services.Utils.format_frequency(frequency));
    }

    public void update_uptime_info (string uptime) {
        uptime_value_label.set_label(uptime);
    }

    public void update_network_info (float up, float down){
        network_value_label.set_label("Up: %.1f Down: %.1f".printf(up, down));
    }
}
