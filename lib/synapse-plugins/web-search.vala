/*
* Copyright (c) 2017 David Hewitt <davidmhewitt@gmail.com>
*               2017 elementary LLC.
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: David Hewitt <davidmhewitt@gmail.com>
*/

namespace Synapse {
    public class WebSearchPlugin: Object, Activatable, ItemProvider {

        public bool enabled { get; set; default = true; }

        public void activate () { }

        public void deactivate () { }

        public class Result : Object, Match {
            // from Match interface
            public string title { get; construct set; }
            public string description { get; set; }
            public string icon_name { get; construct set; }
            public bool has_thumbnail { get; construct set; }
            public string thumbnail_path { get; construct set; }
            public MatchType match_type { get; construct set; }
			public string query_template { get; construct set; }

            public int default_relevancy { get; set; default = 0; }

            private AppInfo? appinfo;
            private string search_term;

            public Result (string search) {
                search_term = search;
                string _icon_name = "applications-internet";

                appinfo = AppInfo.get_default_for_type ("x-scheme-handler/http", false);
                if (appinfo != null) {
                    _title = _("Search %s with %s").printf (search_term, "Ecosia");
                    _icon_name = appinfo.get_icon ().to_string ();
                }

                this.title = _title;
                this.icon_name = _icon_name;
                this.description = _("Open this query in default browser");
                this.has_thumbnail = false;
                this.match_type = MatchType.ACTION;
            }

            public void execute (Match? match) {
                if (appinfo == null) {
                    return;
                }

                var list = new List<string> ();
                list.append ("https://www.ecosia.org/search?q="+search_term);
                try {
                    appinfo.launch_uris (list, null);
                } catch (Error e) {
                    warning ("%s\n", e.message);
                }
            }        
        }

        static void register_plugin () {
            DataSink.PluginRegistry.get_default ().register_plugin (typeof (WebSearchPlugin),
                                            _("WebSearch"),
                                            _("Search the web for result"),
                                            "applications-internet",
                                            register_plugin);
        }

        static construct {
            register_plugin ();
        }

        public bool handles_query (Query query) {
            return QueryFlags.TEXT in query.query_type;
        }

        public async ResultSet? search (Query query) throws SearchError {
			Result result = new Result (query.query_string);
            ResultSet results = new ResultSet ();
            results.add (result, Match.Score.AVERAGE);
            query.check_cancellable ();

			return results;
        }
    }
}
