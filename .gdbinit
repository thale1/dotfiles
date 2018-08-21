set print pretty
set pagination off
# pretty binary dumps
define xxd
  if $argc != 2
    help xxd
    else
      set pagination off
      dump binary memory /tmp/gdbdump.bin $arg0 $arg0+$arg1
      shell xxd /tmp/gdbdump.bin
      shell rm -f /tmp/gdbdump.bin
      set pagination on
      end
end

#source ~/.gdb-dashboard
