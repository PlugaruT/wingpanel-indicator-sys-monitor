public class SysMonitor.Services.CPU  : GLib.Object {
    private float last_total;
    private float last_used;

    private int _percentage_used;

    public int percentage_used {
        get { update_percentage_used (); return _percentage_used; }
    }

    public CPU (){
        last_used = 0;
        last_total = 0;
    }

    construct {}

    private void update_percentage_used (){
      GTop.Cpu cpu;
      GTop.get_cpu (out cpu);

      var used = cpu.user + cpu.nice + cpu.sys;                               // get cpu used
      var difference_used = (float) used - last_used;                         // calculate the difference used
      var difference_total = (float) cpu.total - last_total;                  // calculate the difference total
      var pre_percentage = difference_used.abs () / difference_total.abs ();  // calculate the pre percentage

      _percentage_used = (int) Math.round(pre_percentage * 100);

      last_used = (float) used;
      last_total = (float) cpu.total;
    }

}
