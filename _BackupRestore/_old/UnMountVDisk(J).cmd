SetLocal EnableExtensions EnableDelayedExpansion
cd /d C:\Windows\system32
(
  echo diskpart
  echo timeout 2
  echo select vdisk file="I:\file.vhd"
  echo detach vdisk
  echo timeout 1
) | diskpart
exit