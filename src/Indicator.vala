
public class SysMonitor.Indicator : Wingpanel.Indicator {
  const string APPNAME = "wingpanel-indicator-sys-monitor";
  private Gtk.Label cpu_label;
  private Gtk.Label mem_label;
  private Gtk.Grid grid;
  private CPU cpu;
  private Memory memory;

  public Indicator (Wingpanel.IndicatorManager.ServerType server_type) {
      Object (code_name: APPNAME,
              display_name: _("Sys-Monitor"),
              description: _("System monitor indicator that display CPU and RAM usage in wingpanel"));

    this.cpu = new CPU();
    this.memory = new Memory();

    this.grid = new Gtk.Grid();
    this.grid.column_spacing = 3;

    this.cpu_label = new Gtk.Label("CPU");
    this.mem_label = new Gtk.Label("MEM");

    this.grid.add(this.cpu_label);
    this.grid.add(this.mem_label);

    visible = true;
    this.update();
  }

  public override Gtk.Widget get_display_widget () {
    var spinner = new Gtk.Stack ();
    spinner.add_named(this.grid, "grid");
    spinner.margin_top = 4;
    return spinner;
  }

  public override Gtk.Widget? get_widget () {
    return null;
  }

  public override void opened () {}

  public override void closed () {}

  private void update () {
    Timeout.add_seconds (1, () => {
        this.cpu_label.label = this.int_to_string(this.cpu.percentage_used) + "%";
        this.mem_label.label = this.int_to_string(this.memory.percentage_used) + "%";
        return true;
      });
  }

  private string int_to_string (int number) {
    if (number < 10){
      return "0" + number.to_string();
    } else {
      return number.to_string();
    }
  }
}

public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
  debug ("Loading system monitor indicator");

    if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
      debug ("Wingpanel is not in session, not loading sys-monitor");
      return null;
  }

  var indicator = new SysMonitor.Indicator (server_type);

  return indicator;
}
