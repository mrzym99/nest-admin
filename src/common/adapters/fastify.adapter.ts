import { FastifyAdapter } from '@nestjs/platform-fastify';
import { isDev, loadHttpOptions } from '~/utils';

export async function createFastifyApp(): Promise<FastifyAdapter> {
  const fastifyApp = new FastifyAdapter({
    // @see https://www.fastify.io/docs/latest/Reference/Server/#trustproxy
    trustProxy: true,
    logger: false,
    // https: await loadHttpOptions(isDev),
    // forceCloseConnections: true,
  });

  fastifyApp.getInstance().register(require('@fastify/multipart'), {
    limits: {
      fields: 10, // Max number of non-file fields
      fileSize: 1024 * 1024 * 6, // limit size 6M
      files: 5, // Max number of file fields
    },
  });

  fastifyApp.getInstance().register(require('@fastify/cookie'), {
    secret: 'cookie-secret', // 这个 secret 不太重要，不存鉴权相关，无关紧要
  });

  fastifyApp.getInstance().addHook('onRequest', (request, reply, done) => {
    // set undefined origin
    const { origin } = request.headers;
    if (!origin) request.headers.origin = request.headers.host;

    // forbidden php

    const { url } = request;

    if (url.endsWith('.php')) {
      reply.raw.statusMessage =
        'Eh. PHP is not support on this machine. Yep, I also think PHP is bestest programming language. But for me it is beyond my reach.';

      return reply.code(418).send();
    }

    // skip favicon request
    if (url.match(/favicon.ico$/) || url.match(/manifest.json$/))
      return reply.code(204).send();

    done();
  });

  return fastifyApp;
}
