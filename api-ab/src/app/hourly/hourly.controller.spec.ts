import { Test, TestingModule } from '@nestjs/testing';
import TesteHourly from '../common/teste/teste-hourly';
import TesteMovie from '../common/teste/teste-movie';
import { HourlyController } from './hourly.controller';
import { HourlyService } from './hourly.service';

describe('HourlyController', () => {
  let controller: HourlyController;
  let service: HourlyService;

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
    service = module.get<HourlyService>(HourlyService);

  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('findAll', () => {
    it('should return an array of hourly', async () => {
      const hourly = TesteHourly.validHourly();
      const result = [hourly, hourly];
      jest.spyOn(service, 'findAll').mockImplementation(async () => await result);
      expect(await controller.index()).toBe(result);
    });
  });

  describe('find by id', () => {
    it('should return an hourly by id', async () => {
      const hourly = TesteHourly.validHourly();
      const result = hourly;
      jest.spyOn(service, 'findOneOrFail').mockImplementation(async () => await result);
      expect(await controller.show(hourly.id)).toBe(result);
    });
  });

  // Dificuldade em fazer a busca pelo id do movie
  // describe('find by movie id', () => {
  //   it('should return an hourly by movie id', async () => {
  //     const hourly = TesteHourly.validHourly();
  //     // const result = await service.findByMovie.mockReturnValue(hourly.Movie.id);
  //     const result = hourly;
  //     jest.spyOn(service, 'findByMovie').mockImplementation(async () => await result);
  //     expect(await controller.findByCollaborator(hourly.Movie.id)).toBe(result);
  //   });
  // });

  describe(`create`, () => {
    it(`should create a hourly`, () => {
      const hourly = TesteHourly.validHourly();
      expect(controller.store(hourly));
      expect(mockHourlyService.store).toBeCalled();
    });
  });

  describe(`update`, () => {
    it(`should update a hourly`, () => {
      const hourly = TesteHourly.validHourly();
      const Movie = TesteMovie.validMovie();
      const hourlyUpdate = { timeDay: '13:30', date: new Date('2022/04/02'), Movie: Movie }
      expect(controller.update(hourly.id, hourlyUpdate));
      expect(mockHourlyService.update).toBeCalled();
    });
  });

  describe('delete hourly', () => {
    it('should return an hourly delete', async () => {
      const hourly = TesteHourly.validHourly();
      const result = undefined;
      jest.spyOn(service, 'destroy').mockImplementation(async () => await result);
      expect(await controller.destroy(hourly.id)).toBe(result);
    });
  });
});
