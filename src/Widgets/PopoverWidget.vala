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

public class SysMonitor.Widgets.PopoverWidget : Gtk.Grid {
    private SysMonitor.Indicator indicator;
    private SysMonitor.Widgets.MainView main_view;
    private SysMonitor.Widgets.SettingsView settings_view;
    private Gtk.Stack stack;

    public PopoverWidget (SysMonitor.Indicator _indicator) {
        Object (orientation: Gtk.Orientation.VERTICAL);
        indicator = _indicator;
    }

    construct {
        main_view = new SysMonitor.Widgets.MainView ();
        main_view.hexpand = true;
        settings_view = new SysMonitor.Widgets.SettingsView ();

        stack = new Gtk.Stack ();
        stack.hexpand = true;
        stack.add_titled (main_view,     main_view.name,     _ ("Main"));
        stack.add_titled (settings_view, settings_view.name, _ ("Settings"));

        var stack_switcher = new Gtk.StackSwitcher ();
        stack_switcher.margin = 3;
        stack_switcher.halign = Gtk.Align.FILL;
        stack_switcher.margin_start = 15;
        stack_switcher.margin_end = 15;
        stack_switcher.homogeneous = true;
        stack_switcher.stack = stack;

        var quit_button = new Gtk.ModelButton ();
        quit_button.text = _ ("Quit");
        quit_button.get_style_context ().add_class ("menuitem");
        quit_button.get_style_context ().remove_class ("button");
        quit_button.clicked.connect (() => {
            indicator.hide ();
        });

        var separator_start = new Wingpanel.Widgets.Separator ();
        separator_start.hexpand = true;

        var separator_end = new Wingpanel.Widgets.Separator ();
        separator_end.hexpand = true;

        attach (stack_switcher,  0, 0, 1, 1);
        attach (separator_start, 0, 1, 1, 1);
        attach (stack,           0, 2, 1, 1);
        attach (separator_end,   0, 3, 1, 1);
        attach (quit_button,     0, 4, 1, 1);
    }

    public void set_main_view () {
        stack.visible_child_name = main_view.name;
    }

    public void update_ram_info (double used_ram, double total_ram) {
        main_view.update_ram (used_ram, total_ram);
    }

    public void update_swap_info (double used_swap, double total_swap) {
        main_view.update_swap (used_swap, total_swap);
    }

    public void update_freq_info (double frequency) {
        main_view.update_freq (frequency);
    }

    public void update_uptime_info (string uptime) {
        main_view.update_uptime (uptime);
    }

    public void update_net_speed (int bytes_in, int bytes_out) {
        main_view.update_net_speed (bytes_in, bytes_out);
    }
}
