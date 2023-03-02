import { Test, TestingModule } from '@nestjs/testing';
import { HourlyController } from './hourly.controller';

describe('HourlyController', () => {
  let controller: HourlyController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [HourlyController],
    }).compile();

    controller = module.get<HourlyController>(HourlyController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
