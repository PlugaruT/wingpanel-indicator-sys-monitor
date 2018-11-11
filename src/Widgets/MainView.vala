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

public class SysMonitor.Widgets.MainView : Gtk.Grid {
    private Gtk.Label ram_value_label;
    private Gtk.Label swap_value_label;
    private Gtk.Label freq_value_label;
    private Gtk.Label uptime_value_label;
    private Gtk.Label network_value_label;

    public MainView () {
        name = "main";
        orientation = Gtk.Orientation.HORIZONTAL;
        hexpand = true;
        column_spacing = 40; // to add space between label and value label
        row_spacing = 2;
    }

    construct {
        ram_value_label = create_value_label ();
        swap_value_label = create_value_label ();
        freq_value_label = create_value_label ();
        uptime_value_label = create_value_label ();
        
        network_value_label = create_value_label ();
        network_value_label.set_width_chars (10);
        network_value_label.set_justify (Gtk.Justification.FILL);

        var ram_label = create_name_label (_ ("Ram:"));
        var swap_label = create_name_label (_ ("Swap:"));
        var freq_label = create_name_label (_ ("Frequency:"));
        var uptime_label = create_name_label (_ ("Uptime:"));
        var network_label = create_name_label (_ ("Network:"));


        halign = Gtk.Align.CENTER;
        valign = Gtk.Align.CENTER;

        attach (freq_label,         1, 0, 1, 1);
        attach (freq_value_label,   2, 0, 1, 1);
        attach (ram_label,          1, 1, 1, 1);
        attach (ram_value_label,    2, 1, 1, 1);
        attach (swap_label,         1, 2, 1, 1);
        attach (swap_value_label,   2, 2, 1, 1);
        attach (uptime_label,       1, 3, 1, 1);
        attach (uptime_value_label, 2, 3, 1, 1);
        attach (network_label,       1, 4, 1, 1);
        attach (network_value_label, 2, 4, 1, 1);
    }

    private Gtk.Label create_name_label (string label_name) {
        var label = new Gtk.Label (label_name);
        label.halign = Gtk.Align.START;
        label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
        label.margin_start = 9;
        return label;
    }

    private Gtk.Label create_value_label (string label_name="") {
        var label = new Gtk.Label (label_name);
        label.halign = Gtk.Align.END;
        label.get_style_context ().add_class ("menuitem");
        label.margin_end = 9;
        return label;
    }

    public void update_ram (double used_ram, double total_ram) {
        ram_value_label.set_label ("%s / %s".printf (SysMonitor.Services.Utils.format_size (used_ram), SysMonitor.Services.Utils.format_size (total_ram)));
    }

    public void update_swap (double used_swap, double total_swap) {
        swap_value_label.set_label ("%s / %s".printf (SysMonitor.Services.Utils.format_size (used_swap), SysMonitor.Services.Utils.format_size (total_swap)));
    }
	
    public void update_freq (double frequency) {
        freq_value_label.set_label (SysMonitor.Services.Utils.format_frequency (frequency));
    }

    public void update_uptime (string uptime) {
        uptime_value_label.set_label (uptime);
    }

    public void update_net_speed (int bytes_out, int bytes_in) {
        var download = SysMonitor.Services.Utils.format_net_speed (bytes_in, false);
        var upload = SysMonitor.Services.Utils.format_net_speed(bytes_out, false);
        network_value_label.set_label ("D: " + download + " \nU: " + upload);
    }
}

