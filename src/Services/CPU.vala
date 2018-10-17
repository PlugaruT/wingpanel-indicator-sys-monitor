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

public class SysMonitor.Services.CPU  : GLib.Object {
    private float last_total;
    private float last_used;

    private int _percentage_used;
    private double _frequency;

    public int percentage_used {
        get { update_percentage_used (); return _percentage_used; }
    }

    public double frequency {
        get { update_frequency (); return _frequency; }
    }

    public CPU () {
        last_used = 0;
        last_total = 0;
    }

    construct {
    }

    private void update_percentage_used () {
        GTop.Cpu cpu;
        GTop.get_cpu (out cpu);

        var used = cpu.user + cpu.nice + cpu.sys;                               // get cpu used
        var difference_used = (float)used - last_used;                          // calculate the difference used
        var difference_total = (float)cpu.total - last_total;                   // calculate the difference total
        var pre_percentage = difference_used.abs () / difference_total.abs ();  // calculate the pre percentage

        _percentage_used = (int)Math.round (pre_percentage * 100);

        last_used = (float)used;
        last_total = (float)cpu.total;
    }

    private void update_frequency () {
        double maxcur = 0;
        for (uint i = 0, isize = (int)get_num_processors (); i < isize; ++i) {
            var cur = 1000.0 * read (i, "scaling_cur_freq");
            if (i == 0) {
                maxcur = cur;
            } else {
                maxcur = double.max (cur, maxcur);
            }
        }
        _frequency = (double)maxcur;
    }


    private static double read (uint cpu, string what) {
        string value;
        try {
            FileUtils.get_contents (@"/sys/devices/system/cpu/cpu$cpu/cpufreq/$what", out value);
        } catch (Error e) {
            value = "0";
        }
        return double.parse (value);
    }
}
