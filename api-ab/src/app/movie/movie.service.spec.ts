import { NotFoundException } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import TesteMovie from '../common/teste/teste-movie';
import { MovieEntity } from './movie.entity';
import { MovieService } from './movie.service';

describe('MovieService', () => {
  let service: MovieService;
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
      providers: [MovieService, {
        provide: getRepositoryToken(MovieEntity),
        useValue: mockRepository,
      }],
    }).compile();

    service = module.get<MovieService>(MovieService);
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
    it('should be list all movies', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.find.mockReturnValue([movie, movie]);
      const movies = await service.findAll();
      expect(movies).toHaveLength(2);
      expect(mockRepository.find).toHaveBeenCalledTimes(1);
    });
    it('should return a exception when does not to find a movies', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.find.mockReturnValue(null);
      await service.findAll().catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
        expect(mockRepository.find).toHaveBeenCalledTimes(1);
      });
    });
  });

  describe('findOneOrFail', () => {
    it('should find a existing movie', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.findOne.mockReturnValue(movie);
      const movieFound = await service.findOneOrFail('0fc7cfa7-9749-4ffb-b7ce-21b9731e2ff3');
      expect(movieFound).toMatchObject({ name: movie.name });
      expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
    });

    it('should return a exception when does not to find a movie', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.findOne.mockReturnValue(null);
      await service.findOneOrFail(movie.id).catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
        expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      });
    });
  });

  describe('findByName', () => {
    it('should find a movie by name', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.query.mockReturnValue(movie);
      const movieFound = await service.findByName('valid@gmail.com');
      expect(movieFound).toMatchObject({ name: movie.name });
      expect(mockRepository.query).toHaveBeenCalledTimes(1);
    });

    it('should return a exception when does not to find by name by a movie', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.findOne.mockReturnValue(null);
      await service.findOneOrFail(movie.id).catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
        expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      });
    });
  });

  describe('create', () => {
    it('should create movie', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.create.mockReturnValue(movie);
      mockRepository.save.mockReturnValue(movie);
      const movieSave = await service.store(movie);
      expect(movieSave).toMatchObject(movie);
      expect(mockRepository.create).toHaveBeenCalledTimes(1);
      expect(mockRepository.save).toHaveBeenCalledTimes(1);
    });

    it('should return a exception when does not to create a movie', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.create.mockReturnValue(null);
      mockRepository.save.mockReturnValue(null);
      await service.store(movie).catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
        expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      });
      expect(mockRepository.create).toHaveBeenCalledTimes(1);
      expect(mockRepository.save).toHaveBeenCalledTimes(1);
    });
  });

  describe('update', () => {
    it('should update a movie', async () => {
      const movie = TesteMovie.validMovie();
      const movieUpdate = { name: 'filme novo', classification: 2, type: 1, duration: '01:30', room: 2, path: 'foto.png' }
      mockRepository.findOne.mockReturnValue(movie);
      mockRepository.save.mockReturnValue({
        id: movie.id,
        ...movieUpdate
      });
      const movieResult = await service.update(movie.id, movieUpdate)
      expect(movieResult).toMatchObject(movieUpdate);
      expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      expect(mockRepository.save).toHaveBeenCalledTimes(1);

    });

    it('should return a exception when does not to update a movie', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.findOne.mockReturnValue(null);
      mockRepository.save.mockReturnValue(null);
      await service.update(movie.id, movie).catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
      });
      expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      expect(mockRepository.save).toHaveBeenCalledTimes(1);
    });
  });

  describe('delete', () => {
    it('should delete a movie', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.findOne.mockReturnValue(movie);
      mockRepository.softDelete.mockReturnValue(movie.id);
      const movieDelete = await service.destroy(movie.id);
      expect(movieDelete).toBe(true);
      expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      expect(mockRepository.softDelete).toHaveBeenCalledTimes(1);
    });

    it('should return a exception when does not to delete a movie', async () => {
      const movie = TesteMovie.validMovie();
      mockRepository.findOne.mockReturnValue(null);
      mockRepository.softDelete.mockReturnValue(null);
      await service.destroy(movie.id).catch(e => {
        expect(e).toBeInstanceOf(NotFoundException);
        expect(e).toMatchObject(e.message);
        expect(mockRepository.findOne).toHaveBeenCalledTimes(1);
      });
      const movieDelete = await service.destroy(movie.id);
      expect(movieDelete).toBe(false);
      expect(mockRepository.softDelete).toHaveBeenCalledTimes(2);
    });
  });

});
