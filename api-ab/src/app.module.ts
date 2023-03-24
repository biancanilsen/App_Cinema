import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MovieModule } from './app/movie/movie.module';
import { HourlyModule } from './app/hourly/hourly.module';

@Module({
  imports: [ConfigModule.forRoot(),
  TypeOrmModule.forRoot({
    type: 'postgres',
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    database: process.env.DB_DATABASE,
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    synchronize: true,
    entities: [__dirname + '/**/*.entity{.js,.ts}'],
  }),
  MovieModule,
  HourlyModule,],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
