public class SysMonitor.Services.Memory  : GLib.Object {
    private int _percentage_used;
    private float _total;
    private float _used;

    private float _used_swap;
    private float _total_swap;

    public int percentage_used {
        get { update_percentage_used (); return _percentage_used; }
    }
    public float total {
        get { update_total (); return _total; }
    }
    public float used {
        get { update_used (); return _used; }
    }

    public float used_swap {
        get { update_used_swap (); return _used_swap; }
    }

    public float total_swap {
        get { update_total_swap (); return _total_swap; }
    }

    public Memory (){
        this._percentage_used = 0;
        this._used = 0;
        this._total = 0;
    }

    private void update_percentage_used (){
        _percentage_used = (int) Math.round((used / total) * 100);
    }

    private void update_total () {
        GTop.Memory memory;
        GTop.get_mem (out memory);
        _total = (((float) memory.total / 1024) /1024) / 1024;
    }

    private void update_used () {
        GTop.Memory memory;
        GTop.get_mem (out memory);
        _used = (((float) memory.user / 1024) /1024) / 1024;
    }

    private void update_used_swap () {
        GTop.Swap swap;
        GTop.get_swap(out swap);
        _used_swap = (((float) swap.used / 1024) /1024) / 1024;
    }

    private void update_total_swap () {
        GTop.Swap swap;
        GTop.get_swap(out swap);
        _total_swap = (((float) swap.total / 1024) /1024) / 1024;
    }
}
