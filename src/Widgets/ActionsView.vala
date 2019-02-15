// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
//
//  Copyright (C) 2011-2012 Giulio Collura
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

using Gtk;

namespace Launcher.Widgets {

    public class ActionsView : Gtk.ScrolledWindow {
		
		private LaunchyView view;
		public signal void start_search (Synapse.SearchMatch search_match, Synapse.Match? target);

        public bool in_context_view { get; private set; default = false; }

        private Gee.HashMap<Backend.App, SearchItem> items;
        private SearchItem selected_app = null;
        private Gtk.Box main_box;

        private Gtk.Box context_box;
        private Gtk.Fixed context_fixed;
        private int context_selected_y;
        
        private Backend.SynapseSearch synapse;
        
        private int _selected = 0;
		
		public ActionsView (LaunchyView parent) {
            view = parent;
            hscrollbar_policy = Gtk.PolicyType.NEVER;
            items = new Gee.HashMap<Backend.App, SearchItem> ();
            
            synapse = new Backend.SynapseSearch ();

            main_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            main_box.margin_start = 12;

            context_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            context_fixed = new Gtk.Fixed ();
            context_fixed.margin_start = 12;
            context_fixed.margin_end = 12;
            context_fixed.put (context_box, 0, 0);

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            box.pack_start (main_box, true);
            box.pack_start (context_fixed, false);

            add_with_viewport (box);

            parent.search_entry.key_press_event.connect ((e) => {
                if (parent.search_entry.text == "")
                    _selected = 0;

                return false;
            });
            
            show_actions ();
        }
        
        private async void show_actions () {
            //FIXME bit of a shody way of doing this
			//var results = synapse.search ("shutdown");
			List<string> actions = new List<string> ();
			actions.append("shutdown");
			actions.append("restart");
			actions.append("suspend");
			actions.append("hibernate");
			actions.append("logout");
			
            Gee.List<Synapse.Match> matches;

            synapse.get_system_actions();
						
			foreach(string action in actions){
				matches = yield synapse.search_actions (action);
				matches.foreach((match) => {
					var search_item = new SearchItem (new Backend.App.from_synapse_match (match));
					
					search_item.button_release_event.connect (() => {
						if (!search_item.dragging) {
							((Synapse.DesktopFilePlugin.ActionMatch) match).execute (null);
						}						
						return true;
					});
					
					main_box.pack_start (search_item);
					return true;
				});
			}
			
			main_box.show_all ();
        }	
	}
}
