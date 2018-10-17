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

public class SysMonitor.Services.System  : GLib.Object {
    private string _uptime;
    private float _network_up;
    private float _network_down;


    public string uptime {
        get { update_uptime (); return _uptime; }
    }

    public float network_up {
        get { update_network (); return _network_up; }
    }

    public float network_down {
        get { update_network (); return _network_down; }
    }

    public System () {
    }

    construct { }

    private void update_uptime () {
        GTop.Uptime uptime;
        GTop.get_uptime (out uptime);

        _uptime = Granite.DateTime.seconds_to_time ((int)uptime.uptime);
    }

    private void update_network () {
        // GTop.NetLoad network;
        //GTop.get_netload(out network);

        //_network_down = (float) network.bytes_in;
        //_network_up = (float) network.bytes_out;
    }
}
