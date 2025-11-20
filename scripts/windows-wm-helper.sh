# Windows VM Helper Script for Framework Laptop 16

VM_NAME="windows-gaming"

case "$1" in
    start)
        echo "Starting Windows VM..."
        virsh start "$VM_NAME"
        ;;
    stop)
        echo "Shutting down Windows VM..."
        virsh shutdown "$VM_NAME"
        ;;
    force-stop)
        echo "Force stopping Windows VM..."
        virsh destroy "$VM_NAME"
        ;;
    looking-glass)
        echo "Starting Looking Glass client..."
        looking-glass-client -F -m KEY_SCROLLLOCK
        ;;
    status)
        virsh list --all | grep "$VM_NAME"
        ;;
    console)
        virt-manager --connect qemu:///system --show-domain-console "$VM_NAME"
        ;;
    *)
        echo "Windows VM Helper"
        echo "Usage: $0 {start|stop|force-stop|looking-glass|status|console}"
        echo ""
        echo "Commands:"
        echo "  start         - Start the VM"
        echo "  stop          - Gracefully shutdown the VM"
        echo "  force-stop    - Force stop the VM"
        echo "  looking-glass - Launch Looking Glass client"
        echo "  status        - Check VM status"
        echo "  console       - Open virt-manager console"
        exit 1
        ;;
esac
