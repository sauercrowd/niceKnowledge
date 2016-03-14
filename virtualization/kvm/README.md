# kvm



Definition
=========
[Quelle](http://serverfault.com/questions/208693/difference-between-kvm-and-qemu)

**Qemu:**

QEmu is a complete and standalone software of its own. You use it to emulate machines, it is very flexible and portable. Mainly it works by a special 'recompiler' that transforms binary code written for a given processor into another one (say, to run MIPS code on a PPC mac, or ARM in an x86 PC).

To emulate more than just the processor, Qemu includes a long list of peripheral emulators: disk, network, VGA, PCI, USB, serial/parallel ports, etc.


**KVM:**

KVM is a couple of things: first it is a Linux kernel module—now included in mainline—that switches the processor into a new 'guest' state. The guest state has its own set of ring states, but privileged ring0 instructions fall back to the hypervisor code. Since it is a new processor mode of execution, the code doesn't have to be modified in any way.

Apart from the processor state switching, the kernel module also handles a few low-level parts of the emulation like the MMU registers (used to handle VM) and some parts of the PCI emulated hardware.

Second, KVM is a fork of the Qemu executable. Both teams work actively to keep differences at a minimum, and there are advances in reducing it. Eventually, the goal is that Qemu should work anywhere, and if a KVM kernel module is available, it could be automatically used. But for the foreseeable future, the Qemu team focuses on hardware emulation and portability, while KVM folks focus on the kernel module (sometimes moving small parts of the emulation there, if it improves performance), and interfacing with the rest of the userspace code.

The kvm-qemu executable works like normal Qemu: allocates RAM, loads the code, and instead of recompiling it, or calling KQemu, it spawns a thread (this is important). The thread calls the KVM kernel module to switch to guest mode and proceeds to execute the VM code. On a privileged instruction, it switches back to the KVM kernel module, which, if necessary, signals the Qemu thread to handle most of the hardware emulation.

One of the nice things of this architecture is that the guest code is emulated in a posix thread which you can manage with normal Linux tools. If you want a VM with 2 or 4 cores, kvm-qemu creates 2 or 4 threads, each of them calls the KVM kernel module to start executing. The concurrency—if you have enough real cores—or scheduling—if not—is managed by the normal Linux scheduler, keeping code small and surprises limited.

**KQemu:**

In the specific case where both source and target are the same architecture (like the common case of x86 on x86), it still has to parse the code to remove any 'privileged instructions' and replace them with context switches. To make it as efficient as possible on x86 Linux, there's a kernel module called KQemu that handles this.

Being a kernel module, KQemu is able to execute most code unchanged, replacing only the lowest-level ring0-only instructions. In that case, userspace Qemu still allocates all the RAM for the emulated machine, and loads the code. The difference is that instead of recompiling the code, it calls KQemu to scan/patch/execute it. All the peripheral hardware emulation is done in Qemu.

This is a lot faster than plain Qemu because most code is unchanged, but still has to transform ring0 code (most of the code in the VM's kernel), so performance still suffers.



Helpful links to get Windows Guest OS on Ubuntu
=================================
* [VM](http://serverfault.com/questions/703675/install-windows-2012-r2-over-kvm-virtualizaton)
* [Settings](https://me.m01.eu/blog/2015/03/windows-10-kvm-and-iscsi/)
* [virtio Driver](https://launchpad.net/kvm-guest-drivers-windows/+download)
