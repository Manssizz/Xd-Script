#!/bin/bash
echo ""
wget -q -O /tmp/ssr https://raw.githubusercontent.com/phreaker56/ChumoGH-Script/master/msg-bar/msg 
cat /tmp/ssr > /tmp/ssrrmu.sh
wget -q -O /tmp/ssr https://www.dropbox.com/s/u9npvg030pf7xvy/C-SSR.sh
cat /tmp/ssr >> /tmp/ssrrmu.sh
#curl  https://www.dropbox.com/s/re3lbbkxro23h4g/C-SSR.sh >> 
sed -i "s;VPS•MX;PHRK56-ADM;g" /tmp/ssrrmu.sh
sed -i "s;@Kalix1;Phreaker56;g" /tmp/ssrrmu.sh
sed -i "s;VPS-MX;phreaker56;g" /tmp/ssrrmu.sh
chmod +x /tmp/ssrrmu.sh && bash /tmp/ssrrmu.sh
#sed '/gnula.sh/ d' /tmp/ssrrmu.sh > /bin/ejecutar/crontab
