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

public class SysMonitor.Services.Memory  : GLib.Object {
    private int _percentage_used;
    private double _total;
    private double _used;

    private double _used_swap;
    private double _total_swap;

    public int percentage_used {
        get { update_percentage_used (); return _percentage_used; }
    }
    public double total {
        get { update_total (); return _total; }
    }
    public double used {
        get { update_used (); return _used; }
    }

    public double used_swap {
        get { update_used_swap (); return _used_swap; }
    }

    public double total_swap {
        get { update_total_swap (); return _total_swap; }
    }

    public Memory () {
        this._percentage_used = 0;
        this._used = 0;
        this._total = 0;
    }

    private void update_percentage_used () {
        _percentage_used = (int)Math.round ((used / total) * 100);
    }

    private void update_total () {
        GTop.Memory memory;
        GTop.get_mem (out memory);
        _total = (double)memory.total;
    }

    private void update_used () {
        GTop.Memory memory;
        GTop.get_mem (out memory);
        _used = (double)memory.user;
    }

    private void update_used_swap () {
        GTop.Swap swap;
        GTop.get_swap (out swap);
        _used_swap = (double)swap.used;
    }

    private void update_total_swap () {
        GTop.Swap swap;
        GTop.get_swap (out swap);
        _total_swap = (double)swap.total;
    }
}
