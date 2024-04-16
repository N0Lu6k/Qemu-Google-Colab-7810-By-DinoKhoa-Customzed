sudo apt-get update && apt-get install qemu -y
sudo apt install qemu-utils -y
sudo apt install qemu-system-x86-xen -y
sudo apt install qemu-system-x86 -y
qemu-img create -f raw win.img 32G
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.248-1/virtio-win.iso'
wget -O win.iso 'https://software.download.prss.microsoft.com/dbazure/Win10_22H2_English_x64v1.iso?t=212b1f9d-6ed4-417f-acc0-1dc17d7fc497&P1=1713347798&P2=601&P3=2&P4=vq9Y68iolBWe3Qxh%2bL16ZW%2b7RhiubhW9pJEXhgcUXZQxNv7K%2fPtVioZYP6yieXWsz%2frHvq0KzBjfgfGFsQlIxzjsYuKJZwOLT64lnZgcFMEBjekD1KzOSizy%2buoOP45iojgluUE4QcU%2f%2fza0eM8T155sJ%2buUAl%2fwcaODwKzlo91wZxW3QaJHDeCLlnvYHxszH%2bV8PFHctPmLOP7WG7I74Y%2b15L59beI9GvM9OfJPnTUNa5MOfAhBLgBHocPcKC6EPMa6lTsSs9oZpoOZTadjt1RwQpv2cpXRG2Ps%2b7CDc8EtC9G%2fgKo0c4JeJ4%2bNH60bNa9Z%2f1HKEaA2w0lFWB5uqg%3d%3d'
clear
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sudo qemu-system-x86_64 \
  -m 8G \
  -cpu EPYC \
  -boot order=d \
  -drive file=win.iso,media=cdrom \
  -drive file=win.img,format=raw,if=virtio \
  -drive file=virtio-win.iso,media=cdrom \
  -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
  -device usb-tablet \
  -vnc :0 \
  -smp cores=4 \
