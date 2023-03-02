import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { HourlyController } from './hourly.controller';
import { HourlyEntity } from './hourly.entity';
import { HourlyService } from './hourly.service';

@Module({
  imports: [TypeOrmModule.forFeature([HourlyEntity])],
  controllers: [HourlyController],
  providers: [HourlyService]
})
export class HourlyModule { }
