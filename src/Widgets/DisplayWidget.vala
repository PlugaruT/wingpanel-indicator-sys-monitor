public class SysMonitor.Widgets.DisplayWidget : Gtk.Grid {
    private Gtk.Label cpu_label;
    private Gtk.Label mem_label;

    construct {
        column_spacing = 4;
        margin_top = 4;

        var icon = new Gtk.Image.from_icon_name ("computer-symbolic", Gtk.IconSize.MENU);
        cpu_label = new Gtk.Label("CPU");
        mem_label = new Gtk.Label("MEM");

        add (icon);
        add (cpu_label);
        add (mem_label);
    }

    public void set_cpu (int cpu_usage) {
        cpu_label.set_label(this.format_int(cpu_usage));
    }

    public void set_mem (int mem_usage) {
        mem_label.set_label(this.format_int(mem_usage));
    }

    public void hide_cpu () {
        remove (cpu_label);
    }

    public void show_cpu () {
        add (cpu_label);
    }

    public void hide_mem () {
        remove (mem_label);
    }

    public void show_mem () {
        add (cpu_label);
    }

    private string format_int (int number) {
        if (number < 10) {
            return "0%i%%".printf(number);
        } else {
            return "%i%%".printf(number);
        }
    }
}

