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

public class SysMonitor.Widgets.SettingsView : Gtk.Grid {
    private Wingpanel.Widgets.Switch show_cpu_switch;
    private Wingpanel.Widgets.Switch show_ram_switch;
    private Wingpanel.Widgets.Switch show_network_switch;
    private Wingpanel.Widgets.Switch show_icon_switch;
    private SysMonitor.Services.SettingsManager settings;

    public SettingsView () {
        name = "settings";
        orientation = Gtk.Orientation.HORIZONTAL;
        hexpand = true;
    }

    construct {
        settings = SysMonitor.Services.SettingsManager.get_default ();
        show_cpu_switch = new Wingpanel.Widgets.Switch (_ ("Display CPU usage"), settings.show_cpu);
        show_ram_switch = new Wingpanel.Widgets.Switch (_ ("Display RAM usage"), settings.show_ram);
        show_network_switch = new Wingpanel.Widgets.Switch (_ ("Display Network usage"), settings.show_network);
        show_icon_switch = new Wingpanel.Widgets.Switch (_ ("Display icon"), settings.show_icon);

        settings.schema.bind("show-ram", show_ram_switch.get_switch(), "active", SettingsBindFlags.DEFAULT);
        settings.schema.bind("show-cpu", show_cpu_switch.get_switch(), "active", SettingsBindFlags.DEFAULT);
        settings.schema.bind("show-network", show_network_switch.get_switch(), "active", SettingsBindFlags.DEFAULT);
        settings.schema.bind("show-icon", show_icon_switch.get_switch(), "active", SettingsBindFlags.DEFAULT);

        attach (show_cpu_switch,  0, 1, 1, 1);
        attach (show_ram_switch,  0, 2, 1, 1);
        attach (show_network_switch, 0, 3, 1, 1);
        attach (show_icon_switch, 0, 4, 1, 1);
    }
}

