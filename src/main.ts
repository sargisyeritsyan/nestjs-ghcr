import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';

(async () => {
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter({ logger: false }),
  );
  const HOST = process.env.HOST || '0.0.0.0';
  const PORT = process.env.PORT || 3000;

  await app
    .listen(PORT, HOST, () =>
      console.log(`🚀  Server is listening on :: ${HOST}:${PORT}`),
    )
    .catch((e) => {
      console.error(`❌  Error starting server, ${e}`);
      throw e;
    });
})();
