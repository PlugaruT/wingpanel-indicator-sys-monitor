public class SysMonitor.Widgets.PopoverWidget : Gtk.Grid {
    private Gtk.Label title_label;
    private Gtk.Label memory_usage_label;

    public PopoverWidget () {
        Object (orientation: Gtk.Orientation.VERTICAL);
    }

    construct {
        title_label = new Gtk.Label(_("System Monitor"));
        title_label.get_style_context ().add_class ("h4");
        title_label.halign = Gtk.Align.CENTER;
        title_label.margin_start = 12;
        title_label.margin_end = 12;

        memory_usage_label = new Gtk.Label("");
        memory_usage_label.halign = Gtk.Align.END;
        memory_usage_label.margin_end = 6;

        var separator = new Wingpanel.Widgets.Separator ();
        separator.hexpand = true;

        var ram_label = new Gtk.Label(_("RAM:"));
        ram_label.halign = Gtk.Align.START;
        ram_label.margin_start = 6;

        attach (title_label, 1, 1, 2);
        attach (separator, 1, 2, 2);

        attach (ram_label, 1, 3, 1);
        attach (memory_usage_label, 2, 3, 1);
    }

    public void update_memory_info (float used_memory, float total_memory) {
        memory_usage_label.set_label("%.2f GB / %.2f GB".printf (used_memory, total_memory));
    }
}
