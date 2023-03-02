import { Test, TestingModule } from '@nestjs/testing';
import { HourlyService } from './hourly.service';

describe('HourlyService', () => {
  let service: HourlyService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [HourlyService],
    }).compile();

    service = module.get<HourlyService>(HourlyService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
