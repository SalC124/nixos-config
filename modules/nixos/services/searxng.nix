{ pkgs, ... }:
{
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    redisCreateLocally = true;

    environmentFile = "/etc/searxng/env";

    settings = {
      server = {
        port = 8888;
        bind_address = "127.0.0.1";
      };
      engines = [
        {
          name = "bing";
          disabled = false;
        }
        {
          name = "google";
          disabled = false;
        }
        {
          name = "duckduckgo";
          disabled = false;
        }
        {
          name = "wikidata";
          disabled = false;
        }
      ];

      ui = {
        default_theme = "simple";
        center_alignment = true;
      };

      search.safe_search = 2;
    };
  };
}
