import { Injectable } from '@nestjs/common';
import { Disk, ServeStatInfo } from './serve.model';
import * as si from 'systeminformation';

@Injectable()
export class ServeService {
  async stat(): Promise<ServeStatInfo> {
    const [nodeVersion, npmVersion, osInfo, cpu, currentLoad, mem] = (
      await Promise.allSettled([
        si.versions('node'),
        si.versions('npm'),
        si.osInfo(),
        si.cpu(),
        si.currentLoad(),
        si.mem(),
      ])
    ).map((r: any) => r.value);

    // 计算 磁盘信息
    const diskListInfo = await si.fsSize();

    const diskInfo = new Disk();
    diskInfo.size = 0;
    diskInfo.available = 0;
    diskInfo.used = 0;
    diskListInfo.forEach((disk) => {
      diskInfo.size += disk.size;
      diskInfo.available += disk.available;
      diskInfo.used += disk.used;
    });

    return {
      runtime: {
        nodeVersion: nodeVersion.node,
        npmVersion: npmVersion.npm,
        os: osInfo.platform,
        arch: osInfo.arch,
      },

      cpu: {
        manufacturer: cpu.manufacturer,
        brand: cpu.brand,
        physicalCores: cpu.physicalCores,
        model: cpu.model,
        speed: cpu.speed,
        rawCurrentLoad: currentLoad.currentLoad,
        rawCurrentLoadIdle: currentLoad.currentLoadIdle,
        coresLoad: currentLoad.cpus.map((e) => {
          return {
            rawLoad: e.rawLoad,
            rawLoadIdle: e.rawLoadIdle,
          };
        }),
      },
      disk: diskInfo,
      memory: {
        total: mem.total,
        active: mem.active,
        available: mem.available,
      },
    };
  }
}
