import { Inject } from '@nestjs/common';
import * as path from 'node:path';
import { DatabaseConfig, IDatabaseConfig } from '~/config';
import { exec } from 'child_process';
import { existsSync, unlink, writeFile } from 'node:fs';
import { spawn } from 'node:child_process';
import { tmpdir } from 'node:os';
import { MysqlConnectionOptions } from 'typeorm/driver/mysql/MysqlConnectionOptions';

export class SqlService {
  constructor(
    @Inject(DatabaseConfig.KEY)
    private readonly databaseConfig: IDatabaseConfig,
  ) {}

  async export(): Promise<string> {
    const { host, port, username, password, database } = this
      .databaseConfig as MysqlConnectionOptions;
    const outputFile = path.join(__dirname, `../sql/${database}.sql`);
    const dumpCommand = `mysqldump -h ${host} -P ${port} -u ${username} -p${password} ${database} > ${outputFile}`;
    return new Promise((resolve, reject) => {
      exec(dumpCommand, (error, stdout, stderr) => {
        if (error) {
          reject(`导出失败: ${stderr}`);
        } else {
          if (existsSync(outputFile)) {
            resolve(outputFile);
          } else {
            reject(`导出失败: 文件未生成，请检查路径权限`);
          }
        }
      });
    });
  }

  async import(file: Buffer): Promise<string> {
    const { host, port, username, password, database } = this
      .databaseConfig as MysqlConnectionOptions;

    // 1. 创建临时配置文件
    const tempConfigPath = path.join(
      tmpdir(),
      `mysql-config-${Date.now()}.cnf`,
    );
    await writeFile(
      tempConfigPath,
      `[client]\nuser=${username}\npassword=${password}`,
      (err) => {
        if (err) {
          throw new Error(`创建临时配置文件失败: ${err}`);
        }
      },
    );

    // 2. 设置配置文件路径
    const mysql = spawn('mysql', [
      `--defaults-file=${tempConfigPath}`,
      `-h${host}`,
      `-P${port}`,
      database,
    ]);

    // 3. 写入 SQL 内容
    mysql.stdin.write(file);
    mysql.stdin.end();

    return new Promise((resolve, reject) => {
      mysql.on('close', async (code) => {
        // 删除临时配置文件
        await unlink(tempConfigPath, (err) => {});

        if (code !== 0) {
          reject(`导入失败，退出码: ${code}`);
        } else {
          resolve('导入成功');
        }
      });

      mysql.stderr.on('data', (data) => {
        reject(`导入失败: ${data.toString()}`);
      });
    });
  }
}
