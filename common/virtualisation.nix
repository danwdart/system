{...}:
{
  docker.enable = true;
  docker.autoPrune.enable = true;

  libvirtd.enable = true;
  libvirtd.onBoot = "start";
  libvirtd.qemu.ovmf.enable = true;
  libvirtd.onShutdown = "suspend";

  # intel gen 5+
  kvmgt = {
    # get your own uuid
    enable = true;
    vgpus = {
      # low_gm_size: 128MB
      # high_gm_size: 512MB
      # fence: 4
      # resolution: 1920x1200
      # weight: 4
      "i915-GVTg_V5_4" = {
        uuid = [ "f3391b14-5221-11ed-ba3d-6b25560d08e7" ];
      };
      # low_gm_size: 64MB
      # high_gm_size: 384MB
      # fence: 4
      # resolution: 1024x768
      # weight: 2
      #"i915-GVTg_V5_8" = {
      #  uuid = [ "3ad9581c-5222-11ed-9cb3-371ac8d42518" ];
      #};
    };
  };
  
  # anbox.enable = true;

  # virtualbox.host.enable = true;
  
  # makes it recompile a lot
  # virtualbox.host.enableExtensionPack = true;

  # lxc.enable = true;
  # lxd.enable = true;
}