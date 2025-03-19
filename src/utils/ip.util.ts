import axios from 'axios';

function isLAN(ip: string): boolean {
  if (ip === '127.0.0.1' || ip === '::1' || ip === 'localhost' || '') {
    return true;
  }
  const ipNum = ip.split('.').map(Number);
  if (ipNum.length !== 4) {
    return false; // 非法的 IP 地址格式
  }
  return (
    ipNum[0] === 10 ||
    (ipNum[0] === 172 && ipNum[1] >= 16 && ipNum[1] <= 31) ||
    (ipNum[0] === 192 && ipNum[1] === 168)
  );
}

export function getIp(request: Request) {
  const req = request as any;
  let ip =
    request.headers['x-forwarded-for'] ||
    request.headers['X-Forwarded-For'] ||
    request.headers['x-real-ip'] ||
    request.headers['X-Real-IP'] ||
    req?.ip ||
    req?.connection?.remoteAddress ||
    req?.socket?.remoteAddress ||
    req?.connection?.socket?.remoteAddress ||
    '';

  if (ip && ip.split(',').length > 0) {
    ip = ip.split(',')[0];
  }

  return ip;
}

export async function getIpAddress(ip: string) {
  if (isLAN(ip)) {
    return '内网IP';
  }

  try {
    let { data } = await axios.get(
      `https://whois.pconline.com.cn/ipJson.jsp?ip=${ip}&json=true`,
      { responseType: 'arraybuffer' },
    );
    data = new TextDecoder('gbk').decode(data);
    data = JSON.parse(data);
    return data.addr.trim().split(' ').at(0);
  } catch (_error) {
    console.log(_error);
    return '第三方接口请求失败';
  }
}
