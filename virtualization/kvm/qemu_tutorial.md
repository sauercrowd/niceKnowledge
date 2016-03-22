# Qemu Tutorial
## Hard Disk
1. Create a Hard disk

      ```qemu-img create -f qcow2 MyHardDisk.qcow2 20G```
    
2. Resize a Hard Disk

      ```qemu-img resize MyHardDisk.qcow2 +10G```

## Run 
    kvm -hda MyHardDisk.qcow2
### Options
  - Use A cdrom
  
    -cdrom os.iso
    
  - Define RAM
  
    -m 4096
    
  - Start it in nographic mode
  
    -nographic
    
  - redirect ports
  
    -redir :8080::80
