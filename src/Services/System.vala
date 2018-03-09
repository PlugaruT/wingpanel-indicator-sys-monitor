public class SysMonitor.Services.System  : GLib.Object {
    private string _uptime;
    private float _network_up;
    private float _network_down;


    public string uptime {
        get { update_uptime (); return _uptime; }
    }

    public float network_up {
        get { update_network (); return _network_up; }
    }

    public float network_down {
        get { update_network (); return _network_down; }
    }

    public System() {}

    construct {}

    private void update_uptime () {
        GTop.Uptime uptime;
        GTop.get_uptime(out uptime);

        _uptime = Granite.DateTime.seconds_to_time((int)uptime.uptime);
    }

    private void update_network () {
        GTop.NetLoad network;
        //GTop.get_netload(out network);

        //_network_down = (float) network.bytes_in;
        //_network_up = (float) network.bytes_out;
    }
}
