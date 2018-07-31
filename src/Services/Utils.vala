public class SysMonitor.Services.Utils  : GLib.Object {
    public Utils () {
    }

    construct { }

    public static string format_size (double val) {
        const string[] units = {
            N_ ("{} kB"),
            N_ ("{} MB"),
            N_ ("{} GB")
        };
        int index = -1;
        while (index + 1 < units.length && (val >= 1000 || index < 0)) {
            val /= 1000;
            ++index;
        }
        if (index < 0) {
            return ngettext ("%u B", "%u B", (ulong)val).printf ((uint)val);
        }

        // 4 significant digits
        var pattern = _ (units[index]).replace ("{}",
                                                val <   9.95 ? "%.1f" :
                                                val <  99.5  ? "%.0f" :
                                                val < 999.5  ? "%.0f" : "%.0f");
        return pattern.printf (val);
    }

    public static string format_frequency (double val) {
        const string[] units = {
            N_ ("{} kHz"),
            N_ ("{} MHz"),
            N_ ("{} GHz")
        };
        int index = -1;
        while (index + 1 < units.length && (val >= 1000 || index < 0)) {
            val /= 1000;
            ++index;
        }
        if (index < 0) {
            return ngettext ("%u Hz", "%u Hz", (ulong)val).printf ((uint)val);
        }

        // 4 significant digits
        var pattern = _ (units[index]).replace ("{}",
                                                val <   9.95 ? "%.1f" :
                                                val <  99.5  ? "%.0f" :
                                                val < 999.5  ? "%.0f" : "%.0f");
        return pattern.printf (val);
    }

    public static string format_net_speed (int bytes, bool round) {
        string[] sizes = { " B/s", "KB/s", "MB/s", "GB/s", "TB/s" };
        double len = (double) bytes;
        int order = 0;
        string speed = "";
        while (len >= 1024 && order < sizes.length - 1) {
            order++;
            len = len/1024;
        }
        if(round == true){
            speed = "%3.0f %s".printf(len, sizes[order]);
        }else{
            speed = "%3.2f %s".printf(len, sizes[order]);
        }

        return speed;
    }
}