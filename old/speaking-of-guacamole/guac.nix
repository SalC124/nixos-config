{ pkgs
, inputs
, ...
}:
{
  environment.systemPackages = with pkgs; [
    wayvnc
  ];
  services.guacamole-server = {
    enable = false;
    host = "127.0.0.1";
  };

  services.guacamole-client = {
    enable = false;
    userMappingXml = ./user-mapping.xml;
    enableWebserver = true;
    settings = {
      guacd-port = 4822;
      guacd-hostname = "127.0.0.1";
    };
  };
}
