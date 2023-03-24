import { Module } from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';
import { TypeOrmModule } from '@nestjs/typeorm';
import { HttpExceptionFilter } from '../common/exception/filter';
import { HourlyController } from './hourly.controller';
import { HourlyEntity } from './hourly.entity';
import { HourlyService } from './hourly.service';

@Module({
  imports: [TypeOrmModule.forFeature([HourlyEntity])],
  controllers: [HourlyController],
  providers: [HourlyService, {
    provide: APP_FILTER,
    useClass: HttpExceptionFilter,
  }]
})
export class HourlyModule { }
