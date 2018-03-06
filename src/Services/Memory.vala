public class SysMonitor.Services.Memory  : GLib.Object {
    private int _percentage_used;
    private float _total;
    private float _used;

    public int percentage_used {
        get { update_percentage_used (); return _percentage_used; }
    }
    public float total {
        get { update_total (); return _total; }
    }
    public float used {
        get { update_used (); return _used; }
    }

    public Memory (){
        this._percentage_used = 0;
        this._used = 0;
        this._total = 0;
    }

    private void update_percentage_used (){
        _percentage_used = (int) Math.round((used / total) * 100);
    }

    private void update_total (){
        GTop.Memory memory;
        GTop.get_mem (out memory);
        _total = (((float) memory.total / 1024) /1024) / 1024;
    }

    private void update_used (){
        GTop.Memory memory;
        GTop.get_mem (out memory);
        _used = (((float) memory.user / 1024) /1024) / 1024;
    }
}
