public class SysMonitor.Widgets.PopoverWidget : Gtk.Grid {
    private Gtk.Label title_label;

    public PopoverWidget () {
        Object (orientation: Gtk.Orientation.VERTICAL);
    }

    construct {
        title_label = new Gtk.Label(_("System Monitor"));
        title_label.get_style_context ().add_class ("h4");
        title_label.halign = Gtk.Align.CENTER;
        title_label.margin_start = 12;
        title_label.margin_end = 12;

        var separator = new Wingpanel.Widgets.Separator ();
        separator.hexpand = true;

        attach (title_label, 1, 1);
        attach (separator, 1, 2);
    }
}
