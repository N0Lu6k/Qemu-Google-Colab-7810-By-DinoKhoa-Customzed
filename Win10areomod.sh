wget -O bios64.bin "https://github.com/BlankOn/ovmf-blobs/raw/master/bios64.bin"
wget -O win.iso "https://go.microsoft.com/fwlink/p/?LinkID=2195404&clcid=0x409&culture=en-us&country=US"
wget -O ngrok.tgz "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz"
tar -xf ngrok.tgz
./ngrok authtoken 2fAbst1jCEmTCQSw54p85GlSsPw_22uSS7tDPAd6T1SoPpwSN
sudo apt update
sudo apt install qemu-kvm -y
qemu-img create -f raw win.img 32G
sudo qemu-system-x86_64 -m 12G -smp 4 -cpu host -boot order=c -drive file=win.iso,media=cdrom -drive file=win.img,format=raw -device usb-ehci,id=usb,bus=pci.0,addr=0x4 -device usb-tablet -vnc :0 -smp cores=4 -device e1000,netdev=n0 -netdev user,id=n0 -vga qxl -accel kvm -bios bios64.bin
