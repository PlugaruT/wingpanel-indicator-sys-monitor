
public class SysMonitor.Indicator : Wingpanel.Indicator {
    const string APPNAME = "wingpanel-indicator-sys-monitor";

    public Indicator (Wingpanel.IndicatorManager.ServerType server_type) {
        Object (code_name: APPNAME,
                display_name: _("Sys-Monitor"),
                description: _("System monitor indicator that display CPU and RAM usage in wingpanel"));

      visible = true;
    }

    public override Gtk.Widget get_display_widget () {
      var spinner = new Gtk.Stack ();
      var indicator_icon = new Gtk.Image.from_icon_name ("video-display-symbolic", Gtk.IconSize.MENU);
      var tlabel = new Gtk.Label ("00:00");

      spinner.add_named (indicator_icon, "icon");
      spinner.add_named (tlabel, "label");

      return spinner;
    }

    public override Gtk.Widget? get_widget () {
      return null;
    }

    public override void opened () {}

    public override void closed () {}

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