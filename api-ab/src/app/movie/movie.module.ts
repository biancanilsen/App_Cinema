import { Module } from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';
import { TypeOrmModule } from '@nestjs/typeorm';
import { HttpExceptionFilter } from '../common/exception/filter';
import { MovieController } from './movie.controller';
import { MovieEntity } from './movie.entity';
import { MovieService } from './movie.service';

@Module({
  imports: [TypeOrmModule.forFeature([MovieEntity])],
  controllers: [MovieController],
  providers: [MovieService, {
    provide: APP_FILTER,
    useClass: HttpExceptionFilter,
  },]
})
export class MovieModule { }
