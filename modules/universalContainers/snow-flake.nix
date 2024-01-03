{
  virtualisation.oci-containers.containers = {
    snowflake-proxy = {
      image = "docker.io/thetorproject/snowflake-proxy:latest";
      autoStart = true;
      cmd = [ "-ephemeral-ports-range" "30000:60000" ];
    };
  };
}
