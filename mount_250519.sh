IP_ADDR=172.16.10.10
sudo mount -t cifs //$IP_ADDR/2024-Photo   ./PlenopticServer1 -o user=plenoptic,pass=Vmffpsdhqxlr!2,rw,vers=2.0
sudo mount -t cifs //$IP_ADDR/DATA-VII   ./PlenopticServer2 -o user=plenoptic,pass=Vmffpsdhqxlr!2,rw,vers=2.0

