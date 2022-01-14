{...}:
{
  docker.enable = true;
  docker.autoPrune.enable = true;

  libvirtd.enable = true;
  libvirtd.onBoot = "start";
  libvirtd.qemuOvmf = true;
  libvirtd.onShutdown = "suspend";
  # anbox.enable = true;

  # virtualbox.host.enable = true;
  
  # makes it recompile a lot
  # virtualbox.host.enableExtensionPack = true;

  # lxc.enable = true;
  # lxd.enable = true;
}