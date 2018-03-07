public class SysMonitor.Services.System  : GLib.Object {
    private double _uptime;


    public double uptime {
        get { update_uptime (); return _uptime; }
    }

    public System() {}

    construct {}

    private void update_uptime () {
        GTop.Uptime uptime;
        GTop.get_uptime(out uptime);

        _uptime = uptime.uptime / 3600;
    }
}
