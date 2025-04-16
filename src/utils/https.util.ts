import { HttpsOptions } from '@nestjs/common/interfaces/external/https-options.interface';
import * as fs from 'node:fs';
import * as path from 'node:path';

export async function loadHttpOptions(isDev): Promise<HttpsOptions> {
  if (isDev) {
    return null;
  }

  const key = await fs.readFileSync(
    path.join(__dirname, '..', 'https', 'private-key.pem'),
  );
  const cert = await fs.readFileSync(
    path.join(__dirname, '..', 'https', 'public-certificate.pem'),
  );

  if (!key.length || !cert.length) {
    console.error('https key or cert not found');
  }

  return {
    key,
    cert,
  };
}
