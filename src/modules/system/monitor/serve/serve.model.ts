import { ApiProperty } from '@nestjs/swagger';

export class Runtime {
  @ApiProperty({ description: '系统', type: String })
  os?: string;

  @ApiProperty({ description: '服务器架构', type: String })
  arch?: string;

  @ApiProperty({ description: 'node 版本', type: String })
  nodeVersion?: string;

  @ApiProperty({ description: 'npm 版本', type: String })
  npmVersion?: string;
}

export class CoreLoad {
  @ApiProperty({ description: '当前cpu资源消耗', type: Number })
  rawLoad?: number;

  @ApiProperty({ description: '当前空闲cpu资源', type: Number })
  rawLoadIdle?: number;
}

export class Cpu {
  @ApiProperty({ description: '制造商' })
  manufacturer?: string;

  @ApiProperty({ description: '品牌' })
  brand?: string;

  @ApiProperty({ description: '物理核心数' })
  physicalCores?: number;

  @ApiProperty({ description: '型号' })
  model?: string;

  @ApiProperty({ description: '速度 in GHz' })
  speed?: number;

  @ApiProperty({ description: 'CPU资源消耗 原始滴答' })
  rawCurrentLoad?: number;

  @ApiProperty({ description: '空闲CPU资源 原始滴答' })
  rawCurrentLoadIdle?: number;

  @ApiProperty({ description: 'cpu资源消耗', type: [CoreLoad] })
  coresLoad?: CoreLoad[];
}

export class Disk {
  @ApiProperty({ description: '磁盘空间大小 (bytes)' })
  size?: number;

  @ApiProperty({ description: '已使用磁盘空间 (bytes)' })
  used?: number;

  @ApiProperty({ description: '可用磁盘空间 (bytes)' })
  available?: number;
}

export class Memory {
  @ApiProperty({ description: 'total memory in bytes' })
  total?: number;

  @ApiProperty({ description: '被使用的' })
  active?: number;

  @ApiProperty({ description: '可用内存' })
  available?: number;
}

export class ServeStatInfo {
  @ApiProperty({ description: '运行时环境', type: Runtime })
  runtime?: Runtime;

  @ApiProperty({ description: 'CPU信息', type: Cpu })
  cpu?: Cpu;

  @ApiProperty({ description: '磁盘信息', type: Disk })
  disk?: Disk;

  @ApiProperty({ description: '内存信息', type: Memory })
  memory?: Memory;
}
