%import urllib,json
      <h3>Searching for <span id="query-lbl">{{v.query}}</span></h3>
      <div class="row">
        <div class="col-xs-8">
          <p>Your search for <b>{{!v.query}}</b> returned these results:</p>
          <div id="searchcontrol">No results found.</div>
          <p><a id="search-again-btn" href="./" class="btn btn-default">Search Again</a></p>
%if v.useGoogle:
          <!-- Google Search API (just for fun) -->
          <style>
            .gsc-search-box, .gsc-resultsHeader { display: none; }
            .gsc-control { width: 100% !important; }
          </style>
          <script src="https://www.google.com/jsapi"
            type="text/javascript"></script>
          <script type="text/javascript">
            google.load("search", "1");
            function initialize() {
              var searchControl = new google.search.SearchControl();
              searchControl.addSearcher(new google.search.WebSearch());
              searchControl.draw(document.getElementById("searchcontrol"));
              searchControl.execute("{{!''.join(["\\x%02X" % ord(c) for c in v.query])}}");
            }
            google.setOnLoadCallback(initialize);
          </script>
%end
        </div>
        <div class="col-xs-4">

          <!-- History sidebar -->
          <div class="well">
            <h4>Search History</h4>
%if v.user is None:
            <p>Log in and we'll track your search history here.</p>
%else:
            <div id="history-list" class="list-group">
%for item in v.history:
              <a href="search?q={{!urllib.quote(item)}}" class="history-item list-group-item">{{item}}</a>
%end
            </div>
%end
          </div>

        </div>
      </div>

%rebase base title="Search Results", v=v
