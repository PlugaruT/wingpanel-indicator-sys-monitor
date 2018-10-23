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
    private double[] bg_color = {0.0, 0.0, 0.0, 1.0};
    private double[] pecent_color = {1.0, 1.0, 1.0, 1.0};
    private double[] stroke_color = {0.2, 0.2, 0.2, 1.0};
    
    private int _current_percent;
    public int current_percent { 
        set {_current_percent=value; redraw_canvas();} 
        get {return _current_percent;} 
    }

    public SysGraph (int target_width, int target_height) {
        set_size_request (target_width, target_height);
        current_percent = 0;
    }
     
    public override bool draw (Cairo.Context cr) {
        int width = get_allocated_width ();
        int height = get_allocated_height ();
        
        // Background
        cr.set_source_rgba (bg_color[0],bg_color[1],bg_color[2],bg_color[3]);
        cr.rectangle (0, 0, width, height);
        cr.fill ();
        
        // Percentage
        var percent_height = (int) (((double)current_percent/100.0) * height);
        var px = 0;
        var py = height-percent_height;
        cr.set_source_rgba (pecent_color[0],pecent_color[1],pecent_color[2],pecent_color[3]);
        cr.rectangle (px, py, width, percent_height);
        cr.fill ();
        
        // Border
        cr.set_source_rgba (stroke_color[0],stroke_color[1],stroke_color[2],stroke_color[3]);
        cr.rectangle (0, 0, width, height);
        cr.stroke ();
        
        return false;
    }
    
    private void redraw_canvas () {
        var window = get_window ();
        if (null == window) {
            return;
        }
        var region = window.get_clip_region ();
        // redraw the cairo canvas completely by exposing it
        window.invalidate_region (region, true);
    }
}
