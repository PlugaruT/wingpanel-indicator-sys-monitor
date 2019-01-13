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

public class SysMonitor.Services.SettingsManager : Granite.Services.Settings {
    private static SettingsManager ? instance = null;

    public bool show_cpu { set; get; }
    public bool show_ram { set; get; }
    public bool show_network { set; get; }
    public bool show_desr { set; get; }
    public bool show_graph { set; get; }
    public bool show_icon { set; get; }
    public bool network_in_bits { set; get; }

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
