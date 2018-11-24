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

public class SysMonitor.Widgets.SysGraph : Gtk.DrawingArea {
    protected double[] value_color = {1.0, 1.0, 1.0};

    protected int _current_percent;
    public int current_percent {
        set {_current_percent=value; redraw_canvas ();}
        get {return _current_percent;}
    }

    public SysGraph (int target_width, int target_height) {
        set_size_request (target_width, target_height);
        current_percent = 0;
        Services.BackgroundManager.get_default ().background_state_changed.connect (update_background);
    }

    public override bool draw (Cairo.Context cr) {
        int width = get_allocated_width ();
        int height = get_allocated_height ();

        // Percentage
        var percent_height = (int)(((double)current_percent / 100.0) * height);
        var px = 0;
        var py = height - percent_height;
        cr.set_source_rgb (value_color[0], value_color[1], value_color[2]);
        cr.rectangle (px, py, width, percent_height);
        cr.fill ();

        return false;
    }

    protected void redraw_canvas () {
        var window = get_window ();
        if (null == window) {
            return;
        }
        var region = window.get_clip_region ();
        // redraw the cairo canvas completely by exposing it
        window.invalidate_region (region, true);
    }

    private void update_background (Services.BackgroundState state, uint animation_duration) {
        // Update color of percentage bar and stroke
        switch (state) {
        case Services.BackgroundState.DARK :
        case Services.BackgroundState.TRANSLUCENT_DARK : {
            // Light Wingpanel background
            value_color = {1.0, 1.0, 1.0};
            break;
        }
        case Services.BackgroundState.MAXIMIZED :
        case Services.BackgroundState.LIGHT :
        case Services.BackgroundState.TRANSLUCENT_LIGHT : {
            // Dark Wingpanel background
            value_color = {0.0, 0.0, 0.0};
            break;
        }
        }
        redraw_canvas ();
    }
}

public class SysMonitor.Widgets.SysLineGraph : SysMonitor.Widgets.SysGraph {
    protected Queue<int> _queue = new Queue<int> ();

    public int current_percent {
        set {
            int width = get_allocated_width ();
            while (_queue.length >= width) {
                _queue.pop_tail ();
            }
            _queue.push_head (value);
            redraw_canvas ();
        }
        get {return _queue.peek_head ();}
    }

    public SysLineGraph (int target_width, int target_height) {
        base (target_width, target_height);
    }

    public override bool draw (Cairo.Context cr) {
        int width = get_allocated_width ();
        int height = get_allocated_height ();

        int xb = width;
        int yb = height;

        int last_x = xb;
        cr.set_source_rgb (value_color[0], value_color[1], value_color[2]);
        cr.move_to (xb, yb);
        if (_queue.length > 0) {
            for (int i=0; i<_queue.length; i++) {
                var percent_height = (int)(((double)_queue.peek_nth (i) / 100.0) * height);
                var px = last_x - 1;
                var py = height - percent_height;
                cr.line_to (px, py);
                last_x = px;
            }
        }
        cr.line_to (last_x, height);
        cr.fill ();

        return false;
    }
}

