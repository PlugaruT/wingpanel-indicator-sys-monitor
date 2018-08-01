public class SysMonitor.Indicator : Wingpanel.Indicator {
    const string APPNAME = "wingpanel-indicator-sys-monitor";
    private SysMonitor.Services.CPU cpu;
    private SysMonitor.Services.Memory memory;
    private SysMonitor.Services.System system;
    private SysMonitor.Services.Net net;

    private SysMonitor.Widgets.DisplayWidget display_widget;
    private SysMonitor.Widgets.PopoverWidget popover_widget;


    public Indicator (Wingpanel.IndicatorManager.ServerType server_type) {
        Object (
            code_name: APPNAME,
            display_name: _ ("Sys-Monitor"),
            description: _ ("System monitor indicator that display CPU and RAM usage in wingpanel")
            );

        cpu = new SysMonitor.Services.CPU ();
        memory = new SysMonitor.Services.Memory ();
        system = new SysMonitor.Services.System ();
        net = new SysMonitor.Services.Net ();

        visible = true;

            update ();
    }

    public override Gtk.Widget get_display_widget () {
        if (display_widget == null) {
            display_widget = new SysMonitor.Widgets.DisplayWidget ();
            update ();
        }
        return display_widget;
    }

    public override Gtk.Widget ? get_widget () {
        if (popover_widget == null) {
            popover_widget = new SysMonitor.Widgets.PopoverWidget (this);
        }

        return popover_widget;
    }

    public override void opened () {
        popover_widget.set_main_view ();
    }

    public override void closed () {
    }

    public void hide () {
        visible = false;
    }

    private void update () {
        if (display_widget != null) {
            Timeout.add_seconds (1, () => {
                                     display_widget.set_cpu (cpu.percentage_used);
                                     display_widget.set_ram (memory.percentage_used);
                                     var bytes = net.get_bytes();
                                     display_widget.set_network (bytes[0], bytes[1]);
                                     update_popover_widget_data ();
                                     return true;
                                 });
        }
    }

    private void update_popover_widget_data () {
        popover_widget.update_ram_info (memory.used, memory.total);
        popover_widget.update_swap_info (memory.used_swap, memory.total_swap);
        popover_widget.update_freq_info (cpu.frequency);
        popover_widget.update_uptime_info (system.uptime);
        var bytes = net.get_bytes();
        popover_widget.update_net_speed (bytes[0], bytes[1]);
    }
}

public Wingpanel.Indicator ? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
        debug ("Loading system monitor indicator");

    if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
        debug ("Wingpanel is not in session, not loading sys-monitor");
        return null;
    }

    var indicator = new SysMonitor.Indicator (server_type);

    return indicator;
}
