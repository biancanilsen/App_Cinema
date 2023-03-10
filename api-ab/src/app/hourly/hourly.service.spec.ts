import { Test, TestingModule } from '@nestjs/testing';
import { HourlyService } from './hourly.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { HourlyEntity } from './hourly.entity';
import TesteHourly from '../common/teste/teste-hourly';
import { NotFoundException } from '@nestjs/common';
import TesteMovie from '../common/teste/teste-movie';


describe('HourlyService', () => {
  let service: HourlyService;
  const mockRepository = {
    find: jest.fn(),
    findOne: jest.fn(),
    query: jest.fn(),
    create: jest.fn(),
    save: jest.fn(),
    softDelete: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [HourlyService, {
        provide: getRepositoryToken(HourlyEntity),
        useValue: mockRepository,
      }],
    }).compile();

    service = module.get<HourlyService>(HourlyService);
  });

  beforeEach(() => {
    mockRepository.find.mockReset();
    mockRepository.findOne.mockReset();
    mockRepository.query.mockReset();
    mockRepository.create.mockReset();
    mockRepository.save.mockReset();
    mockRepository.softDelete.mockReset();
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('findAll', () => {
    it('should be list all hourlys', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.find.mockReturnValue([hourly, hourly]);
      const hourlys = await service.findAll();
      expect(hourlys).toHaveLength(2);
      expect(mockRepository.find).toHaveBeenCalledTimes(1);
    });
    it('should return a exception when does not to find a hourlys', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.find.mockReturnValue(null);
      await service.findAll().catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
        expect(mockRepository.find).toHaveBeenCalledTimes(1);
      });
    });
  });

  describe('findOneOrFail', () => {
    it('should find a existing hourly', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.findOne.mockReturnValue(hourly);
      const hourlyFound = await service.findOneOrFail('0fc7cfa7-9749-4ffb-b7ce-21b9731e2ff3');
      expect(hourlyFound).toMatchObject({ timeDay: hourly.timeDay });
      expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
    });
    it('should return a exception when does not to find a hourly', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.findOne.mockReturnValue(null);
      await service.findOneOrFail(hourly.id).catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
        expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      });
    });
  });

  describe('findByMovie', () => {
    it('should find a hourly by movie', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.query.mockReturnValue(hourly);
      const hourlyFound = await service.findByMovie('valid@gmail.com');
      expect(hourlyFound).toMatchObject({ Movie: hourlyFound.Movie });
      expect(mockRepository.query).toHaveBeenCalledTimes(1);
    });
    it('should return a exception when does not to find by hourly by as hourly', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.findOne.mockReturnValue(null);
      await service.findOneOrFail(hourly.id).catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
        expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      });
    });
  });

  describe('create', () => {
    it('should create hourly', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.create.mockReturnValue(hourly);
      mockRepository.save.mockReturnValue(hourly);
      const hourlySave = await service.store(hourly);
      expect(hourlySave).toMatchObject(hourly);
      expect(mockRepository.create).toHaveBeenCalledTimes(1);
      expect(mockRepository.save).toHaveBeenCalledTimes(1);
    });

    it('should return a exception when does not to create a hourly', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.create.mockReturnValue(null);
      mockRepository.save.mockReturnValue(null);
      await service.store(hourly).catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
        expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      });
      expect(mockRepository.create).toHaveBeenCalledTimes(1);
      expect(mockRepository.save).toHaveBeenCalledTimes(1);
    });
  });

  describe('update', () => {
    it('should update a hourly', async () => {
      const hourly = TesteHourly.validHourly();
      const Movie = TesteMovie.validMovie();
      const hourlyUpdate = { timeDay: '13:30', date: new Date('2022/04/02'), Movie: Movie }
      mockRepository.findOne.mockReturnValue(hourly);
      mockRepository.save.mockReturnValue({
        id: hourly.id,
        ...hourlyUpdate
      });
      const hourlyResult = await service.update(hourly.id, hourlyUpdate)
      expect(hourlyResult).toMatchObject(hourlyUpdate);
      expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      expect(mockRepository.save).toHaveBeenCalledTimes(1);

    });

    it('should return a exception when does not to update a hourly', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.findOne.mockReturnValue(null);
      mockRepository.save.mockReturnValue(null);
      await service.update(hourly.id, hourly).catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
      });
      expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      expect(mockRepository.save).toHaveBeenCalledTimes(1);
    });
  });

  describe('delete', () => {
    it('should delete a hourly', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.findOne.mockReturnValue(hourly);
      mockRepository.softDelete.mockReturnValue(hourly.id);
      const hourlyDelete = await service.destroy(hourly.id);
      expect(hourlyDelete).toBe(true);
      expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      expect(mockRepository.softDelete).toHaveBeenCalledTimes(1);
    });

    it('should return a exception when does not to delete a hourly', async () => {
      const hourly = TesteHourly.validHourly();
      mockRepository.findOne.mockReturnValue(null);
      mockRepository.softDelete.mockReturnValue(null);
      await service.destroy(hourly.id).catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
        expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      });
      const hourlyDelete = await service.destroy(hourly.id);
      expect(hourlyDelete).toBe(false);
      expect(mockRepository.softDelete).toHaveBeenCalledTimes(2);
    });
  });

});
