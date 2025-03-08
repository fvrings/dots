import GLib from "gi://GLib";
export const LOGO = Variable(GLib.get_os_info("LOGO")!);

export const MUSIC = Variable(false);
export let LIGHT = Variable(false);
export const DATE = Variable("", {
  poll: [1000, 'date "+%H:%M"'],
});
export const CPU = Variable("", {
  poll: [
    2000,
    () => {
      return Utils.execAsync(
        `sh -c "awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print (u-u1) * 100 / (t-t1); }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)"`,
      );
    },
  ],
});
export const MEM = Variable("", {
  poll: [
    2000,
    () => {
      return Utils.execAsync(
        `sh -c "free |grep 'Mem:'  |awk '{print $3*100/$2}'"`,
      );
    },
  ],
});
export const DOWN = Variable("", {
  poll: [
    2000,
    () => {
      return Utils.execAsync(
        `sh -c "ifstat -p |grep enp1s0 |awk '{print $6}'"`,
      );
    },
  ],
});
export const UP = Variable("", {
  poll: [
    2000,
    () => {
      return Utils.execAsync(
        `sh -c "ifstat -p |grep enp1s0 |awk '{print $8}'"`,
      );
    },
  ],
});
export const BTC = Variable("", {
  poll: [
    60000,
    () => {
      return Utils.execAsync(
        `nu -c "http get https://api.coindesk.com/v1/bpi/currentprice/usd.json  |get bpi.USD.rate_float"`,
      );
    },
  ],
});
