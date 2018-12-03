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

public class SysMonitor.Widgets.MainView : Gtk.Box {
    private SysMonitor.Widgets.MainViewRow ram_row;
    private SysMonitor.Widgets.MainViewRow swap_row;
    private SysMonitor.Widgets.MainViewRow freq_row;
    private SysMonitor.Widgets.MainViewRow uptime_row;
    private SysMonitor.Widgets.MainViewRow network_up_row;
    private SysMonitor.Widgets.MainViewRow network_down_row;

    public MainView () {
        name = "main";
        valign = Gtk.Align.CENTER;
        orientation = Gtk.Orientation.VERTICAL;
    }

    construct {
        ram_row = new SysMonitor.Widgets.MainViewRow (_ ("Ram:"));
        swap_row = new SysMonitor.Widgets.MainViewRow (_ ("Swap:"));
        freq_row = new SysMonitor.Widgets.MainViewRow (_ ("Frequency:"));
        uptime_row = new SysMonitor.Widgets.MainViewRow (_ ("Uptime:"));

        network_up_row = new SysMonitor.Widgets.MainViewRow (_ ("Network Up"));
        network_up_row.set_value_label_char_width (10);

        network_down_row = new SysMonitor.Widgets.MainViewRow (_ ("Network Down"));
        network_down_row.set_value_label_char_width (10);

        add (        freq_row);
        add (         ram_row);
        add (        swap_row);
        add (      uptime_row);
        add (  network_up_row);
        add (network_down_row);
    }

    public void update_ram (double used_ram, double total_ram) {
        var used = SysMonitor.Services.Utils.format_size (used_ram);
        var total = SysMonitor.Services.Utils.format_size (total_ram);
        ram_row.update_value ("%s / %s".printf (used, total));
    }

    public void update_swap (double used_swap, double total_swap) {
        var used = SysMonitor.Services.Utils.format_size (used_swap);
        var total = SysMonitor.Services.Utils.format_size (total_swap);
        swap_row.update_value ("%s / %s".printf (used, total));
    }

    public void update_freq (double frequency) {
        var val = SysMonitor.Services.Utils.format_frequency (frequency);
        freq_row.update_value (val);
    }

    public void update_uptime (string uptime) {
        uptime_row.update_value (uptime);
    }

    public void update_net_speed (int bytes_out, int bytes_in) {
        var download = SysMonitor.Services.Utils.format_net_speed (bytes_in, false);
        var upload = SysMonitor.Services.Utils.format_net_speed (bytes_out, false);
        network_down_row.update_value (download);
        network_up_row.update_value (upload);
    }
}

