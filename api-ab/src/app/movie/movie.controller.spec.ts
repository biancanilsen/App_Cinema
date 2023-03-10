import { Test, TestingModule } from '@nestjs/testing';
import TesteMovie from '../common/teste/teste-movie';
import { MovieController } from './movie.controller';
import { MovieService } from './movie.service';

describe('MovieController', () => {
  let controller: MovieController;
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

  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
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



});
