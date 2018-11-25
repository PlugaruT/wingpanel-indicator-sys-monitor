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

public class SysMonitor.Widgets.MainViewRow : Gtk.Grid {
    private Gtk.Label text_label;
    private Gtk.Label value_label;

    public MainViewRow (string text, string val="") {
        //  hexpand = true;
        //  halign = Gtk.Align.FILL;
        //  valign = Gtk.Align.CENTER;


        text_label = new Gtk.Label (text);
        text_label.halign = Gtk.Align.START;
        text_label.margin_start = 9;
        text_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);

        value_label = new Gtk.Label (val);
        value_label.halign = Gtk.Align.END;
        value_label.margin_end = 9;

        attach (text_label,  1, 0, 1, 1);
        attach (value_label, 2, 0, 1, 1);
    }

    public void update_value (string new_value) {
        value_label.set_label (new_value);
    }

    public void set_value_label_char_width (int width) {
        value_label.set_width_chars (width);
        value_label.set_justify (Gtk.Justification.FILL);
    }
}

