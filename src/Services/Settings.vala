public class SysMonitor.Services.SettingsManager : Granite.Services.Settings {
    private static SettingsManager ? instance = null;

    public bool show_cpu { set; get; }
    public bool show_ram { set; get; }
    public bool show_network { set; get; }
    public bool show_icon { set; get; }

    public SettingsManager () {
        base ("com.github.plugarut.wingpanel-indicator-sys-monitor");
    }

    public static SettingsManager get_default () {
        if (instance == null) {
            instance = new SettingsManager ();
        }
        return instance;
    }
}
