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

public class SysMonitor.Widgets.DisplayWidget : Gtk.Grid {
    private SysMonitor.Services.SettingsManager settings;
    private Gtk.Label cpu_label;
    private Gtk.Label ram_label;
    private Gtk.Label network_down_label;
    private Gtk.Label network_up_label;
    private Gtk.Image icon;
    private Gtk.Image icon_down;
    private Gtk.Image icon_up;

    private Gtk.Revealer cpu_revealer;
    private Gtk.Revealer ram_revealer;
    private Gtk.Revealer network_revealer;
    private Gtk.Revealer icon_revealer;

    construct {
        column_spacing = 4;
        margin_top = 4;

        settings = SysMonitor.Services.SettingsManager.get_default ();
        icon = new Gtk.Image.from_icon_name ("utilities-system-monitor-symbolic", Gtk.IconSize.MENU);
        cpu_label = new Gtk.Label ("CPU");
        ram_label = new Gtk.Label ("MEM");
        network_down_label = new Gtk.Label ("DOWN");
        network_down_label.set_width_chars (8);
        network_up_label = new Gtk.Label ("UP");
        network_up_label.set_width_chars (8);
        icon_down = new Gtk.Image.from_icon_name ("go-down-symbolic", Gtk.IconSize.MENU);
        icon_up = new Gtk.Image.from_icon_name ("go-up-symbolic", Gtk.IconSize.MENU);

        cpu_revealer = new Gtk.Revealer ();
        cpu_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_RIGHT;
        update_cpu_revelear ();
        cpu_revealer.add (cpu_label);

        ram_revealer = new Gtk.Revealer ();
        ram_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_RIGHT;
        update_ram_revealer ();
        ram_revealer.add (ram_label);

        network_revealer = new Gtk.Revealer ();
        network_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_RIGHT;
        
        var grid_network = new Gtk.Grid ();
        update_network_revealer ();
        grid_network.attach (icon_down, 0, 0, 1, 1);
        grid_network.attach_next_to (network_down_label, icon_down, Gtk.PositionType.RIGHT, 1, 1);
        grid_network.attach_next_to (icon_up, network_down_label, Gtk.PositionType.RIGHT, 1, 1);
        grid_network.attach_next_to (network_up_label, icon_up, Gtk.PositionType.RIGHT, 1, 1);
        network_revealer.add (grid_network);

        icon_revealer = new Gtk.Revealer ();
        icon_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_LEFT;
                                      update_icon_revealer ();
        icon_revealer.add (icon);


        settings.changed.connect (() => {
                                      update_icon_revealer ();
                                      update_cpu_revelear ();
                                      update_ram_revealer ();
                                      update_network_revealer ();
                                  });
                                  
        add (icon_revealer);
        add (network_revealer);
        add (cpu_revealer);
        add (ram_revealer);
    }

    public void set_cpu (int cpu_usage) {
        cpu_label.set_label (this.format_percent (cpu_usage));
    }

    public void set_ram (int ram_usage) {
        ram_label.set_label (this.format_percent (ram_usage));
    }

    public void set_network (int bytes_out, int bytes_in) {
        network_up_label.set_label (SysMonitor.Services.Utils.format_net_speed (bytes_out, true));
        network_down_label.set_label (SysMonitor.Services.Utils.format_net_speed(bytes_in, true));
    }

    private void update_cpu_revelear () {
        cpu_revealer.reveal_child = settings.show_cpu;
    }

    private void update_ram_revealer () {
        ram_revealer.reveal_child = settings.show_ram;
    }

    private void update_network_revealer () {
        network_revealer.reveal_child = settings.show_network;
    }

    private void update_icon_revealer () {
        icon_revealer.reveal_child = settings.show_icon;
    }

    private string format_percent (int number) {
        return "%i%%".printf (number);
    }
}

