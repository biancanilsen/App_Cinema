import { Test, TestingModule } from '@nestjs/testing';
import TesteMovie from '../common/teste/teste-movie';
import { MovieController } from './movie.controller';
import { MovieService } from './movie.service';

describe('MovieController', () => {
  let controller: MovieController;
  let service: MovieService;

  const mockMoviesService = {
    findAll: jest.fn(),
    findOneOrFail: jest.fn(),
    findByName: jest.fn(),
    store: jest.fn(),
    update: jest.fn(),
    destroy: jest.fn(),
  }

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MovieController],
      providers: [MovieService]

    }).overrideProvider(MovieService).useValue(mockMoviesService).compile();

    controller = module.get<MovieController>(MovieController);
    service = module.get<MovieService>(MovieService);

  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('findAll', () => {
    it('should return an array of movie', async () => {
      const movie = TesteMovie.validMovie();
      const result = [movie, movie];
      jest.spyOn(service, 'findAll').mockImplementation(async () => await result);
      expect(await controller.index()).toBe(result);
    });
  });

  describe('find by id', () => {
    it('should return an hourly by id', async () => {
      const movie = TesteMovie.validMovie();
      const result = movie;
      jest.spyOn(service, 'findOneOrFail').mockImplementation(async () => await result);
      expect(await controller.show(movie.id)).toBe(result);
    });
  });


  describe(`create`, () => {
    it(`should create a movie`, () => {
      const movie = TesteMovie.validMovie();
      expect(controller.store(movie));
      expect(mockMoviesService.store).toBeCalled();
    });
  });

  describe(`update`, () => {
    it(`should update a movie`, () => {
      const movie = TesteMovie.validMovie();
      const movieUpdate = { name: 'filme novo', classification: 2, type: 1, duration: '01:30', room: 2, path: 'foto.png' }
      expect(controller.update(movie.id, movieUpdate));
      expect(mockMoviesService.update).toBeCalled();
    });
  });

  describe('delete hourly', () => {
    it('should return an hourly delete', async () => {
      const movie = TesteMovie.validMovie();
      const result = undefined;
      jest.spyOn(service, 'destroy').mockImplementation(async () => await result);
      expect(await controller.destroy(movie.id)).toBe(result);
    });
  });

});
