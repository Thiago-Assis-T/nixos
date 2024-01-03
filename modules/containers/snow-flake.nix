{
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    hello-world = {
      image = "library/hello-world";
      autoStart = true;
      # image = "snowflake-proxy";
      # ports = [ ":" ];
    };
  };
}
