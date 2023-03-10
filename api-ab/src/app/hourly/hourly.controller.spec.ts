import { Test, TestingModule } from '@nestjs/testing';
import TesteHourly from '../common/teste/teste-hourly';
import TesteMovie from '../common/teste/teste-movie';
import { HourlyController } from './hourly.controller';
import { HourlyService } from './hourly.service';

describe('HourlyController', () => {
  let controller: HourlyController;
  const mockHourlyService = {
    findAll: jest.fn(),
    findOneOrFail: jest.fn(),
    findByName: jest.fn(),
    store: jest.fn(),
    update: jest.fn(),
    destroy: jest.fn(),
  }

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [HourlyController],
      providers: [HourlyService]
    }).overrideProvider(HourlyService).useValue(mockHourlyService).compile();

    controller = module.get<HourlyController>(HourlyController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe(`create`, () => {
    it(`should create a hourly`, () => {
      const hourly = TesteHourly.validHourly();
      expect(controller.store(hourly));
      expect(mockHourlyService.store).toBeCalled();
    });
  });

  describe(`update`, () => {
    it(`should update a movie`, () => {
      const hourly = TesteHourly.validHourly();
      const Movie = TesteMovie.validMovie();
      const hourlyUpdate = { timeDay: '13:30', date: new Date('2022/04/02'), Movie: Movie }
      expect(controller.update(hourly.id, hourlyUpdate));
      expect(mockHourlyService.update).toBeCalled();
    });
  });
});
