/*-
 * Copyright (c) 2018 Tudor Plugaru (https://github.com/PlugaruT/wingpanel-indicator-sys-monitor)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 *
 * Authored by: Tudor Plugaru <plugaru.tudor@gmail.com>
 */

public class SysMonitor.Services.Utils  : GLib.Object {
    public Utils () {
    }

    construct { }

    public static string format_temp (double val) {
        const string units = "{} C";

        // 4 significant digits
        var pattern = _ (units).replace ("{}",
                                         val <   9.95 ? "%.1f" :
                                         val <  99.5  ? "%.0f" :
                                         val < 999.5  ? "%.0f" : "%.0f");

        return pattern.printf (val);
    }

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

    public static string format_net_speed (int bytes, bool round, bool in_bits) {
        string[] sizes = { " B/s", "KB/s", "MB/s", "GB/s", "TB/s" };
        string[] sizes_in_bits = { " b/s", "Kb/s", "Mb/s", "Gb/s", "Tb/s" };
        double len = (double)bytes;
        int order = 0;
        string speed = "";
        while (len >= 1024 && order < sizes.length - 1) {
            order++;
            len = len/1024;
        }
        if (bytes < 0) {
            len = 0;
            order = 0;
        }
        string unit = sizes[order];
        if (in_bits == true){
            len = len*8;
            unit = sizes_in_bits[order];
        }
        if (round == true) {
            speed = "%3.0f %s".printf (len, unit);
        } else  {
            speed = "%3.2f %s".printf (len, unit);
        }

        return speed;
    }
}
