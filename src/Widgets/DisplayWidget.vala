public class SysMonitor.Widgets.DisplayWidget : Gtk.Grid {
    private Gtk.Label cpu_label;
    private Gtk.Label mem_label;

    construct {
        column_spacing = 4;
        margin_top = 4;

        cpu_label = new Gtk.Label("CPU");
        mem_label = new Gtk.Label("MEM");

        add (cpu_label);
        add (mem_label);
    }

    public void set_cpu (int cpu_usage) {
        cpu_label.set_label(this.format_int(cpu_usage) + "%");
    }

    public void set_mem (int mem_usage) {
        mem_label.set_label(this.format_int(mem_usage) + "%");
    }

    private string format_int (int number) {
        if (number < 10){
            return "0" + number.to_string();
        } else {
            return number.to_string();
        }
    }

}

