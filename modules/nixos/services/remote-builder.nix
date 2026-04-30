{ ... }:
{
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "192.168.1.54";
      system = "x86_64-linux";
      maxJobs = 2;
      speedFactor = 2;
      supportedFeatures = [
        "nix-command"
        "flakes"
        "big-parallel"
      ];
    }
  ];
}
