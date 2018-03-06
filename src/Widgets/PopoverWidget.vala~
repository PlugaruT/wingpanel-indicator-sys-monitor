public class SysMonitor.Widgets.PopoverWidget : Gtk.Grid {
  SysMonitor.Services.CPU cpu;
  float used_memory;
  float total_memory;
  SysMonitor.Indicator indicator;

  public PopoverWidget (SysMonitor.Indicator _indicator, SysMonitor.Services.CPU _cpu, float _total_memory, float _used_memory) {
    set_orientation (Gtk.Orientation.VERTICAL);
    margin_top = 6;

    indicator = _indicator;
    cpu = _cpu;
    total_memory = _total_memory;
    used_memory = _used_memory;

    var title = new Gtk.Label("System Monitor");
    title.get_style_context ().add_class ("h3");

    add (title);
    add (new Wingpanel.Widgets.Separator ());
    add (build_states_box());
  }

  Gtk.ListBox build_states_box () {
    var list_box = new Gtk.ListBox ();
    list_box.selection_mode = Gtk.SelectionMode.NONE;

    var memory_label = new Gtk.Label ("");
    memory_label.label = "Mem: " + this.used_memory.to_string() + "GB / " + this.total_memory.to_string() + "GB";

    list_box.add (memory_label);
    return list_box;
  }
}
